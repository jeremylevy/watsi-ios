//
//  DonorProfilPatientsPhotoCollectionViewController.swift
//  Watsi
//
//  Created by Jeremy Levy on 14/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

private let donorPatientsPhotoCollectionViewCellReuseIdentifier = "donorProfilPatientPhotoCollectionViewCell"

class DonorProfilPatientsPhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Custom properties
    
    var donor: Donor!
    
    // MARK: - View controller lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = Color.windowBgColor()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.donor.patientsPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: donorPatientsPhotoCollectionViewCellReuseIdentifier, for: indexPath) as! DonorProfilPatientPhotoCollectionViewCell
        let patientPhotoURL = donor.patientsPhotos[indexPath.row]
        
        cell.patientPhotoImageView.sd_setImage(with: URL(string: patientPhotoURL))
    
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let photoPadding = flowLayout.minimumInteritemSpacing
        let collectionWidth = collectionView.bounds.width - (flowLayout.sectionInset.left)
        
        let photoWidth: CGFloat = (collectionWidth / 3) - (photoPadding / 1.5)
        let photoHeight = photoWidth
        
        return CGSize(width: photoWidth, height: photoHeight)
    }
}
