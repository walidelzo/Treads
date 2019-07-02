//
//  RunLogVC.swift
//  Treads
//
//  Created by Admin on 5/1/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
}

extension RunLogVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "runLog") as? runLog {
            guard let run = Run.getAllRuns()?[indexPath.row] else {
                return runLog()
            }
            cell.configure(run: run)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    
    
}

