//
//  LiveViewController.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 3/27/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit


class LiveViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var liveFeedWebView: UIWebView!
   
    
    let liveFeedURL = "http://qt.csumb.edu:1935/live/encoder3.sdp/playlist.m3u8"

    var streamOnce: Bool?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.liveFeedWebView.delegate = self
        
        let url = URL(string: liveFeedURL)
        //
        if UIApplication.shared.canOpenURL(url!){
            
            print("URL Works")
            
            if let unwrapURL = url{
                
                let request = URLRequest(url: unwrapURL)
                let session = URLSession.shared
                
                let task = session.dataTask(with: unwrapURL, completionHandler: { (data, response, error) in
                    
                    
                    if data != nil{
                        
                        //Update the Web View to the main thread
                        DispatchQueue.main.async {
                            
                            self.liveFeedWebView.loadRequest(request)
                            
                            self.streamOnce = true
                        }
                    }
                    else{
                        
                        print("Error loading Live Stream \(String(describing: error))")
                        
                        DispatchQueue.main.async {
                            
                            
                            self.showAlert(title: "Error", message: "Live Feed is Unavailable at this time")
                        }
                    }
                })
                
                task.resume()
            }
            
            
        }
        else{
            
            print("URL does not work")
            self.showAlert(title: "Error", message: "Live Feed is Unavailable at this time")
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
        print("MAde it to finish \n")
        liveFeedWebView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';")
        liveFeedWebView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.textAlign = 'center';")
        liveFeedWebView.stringByEvaluatingJavaScript(from: "document.getElementById('mapid').style.margin = 'auto';")
        
        
        //self.loadingActivityIndicator.stopAnimating()
        print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")

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
