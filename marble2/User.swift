//
//  User.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/06/28.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RealmSwift
import Realm

struct User {
    
    let id: Int
    let screenName: String
    let userName: String
    
    init(id: Int, screenName: String, userName: String) {
        self.id = id
        self.screenName = screenName
        self.userName = userName
    }
    
    init(json: JSON) {
        id = json["id"].int ?? 0
        screenName = json["screenname"].string ?? ""
        userName = json["username"].string ?? ""
    }
}
class LikeUser: Object {
    dynamic var id = 0
    dynamic var screenName = ""
    dynamic var userName = ""
}
