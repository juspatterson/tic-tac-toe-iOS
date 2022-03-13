//
//  ViewController.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    let spacing = CGFloat(10)
    let padding = CGFloat(10)
    let router: Router
    let database: Database
    
    init(router: Router, database: Database) {
        self.router = router
        self.database = database
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.backgroundColor = .systemBackground
        
        
        let screenTopOffset = (view.bounds.size.height) / 4.5
        let buttonWidth = (view.bounds.size.width) / 1.2
        
        //safe area insets
        additionalSafeAreaInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        

        
        //settings for label
        let label = with(UILabel()){
            $0.backgroundColor = UIColor.clear
            $0.textColor = .customDarkGreen
            $0.numberOfLines = 0
            
            $0.text = "Emoji\nTic Tac Toe"
            $0.textAlignment = NSTextAlignment.center
            $0.font  = UIFont.systemFont(ofSize: 60.0, weight: UIFont.Weight.semibold)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let singlePlayer = with(UIButton()){
            $0.setTitle("Single Player", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
            $0.addTarget(self, action: #selector(singlePlayerButtonAction), for: .touchUpInside)
            $0.backgroundColor = .customDarkGreen
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.layer.cornerRadius = 12
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let twoPlayer = with(UIButton()){
            $0.setTitle("Two Player", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
            $0.addTarget(self, action: #selector(twoPlayerButtonAction), for: .touchUpInside)
            $0.backgroundColor = .customDarkGreen
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.layer.cornerRadius = 12
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let highScoreButton = with(UIButton()){
            $0.setTitle("High Score", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
            $0.addTarget(self, action: #selector(highScoreButtonAction), for: .touchUpInside)
            $0.backgroundColor = UIColor(hue: 0.3444, saturation: 1, brightness: 0.65, alpha: 1)
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.layer.cornerRadius = 12
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //add label to screen
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: screenTopOffset),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
                ])
        

        
        view.addSubview(singlePlayer)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: singlePlayer.topAnchor),
            singlePlayer.topAnchor.constraint(equalTo: label.bottomAnchor),
            singlePlayer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            singlePlayer.widthAnchor.constraint(equalToConstant: buttonWidth)
            
        ])
        
        view.addSubview(twoPlayer)
        
        NSLayoutConstraint.activate([
            singlePlayer.bottomAnchor.constraint(equalTo: twoPlayer.topAnchor,constant: -padding),
            twoPlayer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            twoPlayer.widthAnchor.constraint(equalToConstant: buttonWidth)
            
        ])

        
        view.addSubview(highScoreButton)
        
        NSLayoutConstraint.activate([
            twoPlayer.bottomAnchor.constraint(equalTo: highScoreButton.topAnchor,constant: -padding),
            highScoreButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            highScoreButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
    }
    
    @objc func singlePlayerButtonAction(){
        router.navigate(to: .chooseEmojiScreen(database, numberOfPlayers: 1))
        
    }
    
    @objc func twoPlayerButtonAction(){
        router.navigate(to: .chooseEmojiScreen(database, numberOfPlayers: 2))
        
    }

    @objc func highScoreButtonAction(){
        router.navigate(to: .highScoresScreen(database))
    }


}

