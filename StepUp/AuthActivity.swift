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
    public var viewController: FirstViewController?
    
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
        if let vc = viewController {
            vc.authURL = url
        }
    }
    
}
