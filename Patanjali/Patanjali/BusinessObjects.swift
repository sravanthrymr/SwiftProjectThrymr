//
//  BusinessObjects.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import Foundation

class structLogin: NSObject
{
    var strUserId = ""
    var strPassword  = ""
}

class structPromotionBanners: NSObject
{
    var strImageName :  String?
    var strId :  String?
    var intCreatedDate  : NSInteger? = 0
    var intUpdateDate  : NSInteger? = 0
    
    var strTitle:  String?
    var strBannerUrl :  String?
    var strDescription:  String?
    var strDisplayOrder :  String?
    var isActive : Bool? = false
    var structCategory : structCategories?
    var structSubCategory: structCategories?
}
class structCategories: NSObject
{
    var isSelected  : Bool = false
    var isActive  : Bool = false
    var isArticle  : Bool = false
    
    var createdDate : NSInteger = 0
    var updateDate : NSInteger = 0
    
    var strFileUrl :  String?
    var strIconUrl :  String?
    var strName :  String?
    var strId :  String?
    var strDescription :  String?
    
    var arrProducts : NSMutableArray?
    var dataImage : Data?
}
