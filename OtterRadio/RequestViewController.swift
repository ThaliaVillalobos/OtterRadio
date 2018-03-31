//
//  RequestViewController.swift
//  OtterRadio
//
//  Created by Thalia  on 3/31/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class RequestViewController: UIViewController {

    @IBOutlet weak var artistName: UITextField!
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var shoutOut: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSubmit(_ sender: AnyObject) {
        let requestSong = PFObject(className: "Request")
        
        requestSong["artist"] = artistName.text ?? ""
        requestSong["song"] = songTitle.text ?? ""
        requestSong["shoutOut"] = shoutOut.text ?? ""
        requestSong["user"] = PFUser.current()
        
        
        requestSong.saveInBackground { (success, error) in
            if success {
                print("The request is saved!")
                self.artistName.text = ""
                self.songTitle.text = ""
                self.shoutOut.text = ""
                
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
        performSegue(withIdentifier: "backHome", sender: nil)
        
    }

}
