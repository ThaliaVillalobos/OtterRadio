//
//  ChatCell.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 3/28/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: PFObject! {
        didSet {
            if let user = message["user"] as? PFUser {
                usernameLabel.text = user.username
            }
            messageLabel.text = message["text"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
