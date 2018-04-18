//
//  LiveChatViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class LiveChatViewController: UIViewController,UITableViewDataSource  {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    var messages: [PFObject] = []
    
    var userCols: [UIColor] = [ UIColor(hue: 46.0 , saturation: 59.0 , brightness: 100.0, alpha: 1.0), UIColor(hue: 115.0, saturation: 40.0, brightness: 77.0, alpha: 1.0) , UIColor.white ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 50
        
        fetchMessages()
        chatTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        chatTableView.insertSubview(refreshControl, at: 0)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.messageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveChat", for: indexPath) as! LiveCell
        
        let mess = messages[indexPath.row]
        
        if let user = mess["user"] as? PFUser {
            // User found! update username label with username
            cell.name.text = user.username
            let iColor = indexPath.row % 3
            print("\(iColor)\n")
            cell.name.textColor = userCols[iColor]
        } else {
            // No user found, set default username
            cell.name.text = "🤖"
        }
        
        cell.message.text = mess["text"] as? String

        
        return cell
    }
    
    //Refresh message
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMessages()
        refreshControl.endRefreshing()
    }
    
    //Fetching messages
    func fetchMessages() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "_created_at")
        query.includeKey("user")
        
        
        query.findObjectsInBackground { ( messages: [PFObject]?, error: Error?) in
            if let mess = messages {
                self.messages = mess
                
                self.chatTableView.reloadData()
            } else {
                print("Error receiving the messages")
            }
        }
    }
    
    


  

}
