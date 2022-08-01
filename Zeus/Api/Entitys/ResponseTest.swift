//
//  ResponseTest.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation

struct ResponseTest : Codable{
    
    let reports : [Report]
    let companies : [Company]
    
    private enum CodingKeys : String, CodingKey {
        case reports = "reporte"
        case companies = "empresas"
    }
}
