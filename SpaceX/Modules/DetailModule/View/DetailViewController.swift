//
//  DetailViewController.swift
//  SpaceX
//
//  Created by Даня on 13.04.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    
    private lazy var launchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 40, left: 0, bottom: 0, right: 0)
        collectionView.allowsSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension DetailViewController {
    func setupViews() {
        title = presenter?.titleText
        view.backgroundColor = .black
        view.addSubview(launchCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            launchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            launchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            launchCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            launchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backItem?.title = "Назад"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.launches?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let viewModel = presenter.getViewModel(index: indexPath.row) {
        cell.configure(with: viewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: 100)
    }
    
}

extension DetailViewController: DetailViewControllerProtocol {
    func success() {
        self.launchCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
