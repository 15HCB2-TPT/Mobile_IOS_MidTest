//
//  Table_Call_Cell.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/20/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_Call_Cell: UITableViewCell{
    
    // MARK: **** Elements ****
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    // MARK: **** Modals ****
    var data: Food!
    var controller: UIViewController!
    
    // MARK: **** Handlers ****
    @IBAction func btnOrder_Click(_ sender: Any) {
        
    }
    
}
