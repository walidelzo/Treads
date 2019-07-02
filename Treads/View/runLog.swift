//
//  runLog.swift
//  Treads
//
//  Created by Admin on 6/2/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class runLog: UITableViewCell {

    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var paceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(run:Run){
        durationLbl.text = run.duration.formatTimeToString()
        distanceLbl.text = "\(run.distance.metersToMiles(places: 2)) /mi"
        paceLbl.text = run.pace.formatTimeToString()
        dateLbl.text = run.date.StringFromDate()
        
    }

}
