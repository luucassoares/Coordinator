//
//  UniversityRequest.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
class UniversityRequest: APIRequestProtocol {
    var parameters: [String : String] = [:]
    var method = RequestType.GET
    var path = "search"
    
    init(name: String) {
        parameters["name"] = name
    }
}
