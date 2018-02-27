//
//  DonorProfilPatientsCountryMapArtwork.swift
//  Watsi
//
//  Created by Jeremy Levy on 14/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit
import MapKit

class DonorProfilPatientsCountryMapArtwork: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
