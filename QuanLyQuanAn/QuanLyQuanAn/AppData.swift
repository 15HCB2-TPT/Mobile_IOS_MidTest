//
//  AppData.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/20/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation

struct AppData {
    //static var AppLanguage:
    static var AppCurrency: Currency?
    
    static func CurrencyFormatter(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: (AppCurrency?.countryId)!)
        return formatter.string(from: NSNumber(value: value * (AppCurrency?.value)!))!
    }
    
    static func CurrencyFormatterBack(value: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: (AppCurrency?.countryId)!)
        return formatter.number(from: value) as! Double
    }
}
