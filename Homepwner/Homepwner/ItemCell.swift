//
//  ItemCell.swift
//  Homepwner
//
//  Created by Michael Pettiford on 8/23/17.
//  Copyright © 2017 Michael Pettiford. All rights reserved.
//

import UIKit


class ItemCell : UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
}
