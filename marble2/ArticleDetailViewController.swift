//
//  ArticleDetailViewController.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/07/04.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Realm
import RealmSwift

class ArticleDetailViewController: UIViewController {
    
    let apiManager: ApiManager = ApiManager.sharedInstance
    
    var article: Article!
    
    @IBOutlet weak var bodyDetail: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var likeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(article)
        bodyDetail.text = article.body
        titleDetail.text = article.title
        let url = NSURL(string:article.thumbOriginal)
        let req = NSURLRequest(URL:url!)
        NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
            let image = UIImage(data:data!)
            self.imgDetail.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addLike(sender: AnyObject) {

        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 2) {
                }
        })
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()

        let likeArticle = LikeArticle()
        likeArticle.id = article.id
        likeArticle.title = article.title
        likeArticle.body = article.body
        likeArticle.categoryId = article.categoryId
        likeArticle.itemOrder = article.itemOrder
        likeArticle.modified = article.modified
        likeArticle.onePage = article.onePage
        likeArticle.provider = article.provider
        likeArticle.published = article.published
        likeArticle.thumb = article.thumb
        likeArticle.thumbOriginal = article.thumbOriginal
        likeArticle.thumbStatus = article.thumbStatus
        likeArticle.thumbNormal = article.thumbNormal
        likeArticle.thumbUpdated = article.thumbUpdated
        likeArticle.user_id = article.userData.id
        likeArticle.user_screenName = article.userData.screenName
        likeArticle.user_userName = article.userData.userName
        
        try! realm.write({
            realm.add(likeArticle, update: true)
        })
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