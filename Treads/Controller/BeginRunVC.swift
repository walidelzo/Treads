//
//  BeginRunVC.swift
//  Treads
//
//  Created by Admin on 5/1/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit
import MapKit
class BeginRunVC: LocationVC {
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.startUpdatingLocation()
        manager?.delegate = self
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    @IBAction func centerLocationBtn(_ sender: Any) {
        
    }
    
}
extension BeginRunVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status  == .authorizedWhenInUse{
         checkLocationAuthStatus()
         mapView.showsUserLocation = true
         mapView.userTrackingMode = .follow
        }
    }
}
