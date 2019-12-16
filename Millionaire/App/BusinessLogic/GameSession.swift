//
//  GameSession.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

class GameSession {
    
    let questions: [Question]
    private(set) var score: Int
    
    init(questions: [Question]) {
        self.questions = questions
        self.score = 0
    }
    
    func scoreIncrease() {
        score += 1
    }
    
}
