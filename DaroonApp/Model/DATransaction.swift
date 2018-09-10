//
//  DATransaction.swift
//  DaroonApp
//
//  Created by Masoud on 8/14/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation

public class DATransaction:DAPayment {
    private let id:Int
    private let status:String
    private let date:String
    
    init?(json: [String: Any]) {
        guard let id:Int = json[key(of: .id)] as? Int,
            let amount:Int = json[key(of: .amount)] as? Int,
            let mobile:String = json[key(of: .mobile)] as? String,
            let status:String = json[key(of: .status)] as? String,
            let updatedAt:String = json[key(of: .updatedAt)] as? String
        else {
            return nil
        }
        
        let email = json[key(of: .email)] as? String
        let extraData = json[key(of: .extraData)] as? String
        
        self.id = id
        self.status = status
        self.date = updatedAt
        super.init(email: email, amount: amount, mobile: mobile, extraData: extraData)
        
        
    }
    
    public func getID() -> Int {
        return id
    }
    
    public func getStatus() -> String {
        return status
    }
    
    public func getDate() -> String {
        return date
    }
    
}
