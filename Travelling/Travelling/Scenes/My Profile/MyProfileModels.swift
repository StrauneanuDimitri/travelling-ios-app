//
//  MyProfileModels.swift
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

enum MyProfileModels {
    enum ItemType {
        case user
        case logout
        case reportIssue
        case version
    }
    
    struct DisplayedItem: Equatable {
        static func == (lhs: MyProfileModels.DisplayedItem, rhs: MyProfileModels.DisplayedItem) -> Bool {
            return lhs.type == rhs.type
        }
        
        var type: ItemType
        var model: Any?
    }
    
    class UserModel {
        var name: NSAttributedString?
        var title: NSAttributedString?
        var description: NSAttributedString?
        
        var image: UIImage?
        var imageName: String?
        var imageContentMode: UIView.ContentMode = .scaleAspectFill
        var imageDominantColor: UIColor?
        var isLoadingImage: Bool = false
        
        weak var cellInterface: MyProfileInformationTableViewCellInterface?
    }
    
    struct TitleModel {
        var title: NSAttributedString?
    }
    
    enum UserPresentation {
        struct Response {
            let user: User
        }
        
        struct ViewModel {
            let items: [DisplayedItem]
        }
    }
    
    enum ImageFetching {
        struct Request {
            let model: UserModel
        }
        
        struct Response {
            let model: UserModel
        }
        
        struct ViewModel {
            let model: UserModel
        }
    }
    
    enum ImagePresentation {
        struct Response {
            let model: UserModel
            let image: UIImage?
        }
        
        struct ViewModel {
            let model: UserModel
            let image: UIImage?
            let contentMode: UIView.ContentMode
        }
    }
}
