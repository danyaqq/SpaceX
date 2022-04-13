//
//  SpaceRocketsViewCellViewModel.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import Foundation


struct SpaceRocketsViewCellViewModel {
    let id: String
    let image: String
    let title: String
    let characteristics: [CharacteristicsViewModel]
    let firstStage: [InfoCellViewModel]
    let secondStage: [InfoCellViewModel]
    let launchItems: [RocketLaunchViewModel]
}
