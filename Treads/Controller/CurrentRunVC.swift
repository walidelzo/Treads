//
//  CurrentRunVC.swift
//  Treads
//
//  Created by Admin on 5/4/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//
import UIKit
import MapKit
import RealmSwift
class CurrentRunVC: LocationVC {
    
    @IBOutlet weak var slidBgImage: UIImageView!
    @IBOutlet weak var sliderImage: UIImageView!
    @IBOutlet weak var puseBtn: UIButton!
    @IBOutlet weak var durationLBL: UILabel!
    @IBOutlet weak var distanceLBL: UILabel!
    @IBOutlet weak var paceLBL: UILabel!
    
   fileprivate var startLocation:CLLocation!
   fileprivate var endLocation:CLLocation!
   fileprivate var distance = 0.0
   fileprivate var timer = Timer()
   fileprivate var counter = 0
   fileprivate var pace = 0
   fileprivate var coordonateLocations = List<Location>()
    
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
        
        sliderImage.center.x = slidBgImage.center.x - (sliderImage.frame.width + 6)
        sliderImage.center.y = slidBgImage.center.y
        print(slidBgImage.center.y)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
        
    }
    
    func startRun(){
        manager?.startUpdatingLocation()
        startTimer()
        puseBtn.setImage(#imageLiteral(resourceName: "pauseButton"), for: .normal)
        
    }
    func pauseRun(){
        manager?.stopUpdatingLocation()
        timer.invalidate()
        puseBtn.setImage(#imageLiteral(resourceName: "resumeButton"), for: .normal)
    }
    
    func endRun(){
        manager?.stopUpdatingLocation()
        Run.addedRunToRealm(distace: distance, pace: pace, duration: counter, locations: coordonateLocations)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counterFunction), userInfo: nil, repeats: true)
    }
    @objc func counterFunction(){
        counter += 1
        durationLBL.text = "\(counter.formatTimeToString())"
    }
    
    func calculatePace(time second:Int , miles :Double )-> String
    {
         pace = Int(Double(second) / miles)
        return pace.formatTimeToString()
    }
    
    @IBAction func pauseBTNPressed(_ sender: Any) {
        if timer.isValid {
            pauseRun()

        }else{
            startRun()
        }
    }
    
    @objc func endRun(_ sender : UISwipeGestureRecognizer ){
        if let sliderView = sender.view {
            
            if sender.direction == UISwipeGestureRecognizer.Direction.right
            {
                UIView.animate(withDuration:2.0 ) {
                    sliderView.center.x = self.puseBtn.center.x
                    ////code is here
                    self.endRun()
                }
                self.dismiss(animated: true, completion: nil)
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
            let newLocation = Location(latitude: Double(endLocation.coordinate.latitude), longitude: Double(endLocation.coordinate.longitude))
            self.coordonateLocations.insert(newLocation, at: 0)
            if distance > 0 && counter > 0
            {
                paceLBL.text = calculatePace(time: counter, miles: distance.metersToMiles(places: 2))
            }
        }
        endLocation = locations.last
    }
    
}

