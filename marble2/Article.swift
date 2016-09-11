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
import RealmSwift
import Realm

struct Article {
    
    let id: Int
    let title: String
    let body: String
    let categoryId: Int
    let itemOrder: String
    let modified: Int
    let onePage: Int
    let provider: String
    let published: NSDate
    let thumb: String
    let thumbNormal: String
    let thumbOriginal: String
    let thumbStatus: Int
    let thumbUpdated: NSDate
    let userData: User
    
    init(json: JSON) {
        let article = json["Article"]
        id = article["id"].intValue
        title = article["title"].stringValue
        body = article["body"].stringValue
        categoryId = article["category_id"].intValue
        itemOrder = article["item_order"].stringValue
        modified = article["modified"].intValue
        onePage = article["one_page"].intValue
        provider = json["provider"].stringValue
        published = NSDate.dateFromString(article["published"].stringValue) ?? NSDate()
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
class Book : Object {
    dynamic var isbn = ""
    dynamic var name = ""
    dynamic var price = 0
}
class LikeArticle : Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var body = ""
    dynamic var categoryId = 0
    dynamic var itemOrder = ""
    dynamic var modified = 0
    dynamic var onePage = 0
    dynamic var provider = ""
    dynamic var published =  NSDate()
    dynamic var thumb = ""
    dynamic var thumbNormal = ""
    dynamic var thumbOriginal = ""
    dynamic var thumbStatus = 0
    dynamic var thumbUpdated = NSDate()
    dynamic var user_id = 0
    dynamic var user_screenName = ""
    dynamic var user_userName = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
//class User: Object {
//    dynamic var age = 0
//}

//class TestData: Object {
//    dynamic var flag = true
//    dynamic var byte: Int8 = 0
//    dynamic var short: Int16 = 0
//    dynamic var long: Int32 = 0
//    dynamic var longlong: Int64 = 0
//    dynamic var double: Double = 0
//    dynamic var float: Float = 0
//    
//    dynamic var string: String = ""
//    dynamic var date = NSDate()
//    dynamic var data = NSData()
//}