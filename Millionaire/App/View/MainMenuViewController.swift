//
//  MainMenyViewController.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var createQuestionButton: UIButton!
    
    var session: GameSession!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameVC = segue.destination as? GameViewController else { return }
        self.session = GameSession(questions: Game.shared.questions)
        Game.shared.startGame(session: session)
        gameVC.delegate = self
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
    }
    
}

extension MainMenuViewController: GameSessionDelegate {
    
    var result: Observable<Float> {
        return session.result
    }
    
    func scoreIncrease() {
        session.scoreIncrease()
    }
    
    func finish() {
        Game.shared.finishGame()
    }
    
}
