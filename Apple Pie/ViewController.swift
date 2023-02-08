//
//  ViewController.swift
//  Apple Pie
//
//  Created by Colin Jones on 1/31/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    var listOfWords = ["nice", "hotdog", "fast", "patent", "bookshelf"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    
    var currentGame: Game!
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
                 let letterString = sender.titleLabel!.text!
                 let letter = Character(letterString.lowercased())
                 currentGame.playerGuessed(letter: letter)

                 updateGameState()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()        // Do any additional setup after loading the view.
    }

    func newRound() {
             if !listOfWords.isEmpty {
                 let newWord = listOfWords.removeFirst()
                 currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
                 enableLetterButtons(true)
                 updateUI()
             } else {
                 enableLetterButtons(false)
             }
         }

    func enableLetterButtons(_ enable: Bool) {
             for button in letterButtons {
                 button.isEnabled = enable
             }
         }
    
    func updateUI() {
        let letters = Array(currentGame.formattedWord)
        let lettersAsStrings = letters.map { String($0) }
        let wordWithSpacing = lettersAsStrings.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }



         func updateGameState() {
             if currentGame.incorrectMovesRemaining == 0 {
                 totalLosses += 1
             } else if currentGame.word == currentGame.formattedWord {
                 totalWins += 1
             } else {
                 updateUI()
             }
         }

     }
