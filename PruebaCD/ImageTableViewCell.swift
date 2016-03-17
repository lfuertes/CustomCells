//
//  ImateTableViewCell.swift
//  PruebaCD
//
//  Created by Luis Fuertes on 3/3/16.
//  Copyright © 2016 Luis.Fuertes. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var fieldCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
