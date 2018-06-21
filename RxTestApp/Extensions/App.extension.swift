//
//  App.extension.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/20.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import Foundation

public final class AppExtension<Base> {
    let base: Base
    public init(base: Base) {
        self.base = base
    }
}

public protocol AppExtensionCompatible {
    associatedtype AppExtensionType
    static var rxapp: AppExtensionType.Type { get }
    var rxapp: AppExtensionType { get }
}

public extension AppExtensionCompatible {
    
    public static var rxapp: AppExtension<Self>.Type {
        return AppExtension<Self>.self
    }
    
    public var rxapp: AppExtension<Self> {
        return AppExtension(base: self)
    }
}
