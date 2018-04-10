//
//  AdminViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/2/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class AdminViewController: UIViewController, UITableViewDataSource,UISearchBarDelegate, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users: [PFObject] = []
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchName()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.userNameLabel.text = user["username"] as? String
        print(user["type"] as? String ?? "No user type")
        if user["type"] as? String == "host" {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
        return cell
    }

    //Adding Checkmarks on usernames
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }else{
            let user = users[indexPath.row]
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            PFCloud.callFunction(inBackground: "makeHost", withParameters: ["username": user["username"], "id": user.objectId]) { (response, error) in
                if error == nil {
                    // The function was successfully executed and you have a correct // response object
                    print(response as? String ?? "Response = nil")
                } else {
                    // The function returned a error
                    print("There was an error")
                }
            }
        }
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
    
    //Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        let user = PFQuery(className: "_User")
        
        if searchText != nil{
            user.whereKey("username", matchesRegex: "(?i)\(searchText)")
        }
        user.findObjectsInBackground { (results, error) -> Void in
            self.users = (results)!
            self.tableView.reloadData()
        }
    }
    
    //LogOut
    @IBAction func didTapLogOutButton(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }



}
