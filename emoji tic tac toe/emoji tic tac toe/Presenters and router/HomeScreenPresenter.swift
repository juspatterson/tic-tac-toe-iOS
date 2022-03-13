//
//  HomeScreenPresenter.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

class HomeScreenPresenter: Presenter {
   
    func present(router: Router, route: Route) {
        guard case let .homeScreen(Database) = route else {
                    return}
        let homeScreenViewController = HomeScreenViewController(router: router, database: Database)
       
        if router.navigationController.viewControllers == [] {
            router.navigationController.pushViewController(homeScreenViewController, animated: true)
        }
        router.navigationController.popToRootViewController(animated: true)
        if router.navigationController.presentedViewController != nil {
            router.navigationController.dismiss(animated: true, completion: nil)
        }

   }

}
