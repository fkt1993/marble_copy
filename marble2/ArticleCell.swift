//
//  ArticleCell.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/06/28.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var articleImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(article :Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.body
        userLabel.text = article.userData.userName
        
        let format = NSDateFormatter()
        format.locale = NSLocale(localeIdentifier: "ja_JP")
        format.dateFormat = "yyyy/MM/dd"
        dateLabel.text = format.stringFromDate(article.published)
        
        let url = NSURL(string:article.thumbOriginal)
        let req = NSURLRequest(URL:url!)
        NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
            let image = UIImage(data:data!)
            self.articleImg.image = image
        }

    }
    func setCell2(article :LikeArticle) {
        titleLabel.text = article.title
        descriptionLabel.text = article.body
        userLabel.text = article.user_userName
        
        let format = NSDateFormatter()
        format.locale = NSLocale(localeIdentifier: "ja_JP")
        format.dateFormat = "yyyy/MM/dd"
                dateLabel.text = format.stringFromDate(article.published)
        
                let url = NSURL(string:article.thumbOriginal)
                let req = NSURLRequest(URL:url!)
                NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
                    let image = UIImage(data:data!)
                    self.articleImg.image = image
        }
        
    }

}
