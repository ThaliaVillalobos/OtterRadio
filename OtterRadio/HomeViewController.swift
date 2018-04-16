//
//  HomeViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 3/27/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse


class HomeViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate{
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var username: String!
    var otterRadio: RadioAPI!
    var admin: Admin!
    var messages: [PFObject] = []
    
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        otterRadio = RadioAPI()
        self.view.layer.addSublayer(otterRadio.getAVPlayerLayer())
        
        checkUser()
        trayDesign()
        
        fetchMessages()
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Checking to see if a user is a guest
    func checkUser() {
        if PFUser.current() == nil{
            trayView.isHidden = true
            var viewControllers = tabBarController?.viewControllers
            viewControllers?.remove(at: 2)
            tabBarController?.viewControllers = viewControllers
        }
    }
    
    //The style of the Tray view
    func trayDesign(){
        trayDownOffset = 285
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
    }
    
    //Logout Button
    @IBAction func didTapLogOutButton(_ sender: Any) {
        
        otterRadio.stopRadio()
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    //Play Button
    @IBAction func didTapPlayButton(_ sender: UIButton) {
        if !(otterRadio.isPlaying!)
        {
            otterRadio.playRadio()
            playButton.setImage(UIImage(named: "pause.png"), for: UIControlState.normal)
        } else {
            otterRadio.stopRadio()
            playButton.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
        }
    }

    //Tary
    @IBAction func didPanTray(_ sender: AnyObject) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayDown
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayUp                 
                }
            }
        }
    }
    
    //Send Button
    @IBAction func sendButton(_ sender: AnyObject) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let mess = messages[indexPath.row]
        
        if let user = mess["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        
        cell.messageLabel.text = mess["text"] as? String
        
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
                
                self.tableView.reloadData()
            } else {
                print("Error receiving the messages")
            }
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (!isMoreDataLoading) {
//            // Calculate the position of one screen length before the bottom of the results
//            let scrollViewContentHeight = tableView.contentSize.height
//            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
//            
//            // When the user has scrolled past the threshold, start requesting
//            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
//                
//                isMoreDataLoading = true
//                
//                // Code to load more results
//                loadMoreData()
//            }
//        }
//    }
  
}
