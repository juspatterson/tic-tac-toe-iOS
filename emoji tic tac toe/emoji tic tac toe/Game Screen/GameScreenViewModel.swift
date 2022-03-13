//
//  GameScreenViewModel.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 2/9/21.
//

import UIKit

enum Player: String {
    case computer = "computer"
    case human = "human"
    case playerOne = "playerOne"
    case playerTwo = "playerTwo"
}

class GameScreenViewModel {
    let router: Router
    let database: Database
    let numberOfPlayers: Int
    let playerOneEmoji: String
    let playerTwoEmoji: String
    
    var players = ["human", "computer"]
    lazy var selectPlayer = players.randomElement()
    lazy var human = playerOneEmoji
    lazy var computer = playerTwoEmoji
    lazy var player1 = playerOneEmoji
    lazy var player2 = playerTwoEmoji
    var numberOfMoves = 0
    var playersMoves = [String](repeating: "", count: 9)
    var results = ""
    
    init(router: Router, database: Database, numberOfPlayers: Int, playerOneEmoji: String,playerTwoEmoji: String) {
        self.router = router
        self.database = database
        self.numberOfPlayers = numberOfPlayers
        self.playerOneEmoji = playerOneEmoji
        self.playerTwoEmoji = playerTwoEmoji
    }
    
    func twoPlayers(indexPath: IndexPath, cv: UICollectionView) {
        let cell = cv.cellForItem(at: indexPath) as! GameBoardCell
        
        switch selectPlayer {
                case players[0]:
                    if playersMoves[indexPath.item] == "" {
                        cell.label.text = playerOneEmoji
                        
                        playersMoves[indexPath.item] = selectPlayer!
                        
                        
                        numberOfMoves += 1
                        checkWin(playersTag: players[0])
                        selectPlayer = players[1]
                    }
                    
                    break
                case players[1]:
                    if playersMoves[indexPath.item] == "" {
                        cell.label.text = playerTwoEmoji
                        
                        playersMoves[indexPath.item] = selectPlayer!
                        
                        
                        numberOfMoves += 1
                        checkWin(playersTag: players[1])
                        selectPlayer = players[0]
                    }
                    break
                default:
                    print("error")
                }
    }
    
    func humanPlayerTurn(indexPath: IndexPath, cv: UICollectionView) {
        let cell = cv.cellForItem(at: indexPath) as! GameBoardCell
        
        if self.selectPlayer == self.players[0]{
            if playersMoves[indexPath.item] == "" {
                cell.label.text = human
                playersMoves[indexPath.item] = selectPlayer!
                
                
                numberOfMoves += 1
                selectPlayer = players[1]
                
                if results == "" { checkWin(playersTag: players[0]) }
                nextMove(cv: cv)
            }
        }
    }
    
    func checkWin(playersTag: String) {
        //check for row win
        checkForThreeOfTheSame(placeOne: 0, placeTwo: 1, placeThree: 2, playersTag: playersTag)
        checkForThreeOfTheSame(placeOne: 3, placeTwo: 4, placeThree: 5, playersTag: playersTag)
        checkForThreeOfTheSame(placeOne: 6, placeTwo: 7, placeThree: 8, playersTag: playersTag)
        
        //check for column win
        checkForThreeOfTheSame(placeOne: 0, placeTwo: 3, placeThree: 6, playersTag: playersTag)
        checkForThreeOfTheSame(placeOne: 1, placeTwo: 4, placeThree: 7, playersTag: playersTag)
        checkForThreeOfTheSame(placeOne: 2, placeTwo: 5, placeThree: 8, playersTag: playersTag)
        
        //check for diagonal win
        checkForThreeOfTheSame(placeOne: 0, placeTwo: 4, placeThree: 8, playersTag: playersTag)
        checkForThreeOfTheSame(placeOne: 2, placeTwo: 4, placeThree: 6, playersTag: playersTag)
        
        
    }
    
    func checkForThreeOfTheSame(placeOne: Int, placeTwo: Int, placeThree: Int, playersTag: String) {
        print(numberOfMoves)
        if playersMoves[placeOne] == playersTag &&
           playersMoves[placeTwo] == playersTag &&
           playersMoves[placeThree] == playersTag {
            
            if numberOfPlayers == 1 {
                if playersTag == players[0] { results = "win" }
                else if playersTag == players[1] {results = "lose"}
                delayWithSeconds(0.4){
                    self.goToResultsScreen()
                }
            }
            else if numberOfPlayers == 2 {
                if playersTag == players[0] { results = "playerOne" }
                else if playersTag == players[1] {results = "playerTwo"}
                delayWithSeconds(0.4){
                    self.goToResultsScreen()
                }
            }
        } else if numberOfMoves == 9 && results == "" {
            results = "tie"
            delayWithSeconds(0.4){
                self.goToResultsScreen()
            }
        }
    }
    
    func goToResultsScreen() {
        self.router.navigate(to: .resultScreen(results: self.results, numberOfMoves: self.numberOfMoves, database: self.database,numberOfPlayers: numberOfPlayers, playerOneEmoji: playerOneEmoji, playerTwoEmoji: playerTwoEmoji))
    }
    
    func selectPlayerOne(cv: UICollectionView) {
        var alertMessage = ""
        
        if numberOfPlayers == 2 {
            players = ["playerOne","playerTwo"]
            selectPlayer = players.randomElement()
            
            if selectPlayer == "playerTwo" {
                alertMessage = "Player Two goes first"
            } else {alertMessage = "Player One go first"}
        }
        
        else if numberOfPlayers == 1 {
            
            if selectPlayer == "computer" {
                alertMessage = "Computer goes first"
            } else {alertMessage = "You go first"}
        }
        
        let selectedPlayerAlert = UIAlertController(title: alertMessage, message: "", preferredStyle: UIAlertController.Style.alert)
        
        selectedPlayerAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,  handler: { (action: UIAlertAction!) in
            if self.selectPlayer == "computer"{self.placeComputerMove(cv: cv, item: 4)}
        }))
        
        UIApplication.shared.windows.first?.rootViewController?.present(selectedPlayerAlert, animated: true, completion: nil)
    }
    
    func nextMove(cv: UICollectionView) {
        //place move in centre of the board
        if numberOfMoves == 1 && playersMoves[4] == "" { placeComputerMove(cv: cv, item: 4) }
        
        //check if computer can win
        playNextMove(cv: cv, playersTag: players[1])
        
        //check to block human player
        playNextMove(cv: cv,playersTag: players[0])
        
        //play a move if both win and block do not play a move
        if selectPlayer == players[1] {
            for i in 0..<playersMoves.count {
                if playersMoves[i] == "" {
                    placeComputerMove(cv: cv, item: i)
                    break
                }
            }
        }

    }
    
    func playNextMove(cv: UICollectionView, playersTag: String) {
        //columns
        checkForNextMove(cv: cv, playersMoveOne: 0, playersMoveTwo: 1, playersMoveThree: 2, playersTag: playersTag)
        checkForNextMove(cv: cv, playersMoveOne: 3, playersMoveTwo: 4, playersMoveThree: 5, playersTag: playersTag)
        checkForNextMove(cv: cv, playersMoveOne: 6, playersMoveTwo: 7, playersMoveThree: 8, playersTag: playersTag)
        //row
        checkForNextMove(cv: cv, playersMoveOne: 0, playersMoveTwo: 3, playersMoveThree: 6, playersTag: playersTag)
        checkForNextMove(cv: cv, playersMoveOne: 1, playersMoveTwo: 4, playersMoveThree: 7, playersTag: playersTag)
        checkForNextMove(cv: cv, playersMoveOne: 2, playersMoveTwo: 5, playersMoveThree: 8, playersTag: playersTag)
        //diagonal
        checkForNextMove(cv: cv, playersMoveOne: 0, playersMoveTwo: 4, playersMoveThree: 8, playersTag: playersTag)
        checkForNextMove(cv: cv, playersMoveOne: 2, playersMoveTwo: 4, playersMoveThree: 6, playersTag: playersTag)
    }
    
    func checkForNextMove(cv: UICollectionView, playersMoveOne: Int,playersMoveTwo: Int, playersMoveThree: Int, playersTag: String) {
        if playersMoves[playersMoveOne] == playersTag &&
            playersMoves[playersMoveTwo] == "" &&
            playersMoves[playersMoveThree] == playersTag {
            placeComputerMove(cv: cv, item: playersMoveTwo)
        }
        else if playersMoves[playersMoveOne] == "" &&
            playersMoves[playersMoveTwo] == playersTag &&
            playersMoves[playersMoveThree] == playersTag {
            placeComputerMove(cv: cv, item: playersMoveOne)
        }
        else if playersMoves[playersMoveOne] == playersTag &&
            playersMoves[playersMoveTwo] == playersTag &&
            playersMoves[playersMoveThree] == "" {
            placeComputerMove(cv: cv, item: playersMoveThree)
        }
    }
    
    func placeComputerMove(cv: UICollectionView, item: Int) {
        delayWithSeconds(0.5) {
            if self.selectPlayer == self.players[1] {
                let indexPath = IndexPath(item: item, section: 0);
                guard let cell = cv.cellForItem(at: indexPath) as? GameBoardCell else { return }
                cell.label.text = self.computer
                self.playersMoves[indexPath.item] = self.selectPlayer!
                self.numberOfMoves += 1
                self.selectPlayer = self.players[0]
                if self.results == "" { self.checkWin(playersTag: self.players[1]) }
                
            }}
        
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        let group = DispatchGroup()

        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
            group.wait()
        }
        
    }
    
    func restartGame(cv:UICollectionView) {
        numberOfMoves = 0
        playersMoves = [String](repeating: "", count: 9)
        selectPlayerOne(cv: cv)
        results = ""
        
        cv.reloadData()
    }
    
    func goToHomeScreen() {
        router.navigate(to: .homeScreen(database))
    }
}
