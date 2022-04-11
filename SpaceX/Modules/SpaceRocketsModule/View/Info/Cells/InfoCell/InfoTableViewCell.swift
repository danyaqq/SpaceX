//
//  InfoTableViewCell.swift
//  SpaceX
//
//  Created by Даня on 11.04.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    static let identifier = "InfoTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.7920780778, green: 0.792212069, blue: 0.7920604348, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        return label
    }()
    
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5607843137, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [valueLabel, unitLabel])
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension InfoTableViewCell {
    func setupView() {
        addSubview(titleLabel)
        addSubview(rightStackView)
        
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: rightStackView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            unitLabel.widthAnchor.constraint(equalToConstant: 30),
            
            rightStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    func configure(with viewModel: InfoCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        unitLabel.text = viewModel.unit
    }
}
