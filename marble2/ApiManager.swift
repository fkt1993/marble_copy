//
//  File.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/06/25.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import BrightFutures

@objc class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    private let baseURL:String = "http://api.topicks.jp"
    
    
    func article_list(){
        let url = baseURL + "/api/v1/articles/list.json?search_type=category"
        Alamofire.request(Alamofire.Method.GET, url)
            .validate()
            .responseJSON {response in
                switch response.result {
                case .Success(let articles):
                    print(articles)
//                    let json = JSON(articles)
//                    if let message = json["message"].string {
//                        reject(self.createError(message))
//                        return
                    
                    
//                    fulfill(articles)
                case .Failure(let error):
                    print(error)
//                    reject(error)
                
            }
        }

//            .responseJSON { response in
//                print("aaa")
//                print(url)
//                print(response.result)
//            }
    }
    
    func get<T: ResponseSerializerType>(url: URLStringConvertible, params: [String: AnyObject], serializer: T) -> Future<T.SerializedObject, T.ErrorObject> {
        let promise = Promise<T.SerializedObject, T.ErrorObject>()
        
        Alamofire.request(.GET, url, parameters: params)
            .validate()
            .response(responseSerializer: serializer) { response in
                switch response.result {
                case .Success(let r):
                    promise.success(r)
                    
                case .Failure(let error):
                    promise.failure(error)
                }
        }
        return promise.future
    }
}

