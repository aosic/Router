//
//  Router.swift
//  Router
//
//  Created by aosic on 2020/7/13.
//  Copyright © 2020 Aosic. All rights reserved.
//

import UIKit

@objc public class Router: NSObject {
    
    @objc public var urlProtocolHeader: String?
    
    @objc public static let shared = Router()
    
    var storeCache: Dictionary<String, Any> = [:]
    
    @objc public var errorHandler: ((String)-> Void)?

    @objc public static func register(key: String, className: String) {
        Router.shared.storeCache.updateValue(className, forKey: key)
    }
    @objc public static func register(key: String, callBack: @escaping (String, Any) -> Void) {
        Router.shared.storeCache.updateValue(callBack, forKey: key)
    }
    @objc public static func remove(key: String) {
        Router.shared.storeCache.removeValue(forKey: key)
    }
    
    @objc public static func removeAll() {
        Router.shared.storeCache.removeAll()
    }
    
    @objc public static func canOpen(url: String) -> Bool {
        let U = URL(string: url)
        guard U != nil, U?.host != nil, U?.path != nil else {
            return false
        }
        let key = U!.host! + U!.path + ":\(U!.port!)"
        return Router.shared.storeCache[key] != nil
    }

    @objc public static func open(url: String, params: Dictionary<String, Any>? = nil) {
        if let header = Router.shared.urlProtocolHeader {
            if !url.hasPrefix(header) {
                Router.shared.errorHandler?("路由调用\(url)未使用\(header)协议头")
                return
            }
        }
        if Router.canOpen(url: url) == false {
            Router.shared.errorHandler?(url)
            return
        }
        let U = URL(string: url)
        guard U != nil, U?.host != nil, U?.path != nil else {
            Router.shared.errorHandler?(url)
            return
        }
        let key = U!.host! + U!.path + ":\(U!.port!)"
        let v = Router.shared.storeCache[key]!

        let urlParams = U!.urlQuery() as [String: Any]
        let routerParams = urlParams.merging(params ?? [:]) { (_, new) in new }
        
        if v is String {
            let clsName = v as! String
            guard let cls:AnyClass = NSClassFromString(clsName) else {
                Router.shared.errorHandler?(clsName)
                return
            }
            let objCls = cls as! NSObject.Type
            
            let object = objCls.init()
            
            if object.conforms(to: Routerable.self) {
                let routerableValue = object as! Routerable
                routerableValue.routerUpdate(params: routerParams)
            }

            if object.isKind(of: UIViewController.self) {
                let vc = object as! UIViewController
                vc.hidesBottomBarWhenPushed = true
                Router.topViewController().navigationController?.pushViewController(vc, animated: true)
            }
        } else if v is ((String, Any) -> ()) {
            let callBack = v as! ((String, Any) -> ())
            callBack(url, routerParams)
        }
    }
    

    private override init() {
        super.init()
    }
    
}

public extension Router {
    @objc class func topViewController() -> UIViewController{
        let rootVc = UIApplication.shared.windows.first?.rootViewController
        let currentVc = topViewControllerFrom(rootVc!)
        return currentVc
    }
    class private func topViewControllerFrom(_ rootVc:UIViewController) -> UIViewController{
        var currentVc:UIViewController

        var rootCtr = rootVc
        if (rootCtr.presentedViewController != nil) {
            rootCtr = rootVc.presentedViewController!
        }
        if rootVc.isKind(of:UITabBarController.classForCoder()) {
            currentVc = topViewControllerFrom((rootVc as!UITabBarController).selectedViewController!)
        }else if rootVc.isKind(of:UINavigationController.classForCoder()){
            currentVc = topViewControllerFrom((rootVc as!UINavigationController).visibleViewController!)
        }else{
            currentVc = rootCtr
        }
        return currentVc
    }
}

public extension Router {
    
    static func autoRegister(with appDelegate: UIApplicationDelegate) {
        var count: UInt32 = 0
        guard let image = class_getImageName(object_getClass(appDelegate)),
            let classes = objc_copyClassNamesForImage(image, &count) else {
                print("ERROR, 应用未正常启动")
                return
        }
        
        for i in 0 ..< Int(count) {
                
            if let c = String(cString: classes[i], encoding: .utf8) {
                if let cls:AnyClass = NSClassFromString(c) {
                    if cls is AutoRouterable.Type {
                        let autoCls = cls as! AutoRouterable.Type
                        let key = autoCls.autoRouterKey
                        Router.shared.storeCache.updateValue(c, forKey: key)
                    }

                }
                
            }

        }
    }
    
}
