//
//  TabBarViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

protocol TabBarPresenting: AnyObject {
}

class TabBarViewController: UITabBarController {
    
    //IBOutlets
    
    @IBOutlet weak var tabBarView: UITabBar!
    
    //variables
    
    var tabBarPresenter = TabBarPresenter()
    
//MARK: - Lyfe Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBarControllerDelegate()
        tabBarPresenter.attachView(self)
        tabBarPresenter.setViewControllersToTabBarVC()
    }
    
    override func viewDidLayoutSubviews() {
        setTabBarItem()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: TabBarPresenting

extension TabBarViewController: TabBarPresenting {
    
}

//MARK: - TabBarController Delegate

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarPresenter.setTabBarCurrentVC(vc: viewController)
    }
    
    func setTabBarControllerDelegate() {
        self.delegate = self
    }
}

//MARK: - UI

extension TabBarViewController {
    
    func setTabBarItem() {
        self.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    }
}
