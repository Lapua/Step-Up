//
//  SecondViewController.swift
//  StepUp
//
//  Created by CrystalArrow on 2019/12/29.
//  Copyright © 2019 CrystalArrow. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var minoTable: UITableView!
    @IBOutlet weak var campusTable: UITableView!
    @IBOutlet weak var minoCount: UILabel!
    @IBOutlet weak var campusCount: UILabel!
    var minoArray: [Date] = []
    var campusArray: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BusNetwork.getTable(2)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return minoArray.count
        } else {
            return campusArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
//            cell.textLabel =
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cCell", for: indexPath)
//            cell.textLabel =
            return cell
        }
    }
    
}

