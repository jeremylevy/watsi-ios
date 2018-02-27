//
//  DonorProfilViewController.swift
//  Watsi
//
//  Created by Jeremy Levy on 13/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit
import DBProfileViewController
import SDWebImage

private let donorProfilPatientsPhotoViewControllerIdentifier = "donorProfilPatientsPhotoCollectionViewController"
private let donorProfilPatientsCountryViewControllerIdentifier = "donorProfilPatientsCountryViewController"

class DonorProfilViewController: DBProfileViewController, DBProfileViewControllerDataSource, DBProfileViewControllerDelegate {
    
    // MARK: - Custom properties
    
    var donor: Donor!
    
    // MARK: - View controller lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDBProfileVC()
    }
    
    // MARK: - Custom methods
    
    func configureDBProfileVC() {
        self.dataSource = self
        self.delegate = self
        self.allowsPullToRefresh = false
        
        self.segmentedControl.tintColor = Color.blue()
        self.overlayView?.backgroundColor = UIColor.clear
        
        self.register(DBProfileAvatarView.self , forAccessoryViewOfKind: DBProfileAccessoryKindAvatar)
        self.register(DBProfileCoverPhotoView.self, forAccessoryViewOfKind: DBProfileAccessoryKindHeader)
        
        self.configureProfilDetailView()
        self.configureAvatarView()
        self.configureCoverPhotoView()
        
        let headerViewLayoutAttr = self.layoutAttributesForAccessoryView(ofKind: DBProfileAccessoryKindHeader) as! DBProfileHeaderViewLayoutAttributes
        
        headerViewLayoutAttr.headerStyle = .navigation
        
        let avatarViewLayoutAttr = self.layoutAttributesForAccessoryView(ofKind: DBProfileAccessoryKindAvatar) as! DBProfileAvatarViewLayoutAttributes
        
        avatarViewLayoutAttr.avatarAlignment = .center
    }
    
    func configureProfilDetailView() {
        let donorProfilDetailsView = DBUserProfileDetailView()
        
        donorProfilDetailsView.nameLabel.text = donor.name
        donorProfilDetailsView.nameLabel.textColor = Color.donorNameLabelColor()
        
        donorProfilDetailsView.usernameLabel.text = "@" + donor.username
        donorProfilDetailsView.usernameLabel.textColor = Color.donorUsernameLabelColor()
        
        donorProfilDetailsView.descriptionLabel.text = donor.bio ?? donor.story
        donorProfilDetailsView.descriptionLabel.textColor = Color.donorHistoryLabelColor()
        
        donorProfilDetailsView.nameLabel.textAlignment = .center
        donorProfilDetailsView.usernameLabel.textAlignment = .center
        donorProfilDetailsView.descriptionLabel.textAlignment = .center
        
        self.detailView = donorProfilDetailsView;
    }
    
    func configureAvatarView() {
        let avatarView = self.accessoryView(ofKind: DBProfileAccessoryKindAvatar) as! DBProfileAvatarView
        
        if let avatarUrl = donor.avatarUrl {
            avatarView.imageView.sd_setImage(with: URL(string: avatarUrl))
        } else {
            avatarView.imageView.backgroundColor = donor.randomColorAssigned!
        }
        
        avatarView.avatarStyle = .round
    }
    
    func configureCoverPhotoView() {
        let coverPhotoView = self.accessoryView(ofKind: DBProfileAccessoryKindHeader) as! DBProfileCoverPhotoView
        var overlayView: UIView = UIView()
        
        if donor.avatarUrl != nil {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            
            overlayView = UIVisualEffectView(effect: blurEffect)
        } else {
            overlayView.backgroundColor = Color.blue()
        }
        
        overlayView.frame = coverPhotoView.bounds
        // for supporting device rotation
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coverPhotoView.addSubview(overlayView)
        coverPhotoView.shouldApplyTint = false
        
        if let avatarUrl = donor.avatarUrl {
            let avatarView = UIImageView()
            let block: SDWebImageCompletionBlock = {(image, error, cacheType, imageURL) -> Void in
                coverPhotoView.setCoverPhotoImage(avatarView.image!, animated: true)
            }
            
            avatarView.sd_setImage(with: URL(string: avatarUrl),
                                   placeholderImage: UIImage(),
                                   options: SDWebImageOptions.refreshCached,
                                   completed: block)
        }
    }
    
    // MARK: - DBProfileViewControllerDataSource
    
    func numberOfContentControllers(for controller: DBProfileViewController) -> UInt {
        return 2
    }
    
    func profileViewController(_ controller: DBProfileViewController, contentControllerAt controllerIndex: UInt) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if controllerIndex == 0 {
            let patientsPhotoVC = storyboard.instantiateViewController(withIdentifier: donorProfilPatientsPhotoViewControllerIdentifier) as! DonorProfilPatientsPhotoCollectionViewController
            
            patientsPhotoVC.donor = self.donor
            
            return patientsPhotoVC
        } else {
            let patientsCountryVC = storyboard.instantiateViewController(withIdentifier: donorProfilPatientsCountryViewControllerIdentifier) as! DonorProfilPatientsCountryViewController
            
            patientsCountryVC.donor = donor
            
            return patientsCountryVC
        }
    }
    
    func profileViewController(_ controller: DBProfileViewController, titleForContentControllerAt controllerIndex: UInt) -> String {
        return controllerIndex == 0 ? "Patients financés" : "Impact"
    }
    
    func profileViewController(_ controller: DBProfileViewController, subtitleForContentControllerAt controllerIndex: UInt) -> String {
        return self.donor.name
    }
    
    
//    func profileViewController(_ controller: DBProfileViewController, referenceSizeForAccessoryViewOfKind accessoryViewKind: String) -> CGSize {
//        if accessoryViewKind == DBProfileAccessoryKindAvatar {
//            return CGSize(width: 0, height: 72)
//        } else if accessoryViewKind == DBProfileAccessoryKindHeader {
//            return CGSize(width: 0, height: 80)
//        }
//        
//        return CGSize.zero
//    }
}
