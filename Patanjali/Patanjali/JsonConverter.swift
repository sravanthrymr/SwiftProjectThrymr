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
        let arrData : NSMutableArray = []
        for  dic: Any in arrData
        {
            if dic is NSDictionary
            {
               // let objProduct = dic as! NSDictionary

            }
        }
        return arrData
    }
//    NSMutableArray *arrData = [[NSMutableArray alloc] init];
//    for (NSDictionary *dicProduct in arrProducts)
//    {
//    structProduct *objStruct = [self getProductsDetails:dicProduct];
//    [arrData addObject:objStruct];
//    }
//    return arrData;
//    }
    
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
        
        
        
        
        return objStruct
    }

/*
     -(structProduct *)getProductsDetails:(NSDictionary *)dicProduct
     {
     structProduct *objStruct = [[structProduct alloc] init];
     [objStruct initallocations];
     
     
     
     
     
     
     
     
     
     
     objStruct.idValue = [[dicProduct safeObjectForKey:@"id"] integerValue];
     objStruct.currentDate = [[dicProduct safeObjectForKey:@"currentDate"] integerValue];
     objStruct.updateDate = [[dicProduct safeObjectForKey:@"updateDate"] integerValue];
     objStruct.price = [[dicProduct safeObjectForKey:@"price"] floatValue];
     objStruct.discount = [[dicProduct safeObjectForKey:@"discount"] floatValue];
     objStruct.quantity = [[dicProduct safeObjectForKey:@"quantity"] intValue];
     objStruct.gstRate = [[dicProduct safeObjectForKey:@"gstRate"] floatValue];
     objStruct.name = [dicProduct safeObjectForKey:@"name"];
     objStruct.sku = [dicProduct safeObjectForKey:@"sku"];
     objStruct.smallDescription = [dicProduct safeObjectForKey:@"smallDescription"];
     objStruct.longDescription = [dicProduct safeObjectForKey:@"longDescription"];
     objStruct.weight = [dicProduct safeObjectForKey:@"weight"];
     objStruct.weightUnit = [dicProduct safeObjectForKey:@"weightUnit"];
     objStruct.metaTitle = [dicProduct safeObjectForKey:@"metaTitle"];
     objStruct.metaKeywords = [dicProduct safeObjectForKey:@"metaKeywords"];
     objStruct.metaDescription = [dicProduct safeObjectForKey:@"metaDescription"];
     objStruct.sapCode = [dicProduct safeObjectForKey:@"sapCode"];
     objStruct.hsnClassification = [dicProduct safeObjectForKey:@"hsnClassification"];
     objStruct.barCode = [dicProduct safeObjectForKey:@"barCode"];
     objStruct.benefits = [dicProduct safeObjectForKey:@"benefits"];
     objStruct.ingredients = [dicProduct safeObjectForKey:@"ingredients"];
     objStruct.howToUse = [dicProduct safeObjectForKey:@"howToUse"];
     objStruct.shareUrl = [dicProduct safeObjectForKey:@"shareUrl"];
     //         objStruct.productManufacture = [dicProduct safeObjectForKey:@"productManufacture"];
     NSArray *arrProductImages = [dicProduct safeObjectForKey:@"productImages"];
     for (NSDictionary *dic in arrProductImages)
     {
     structProductImages *objStructImage = [[structProductImages alloc]init];
     objStructImage.intId = [[dic safeObjectForKey:@"id"]  integerValue];
     objStructImage.intCreatedDate = [[dic safeObjectForKey:@"createdDate"] integerValue];
     objStructImage.intUpdateDate = [[dic safeObjectForKey:@"updateDate"] integerValue];
     objStructImage.strImageUrl = [dic safeObjectForKey:@"imageUrl"];
     objStructImage.strImageUrl = [objStructImage.strImageUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
     objStructImage.strImageType = [dic safeObjectForKey:@"imageType"];
     objStructImage.isDefault = [[dic safeObjectForKey:@"default"] boolValue];
     [objStruct.arrProductImages addObject:objStructImage];
     }
     
     NSArray *arrProductConfigarations = [dicProduct safeObjectForKey:@"differentWeightProducts"];
     for (NSDictionary *dicConf in arrProductConfigarations)
     {
     structProduct *objProductInternal = [self getProductsDetails:dicConf];
     [objStruct.arrProductSizeConfigarations addObject:objProductInternal];;
     }
     
     NSDictionary *dicCategory = [dicProduct safeObjectForKey:@"category"];
     objStruct.structCategory.strId = [NSString stringWithFormat:@"%ld", [[dicCategory safeObjectForKey:@"id"] integerValue]];
     objStruct.structCategory.createdDate = [[dicCategory safeObjectForKey:@"createdDate"] integerValue];
     objStruct.structCategory.updateDate = [[dicCategory safeObjectForKey:@"updateDate"] integerValue];
     objStruct.structCategory.strName = [dicCategory safeObjectForKey:@"name"];
     objStruct.structCategory.strDescription = [dicCategory safeObjectForKey:@"description"];
     objStruct.structCategory.isActive = [[dicCategory safeObjectForKey:@"active"] boolValue];
     objStruct.structCategory.strFileUrl = [dicCategory safeObjectForKey:@"fileUrl"];
     
     NSDictionary *dicSubCategory = [dicProduct safeObjectForKey:@"subCategory"];
     objStruct.structSubCategory.strId = [NSString stringWithFormat:@"%ld", [[dicSubCategory safeObjectForKey:@"id"] integerValue]];
     objStruct.structSubCategory.createdDate = [[dicSubCategory safeObjectForKey:@"createdDate"] integerValue];
     objStruct.structSubCategory.updateDate = [[dicSubCategory safeObjectForKey:@"updateDate"] integerValue];
     objStruct.structSubCategory.strName = [dicSubCategory safeObjectForKey:@"name"];
     objStruct.structSubCategory.strDescription = [dicSubCategory safeObjectForKey:@"description"];
     objStruct.structSubCategory.isActive = [[dicSubCategory safeObjectForKey:@"active"] boolValue];
     
     NSDictionary *dicReviewSummary = [dicProduct safeObjectForKey:@"reviewSummary"];
     objStruct.structOveralrating.averageRating = [[dicReviewSummary safeObjectForKey:@"averageRating"] floatValue];
     objStruct.structOveralrating.overallRatings = [[dicReviewSummary safeObjectForKey:@"overallRatings"] floatValue];
     objStruct.structOveralrating.overallReviews = [[dicReviewSummary safeObjectForKey:@"overallReviews"] floatValue];
     objStruct.structOveralrating.oneRatings = [[dicReviewSummary safeObjectForKey:@"oneRatings"] floatValue];
     objStruct.structOveralrating.twoRatings = [[dicReviewSummary safeObjectForKey:@"twoRatings"] floatValue];
     objStruct.structOveralrating.threeRatings = [[dicReviewSummary safeObjectForKey:@"threeRatings"] floatValue];
     objStruct.structOveralrating.fourRatings = [[dicReviewSummary safeObjectForKey:@"fourRatings"] floatValue];
     objStruct.structOveralrating.fiveRatings = [[dicReviewSummary safeObjectForKey:@"fiveRatings"] floatValue];
     
     return objStruct;
     }
*/
}
