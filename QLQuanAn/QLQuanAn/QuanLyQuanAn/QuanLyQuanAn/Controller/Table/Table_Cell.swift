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
    @IBOutlet weak var btnCall: UIButton!
    
    // MARK: **** Models ****
    var data: Table!
    var controller: UIViewController!
    
    // MARK: **** Handlers ****
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCall_Click(_ sender: Any) {
        UIPassingData.presentData(from: controller, storyboard: "Main", controller: "tableCallFoodWindow", data: nil, identity: 0)
    }
}
