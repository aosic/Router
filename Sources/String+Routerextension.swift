//
//  String+Routerextension.swift
//  Router
//
//  Created by aoxingkui on 2020/7/18.
//  Copyright © 2020 aosic. All rights reserved.
//

import Foundation

public extension String {
    func routerChineseEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    func routerUrlEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:|@&=+$,/?%#[]{}").inverted) ?? ""
    }
    func routerUrlDecode() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

