//
//  Routerable.swift
//  Router
//
//  Created by aoxingkui on 2020/7/18.
//  Copyright © 2020 aosic. All rights reserved.
//

import Foundation

@objc public protocol Routerable {
    func routerUpdate(params: Dictionary<String, Any>?)
}

@objc public protocol AutoRouterable {
    static var autoRouterKey: String {get}
}
