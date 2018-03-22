//
//  ProductCategoryController.swift
//  Patanjali
//
//  Created by Thrymr on 21/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit

class ProductCategoryController: UIViewController {
    
    @IBOutlet weak var imgViewHome: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrPreLogin : NSMutableArray = []
    var arrPostLogin : NSMutableArray = []
    var arrConst : NSMutableArray = []
    var arrData : NSMutableArray = []
    var arrDataTemp : NSMutableArray = []
    
    var str:NSString!
    var open: Bool! = false
    
    static let sharedInstance = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductCategoryController")  as! ProductCategoryController
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let swipeLeftGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(closeSlideMenu))
        swipeLeftGesture.direction = .left
        self.view .addGestureRecognizer(swipeLeftGesture)
        
        let swipeSlideTap = UITapGestureRecognizer.init(target: self, action: #selector(handleSingleTap))
        placeHolderView .addGestureRecognizer(swipeSlideTap)
        
        lblHome.font = setRandomFont(withSize: 14.0, withFontName: FONTROBOTO_SEMIBOLD)
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.estimatedSectionHeaderHeight = 50.0
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension

//        tableView.delegate = self as! UITableViewDelegate
//        tableView.dataSource = self as! UITableViewDataSource
        tableView.separatorStyle = .none;
    }
    func setMenuOptions()
    {
        if arrData.count == 0 && arrDataTemp.count > 0
        {
            arrData .addObjects(from: arrDataTemp as! [Any])
            arrDataTemp .removeAllObjects()
        }
        arrPreLogin .removeAllObjects()
        
        let arrPreLoginTitles = ["Login", "Register"]
        let arrPreLoginImages = ["leftMenu_Login", "leftMenu_Register"];
        let arrPreLoginScreens = [SCREEN_LOGIN, SCREEN_REGISTARTION]
        
        for jCnt in 0..<arrPreLoginTitles.count
        {
            let objStruct = structDescription()
            objStruct.isLine = (jCnt == 0) ? true : false
            objStruct.strTitle = arrPreLoginTitles[jCnt];
            objStruct.strImageName = arrPreLoginImages[jCnt];
            objStruct.screenType = arrPreLoginScreens[jCnt];
            arrPreLogin .add(objStruct)
        }
        
        arrPostLogin .removeAllObjects()
        
        let arrPostLoginTitles = ["My Account", "Orders", "Settings"]
        let arrPostLoginImages = ["leftMenu_Account", "leftMenu_Orders", "leftMenu_Settings"];
        let arrPostLoginScreens = [SCREEN_ACCOUNT, SCREEN_ORDERS, SCREEN_SETTINGS]
        
        for jCnt in 0..<arrPostLoginTitles.count
        {
            let objStruct = structDescription()
            objStruct.isLine = (jCnt == 0) ? true : false
            objStruct.strTitle = arrPostLoginTitles[jCnt];
            objStruct.strImageName = arrPostLoginImages[jCnt];
            objStruct.screenType = arrPostLoginScreens[jCnt];
            arrPostLogin .add(objStruct)
        }
        
        arrConst .removeAllObjects()
        let arrImages = ["leftMenu_AboutUs", "leftMenu_ContactUs", "leftMenu_FAQ", "leftMenu_Legal"]
        let arrTitles = ["About Us", "Contact us", "FAQ's", "Legal"]
        let arrScreens = [SCREEN_ABOUTUS, SCREEN_CONTACTUS, SCREEN_FAQ, SCREEN_LEGAL]
        
        for  jCnt in 0..<arrTitles.count
        {
            let objStruct = structDescription()
            objStruct.isLine = (jCnt == 0) ? true : false
            objStruct.strTitle = arrTitles[jCnt]
            objStruct.strImageName = arrImages[jCnt]
            objStruct.screenType = arrScreens[jCnt]
            arrConst .add(objStruct)
        }
        
        arrPostLogin .addObjects(from: arrConst as! [Any])
        arrPreLogin .addObjects(from: arrConst as! [Any])
        
        DispatchQueue.main.async {
            self.tableView .reloadData()
        }
    }
    @objc func handleSingleTap(rocognizer: UITapGestureRecognizer) -> Void
    {
        closeMenu()
    }
    @objc func closeSlideMenu(rocognizer: UISwipeGestureRecognizer) -> Void
    {
        closeMenu()
    }
    // MARK : To open side menu
    func openMenu()
    {
        DispatchQueue.main.async {
            if (!self.open)
            {
                self.open = true;
                self.view.alpha = 0;
                UIApplication .shared .keyWindow? .addSubview(self.view)
                UIView .animate(withDuration: 0.5, animations: {
                    self.view.alpha = 1
                    self.view.backgroundColor = UIColor.clear
                    let frame: CGRect = self.view.frame
                    var newFrame: CGRect = frame
                    newFrame.origin.x = 0;
                    self.view.frame = newFrame;
                    self.bgView.transform = CGAffineTransform.identity
                })
                self.placeHolderView.isHidden = false
            }
        }
    }
    // MARK : To close the side menu
    func closeMenu()
    {
        DispatchQueue.main.async {
            
            if (self.open)
            {
                self.open = false
                UIView .animate(withDuration: 0.5, animations: {
                    
                    let screenWidth: CGFloat  = SCREEN_WIDTH
                    let frame: CGRect = self.view.frame
                    var newFrame: CGRect = frame
                    newFrame.origin.x = -screenWidth
                    self.view.frame = newFrame;
                    self.bgView.transform = CGAffineTransform.init(translationX: -SCREEN_WIDTH, y: 0)
                }, completion: { (finished) in
                    self.view .removeFromSuperview()
                })
                self.placeHolderView.isHidden = true;
            }
        }
    }
    //MARK: UIbutton Actions
    @IBAction func btnHomeClicked(_ sender: Any)
    {
        closeMenu()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

