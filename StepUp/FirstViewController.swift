//
//  FirstViewController.swift
//  StepUp
//
//  Created by CrystalArrow on 2019/12/29.
//  Copyright © 2019 CrystalArrow. All rights reserved.
//

import UIKit
import SafariServices
import Alamofire

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableMessage: String = "Loading ..."
    var tableSource: [Lectures]?
    @IBOutlet weak var lectureTableView: UITableView!
    
    @IBAction func updateTable(_ sender: UIButton) {
        Network.getMyInfo(self)
    }
    
    @IBAction func login(_ sender: UIButton) {
        let url = URL(string: "https://service.cloud.teu.ac.jp/portal/index")!
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lectureTableView.rowHeight = CGFloat(44)
        lectureTableView.register(UINib(nibName: "LectureTableViewCell", bundle: nil), forCellReuseIdentifier: "LecCell")
        Network.getMyInfo(self)
    }
    
    func setTableRows(_ lectures: [Lectures]) {
        tableSource = lectures
        lectureTableView.reloadData()
    }
    
    func setTableMessage(_ message: String) {
        tableMessage = message
        lectureTableView.reloadData()
    }
    
    // tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = tableSource?.count {
            return count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LecCell") as? LectureTableViewCell {
            if let lectures = tableSource {
                let item = lectures[indexPath.row]
                cell.setText(lectureName: item.lecture_name, roomName: item.room_name)
                return cell
            }
            cell.setText(tableMessage)
            return cell
        }
        return UITableViewCell()
    }
    
}

extension FirstViewController: SFSafariViewControllerDelegate {
    
    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
        if URL.absoluteString.hasPrefix("https://service.cloud.teu.ac.jp/portal/index?auth_tkt=") {
            let authActivity = AuthActivity() as AuthActivity
            authActivity.viewController = self
            return [authActivity]
        }
        return []
    }
    
    func safariViewController(_ controller: SFSafariViewController, excludedActivityTypesFor URL: URL, title: String?) -> [UIActivity.ActivityType] {
        return [.addToReadingList]
    }
    
}
