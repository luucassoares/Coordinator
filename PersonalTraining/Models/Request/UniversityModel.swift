//
//  UniversityModel.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
struct UniversityModel: Codable {
    let name: String?
    let webPages: [String]?
    let country: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case webPages = "web_pages"
        case country
    }
}
