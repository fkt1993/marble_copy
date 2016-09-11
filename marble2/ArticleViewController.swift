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
    private var articleCount: Int = 0
    
    var nowLoading: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "marble" //ナビゲーションバーのタイトル
        tableView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let params: [String: AnyObject] = [
            "search_type": "category",
            "limit": 30
        ]
        
        viewmodel.fetchArticleList(params)
            .onSuccess { [weak self] data in
                self?.articles = data.1
                self?.articleCount = (self?.articleCount)! + 30
                self?.tableView.reloadData()
            }
            .onFailure { [weak self] error in
                    self?.showErrorAlert(error.localizedDescription, completion: nil)
        }

        
        
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return articles?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell") as! ArticleCell

        if let _ = articles?[indexPath.row]{
            cell.setCell(articles![indexPath.row])
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboad: UIStoryboard = UIStoryboard(name: "ArticleDetail", bundle: nil)
        if let nextVC: ArticleDetailViewController = storyboad.instantiateViewControllerWithIdentifier("ArticleDetail") as? ArticleDetailViewController{
            nextVC.article = articles![indexPath.row]
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView){
        if self.nowLoading {
            return
        }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        let o = maximumOffset - currentOffset
        
        if o <= 200 {//一番下までスクロールしたら
            self.nowLoading = true
            let params: [String: AnyObject] = [
                "search_type": "category",
                "offset": self.articleCount,
                "limit": 30
            ]
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
            
            viewmodel.fetchArticleList(params)
                .onSuccess { [weak self] data in
                    self?.articles = self?.mergeArticles(data.1)
                    print(self?.articles)
                    UIView.animateWithDuration(0.3, animations: {
                        guard let before = self?.tableView.contentSize.height else{
                            return
                        }
                        self?.tableView.reloadData()
                        guard let after = self?.tableView.contentSize.height else{
                            return
                        }
                        if(before<after) {
                            self?.tableView.contentOffset.y = after - before
                        }
                        self?.articleCount = (self?.articleCount)! + 30
                        self?.nowLoading = false
                    })
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
                .onFailure { [weak self] error in
                    self?.showErrorAlert(error.localizedDescription, completion: nil)
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }

        }
        
        
    }
    private func mergeArticles(articles: [Article]) -> [Article] {
        
        if let _ = self.articles {
            let newArticles = self.articles! + articles
            return newArticles
        }else{
            return articles
        }
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