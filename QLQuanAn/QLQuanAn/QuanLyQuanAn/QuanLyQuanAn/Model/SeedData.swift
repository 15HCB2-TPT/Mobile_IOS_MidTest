//
//  SeedData.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/10/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation
import UIKit

class SeedData {
    private static let SEED_ENABLE = true
    
    static func seedData(){
        if SEED_ENABLE {
            clearData()
            seedFoodType()
            seedCurrency()
            seedRegion()
            seedTable()
        }
    }
    
    private static func clearData(){
        Database.clear(entityName: "DetailsOrder")
        Database.clear(entityName: "Order")
        Database.clear(entityName: "Table")
        Database.clear(entityName: "Region")
        Database.clear(entityName: "FoodType")
        Database.clear(entityName: "Food")
        Database.save()
    }
    
    private static func seedFoodType(){
        let data = ["Thức uống", "Lẩu", "Đồ nướng", "Hải sản", "Cơm"]
        for each in data {
            let d: FoodType = Database.create()
            d.nametype = each
        }
        Database.save()
    }
    
    private static func seedCurrency(){
        let data = [("vnd", 22000.0), ("$", 1.0)]
        for each in data {
            let d: Currency = Database.create()
            d.name = each.0
            d.value = each.1
        }
        Database.save()
    }
    
    private static func seedRegion(){
        let data = [("Trong nhà", ""), ("Ngoài trời", ""), ("Sân vườn", "")]
        for each in data {
            let d: Region = Database.create()
            d.name = each.0
            d.des = each.1
            d.image = UIImage(named: "Partly Cloudy Day Filled-50-SIlver")?.pngRepresentationData
        }
        Database.save()
    }
    
    private static func seedTable(){
        var id =  1
        for reg in Database.select(entityName: "Region") as! [Region] {
            let data = [("\(id)A1", Int32.random(lower: 2, upper: 4)), ("\(id)A2", Int32.random(lower: 2, upper: 4)), ("\(id)A3", Int32.random(lower: 2, upper: 4)), ("\(id)B1", Int32.random(lower: 4, upper: 12)), ("\(id)B2", Int32.random(lower: 4, upper: 12))]
            for each in data {
                let d: Table = Database.create()
                d.name = each.0
                d.number = each.1
                d.table_region = reg
                d.is_empty = true
            }
            id += 1
        }
        Database.save()
    }
}
