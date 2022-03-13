//
//  ChooseEmojiViewController.swift
//  emoji tic tac tow
//
//  Created by Justin Patterson on 11/9/21.
//

import UIKit

class ChooseEmojiViewController: UIViewController, UITextFieldDelegate {
    
    let spacing = CGFloat(10)
    lazy var emojiPickerCell = EmojiPickerCell(frame: CGRect(),size: (view.bounds.size.height) / 3.1)
    var playerOneEmoji = ""
    var playerTwoEmoji = ""
    var playersTag = 1

    
    
    let router: Router
    let database: Database
    let numberOfPlayers: Int
    
    lazy var gestureRecognizer: UITapGestureRecognizer = with(UITapGestureRecognizer()){
        $0.addTarget(self, action: #selector(tap))
        $0.cancelsTouchesInView = false
    }
    
    lazy var label = with(UILabel()){
        $0.backgroundColor = UIColor.clear
        $0.textColor = .customDarkGreen
        $0.numberOfLines = 0
        
        $0.text = "Choose player one emoji"
        $0.textAlignment = NSTextAlignment.center
        $0.font  = UIFont.systemFont(ofSize: 30.0, weight: UIFont.Weight.semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var selectPlayerTwoEmoji = with(UIButton()){
        $0.setTitle("Select player two emoji", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
        $0.addTarget(self, action: #selector(selectPlayerTwoEmojiButtonAction), for: .touchUpInside)
        $0.backgroundColor = .customDarkGreen
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.layer.cornerRadius = 12
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(router: Router,database: Database, numberOfPlayers: Int) {
        self.router = router
        self.database = database
        self.numberOfPlayers = numberOfPlayers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Emoji"
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(gestureRecognizer)
        
        let buttonWidth = (view.bounds.size.width) / 1.2
        
        

        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        selectPlayerTwoEmoji.isEnabled = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonAction))
        
        //safe area insets
        additionalSafeAreaInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        emojiPickerCell.textFieldLabel.text = "Player One"
        
        
        view.addSubview(emojiPickerCell)
        
        emojiPickerCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emojiPickerCell.topAnchor.constraint(equalTo: label.bottomAnchor),
            //emojiPickerCell.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            //emojiPickerCell.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            emojiPickerCell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        if numberOfPlayers == 1 {
            selectPlayerTwoEmoji.setTitle("Select computers emoji", for: .normal)
        }
        
        view.addSubview(selectPlayerTwoEmoji)
        
        NSLayoutConstraint.activate([
            selectPlayerTwoEmoji.topAnchor.constraint(equalTo: emojiPickerCell.bottomAnchor,constant: spacing),
            selectPlayerTwoEmoji.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            selectPlayerTwoEmoji.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])

        

        
        emojiPickerCell.playerOneChosenEmoji = PLayerOneHaveChosenEmoji
        emojiPickerCell.onEmojiChanged = bothPLayersHaveChosenEmoji

        
    }
    
    func PLayerOneHaveChosenEmoji(_: String) {
        selectPlayerTwoEmoji.isEnabled = emojiPickerCell.hasText()
    }
    
    func bothPLayersHaveChosenEmoji(_: String) {
        if playersTag == 2 {
            playerTwoEmoji = emojiPickerCell.textField.text!
        }
        if playersTag == 1 && playerOneEmoji != ""{
            playerOneEmoji = emojiPickerCell.textField.text!
        }
        navigationItem.rightBarButtonItem?.isEnabled = playerOneEmoji != "" && playerTwoEmoji != ""
    }
    
    @objc func tap() { view.firstResponder.first?.resignFirstResponder() }
    
    @objc func backButtonAction() {
        switch playersTag {
        case 1:
            self.dismiss(animated: true, completion: nil)
            break
        case 2:
            playerTwoEmoji = emojiPickerCell.textField.text!
            emojiPickerCell.textFieldLabel.text = "Player One"
            emojiPickerCell.textField.text = playerOneEmoji
            emojiPickerCell.textField.leftViewMode = UITextField.ViewMode.never
            label.text = "Choose player one emoji"
            selectPlayerTwoEmoji.isHidden = false
            playersTag = 1
            break
            
        default:
            print("error for back button for choose emoji screen")
        }
        
        
    }
    
    @objc func doneButtonAction() {
        router.navigate(to: .gameScreen(database, numberOfPlayers: numberOfPlayers, playerOneEmoji: playerOneEmoji, playerTwoEmoji: playerTwoEmoji))
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectPlayerTwoEmojiButtonAction() {
        playerOneEmoji = emojiPickerCell.textField.text!
        //print(playerOneEmoji)
        playersTag = 2
        setEmojiPickerCellPlayerTwo()
        selectPlayerTwoEmoji.isHidden = true
    }
    
    func setEmojiPickerCellPlayerTwo() {
        var labelPlayerDisplay = ""
        if playersTag == 2 {
            switch numberOfPlayers {
            case 1:
                emojiPickerCell.setText(text: "🖥")
                playerTwoEmoji = emojiPickerCell.textField.text!
                emojiPickerCell.textFieldLabel.text = "Computer"
                labelPlayerDisplay = "computer"
                break
            case 2:
                emojiPickerCell.textFieldLabel.text = "Player Two"
                print(playerTwoEmoji)
                if playerTwoEmoji == "" {
                    emojiPickerCell.textField.text?.removeAll()
                    emojiPickerCell.textField.leftViewMode = UITextField.ViewMode.unlessEditing
                } else {
                    emojiPickerCell.textField.text? = playerTwoEmoji
                    emojiPickerCell.textField.leftViewMode = UITextField.ViewMode.never
                }
                labelPlayerDisplay = "player two"
                break
                
            default:
                print("error")
            }
            label.text = "Choose \(labelPlayerDisplay) emoji"
        }
    }

}
