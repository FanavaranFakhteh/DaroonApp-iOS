//
//  String.swift
//  DaroonApp
//
//  Created by Masoud on 8/15/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation

extension Int {
    func persianString() -> String?{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "fa_IR")
        return formatter.string(from: self as NSNumber)?.replacingOccurrences(of: "ریال", with: "")
    }
}

extension String {
    func persianString() -> String {
        var text = ""
        for each in self {
            if let _ = Int(String(each)) {
                let format = NumberFormatter()
                format.locale = Locale(identifier: "fa_IR")
                let number =   format.number(from: String(each))
                let faNumber = format.string(from: number!)
                text += faNumber!
            } else {
                text += String(each)
            }
        }
        return text
    }
}
