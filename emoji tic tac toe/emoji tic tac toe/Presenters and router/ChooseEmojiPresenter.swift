//
//  ChooseEmojiPresenter.swift
//  emoji tic tac tow
//
//  Created by Justin Patterson on 11/9/21.
//

import UIKit

class  ChooseEmojiPresenter: Presenter {
    func present(router: Router, route: Route) {
        guard case let .chooseEmojiScreen(database, numberOfPlayers: numberOfPlayers) = route else {
            return}
        
        let chooseEmojiViewController = ChooseEmojiViewController(router: router, database: database, numberOfPlayers: numberOfPlayers)
        
        let navigation = UINavigationController(rootViewController: chooseEmojiViewController)
        
        router.navigationController.present(navigation, animated: true)
        
    }
}
