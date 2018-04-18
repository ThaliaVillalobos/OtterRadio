//
//  LiveCell.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class LiveCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var createdAtString: String = ""
    
    var chatMessage: PFObject! {
        didSet {
            if let user = chatMessage["user"] as? PFUser {
                name.text = user.username
            }
            message.text = chatMessage["text"] as? String
            
            let createdAtOringinalString = chatMessage.createdAt?.description
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
            let date = formatter.date(from: createdAtOringinalString!)!
            formatter.dateFormat = "MMM dd HH:mm a"
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            createdAtString = formatter.string(from: date)
            time.text = createdAtString
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
