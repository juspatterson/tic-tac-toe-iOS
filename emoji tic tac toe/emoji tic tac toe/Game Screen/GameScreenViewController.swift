//
//  GameScreenViewController.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

import UIKit

class GameScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let spacing = CGFloat(10)
    let padding = CGFloat(10)
    let router: Router
    let gameScreenViewModel: GameScreenViewModel
    
    let layout = UICollectionViewFlowLayout()
    let gameBoardCellIdentifier = "gameBroadCell"
    lazy var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    init(router: Router, gameScreenViewModel: GameScreenViewModel) {
        self.router = router
        self.gameScreenViewModel = gameScreenViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let screenTopOffset = (view.bounds.size.height) / 5

        
        cv.register(GameBoardCell.self, forCellWithReuseIdentifier: gameBoardCellIdentifier)
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = true
        cv.bounces = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .customDarkGreen
        cv.alwaysBounceVertical = false
        cv.alwaysBounceHorizontal = false
        view.addSubview(cv)
        
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenTopOffset),
            //cv.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            cv.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            cv.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            cv.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor) // - ((spacing + 1.3) * 2))
        ])
        
        //safe area insets
        additionalSafeAreaInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let buttonWidth = (view.bounds.size.width) / 1.2
        
        let endGameButton = with(UIButton()){
            $0.setTitle("Restart Game", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize + 8)
            $0.addTarget(self, action: #selector(endGameButtonAction), for: .touchUpInside)
            $0.backgroundColor = .customDarkGreen
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.layer.cornerRadius = 12
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        
        view.addSubview(endGameButton)
        
        NSLayoutConstraint.activate([
            endGameButton.topAnchor.constraint(equalTo: cv.bottomAnchor, constant: padding),
            endGameButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            endGameButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            
        ])
        
        gameScreenViewModel.selectPlayerOne(cv: cv)
        
    }
    
    @objc func endGameButtonAction() {
        alert(message: "You are about to restart the game all progress will be lost")
    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,  handler: { (action: UIAlertAction!) in
            //self.cv.visibleCells.forEach { $0.contentView.subviews.forEach { $0.removeFromSuperview() } }
            self.cv.reloadData()
            self.gameScreenViewModel.restartGame(cv: self.cv)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler: { (action: UIAlertAction!) in
                    //if anything to do after cancel clicked
        }))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameBoardCellIdentifier, for: indexPath) as! GameBoardCell
        
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch gameScreenViewModel.numberOfPlayers {
        case 1:
            gameScreenViewModel.humanPlayerTurn(indexPath: indexPath, cv: cv)
            break
        case 2:
            gameScreenViewModel.twoPlayers(indexPath: indexPath, cv: cv)
            break
        default:
            print("error")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.size.width / 3) - spacing
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
}
