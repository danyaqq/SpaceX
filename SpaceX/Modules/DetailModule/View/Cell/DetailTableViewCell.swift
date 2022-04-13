//
//  DetailCollectionViewCell.swift
//  SpaceX
//
//  Created by Даня on 13.04.2022.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    static let identifier = "DetailCollectionViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "FalconSat"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.text = "2 feb, 2022io123op1i3p"
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.6250877976, green: 0.6252155304, blue: 0.628690362, alpha: 1)
        return label
    }()
    
    lazy var leftStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let rocketImageView: UIImageView = {
        let image = UIImage(systemName: "xmark")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        view.layer.cornerRadius = 24
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

extension DetailCollectionViewCell {
    func setupView() {
        addSubview(containerView)
        
        containerView.addSubview(leftStackView)
        containerView.addSubview(rocketImageView)
        
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            leftStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            leftStackView.trailingAnchor.constraint(equalTo: rocketImageView.leadingAnchor, constant: -8),
            leftStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            rocketImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            rocketImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func configure(with viewModel: DetailCellViewModel) {
        titleLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        rocketImageView.image = UIImage(named: viewModel.image)
    }
}
