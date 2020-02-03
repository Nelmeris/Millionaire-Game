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
    
    var session: GameSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton(startGameButton)
        configureButton(resultsButton)
    }
    
    func configureButton(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.padding = 10
        button.borderColor = .white
        button.borderWidth = 2
        button.cornerRadius = button.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    @IBAction func startGame(_ sender: Any) {
        self.session = GameSession(questions: Game.shared.questions)
        Game.shared.startGame(session: session)
    }
    
    @IBAction func showResults(_ sender: UIButton) {
        print(Game.shared.results)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameVC = segue.destination as? GameViewController else { return }
        gameVC.delegate = self
    }
    
}

extension MainMenuViewController: GameSessionDelegate {
    
    func scoreIncrease() {
        session.scoreIncrease()
    }
    
    func finish() {
        Game.shared.finishGame()
    }
    
}
