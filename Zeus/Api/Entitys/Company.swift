//
//  Company.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation

struct Company : Codable{
    
    let name : String
    let percentage : Int
    
    private enum CodingKeys : String, CodingKey {
        case name = "nombre"
        case percentage = "porcentaje"
    }
}
