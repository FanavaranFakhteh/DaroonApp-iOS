//
//  DAHeaderView.swift
//  DaroonApp
//
//  Created by Masoud on 8/15/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import UIKit

class DAHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        UINib(nibName: "DAHeaderView", bundle: Bundle(identifier: "zzmasoud.DaroonApp")!).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()

    }
}
