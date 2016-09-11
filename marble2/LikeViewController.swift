//
//  LikeViewController.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/07/28.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class LikeViewController: UIViewController {

    @IBOutlet weak var likeView: UITableView!
    private let viewmodel = ArticleViewModel()
    private let apiManager: ApiManager = ApiManager.sharedInstance
    private var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Like" //ナビゲーションバーのタイトル
        likeView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        likeView.rowHeight = UITableViewAutomaticDimension
        likeView.estimatedRowHeight = 100
        
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 2) {
                }
        })
        
        Realm.Configuration.defaultConfiguration = config

        let realm = try! Realm()
//        let likeArticles = realm.objects(LikeArticle)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        likeView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        let realm = try! Realm()
        let likeArticles = realm.objects(LikeArticle)
        return likeArticles.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell") as! ArticleCell
        
        let realm = try! Realm()
        let likeArticles = realm.objects(LikeArticle)
        let likeArticle = likeArticles[indexPath.row]
            cell.setCell2(likeArticle)
        return cell
    }

    private func showErrorAlert(message: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "MARBLE",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: completion))
        presentViewController(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
