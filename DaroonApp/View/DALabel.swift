//
//  DALabel.swift
//  DaroonApp
//
//  Created by Masoud on 8/15/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation


class DALabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        if Device.isSizeOrSmaller(height: .Inches_4) {
             self.font = UIFont(name: self.font.fontName, size: self.font.pointSize * 0.8)
        }
    }
}
