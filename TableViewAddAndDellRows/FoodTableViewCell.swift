//
//  FoodTableViewCell.swift
//  TableViewAddAndDellRows
//
//  Created by VyacheslavKrivoi on 5/4/19.
//  Copyright © 2019 VyacheslavKrivoi. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewFood:UIImageView?
    @IBOutlet weak var lblFoodName:UILabel?
    @IBOutlet weak var lblRating:UILabel?
    @IBOutlet weak var lblDescription:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
