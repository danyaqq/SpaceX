//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Даня on 12.04.2022.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {
    
}

class SettingsViewController: UIViewController {

    var presenter: SettingsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }

}

extension SettingsViewController: SettingsViewControllerProtocol {
    
}
