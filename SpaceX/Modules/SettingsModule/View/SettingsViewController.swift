//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Даня on 12.04.2022.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {
    func closeButtonDidTapped()
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
        button.addTarget(nil, action: #selector(closeButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heightSegmentView: ChoosingUnitView = {
       let view = ChoosingUnitView()
        view.title = "Высота"
        view.segmentedItems = ["m", "ft"]
        view.selectedItemIndex = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let diameterSegmentView: ChoosingUnitView = {
       let view = ChoosingUnitView()
        view.title = "Диаметр"
        view.segmentedItems = ["m", "ft"]
        view.selectedItemIndex = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let weightSegmentView: ChoosingUnitView = {
       let view = ChoosingUnitView()
        view.title = "Масса"
        view.segmentedItems = ["kg", "lb"]
        view.selectedItemIndex = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let payloadSegmentView: ChoosingUnitView = {
       let view = ChoosingUnitView()
        view.title = "Полезная нагрузка"
        view.segmentedItems = ["kg", "lb"]
        view.selectedItemIndex = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [heightSegmentView, diameterSegmentView, weightSegmentView, payloadSegmentView])
        stack.axis = .vertical
        stack.spacing = 27
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    @objc
    func closeButtonDidTap() {
        presenter?.dismissSettings()
    }
    
}

extension SettingsViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "pageBlack")
        view.addSubview(topView)
        view.addSubview(stackView)
        
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
            closeButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            stackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 56),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
}

extension SettingsViewController: SettingsViewControllerProtocol {
    func closeButtonDidTapped() {
        dismiss(animated: true, completion: nil)
    }
}
