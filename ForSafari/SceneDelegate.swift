//
//  SceneDelegate.swift
//  ForSafari
//
//  Created by Igor Kononov on 23.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
    }
}
