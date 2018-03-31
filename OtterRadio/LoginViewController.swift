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
    
    var number = 1
    var username:String!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lastNumber = UserDefaults.standard.value(forKey: "hightestNumber"){
            self.number = lastNumber as! Int
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignIn(_ sender: AnyObject) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    @IBAction func onSignUp(_ sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

    
    @IBAction func onSignGuess(_ sender: AnyObject) {
        if PFUser.current()?.username != nil{
            print(PFUser.current()?.username)
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }else{
            let newUser = PFUser()
            newUser.username = username
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    print(self.username)
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
        
        //let password = "Pa361ssW485ord9753"
        
        //newUser.password = password
        
        self.number += 1
        UserDefaults.standard.set(self.number, forKey:"hightestNumber")
    }


}
