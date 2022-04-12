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
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
}

extension SettingsViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "pageBlack")
        view.addSubview(topView)
        
        topView.addSubview(settingsLabel)
        topView.addSubview(closeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 56),
            
            settingsLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            settingsLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            closeButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -24),
            closeButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
    }
}

extension SettingsViewController: SettingsViewControllerProtocol {
    
}
