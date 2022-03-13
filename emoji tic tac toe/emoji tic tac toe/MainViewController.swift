//
//  MainViewController.swift
//  recipe to shoppoing list
//
//  Created by Justin Patterson on 30/12/20.
//  Copyright © 2020 Justin Patterson. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {
    
    
    
    lazy var router: Router = with(Router()) {
        $0.navigationController = self
    }
    
    override func viewDidLoad() {
        let database = Database()
        database.createTable()
        router.navigate(to: .homeScreen(database))

    }
    
    
    
    
}

