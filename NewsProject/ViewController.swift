//
//  ViewController.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/18/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var articlesArray = [Article]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var articleCell: UITableViewCell!
    

    
    override func loadView() {
        super.loadView()
        
        // Test Server Manager
        let APIkey = "06ec29c6902c4616a382357a1ee918b4"
        let stringURL = "https://newsapi.org/v1/articles?source=the-next-web&sortBy=latest&apiKey=\(APIkey)"
        let manager = ServerManager.sharedManager
        
        
        manager.testRequest(source: stringURL) { (data) in
            DispatchQueue.main.async {
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                
                let articles = json["articles"] as? [[String : Any]]
                for article in articles! {
                    let articleObj = Article(response: article as! [String : String])
                    self.articlesArray.append(articleObj)
                    self.tableView.reloadData()
                }

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // test
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseID = "articleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! ArticleTableViewCell
        
        let row = indexPath.row
        print(indexPath.row)
        let articleObj = self.articlesArray[row]
        
        // Setup Cell
        cell.authorLabel.text = articleObj.kAuthor
        cell.dateLabel.text = articleObj.KPublishedAt
        cell.descriptionLabel.text = articleObj.kDescription
        cell.titleLabel.text = articleObj.kTitle
        
        // test
        print(cell.authorLabel.text ?? -1)
        print(cell.descriptionLabel.text ?? -1)
        
        
        
        return cell
    }
  
}

