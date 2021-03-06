//
//  LoginViewController+DisplayLogic.swift
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

protocol LoginDisplayLogic: class {
    func displaySetupItems(viewModel: LoginModels.SetupItems.ViewModel)
    
    func displayUpdateItem(viewModel: LoginModels.UpdateItem.ViewModel)
    func displayValidationError(viewModel: LoginModels.ValidateItem.ViewModel)
    
    func displayActivateTextField(viewModel: LoginModels.ActivateTextField.ViewModel)
    
    func displayEnableItem(viewModel: LoginModels.EnableItem.ViewModel)
    func displayDisableItem(viewModel: LoginModels.EnableItem.ViewModel)
    
    func displayLoadingItem(viewModel: LoginModels.LoadingItem.ViewModel)
    func displayNotLoadingItem(viewModel: LoginModels.LoadingItem.ViewModel)
    
    func displayEnableUserInteraction()
    func displayDisableUserInteraction()
    
    func displayNavigateToForgotPassword()
    
    func displayUserDetails(viewModel: LoginModels.UserDetails.ViewModel)
    func displayErrorAlert(viewModel: LoginModels.LoginError.ViewModel)
}

extension LoginViewController: LoginDisplayLogic {
    func displaySetupItems(viewModel: LoginModels.SetupItems.ViewModel) {
        DispatchQueue.main.async {
            self.displayedItems = viewModel.displayedItems
            self.tableView?.reloadData()
        }
    }
    
    func displayUpdateItem(viewModel: LoginModels.UpdateItem.ViewModel) {
        DispatchQueue.main.async {
            (self.displayedItemModel(type: viewModel.type) as? LoginModels.DisplayedTextItem)?.text = viewModel.text
        }
    }
    
    func displayValidationError(viewModel: LoginModels.ValidateItem.ViewModel) {
        DispatchQueue.main.async {
            (self.displayedItemModel(type: viewModel.type) as? LoginModels.DisplayedTextItem)?.displayError = viewModel.displayError
            self.reloadItem(itemType: viewModel.type)
        }
    }
    
    func displayActivateTextField(viewModel: LoginModels.ActivateTextField.ViewModel) {
        DispatchQueue.main.async {
            if let value = self.textFields.first(where: { $0.1 == viewModel.type }) {
                value.0?.becomeFirstResponder()
            }
        }
    }
    
    func displayEnableItem(viewModel: LoginModels.EnableItem.ViewModel) {
        DispatchQueue.main.async {
            (self.displayedItemModel(type: viewModel.type) as? LoginModels.DisplayedButtonItem)?.isEnabled = true
            self.reloadItem(itemType: viewModel.type)
        }
    }
    
    func displayDisableItem(viewModel: LoginModels.EnableItem.ViewModel) {
        DispatchQueue.main.async {
            (self.displayedItemModel(type: viewModel.type) as? LoginModels.DisplayedButtonItem)?.isEnabled = false
            self.reloadItem(itemType: viewModel.type)
        }
    }
    
    private func reloadItem(itemType: LoginModels.ItemType) {
        if let index = self.displayedItems.firstIndex(where: { $0.type == itemType }) {
            self.tableView?.reloadRowsWithoutAnimation(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    func displayLoadingItem(viewModel: LoginModels.LoadingItem.ViewModel) {
        DispatchQueue.main.async {
            (self.displayedItemModel(type: viewModel.type) as? LoginModels.DisplayedButtonItem)?.isLoading = true
            self.reloadItem(itemType: viewModel.type)
        }
    }
    
    func displayNotLoadingItem(viewModel: LoginModels.LoadingItem.ViewModel) {
        DispatchQueue.main.async {
            (self.displayedItemModel(type: viewModel.type) as? LoginModels.DisplayedButtonItem)?.isLoading = false
            self.reloadItem(itemType: viewModel.type)
        }
    }
    
    func displayEnableUserInteraction() {
        DispatchQueue.main.async {
            self.tableView?.isUserInteractionEnabled = true
        }
    }
    
    func displayDisableUserInteraction() {
        DispatchQueue.main.async {
            self.tableView?.isUserInteractionEnabled = false
        }
    }
    
    func displayNavigateToForgotPassword() {
        DispatchQueue.main.async {
            self.router?.navigateToForgotPassword()
        }
    }
    
    func displayUserDetails(viewModel: LoginModels.UserDetails.ViewModel) {
        DispatchQueue.main.async {
            self.delegate?.loginViewController(self, didLoginUser: viewModel.user)
        }
    }
    
    func displayErrorAlert(viewModel: LoginModels.LoginError.ViewModel) {
        DispatchQueue.main.async {
            let okAction = UIAlertAction(title: viewModel.okTitle, style: .cancel, handler: nil)
            self.router?.navigateToAlert(title: nil, message: viewModel.message, actions: [okAction])
        }
    }
    
    private func displayedItemModel(type: LoginModels.ItemType) -> Any? {
        return self.displayedItems.first(where: { $0.type == type })?.model
    }
}
