//
//  CharacteristicsViewCell.swift
//  SpaceX
//
//  Created by Даня on 11.04.2022.
//

import UIKit

class CharacteristicsViewCell: UICollectionViewCell {
    
    static let identifier = "CharacteristicsViewCell"
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6250877976, green: 0.6252155304, blue: 0.628690362, alpha: 1)
        return label
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension CharacteristicsViewCell {
    func setupView() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        
        containerView.layer.cornerRadius = 32
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func configure(with viewModel: CharacteristicsViewModel) {
        bottomLabel.text = viewModel.title
        topLabel.text = viewModel.value
    }
}
