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

class ArticleDetailViewController: UIViewController {
    
    let apiManager: ApiManager = ApiManager.sharedInstance
    var article: Article?
    
    @IBOutlet weak var bodyDetail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bodyDetail.text = article?.body
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
