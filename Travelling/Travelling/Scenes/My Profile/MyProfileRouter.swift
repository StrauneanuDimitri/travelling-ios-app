//
//  MyProfileRouter.swift
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
import MessageUI

protocol MyProfileRoutingLogic {
    func navigateToEmail(recipient: String, subject: String)
}

class MyProfileRouter: MyProfileRoutingLogic {
    weak var viewController: MyProfileViewController?
    
    func navigateToEmail(recipient: String, subject: String) {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self.viewController
        mailViewController.setToRecipients([recipient])
        mailViewController.setSubject(subject)
        mailViewController.modalPresentationStyle = .fullScreen
        self.viewController?.present(mailViewController, animated: true, completion: nil)
    }
}
