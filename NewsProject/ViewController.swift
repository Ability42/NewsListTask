//
//  ViewController.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/18/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var articlesArray: [Article]? = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var articleControl: UISegmentedControl!
    
    override func loadView() {
        super.loadView()
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 180
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.articleControl.selectedSegmentIndex == 0 {
            fetchArticlesWithFilter(filter: "top")

        } else {
            fetchArticlesWithFilter(filter: "latest")

        }
        
    }
    
    @IBAction func filterApply(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.articlesArray?.removeAll()
            fetchArticlesWithFilter(filter: "top")
            
        } else if sender.selectedSegmentIndex == 1 {
            self.articlesArray?.removeAll()
            fetchArticlesWithFilter(filter: "latest")
        }
    }
    
    func fetchArticlesWithFilter(filter: String) {
        // Test Server Manager
        
        let source = "reuters"
        let APIkey = "06ec29c6902c4616a382357a1ee918b4"
        let stringURL = "https://newsapi.org/v1/articles?source=\(source)&sortBy=\(filter)&apiKey=\(APIkey)"
        
        let manager = ServerManager.sharedManager
        
        
        manager.testRequest(source: stringURL) { (data) in
                
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            let jsonArticles = json["articles"] as? [[String : Any]]
            
            for article in jsonArticles! {
                let articleObj = Article(withServer: article)
                self.articlesArray?.append(articleObj)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.articlesArray?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseID = "articleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! ArticleTableViewCell
        
        // Setup cell controls
        cell.titleLabel.text = self.articlesArray?[indexPath.item].kTitle
        cell.authorLabel.text = self.articlesArray?[indexPath.item].kAuthor
        cell.descriptionLabel.text = self.articlesArray?[indexPath.item].kDescription
        cell.dateLabel.text = self.articlesArray?[indexPath.item].KPublishedAt
        cell.photoImageView.image = self.articlesArray?[indexPath.item].kImage
        
        cell.photoImageView.layer.masksToBounds = true;
        
        return cell

    }
  
}












