//
//  ObjectAssosiation.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation

func associatedObject<ValueType: AnyObject>(
        base: AnyObject, 
        key: UnsafePointer<UInt8>, 
        initialiser: () -> ValueType) 
        -> ValueType {
    if let associated = objc_getAssociatedObject(base, key) 
        as? ValueType { return associated }
    let associated = initialiser()
    objc_setAssociatedObject(base, key, associated, 
                             .OBJC_ASSOCIATION_RETAIN)
    return associated
}

func associateObject<ValueType: AnyObject>(
        base: AnyObject, 
        key: UnsafePointer<UInt8>, 
        value: ValueType) {
    objc_setAssociatedObject(base, key, value, 
                             .OBJC_ASSOCIATION_RETAIN)
}
