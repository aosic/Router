//
//  URL+Routerextension.swift
//  Router
//
//  Created by aosic on 2020/7/21.
//  Copyright © 2020 Aosic. All rights reserved.
//

import Foundation

public extension URL {
    
    func urlQuery() -> [String: String] {
        var parameters: [String: String] = [:]
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        if let c = components {
            let queryItems = c.queryItems
            if let q = queryItems {
                for item in q {
                    parameters[item.name] = item.value
                }
            }
        }
        return parameters
    }
    
}
