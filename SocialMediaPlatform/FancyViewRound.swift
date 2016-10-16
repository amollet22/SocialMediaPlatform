//
//  FancyViewRound.swift
//  SocialMediaPlatform
//
//  Created by Arron Mollet on 10/6/16.
//  Copyright © 2016 Arron Mollet. All rights reserved.
//

import UIKit

class FancyViewRound: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 5.0
        
    }
}
