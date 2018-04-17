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
    @IBOutlet weak var downArrowImgView: UIImageView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var username: String!
    var otterRadio: RadioAPI!
    var admin: Admin!
    var messages: [PFObject] = []
    var isArrowFacingUp = false
    
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    var limit = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        otterRadio = RadioAPI()
        self.view.layer.addSublayer(otterRadio.getAVPlayerLayer())
        
        checkUser()
        trayDesign()

        fetchMessages()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)
        

        //Todo: infinit scroll
//        loadMoreData()
//        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
//        loadingMoreView = InfiniteScrollActivityView(frame: frame)
//        loadingMoreView!.isHidden = true
//        tableView.addSubview(loadingMoreView!)
//        
//        var insets = tableView.contentInset
//        insets.bottom += InfiniteScrollActivityView.defaultHeight
//        tableView.contentInset = insets
//        
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
        trayDownOffset = 260
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
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
            isArrowFacingUp = !isArrowFacingUp
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayDown
                    self.downArrowImgView.transform = CGAffineTransform(rotationAngle: .pi)
                }
                
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayUp
                    self.downArrowImgView.transform = CGAffineTransform.identity
                }
            }
            
//            UIView.animate(withDuration:0.3){
//                if self.isArrowFacingUp {
//                    self.downArrowImgView.transform = CGAffineTransform(rotationAngle: .pi)
//                } else {
//                    self.downArrowImgView.transform = CGAffineTransform.identity
//                }
//            }
            
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
        cell.message = messages[indexPath.row]
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
        query.limit = 10
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

    
    
  //Todo: infinit scroll
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (!isMoreDataLoading) {
//            // Calculate the position of one screen length before the bottom of the results
//            let scrollViewContentHeight = tableView.contentSize.height
//            print(scrollViewContentHeight)
//            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
//            
//            // When the user has scrolled past the threshold, start requesting
//            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
//                
//                isMoreDataLoading = true
//                
//                // Update position of loadingMoreView, and start loading indicator
//                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
//                loadingMoreView?.frame = frame
//                loadingMoreView!.startAnimating()
//                
//                // Code to load more results
//                loadMoreData()
//            }
//        }
//    }
//    
//    func loadMoreData() {
//        let query = PFQuery(className: "Message")
//        query.order(byDescending: "_created_at")
//        query.includeKey("user")
//        query.limit = limit //<--- change this line
//        query.findObjectsInBackground { ( messages: [PFObject]?, error: Error?) in
//            if let mess = messages {
//                print(self.messages.count)
//                self.messages.append(contentsOf: mess)
//                print(self.messages.count)
//                
//                // Stop the loading indicator
//                
//                
//                self.loadingMoreView!.stopAnimating()
//                print("after load more stop")
//                self.tableView.reloadData()
//                print("after table reload data")
//                self.isMoreDataLoading = false
//                print(self.messages)
//            } else {
//                print("Error receiving the messages")
//            }
//        }
//        
//       self.limit = self.limit + 10
//    }
  
}
