//
//  Report.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation

struct Report : Codable{
    
    let value : String
    let quantity : String
    
    private enum CodingKeys : String, CodingKey {
        case value = "valor"
        case quantity = "cantidad"
    }
}

