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
                toastLabel(context: self, msg: response as! String)
            }
        }
    }
     // MARK: Handle Landingpage Response
    func handleDashBoardResponse(response:NSDictionary) -> Void
    {
        let dicResponseData = response.value(forKey: "data") as! NSDictionary
        let arrPromotionBanners = dicResponseData.value(forKey: "promotionBanners") as! NSArray
        let arrPromotionBannersDataTemp = JsonConverter.sharedInstance.getBannersData(withData: arrPromotionBanners)
        print("\(arrPromotionBannersDataTemp)")
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

