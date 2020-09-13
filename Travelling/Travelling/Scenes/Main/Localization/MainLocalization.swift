//
//  MainLocalization.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 12/09/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class MainLocalization {
    static let shared = MainLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
        exploreTabTitle = "Explore.tab.title",
        myFavoritesTabTitle = "MyFavorites.tab.title",
        myProfileTabTitle = "MyProfile.tab.title"
    }
    
    let exploreTabTitle = LocalizedKey.exploreTabTitle.localized()
    let myFavoritesTabTitle = LocalizedKey.myFavoritesTabTitle.localized()
    let myProfileTabTitle = LocalizedKey.myProfileTabTitle.localized()
}
