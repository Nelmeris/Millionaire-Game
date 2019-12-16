//
//  Game.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

typealias Result = Float
class Game {
    
    let gameCaretaker: GameCaretaker
    
    private init() {
        gameCaretaker = GameCaretaker()
        do {
            results = try gameCaretaker.loadGame()
        } catch {
            print(error)
        }
    }
    static let shared = Game()
    
    private var session: GameSession?
    
    private(set) var results: [Result] = []
    
    let questions = [
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
    
    func startGame(session: GameSession) {
        self.session = session
    }
    
    func finishGame() {
        guard let session = session else { return }
        results.append(Result(Result(session.score) / Result(session.questions.count)))
        self.session = nil
        do {
            try gameCaretaker.saveGame(results)
        } catch {
            
        }
    }
    
}

typealias Memento = Data
class GameCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "game"
    
    func saveGame(_ results: [Result]) throws {
        let data: Memento = try encoder.encode(results)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadGame() throws -> [Result] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Memento
            , let results = try? decoder.decode([Result].self, from: data) else {
                throw Error.gameNotFound
        }
        return results
    }
    
    public enum Error: Swift.Error {
        case gameNotFound
    }
}
