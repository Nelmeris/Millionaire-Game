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
    private(set) var result: Observable<Float>
    
    init(questions: [Question]) {
        self.questions = questions
        self.score = 0
        self.result = Observable(0)
    }
    
    func scoreIncrease() {
        score += 1
        self.result.value = Float(score) / Float(questions.count)
    }
    
}

