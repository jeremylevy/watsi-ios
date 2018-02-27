//
//  Donor.swift
//  Watsi
//
//  Created by Jeremy Levy on 08/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

class Donor: NSObject {
    var id: Int
    var name: String
    var username: String
    
    var bio: String?
    var country: String?
    
    var profilUrl: String
    var avatarUrl: String?
    
    var homepageUrl: String?
    var story: String
    
    var isUFMember: Bool
    var patientsPhotos: [String]
    
    var countriesFunded: [Country]
    
    var randomColorAssigned: UIColor?
    
    init(id: Int, name: String, bio: String?, country: String?, profilUrl: String, avatarUrl: String?, homepageUrl: String?, story: String, isUFMember: Bool, countriesFunded: [Country], patientsPhotos: [String]) {
        
        self.id = id
        self.name = name
        self.username = name.lowercased().replacingOccurrences(of: " ", with: "")
        
        self.bio = bio
        self.country = country
        
        self.profilUrl = profilUrl
        self.avatarUrl = avatarUrl
        
        self.homepageUrl = homepageUrl
        self.story = story
        
        self.isUFMember = isUFMember
        self.countriesFunded = countriesFunded
        
        self.patientsPhotos = patientsPhotos
    }
}
