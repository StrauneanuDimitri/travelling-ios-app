//
//  MyProfileInteractor.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 27/09/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyProfileBusinessLogic {
    func shouldFetchUser()
    func shouldFetchImage(request: MyProfileModels.ImageFetching.Request)
}

class MyProfileInteractor: MyProfileBusinessLogic, MyProfileWorkerDelegate {
    var presenter: MyProfilePresentationLogic?
    var worker: MyProfileWorker?
    
    var user: User?
    
    init() {
        self.worker = MyProfileWorker(delegate: self)
    }
}

extension MyProfileInteractor {
    func shouldFetchUser() {
        if let user = self.user {
            self.presenter?.presentUser(response: MyProfileModels.UserPresentation.Response(user: user))
        } else {
            // TODO: - Retrieve userId from UserDefaults?
            self.presenter?.presentWillFetchUser()
            self.worker?.fetchUser(userId: "userId")
        }
    }
    
    func successDidFetchUser(user: User) {
        self.user = user
        self.presenter?.presentUser(response: MyProfileModels.UserPresentation.Response(user: user))
        self.presenter?.presentDidFetchUser()
    }
    
    func failureDidFetchUser(error: OperationError) {
        self.presenter?.presentDidFetchUser()
    }
}

extension MyProfileInteractor {
    func shouldFetchImage(request: MyProfileModels.ImageFetching.Request) {
        let model = request.model
        if model.image == nil && model.imageName.isNilOrEmpty() {
            self.presenter?.presentPlaceholderImage(response: MyProfileModels.ImagePresentation.Response(model: model, image: nil))
        } else if model.image == nil && !model.imageName.isNilOrEmpty() && !model.isLoadingImage {
            self.presenter?.presentWillFetchImage(response: MyProfileModels.ImageFetching.Response(model: model))
            self.worker?.fetchImage(model: model)
        }
    }
    
    func successDidFetchImage(model: MyProfileModels.UserModel, image: UIImage?) {
        self.presenter?.presentImage(response: MyProfileModels.ImagePresentation.Response(model: model, image: image))
        self.presenter?.presentDidFetchImage(response: MyProfileModels.ImageFetching.Response(model: model))
    }
    
    func failureDidFetchImage(model: MyProfileModels.UserModel, error: OperationError) {
        self.presenter?.presentPlaceholderImage(response: MyProfileModels.ImagePresentation.Response(model: model, image: nil))
        self.presenter?.presentDidFetchImage(response: MyProfileModels.ImageFetching.Response(model: model))
    }
}
