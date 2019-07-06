//
//  ViewController.swift
//  Tict Tac Toe - XO
//
//  Created by Muhammad Ewaily on 7/2/19.
//  Copyright © 2019 Muhammad Ewaily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var player = 1, xPlayerScore = 0, oPlayerScore = 0, flag1 = 0, flag2 = 0, gameMode = 0, rand = 0, flag3 = 0, flag4 = 0
    var gameState = [0,0,0,0,0,0,0,0,0]
    let winnigCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    @IBOutlet weak var xScore: UILabel!
    @IBOutlet weak var oScore: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        xScore.text = String(0)
        oScore.text = String(0)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        GameMode()
    }

    @IBAction func playerAction(_ sender: UIButton) {
        
        if gameMode == 1 {
            
            if gameState[sender.tag - 1] == 0 {
                flag1 += 1
                if player == 1 {
                    sender.setImage(UIImage(named: "X"), for: UIControl.State())
                    gameState[sender.tag - 1] = player
                }
                else {
                    sender.setImage(UIImage(named: "O"), for: UIControl.State())
                    gameState[sender.tag - 1] = player
                }
                playerTurn()
                winnerCheck()
                drawCheck()
                
            }
            
            }
            
        else if gameMode == 2 {
            
            if gameState[sender.tag - 1] == 0 {
                
                sender.setImage(UIImage(named: "X"), for: UIControl.State())
                gameState[sender.tag - 1] = 1
                flag1 += 1
                flag3 = 0
                flag4 = 0
                drawCheck()
                winnerCheck()
                
                if flag3 == 0 && flag4 == 0{
                rand = 1
                
                while rand == 1 {
                    
                    let randomNumber = Int.random(in: 1...9)
                    
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
    
    func playerTurn () {
        
        if player == 1 {
            player = 2
        }
        else {
            player = 1
        }
    }
    
    func updateDisplay () {
        flag1 = 0
        flag2 = 0
        player = 1
        xScore.text = "0" + String(xPlayerScore)
        oScore.text = "0" + String(oPlayerScore)
        gameState = [0,0,0,0,0,0,0,0,0]
        for i in 1...9 {
            
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }

    }
    
    func winnerCheck () {
        
        for combination in winnigCombinations {
            
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {

                flag2 = 1
                flag3 = 1
                
                if gameState[combination[0]] == 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

                    let alert = UIAlertController(title: "Winner", message: "Congratulations, X player wins🏅", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                        self.xPlayerScore += 1
                        self.updateDisplay()
                    }
                }
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let alert = UIAlertController(title: "Winner", message: "Congratulations, O player wins🏅", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.oPlayerScore += 1
                    self.updateDisplay()
                }
                }
            }
        }

    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Start Over", message: "Are you sure?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Yes", style: .destructive, handler: {
            action in
            self.resetDisplay()
        })
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
    }
    
    func GameMode () {
        
        let alert = UIAlertController(title: "Game Mode", message: "Choose game mode", preferredStyle: .actionSheet)
        
        let mode1 = UIAlertAction(title: "2 Players", style: .default, handler: {
            action in
            self.gameMode = 1
        })
        
        let mode2 = UIAlertAction(title: "1 Player", style: .default, handler: {
            action in
            self.gameMode = 2
        })
        
        alert.addAction(mode1)
        alert.addAction(mode2)
        
        present(alert, animated: true, completion: nil)
        
    }
    func resetDisplay () {
        xPlayerScore = 0
        oPlayerScore = 0
        player = 1
        updateDisplay()
        GameMode()
        
    }
    
    func drawCheck () {
        
        winnerCheck()
        if flag1 == 9 && flag2 == 0 {
            flag4 = 1
            let alert = UIAlertController(title: "Draw", message: "You draw! 🤷‍♂", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            player = 1
            updateDisplay()
        }
    }
}

