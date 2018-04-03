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
        fetchName()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        //Todo: dispaly username
        let user = users[indexPath.row]
        cell.userNameLabel.text = user["username"] as? String
        
        return cell
    }
    
    //Fetching Names
    func fetchName() {
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
