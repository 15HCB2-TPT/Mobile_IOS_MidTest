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
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnPay: UIButton!
    
    // MARK: **** Modals ****
    var data: Table!
    var controller: Table_Main!
    
    // MARK: **** Handlers ****
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCall_Click(_ sender: Any) {
        if data.is_deleted {
            controller.alert(title: "Alert".localized(lang: L102Language.currentAppleLanguage()), msg: "Can't order this food for this table".localized(lang: L102Language.currentAppleLanguage()), btnTitle: "Next".localized(lang: L102Language.currentAppleLanguage()))
            return
        }
        if data.is_empty {
            UIPassingData.pushData(from: controller, storyboard: "Main", controller: "tableCallFoodWindow", data: data, identity: 1)
        } else {
            UIPassingData.pushData(from: controller, storyboard: "Main", controller: "tableCallFoodWindow", data: (data, Database.isExistAndGet(entityName: "Order", predicater: NSPredicate(format: "order_table.name == %@ AND is_paid == %i", data.name!, 0)) as! Order), identity: 2)
        }
    }
    
    @IBAction func btnPay_Click(_ sender: Any) {
        UIPassingData.pushData(from: controller, storyboard: "Main", controller: "tablePayFoodWindow", data: Database.isExistAndGet(entityName: "Order", predicater: NSPredicate(format: "order_table.name == %@ AND is_paid == %i", data.name!, 0)) as! Order, identity: 0)
    }
    
}
