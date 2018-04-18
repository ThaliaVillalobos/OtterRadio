//
//  AdminViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/2/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class AdminViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var users: [PFObject] = []
    var filteredData: [String]!
    var confirmHostAlert: UIAlertController! = nil
    var confirmUserAlert: UIAlertController! = nil
    
    private var selectedUser: PFObject! = nil
    private var selectedTableViewCell: UITableViewCell!
    private var userType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchName()
        searchForUser("user")
        userType = "user"
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        confirmHostAlert = UIAlertController(title: "Promote User", message: "Turn user into radio host?", preferredStyle: UIAlertControllerStyle.alert)
        
        confirmHostAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.turnUserToHost()
        }))
        
        confirmHostAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.selectedUser = nil
            self.selectedTableViewCell = nil
            print("Canceled")
        }))
        //-----------
        confirmUserAlert = UIAlertController(title: "Revoke Host", message: "Turn host into regular user?", preferredStyle: UIAlertControllerStyle.alert)
        
        confirmUserAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.turnHostToUser()
        }))
        
        confirmUserAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.selectedUser = nil
            self.selectedTableViewCell = nil
            print("Canceled")
        }))
        
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
        //print(user["type"] as? String ?? "No user type")
        if (user["type"] as! String) == "host" {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return cell
    }

    //Adding Checkmarks on usernames
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            self.selectedUser = users[indexPath.row]
            self.selectedTableViewCell = tableView.cellForRow(at: indexPath)
            self.present(confirmUserAlert, animated: true, completion: nil)
        }else{
            selectedUser = users[indexPath.row]
            selectedTableViewCell = tableView.cellForRow(at: indexPath)
            self.present(confirmHostAlert, animated: true, completion: nil)
        }
    }
    
    //Fetching Names
    func fetchName() {
        let query = PFQuery(className: "_User")
        query.includeKey("username")
        query.includeKey("type")
        
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
            user.whereKey("type", equalTo: self.userType)
        }
        user.findObjectsInBackground { (results, error) -> Void in
            self.users = (results)!
            self.tableView.reloadData()
        }
    }
    
    func searchForUser(_ userType: String) {
        let query = PFQuery(className: "_User")
        query.includeKey("username")
        query.includeKey("type")
        
        query.whereKey("type", equalTo: userType)
        query.findObjectsInBackground { ( users: [PFObject]?, error: Error?) in
            if let userName = users {
                self.users = userName
                self.tableView.reloadData()
            } else {
                print("Error receiving the messages")
            }
        }
        
    }
    
    //LogOut
    @IBAction func didTapLogOutButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
                searchForUser("user")
                userType = "user"
            case 1:
                searchForUser("host")
                userType = "host"
            default:
                break
        }
    }
    private func turnUserToHost() {
        PFCloud.callFunction(inBackground: "makeHost", withParameters: ["username": self.selectedUser["username"], "id": self.selectedUser.objectId as Any]) { (response, error) in
            if error == nil {
                // The function was successfully executed and you have a correct // response object
                print(response as? String ?? "Response = nil")
                self.selectedTableViewCell.accessoryType = UITableViewCellAccessoryType.checkmark
                
                self.selectedUser = nil
                self.selectedTableViewCell = nil
            } else {
                // The function returned a error
                print("There was an error")
                self.selectedUser = nil
                self.selectedTableViewCell = nil
            }
        }
    }

    private func turnHostToUser() {
        PFCloud.callFunction(inBackground: "makeUser", withParameters: ["username": self.selectedUser["username"], "id": self.selectedUser.objectId!]) { (response, error) in
            if error == nil {
                // The function was successfully executed and you have a correct // response object
                print(response as? String ?? "Response = nil")
                self.selectedTableViewCell.accessoryType = UITableViewCellAccessoryType.none
                
                self.selectedUser = nil
                self.selectedTableViewCell = nil
            } else {
                // The function returned a error
                print("There was an error")
                self.selectedUser = nil
                self.selectedTableViewCell = nil
            }
        }
    }
}
