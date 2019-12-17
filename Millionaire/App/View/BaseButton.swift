//
//  BaseButton.swift
//  Millionaire
//
//  Created by Artem Kufaev on 17.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setTitleColor(.white, for: .normal)
        self.padding = 10
        self.borderColor = .white
        self.borderWidth = 2
        self.cornerRadius = self.bounds.height / 2
    }

}
