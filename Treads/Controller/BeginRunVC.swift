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
    @IBOutlet weak var avgPacesLbl: UILabel!
    @IBOutlet weak var durationsLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var LastRubView: UIView!
    
    @IBOutlet weak var LastRunDate: UILabel!
    
    //Actions
    @IBAction func closeBtnView(_ sender: Any) {
        self.LastRubView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        print("this is all runs\(String(describing: Run.getAllRuns()))")
        getLastRun()
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
    
    
    func getLastRun(){
        guard let lastRun =  Run.getAllRuns()?.first else{
            LastRubView.isHidden = true
            return
        }
        self.avgPacesLbl.text = lastRun.pace.formatTimeToString()
        self.durationsLbl.text = lastRun.duration.formatTimeToString()
        self.distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        self.LastRunDate.text = lastRun.date.StringFromDate()
        
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
