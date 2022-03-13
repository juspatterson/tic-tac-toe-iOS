//
//  ResultScreenPresenter.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 2/9/21.
//

import UIKit

class  ResultScreenPresenter: Presenter {
    func present(router: Router, route: Route) {
        guard case let .resultScreen(results: result, numberOfMoves: numberOfMoves, database: Database, numberOfPlayers:numberOfPlayers, playerOneEmoji: playerOneEmoji ,playerTwoEmoji: playerTwoEmoji) = route else {
            return}
        let resultScreenViewController = ResultScreenViewController(router: router, results: result, numberOfMoves: numberOfMoves, database: Database, numberOfPlayers: numberOfPlayers, playerOneEmoji: playerOneEmoji ,playerTwoEmoji: playerTwoEmoji)
        
        //let navigation = UINavigationController(rootViewController: resultScreenViewController)
        
        //router.navigationController.present(navigation, animated: true, completion: nil)
        
        router.navigationController.present(resultScreenViewController, animated: true) {
            router.navigationController.popToRootViewController(animated: true)
        }
    }
}
