//
//  MusicCell.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class MusicCell: UITableViewCell {
    
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var shoutOut: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var createdAtString: String = ""
    
    var song: PFObject!{
        didSet{
            artistName.text = song["artist"] as? String
            songTitle.text = song["song"] as? String
            shoutOut.text = song["shoutOut"] as? String
            if let user = song["user"] as? PFUser {
                // User found! update username label with username
                userName.text = user.username
            } else {
                // No user found, set default username
                userName.text = "🤖"
            }
            
            let createdAtOringinalString = song.createdAt?.description
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
    
    override func layoutSubviews() {
//        artistName.preferredMaxLayoutWidth = artistName.frame.size.width
//        songTitle.preferredMaxLayoutWidth = songTitle.frame.size.width
//        shoutOut.preferredMaxLayoutWidth = shoutOut.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
