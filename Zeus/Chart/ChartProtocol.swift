//
//  ChartProtocol.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation

protocol ChartViewProtocol {
    func showError()
    func reloadData(response: ResponseTest)
}

protocol ChartPresenterProtocol {
    func successGetInfo(response: ResponseTest)
    func errorGetInfo()
    func getInformation()
}

protocol ChartInteractorProtocol {
    func getInformation()
}

protocol ChartRouterProtocol {
    
}
