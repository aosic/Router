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

    func urlQueryConvertDictionary() -> [String: Any] {
        var url_array = [""]
        if self.contains("?") {
            url_array = self.components(separatedBy:"?")
        }else{
            url_array = self.components(separatedBy: "//")
        }
        let urlComponents = url_array[1].components(separatedBy: "&")
        var params = [String: Any]()
        for keyValuePair in urlComponents {
            let pairComponents = keyValuePair.components(separatedBy:"=")
            let key = pairComponents.first?.removingPercentEncoding
            let value = pairComponents.last?.removingPercentEncoding
            if let key = key, let value = value {
                if let existValue = params[key] {
                    if var existValue = existValue as? [Any] {
                        existValue.append(value)
                        params[key] = existValue
                    } else {
                        params[key] = [existValue, value]
                    }
                } else {
                    params[key] = value
                }
            }
        }
        return params
    }
}

