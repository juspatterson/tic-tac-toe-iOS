//
//  ResultScreenViewController.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 2/9/21.
//

import UIKit

class ResultScreenViewController: UIViewController, UITextFieldDelegate {
    
    let spacing = CGFloat(10)
    let padding = CGFloat(10)
    let router: Router
    let results: String
    let numberOfMoves: Int
    let database: Database
    let numberOfPlayers: Int
    let playerOneEmoji: String
    let playerTwoEmoji: String
    
    init(router: Router, results: String, numberOfMoves: Int,database: Database, numberOfPlayers: Int,playerOneEmoji: String, playerTwoEmoji: String) {
        self.router = router
        self.results = results
        self.database = database
        self.numberOfMoves = numberOfMoves
        self.numberOfPlayers = numberOfPlayers
        self.playerOneEmoji = playerOneEmoji
        self.playerTwoEmoji = playerTwoEmoji
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let textFieldSize: CGFloat = 50
    
    lazy var textField = with(UITextField()){
        $0.textAlignment = .center
        $0.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .boldSystemFont(ofSize: UIFont.buttonFontSize))
        $0.adjustsFontSizeToFitWidth = true
        $0.adjustsFontForContentSizeCategory = true
        $0.delegate = self
        $0.placeholder = "Enter Name"
        $0.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0.50, alpha: 0.50)
        $0.layer.cornerRadius = textFieldSize/2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var saveScoreButton = with(UIButton()){
        $0.setTitle("Save Score", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
        $0.addTarget(self, action: #selector(saveScoreButtonAction), for: .touchUpInside)
        $0.backgroundColor = .gray
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.layer.cornerRadius = 12
        $0.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        
        isModalInPresentation = false
        view.backgroundColor = .systemBackground
        
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextField.textDidChangeNotification, object: nil)
        saveScoreButton.isEnabled = false
        
        additionalSafeAreaInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        
        print(numberOfMoves)
        
        let buttonWidth = (view.bounds.size.width) / 1.2
        
        var resultMessage = ""
        
        let playAgainButton = with(UIButton()){
            $0.setTitle("Play Again", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
            $0.addTarget(self, action: #selector(playAgainButtonAction), for: .touchUpInside)
            $0.backgroundColor = .customDarkGreen
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.layer.cornerRadius = 12
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        let homeScreen = with(UIButton()){
            $0.setTitle("Home Screen", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
            $0.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
            $0.backgroundColor = .customDarkGreen
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.layer.cornerRadius = 12
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        switch results {
        case "win":
            resultMessage = "You Win with \(numberOfMoves) moves"
            break
        case "lose":
            resultMessage = "You lose with \(numberOfMoves) moves"
            saveScoreButton.isHidden = true
            textField.isHidden = true
            break
        case "playerOne":
            resultMessage = "Player One wins with \(numberOfMoves) moves"
            break
        case "playerTwo":
            resultMessage = "Player Two wins with \(numberOfMoves) moves"
            break
        case "tie":
            resultMessage = "Tied with \(numberOfMoves) moves"
            saveScoreButton.isHidden = true
            textField.isHidden = true
            break
        default:
            print("error")
        }
        
        let label = with(UILabel()){
            $0.backgroundColor = UIColor.clear
            $0.textColor = .customDarkGreen
            $0.text = resultMessage
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.textAlignment = NSTextAlignment.center
            $0.font  = UIFont.systemFont(ofSize: 60.0, weight: UIFont.Weight.semibold)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: label.bottomAnchor).usingPriority(.almostRequired),
            textField.heightAnchor.constraint(equalToConstant: textFieldSize),
            textField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).usingPriority(.almostRequired),
            textField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).usingPriority(.almostRequired),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).usingPriority(.almostRequired)
        ])
        
        view.addSubview(saveScoreButton)
        
        NSLayoutConstraint.activate([
            saveScoreButton.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: padding).usingPriority(.almostRequired),
            saveScoreButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).usingPriority(.almostRequired),
            saveScoreButton.widthAnchor.constraint(equalToConstant: buttonWidth).usingPriority(.almostRequired),
        ])
        
        view.addSubview(playAgainButton)
        
        NSLayoutConstraint.activate([
            playAgainButton.topAnchor.constraint(equalTo: saveScoreButton.bottomAnchor,constant: padding).usingPriority(.almostRequired),
            playAgainButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).usingPriority(.almostRequired),
            playAgainButton.widthAnchor.constraint(equalToConstant: buttonWidth).usingPriority(.almostRequired)
        ])
        
        view.addSubview(homeScreen)
        
        NSLayoutConstraint.activate([
            homeScreen.topAnchor.constraint(equalTo: playAgainButton.bottomAnchor, constant: padding).usingPriority(.almostRequired),
            homeScreen.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).usingPriority(.almostRequired),
            homeScreen.widthAnchor.constraint(equalToConstant: buttonWidth).usingPriority(.almostRequired)
        ])
    }
    
    @objc   func saveScoreButtonAction() {
        let currentDateTime = Date()


        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        database.addHighScore(playerName: (textField.text!) as String, numberOFMoves: numberOfMoves, dateTime: formatter.string(from: currentDateTime))
        
        showAlert()
        //saveScoreButton.isHidden = true
        saveScoreButton.backgroundColor = .gray
        NotificationCenter.default.removeObserver(self)
        saveScoreButton.isEnabled = false
        
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "High Score Saved", message: "", preferredStyle: .actionSheet)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    @objc   func playAgainButtonAction() {
        router.navigate(to: .gameScreen(database, numberOfPlayers: numberOfPlayers, playerOneEmoji: playerOneEmoji ,playerTwoEmoji: playerTwoEmoji))
        
    }
    
    @objc func homeButtonAction() {
        
        router.navigate(to: .homeScreen(database)) }
    
    @objc func textChanged() {
        if textField.hasText {
            saveScoreButton.isEnabled = true
            saveScoreButton.backgroundColor = .customDarkGreen
        } else {
            saveScoreButton.backgroundColor = .gray
            saveScoreButton.isEnabled = false
        }
    }
    
    
}
