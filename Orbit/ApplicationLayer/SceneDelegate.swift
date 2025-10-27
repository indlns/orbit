//
//  SceneDelegate.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = RemindersListViewController()
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        self.window?.windowScene = scene
        self.window?.makeKeyAndVisible()
    }
}
