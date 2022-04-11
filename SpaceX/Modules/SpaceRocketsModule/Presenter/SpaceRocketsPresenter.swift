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
    func getViewModel(index: Int) -> SpaceRocketsViewCellViewModel?
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
    
    func getViewModel(index: Int) -> SpaceRocketsViewCellViewModel? {
        
        guard let rocket = rockets?[index] else {
            return nil
        }
        
        return SpaceRocketsViewCellViewModel(image: rocket.flickrImages.first ?? "", title: rocket.name, characteristics: [
            CharacteristicsViewModel(title: "Высота, ft", value: "\(rocket.height.feet ?? 0)"),
            CharacteristicsViewModel(title: "Диаметр, ft", value: "\(rocket.diameter.feet ?? 0)"),
            CharacteristicsViewModel(title: "Масса, lb", value: "\(rocket.mass.lb)"),
            CharacteristicsViewModel(title: "Нагрузка, lb", value: "\(rocket.payloadWeights.first(where: { $0.id == "leo"})?.lb ?? 0)")
        ], firstStage: [
            InfoCellViewModel(title: "Количество двигателей", value: "\(rocket.firstStage.engines)", unit: ""),
            InfoCellViewModel(title: "Количество топлива", value: "\(rocket.firstStage.fuelAmountTons)", unit: "ton"),
            InfoCellViewModel(title: "Время сгорания", value: "\(rocket.firstStage.burnTimeSEC ?? 0)", unit: "sec")
        ], secondStage: [
            InfoCellViewModel(title: "Количество двигателей", value: "\(rocket.secondStage.engines)", unit: ""),
            InfoCellViewModel(title: "Количество топлива", value: "\(rocket.secondStage.fuelAmountTons)", unit: "ton"),
            InfoCellViewModel(title: "Время сгорания", value: "\(rocket.secondStage.burnTimeSEC ?? 0)", unit: "sec")
        ], launchItems: [
            RocketLaunchViewModel(title: "Первый запуск", value: "\(rocket.firstFlight.getFormattedDateString(format: "d MMMM, yyyy"))"),
            RocketLaunchViewModel(title: "Страна", value: "\(rocket.country)"),
            RocketLaunchViewModel(title: "Стоимость запуска", value: "$\(rocket.costPerLaunch / 1000000) млн")
        ])
    }
    
}
