//
//  LiveViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 3/27/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import AVFoundation

class LiveViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var liveFeedWebView: UIWebView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    let liveFeedURL = "http://qt.csumb.edu:1935/live/encoder3.sdp/playlist.m3u8"
    var canStream: Bool?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        liveFeedWebView.delegate = self
        loadingActivityIndicator.startAnimating()
        
        
        let url = URL(string: liveFeedURL)
        
        if AVAsset(url: url!).isReadable{
            
            print("url works!")
            self.canStream = true
        }
        else{
            
            print("URL fails")
            self.canStream = false
        }
        
        
        if canStream!{
            
            let url = URL(string: liveFeedURL)
            if let unwrapURL = url{
                
                let request = URLRequest(url: unwrapURL)
                let session = URLSession.shared
                
                let task = session.dataTask(with: unwrapURL, completionHandler: { (data, response, error) in
                    
                    
                    if data != nil{
                        
                        //Update the Web View to the main thread
                        DispatchQueue.main.async {
                            
                            self.liveFeedWebView.loadRequest(request)
                            self.loadingActivityIndicator.stopAnimating()
                        }
                    }
                    else{
                        
                        print("Error loading Live Stream \(String(describing: error))")
                        
                        DispatchQueue.main.async {
                            
                            self.showAlert(title: "Error", message: String(describing: error))
                        }
                    }
                })
                
                task.resume()
            }
        }
            
        else{
            
            loadingActivityIndicator.stopAnimating()
            self.showAlert(title: "Error", message: "Live Feed is Unavailable at this time")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        liveFeedWebView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';")
        liveFeedWebView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.textAlign = 'center';")
        liveFeedWebView.stringByEvaluatingJavaScript(from: "document.getElementById('mapid').style.margin = 'auto';")
    }

    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
