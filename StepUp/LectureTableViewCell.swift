//
//  LectureTableViewCell.swift
//  StepUp
//
//  Created by CrystalArrow on 2019/12/31.
//  Copyright © 2019 CrystalArrow. All rights reserved.
//

import UIKit

class LectureTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setText(_ text: String) {
        label.text = text
    }
    
}
