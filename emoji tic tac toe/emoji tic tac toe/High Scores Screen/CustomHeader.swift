//
//  CustomHeader.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 3/9/21.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setup()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let fontSize: CGFloat = 27
    let padding: CGFloat = 20
    let paddingDateTime: CGFloat = 30
    
    lazy var playerNameHeaderLabel: UILabel = with(UILabel()) {
        contentView.addSubview($0)
        $0.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0.50, alpha: 0.50)
        $0.font = .boldSystemFont(ofSize: fontSize)
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.text = "Players\nName"
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            //$0.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    lazy var numberOfMovesHeaderLabel: UILabel = with(UILabel()) {
        contentView.addSubview($0)
        $0.backgroundColor = .clear
        $0.font = .boldSystemFont(ofSize: fontSize)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.adjustsFontForContentSizeCategory = true
        $0.text = "Number Of\n    Moves"
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.topAnchor.constraint(equalTo: contentView.topAnchor),
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    lazy var dateTimeHeaderLabel: UILabel = with(UILabel()) {
        contentView.addSubview($0)
        $0.backgroundColor = .clear
        $0.font = .boldSystemFont(ofSize: fontSize)
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.text = "Date/\nTime"
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -paddingDateTime),
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    func setup() {
        
        layer.masksToBounds = true
        
        
    }
    
    
}
