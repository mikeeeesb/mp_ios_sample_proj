//
//  WebViewController.swift
//  mp_ios_sample_proj
//
//  Created by mike on 8/6/17.
//  Copyright © 2017 mp. All rights reserved.
//

import UIKit

class WebViewController : UIViewController {
    
    var webView : UIWebView!
    
    override func viewDidLoad() {
        webView = UIWebView()
        
        webView.loadRequest(URLRequest.init(url: URL.init(string: "http://apple.com")!))
        
        view = webView
    }
}
