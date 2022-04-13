//
//  Launches.swift
//  SpaceX
//
//  Created by Даня on 13.04.2022.
//

import Foundation

struct Launches: Decodable {
    let docs: [LaunchModel]
}

struct LaunchModel: Decodable {
    let success: Bool?
    let name: String
    let dateLocal: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case success, name
        case dateLocal = "date_local"
        case id
    }
}
