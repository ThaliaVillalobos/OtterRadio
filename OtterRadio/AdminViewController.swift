//
//  AdminViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/2/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class AdminViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [PFObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        //Todo: dispaly username
//        let username = users[indexPath.row]
//        
//        cell.userNameLabel.text = use
        
        return cell
    }
    
    //Fetching messages
    func fetchMessages() {
        let query = PFQuery(className: "_User")
        query.includeKey("username")
        
        
        query.findObjectsInBackground { ( users: [PFObject]?, error: Error?) in
            if let userName = users {
                self.users = userName
                self.tableView.reloadData()
            } else {
                print("Error receiving the messages")
            }
        }
    }


}
