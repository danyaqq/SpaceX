//
//  CharacteristicsView.swift
//  SpaceX
//
//  Created by Даня on 11.04.2022.
//

import UIKit

class CharacteristicsView: UIView {
    
    var items: [CharacteristicsViewModel]?
    
    private lazy var characteristicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .horizontal        
        
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.register(CharacteristicsViewCell.self, forCellWithReuseIdentifier: CharacteristicsViewCell.identifier)
        collectionView.contentInset = .init(top: 0, left: 32, bottom: 0, right: 32)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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

extension CharacteristicsView {
    func setupView() {
        addSubview(characteristicsCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            characteristicsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characteristicsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characteristicsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            characteristicsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

extension CharacteristicsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacteristicsViewCell.identifier, for: indexPath) as? CharacteristicsViewCell else {
            return UICollectionViewCell()
        }
        
        if let viewModel = items?[indexPath.item] {
        cell.configure(with: viewModel)
        }
        return cell
    }
}

extension CharacteristicsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 96)
    }
}
