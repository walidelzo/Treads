//
//  CurrentRunVC.swift
//  Treads
//
//  Created by Admin on 5/4/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class CurrentRunVC: UIViewController {
    @IBOutlet weak var slidBgImage: UIImageView!
    @IBOutlet weak var sliderImage: UIImageView!
    @IBOutlet weak var puseBtn: UIButton!
    
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
    
    @objc func endRun(_ sender : UISwipeGestureRecognizer ){
       // let maxAdjust :CGFloat = 159
        let minAdjust :CGFloat = 82
        if let sliderView = sender.view {

                if sender.direction == UISwipeGestureRecognizer.Direction.right
                {
                    UIView.animate(withDuration: 0.5) {
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
    


