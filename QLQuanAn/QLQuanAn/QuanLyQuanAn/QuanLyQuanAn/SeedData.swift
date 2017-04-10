//
//  SeedData.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/10/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation

class SeedData {
    static func seedFoodType(){
        let data = ["Thức uống", "Lẩu", "Đồ nướng", "Hải sản", "Cơm"]
        for each in data {
            let d: FoodType = Database.create()
            d.nametype = each
        }
        Database.save()
    }
    
    static func seedCurrency(){
        let data = [("vnd", 22000.0), ("$", 1.0)]
        for each in data {
            let d: Currency = Database.create()
            d.name = each.0
            d.value = each.1
        }
        Database.save()
    }
}
