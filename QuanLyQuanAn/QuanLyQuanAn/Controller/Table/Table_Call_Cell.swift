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
    @IBOutlet weak var btnOrder: UIButton!
    
    // MARK: **** Modals ****
    var data: Food!
    var controller: Table_Call_Food!
    
    // MARK: **** Handlers ****
    @IBAction func btnOrder_Click(_ sender: Any) {
        controller.tfInputNum.text = ""
        controller.tfInputNum.isHidden = false
        controller.tfInputNum.inputAccessoryView = AppExtension.addCancelDoneButton(target: self, doneAct: #selector(done), cancelAct: #selector(cancel))
        controller.tfInputNum.becomeFirstResponder()
    }
    
    func done(){
        if let num = Int(controller.tfInputNum.text!) {
            controller.calledFoods.updateValue(num, forKey: data)
            var sum: Double = 0
            for each in controller.calledFoods {
                sum += each.key.money * Double(each.value)
            }
            controller.lblTotalMoney.title = "Total Money".localized(lang: L102Language.currentAppleLanguage()) + ": \(AppData.CurrencyFormatter(value: sum))"
//            if num == 0 {
//                btnOrder.titleLabel?.text = "Đặt món"
//            } else {
//                btnOrder.titleLabel?.text = "(\(num)) +"
//            }
        }
        controller.table.reloadData()
        controller.tfInputNum.isHidden = true
        controller.tfInputNum.endEditing(true)
    }
    
    func cancel(){
//        if let num = controller.calledFoods[data] {
//            if num == 0 {
//                btnOrder.titleLabel?.text = "Đặt món"
//            } else {
//                btnOrder.titleLabel?.text = "(\(num)) +"
//            }
//        }
        controller.table.reloadData()
        controller.tfInputNum.isHidden = true
        controller.tfInputNum.endEditing(true)
    }
    
}
