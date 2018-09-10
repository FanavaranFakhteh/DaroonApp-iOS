//
//  ViewController.swift
//  SimpleApp
//
//  Created by Masoud on 08/08/2018.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import UIKit
import DaroonApp

class ViewController: UIViewController {
    
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var label:UILabel!
    
    @IBAction func pay() {
        view.endEditing(true)
        let p = price.text ?? "5000"
        var e:String? = nil
        if let email = email.text {
            e = email.isEmpty ? nil:email
        }
        let pn = phoneNumber.text ?? "09025003748"

        let pInt = Int(p) ?? 5000

        let payment = DAPayment(email: e, amount: pInt, mobile: pn, extraData: nil)

        DaroonApp.shared.pay(target: self, payment: payment) { (error) in
        
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DaroonApp.shared.delegate = self

    }
    
    func checkLast() {
        DaroonApp.shared.getLastTransaction { (error, object) in
            var text = ""
            if let dic = object {
                for (key,value) in dic {
                    text += "\(key) = " + "\(value)" + "\n"
                }

                DispatchQueue.main.async {
                    self.label.text = text
                }
            }
        }
    }

}

extension ViewController: DaroonAppDelegate {
    func transactionFinished(result: DATransactionResult) {
        var color:UIColor = .gray
        var text:String!

        switch result {
        case .failed:
            text = "failed."
            break

        default:
            color = .green
            text = "Successful"
            break
            
        }
        
        DispatchQueue.main.async {
            self.label.text = text
            self.view.backgroundColor = color
            
            self.checkLast()
        }
    }
    
    
}

