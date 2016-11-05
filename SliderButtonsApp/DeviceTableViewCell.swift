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
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var uartConnectableLabel: UILabel!

    var doConnect: ((DeviceTableViewCell) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func connectButtonPressed(_ sender: AnyObject) {
        doConnect?(self)
    }
}
