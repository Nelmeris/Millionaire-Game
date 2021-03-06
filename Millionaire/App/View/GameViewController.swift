//
//  GameViewController.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var questions: [Question]!
    
    var currentQuestion = -1
    
    var score = 0
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    var delegate: GameSessionDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.landscapeLeft, andRotateTo: .landscapeLeft)
        
        questions = Game.shared.sortType.getSorter().sortQuestions(Game.shared.questions)
        
        configureButton(firstAnswerButton)
        configureButton(secondAnswerButton)
        configureButton(thirdAnswerButton)
        configureButton(fourthAnswerButton)
        configureTextView(questionTextView)
        
        nextQuestion()
        
        delegate?.result.addObserver(self, options: [.initial, .old, .new]) { [weak self] result, _ in
            guard let `self` = self else { return }
            self.progressLabel.text = "\(NSString(format: "%.0f", result * 100))%"
        }
    }
    
    func configureButton(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.padding = 10
        button.borderColor = .white
        button.borderWidth = 2
        button.cornerRadius = button.bounds.height / 2
        button.backgroundColor = .systemIndigo
    }
    
    func configureTextView(_ textView: UITextView) {
        textView.textColor = .white
        textView.borderColor = .white
        textView.borderWidth = 2
        textView.cornerRadius = 20
        textView.backgroundColor = .systemIndigo
    }
    
    func nextQuestion() {
        guard (currentQuestion != questions.count - 1) else {
            delegate?.finish()
            dismiss(animated: true, completion: nil)
            return
        }
        currentQuestion += 1
        questionNumberLabel.text = "Вопрос №\(currentQuestion + 1)"
        let question = questions[currentQuestion]
        firstAnswerButton.setTitle(question.answers[0], for: .normal)
        secondAnswerButton.setTitle(question.answers[1], for: .normal)
        thirdAnswerButton.setTitle(question.answers[2], for: .normal)
        fourthAnswerButton.setTitle(question.answers[3], for: .normal)
        questionTextView.text = question.question
    }

    @IBAction func selectAnswer(_ sender: UIButton) {
        if questions[currentQuestion].correctAnswerId == sender.tag {
            delegate?.scoreIncrease()
        }
        nextQuestion()
    }
}
