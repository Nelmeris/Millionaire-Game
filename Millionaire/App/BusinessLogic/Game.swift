//
//  Game.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

class Game {
    
    let gameCaretaker: GameCaretaker
    private(set) var results: [GameResult] = []
    private var session: GameSession?
    let userQuestionsCaretaker: UserQuestionsCaretaker
    
    private init() {
        gameCaretaker = GameCaretaker()
        userQuestionsCaretaker = UserQuestionsCaretaker()
        
        do {
            results = try gameCaretaker.loadGame()
        } catch {
            print(error)
        }
        do {
            userQuestions = try userQuestionsCaretaker.loadGame()
        } catch {
            print(error)
        }
    }
    static let shared = Game()
    
    var sortType: QuestionsSortType = .random
    
    var questions: [Question] {
        var array: [Question] = []
        array.append(contentsOf: mainQuestions)
        array.append(contentsOf: userQuestions)
        return array
    }
    private let mainQuestions = [
    Question(question: "Как правильно продолжить припев детской песни: \"Тили-тили...\"?",
             answers: ["хали-гали", "трали-вали",
                       "жили-были", "ели-пили"],
             correctAnswerId: 2),
    
    Question(question: "Что понадобится, чтобы взрыхлить землю на грядке?",
             answers: ["тяпка", "бабка",
                       "скобка", "тряпка"],
             correctAnswerId: 1),
    
    Question(question: "Как называется экзотическое животное из Южной Америки?",
             answers: ["пчеложор", "термитоглот",
                       "муравьед", "комаролов"],
             correctAnswerId: 3),
    
    Question(question: "Во что превращается гусеница?",
             answers: ["в мячик", "в пирамидку",
                       "в машинку", "в куколку"],
             correctAnswerId: 4),
    
    Question(question: "К какой группе музыкальных инструментов относится валторна?",
             answers: ["струнные", "клавишные",
                       "ударные", "духовые"],
             correctAnswerId: 4),
    ]
    
    var userQuestions: [Question] = []
    
    func startGame(session: GameSession) {
        self.session = session
    }
    
    func finishGame() {
        guard let session = session else { return }
        results.append(GameResult(date: Date(), score: session.result.value))
        self.session = nil
        do {
            try gameCaretaker.saveGame(results)
        } catch {
            print(error)
        }
    }
    
    func addNewQuestion(_ question: Question) {
        userQuestions.append(question)
        do {
            try userQuestionsCaretaker.saveGame(userQuestions)
        } catch {
            print(error)
        }
    }
    
}

typealias Memento = Data
class GameCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "game"
    
    func saveGame(_ results: [GameResult]) throws {
        let data: Memento = try encoder.encode(results)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadGame() throws -> [GameResult] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Memento
            , let results = try? decoder.decode([GameResult].self, from: data) else {
                throw Error.gameNotFound
        }
        return results
    }
    
    public enum Error: Swift.Error {
        case gameNotFound
    }
}

class UserQuestionsCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "userQuestions"
    
    func saveGame(_ questions: [Question]) throws {
        let data: Memento = try encoder.encode(questions)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadGame() throws -> [Question] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Memento
            , let questions = try? decoder.decode([Question].self, from: data) else {
                throw Error.questionsNotFound
        }
        return questions
    }
    
    public enum Error: Swift.Error {
        case questionsNotFound
    }
}
