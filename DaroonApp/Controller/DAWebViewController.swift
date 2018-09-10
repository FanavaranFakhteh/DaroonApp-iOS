//
//  DAWebViewController.swift
//  DaroonApp
//
//  Created by Masoud on 8/11/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import UIKit

class DAWebViewController: UIViewController {
    
    convenience init(paymentID:Int) {
        self.init()
        self.paymentID = String(paymentID)
        webView = DAWebView(frame: .zero)

        loadWeb()
    }

    var webView:DAWebView!
    var headerView:DAHeaderView!
    
    var paymentID:String?
    var delegate:DAWebViewControllerDelegate?
    
    private let failedPath = "https://my.daroonapp.com/user/paid/failed"
    private let successfulPath = "https://my.daroonapp.com/user/paid/success"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupWebView()
    }
    
    private func setupHeaderView() {
        headerView = DAHeaderView()
        self.view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let l = NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        let r = NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let t = NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        var height = NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
        
        if Device.IS_4_INCHES_OR_SMALLER() {
            height = NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.height, multiplier: 0.11, constant: 0)
        }
        view.addConstraints([l, r, t, height])
    }
    
    
    private func setupWebView() {
        self.view.addSubview(webView)
        webView.delegate = self
        webView.backgroundColor = .white

        webView.translatesAutoresizingMaskIntoConstraints = false
        let l = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        let r = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let t = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: headerView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let b = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        view.addConstraints([l, r, t, b])

    }
    
    private func loadWeb() {
        if let id = paymentID {
            let str = path(of: .zarinPayment) + id
            if let url = URL(string: str) {
                webView.loadRequest(URLRequest(url: url))
            }
        }
    }

}

extension DAWebViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        self.dismiss(animated: true, completion: nil)
//        delegate?.didClose(controller: self, reason: .noInternet)
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let destination = webView.request?.url?.absoluteString {
            
            headerView.label.text = destination

            if destination == failedPath {
                self.dismiss(animated: true, completion: nil)
                delegate?.didClose(controller: self, reason: .failed)
                
            } else if destination == successfulPath {
                self.dismiss(animated: true, completion: nil)
                delegate?.didClose(controller: self, reason: .successful)
            }
        }
    }
}
