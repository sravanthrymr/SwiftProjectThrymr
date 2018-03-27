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
    var contentOffSet : CGFloat! = 0
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
        
//        tableView .register(ProductCategoryCustomView(), forHeaderFooterViewReuseIdentifier: "ProductCategoryCustomView")
//        tableView .register(UINib(nibName: "LeftMenuHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "LeftMenuHeaderTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none;
        setMenuOptions()
        callServiceForCategories()
    }
    //MARK: SERVICE CALL
    func callServiceForCategories()
    {
        Services.sharedInstatnce.Service_CallWithData(withParameters: nil, withMethodName: .categoryList) { (response, error, success) in
            if(success == true)
            {
                let dicResponse = response as? NSDictionary
                if  let arrResponseData = dicResponse?.safeObjectForKey(key: "data") as? NSArray
                {
                    for jCnt in 0..<arrResponseData.count
                    {
                        let objCategory =  structCategories()
                        let dicCategory = arrResponseData[jCnt] as? NSDictionary
                        
                        objCategory.strId = dicCategory?.safeObjectForKey(key: "id") as? String
                        objCategory.strName = dicCategory?.safeObjectForKey(key: "name") as? String
                        objCategory.strDescription = dicCategory?.safeObjectForKey(key: "description") as? String
                        objCategory.strFileUrl = dicCategory?.safeObjectForKey(key: "fileUrl") as? String
                        objCategory.strIconUrl = dicCategory?.safeObjectForKey(key: "iconUrl") as? String
                        objCategory.strIconUrl = objCategory.strIconUrl?.replacingOccurrences(of: " ", with: "%20")
                        
                        objCategory.isSelected = false
                        objCategory.isActive = dicCategory?.safeObjectForKey(key: "isActive") as? Bool
                        
                        if let arrProducts = dicCategory?.safeObjectForKey(key: "subCategories") as? NSArray
                      {
                            for jCnt in 0..<arrProducts.count
                            {
                                let dicProduct = arrProducts[jCnt] as? NSDictionary
                                let objProduct = structCategories()
                                objProduct.strId = dicProduct?.safeObjectForKey(key: "id") as? String
                                objProduct.strName = dicProduct?.safeObjectForKey(key: "name") as? String
                                objProduct.strDescription = dicProduct?.safeObjectForKey(key: "description") as? String
                                objProduct.isActive = dicProduct?.safeObjectForKey(key: "isActive") as? Bool
                               objCategory.arrProducts .add(objProduct)
                            }
                        }
                        self.arrData .add(objCategory)
                    }
                    let  objProductArticle = structCategories()
                    objProductArticle.strId = ""
                    objProductArticle.strName = "Health"
                    objProductArticle.strDescription = ""
                    objProductArticle.isArticle = true;
                    self.arrData .add(objProductArticle)
                }
                DispatchQueue.main.async {
                    self.setMenuOptions()
                }
            }
            else
            {
                toastLabel(context: self, msg: response as! String)
            }
        }
    }
    /*
     -(void)callServiceForCategories
     {
     [APP_DELEGATE showLoader];
     
     [[APIClass sharedInstance] Service_CallWithData:nil withMethodName:CategoryList complitionHandler:^(id response, NSError *error, BOOL isSuccess) {
     dispatch_async(dispatch_get_main_queue(), ^{ [APP_DELEGATE hideLoader]; });
     if(isSuccess)
     {
     dispatch_async(dispatch_get_main_queue(), ^{
     NSDictionary *dicResponse = (NSDictionary *)response;
     NSArray *arrResponseData = [dicResponse safeObjectForKey:@"data"];
     for (int iCnt = 0; iCnt < arrResponseData.count; iCnt++)
     {
     NSDictionary *dicCategory = arrResponseData[iCnt];
     structCategories *objCategory = [[structCategories alloc] init];
     objCategory.strId = [NSString stringWithFormat:@"%@", [dicCategory safeObjectForKey:@"id"]];
     objCategory.strName = [dicCategory safeObjectForKey:@"name"];
     objCategory.strDescription = [dicCategory safeObjectForKey:@"description"];
     objCategory.strFileUrl = [dicCategory safeObjectForKey:@"fileUrl"];
     objCategory.strIconUrl = [dicCategory safeObjectForKey:@"iconUrl"];
     objCategory.strIconUrl = [objCategory.strIconUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
     
     objCategory.arrProducts = [[NSMutableArray alloc] init];
     objCategory.isSelected = NO;
     objCategory.isActive = [[dicCategory safeObjectForKey:@"isActive"] boolValue];
     NSArray *arrProducts = [dicCategory safeObjectForKey:@"subCategories"];
     if(arrProducts.count > 0)
     for (int jCnt = 0; jCnt < arrProducts.count; jCnt++)
     {
     NSDictionary *dicProduct = arrProducts[jCnt];
     structCategories *objProduct = [[structCategories alloc] init];
     objProduct.strId = dicCategory?.safeObjectForKey(key: "id"];
     objProduct.strName = dicCategory?.safeObjectForKey(key: "name"];
     objProduct.strDescription = dicCategory?.safeObjectForKey(key: "description"];
     objProduct.isActive = [dicCategory?.safeObjectForKey(key: "isActive"] boolValue];
     [objCategory.arrProducts addObject:objProduct];
     }
     [arrData addObject:objCategory];
     }
     structCategories *objProductArticle = [[structCategories alloc] init];
     objProductArticle.strId = @"";
     objProductArticle.strName = @"Health";
     objProductArticle.strDescription = @"";
     objProductArticle.isActive = @"";
     objProductArticle.isArticle = YES;
     [arrData addObject:objProductArticle];
     
     dispatch_async(dispatch_get_main_queue(), ^{ [self setMenuOptions]; });
     });
     }
     else
     {
     dispatch_async(dispatch_get_main_queue(), ^{ [self setMenuOptions]; });
     
     [Utils showAlert:self withMessage:(NSString *)response];
     }
     }];
     }
     */
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
    // MARK: To open side menu
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
    @objc func btnSectionExpandClicked(btn : UIButton)
    {
        if(btn.tag <= arrData.count-1 && arrData.count > 0)
        {
            let  objCategory = arrData[btn.tag] as! structCategories
            if(objCategory.isArticle == true)
            {
               // [self openHealthArticles];
                return;
            }
            if(objCategory.isSelected == true)
            {
                tableView.contentOffset = CGPoint(x: 0, y: contentOffSet)
                objCategory.isSelected = false
            }
            else
            {
                for  iCnt in 0..<arrData.count
                {
                    let objStruct = arrData[iCnt] as? structCategories
                    if iCnt == btn.tag
                    {
                        objStruct?.isSelected = true
                        contentOffSet = tableView.contentOffset.y
                    }
                    else
                    {
                        objStruct?.isSelected = false
                    }
                }
            }
        }
        else
        {
            //[self openItem:[NSIndexPath indexPathForRow:0 inSection:btn.tag]];
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            }
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
            return (objStruct.isSelected == true ) ? objStruct.arrProducts.count :0
        }
        else
        {
            return 0
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let viewHeader = Bundle.main.loadNibNamed("ProductCategoryCustomView", owner: self, options: nil)?.first as! ProductCategoryCustomView

//        var viewHeader = tableView.dequeueReusableCell(withIdentifier: "LeftMenuHeaderTableViewCell") as? LeftMenuHeaderTableViewCell
//        if(viewHeader == nil)
//        {
//            viewHeader = UITableViewCell.init(style: .default, reuseIdentifier: "LeftMenuHeaderTableViewCell") as? LeftMenuHeaderTableViewCell
//        }
        viewHeader.btnExpand .addTarget(self, action: #selector(btnSectionExpandClicked), for: .touchUpInside)
       viewHeader.btnExpand.tag = section

        if(section <= arrData.count-1 && arrData.count > 0)
        {
            let objStruct = arrData[section] as! structCategories
            viewHeader.lblCategoryname.text = objStruct.strName
            viewHeader.imageViewLogo.image = UIImage.init(named: "listIconPreview")
            if(objStruct.isSelected == true)
            {
                viewHeader.lblCategoryname.textColor = COLOR_SELECTED_ORANGE;
                viewHeader.lblCategoryname.font = setRandomFont(withSize: 13.0, withFontName: FONTOPENSANS_BOLD)
                viewHeader.imageViewExpand.image = UIImage.init(named: "minus")
            }
            else
            {
                viewHeader.lblCategoryname.textColor = COLORTEXT_SELECTED_GRAY;
                viewHeader.imageViewExpand.image = UIImage.init(named: "plus")
                viewHeader.lblCategoryname.font = setRandomFont(withSize: 12.0, withFontName: FONTOPENSANS_BOLD)
            }
            if(objStruct.strIconUrl != nil)
            {
                if(objStruct.dataImage != nil)
                {
                    viewHeader.imageViewLogo.image = UIImage.init(data: objStruct.dataImage!)
                }
                else
                {
                    DispatchQueue.global(qos: .default).async(execute: {() -> Void in
                        let dataOfImage = try? Data.init(contentsOf: URL.init(string: objStruct.strIconUrl!)!)
                        if(dataOfImage != nil)
                        {
                            objStruct.dataImage = dataOfImage
                            let imageDownloaded = UIImage.init(data: objStruct.dataImage!)
                            DispatchQueue.main.async {
                                viewHeader.imageViewLogo.image = imageDownloaded
                            }
                        }
                    })
                }
            }
                viewHeader.imageViewExpand.isHidden = false
                viewHeader.imageViewLine.isHidden = true

                if(arrData.count-1 == section)
                {
                    viewHeader.lblCategoryname.textColor = COLORBACKGROUND_GRAY;
                    viewHeader.lblCategoryname.font = setRandomFont(withSize: 12.0, withFontName: FONTOPENSANS_BOLD)
                    viewHeader.imageViewExpand.backgroundColor = COLORTEXT_GRAY;
                    viewHeader.imageViewExpand.isHidden = true
                    viewHeader.imageViewLogo.image = UIImage.init(named: "healthIcon")
                    viewHeader.imageViewLine.isHidden = true
                }
        }
        else
        {
            viewHeader.imageViewLine.backgroundColor = COLORTEXT_GRAY;
            viewHeader.imageViewLine.contentMode = .scaleAspectFit
            viewHeader.imageViewExpand.isHidden = true

            let objProduct = ((UserDefaults.standard.object(forKey: IS_LOGIN) as? String == "YES") ? arrPostLogin[section-arrData.count] : arrPreLogin[section-arrData.count]) as! structDescription

            viewHeader.imageViewLine.isHidden = (objProduct.isLine == true) ? false : true
            viewHeader.lblCategoryname.text = objProduct.strTitle;
            if (objProduct.strImageName != nil)
            {
                viewHeader.imageViewLogo.image = UIImage.init(named: objProduct.strImageName!)
            }
            viewHeader.lblCategoryname.textColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
            viewHeader.lblCategoryname.font = setRandomFont(withSize: 11.0, withFontName: FONTOPENSANS_REGULAR)
        }

      return viewHeader
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "cellProductCategory"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let objCategory = arrData[indexPath.section] as! structCategories
        let objProduct = objCategory.arrProducts[indexPath.row] as! structCategories
        
        let label = cell.contentView.viewWithTag(101) as? UILabel
        label?.text = objProduct.strName
        label?.font = setRandomFont(withSize: 10, withFontName: FONTOPENSANS_REGULAR)
        label?.textColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
        return cell
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}

