//
//  ViewController.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/18/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var articlesArray = [Article]()
    
    
    override func loadView() {
        super.loadView()
        
        // Test Server Manager
        
        
        let APIkey = "06ec29c6902c4616a382357a1ee918b4"
        let stringURL = "https://newsapi.org/v1/articles?source=the-next-web&sortBy=latest&apiKey=\(APIkey)"
        let manager = ServerManager.sharedManager
        
        
        manager.testRequest(source: stringURL) { (data) in
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            
            let articles = json["articles"] as? [[String : Any]]
            for article in articles! {
                let articleObj = Article(response: article as! [String : String])
                self.articlesArray.append(articleObj)
            }
            print(self.articlesArray.count)
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

