//
//  RequestViewController.swift
//  OtterRadio
//
//  Created by Thalia  on 3/31/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class RequestViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var artistName: UITextField!
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var shoutOut: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    var phoneNumber = "8315823888"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoutOut.delegate = self
        shoutOut.isEditable = true
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        characterCountLabel.text = String(characterLimit - newText.characters.count)
        return newText.characters.count < characterLimit
    }
    
    @IBAction func makeCall(_ sender: UIButton) {
        if let url = URL(string: "tel://\(phoneNumber)"){
            UIApplication.shared.openURL(url)
        }
    }

}
