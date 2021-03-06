//
//  LoginRouter.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 04/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginRoutingLogic {
    func navigateToAlert(title: String?, message: String?, actions: [UIAlertAction])
    func navigateToForgotPassword()
}

class LoginRouter: LoginRoutingLogic {
    weak var viewController: LoginViewController?
    
    func navigateToAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        actions.forEach({ alertController.addAction($0) })
        self.viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToForgotPassword() {
        let forgotPasswordViewController = ForgotPasswordViewController()
        self.viewController?.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
}
