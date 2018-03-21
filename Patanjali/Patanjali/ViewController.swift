//
//  ViewController.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var viewScrollBg: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgViewBanner: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    var arrBanners : NSMutableArray = []
    var arrLandingProductsData : NSMutableArray = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tblView.rowHeight = 50.0
        tblView.estimatedRowHeight = UITableViewAutomaticDimension
        
        if(checkNet())
        {
            callServiceForLandingPage()
        }
    }
    
    // MARK: ---Service call for Landing page
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
    // MARK: ---Handle Landingpage Response
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
        
        let arrProductsList  = dicResponseData.safeObjectForKey(key: "productsList") as? NSArray
        
        for dic : Any in arrProductsList!
        {
            if dic is NSDictionary
            {
                let dicProduct = dic as! NSDictionary
                
                let objStruct = structLandingPage()
                objStruct.intId = dicProduct.safeObjectForKey(key: "id") as? NSInteger
                objStruct.strTitle = dicProduct.safeObjectForKey(key: "title") as? String
                objStruct.strCategory = dicProduct.safeObjectForKey(key: "category") as? String
                objStruct.arrProducts = []
                
                let arrProductsResponse = dicProduct.value(forKey: "products") as? NSArray
                if arrProductsResponse != nil
                {
                    let arrProductsTemp = JsonConverter.sharedInstance.getProductsData(withData: arrProductsResponse!)
                    objStruct.arrProducts .addObjects(from: arrProductsTemp as! [Any])
                }
                if objStruct.arrProducts.count > 0
                {
                    arrLandingProductsData .add(objStruct)
                }
            }
        }
        print("\(arrLandingProductsData)")
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
    }
    // MARK: ---Design Banners View
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
    //MARK: --- UIScrollView Delegates
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        DispatchQueue.main.async
            {
                self.pageController.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        }
    }
    //MARK: --- UITableView Delegates
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let viewHeader = UIView()
        viewHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width - 80, height: 50)
        viewHeader.backgroundColor = UIColor.clear
        
        let objStruct = arrLandingProductsData[section] as! structLandingPage
        let lblTitle = UILabel()
        lblTitle.frame = CGRect(x: 10, y: 5, width: tblView.frame.size.width, height: 40)
        lblTitle.text = objStruct.strTitle
        lblTitle.textColor = COLORSELECTED
        lblTitle.minimumScaleFactor = 0.6
        lblTitle.font = setRandomFont(withSize: 15.0, withFontName: FONTOPENSANS_BOLD)
        viewHeader .addSubview(lblTitle)
        
        let buttonSeeAll = UIButton.init(type: .custom)
        buttonSeeAll.frame = CGRect(x: tblView.frame.size.width - 70, y: 5, width: 60, height: 40)
        buttonSeeAll .setTitle("See All", for: .normal)
        buttonSeeAll.setTitleColor(UIColor.gray, for: .normal)
       buttonSeeAll .titleLabel?.font = setRandomFont(withSize: 15.0, withFontName: FONTOPENSANS_BOLD)
        buttonSeeAll .addTarget(self, action: #selector(buttonSeeAllClicked), for: .touchUpInside)
        buttonSeeAll.tag = section
        viewHeader .addSubview(buttonSeeAll)
        return viewHeader
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 180
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "cellHome"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! HomeTableViewCell
        
        let objStruct = arrLandingProductsData[indexPath.section] as! structLandingPage
        cell.setData(withProducts: objStruct.arrProducts as! [structProduct])
        return cell
    }
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrLandingProductsData.count
    }
    //MARK: UIButton Actions

    @objc func buttonSeeAllClicked(btn: UIButton) -> Void
    {
        print("\(btn.tag)")
    }
    @objc func btnMenuClicked(sender : UIButton) -> Void
    {
        
    }
    @IBAction func pageControllerClicked(_ sender: Any)
    {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width * CGFloat(pageController.currentPage), y: 0), animated: true)
    }
    @IBAction func btnMenuClicked(_ sender: Any)
    {
        DispatchQueue.main.async {
            ProductCategoryController.sharedInstance.openMenu()
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

