//
//  LeftMenuHeaderTableViewCell.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 22/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit


class LeftMenuHeaderTableViewCell: UITableViewCell
{

    @IBOutlet weak var cellBgView: UIView!
    
    @IBOutlet weak var lblCategoryname: UILabel!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var imageViewExpand: UIImageView!
    @IBOutlet weak var btnExpand: UIButton!
  
     @IBOutlet weak var imageViewLine: UIImageView!
     
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
