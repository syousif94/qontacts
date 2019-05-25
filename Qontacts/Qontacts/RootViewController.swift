//
//  ViewController.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/20/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, EMPageViewControllerDataSource {
    
    let homeViewController = HomeViewController()
    
    let profileViewController = ProfileViewController()
    
    let searchViewController = SearchViewController()
    
    var controllers: [UIViewController] {
        return [
            homeViewController,
            searchViewController,
            profileViewController
        ]
    }
    
    let loopedPageViewController = EMPageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loopedPageViewController.dataSource = self
        loopedPageViewController.selectViewController(controllers[0], direction: .forward, animated: false, completion: nil)
        addChild(loopedPageViewController)
        view.addSubview(loopedPageViewController.view)
        loopedPageViewController.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loopedPageViewController.view.pin.all()
    }
    
    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index == 0 {
            return controllers[controllers.count-1]
        }
        
        let previousIndex = index - 1
        
        let controller = controllers[previousIndex]
        
        return controller
    }
    
    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        if nextIndex == controllers.count {
            
            return controllers.first
        }
        
        let controller = controllers[nextIndex]
        
        return controller
    }
}

