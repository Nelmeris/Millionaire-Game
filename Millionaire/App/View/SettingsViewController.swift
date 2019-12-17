//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var sortTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch Game.shared.sortType {
        case .sequential:
            sortTypeSegmentedControl.selectedSegmentIndex = 0
        case .random:
            sortTypeSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func changeSortType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                Game.shared.sortType = .sequential
            case 1:
                Game.shared.sortType = .random
        default:
            break
        }
    }

}
