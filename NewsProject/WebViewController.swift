//
//  WebViewController.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/29/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(URLRequest(url: URL(string: url!)!))
        print(url ?? -1)
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
