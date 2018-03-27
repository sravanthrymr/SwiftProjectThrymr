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
    
    func getProductsData(withData arrData:NSArray) -> NSMutableArray
    {
        let arrProducts : NSMutableArray = []
        for  dic: Any in arrData
        {
            if dic is NSDictionary
            {
                let dicProduct = dic as! NSDictionary
                let objProduct = getProductsDetails(withData: dicProduct)
                arrProducts .add(objProduct )
            }
        }
        return arrProducts
    }
    func getProductsDetails(withData dicProduct:NSDictionary) -> structProduct
    {
        let objStruct  = structProduct()
        objStruct.isActive = dicProduct.safeObjectForKey(key: "active") as? Bool
        objStruct.isConfigurable = dicProduct.safeObjectForKey(key: "configurable") as? Bool
        objStruct.isLatest = dicProduct.safeObjectForKey(key: "latest") as? Bool
        objStruct.isFeatured = dicProduct.safeObjectForKey(key: "featured") as? Bool
        objStruct.isBestSeller = dicProduct.safeObjectForKey(key: "bestSeller") as? Bool
        objStruct.isUpcoming = dicProduct.safeObjectForKey(key: "upcoming") as? Bool
        objStruct.isWishList = dicProduct.safeObjectForKey(key: "hasInWishlist") as? Bool
        objStruct.isCart = dicProduct.safeObjectForKey(key: "hasInCart") as? Bool
        objStruct.intStock = dicProduct.safeObjectForKey(key: "inStock") as? Int
        
        objStruct.idValue = dicProduct.safeObjectForKey(key: "id") as? NSInteger
        objStruct.currentDate = dicProduct.safeObjectForKey(key: "currentDate") as? NSInteger
        objStruct.updateDate = dicProduct.safeObjectForKey(key: "updateDate") as? NSInteger

        objStruct.price = dicProduct.safeObjectForKey(key: "price") as? Float
        objStruct.discount = dicProduct.safeObjectForKey(key: "discount") as? Float
        objStruct.quantity = dicProduct.safeObjectForKey(key: "quantity") as? Int
        objStruct.gstRate = dicProduct.safeObjectForKey(key: "gstRate") as? Float

        objStruct.name = dicProduct.safeObjectForKey(key: "name") as? String
        objStruct.sku = dicProduct.safeObjectForKey(key: "sku") as? String
        objStruct.smallDescription = dicProduct.safeObjectForKey(key: "smallDescription") as? String
        objStruct.longDescription = dicProduct.safeObjectForKey(key: "longDescription") as? String
        objStruct.weight = dicProduct.safeObjectForKey(key: "weight") as? String
        objStruct.weightUnit = dicProduct.safeObjectForKey(key: "weightUnit") as? String
        objStruct.metaTitle = dicProduct.safeObjectForKey(key: "metaTitle") as? String
        objStruct.metaKeywords = dicProduct.safeObjectForKey(key: "metaKeywords") as? String
        objStruct.metaDescription = dicProduct.safeObjectForKey(key: "metaDescription") as? String
        objStruct.sapCode = dicProduct.safeObjectForKey(key: "sapCode") as? String
        objStruct.hsnClassification = dicProduct.safeObjectForKey(key: "hsnClassification") as? String
        objStruct.barCode = dicProduct.safeObjectForKey(key: "barCode") as? String
        objStruct.benefits = dicProduct.safeObjectForKey(key: "benefits") as? String
        objStruct.ingredients = dicProduct.safeObjectForKey(key: "ingredients") as? String
        objStruct.howToUse = dicProduct.safeObjectForKey(key: "howToUse") as? String
        objStruct.shareUrl = dicProduct.safeObjectForKey(key: "shareUrl") as? String

        let arrProductImages  = dicProduct.safeObjectForKey(key: "productImages") as? NSArray
        if arrProductImages != nil
        {
            for dic :Any in arrProductImages!
            {
                if dic is NSDictionary
                {
                    let dicProductImageTemp = dic as! NSDictionary
                    let objStructImage = structProductImages()
                    objStructImage.intId = dicProductImageTemp.safeObjectForKey(key: "id") as? NSInteger
                    objStructImage.intCreatedDate = dicProductImageTemp.safeObjectForKey(key: "createdDate") as? NSInteger
                    objStructImage.intUpdateDate = dicProductImageTemp.safeObjectForKey(key: "updateDate") as? NSInteger
                    objStructImage.strImageUrl = dicProductImageTemp.safeObjectForKey(key:"imageUrl") as? String
                    objStructImage.strImageUrl = objStructImage.strImageUrl?.replacingOccurrences(of: " ", with: "%20")
                    objStructImage.strImageType = dicProductImageTemp.safeObjectForKey(key:"imageType") as? String
                    objStructImage.isDefault = dicProductImageTemp.safeObjectForKey(key: "default") as? Bool
                    objStruct.arrProductImages .add(objStructImage)
                }
            }
        }
        let arrProductConfigarations = dicProduct.safeObjectForKey(key: "differentWeightProducts") as? NSArray
        if arrProductConfigarations != nil
        {
            for dicConf :Any in arrProductConfigarations!
            {
                if dicConf is NSDictionary
                {
                    let dicProductConf = dicConf as! NSDictionary
                    let objProductInternal = getProductsDetails(withData: dicProductConf)
                    objStruct.arrProductSizeConfigarations .add(objProductInternal)
                }
            }
        }
        let dicCategory = dicProduct.safeObjectForKey(key: "category") as? NSDictionary
        objStruct.structCategory.strId =  dicCategory?.safeObjectForKey(key: "id") as? String
        objStruct.structCategory.createdDate = dicCategory?.safeObjectForKey(key: "createdDate") as? NSInteger
        objStruct.structCategory.updateDate = dicCategory?.safeObjectForKey(key: "updateDate") as? NSInteger
        objStruct.structCategory.strName = dicCategory?.safeObjectForKey(key: "name") as? String
        objStruct.structCategory.strDescription = dicCategory?.safeObjectForKey(key: "description") as? String
        objStruct.structCategory.isActive = dicCategory?.safeObjectForKey(key: "active") as? Bool
        objStruct.structCategory.strFileUrl = dicCategory?.safeObjectForKey(key: "fileUrl") as? String
        
        let dicSubCategory = dicProduct.safeObjectForKey(key: "subCategory") as? NSDictionary
        objStruct.structSubCategory.strId =  dicSubCategory?.safeObjectForKey(key: "id") as? String
        objStruct.structSubCategory.createdDate = dicSubCategory?.safeObjectForKey(key: "createdDate") as? NSInteger
        objStruct.structSubCategory.updateDate = dicSubCategory?.safeObjectForKey(key: "updateDate") as? NSInteger
        objStruct.structSubCategory.strName = dicSubCategory?.safeObjectForKey(key: "name") as? String
        objStruct.structSubCategory.strDescription = dicSubCategory?.safeObjectForKey(key: "description") as? String
        objStruct.structSubCategory.isActive = dicSubCategory?.safeObjectForKey(key: "active") as? Bool
        objStruct.structSubCategory.strFileUrl = dicSubCategory?.safeObjectForKey(key: "fileUrl") as? String
        
        let dicReviewSummary = dicProduct.safeObjectForKey(key: "reviewSummary") as? NSDictionary
        objStruct.structOveralrating.averageRating = dicReviewSummary?.safeObjectForKey(key: "averageRating") as? Float
        objStruct.structOveralrating.overallRatings = dicReviewSummary?.safeObjectForKey(key: "overallRatings") as? Int
        objStruct.structOveralrating.overallReviews = dicReviewSummary?.safeObjectForKey(key: "overallReviews") as? Int
        objStruct.structOveralrating.oneRatings = dicReviewSummary?.safeObjectForKey(key: "oneRatings") as? Int
        objStruct.structOveralrating.twoRatings = dicReviewSummary?.safeObjectForKey(key: "twoRatings") as? Int
        objStruct.structOveralrating.threeRatings = dicReviewSummary?.safeObjectForKey(key: "threeRatings") as? Int
        objStruct.structOveralrating.fourRatings = dicReviewSummary?.safeObjectForKey(key: "fourRatings") as? Int
        objStruct.structOveralrating.fiveRatings = dicReviewSummary?.safeObjectForKey(key: "fiveRatings") as? Int
        
        return objStruct
    }
}
