//
//  Country.swift
//  Watsi
//
//  Created by Jeremy Levy on 15/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

class Country: NSObject {
    var id: Int
    var name: String
    
    var lat: Double
    var lng: Double
    
    var code: String
    
    init(id: Int, name: String, lat: Double, lng: Double, code: String) {
        self.id = id
        self.name = name
        
        self.lat = lat
        self.lng = lng
        
        self.code = code
    }
}
