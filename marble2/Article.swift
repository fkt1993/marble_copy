//
//  Article.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/06/28.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

struct Article {
    
    let title: String
    let body: String
    let categoryId: Int
    let itemOrder: String
    let modified: Int
    let onePage: Int
    let provider: String
    let published: Int
    let thumb: String
    let thumbNormal: String
    let thumbOriginal: String
    let thumbStatus: Int
    let thumbUpdated: NSDate
    let userData: User
    
    init(json: JSON) {
        let article = json["Article"]
        title = article["title"].stringValue
        body = article["body"].stringValue
        categoryId = article["category_id"].intValue
        itemOrder = article["item_order"].stringValue
        modified = article["modified"].intValue
        onePage = article["one_page"].intValue
        provider = json["provider"].stringValue
        published = article["published"].intValue
        thumb = article["thumb"].stringValue
        thumbNormal = article["thumb_normal"].stringValue
        thumbOriginal = article["thumb_original"].stringValue
        thumbStatus = article["thumb_status"].intValue
        thumbUpdated = NSDate.dateFromString(article["thumb_updated"].stringValue) ?? NSDate()
        userData = User(json: json["User"])
    }
}
struct ArticleSerializer: ResponseSerializerType {
    
    typealias SerializedObject = (max: Int, articles: [Article])
    typealias ErrorObject = NSError
    
    var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Result<SerializedObject, ErrorObject> = { (request, response, data, error) in
        
        if let error = error {
            return Result.Failure(error)
        }
        
        guard let responseData = data else {
            return Result.Failure(Utils.createErrorObject("データの取得に失敗しました"))
        }
        
        let json = JSON(data: responseData)
        
        if let message = json["message"].string {
            return Result.Failure(Utils.createErrorObject(message))
        }
        
        let max = json["meta"]["count"].int ?? 0
        let articles = json["results"].arrayValue.map { Article(json: $0) }
        
        return Result.Success((max, articles))
    }
}
