//
//  Router.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

import UIKit

enum Route {
    case gameScreen(Database, numberOfPlayers: Int,playerOneEmoji: String ,playerTwoEmoji: String)
    case homeScreen(Database)
    case highScoresScreen(Database)
    case resultScreen(results: String, numberOfMoves: Int, database: Database,numberOfPlayers: Int, playerOneEmoji: String ,playerTwoEmoji: String)
    case chooseEmojiScreen(Database,numberOfPlayers: Int)
}

class Router {
    @IBOutlet var navigationController: UINavigationController!
    
    func navigate(to route: Route) {
        
        let presenter: Presenter
        
        switch route {
        case .gameScreen:
            presenter = GameScreenPresenter()
        case .homeScreen:
            presenter = HomeScreenPresenter()
        case .highScoresScreen:
            presenter = HighScoresScreenPresenter()
        case .resultScreen:
            presenter = ResultScreenPresenter()
        case .chooseEmojiScreen:
            presenter = ChooseEmojiPresenter()
        }
        presenter.present(router: self, route: route)
    }
    
    
}
