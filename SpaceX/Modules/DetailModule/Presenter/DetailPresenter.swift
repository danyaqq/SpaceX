//
//  DetailPresenter.swift
//  SpaceX
//
//  Created by Даня on 13.04.2022.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewControllerProtocol, networkService: NetworkServiceProtocol, titleText: String?, rocketId: String?)
    var titleText: String? { get set }
    var rocketId: String? { get set }
    var launches: [LaunchModel]? { get set }
    func getLaunches()
    func getViewModel(index: Int) -> DetailCellViewModel?
}

class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailViewControllerProtocol?
    var networkService: NetworkServiceProtocol?
    var titleText: String?
    var rocketId: String?
    var launches: [LaunchModel]?
    
    required init(view: DetailViewControllerProtocol, networkService: NetworkServiceProtocol, titleText: String?, rocketId: String?) {
        self.view = view
        self.networkService = networkService
        self.titleText = titleText
        self.rocketId = rocketId
        
        getLaunches()
    }
    
    func getLaunches() {
        guard let rocketId = rocketId else {
            return
        }

        networkService?.getLaunches(rocketId: rocketId){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let launches):
                DispatchQueue.main.async {
                    self.launches = launches.sorted(by: {$0.dateLocal > $1.dateLocal})
                    self.view?.success()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func getViewModel(index: Int) -> DetailCellViewModel? {
        guard let launches = launches?[index] else {
            return nil
        }
        let viewModel = DetailCellViewModel(name: launches.name,
                                            date: launches.dateLocal.getFormattedDateString(oldFormat: "yyyy-MM-dd'T'HH:mm:ssZ", format: "d MMMM, yyyy"),
                                            image: launches.success == true ? "success" : "fail")
        return viewModel
    }
    
}
