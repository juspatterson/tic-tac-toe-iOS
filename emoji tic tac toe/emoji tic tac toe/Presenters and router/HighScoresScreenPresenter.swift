//
//  HighScoresScreenPresenter.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

class HighScoresScreenPresenter: Presenter {
   
    func present(router: Router, route: Route) {
        guard case let .highScoresScreen(Database) = route else {
                    return}
        
        let highScoresScreenViewController = HighScoresScreenViewController(router: router, database: Database)
        
        router.navigationController.pushViewController(highScoresScreenViewController, animated: true)

   }

}
