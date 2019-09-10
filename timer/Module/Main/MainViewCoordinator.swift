//
//  MainViewCoordinator.swift
//  timer
//
//  Created by Jeong Jin Eun on 09/04/2019.
//  Copyright © 2019 Jeong Jin Eun. All rights reserved.
//

import UIKit

/// Route from main view (tab bar)
class MainViewCoordinator: CoordinatorProtocol {
     // MARK: - route enumeration
    enum MainRoute {
        case productivity
        case local
        case share
        case timeSetProcess
    }
    
    weak var viewController: MainViewController!
    let provider: ServiceProviderProtocol
    
    // MARK: - constructor
    required init(provider: ServiceProviderProtocol) {
        self.provider = provider
    }
    
    func present(for route: MainRoute) -> UIViewController? {
        guard let viewController = get(for: route) else { return nil }
        
        switch route {
        case .timeSetProcess:
            guard let rootViewController = self.viewController.navigationController?.viewControllers.first else {
                return nil
            }
            let viewControllers = [rootViewController, viewController]
            self.viewController.navigationController?.setViewControllers(viewControllers, animated: true)
            
        default:
            break
        }
        
        return viewController
    }
    
    func get(for route: MainRoute) -> UIViewController? {
        switch route {
        case .productivity:
            let coordinator = ProductivityViewCoordinator(provider: provider)
            let reactor = TimeSetEditViewReactor(timeSetService: provider.timeSetService)
            let viewController = ProductivityViewController(coordinator: coordinator)
            
            // DI
            coordinator.viewController = viewController
            viewController.reactor = reactor
            
            return viewController
            
        case .local:
            let coordinator = LocalTimeSetViewCoordinator(provider: provider)
            let reactor = LocalTimeSetViewReactor(timeSetService: provider.timeSetService)
            let viewController = LocalTimeSetViewController(coordinator: coordinator)
            
            // DI
            coordinator.viewController = viewController
            viewController.reactor = reactor
            
            return viewController
            
        case .share:
            let coordinator = SharedTimeSetViewCoordinator(provider: provider)
            let reactor = SharedTimeSetViewReactor()
            let viewController = SharedTimeSetViewController(coordinator: coordinator)
            
            // DI
            coordinator.viewController = viewController
            viewController.reactor = reactor
            
            return viewController
            
        case .timeSetProcess:
            let coordinator = TimeSetProcessViewCoordinator(provider: provider)
            guard let reactor = TimeSetProcessViewReactor(appService: provider.appService, timeSetService: provider.timeSetService) else { return nil }
            let viewController = TimeSetProcessViewController(coordinator: coordinator)
            
            // DI
            coordinator.viewController = viewController
            viewController.reactor = reactor
            
            return viewController
        }
    }
}
