//
//  DeviceTableViewCell.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 10.10.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    // MARK: properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
