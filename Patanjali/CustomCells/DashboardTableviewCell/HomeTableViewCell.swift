//
//  HomeTableViewCell.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 21/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit
var arrProducts : NSMutableArray?
class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var collectionViewProducts: UICollectionView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        collectionViewProducts.delegate = self
        collectionViewProducts.dataSource = self
        collectionViewProducts.register(UINib(nibName: "ProductCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
    func setData(withProducts arrData : NSMutableArray) -> Void
    {
        arrProducts  = arrData
        self.collectionViewProducts.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if arrProducts != nil
        {
            let objStruct = arrProducts![collectionViewProducts.tag] as! structLandingPage
           return objStruct.arrProducts.count
        }
        else
        {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellIdentifier = "ProductCollectionViewCell"
        let cell = collectionViewProducts.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        let objStruct = arrProducts![collectionViewProducts.tag] as! structLandingPage
        let objStructProduct = objStruct.arrProducts[indexPath.item] as! structProduct
        
        cell.lblProductQty.attributedText = setAttrStrForProductUnits(str1:objStructProduct.weight!, str2:String(format:" %@", objStructProduct.weightUnit!))
        cell.lblProductName.text = objStructProduct.name
        
        cell.lblProductCost.text = String(format: "\u{20b9} %.2f", objStructProduct.price!)
        cell.imgProduct.image = UIImage(named: "previewBackground")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:180, height: CGFloat(200))
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
