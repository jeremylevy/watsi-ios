//
//  PatientCollectionViewCell.swift
//  Watsi
//
//  Created by Jeremy Levy on 01/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

class PatientCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var percentFundedProgress: UIProgressView!
    
    @IBOutlet weak var percentFundedLabel: UILabel!
    @IBOutlet weak var percentFundedLegendLabel: UILabel!
    
    @IBOutlet weak var amountRaisedLabel: UILabel!
    @IBOutlet weak var amountRaisedLegendLabel: UILabel!
    
    @IBOutlet weak var amountRemainingLabel: UILabel!
    @IBOutlet weak var amountRemainingLegendLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        percentFundedLabel.textColor = Color.patientCollectionViewCellPercentFundedLabelColor()
        amountRaisedLabel.textColor = Color.patientCollectionViewCellAmountRaisedLabelColor()
        
        amountRemainingLabel.textColor = Color.patientCollectionViewCellAmountRemainingLabelColor()
        descriptionLabel.textColor = Color.patientCollectionViewCellDescriptionLabelColor()
        
        amountRaisedLegendLabel.textColor = Color.patientCollectionViewCellAmountRaisedLegendLabelColor()
        
        percentFundedLegendLabel.textColor = Color.patientCollectionViewCellPercentFundedLegendLabelColor()
        
        amountRemainingLegendLabel.textColor = Color.patientCollectionViewCellAmountRemainingLegendLabelColor()
        
        percentFundedProgress.trackTintColor = Color.patientCollectionViewCellPercentFundedProgressTrackTintColor()
        
        percentFundedProgress.progressTintColor = Color.patientCollectionViewCellPercentFundedProgressTintColor()
    }
}
