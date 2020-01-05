//
//  AuthActivity.swift
//  StepUp
//
//  Created by CrystalArrow on 2019/12/29.
//  Copyright © 2019 CrystalArrow. All rights reserved.
//

import UIKit

class AuthActivity: UIActivity {
    
    var url: String?
    var viewController: FirstViewController?
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if let nsUrl: NSURL = item as? NSURL {
                let urlString = nsUrl.absoluteString
                url = urlString
            }
        }
        return true
    }
    
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override var activityTitle: String? {
        return "StepUpでログインする"
    }
    
    override var activityImage: UIImage? {
        return nil
    }
    
    override func perform() {
        if let url = url {
            let comp = NSURLComponents(string: url)
            let queryItem = comp?.queryItems
            if let authTkt = queryItem?.first?.value {
                CSCNetwork.authTkt = authTkt
            }
        }
        if let viewController = viewController {
            viewController.setTableMessage("Loading ...")
            CSCNetwork.getMyInfo(viewController)
        }
    }
    
}
