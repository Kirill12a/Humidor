//
//  TabBar.swift
//  Humidor
//
//  Created by Kirill Drozdov on 22.01.2022.
//

import UIKit

class TabBar: UITabBarController
{
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    UITabBar.appearance().barTintColor = .systemBackground
    tabBar.tintColor = .label
    setupVCs()
  }
  
  fileprivate func createNavController(for rootViewController: UIViewController,
                                       title: String,
                                       image: UIImage) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    navController.navigationBar.prefersLargeTitles = true
    //        rootViewController.navigationItem.title = title
    return navController
  }
  
  func setupVCs() {
    viewControllers = [
      createNavController(for: MySigarsAddSigarsViewController(), title: NSLocalizedString("Хьюмидор", comment: ""), image: UIImage(systemName: "shippingbox")!),
      createNavController(for: HistoryViewController(), title: NSLocalizedString("Банты", comment: ""), image: UIImage(named:"sigar")!),
      createNavController(for: ProfileViewController(), title: NSLocalizedString("Профиль", comment: ""), image: UIImage(systemName: "person")!)
    ]
    
  }
  
}

