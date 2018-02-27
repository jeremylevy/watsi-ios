//
//  PatientProfilTableViewController.swift
//  Watsi
//
//  Created by Jeremy Levy on 04/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit
import SDWebImage
import LTNavigationBar
import RandomColorSwift

private let patientDonorCollectionViewCellReuseIdentifier = "patientDonorCollectionViewCell"

private let showDonorViewControllerSegueIdentifier = "showDonor"
private let showDonateViewControllerSegueIdentifier = "donate"

class PatientProfilTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Interface builder
    
    @IBOutlet weak var percentFundedProgress: UIProgressView!
    @IBOutlet weak var amountRaisedLabel: UILabel!
    
    @IBOutlet weak var amountRemainingLabel: UILabel!
    @IBOutlet weak var patientHistoryTextView: UITextView!
    
    @IBOutlet weak var patientHistoryReadMoreButton: UIButton!
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var patientHistoryTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var donorsCollectionView: UICollectionView!
    
    @IBOutlet weak var donateAmountLabel: UILabel!
    
    @IBAction func readMorePatientHistory(_ readMoreButton: UIButton) {
        self.patientHistoryTextView.text = patient.longDesc
        
        let contentSize = self.patientHistoryTextView.intrinsicContentSize
        
        self.patientHistoryTextViewCellHeight = contentSize.height
            + self.patientHistoryTextViewCellMarginBottom
        
        self.patientHistoryTextViewHeightConstraint.constant = contentSize.height
        
        readMoreButton.removeFromSuperview()
        
        self.patientHistoryTextView.updateConstraintsIfNeeded()
        
        self.tableView.reloadData()
    }
    
    // MARK: - Custom properties
    
    private var photo: UIImageView!
    private var photoBlackOverlay: UIView!
    
    private let photoHeight: CGFloat = 226.0
    private let tableHeaderViewHeight: CGFloat = 277.0
    
    private var patientHistoryTextViewCellHeight: CGFloat = 244.0
    private let patientHistoryTextViewCellMarginBottom: CGFloat = 14.0
    
    private var cachedPhotoSize: CGRect!
    private var cachedPhotoBlackOverlaySize: CGRect!
    
    var patient: Patient!
    weak var patientsListVC: PatientsListCollectionViewController!
    
    // MARK: - View controller lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We want table view under transparent nav bar
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView!.backgroundColor = Color.windowBgColor()
        
        self.configureTableViewHeaderView()
        self.configurePatientHistoryReadMoreButton()
        
        self.loadFullPatient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBar()
    }
    
    // MARK: - Custom methods
    
    func loadFullPatient() {
        self.showNavigationBarLoader()
        
        PatientsStore.patient(withId: self.patient.id, {(error, patient) -> Void in
            if error != nil {
                self.patientsListVC.showPatientError = error
                
                self.navigationController?.popViewController(animated: true)
                
                return
            }
            
            self.patient = patient!
            
            self.populatePlaceholderWithPatientValues()
        })
    }
    
    func populatePlaceholderWithPatientValues() {
        self.navigationItem.title = patient.firstName
        self.hideNavigationBarLoader()
        
        self.donateButton.isEnabled = true
        
        self.donorsCollectionView.isHidden = false
        self.donorsCollectionView.reloadData()
        
        self.partnerLabel.isHidden = false
        self.partnerLabel.text = patient.partnerName
        
        self.configurePatientHistoryTextView()
    }
    
    // MARK: Navigation bar
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        // Reset background color opacity depending on scroll
        self.scrollViewDidScroll(self.tableView)
    }
    
    func showNavigationBarLoader() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
        let barButton = UIBarButtonItem(customView: activityIndicator)
        
        self.navigationItem.rightBarButtonItem = barButton
        
        activityIndicator.startAnimating()
    }
    
    func hideNavigationBarLoader() {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    // MARK: Table view header view
    
    func configureTableViewHeaderView() {
        self.configureImageHeader()
        
        self.amountRaisedLabel.text = String(format: "%.0f$", patient.amountRaised)
        self.amountRemainingLabel.text = String(format: "%.0f$", patient.amountRemaining)
        
        self.percentFundedProgress.progress = patient.percentFunded
        
        // Wait until patient is loaded
        self.donateButton.isEnabled = false
    }
    
    func configureImageHeader() {
        let photoFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.photoHeight)
        
        self.photo = UIImageView(frame: photoFrame)
        self.photo.sd_setImage(with: URL(string: patient.photoUrl))
        
        self.photoBlackOverlay = UIView(frame: photoFrame)
        self.photoBlackOverlay.backgroundColor = UIColor.black
        self.photoBlackOverlay.alpha = 0.4
        
        self.photo.addSubview(photoBlackOverlay)
        
        self.photo.contentMode = .scaleAspectFill
        
        self.cachedPhotoSize = self.photo.frame
        self.cachedPhotoBlackOverlaySize = self.photoBlackOverlay.frame
        
        self.tableView.addSubview(self.photo)
        self.tableView.sendSubview(toBack: self.photo)
        
        self.tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tableHeaderViewHeight)
    }
    
    public func showDonateAmountLabel(withAmount amount: Int) {
        self.donateButton.isHidden = true
        self.donateAmountLabel.isHidden = false
        self.donateAmountLabel.text = "Vous avez fait un don de \(amount)$."
    }
    
    // MARK: Patient history text view
    
    func configurePatientHistoryTextView() {
        // We want text view to be able to calculate intrinsic 
        // content size for "read more" feature
        self.patientHistoryTextView.isScrollEnabled = false
        
        self.patientHistoryTextView.text = patient.longDesc?.replacingOccurrences(of: "\r\n|\n|\r", with: "\n", options: .regularExpression)
        
        self.patientHistoryTextView.isHidden = false
        self.patientHistoryReadMoreButton.isHidden = false
    }
    
    func configurePatientHistoryReadMoreButton() {
        self.patientHistoryReadMoreButton.layer.borderWidth = 1.0;
        self.patientHistoryReadMoreButton.layer.borderColor = Color.patientProfilReadMoreButtonColor().cgColor
    }
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -scrollView.contentOffset.y
        
        // Zoom photo when scrolling down
        
        if y > 0 {
            self.photo.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: self.cachedPhotoSize.size.width + y, height: self.cachedPhotoSize.size.height + y)
            
            self.photo.center = CGPoint(x: self.view.center.x, y: self.photo.center.y)
            
            self.photoBlackOverlay.frame = CGRect(x: 0, y: 0, width: self.cachedPhotoBlackOverlaySize.size.width + y, height: self.cachedPhotoBlackOverlaySize.size.height + y)
            
            self.photoBlackOverlay.center = CGPoint(x: self.view.center.x, y: self.photoBlackOverlay.center.y)
        }
        
        // Update nav bar color when scrolling up / down
        
        let finalColor = Color.navigationBarBackgroundColor()
        let offsetY = scrollView.contentOffset.y
        
        let navBarHeight: CGFloat = 64.0
        let navBarTriggerPoint = self.photoHeight - (navBarHeight * 2)
        
        if offsetY > navBarTriggerPoint {
            let alpha = min(1, 1 - ((navBarTriggerPoint + navBarHeight - offsetY) / navBarHeight));
            
            self.navigationController?.navigationBar.lt_setBackgroundColor(finalColor.withAlphaComponent(alpha))
        } else {
            self.navigationController?.navigationBar.lt_setBackgroundColor(finalColor.withAlphaComponent(0.0))
        }
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 1 {
            return self.patientHistoryTextViewCellHeight
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return patient.numberOfDonors ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let donor = self.patient.donors![indexPath.row]
        let patientDonorCell = collectionView.dequeueReusableCell(withReuseIdentifier: patientDonorCollectionViewCellReuseIdentifier,
                                                      for: indexPath) as! PatientDonorCollectionViewCell
        
        if let donorAvatarUrl = donor.avatarUrl {
            patientDonorCell.avatarImageView.sd_setImage(with: URL(string: donorAvatarUrl))
            patientDonorCell.firstNameFirstLetterLabel.text = ""
        } else {
            if let randomColor = donor.randomColorAssigned {
                patientDonorCell.backgroundColor = randomColor
            } else {
                patientDonorCell.backgroundColor = randomColor(hue: .blue, luminosity: .bright)
                donor.randomColorAssigned = patientDonorCell.backgroundColor
            }
            
            patientDonorCell.firstNameFirstLetterLabel.text = "\(donor.name.characters.first!)"
        }
        
        patientDonorCell.layer.cornerRadius = 20.0
        patientDonorCell.layer.masksToBounds = false
        patientDonorCell.clipsToBounds = true
        
        return patientDonorCell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == showDonorViewControllerSegueIdentifier {
            if let indexPath = self.donorsCollectionView.indexPathsForSelectedItems?.first {
                let donor = self.patient.donors![indexPath.row]
                
                let donorProfilViewController = segue.destination as! DonorProfilViewController
                
                donorProfilViewController.donor = donor
            }
        }
        
        if segue.identifier == showDonateViewControllerSegueIdentifier {
            let donateViewControllerNav = segue.destination as! UINavigationController
            let donateViewController = donateViewControllerNav.viewControllers[0] as! DonateViewController
            
            donateViewController.patientProfilVC = self
        }
    }
}
