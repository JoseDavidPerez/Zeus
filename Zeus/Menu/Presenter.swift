//
//  Presenter.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation
import UIKit

internal class Presenter {
    
    public var view : ViewProtocol?
    public var interactor : InteractorProtocol?
    public var router : RouterProtocol?
    
}

extension Presenter : PresenterProtocol {
    
    func showChart(navegation: UINavigationController) {
        let nav = ChartRouter.createModule(navigation: navegation)
        navegation.pushViewController(nav, animated: true)
    }
    
}
