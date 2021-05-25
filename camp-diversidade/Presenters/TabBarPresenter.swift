//
//  TabBarPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func setViewControllersToTabBarVC()
    func setTabBarCurrentVC(vc: UIViewController)
}

class TabBarPresenter {
    
    weak var view: TabBarPresenting?
    public var coordinator: AppCoordinator?
    
    init() {
        //load
    }
    
    func attachView(_ view: TabBarPresenting) {
        self.view = view
    }
}

extension TabBarPresenter: TabBarDelegate  {
    func setTabBarCurrentVC(vc: UIViewController) {
        coordinator?.tabBarCurrentVC = vc
    }
    
    public func setViewControllersToTabBarVC() {
        let tabBarViewVC = view as? TabBarViewController
        tabBarViewVC?.setViewControllers(coordinator?.instantiateTabBarVCS(), animated: true)
    }
}
