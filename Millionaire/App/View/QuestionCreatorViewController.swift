//
//  QuestionCreatorViewController.swift
//  Millionaire
//
//  Created by Artem Kufaev on 17.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

class QuestionCreatorViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var correctAnswerTextView: UITextView!
    @IBOutlet weak var answerFirstTextView: UITextView!
    @IBOutlet weak var answerSecondTextView: UITextView!
    @IBOutlet weak var answerThirdTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "goToMain" else { return true }
        if (!questionTextView.text.isEmpty &&
            !correctAnswerTextView.text.isEmpty &&
            !answerFirstTextView.text.isEmpty &&
            !answerSecondTextView.text.isEmpty &&
            !answerThirdTextView.text.isEmpty) {
            let answers: [String] = [
                correctAnswerTextView.text,
                answerFirstTextView.text,
                answerSecondTextView.text,
                answerThirdTextView.text
            ]
            let question = Question(question: questionTextView.text, answers: answers, correctAnswerId: 0)
            Game.shared.addNewQuestion(question)
            return true
        } else {
            let alert = UIAlertController(title: "Вы не все ввели", message: "Введите все элементы вопроса", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
            self.present(alert, animated: true)
            return false
        }
    }
    
}
