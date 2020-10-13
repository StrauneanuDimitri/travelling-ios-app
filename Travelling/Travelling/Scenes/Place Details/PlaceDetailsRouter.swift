//
//  PlaceDetailsRouter.swift
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

protocol PlaceDetailsRoutingLogic {
    func navigateToAlert(title: String?, message: String?, actions: [UIAlertAction])
    func navigateToFullscreenImage(imageName: String?)
    func presentViewController(controller: UIViewController)
    func navigateToPlaceComments(placeId: String?)
}

class PlaceDetailsRouter: PlaceDetailsRoutingLogic {
    weak var viewController: PlaceDetailsViewController?
    
    func navigateToAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({ alertController.addAction($0) })
        self.viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToFullscreenImage(imageName: String?) {
        let fullscreenImageViewController = FullscreenImageViewController(imageName: imageName)
        fullscreenImageViewController.modalPresentationStyle = .fullScreen
        self.viewController?.present(fullscreenImageViewController, animated: true, completion: nil)
    }
    
    func presentViewController(controller: UIViewController) {
        self.viewController?.present(controller, animated: true, completion: nil)
    }
    
    func navigateToPlaceComments(placeId: String?) {
        let placeCommentsViewController = PlaceCommentsViewController(placeId: placeId)
        placeCommentsViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(placeCommentsViewController, animated: true)
    }
}
