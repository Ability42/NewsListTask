//
//  ViewController.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/18/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var activityIndicatorView: UIActivityIndicatorView!
    var articlesArray: [Article]? = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var articleControl: UISegmentedControl!
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.articleControl.selectedSegmentIndex == 0 {
            fetchArticlesWithFilter(filter: "top")

        } else {
            fetchArticlesWithFilter(filter: "latest")

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.articlesArray?.count)! <= 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            activityIndicatorView.startAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        activityIndicatorView.startAnimating()
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
        
        let source = "techcrunch"
        let APIkey = "06ec29c6902c4616a382357a1ee918b4"
        let stringURL = "https://newsapi.org/v1/articles?source=\(source)&sortBy=\(filter)&apiKey=\(APIkey)"
        
        let manager = ServerManager.sharedManager
        
        manager.makeRequest(source: stringURL) { (data) in
                
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
    
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 180
        tableView.contentInset.bottom = 80
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView.backgroundView = activityIndicatorView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // pushViewController
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        webVC.urlToLoad = self.articlesArray?[indexPath.item].kUrl
        self.navigationController?.pushViewController(webVC, animated: true)
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












