//
//  AssemblyModuleBuilder.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import Foundation
import UIKit

protocol AssemblyModuleBuilderProtocol {
    static func spaceRocetsModule() -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyModuleBuilderProtocol {
    static func spaceRocetsModule() -> UIViewController {
        let view = SpaceRocketsViewController()
        let networkService = NetworkService()
        let presenter = SpaceRocketsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
}
