//
//  SceneDelegate.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 24.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
          
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        
        func createHabitsViewController() -> UINavigationController {
            let habitsVC = HabitsViewController()
            habitsVC.tabBarItem = UITabBarItem(
                title: "Привычки",
                image: UIImage(named: "habitsIcon"),
                tag: 0
            )
            return UINavigationController(rootViewController: habitsVC)
        }
        
        func createInfoViewController() -> UINavigationController {
            let InfoViewController = InfoViewController()
            InfoViewController.tabBarItem = UITabBarItem(
                title: "Информация",
                image: UIImage(systemName: "info.circle.fill"),
                tag: 1
            )
            return UINavigationController(rootViewController: InfoViewController)
        }
        
        func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [createHabitsViewController(), createInfoViewController()]
            UITabBar.appearance().backgroundColor = .systemGray3
            UITabBar.appearance().tintColor = .purple
            return tabBarController
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

