//
//  InfoView.swift
//  SpaceX
//
//  Created by Даня on 11.04.2022.
//

import UIKit

enum Sections: Int, CaseIterable {
    case Launch = 0
    case FirstStage = 1
    case SecondStage = 2
}

class InfoView: UIView {
    
    var launchItems: [RocketLaunchViewModel]?
    var firstStage: [InfoCellViewModel]?
    var secondStage: [InfoCellViewModel]?
    
    private lazy var infoTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        table.register(RocketLaunchViewCell.self, forCellReuseIdentifier: RocketLaunchViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
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

extension InfoView {
    func setupView() {
        addSubview(infoTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoTableView.topAnchor.constraint(equalTo: topAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension InfoView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.Launch.rawValue:
            return launchItems?.count ?? 0
        case Sections.FirstStage.rawValue:
            return firstStage?.count ?? 0
        case Sections.SecondStage.rawValue:
            return secondStage?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if let firstStageViewModel = firstStage?[indexPath.row],
           let secondStageViewModel = secondStage?[indexPath.row],
           let lauchViewModel = launchItems?[indexPath.row]{
            
            switch indexPath.section {
            case Sections.Launch.rawValue:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RocketLaunchViewCell.identifier, for: indexPath) as? RocketLaunchViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: lauchViewModel)
            case Sections.FirstStage.rawValue:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: firstStageViewModel)
                return cell
            case Sections.SecondStage.rawValue:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: secondStageViewModel)
                return cell
            default:
                return UITableViewCell()
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var text = ""
        
        switch section {
        case Sections.FirstStage.rawValue:
            text = "ПЕРВАЯ СТУПЕНЬ"
        case Sections.SecondStage.rawValue:
            text = "ВТОРАЯ СТУПЕНЬ"
        default:
            text = ""
        }
        
        let title: UILabel = UILabel()
        title.text = text
        title.textColor = .white
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        title.backgroundColor = .clear
        title.textAlignment = .left
        return title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Sections.FirstStage.rawValue:
            return 24
        case Sections.SecondStage.rawValue:
            return 24
        default:
            return 0
        }
    }
}
