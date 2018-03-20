//
//  Utils.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import Foundation
import UIKit

extension NSObject
{
    func checkNet() -> Bool {
        let reachability = Reachability()
        let status = reachability?.connection
        print("Connection status:",status! )
        switch status{
        case .wifi?:
            print("Reachable via WiFi")
            return true
        case .cellular?:
            print("Reachable via Cellular")
            return true
        case .none:
            print("Network not reachable")
            return false
        case .some(.none):
            print("Network not reachable")
            return false
        }
    }
    
}
extension NSObject
{
    func safeObjectForKey(key : String) -> Any?
    {
        if self.value(forKey: key) is NSNull
        {
            return nil
        }
        else
        {
            return self.value(forKey: key)
        }
    }
}
 func popUp(context ctx: UIViewController, msg: String) {
    let toast = UILabel(frame:
        CGRect(x: 16, y: ctx.view.frame.size.height-120,
               width: ctx.view.frame.size.width - 32, height: 60))
    
    toast.backgroundColor = UIColor.lightGray
    toast.textColor = UIColor.white
    toast.textAlignment = .center;
    toast.numberOfLines = 0
    toast.font = UIFont.systemFont(ofSize: 18)
    toast.layer.cornerRadius = 12;
    toast.clipsToBounds  =  true
    
    toast.text = msg
    
    ctx.view.addSubview(toast)
    
    UIView.animate(withDuration: 3.0, delay: 0.2,
                   options: .curveEaseOut, animations: {
                    toast.alpha = 0.0
    }, completion: {(isCompleted) in
        toast.removeFromSuperview()
    })
}
/*extension UILabel {
    
    func autoresize() {
        if let textNSString: NSString = self.text! as? NSString {
            let rect = textNSString.boundingRect(with: CGSize(width:self.frame.size.width, height: CGFloat.greatestFiniteMagnitude),
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSAttributedStringKey.font: self.font],
                                                         context: nil)
            self.frame = CGRect(x:self.frame.origin.x, y:self.frame.origin.y,width:self.frame.size.width,height:rect.height)
        }
    }
    
}
 */

