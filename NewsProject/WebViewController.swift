//
//  WebViewController.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/29/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        let viewShift: Int = 64

        
        let webViewConfig = WKWebViewConfiguration()

        let webViewRect = CGRect(x: 0, y: viewShift, width: Int(view.bounds.width), height: Int(view.bounds.height))
        
        webView = WKWebView(frame: webViewRect, configuration: webViewConfig)
        
        webView.uiDelegate = self
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

}
