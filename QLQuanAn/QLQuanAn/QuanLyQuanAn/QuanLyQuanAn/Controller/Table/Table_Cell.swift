//
//  Table_Cell.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_Cell: UITableViewCell{
    
    // MARK: **** Elements ****
    @IBOutlet weak var tableImg: UIImageView!
    @IBOutlet weak var tableInfo: UILabel!
    @IBOutlet weak var areaInfo: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnCallPay: UIButton!
    
    // MARK: **** Models ****
    var data: Table!
    var controller: UIViewController!
    
    // MARK: **** Handlers ****
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCall_Click(_ sender: Any) {
        if data.is_empty {
            UIPassingData.pushData(from: controller, storyboard: "Main", controller: "tableCallFoodWindow", data: nil, identity: 0)
        } else {
            
        }
    }
}
