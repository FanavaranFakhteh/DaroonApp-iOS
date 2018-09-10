//
//  DAPayment.swift
//  DaroonApp
//
//  Created by Masoud on 08/08/2018.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation

public class DAPayment {
    private let email:String?
    private let amount:Int
    private let mobile:String
    private let extraData:String?
    
    public init(email:String? = nil , amount:Int , mobile:String , extraData:String? = nil) {
        self.email = email
        self.amount = amount
        self.mobile = mobile
        self.extraData = extraData
    }
    
    public func getEmail() -> String? {
        return email
    }
    
    public func getAmount() -> Int {
        return amount
    }
    
    public func getMobile() -> String {
        return mobile
    }
    
    public func getExtraData() -> String? {
        return extraData
    }

}
