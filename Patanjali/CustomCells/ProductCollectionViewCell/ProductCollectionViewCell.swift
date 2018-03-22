//
//  ProductCollectionViewCell.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 21/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit
class ProductCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnProductRating: UIButton!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductCost: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        lblNoData.layer.borderColor = COLORTEXT_GRAY.cgColor;
        
        lblNoData.font = setRandomFont(withSize: 13.0, withFontName: FONTOPENSANS_REGULAR)
        lblNoData.layer.borderWidth = 1.0
        lblNoData.layer.cornerRadius = 5.0

        lblProductName.font = setRandomFont(withSize: 10.0, withFontName: FONTOPENSANS_REGULAR)
        lblProductQty.font = setRandomFont(withSize: 10.0, withFontName: FONTOPENSANS_REGULAR)
        lblProductCost.font = setRandomFont(withSize: 10.0, withFontName: FONTOPENSANS_REGULAR)
    }

    @IBAction func btnActionProductRating(_ sender: Any)
    {
    }
}
