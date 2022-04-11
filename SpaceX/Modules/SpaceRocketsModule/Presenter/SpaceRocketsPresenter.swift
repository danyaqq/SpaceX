//
//  SpaceRocketsPresenter.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import Foundation

protocol SpaceRocketsPresenterProtocol: AnyObject {
    init(view: SpaceRocketsViewControllerProtocol, networkService: NetworkServiceProtocol)
    var rockets: [Rocket]? { get set }
    func getRockets()
}

class SpaceRocketsPresenter: SpaceRocketsPresenterProtocol {
    
    //Properties
    weak var view: SpaceRocketsViewControllerProtocol?
    let networkService: NetworkServiceProtocol?
    var rockets: [Rocket]?
    
    //Init
    required init(view: SpaceRocketsViewControllerProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        getRockets()
    }
    
    //Methods
    func getRockets() {
        networkService?.getRockets { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let rockets):
                DispatchQueue.main.async {
                    self.rockets = rockets
                    self.view?.success()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
}
