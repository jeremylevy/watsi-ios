//
//  PatientsListCollectionViewController.swift
//  Watsi
//
//  Created by Jeremy Levy on 02/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit
import SDWebImage

private let patientCollectionViewCellReuseIdentifier = "patientCollectionViewCell"
private let showPatientViewControllerSegueIdentifier = "showPatient"

enum PatientsListError: Error {
    case unknownError
    case noPatient
}

class PatientsListCollectionViewController: UICollectionViewController {
    
    // MARK: - Interface builder
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorView: UIView!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorRetryButton: UIButton!
    
    @IBAction func tryToReloadPatientsAfterError(_ sender: UIButton) {
        self.loadPatients(ofType: self.patientType, andShowLoadingView: true, nil)
    }
    
    // MARK: - Custom properties
    
    // equals to view width, set in viewDidLoad method
    private var cellWidth: CGFloat = 0.0
    private let cellHeight: CGFloat = 221.0
    
    private let cellVerticalMargin: CGFloat = 20.0
    private let cellHorizontalMargin: CGFloat = 20.0
    
    var patientType: PatientType = .STARTED
    var showPatientError: Error?
    
    private var patients:[Patient] = [Patient]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - View controller lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        
        self.configureErrorRetryButton()
        
        self.loadPatients(ofType: patientType, andShowLoadingView: true, nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.showPatientError != nil {
            let alert = UIAlertController(title: "Erreur", message: "Une erreur inconnue est survenue. Veuillez reessayer ultérieurement.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.view.tintColor = Color.blue()
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            self.showPatientError = nil
        }
    }
    
    // MARK: - Custom methods
    
    func configureCollectionView() {
        self.collectionView!.backgroundColor = Color.windowBgColor()
        self.cellWidth = self.view.bounds.width
        
        self.addRefreshControlToCollectionView()
    }
    
    func configureErrorRetryButton() {
        self.errorRetryButton.layer.borderWidth = 0.0;
        self.errorRetryButton.layer.cornerRadius = 4.0;
        
        self.errorRetryButton.layer.borderColor = UIColor.lightGray.cgColor;
        self.errorRetryButton.tintColor = UIColor.lightGray
        
        self.errorRetryButton.setTitleColor(UIColor.white, for: .normal)
        self.errorRetryButton.backgroundColor = UIColor(white: 0.8, alpha: 1.0)

    }
    
    func loadPatients(ofType type: PatientType, andShowLoadingView showLoadingView: Bool, _ callback: ((PatientsListError?) -> Void)?) {
        
        if showLoadingView {
            self.showLoadingView()
        }
        
        PatientsStore.patients(ofType: self.patientType, {(error, patients) -> Void in
            if error != nil {
                self.showErrorView(withError: .unknownError)
                
                if let cb = callback {
                    return cb(.unknownError)
                }
                
                return
            }
            
            if patients.count == 0 {
                self.showErrorView(withError: .noPatient)
                
                if let cb = callback {
                    return cb(.noPatient)
                }
                
                return
            }
            
            self.patients = patients
            
            if showLoadingView {
                self.hideLoadingView()
            }
            
            if let cb = callback {
                return cb(nil)
            }
        })
    }
    
    // MARK: Refresh control
    
    func addRefreshControlToCollectionView() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(PatientsListCollectionViewController.refreshInvoked(_:)), for: UIControlEvents.valueChanged)
        
        collectionView?.addSubview(refreshControl)
    }
    
    func refreshInvoked(_ sender:AnyObject) {
        sender.beginRefreshing()
        
        self.loadPatients(ofType: patientType, andShowLoadingView: false, { (err: PatientsListError?) in
            sender.endRefreshing()
        })
    }
    
    // MARK: Loading View
    
    func showLoadingView() {
        self.hideErrorView()
        
        self.loadingView.isHidden = false
    }
    
    func hideLoadingView() {
        self.loadingView.isHidden = true
    }
    
    // MARK: Error View
    
    func showErrorView(withError error: PatientsListError) {
        self.hideLoadingView()
        
        self.errorView.isHidden = false
        
        if error == .noPatient {
            self.errorLabel.text = "Aucun patient pour l'instant."
        } else {
            self.errorLabel.text = "Une erreur inconnue est survenue."
        }
    }
    
    func hideErrorView() {
        self.errorView.isHidden = true
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return patients.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: patientCollectionViewCellReuseIdentifier, for: indexPath) as! PatientCollectionViewCell
        
        let patient = patients[indexPath.row]
        
        cell.photo.sd_setImage(with: URL(string: patient.photoUrl))
        
        cell.descriptionLabel.text = patient.shortDesc
        
        cell.amountRaisedLabel.text = String(format: "%.0f$", patient.amountRaised)
        cell.amountRemainingLabel.text = String(format: "%.0f$", patient.amountRemaining)
        
        cell.percentFundedLabel.text = String(format: "%.0f%%", patient.percentFunded * 100)
        cell.percentFundedProgress.progress = patient.percentFunded
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cellWidth - self.cellHorizontalMargin, height: self.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return self.cellVerticalMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showPatientViewControllerSegueIdentifier {
            if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                let patient = patients[indexPath.row]
                let patientProfilVC = segue.destination as! PatientProfilTableViewController
                
                patientProfilVC.patient = patient
                patientProfilVC.patientsListVC = self
            }
        }
    }
}
