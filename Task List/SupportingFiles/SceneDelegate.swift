//
//  SceneDelegate.swift
//  Task List
//
//  Created by Vladimir Stepanchikov on 11.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        LaunchScreenManager.instance.animateAfterLaunch(window!.rootViewController!.view)
    }
    
}

