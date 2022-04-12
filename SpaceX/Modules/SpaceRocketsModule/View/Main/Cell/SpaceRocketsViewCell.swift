//
//  SpaceRocketsViewCell.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import Foundation
import SDWebImage
import UIKit

protocol SpaceRocketsViewCellDelegate: AnyObject {
    func settingsButtonDidTap()
    func showLaunchesButtonDidTap(with titleText: String?)
}

class SpaceRocketsViewCell: UICollectionViewCell {
    
    static let identifier = "SpaceRocketsViewCell"
    
    weak var delegate: SpaceRocketsViewCellDelegate?
    
    var titleText: String?
    
    private lazy var myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let rocketImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleRocketView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "settings")
        button.setImage(image?.withTintColor(#colorLiteral(red: 0.7920895219, green: 0.792201519, blue: 0.7920541167, alpha: 1), renderingMode: .automatic), for: .normal)
        button.addTarget(nil, action: #selector(settingsButtonDidTap), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var characteristicsView: CharacteristicsView = {
        let view = CharacteristicsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleRocketView, settingsButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var infoView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Посмотреть запуски", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = #colorLiteral(red: 0.1293970644, green: 0.1294214725, blue: 0.1293893754, alpha: 1)
        button.layer.masksToBounds = true
        button.addTarget(nil, action: #selector(showLaunchesButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rocketImageView, containerView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    func settingsButtonDidTap() {
        delegate?.settingsButtonDidTap()
    }
    
    @objc
    func showLaunchesButtonDidTap(){
        delegate?.showLaunchesButtonDidTap(with: titleText)
    }
}

extension SpaceRocketsViewCell {
    func setupView() {
        contentView.addSubview(myScrollView)
        contentView.backgroundColor = .black
        
        myScrollView.addSubview(stackView)
        
        containerView.addSubview(topStackView)
        containerView.addSubview(characteristicsView)
        containerView.addSubview(infoView)
        containerView.addSubview(showButton)
        
        containerView.layer.cornerRadius = 32
        showButton.layer.cornerRadius = 12
    }
    
    func setupConstraints() {
        myScrollView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        myScrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        myScrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: myScrollView.bottomAnchor).isActive = true
        
        rocketImageView.heightAnchor.constraint(equalToConstant: 268).isActive = true
        rocketImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        containerView.topAnchor.constraint(equalTo: rocketImageView.bottomAnchor, constant: -20).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        containerView.bottomAnchor.constraint(equalTo: myScrollView.bottomAnchor).isActive = true
        
        topStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true
        topStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28).isActive = true
        
        characteristicsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        characteristicsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        characteristicsView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 32).isActive = true
        characteristicsView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        
        infoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        infoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true
        infoView.topAnchor.constraint(equalTo: characteristicsView.bottomAnchor, constant: 16).isActive = true
        infoView.bottomAnchor.constraint(equalTo: showButton.topAnchor, constant: -20).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 468).isActive = true
        
        showButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        showButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true
        showButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -56).isActive = true
        showButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    func configure(with viewModel: SpaceRocketsViewCellViewModel) {
        rocketImageView.sd_setImage(with: URL(string: viewModel.image), completed: nil)
        titleRocketView.text = viewModel.title
    }
    
    func configureCharacteristicsView(with viewModels: [CharacteristicsViewModel]) {
        characteristicsView.items = viewModels
    }
    
    func configureInfoView(firstStageViewModel: [InfoCellViewModel],
                           secondStageViewModel: [InfoCellViewModel],
                           launchItemsViewModel: [RocketLaunchViewModel]) {
        infoView.firstStage = firstStageViewModel
        infoView.secondStage = secondStageViewModel
        infoView.launchItems = launchItemsViewModel
    }
}
