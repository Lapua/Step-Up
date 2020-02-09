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

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, tableDataDelegate {
    
    private let PORTAL_URL: String = "https://service.cloud.teu.ac.jp/portal/index"
    var tableMessage: String = "Welcome to StepUp"
    var tableSource: [Lectures]?
    let cscNet = CSCNetwork()
    
    @IBOutlet weak var lectureTableView: UITableView!
    @IBOutlet weak var roomCode: UITextField!
    @IBOutlet weak var seatCode: UITextField!
    
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func attend(_ sender: Any) {
        if let room = roomCode.text, let seat = seatCode.text {
            cscNet.attend(roomCode: room, seatCode: seat)
        }
    }
    
    @IBAction func updateTable(_ sender: UIButton) {
        getMyInfo()
    }
    
    @IBAction func login(_ sender: UIButton) {
        let url = URL(string: PORTAL_URL)!
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lectureTableView.rowHeight = CGFloat(44)
        lectureTableView.register(UINib(nibName: "LectureTableViewCell", bundle: nil), forCellReuseIdentifier: "LecCell")
        roomCode.delegate = self
        seatCode.delegate = self
        cscNet.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            seatCode.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func getMyInfo() {
        cscNet.getMyInfo(self)
    }
    
    // tableView
    func setTableRows(_ lectures: [Lectures]) {
        tableSource = lectures
        lectureTableView.reloadData()
    }
    
    func setTableMessage(_ message: String) {
        tableMessage = message
        lectureTableView.reloadData()
    }
    
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
        if URL.absoluteString.hasPrefix(self.PORTAL_URL + "?auth_tkt=") {
            let authActivity = AuthActivity() as AuthActivity
            authActivity.delegate = self
            return [authActivity]
        }
        return []
    }
    
    func safariViewController(_ controller: SFSafariViewController, excludedActivityTypesFor URL: URL, title: String?) -> [UIActivity.ActivityType] {
        return [.addToReadingList]
    }
    
}

protocol tableDataDelegate {
    func getMyInfo()
    func setTableRows(_ lectures: [Lectures])
    func setTableMessage(_ message: String)
}
