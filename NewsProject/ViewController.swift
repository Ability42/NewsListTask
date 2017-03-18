//
//  ViewController.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/18/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        // Test Server Manager
        
        
        let APIkey = "06ec29c6902c4616a382357a1ee918b4"
        let stringURL = "https://newsapi.org/v1/articles?source=the-next-web&sortBy=latest&apiKey=\(APIkey)"
        let manager = ServerManager.sharedManager
        
        
        
        manager.testRequest(source: stringURL) { (data) in
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            
            let articles = json["articles"] as? [[String : Any]]
            var authors = [String]()
            
            for article in articles! {
                if let author = article["author"] as? String {
                    authors.append(author)
                }
            }
            print(authors)
        }

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

