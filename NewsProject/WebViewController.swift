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
    var urlToLoad: String?
    
    override func loadView() {
        super.loadView()
        self.configureWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: URL(string: urlToLoad!)!)
        webView.load(myRequest)
    }
    
    func configureWebView() {
        
        let viewShift: Int = 64
        let webViewConfig = WKWebViewConfiguration()
        let webViewRect = CGRect(x: 0, y: viewShift, width: Int(view.bounds.width), height: Int(view.bounds.height))
        
        webView = WKWebView(frame: webViewRect, configuration: webViewConfig)
        webView.uiDelegate = self
        view.addSubview(webView)
    }
    
    func setupConstrains() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "closeWebVC" {
            self.webView.stopLoading()
            self.webView.uiDelegate = nil
            self.webView.removeFromSuperview()
        }
    }

}
