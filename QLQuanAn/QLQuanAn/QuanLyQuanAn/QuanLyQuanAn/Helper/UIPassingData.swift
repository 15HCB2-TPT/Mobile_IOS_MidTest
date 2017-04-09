//
//  UIPassingData.swift
//  BT_CoreData
//
//  Created by Hiroshi.Kazuo on 3/25/17.
//  Copyright © 2017 Hiroshi.Kazuo. All rights reserved.
//

import Foundation
import UIKit

protocol UIPassingProtocol {
    func uiPassedData(data: Any?)
}

extension UIPassingProtocol {
    func sendData(data: Any?) {
        self.uiPassedData(data: data)
    }
}

class UIPassingData {
    static func sendData(view: UIPassingProtocol, data: Any?, delay: Double = 0.25){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            view.sendData(data: data)
        })
    }
}
