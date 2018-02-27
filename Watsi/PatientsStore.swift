//
//  PatientsStore.swift
//  Watsi
//
//  Created by Jeremy Levy on 02/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit
import Alamofire

enum PatientType {
    case NEW
    case STARTED
}

class PatientsStore: NSObject {
    class func patients(ofType type: PatientType, _ callback: @escaping ((Error?, [Patient]) -> Void)) {
        let url = type == .STARTED ? Config.STARTED_PATIENTS_API_URL : Config.NEW_PATIENTS_API_URL
        
        Alamofire.request(url).validate().responseJSON { response in
            var patients = [Patient]()
            
            switch response.result {
            case .success:
                let json = response.result.value
                let profiles = json as! [[String: Any]]
                
                for profil in profiles {
                    patients.append(Patient(id: profil["id"] as! Int,
                                            shortDesc: profil["shortDesc"] as! String,
                                            photoUrl: profil["photoURL"] as! String,
                                            percentFunded: profil["percentFunded"] as! Float,
                                            targetAmount: profil["targetAmount"] as! Float / 100.0,
                                            amountRemaining: profil["amountRemaining"] as! Float / 100.0,
                                            amountRaised: profil["amountRaised"] as! Float / 100.0))
                }
                
                callback(nil, patients)
            case .failure(let error):
                callback(error, [])
            }
        }
    }
    
    class func patient(withId id: Int, _ callback: @escaping ((Error?, Patient?) -> Void)) {
        Alamofire.request(Config.PATIENT_API_URL.replacingOccurrences(of: ":id", with: String(id))).validate().responseJSON { response in
            
            switch response.result {
            case .success(let json):
                let profil = json as! [String: Any]
                
                var donors: [Donor] = []
                
                for var donor in (profil["donors"] as! [[String: Any]]) {
                    var countriesFunded: [Country] = []
                    
                    for var country in (donor["countries"] as! [[String: Any]]) {
                        countriesFunded.append(Country(id: country["id"] as! Int,
                                                       name: country["name"] as! String,
                                                       lat: country["lat"] as! Double,
                                                       lng: country["lng"] as! Double,
                                                       code: country["code"] as! String))
                    }
                    
                    donors.append(Donor(id: donor["id"] as! Int,
                                        name: donor["name"] as! String,
                                        bio: donor["bio"] as? String,
                                        country: donor["country"] as? String,
                                        profilUrl: donor["profilURL"] as! String,
                                        avatarUrl: donor["avatarURL"] as? String,
                                        homepageUrl: donor["homepageURL"] as? String,
                                        story: donor["story"] as! String,
                                        isUFMember: (donor["isUFMember"] as! Int) == 0 ? false : true,
                                        countriesFunded: countriesFunded,
                                        patientsPhotos: donor["patientPhotos"] as! [String]))
                }
                
                let patient = Patient(id: profil["id"] as! Int,
                                      firstName: profil["firstName"] as? String,
                                      shortDesc: profil["shortDesc"] as! String,
                                      longDesc: profil["longDesc"] as? String,
                                      ageYears: profil["ageYears"] as? Int,
                                      ageMonths: profil["ageMonths"] as? Int,
                                      partnerName: profil["partnerName"] as? String,
                                      country: profil["country"] as? String,
                                      profilUrl: profil["profilURL"] as? String,
                                      photoUrl: profil["photoURL"] as! String,
                                      percentFunded: profil["percentFunded"] as! Float,
                                      targetAmount: profil["targetAmount"] as! Float / 100.0,
                                      amountRemaining: profil["amountRemaining"] as! Float / 100.0,
                                      amountRaised: profil["amountRaised"] as! Float / 100.0,
                                      numberOfDonors: donors.count,
                                      donors: donors)
                
                callback(nil, patient)
            case .failure(let error):
                callback(error, nil)
            }
        }
    }
}
