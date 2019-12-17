//
//  ShowQuestionsStrategy.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

protocol ShowQuestionsStrategy {
    func sortQuestions(_ questions: [Question]) -> [Question]
}

enum QuestionsSortType {
    case sequential, random
    
    func getSorter() -> ShowQuestionsStrategy {
        switch self {
        case .random:
            return RandomSorter()
        case .sequential:
            return SequentialSorter()
        }
    }
}

class SequentialSorter: ShowQuestionsStrategy {
    func sortQuestions(_ questions: [Question]) -> [Question] {
        return questions
    }
}

class RandomSorter: ShowQuestionsStrategy {
    func sortQuestions(_ questions: [Question]) -> [Question] {
        return Array(Set(questions))
    }
}
