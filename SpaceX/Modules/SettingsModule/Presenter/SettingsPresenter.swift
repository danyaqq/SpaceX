//
//  SettingsPresenter.swift
//  SpaceX
//
//  Created by Даня on 12.04.2022.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewControllerProtocol)
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewControllerProtocol?
    
    required init(view: SettingsViewControllerProtocol) {
        self.view = view
    }
}
