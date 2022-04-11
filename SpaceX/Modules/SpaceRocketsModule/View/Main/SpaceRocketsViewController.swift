//
//  SpaceRocketsViewController.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import UIKit

protocol SpaceRocketsViewControllerProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

class SpaceRocketsViewController: UIViewController {
    
    var presenter: SpaceRocketsPresenterProtocol!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let colletionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        colletionView.isPagingEnabled = true
        colletionView.register(SpaceRocketsViewCell.self, forCellWithReuseIdentifier: SpaceRocketsViewCell.identifier)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.backgroundColor = .black
        colletionView.contentInsetAdjustmentBehavior = .never
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        
        return colletionView
    }()
    
    private let pageControlContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "pageBlack")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.pageIndicatorTintColor = #colorLiteral(red: 0.6250877976, green: 0.6252155304, blue: 0.628690362, alpha: 1)
        control.currentPageIndicatorTintColor = .white
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isEnabled = false
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
}

extension SpaceRocketsViewController {
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .yellow
        view.addSubview(collectionView)
        view.addSubview(pageControlContainer)
        
        pageControlContainer.addSubview(pageControl)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            
            pageControlContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControlContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControlContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControlContainer.heightAnchor.constraint(equalToConstant: 40 + UIApplication.shared.windows[0].safeAreaInsets.bottom),
            
            pageControl.topAnchor.constraint(equalTo: pageControlContainer.topAnchor, constant: 24),
            pageControl.centerXAnchor.constraint(equalTo: pageControlContainer.centerXAnchor)
        ])
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
}

extension SpaceRocketsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

extension SpaceRocketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.rockets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpaceRocketsViewCell.identifier, for: indexPath) as? SpaceRocketsViewCell else {
            return UICollectionViewCell()
        }
        
        if let viewModel = presenter.getViewModel(index: indexPath.row) {
        cell.configure(with: viewModel)
        cell.configureCharacteristicsView(with: viewModel.characteristics)
        cell.configureInfoView(firstStageViewModel: viewModel.firstStage, secondStageViewModel: viewModel.secondStage, launchItemsViewModel: viewModel.launchItems)
        }
        
        cell.delegate = self
        
        return cell
    }
}

extension SpaceRocketsViewController: SpaceRocketsViewControllerProtocol {
    func success() {
        collectionView.reloadData()
        pageControl.numberOfPages = presenter.rockets?.count ?? 0
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SpaceRocketsViewController: SpaceRocketsViewCellDelegate {
    func settingsButtonDidTap() {
        let settingsVC = AssemblyModuleBuilder.createSettingsModule()
        settingsVC.modalPresentationStyle = .formSheet
        navigationController?.present(settingsVC, animated: true, completion: nil)
    }
    
    func showLaunchesButtonDidTap() {
        print("Tap")
    }
}
