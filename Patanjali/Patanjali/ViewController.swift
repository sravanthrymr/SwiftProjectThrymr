//
//  ViewController.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate
{
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var viewScrollBg: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgViewBanner: UIImageView!
    var arrBanners : NSMutableArray = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(checkNet())
        {
            callServiceForLandingPage()
        }
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
                toastLabel(context: self, msg: response as! String)
            }
        }
    }
     // MARK: Handle Landingpage Response
    func handleDashBoardResponse(response:NSDictionary) -> Void
    {
        let dicResponseData = response.value(forKey: "data") as! NSDictionary
        let arrPromotionBanners = dicResponseData.value(forKey: "promotionBanners") as! NSArray
        let arrPromotionBannersTemp = JsonConverter.sharedInstance.getBannersData(withData: arrPromotionBanners)
        arrBanners.addObjects(from:arrPromotionBannersTemp as [AnyObject])
        print("\(arrBanners)")
        
        if(arrBanners.count > 0)
        {
            DispatchQueue.main.async {
                self.imgViewBanner.isHidden = true
                self.designBannerView()
            }
        }
        
//        let arrProductsList  = dicResponseData.value(forKey: "productsList") as! NSArray
//
//        for <#item#> in <#items#> {
//            <#code#>
//        }
        /*
         
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
*/
        
        
    }
       // MARK: Design Banners View
    func designBannerView() -> Void
    {
        DispatchQueue.main.async {
            for view : UIView in self.scrollView.subviews
            {
                view .removeFromSuperview()
            }
            for iCnt in 0..<self.arrBanners.count
            {
                let imgView = AsyncImageView()
                imgView.backgroundColor = UIColor.clear
                imgView.frame = CGRect(x:CGFloat(iCnt) * self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height)
                imgView.contentMode = .scaleAspectFill
                imgView.clipsToBounds = true
                imgView.image = UIImage.init(named: "previewBackground")
                self.scrollView .addSubview(imgView)
                
                let objStruct  = self.arrBanners[iCnt] as! structPromotionBanners
                if objStruct.strBannerUrl?.count == 0
                {
                    objStruct.strBannerUrl = ""
                }
                imgView.loadImage(urlString: objStruct.strBannerUrl!)
            }
            self.self.scrollView.contentSize = CGSize(width: CGFloat(self.arrBanners.count) * self.view.frame.size.width, height: self.self.scrollView.frame.size.height)
            self.pageController.numberOfPages = self.arrBanners.count
        }
    }
    @IBAction func pageControllerClicked(_ sender: Any)
    {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width * CGFloat(pageController.currentPage), y: 0), animated: true)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        DispatchQueue.main.async {
            self.pageController.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

