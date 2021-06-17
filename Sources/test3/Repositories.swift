//
//  Repositories.swift
//  test3
//
//  Created by Artem on 25.01.2021.
//

import Foundation

struct Repositories: Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

typealias repositoriesArray = [Repositories]





