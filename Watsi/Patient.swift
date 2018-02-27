//
//  Patient.swift
//  Watsi
//
//  Created by Jeremy Levy on 02/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

class Patient: NSObject {
    var id: Int
    var firstName: String?
    
    var shortDesc: String
    var longDesc: String?
    
    var ageYears: Int?
    var ageMonths: Int?
    
    var partnerName: String?
    var country: String?
    
    var profilUrl: String?
    var photoUrl: String
    
    var percentFunded: Float
    var targetAmount: Float
    
    var amountRemaining: Float
    var amountRaised: Float
    
    var numberOfDonors: Int?
    var donors: [Donor]?
    
    init(id: Int, firstName: String?, shortDesc: String, longDesc: String?, ageYears: Int?, ageMonths: Int?, partnerName: String?, country: String?, profilUrl: String?, photoUrl: String, percentFunded: Float, targetAmount: Float, amountRemaining: Float, amountRaised: Float, numberOfDonors: Int?, donors: [Donor]?) {
        
        self.id = id
        self.firstName = firstName
        
        self.shortDesc = shortDesc
        self.longDesc = longDesc
        
        self.ageYears = ageYears
        self.ageMonths = ageMonths
        
        self.partnerName = partnerName
        self.country = country
        
        self.profilUrl = profilUrl
        self.photoUrl = photoUrl
        
        self.percentFunded = percentFunded
        self.targetAmount = targetAmount
        
        self.amountRemaining = amountRemaining
        self.amountRaised = amountRaised
        
        self.numberOfDonors = numberOfDonors
        self.donors = donors
    }
    
    convenience init(id: Int, shortDesc: String, photoUrl: String, percentFunded: Float, targetAmount: Float, amountRemaining: Float, amountRaised: Float) {
        
        self.init(id: id,
                  firstName: nil,
                  shortDesc: shortDesc,
                  longDesc: nil,
                  ageYears: nil,
                  ageMonths: nil,
                  partnerName: nil,
                  country: nil,
                  profilUrl: nil,
                  photoUrl: photoUrl,
                  percentFunded: percentFunded,
                  targetAmount: targetAmount,
                  amountRemaining: amountRemaining,
                  amountRaised: amountRaised,
                  numberOfDonors: nil,
                  donors: nil)
    }
}
