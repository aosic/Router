//
//  ViewController.swift
//  RouterExample
//
//  Created by aoxingkui on 2020/7/20.
//  Copyright © 2020 aosic. All rights reserved.
//

import UIKit
import Router

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "启动界面"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Router.open("router://router:3003?")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Router.open("router://router:3004?")
        }
    }

}

