//
//  GameBoradCell.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 31/8/21.
//

import UIKit

class GameBoardCell: UICollectionViewCell {
    
    let fontSize: CGFloat = 400
    let offset: CGFloat = -40

    lazy var label: UILabel = with(UILabel()) {
        contentView.addSubview($0)
        $0.backgroundColor = .clear
        $0.font = .boldSystemFont(ofSize: fontSize)
        //$0.minimumScaleFactor = 0.5
        $0.minimumScaleFactor = 0.2
        $0.numberOfLines = 0
        
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            $0.topAnchor.constraint(equalTo: contentView.topAnchor),
            $0.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        label.text?.removeAll()
    }
    
    func setupUI(){
        
        layer.masksToBounds = true
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate( [
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor)
        ] )
        
    }
}
