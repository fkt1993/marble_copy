//
//  ArticleViewController.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/06/27.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ArticleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    private let viewmodel = ArticleViewModel()
    private let apiManager: ApiManager = ApiManager.sharedInstance
    private var articles: [Article]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params: [String: AnyObject] = [
            "search_type": "category",
            "limit": 30
        ]
        
        viewmodel.fetchArticleList(params)
            .onSuccess { [weak self] data in
                self?.articles = data.1
                self?.tableView.reloadData()
            }
            .onFailure { [weak self] error in
                    self?.showErrorAlert(error.localizedDescription, completion: nil)
        }
        tableView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")

        
        
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        switch articles {
        case let .Some(articles):
            return articles.count
            
        case .None:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("index" ,forIndexPath: indexPath) as! ArticleCell
        return cell
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func showErrorAlert(message: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "MARBLE",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: completion))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}