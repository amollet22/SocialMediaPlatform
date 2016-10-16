//
//  FancyImage.swift
//  SocialMediaPlatform
//
//  Created by Arron Mollet on 10/9/16.
//  Copyright © 2016 Arron Mollet. All rights reserved.
//

import UIKit

class FancyImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.0).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
    }

}
