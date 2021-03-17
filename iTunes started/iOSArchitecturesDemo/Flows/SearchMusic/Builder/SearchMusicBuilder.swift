//
//  SearchMusicBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Ruslan Safargalin on 14.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchMusicBuilder {
    
    static func build() -> (UIViewController & SearchMusicViewInput) {
        let presenter = SearchMusicPresenter()
        let viewController = SearchMusicViewController(presenter: presenter)
        presenter.viewInput = viewController
        
        return viewController
    }
}
