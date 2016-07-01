//
//  File.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/07/01.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import UIKit

class Utils {
    
    static func createErrorObject(message: String, code: Int = 100) -> NSError {
        let domain = "jp.co.candle.app.marble"
        
        return NSError(domain: domain, code: 100, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    static func createViewController<T: UIViewController>(viewControllerIdentifier identifier: String,viewControllerType type: T) -> T? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(identifier) as? T
    }
    
}
