//
//  ViewController.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/06/25.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    let imgArray: NSArray = ["http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg",
                             "http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg",
                             "http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg",
                             "http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg",
                             "http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg",
                             "http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg",
                             "http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg",
                             "http://articleimage.nicoblomaga.jp/image/56/2015/8/c/8c621fe2a6cf4e3526e4b8602786a808f9a897ac1423975008.jpg"]
    
    let titleArray: NSArray = ["ああ","あああ","ああああ","いいい",
                                "ううう","え","ええ","お"]
    let descriptionArray: NSArray = ["あsdf","あsdふぁdsf","あsdふぁdsふぁsdf","あsdふぁsdふぁdsf",
                                "sdfsdhsfgs","sfgsdfgsfdgs","sdfgsdfg","sdfgsdfgsd"]
    let dateArray: NSArray = ["2013/8/23/16:04","2013/8/23/16:15","2013/8/23/16:47","2013/8/23/17:10",
                                "2013/8/23/1715:","2013/8/23/17:21","2013/8/23/17:33","2013/8/23/17:41"]
    let userArray: NSArray = ["a","b","c","d",
                                "e","f","g","h"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let ApiManager:NSObject= ApiManager()
        let apiManager = ApiManager()
        apiManager.article_list()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("index" ,forIndexPath: indexPath)
        
        

        
        let title = tableView.viewWithTag(1) as! UILabel
        title.text = "\(titleArray[indexPath.row])"
        let description = tableView.viewWithTag(2) as! UILabel
        description.text = "\(descriptionArray[indexPath.row])"
        let date = tableView.viewWithTag(3) as! UILabel
        date.text = "\(dateArray[indexPath.row])"
        let user = tableView.viewWithTag(4) as! UILabel
        user.text = "\(userArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        print(titleArray[indexPath.row])
        // [indexPath.row] から画像名を探し、UImage を設定
//        let selectedTitle = titleArray[indexPath.row]
//        if let selectedTitle = nil {
            // SubViewController へ遷移するために Segue を呼び出す
        performSegueWithIdentifier("toArticleViewController",sender: nil)
//        }
        
    }
    
    // Segue 準備
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if (segue.identifier == "toArticleViewController") {
//            let AVC: ArticleViewController = segue.destinationViewController as! ArticleViewController
//            AVC.title = selectedTitle
//        }
//    }


}

