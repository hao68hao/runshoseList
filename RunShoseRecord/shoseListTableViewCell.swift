//
//  shoseListTableViewCell.swift
//  RunShoseRecord
//
//  Created by lauda on 16/8/22.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class shoseListTableViewCell: UITableViewCell {

    @IBOutlet weak var shoseImage: UIImageView!
    @IBOutlet weak var shoseName: UILabel!
    @IBOutlet weak var shoseBrand: UILabel!
    @IBOutlet weak var shosePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
