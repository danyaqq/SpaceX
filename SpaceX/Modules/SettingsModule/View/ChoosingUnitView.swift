//
//  ChoosingUnitView.swift
//  SpaceX
//
//  Created by Даня on 12.04.2022.
//

import UIKit

class ChoosingUnitView: UIView {
    
    var title: String?
    var selectedItemIndex: Int?
    var segmentedItems: [String]?
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var segmentedView: SegmentedControl = {
        let segmented = SegmentedControl()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = title
        
        segmentedView.setSegmentedWith(items: segmentedItems)
        segmentedView.setSelectedIndex(to: selectedItemIndex ?? 0)
    }

}

extension ChoosingUnitView {
    func setupView() {
        addSubview(titleLabel)
        addSubview(segmentedView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            segmentedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentedView.topAnchor.constraint(equalTo: topAnchor),
            segmentedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            segmentedView.widthAnchor.constraint(equalToConstant: 115),
            segmentedView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
