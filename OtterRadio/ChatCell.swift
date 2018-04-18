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
    @IBOutlet weak var chatDate: UILabel!
    var createdAtString: String = ""
    
    var message: PFObject! {
        didSet {
            if let user = message["user"] as? PFUser {
                usernameLabel.text = user.username
            }
            messageLabel.text = message["text"] as? String
            
            let createdAtOringinalString = message.createdAt?.description
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
            let date = formatter.date(from: createdAtOringinalString!)!
            formatter.dateFormat = "MMM dd HH:mm a"
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            createdAtString = formatter.string(from: date)
            chatDate.text = createdAtString
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
