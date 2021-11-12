//
//  SceneDelegate.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = initialViewController()
        window?.makeKeyAndVisible()
    }
    
    private func initialViewController() -> UIViewController {
        let controller = HomeViewController(lists: [])
        controller.title = "Home"
        return UINavigationController(rootViewController: controller)
    }
}
