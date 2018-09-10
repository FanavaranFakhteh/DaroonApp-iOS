//
//  DAWebViewControllerDelegate.swift
//  DaroonApp
//
//  Created by Masoud on 8/13/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation

protocol DAWebViewControllerDelegate {
    func didClose(controller: DAWebViewController , reason: DATransactionResult)
}
