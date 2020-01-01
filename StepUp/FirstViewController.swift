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
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var authURL: String?
    private var isLogin: Bool = false
    @IBOutlet weak var lectureTableView: UITableView!
    
    @IBAction func button(_ sender: UIButton) {
        print(lectureTableView.numberOfRows(inSection: 0))
        let url = URL(string: "https://service.cloud.teu.ac.jp/portal/index")!
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lectureTableView.register(UINib(nibName: "LectureTableViewCell", bundle: nil), forCellReuseIdentifier: "LecCell")
        getMyInfo()
    }
    
    private func getMyInfo() {
        Alamofire.request("http://zipcloud.ibsnet.co.jp/api/search?zipcode=1850032").responseJSON { response in
            if response.result.isSuccess {
                if let responseValue = response.result.value {
                    print(JSON(responseValue))
                }
            }
        }
    }
    
    // tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LecCell") as? LectureTableViewCell {
            cell.setText("Loading ...")
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
