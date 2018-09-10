//
//  DAWebView.swift
//  DaroonApp
//
//  Created by Masoud on 8/11/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import UIKit

class DAWebView: UIWebView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
