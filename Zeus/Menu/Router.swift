//
//  Router.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation
import UIKit

internal class Router {
   

}

extension Router : RouterProtocol {
    
    public static func createModule() -> UIViewController {
        
        let viewController : ViewController = ViewController()
        
         
            let presenter = Presenter()
            let router = Router()
            let interactor = Interactor()
            
            viewController.presenter = presenter
            
            presenter.view = viewController
            presenter.interactor = interactor
            presenter.router = router

            interactor.presenter = presenter
            
            return viewController
    }
}
