//
//  DonorProfilDetailsView.swift
//  Watsi
//
//  Created by Jeremy Levy on 13/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

class DonorProfilDetailsView: UIView {
    var contentView: UIView!
    var nameLabel: UILabel!
    var usernameLabel: UILabel!
    var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.contentView = UIView()
        self.nameLabel = UILabel()
        self.usernameLabel = UILabel()
        self.descriptionLabel = UILabel()
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameLabel.textAlignment = .center
        self.usernameLabel.textAlignment = .center
        self.descriptionLabel.textAlignment = .center
        
        self.nameLabel.textColor = UIColor.black
        self.usernameLabel.textColor = UIColor.black.withAlphaComponent(0.54)
        self.descriptionLabel.textColor = UIColor.black.withAlphaComponent(0.72)
        
        self.nameLabel.numberOfLines = 0
        self.usernameLabel.numberOfLines = 0
        self.descriptionLabel.numberOfLines = 0
        
        self.addSubview(self.contentView)
        
        self.configureContentViewLayoutConstraints()
        self.configureNameLabelLayoutConstraints()
        
        self.configureUsernameLabelLayoutConstraints()
        self.configureDescriptionLabelLayoutConstraints()
        
        self.backgroundColor = UIColor.white
        self.tintColor = Color.windowTintColor()
        
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.usernameLabel.font = UIFont.systemFont(ofSize: 14)
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func configureDescriptionLabelLayoutConstraints() {
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.usernameLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0))
    }
    
    func configureUsernameLabelLayoutConstraints() {
        self.contentView.addConstraint(NSLayoutConstraint(item: self.usernameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.nameLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 2.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.usernameLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.usernameLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0))
    }
    
    func configureNameLabelLayoutConstraints() {
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0))
    }
    
    func configureContentViewLayoutConstraints() {
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0))
            
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0))
        
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0))
        
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0))
    }
}
