//
//  ReportItem.swift
//  QuanLyQuanAn
//
//  Created by Shin-Mac on 4/16/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation

class ReportItem {
    var name:String = ""
    var number:Int32 = 0
    var money:Double = 0.0
    var date:Date = Date()
    func getMoney()->Double{
        return money * Double(number)
    }
}
