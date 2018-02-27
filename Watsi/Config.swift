//
//  Config.swift
//  Watsi
//
//  Created by Jeremy Levy on 02/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import Foundation

private let BASE_API_URL = "http://watsiapi-prod.eu-west-1.elasticbeanstalk.com"

struct Config {
    static let DEFAULT_STORYBOARD_NAME = "Main"
    
    static let STARTED_PATIENTS_API_URL = BASE_API_URL + "/patients"
    static let NEW_PATIENTS_API_URL = BASE_API_URL + "/patients/new"
    static let PATIENT_API_URL = BASE_API_URL + "/patients/:id"
}
