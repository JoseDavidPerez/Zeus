//
//  ChartInteractor.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation

internal class ChartInteractor {
    public var presenter : ChartPresenterProtocol?
    
}

extension ChartInteractor : ChartInteractorProtocol {
    
    func getInformation(){
        Api.getInfo { responseTest in
            if let responseTest = responseTest {
                self.presenter?.successGetInfo(response: responseTest)
            } else {
                self.presenter?.errorGetInfo()
            }
        }
    }
}
