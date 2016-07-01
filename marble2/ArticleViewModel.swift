//
//  ArticleViewModel.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/06/28.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import Foundation
import UIKit
import BrightFutures
import SwiftyJSON
import Alamofire

class ArticleViewModel: NSObject {
    
    var max: Int = 0
    private let apiManager = ApiManager.sharedInstance

    func fetchArticleList(params: [String: AnyObject]) -> Future<(Int,[Article]), NSError>  {
        let serializer = ArticleSerializer()
        let url = APIUrl.articleList
        
        return apiManager.get(url, params: params,serializer:serializer)
    }

}
