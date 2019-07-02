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
        print("this is all runs\(String(describing: Run.getAllRuns()))")
        getLastRun()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.startUpdatingLocation()
        manager?.delegate = self
        mapView.delegate = self

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        mapViewSetup()

    }

    @IBAction func centerLocationBtn(_ sender: Any) {
        
    }
    
    func mapViewSetup(){
        if let overly = getLastOverly() {
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overly)
            LastRubView.isHidden = false

        }else{
            LastRubView.isHidden = true

        }
    }
    
    func getLastOverly()->MKPolyline?{
        guard let lastRun =  Run.getAllRuns()?.first else{
            LastRubView.isHidden = true
            return nil
        }
        self.avgPacesLbl.text = lastRun.pace.formatTimeToString()
        self.durationsLbl.text = lastRun.duration.formatTimeToString()
        self.distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        self.LastRunDate.text = lastRun.date.StringFromDate()
        var coordinate2d = [CLLocationCoordinate2D]()
        for location in lastRun.locations
        {
            coordinate2d.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            
        }
        return MKPolyline(coordinates: coordinate2d, count: lastRun.locations.count)
    }
    
    func getLastRun(){
        
        
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let ployline = overlay as! MKPolyline
        let render = MKPolylineRenderer(polyline: ployline)
        render.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        render.lineWidth = 4
        return render
    }
}
