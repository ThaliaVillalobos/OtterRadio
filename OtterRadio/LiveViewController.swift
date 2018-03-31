//
//  LiveViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 3/27/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {
    
    @IBOutlet weak var liveFeedWebView: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let liveFeedURL = URL(string: "http://media.csumb.edu/www/player/encoder.php?en=3&f=1")
        if let unwrapURL = liveFeedURL{
            
            let request = URLRequest(url: unwrapURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: unwrapURL, completionHandler: { (data, response, error) in
                
                if data != nil{
                    //Update the Web View to the main thread
                    DispatchQueue.main.async {
                         self.liveFeedWebView.loadRequest(request)
                    }
                }
                else{
                    
                    print("Error loading Live Stream \(String(describing: error))")
                }
            })
            
           task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
