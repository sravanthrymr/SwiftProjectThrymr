//
//  ViewController.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var viewScrollBg: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var arrBanners : NSMutableArray!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        callServiceForLandingPage()
    }

    // MARK: Service call for Landing page
    func callServiceForLandingPage() -> Void
    {
        Services.sharedInstatnce.Service_CallWithData(withParameters: nil, withMethodName: .landingPage) { (response, error, isSuccess) in
            isSuccess ? print("success") : print("fail")

            if isSuccess == true
            {
                let dicResponse = response as! NSDictionary
                let dataResponse : Data = try! JSONSerialization.data(withJSONObject: dicResponse, options: .prettyPrinted)
                let strResponse = String(data: dataResponse, encoding: .utf8)!
                if strResponse.count > 0
                {
                    UserDefaults.standard.set(strResponse, forKey: DASHBOARD_RESPONSE)
                }
                self.handleDashBoardResponse(response: dicResponse)
            }
            else
            {
                print("\(response)")
            }
        }
    }
    func handleDashBoardResponse(response:NSDictionary) -> Void
    {
        let dicResponseData = response.value(forKey: "data") as! NSDictionary
        let arrPromotionBanners = dicResponseData.value(forKey: "promotionBanners") as! NSArray
        let arrPromotionBannersDataTemp = JsonConverter.sharedInstance.getBannersData(withData: arrPromotionBanners)
        print("\(arrPromotionBannersDataTemp)")
        
    }
    /*-(void)handleDashBoardResponse:(NSDictionary *)response
     {
     dispatch_async(dispatch_get_main_queue(), ^{
     NSDictionary *dicResponse = (NSDictionary *)response;
     
     NSDictionary *dicResponseData = [dicResponse safeObjectForKey:@"data"];
     NSArray *arrPromotionBanners = [dicResponseData safeObjectForKey:@"promotionBanners"];
     NSMutableArray *arrPromotionBannersDataTemp = [[JsonConverter sharedInstance] getBannersData:arrPromotionBanners];
     [arrBanners addObjectsFromArray:arrPromotionBannersDataTemp];
     NSArray *arrProductsList = [dicResponseData safeObjectForKey:@"productsList"];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     lblEmptyData.hidden = (arrPromotionBanners.count > 0 || arrProductsList.count > 0) ? YES : NO;
     });
     for (NSDictionary *dic in arrProductsList)
     {
     structLandingPage *objStruct = [[structLandingPage alloc] init];
     objStruct.intId = [[dic safeObjectForKey:@"id"] integerValue];
     objStruct.strTitle = [dic safeObjectForKey:@"title"];
     objStruct.strCategory = [dic safeObjectForKey:@"category"];
     objStruct.arrProducts = [[NSMutableArray alloc] init];
     NSArray *arrProductsResponse = [dic safeObjectForKey:@"products"];
     NSMutableArray *arrProductsDataTemp = [[JsonConverter sharedInstance] getProductsData:arrProductsResponse];
     [objStruct.arrProducts addObjectsFromArray:arrProductsDataTemp];
     if(objStruct.arrProducts.count > 0)
     [arrLandingProductsData addObject:objStruct];
     }
     [tblViewData reloadData];
     [self designBannerView];
     
     [NSTimer scheduledTimerWithTimeInterval:3.0
     target:self
     selector:@selector(changePageControllerValue:)
     userInfo:nil
     repeats:YES];
     
     //        if(isUserSignin && APP_DELEGATE.objStructProfile.strFirstName.length == 0)
     //            [self performSelectorOnMainThread:@selector(callServiceForprofile) withObject:nil waitUntilDone:YES];
     //        else
     if(isUserSignin)
     {
     [self performSelectorOnMainThread:@selector(callServiceForprofile) withObject:nil waitUntilDone:YES];
     [self performSelectorOnMainThread:@selector(callServiceForWhishlistCartCount) withObject:nil waitUntilDone:YES];
     }
     });
     }
*/
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

