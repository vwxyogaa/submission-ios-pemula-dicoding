//
//  SceneDelegate.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    let mainViewController = HomeViewController()
    let navigationController = UINavigationController(rootViewController: mainViewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
  }
}
