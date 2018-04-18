//
//  LiveChatViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class LiveChatViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate  {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    var messages: [PFObject] = []
    
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.dataSource = self
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 70
        
        //fetchMessages()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(LiveChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        chatTableView.insertSubview(refreshControl, at: 0)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)
        
        loadMoreData()
        
        let frame = CGRect(x: 0, y: chatTableView.contentSize.height, width: chatTableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        chatTableView.addSubview(loadingMoreView!)
        
        var insets = chatTableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        chatTableView.contentInset = insets


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
        cell.chatMessage = messages[indexPath.row]
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
        query.limit = self.limit
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
    
    //Ininit Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = chatTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - chatTableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && chatTableView.isDragging) {
                
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: chatTableView.contentSize.height, width: chatTableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                loadMoreData()
            }
        }
    }
    
    //
    func loadMoreData() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "_created_at")
        query.includeKey("user")
        query.limit = limit
        query.findObjectsInBackground { ( messages: [PFObject]?, error: Error?) in
            if let mess = messages {
                self.messages = mess
                self.loadingMoreView!.stopAnimating()
                self.chatTableView.reloadData()
                self.isMoreDataLoading = false
            } else {
                print("Error receiving the messages")
            }
        }
        
        self.limit = self.limit + 10
    }
    


  

}
