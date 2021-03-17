//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Ruslan Safargalin on 14.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let title: String
    let subtitle: String?
    let rating: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(title: model.trackName,
                             subtitle: model.artistName,
                             rating: model.collectionName >>- { "\($0)" })
    }
}
