//
//  ProductCategoryController.swift
//  Patanjali
//
//  Created by Thrymr on 21/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit

let ViewcornerRadius = 8.0
let ViewShadowOffSet = CGSize(width: -15, height: 20)
let ViewShadowRadius = 5.0
let ViewShadowOpacity = 0.5
let ViewWidth = 0.8
let TableViewCellHeight = 40.0

class ProductCategoryController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
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

        self.view.frame = self.view.bounds;
        self.view.backgroundColor = UIColor.clear
        self.view.layer.masksToBounds = false;
        self.view.layer.cornerRadius = CGFloat(ViewcornerRadius)
        self.view.layer.shadowOffset = ViewShadowOffSet
        self.view.layer.shadowRadius = CGFloat(ViewShadowRadius)
        self.view.layer.shadowOpacity = Float(ViewShadowOpacity)

        var  menuFrame : CGRect = self.view.bounds
        menuFrame.size.width =  menuFrame.size.width * CGFloat(ViewWidth)

        bgView.frame = menuFrame
        bgView.transform = CGAffineTransform(scaleX: -bgView.bounds.size.width, y: CGFloat(0))
        placeHolderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        tableView .register(UINib(nibName: "LeftMenuHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "LeftMenuHeaderTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
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
    @objc func handleSingleTap(rocognizer: UITapGestureRecognizer) -> Void
    {
        closeMenu()
    }
    @objc func closeSlideMenu(rocognizer: UISwipeGestureRecognizer) -> Void
    {
        closeMenu()
    }
    //MARK: UITableView Delegate
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrData.count + Int((UserDefaults.standard.object(forKey: IS_LOGIN) as? String == "YES") ? arrPostLogin.count : arrPreLogin.count)
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section > arrData.count-1)
        {
            return 0
        }
        if(arrData.count > 0)
        {
            let  objStruct = arrData[section] as! structCategories
            return objStruct.arrProducts.count
        }
        else
        {
            return 0
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let objStruct = arrData[indexPath.section] as! structCategories
        return (objStruct.isSelected == true) ? UITableViewAutomaticDimension : 0.0
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var viewHeader = tableView.dequeueReusableCell(withIdentifier: "LeftMenuHeaderTableViewCell") as? LeftMenuHeaderTableViewCell
        if(viewHeader == nil)
        {
            viewHeader = UITableViewCell.init(style: .default, reuseIdentifier: "LeftMenuHeaderTableViewCell") as? LeftMenuHeaderTableViewCell
        }
        return viewHeader
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "cellProductCategory"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        let objCategory = arrData[indexPath.section] as! structCategories
        let objProduct = objCategory.arrProducts[indexPath.row] as! structCategories

        cell.contentView.backgroundColor = (objProduct.isSelected == true) ?  UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0) :  UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
        
        cell.textLabel?.text = objProduct.strName
        cell.textLabel?.font = setRandomFont(withSize: 10, withFontName: FONTOPENSANS_REGULAR)
        cell.textLabel?.textColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
        return cell
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}

