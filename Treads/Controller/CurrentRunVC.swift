//
//  CurrentRunVC.swift
//  Treads
//
//  Created by Admin on 5/4/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit
import MapKit
class CurrentRunVC: LocationVC {
    @IBOutlet weak var slidBgImage: UIImageView!
    @IBOutlet weak var sliderImage: UIImageView!
    @IBOutlet weak var puseBtn: UIButton!
    @IBOutlet weak var durationLBL: UILabel!
    @IBOutlet weak var distanceLBL: UILabel!
    @IBOutlet weak var paceLBL: UILabel!
    
    var startLocation:CLLocation!
    var endLocation:CLLocation!
    var distance = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipGestRight = UISwipeGestureRecognizer(target: self, action: #selector(endRun(_:)))
        sliderImage.isUserInteractionEnabled = true
        sliderImage.addGestureRecognizer(swipGestRight)
        swipGestRight.delegate = self as? UIGestureRecognizerDelegate
        swipGestRight.direction = .right
        
        let swipGestLeft = UISwipeGestureRecognizer(target: self, action: #selector(endRun(_:)))
        sliderImage.isUserInteractionEnabled = true
        sliderImage.addGestureRecognizer(swipGestLeft)
        swipGestLeft.delegate = self as? UIGestureRecognizerDelegate
        swipGestLeft.direction = .left
    }
    
    override func viewWillAppear(_ animated: Bool) {
       manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
        
    }
    
    func startRun(){
        manager?.startUpdatingLocation()
    }
    func endRun(){
        manager?.stopUpdatingLocation()
    }
    @IBAction func pauseBTNPressed(_ sender: Any) {
    }
    
    @objc func endRun(_ sender : UISwipeGestureRecognizer ){
       // let maxAdjust :CGFloat = 159
        let minAdjust :CGFloat = 82
        if let sliderView = sender.view {

                if sender.direction == UISwipeGestureRecognizer.Direction.right
                {
                    UIView.animate(withDuration: 0.2) {
                        sliderView.center.x = self.puseBtn.center.x + sliderView.bounds.width + 19
                        print(self.puseBtn.center.x)
                        ////code is here
                       // self.dismiss(animated: true, completion: nil)
                    }
                } else  if sender.direction == UISwipeGestureRecognizer.Direction.left
                    {
                            UIView.animate(withDuration: 0.2) {
                               sliderView.center.x = minAdjust
                    }
                }
            }
        }
    }
    
extension CurrentRunVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            distance += endLocation.distance(from:location )
            distanceLBL.text = "\(distance.metersToMiles(places: 2))"
        }
        endLocation = locations.last
    }
    
}

