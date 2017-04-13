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
    func uiPassedData(data: Any?, identity: Int)
}

extension UIPassingProtocol {
    func sendData(data: Any?, identity: Int) {
        self.uiPassedData(data: data, identity: identity)
    }
}

class UIPassingData {
    static func sendData(view: UIPassingProtocol, data: Any?, identity: Int = 0, delay: Double = 0.25){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            view.sendData(data: data, identity: identity)
        })
    }
    
    static func sendData(fromController: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        let s = UIStoryboard(name: storyboard, bundle: nil)
        let c = s.instantiateViewController(withIdentifier: controller) 
        fromController.present(c, animated: true, completion: { () -> Void in
            do {
                try UIPassingData.sendData(view: c as! UIPassingProtocol, data: data, identity: identity, delay: delay)
            } catch _ {
                print("Can't pass data to \(c)")
            }
        })
    }
}
