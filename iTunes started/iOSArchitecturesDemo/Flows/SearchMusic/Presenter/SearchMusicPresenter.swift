//
//  SearchMusicPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Ruslan Safargalin on 14.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchMusicViewInput: class {
    
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func hideNoResults()
    func showNoResults()
    func throbber(show: Bool)
}

protocol SearchMusicViewOutput {
    
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}

class SearchMusicPresenter {
    
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchMusicViewInput)?
    
    private func requestSongs(with query: String) {
        
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func openSongDetail(with song: ITunesSong) {
//        let songDetaillViewController = SongDetailViewController(song: song)
//        viewInput?.navigationController?.pushViewController(songDetaillViewController, animated: true)
    }
}

extension SearchMusicPresenter: SearchMusicViewOutput {
    
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        requestSongs(with: query)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        openSongDetail(with: song)
    }
}

