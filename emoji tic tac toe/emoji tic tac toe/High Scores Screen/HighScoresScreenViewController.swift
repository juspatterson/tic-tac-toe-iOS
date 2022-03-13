//
//  HighScoresScreenViewController.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

import UIKit

class HighScoresScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    //func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "name"
    //}
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    

    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                   "sectionHeader") as! CustomHeader
        
        view.tintColor = UIColor.init(hue: 0, saturation: 0, brightness: 0.50, alpha: 0.50)
        view.playerNameHeaderLabel.backgroundColor = .clear
        view.numberOfMovesHeaderLabel.backgroundColor = .clear
        view.dateTimeHeaderLabel.backgroundColor = . clear
       

       return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! TableViewCell

        cell.playerNameLabel.text = highScores[indexPath.item].playerName as String
        
        let aString = highScores[indexPath.item].dateTime as String
        let newString = aString.replacingOccurrences(of: ",", with: " ")
        
        cell.numberOfMovesLabel.text = String(highScores[indexPath.item].numberOFMoves)
        
        
        
        cell.dateTimeLabel.text = newString
        
        cell.dateTimeLabel.lineBreakMode = NSLineBreakMode.byWordWrapping

        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return highScores.count
    }
    
    
    lazy var tv = UITableView(frame: .zero, style: .plain)
    
    let spacing = CGFloat(10)
    let padding = CGFloat(10)
    let router: Router
    let database: Database
    let tableViewCellIdentifier = "tableViewCell"
    lazy var highScores = database.accessDatabase()
    
    
    
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
        
        //cv.register(GameBoardCell.self, forCellWithReuseIdentifier: gameBoardCellIdentifier)
        
            
            
        tv.dataSource = self
        tv.delegate = self
        tv.register(CustomHeader.self,forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tv.register(TableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        tv.rowHeight = 80
        
        
        
        
        view.backgroundColor = .systemBackground
        
        //safe area insets
        additionalSafeAreaInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        
        view.addSubview(tv)
        
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tv.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tv.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])

        
    }

}
