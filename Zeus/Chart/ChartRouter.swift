//
//  ChartRouter.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation
import UIKit

internal class ChartRouter {
    public var navigation : UINavigationController?

}

extension ChartRouter : ChartRouterProtocol {
    
    public static func createModule(navigation: UINavigationController?) -> UIViewController {
        
        let viewController : ChartView = ChartView()
        
        if  let nav = navigation {
            let presenter = ChartPresenter()
            let router = ChartRouter()
            let interactor = ChartInteractor()
            
            viewController.presenter = presenter
            
            presenter.view = viewController
            presenter.interactor = interactor
            presenter.router = router

            router.navigation = nav
            interactor.presenter = presenter
            
            return viewController
        }
            return UIViewController()
    }
}
