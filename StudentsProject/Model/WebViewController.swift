//
//  WebViewController.swift
//  StudentsProject
//
//  Created by Egor on 18.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    var profile: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .cyan
        self.title = "Profile viewer"
        print("WebView loading start")
        
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        webView.center = self.view.center
        self.view.addSubview(webView)
        
        let url = URL(string: self.profile!)
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }

}
