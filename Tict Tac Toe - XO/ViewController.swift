//
//  ViewController.swift
//  Tict Tac Toe - XO
//
//  Created by Muhammad Ewaily on 7/2/19.
//  Copyright © 2019 Muhammad Ewaily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var xScore: UILabel!
    @IBOutlet private var oScore: UILabel!
    
    private var playerType = 1, playerXScore = 0, playerOScore = 0, playerXStatus = 0, playerOStatus = 0, gameMode = 0, rand = 0, flag1 = 0, flag2 = 0, flag3 = 0, flag4 = 0
    private var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    private let winnigCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xScore.text = String(0)
        oScore.text = String(0)
    }
    
    override func viewDidAppear(_: Bool) {
        GameMode()
    }
    
    @IBAction private func playerAction(_ sender: UIButton) {
        if gameMode == 1 {
            if gameState[sender.tag - 1] == 0 {
                flag1 += 1
                if playerType == 1 {
                    sender.setImage(UIImage(named: "X"), for: UIControl.State())
                    gameState[sender.tag - 1] = playerType
                } else {
                    sender.setImage(UIImage(named: "O"), for: UIControl.State())
                    gameState[sender.tag - 1] = playerType
                }
                playerTurn()
                winnerCheck()
                drawCheck()
            }
        } else if gameMode == 2 {
            if gameState[sender.tag - 1] == 0 {
                sender.setImage(UIImage(named: "X"), for: UIControl.State())
                gameState[sender.tag - 1] = 1
                flag1 += 1
                flag3 = 0
                flag4 = 0
                drawCheck()
                winnerCheck()
                
                if flag3 == 0, flag4 == 0 {
                    rand = 1
                    
                    while rand == 1 {
                        let randomNumber = Int.random(in: 1 ... 9)
                        
                        if gameState[randomNumber - 1] == 0 {
                            let button = view.viewWithTag(randomNumber) as! UIButton
                            button.setImage(UIImage(named: "O"), for: UIControl.State())
                            gameState[randomNumber - 1] = 2
                            flag1 += 1
                            winnerCheck()
                            drawCheck()
                            rand = 0
                        }
                    }
                }
            }
        }
    }
    
    @IBAction private func resetButton(_: UIButton) {
        let alert = UIAlertController(title: "Start Over", message: "Are you sure?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Yes", style: .destructive, handler: {
            _ in
            self.resetDisplay()
        })
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: 0, height: 0)
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func winnerCheck() {
        for combination in winnigCombinations {
            if gameState[combination[0]] != 0, gameState[combination[0]] == gameState[combination[1]], gameState[combination[1]] == gameState[combination[2]] {
                flag2 = 1
                flag3 = 1
                
                if gameState[combination[0]] == 1 {
                    playerXStatus = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let alert = UIAlertController(title: "Winner", message: "Congratulations, X player wins🏅", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let popoverController = alert.popoverPresentationController {
                            popoverController.sourceView = self.view
                            popoverController.sourceRect = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: 0, height: 0)
                        }
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                        self.updateDisplay()
                    }
                } else {
                    playerOStatus = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let alert = UIAlertController(title: "Winner", message: "Congratulations, O player wins🏅", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let popoverController = alert.popoverPresentationController {
                            popoverController.sourceView = self.view
                            popoverController.sourceRect = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: 0, height: 0)
                        }
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                        self.updateDisplay()
                    }
                }
            }
        }
    }
    
    private func drawCheck() {
        winnerCheck()
        if flag1 == 9, flag2 == 0 {
            flag4 = 1
            let alert = UIAlertController(title: "Draw", message: "You draw! 🤷‍♂", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: 0, height: 0)
            }
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            playerType = 1
            updateDisplay()
        }
    }
    
    private func playerTurn() {
        if playerType == 1 {
            playerType = 2
        } else {
            playerType = 1
        }
    }
    
    private func GameMode() {
        let alert = UIAlertController(title: "Game Mode", message: "Choose game mode", preferredStyle: .actionSheet)
        
        let mode1 = UIAlertAction(title: "2 Players", style: .default, handler: {
            _ in
            self.gameMode = 1
        })
        
        let mode2 = UIAlertAction(title: "1 Player", style: .default, handler: {
            _ in
            self.gameMode = 2
        })
        
        alert.addAction(mode1)
        alert.addAction(mode2)
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: 0, height: 0)
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func updateDisplay() {
        if playerXStatus == 1 {
            playerXScore += 1
            playerXStatus = 0
        } else if playerOStatus == 1 {
            playerOScore += 1
            playerOStatus = 0
        }
        flag1 = 0
        flag2 = 0
        playerType = 1
        xScore.text = "0" + String(playerXScore)
        oScore.text = "0" + String(playerOScore)
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for i in 1 ... 9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    private func resetDisplay() {
        playerXScore = 0
        playerOScore = 0
        playerType = 1
        updateDisplay()
        GameMode()
    }
}
