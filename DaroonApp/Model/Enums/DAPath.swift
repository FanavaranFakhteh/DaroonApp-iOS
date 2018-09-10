//
//  DAPath.swift
//  DaroonApp
//
//  Created by Masoud on 08/08/2018.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation

enum DAPath:String {
    case baseURL = "https://my.daroonapp.com/api/v1/",
    makePayment = "payments/make",
    zarinPayment = "payments/ipg/",
    failTransaction = "payments/application/event/",
    trackingCode = "payments/verify/",
    allTransactions = "payments/user/get"
}

func path(of: DAPath) -> String {
    return DAPath.baseURL.rawValue + of.rawValue
}
