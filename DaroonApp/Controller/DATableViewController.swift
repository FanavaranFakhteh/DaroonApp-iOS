//
//  DATableViewController.swift
//  DaroonApp
//
//  Created by Masoud on 8/14/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import UIKit

class DATableViewController: UITableViewController {
    
    private let headerCell = "DAHeaderTableViewCell"
    private let cell_id = "DATableViewCell"
    
    var delegate:DATableViewControllerDelegate?
    private var payment:DAPayment!
    
    convenience init (payment: DAPayment) {
        self.init()
        self.payment = payment
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        
        let bundle = Bundle(identifier: "zzmasoud.DaroonApp")

        tableView.register(UINib(nibName: headerCell , bundle: bundle), forHeaderFooterViewReuseIdentifier: headerCell)

        tableView.register(UINib(nibName: cell_id, bundle: bundle), forCellReuseIdentifier: cell_id)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.bounds.height
        return height * 0.5

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DAHeaderTableViewCell") as! DAHeaderTableViewCell
        view.object = payment
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = tableView.bounds.height
        return height * 0.5
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.didSelect(index: indexPath.row)
        }
    }

}
