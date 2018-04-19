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
    let characterLimit = 140

    
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
                self.alertMessage(title: "Success", message: "Request has been sent!")
                self.characterCountLabel.text = String(self.characterLimit)
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
                self.alertMessage(title: "Fail", message: "\(error.localizedDescription)")

            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        characterCountLabel.text = String(characterLimit - newText.characters.count)
        return newText.characters.count < characterLimit
    }
    
    @IBAction func makeCall(_ sender: UIButton) {
        if let url = URL(string: "tel://\(phoneNumber)"){
            UIApplication.shared.openURL(url)
        }
    }
    
    func alertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) {(action) in }
        
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) { }
    }

}
