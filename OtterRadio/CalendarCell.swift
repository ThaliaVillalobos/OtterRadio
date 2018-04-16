//
//  CalendarCell.swift
//  OtterRadio
//
//  Created by Sarah Villegas  on 4/9/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit

class CalendarCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var reminderSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
