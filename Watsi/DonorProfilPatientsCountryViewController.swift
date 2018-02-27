//
//  DonorProfilPatientsCountryViewController.swift
//  Watsi
//
//  Created by Jeremy Levy on 14/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit
import MapKit

private let donorProfilPatientsCountryMapArtworkIdentifier = "donorProfilPatientsCountryMapArtwork"

class DonorProfilPatientsCountryViewController: UITableViewController, MKMapViewDelegate {
    
    // MARK: - Interface builder
    
    @IBOutlet weak var map: MKMapView!
    
    // MARK: - Custom properties
    
    var donor: Donor!
    var mapAnnotationsLoaded = false
    
    // MARK: - View controller lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
    }
    
    // MARK: - Custom methods
    
    func configureTableView() {
        self.tableView.backgroundColor = Color.windowBgColor()
        
        // Trick to remove padding from table view top
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: CGFloat.leastNormalMagnitude))
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "\(donor.name) a financé les soins de santé de \(donor.patientsPhotos.count) patients dans \(donor.countriesFunded.count) pays différents."
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DonorProfilPatientsCountryMapArtwork {
            let identifier = donorProfilPatientsCountryMapArtworkIdentifier
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.isEnabled = true
                view.canShowCallout = true
                view.animatesDrop = true
            }
            
            return view
        }
        
        return nil
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if !fullyRendered {
            return
        }
        
        if self.mapAnnotationsLoaded {
            return
        }
        
        var annotations: [DonorProfilPatientsCountryMapArtwork] = []
        
        for country in donor.countriesFunded {
            annotations.append(DonorProfilPatientsCountryMapArtwork(title: country.name,
                                                                    subtitle: country.code,
                                                                    coordinate: CLLocationCoordinate2D(latitude: country.lat, longitude: country.lng)))
        }
        
        mapView.showAnnotations(annotations, animated: true)
        
        self.mapAnnotationsLoaded = true
    }
}
