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
    var structCategory = structCategories()
    var structSubCategory = structCategories()
}
class structCategories: NSObject
{
    var isSelected  : Bool? = false
    var isActive  : Bool? = false
    var isArticle  : Bool? = false
    
    var createdDate : NSInteger? = 0
    var updateDate : NSInteger? = 0
    
    var strFileUrl :  String?
    var strIconUrl :  String?
    var strName :  String?
    var strId :  String?
    var strDescription :  String?
    
    var arrProducts : NSMutableArray = []
    var dataImage : Data?
}
class structLandingPage: NSObject
{
    var isSelected  : Bool? = false
    
    var intId : NSInteger? = 0
    
    var strTitle :  String?
    var strCategory :  String?
    
    var arrProducts : NSMutableArray = []
}
class structProduct : NSObject
{
    var isActive : Bool? = false
    var isConfigurable : Bool? = false
    var isLatest : Bool? = false
    var isFeatured : Bool? = false
    var isBestSeller : Bool? = false
    var isUpcoming : Bool? = false
    var isWishList : Bool? = false
    var isCart : Bool? = false
    var intStock : Int? = 0
    
    var  idValue : NSInteger? = 0
    var  idWishlist : NSInteger? = 0
    var  currentDate : NSInteger? = 0
    var  updateDate : NSInteger? = 0
    var  wishListCurrentDate : NSInteger? = 0
    var  wishListUpdateDate : NSInteger? = 0
    
    var  price : Float? = 0.0
    var  discount : Float? =  0.0
    
    var quantity : Int? = 0
    var intRelatedProductsTotalCount : Int? = 0
    var intRelatedProductsPageSize : Int? = 0
    var intRelatedProductsPageNumber : Int? = 0
    var cartQunatity : Int? = 0
    var gstRate : Float? =  0.0
    var totalAmount : Float? =  0.0
    
    var name :  String?
    var sku :  String?
    var smallDescription :  String?
    var longDescription :  String?
    var weight :  String?
    var weightUnit :  String?
    var metaTitle :  String?
    var metaKeywords :  String?
    var metaDescription :  String?
    var sapCode :  String?
    var hsnClassification :  String?
    var barCode :  String?
    var benefits :  String?
    var ingredients :  String?
    var howToUse :  String?
    var shareUrl :  String?
    
    var arrProductImages : NSMutableArray = []
    var arrReviews : NSMutableArray = []
    var arrProductSizeConfigarations : NSMutableArray = []
    var arrProductRelated : NSMutableArray = []
    var arrBoughtToGether : NSMutableArray = []
    var indexpathSelected :  NSIndexPath?
    
    var objStructManufacturer : structManufacturer = structManufacturer()
    var structCategory : structCategories =  structCategories()
    var structSubCategory : structCategories = structCategories()
    var structOveralrating : structReviewSummery = structReviewSummery()
}
class structManufacturer: NSObject
{
    var strTitle :  String?
    var strAddress :  String?
    var strEmail :  String?
}
class structReviewSummery: NSObject
{
    var averageRating : Float? = 0.0
    var overallRatings : Int? = 0
    var overallReviews : Int? = 0
    var oneRatings : Int? = 0
    var twoRatings : Int? = 0
    var threeRatings : Int? = 0
    var fourRatings : Int? = 0
    var fiveRatings : Int? = 0
}
class structProductImages: NSObject
{
    var intId : NSInteger? = 0
    var intCreatedDate : NSInteger? = 0
    var intUpdateDate : NSInteger? = 0
    var isDefault : Bool? = false
    
    var strImageUrl :  String?
    var strImageType :  String?
    var dataImage :  Data?
}
