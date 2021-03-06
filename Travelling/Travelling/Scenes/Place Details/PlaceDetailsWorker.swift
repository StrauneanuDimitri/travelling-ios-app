//
//  PlaceDetailsWorker.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 08/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PlaceDetailsWorkerDelegate: class {
    func successDidFetchPlace(place: Place)
    func failureDidFetchPlace(error: OperationError)
    
    func successDidFetchImage(model: PlaceDetailsModels.PhotoModel, image: UIImage?)
    func failureDidFetchImage(model: PlaceDetailsModels.PhotoModel, error: OperationError)
}

class PlaceDetailsWorker {
    weak var delegate: PlaceDetailsWorkerDelegate?
    
    var placesTask: PlacesTaskProtocol = TaskConfigurator.shared.placesTask()
    var imageTask: ImageTaskProtocol = TaskConfigurator.shared.imageTask()
    
    init(delegate: PlaceDetailsWorkerDelegate?) {
        self.delegate = delegate
    }
    
    func fetchPlace(placeId: String?) {
        self.placesTask.fetchPlace(model: PlacesTaskModels.FetchPlace.Request(placeId: placeId)) { result in
            switch result {
                case .success(let response): self.delegate?.successDidFetchPlace(place: response.place); break
                case .failure(let error): self.delegate?.failureDidFetchPlace(error: error); break
            }
        }
    }
    
    func fetchImage(model: PlaceDetailsModels.PhotoModel) {
        self.imageTask.fetchImage(model: ImageTaskModels.Fetch.Request(imageName: model.imageName)) { result in
            switch result {
                case .success(let response): self.delegate?.successDidFetchImage(model: model, image: response.image); break
                case .failure(let error): self.delegate?.failureDidFetchImage(model: model, error: error); break
            }
        }
    }
}
