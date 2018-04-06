//
//  MusicCell.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {
    
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var shoutOut: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
