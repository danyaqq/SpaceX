//
//  DetailPresenter.swift
//  SpaceX
//
//  Created by Даня on 13.04.2022.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewControllerProtocol, networkService: NetworkServiceProtocol, titleText: String?)
    var titleText: String? { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewControllerProtocol?
    var networkService: NetworkServiceProtocol?
    var titleText: String?
    
    required init(view: DetailViewControllerProtocol, networkService: NetworkServiceProtocol, titleText: String?) {
        self.view = view
        self.networkService = networkService
        self.titleText = titleText
    }
    
    
}
