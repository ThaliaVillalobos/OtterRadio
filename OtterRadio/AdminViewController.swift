//
//  AdminViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/2/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class AdminViewController: UIViewController, UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users: [PFObject] = []
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchName()
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
        
        return cell
    }
    
    
    
    
//Todo: Fix the checkmarks
    //Adding Checkmarks on usernames
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//            if cell.accessoryType == .checkmark{
//                cell.accessoryType = .none
//            }
//            else{
//                cell.accessoryType = .checkmark
//            }
//        }
//        
//    }
    
    
    
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


}
