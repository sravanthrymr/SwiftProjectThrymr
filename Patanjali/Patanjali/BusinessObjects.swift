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
    var strImageName = ""
    var strId  = ""
    var intCreatedDate  = 0
    var intUpdateDate  = 0
    
    var strTitle = ""
    var strBannerUrl = ""
    var strDescription = ""
    var strDisplayOrder = ""
    var isActive = false
    var structCategory : structCategories?
    var structSubCategory: structCategories?
}
class structCategories: NSObject
{
    var isSelected = false
    var isActive = false
    var isArticle = false
    
    var createdDate = 0
    var updateDate = 0
    
    var strFileUrl = ""
    var strIconUrl = ""
    var strName = ""
    var strId = ""
    var strDescription = ""
    
    var arrProducts : NSMutableArray = []
    var dataImage : Data?
}
