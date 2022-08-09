//
//  Api.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation
import Alamofire

class Api {
    //Closure o callback
    public static func getInfo(completion: @escaping (ResponseTest?) -> Void){
        
        let url = "https://s3.amazonaws.com/dev.structure.files/examen/ios/test.json"
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { response in
            do {
                if let data = response.data {
                let decoder = JSONDecoder()
                let responseTest = try decoder.decode(ResponseTest.self, from: data)
                completion(responseTest)
                }
            } catch let error {
                print(error)
                completion(nil)
            }
        }
            
    }
}
