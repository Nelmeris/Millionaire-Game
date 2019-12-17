//
//  ResultsTableViewCell.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setScore(_ score: Float) {
        let percents = score * 100
        let s = NSString(format: "%.0f", percents)
        scoreLabel.text = (s as String) + "%"
    }
    
    func setDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm:ss a"
        dateLabel.text = dateFormatter.string(from: date)
    }

}
