//
//  DaroonApp.swift
//  DaroonApp
//
//  Created by Masoud on 08/08/2018.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import Foundation

/**
 The *DaroonApp* class contains static functions that handle global configuration for the DaroonApp framework.
 */
public class DaroonApp {
    static public let shared = DaroonApp()    
    private var token:String!
    private var versionCode:String!
    private var packageName:String!
    
    public var delegate:DaroonAppDelegate?
    
    private var target:UIViewController?
    private var paymentID:Int?
    
    private init() {
        
        UIFont.registerFontWithFilenameString(filenameString: "yekan_regular.ttf", bundle: Bundle(identifier: "zzmasoud.DaroonApp")!)

        //init token
        //init versionCode
    }
    
    /**
     Setup DaroonApp frework
     
      **important:** must call once and first.
    
     for example after appdelegate - didFinishLaunchingWithOptions
     - Parameter token: You have it from DaroonApp developer panel
     */
    public func setup(token:String) {
        self.token = token
        
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            fatalError("Unable to read app version string.")
        }

        guard let identifier = Bundle.main.bundleIdentifier else {
            fatalError("Unable to read app bundle identifier.")
        }

        self.versionCode = version.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range:nil)
        packageName = identifier
   
    }
    
    /**
     Start a payment
     
     **important:** Set the delegate before calling this method.
     - Parameter target: The view controller that present pop-up
     - Parameter payment: A payment object
     - Parameter error: If error happens,it means no payment started.
     */
    public func pay(target: UIViewController , payment: DAPayment , completion: @escaping (_ error: Error?) -> Void) {
        
        guard self.delegate != nil else {
            fatalError("You must implement DaroonAppDelegate.")
        }
        
        let url = URL(string: path(of: .makePayment))!
        var parameterDictionary:[String:Any] = [key(of: .packageName) : packageName,  key(of: .versionCode) : versionCode , key(of: .amount) : payment.getAmount() , key(of: .type) : 1 , key(of: .mobile) : payment.getMobile() , key(of: .token) : token]
        
        if let email = payment.getEmail() {
            parameterDictionary[key(of: .email)] = email
        }
        
        if let extraData = payment.getExtraData() {
            parameterDictionary[key(of: .extraData)] = extraData
        }
        
        var request = customRequest(url: url)
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return
        }
        
        request.httpBody = httpBody
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                if let data = data {
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            if let dic = json as? [String:Any] {
                                if let id = dic[key(of: .paymentID)] as? Int {
                                    completion(nil)
                                    self.paymentID = id
                                    self.target = target
                                    self.presentTableView(target: target , payment: payment)
                                }
                            }
                        } catch {
                            completion(error)
                        }
                    } else {
                        completion(error)
                    }
                } else {
                    completion(error)
                }
            }
        }.resume()
    }
    
    private func presentTableView(target: UIViewController , payment: DAPayment) {
        DispatchQueue.main.async {
            let tableVC = DATableViewController(payment: payment)
            tableVC.delegate = self

            tableVC.modalPresentationStyle = .custom
            let halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: target, presentingViewController: tableVC)
            tableVC.transitioningDelegate = halfModalTransitioningDelegate
        
            target.present(tableVC, animated: true)
        }
        
    }
    
    
    private func presentWebView(target: UIViewController) {
        if let unwrapped = paymentID {
            let webVC = DAWebViewController(paymentID: unwrapped)
            webVC.delegate = self
            target.present(webVC, animated: true, completion: { })
        }

    }
    
    private func failedTransaction(paymentID:Int ,  completion: @escaping (_ error: Error?) -> Void) {
        let url = URL(string: path(of: .failTransaction) + String(paymentID))!
        let parameterDictionary:[String:Any] = [key(of: .packageName) : packageName,  key(of: .versionCode) : versionCode, key(of: .token) : token]
        
        var request = customRequest(url: url)
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return
        }
        
        request.httpBody = httpBody
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(nil)
                } else {
                    completion(error)
                }
            } else {
                completion(error)
            }
        }.resume()
    }
    
    /**
     Get all transaction of the user.
     
     - Parameter mobile: User mobile number
     - Parameter transactions: User transactions
     */
    public func getAllTransactions(mobile:String , completion: @escaping (_ error: Error? , _ transactions:[DATransaction]?) -> Void) {
        let url = URL(string: path(of: .allTransactions))!
        let parameterDictionary:[String:Any] = [key(of: .packageName) : packageName,  key(of: .versionCode) : versionCode, key(of: .token) : token , key(of: .mobile) : mobile]
        
        var request = customRequest(url: url)
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return
        }
        
        request.httpBody = httpBody
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                if let data = data {
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            if let array = json as? [Dictionary<String,Any>] {
                                var objects:[DATransaction] = []
                                for each in array {
                                    if let new = DATransaction(json: each) {
                                        objects.append(new)
                                    }
                                }
                                completion(nil, objects)
                            }
                        } catch {
                            completion(error,nil)
                        }
                    } else {
                        completion(error,nil)
                    }
                } else {
                    completion(error,nil)
                }
            }
        }.resume()

    }
    
    
    /**
     If you recentrly started a payment , you can check the result of the payment.
     
     ## Cases you need to knonw
     1. **error is not nil:**  object is definitely nil
     2. **error and object are nil:**  there is not a last transaction

     - Parameter transaction:A dictionary object to represent the JSON model.

     */
    public func getLastTransaction(completion: @escaping (_ error: Error? , _ transaction:Dictionary<String,Any>?) -> (Void)) {
        if let unwrapped = paymentID {
            let url = URL(string: path(of: .trackingCode)+"\(unwrapped)")!
            let parameterDictionary:[String:Any] = [key(of: .packageName) : packageName,  key(of: .versionCode) : versionCode, key(of: .token) : token]
            
            var request = customRequest(url: url)
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                return
            }
            
            request.httpBody = httpBody
            request.httpMethod = "POST"
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    if let data = data {
                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                if let dic = json as? Dictionary<String,Any> {
                                    completion(nil, dic)
                                }
                            } catch {
                                completion(error,nil)
                            }
                        } else {
                            completion(error,nil)
                        }
                    } else {
                        completion(error,nil)
                    }
                }
            }.resume()
        } else {
            completion(nil, nil)
        }
        
    }
}

extension DaroonApp {
    private func customRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Application/json", forHTTPHeaderField: "Accept")
        
        return request

    }
}

extension DaroonApp:DATableViewControllerDelegate {
    func didSelect(index: Int) {
        if let unwrapped = target {
            self.presentWebView(target: unwrapped)
        }
    }
}

extension DaroonApp:DAWebViewControllerDelegate {
    func didClose(controller: DAWebViewController , reason: DATransactionResult) {
        self.delegate?.transactionFinished(result: reason)
        if reason == .failed {
            DaroonApp.shared.failedTransaction(paymentID: paymentID!) { (error) in
                self.target = nil
            }
        }

    }
    
    
}
