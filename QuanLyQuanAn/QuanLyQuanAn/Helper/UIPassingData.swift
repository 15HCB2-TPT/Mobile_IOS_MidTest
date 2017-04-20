//
//  UIPassingData.swift
//  BT_CoreData
//
//  Created by Hiroshi.Kazuo on 3/25/17.
//  Copyright © 2017 Hiroshi.Kazuo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    internal func uiPassedData(data: Any?, identity: Int) {
        print("This func need override!")
    }
    
    private func receiveData(data: Any?, identity: Int) {
        self.uiPassedData(data: data, identity: identity)
    }
    
    func sendData(to: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            to.receiveData(data: data, identity: identity)
        })
    }
    
    func pushData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        let s = UIStoryboard(name: storyboard, bundle: nil)
        let c = s.instantiateViewController(withIdentifier: controller) 
        self.navigationController?.pushViewController(c, animated: true)
        self.sendData(to: c, data: data, identity: identity, delay: delay)
    }
    
    func popData(data: Any?, identity: Int = 0, delay: Double = 0.25) {
        for controller in (self.navigationController?.viewControllers)! {
            self.navigationController?.popViewController(animated: true)
            self.sendData(to: controller, data: data, identity: identity, delay: delay)
            break
        }
    }
    
    func presentData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        let s = UIStoryboard(name: storyboard, bundle: nil)
        let c = s.instantiateViewController(withIdentifier: controller) 
        self.present(c, animated: true, completion: {
            self.sendData(to: c, data: data, identity: identity, delay: delay)
        })
    }
}

final class UIPassingData {
    static func pushData(from: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        from.pushData(storyboard: storyboard, controller: controller, data: data, identity: identity, delay: delay)
    }
    
    static func popData(from: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        from.popData(data: data, identity: identity, delay: delay)
    }
    
    static func presentData(from: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        from.presentData(storyboard: storyboard, controller: controller, data: data, identity: identity, delay: delay)
    }
}
