//
//  StarView.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import Cosmos

class StarView: CosmosView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        rating = 5
        settings.updateOnTouch = false
        settings.fillMode = .full
        settings.emptyBorderColor = UIColor.clear
        settings.filledColor = UIColor(hex: 0x00AF9E)
        settings.filledBorderColor = UIColor(hex: 0x00AF9E)
        settings.starMargin = 1
        settings.starSize = 13
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
