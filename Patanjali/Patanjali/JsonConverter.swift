//
//  JsonConverter.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import Foundation
class JsonConverter: NSObject
{
    class var sharedInstance: JsonConverter
    {
        struct Static
        {
            static let instance: JsonConverter = JsonConverter()
        }
        return Static.instance
    }
    
    func convertLoginObject(toJson objStruct: structLogin) -> Data
    {
        var maindic = [String:String]()
        maindic["userId"] = objStruct.strUserId
        maindic["password"] = objStruct.strPassword
        
        let encoder = JSONEncoder()
        let data = try! encoder.encode(maindic)
        return data
    }
   
    func getBannersData(withData arrData:NSArray) -> NSMutableArray
    {
        let arrBannersData : NSMutableArray = []
        for  dic: Any in arrData
        {
            if dic is NSDictionary
            {
                let dicData = dic as! NSDictionary
                
                let objStruct = structPromotionBanners()

                objStruct.strId = (dicData.safeObjectForKey(key: "id") as! NSNumber).stringValue
                objStruct.strTitle = dicData.safeObjectForKey(key: "title") as? String
                 objStruct.strBannerUrl = dicData.safeObjectForKey(key: "bannerUrl") as? String
                objStruct.strBannerUrl = objStruct.strBannerUrl?.replacingOccurrences(of: " ", with: "%20")

                objStruct.strDescription = dicData.safeObjectForKey(key: "description") as? String
                objStruct.strDisplayOrder = dicData.safeObjectForKey(key: "displayOrder") as? String
              
                objStruct.intCreatedDate = dicData.safeObjectForKey(key: "createdDate") as? NSInteger
                objStruct.intUpdateDate = dicData.safeObjectForKey(key: "intUpdateDate") as? NSInteger
                objStruct.isActive = (dicData.safeObjectForKey(key: "isActive") != nil)
                arrBannersData .add(objStruct)
            }
       }
        return arrBannersData
    }
}
