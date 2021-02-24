//
//  ResultViewController.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: Variables
    
    lazy var contentView = view as! ResultView
    
    // MARK: IBActions
    
    @IBAction func backToMenuDidTap(_ sender: UIButton) {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
