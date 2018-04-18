//
//  DisplayMusicViewController.swift
//  OtterRadio
//
//  Created by Thalia  on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class DisplayMusicViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate {

    @IBOutlet weak var musicTableView: UITableView!
    var music: [PFObject] = []
    
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRequest()
        musicTableView.dataSource = self
        musicTableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DisplayMusicViewController.didPullToRefresh(_:)), for: .valueChanged)
        musicTableView.insertSubview(refreshControl, at: 0)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchRequest), userInfo: nil, repeats: true)
        
        loadMoreData()
        
        let frame = CGRect(x: 0, y: musicTableView.contentSize.height, width: musicTableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        musicTableView.addSubview(loadingMoreView!)
        
        var insets = musicTableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        musicTableView.contentInset = insets
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.song = music[indexPath.row]
        return cell
    }
    
    //Logout Button
    @IBAction func didTapLogOutButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    //Refresh message
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchRequest()
        refreshControl.endRefreshing()
    }
    
    //Fetching Request
    func fetchRequest() {
        let query = PFQuery(className: "Request")
        query.order(byDescending: "_created_at")
        query.limit = self.limit
        query.includeKey("user")
        
        query.findObjectsInBackground { ( music: [PFObject]?, error: Error?) in
            if let song = music {
                self.music = song
                
                self.musicTableView.reloadData()
            } else {
                print("Error receiving the messages")
            }
        }
    }
    
    //Ininit Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = musicTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - musicTableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && musicTableView.isDragging) {
                
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: musicTableView.contentSize.height, width: musicTableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                loadMoreData()
            }
        }
    }
    
    //
    func loadMoreData() {
        let query = PFQuery(className: "Request")
        query.order(byDescending: "_created_at")
        query.includeKey("user")
        query.limit = limit
        query.findObjectsInBackground { ( musics: [PFObject]?, error: Error?) in
            if let song = musics {
                self.music = song
                self.loadingMoreView!.stopAnimating()
                self.musicTableView.reloadData()
                self.isMoreDataLoading = false
            } else {
                print("Error receiving the messages")
            }
        }
        
        self.limit = self.limit + 10
    }
    
    

}
