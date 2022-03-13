//
//  GameScreenPresenter.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

class GameScreenPresenter: Presenter {
   
   func present(router: Router, route: Route) {
    guard case let .gameScreen(Database, numberOfPlayers, playerOneEmoji: playerOneEmoji ,playerTwoEmoji: playerTwoEmoji) = route else { return }
    
        let gameScreenViewModel = GameScreenViewModel(router: router, database: Database, numberOfPlayers: numberOfPlayers,playerOneEmoji: playerOneEmoji ,playerTwoEmoji: playerTwoEmoji)
    
        let gameScreenViewController = GameScreenViewController(router: router,gameScreenViewModel: gameScreenViewModel)
    if router.navigationController.presentedViewController != nil {
        router.navigationController.dismiss(animated: true, completion: nil)
        router.navigationController.pushViewController(gameScreenViewController, animated: false)
    } else {
        router.navigationController.pushViewController(gameScreenViewController, animated: true)
    }
        

   }

}
