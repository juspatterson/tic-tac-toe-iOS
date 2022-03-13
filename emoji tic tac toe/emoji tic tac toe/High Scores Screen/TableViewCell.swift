//
//  TableViewCell.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 3/9/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let fontSize: CGFloat = 27
    let padding: CGFloat = 25
    let paddingDateTime: CGFloat = 10
    
    lazy var playerNameLabel: UILabel = with(UILabel()) {
        contentView.addSubview($0)
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: fontSize)
        $0.adjustsFontForContentSizeCategory = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
        ])
    }
    
    lazy var numberOfMovesLabel: UILabel = with(UILabel()) {
        contentView.addSubview($0)
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: fontSize)
        $0.adjustsFontForContentSizeCategory = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    lazy var dateTimeLabel: UILabel = with(UILabel()) {
        contentView.addSubview($0)
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: fontSize)
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            $0.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingDateTime)
        ])
    }
    
    func setupUI(){
        
        layer.masksToBounds = true
        layer.cornerRadius = 16
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
    }
    
}
