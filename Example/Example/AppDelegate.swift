//
//  AppDelegate.swift
//  Example
//
//  Created by Nathan Tannar on 8/18/17.
//  Copyright © 2017-2018 Nathan Tannar. All rights reserved.
//

import UIKit
import InputBarAccessoryView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: VC())
        window?.makeKeyAndVisible()
                
        return true
    }
    
}

class VC: InputBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toggle))
    }

    @objc func toggle() {
        isInputBarHidden.toggle()
    }
}
