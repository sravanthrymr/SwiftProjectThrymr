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
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

