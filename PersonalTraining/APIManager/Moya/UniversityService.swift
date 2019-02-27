//
//  UniversityService.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 27/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import Moya

enum UniversityService {
    case fetchAll
    case fetchWithName(name: String)
}

extension UniversityService: TargetType {
    var baseURL: URL {
        <#code#>
    }
    
    var path: String {
        <#code#>
    }
    
    var method: Method {
        <#code#>
    }
    
    var sampleData: Data {
        <#code#>
    }
    
    var task: Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
    
}
