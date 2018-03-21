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
        
        lblNoData.font = setRandomFont(withSize: 13.0, withFontName: FONTROBOTO_REGULAR)
        lblNoData.layer.borderWidth = 1.0
        lblNoData.layer.cornerRadius = 5.0

//       lblProductQty.attributedText = [Utils setAttrStrForProductUnits:@"0 " fontString:@"ml"];
        //lblProductCost.text = [NSString stringWithFormat: @"\u20b9 %d",850];
        //
        //lblProductName.font = [UIFont randomFontwithSize:10.0f fontName:FONTROBOTO_REGULAR];
        //lblProductQty.font = [UIFont randomFontwithSize:10.0f fontName:FONTROBOTO_REGULAR];
        //lblProductCost.font = [UIFont randomFontwithSize:10.0f fontName:FONTROBOTO_REGULAR];

    }
    


    @IBAction func btnActionProductRating(_ sender: Any)
    {
    }
}
