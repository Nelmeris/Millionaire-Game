//
//  Question.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct Question: Hashable, Codable {
    let question: String
    let answers: [String]
    let correctAnswerId: Int
}
