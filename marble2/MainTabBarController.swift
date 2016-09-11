//
//  MainTabBarController.swift
//  marble2
//
//  Created by 深津裕樹 on 2016/07/26.
//  Copyright © 2016年 深津裕樹. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController{

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tabBar.translucent = true
    }
    
    override func viewDidLoad() {
        let homeStoryboard = UIStoryboard(name: "Article", bundle: nil)
        let likeStoryboard = UIStoryboard(name: "Like", bundle: nil)
        
        let articleContainerController = homeStoryboard.instantiateInitialViewController() as! ArticleContainerController
        let articleContainer2Controller = likeStoryboard.instantiateInitialViewController() as! ArticleContainerController
        let viewControllers = [articleContainerController,articleContainer2Controller]
        self.setViewControllers(viewControllers, animated: false)
        super.viewDidLoad()

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
