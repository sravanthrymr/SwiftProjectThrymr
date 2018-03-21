//
//  ProductCategoryController.swift
//  Patanjali
//
//  Created by Thrymr on 21/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit

class ProductCategoryController: UIViewController {
    
    @IBOutlet weak var imgViewHome: UIImageView!
    @IBOutlet weak var bgView: UIView?
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var placeHolderView: UIView?
    @IBOutlet weak var tableView: UITableView!
    
    var str:NSString!
    var open: Bool! = false
    
    
    class var sharedInstance: ProductCategoryController
    {
        struct Static
        {
            static let instance: ProductCategoryController = ProductCategoryController()
        }
        return Static.instance
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK : To open side menu
    func openMenu()
    {
        if (!self.open)
        {
            self.open = true;
            self.view.alpha = 0;
            UIApplication .shared .keyWindow? .addSubview(self.view)
            UIView .animate(withDuration: 0.5, animations: {
                self.view.alpha = 1
                self.view.backgroundColor = UIColor.clear
                let frame: CGRect = self.view.frame
                var newFrame: CGRect = frame
                newFrame.origin.x = 0;
                self.view.frame = newFrame;
                self.bgView?.transform = CGAffineTransform.identity
            })
            self.placeHolderView?.isHidden = false
        }
    }
    // MARK : To close the side menu
    func closeMenu() {
        if (self.open)
        {
            self.open = false
            UIView .animate(withDuration: 0.5, animations: {
                
                let screenWidth: CGFloat  = SCREEN_WIDTH
                let frame: CGRect = self.view.frame
                var newFrame: CGRect = frame
                newFrame.origin.x = -screenWidth
                self.view.frame = newFrame;
                self.bgView?.transform = CGAffineTransform.init(translationX: -SCREEN_WIDTH, y: 0)
            }, completion: { (finished) in
                self.view .removeFromSuperview()
            })
            self.placeHolderView?.isHidden = true;
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
