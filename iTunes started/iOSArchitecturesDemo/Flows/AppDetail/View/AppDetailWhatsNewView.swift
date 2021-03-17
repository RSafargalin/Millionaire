//
//  AppDetailWhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Ruslan Safargalin on 13.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

/*
 заголовок, номер версии, ее описание и дату выхода
 */

import UIKit

class AppDetailWhatsNewView: UIView {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var versionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var versionReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        backgroundColor = .clear
        
        self.addSubview(titleLabel)
        self.addSubview(versionLabel)
        self.addSubview(versionReleaseDateLabel)
        self.addSubview(versionDescriptionLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14.0),
            versionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            versionLabel.widthAnchor.constraint(equalToConstant: 150.0),
            
            versionReleaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14.0),
            versionReleaseDateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            versionDescriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 14.0),
            versionDescriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            versionDescriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
        ])
    }
}

