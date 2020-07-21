//
//  CViewController.swift
//  RouterExample
//
//  Created by aoxingkui on 2020/7/21.
//  Copyright © 2020 aosic. All rights reserved.
//

import UIKit
import ACRouter

class CViewController: UIViewController, AutoRouterable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static var autoRouterKey: String {
        return "router:3005"
    }

}
