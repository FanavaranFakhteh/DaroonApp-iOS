//
//  DAAPIKey.swift
//  DaroonApp
//
//  Created by Masoud on 8/14/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation

enum DAAPIKey:String {
    case email = "email",
    packageName = "package_name",
    versionCode = "version_code",
    amount = "amount",
    type = "type",
    mobile = "mobile" ,
    extraData = "extra_data" ,
    token = "token" ,
    paymentID = "payment_id" ,
    id = "id" ,
    status = "status" ,
    createdAt = "created_at" ,
    updatedAt = "updated_at"
}


func key(of: DAAPIKey) -> String {
    return of.rawValue
}

