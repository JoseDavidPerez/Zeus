//
//  ChartPresenter.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation

internal class ChartPresenter {
    
    public var view : ChartViewProtocol?
    public var interactor : ChartInteractorProtocol?
    public var router : ChartRouterProtocol?
    
    
}

extension ChartPresenter : ChartPresenterProtocol {
    
    func getInformation() {
        interactor?.getInformation()
    }
    
    func successGetInfo(response: ResponseTest) {
        view?.reloadData(response: response)
    }
    
    func errorGetInfo() {
        view?.showError()
    }
    
    
}

