//
//  DisplayMusicViewController.swift
//  OtterRadio
//
//  Created by Thalia  on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse

class DisplayMusicViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var musicTableView: UITableView!
    var music: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRequest()
        musicTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DisplayMusicViewController.didPullToRefresh(_:)), for: .valueChanged)
        musicTableView.insertSubview(refreshControl, at: 0)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchRequest), userInfo: nil, repeats: true)

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

}
