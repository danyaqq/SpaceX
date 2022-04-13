//
//  AssemblyModuleBuilder.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import Foundation
import UIKit

protocol AssemblyModuleBuilderProtocol {
    static func createSpaceRocetsModule() -> UIViewController
    static func createSettingsModule() -> UIViewController
    static func createDetailModule(with titleText: String?, rocketId: String?) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyModuleBuilderProtocol {
    static func createSpaceRocetsModule() -> UIViewController {
        let view = SpaceRocketsViewController()
        let networkService = NetworkService()
        let presenter = SpaceRocketsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    static func createSettingsModule() -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
    
    static func createDetailModule(with titleText: String?, rocketId: String?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, titleText: titleText, rocketId: rocketId)
        view.presenter = presenter
        
        return view
    }
}
