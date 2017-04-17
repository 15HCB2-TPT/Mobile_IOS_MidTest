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
    func uiPassedData(data: Any?, identity: Int){
        print("This func need override!")
    }
    
    func sendData(data: Any?, identity: Int) {
        self.uiPassedData(data: data, identity: identity)
    }
}

private var oldControllerKey: UInt8 = 0
extension UIViewController: UIPassingProtocol {
    var _oldController: UIViewController {
        get { return associatedObject(base: self, key: &oldControllerKey) { return UIViewController() } }
        set { associateObject(base: self, key: &oldControllerKey, value: newValue) }
    }
    
    private func sendData(to: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25){
        to._oldController = self
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            to.sendData(data: data, identity: identity)
        })
    }
    
    func presentData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        let s = UIStoryboard(name: storyboard, bundle: nil)
        let c = s.instantiateViewController(withIdentifier: controller) 
        self.present(c, animated: true, completion: { () -> Void in
            self.sendData(to: c, data: data, identity: identity, delay: delay)
        })
    }
    
    func dismissData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        self.dismiss(animated: true, completion: { () -> Void in
            self.sendData(to: self._oldController, data: data, identity: identity, delay: delay)
        })
    }
    
    func popData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        self.navigationController?.popViewController(animated: true)
        self.sendData(to: self._oldController, data: data, identity: identity, delay: delay)
    }
}

final class UIPassingData {
    private static func sendData(from: UIViewController, to: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25){
        to._oldController = from
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            to.sendData(data: data, identity: identity)
        })
    }
    
    static func presentData(from: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        let s = UIStoryboard(name: storyboard, bundle: nil)
        let c = s.instantiateViewController(withIdentifier: controller) 
        from.present(c, animated: true, completion: { () -> Void in
            UIPassingData.sendData(from: from, to: c, data: data, identity: identity, delay: delay)
        })
    }
}
