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
    func checkNet() -> Bool
    {
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
func setRandomFont(withSize size : CGFloat, withFontName fontName: String) -> UIFont
{
    var font : UIFont!
    if SCREEN_HEIGHT ==  CGFloat(IPHONE_4_SCREEN_HEIGHT)
    {
        font = UIFont(name: fontName, size: size)!
    }
    else if (SCREEN_HEIGHT == CGFloat(IPHONE_5_SCREEN_HEIGHT)) // iPhone 5,5S, SE
    {
        font = UIFont(name: fontName, size: size+1)!
    }
    else if (SCREEN_WIDTH == CGFloat(IPHONE_6_SCREEN_WIDTH)) // iPhone 6, 6S, 7
    {
        font = UIFont(name: fontName, size: size+2)!
    }
    else if (SCREEN_WIDTH == CGFloat(IPHONE_6PLUS_SCREEN_WIDTH)) // iPhone 6 Plus, 6s Plus, 7 Plus
    {
        font = UIFont(name: fontName, size: size+4)!
    }
    else if (SCREEN_WIDTH == CGFloat(768)) // iPad
    {
        font = UIFont(name: fontName, size: size+5)!
    }
    else
    {
        font = UIFont(name: fontName, size: size+4)!
    }
    return font
}


func toastLabel(context ctx: UIViewController, msg: String)
{
    
    let heightOfLbl: CGFloat = heightForView(text: msg, font: UIFont.systemFont(ofSize: 20), width: ctx.view.frame.size.width - 80)
    let toast = UILabel(frame:
        CGRect(x: 40, y: ctx.view.frame.size.height-heightOfLbl-100,
               width: ctx.view.frame.size.width - 80, height: heightOfLbl))
    
    toast.backgroundColor = UIColor.lightGray
    toast.textColor = UIColor.white
    toast.textAlignment = .center;
    toast.numberOfLines = 0
    toast.font = UIFont.systemFont(ofSize: 16)
    toast.layer.cornerRadius = 6;
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
func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    
    return label.frame.height
}
/*
 extension UILabel
 {
 var optimalHeight : CGFloat
 {
 get
 {
 let label = UILabel(frame:CGRect(x:0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
 label.numberOfLines = 0
 label.lineBreakMode = self.lineBreakMode
 label.font = self.font
 label.text = self.text
 
 label.sizeToFit()
 
 return label.frame.height
 }
 }
 }
 */

func setAttrStrForProductUnits(str1: String, str2: String ) -> NSAttributedString
{
    let str1Attributes: [NSAttributedStringKey : Any] = [
        NSAttributedStringKey.font: setRandomFont(withSize: 13.0, withFontName: FONTOPENSANS_REGULAR),
        NSAttributedStringKey.foregroundColor: UIColor.black]
    
    let str2Attributes: [NSAttributedStringKey : Any] = [
        NSAttributedStringKey.font: setRandomFont(withSize: 9.0, withFontName: FONTOPENSANS_REGULAR),
        NSAttributedStringKey.foregroundColor: COLORTEXT_GRAY]
    
    let attString = NSMutableAttributedString()
    attString.append(NSAttributedString(string:str1, attributes: str1Attributes))
    attString.append(NSAttributedString(string:str2, attributes: str2Attributes))
    
    return attString
}


