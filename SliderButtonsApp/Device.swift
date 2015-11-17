//
//  Device.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 10.10.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import Foundation
import UIKit

class Device {
    
    var identifier: String!
    var name: String?
    var photo: UIImage?
    
    init?(identifier: String, name: String?, photo: UIImage?) {
        self.name = name
        self.photo = photo
    }
    
}
