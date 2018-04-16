//
//  LoginViewController.swift
//  OtterRadio
//
//  Created by Thalia  on 3/24/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignIn(_ sender: AnyObject) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                self.alertMessage(title: "Login Failed", message: error.localizedDescription)
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                
                switch PFUser.current()!.value(forKey: "type") as! String {
                    
                    case "admin":
                        self.performSegue(withIdentifier: "adminSegue", sender: nil)
                        break
                    case "host":
                        self.performSegue(withIdentifier: "hostSegue", sender: nil)
                        break
                    case "user":
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        break
                    default:
                        print("Error")
                }
                
            }
        }
    }
    
    
    @IBAction func onSignUp(_ sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser["type"] = "user"
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                self.alertMessage(title: "ERROR", message: error.localizedDescription)
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }

    }

    
    @IBAction func onSignGuest(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    func alertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) {(action) in }
        
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) { }
    }


}
