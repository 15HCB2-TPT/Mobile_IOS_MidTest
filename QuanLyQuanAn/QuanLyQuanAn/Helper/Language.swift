//
//  Language.swift
//  QuanLyQuanAn
//
//  Created by Shin-MacDesk on 4/22/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation

// constants
/// L102Language
class L102Language {
    /// get current Apple language
    
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.stringArray(forKey: AppConfigs.LANGUAGE_KEY)! as NSArray
        let current = langArray.firstObject as! String
        return current 
    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: AppConfigs.LANGUAGE_KEY)
        userdef.synchronize()
    }
}
