//
//  EmojiPickerCell.swift
//  emoji tic tac tow
//
//  Created by Justin Patterson on 11/9/21.
//

import UIKit

class EmojiPickerCell: UIView, UITextFieldDelegate {
    
    var onEmojiChanged: (String) -> Void = { _ in }
    var playerOneChosenEmoji: (String) -> Void = { _ in }
    var size: CGFloat
    
    
    init(frame: CGRect, size: CGFloat) {
        self.size = size
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textFieldLabel = with(UILabel()) {
        $0.adjustsFontSizeToFitWidth = true
        $0.numberOfLines = 2
        $0.font = .boldSystemFont(ofSize: 50)
        $0.tintColor = .systemBackground
        $0.textColor = .systemBackground
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var textField = with(EmojiTextField()){
        $0.textAlignment = .center
        $0.tintColor = .clear
        $0.font = .boldSystemFont(ofSize: 400)
        $0.adjustsFontSizeToFitWidth = true
        $0.delegate = self
        $0.leftViewMode = UITextField.ViewMode.unlessEditing
        $0.leftView = textFieldLabel
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = string.last.map { "\($0)" }
        onEmojiChanged(textField.text ?? " ")
        playerOneChosenEmoji(textField.text ?? " ")
        placeHolder()
        return false
    }
    
    func setText(text:String) {
        textField.text = text
        textField.leftViewMode = UITextField.ViewMode.never
    }
    
    func setupUI(){
        addSubview(textField)
        
        
        
        layer.masksToBounds = true
        layer.cornerRadius = size/2
        backgroundColor = .labelBackGround
        let spacing: CGFloat = 24
        
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: CGFloat(size)),
            widthAnchor.constraint(equalToConstant: CGFloat(size)),
            textField.heightAnchor.constraint(equalToConstant: CGFloat(size - spacing * 2)).usingPriority(.almostRequired),
            textField.widthAnchor.constraint(equalToConstant: CGFloat(size - spacing * 2)).usingPriority(.almostRequired),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor).usingPriority(.almostRequired),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor).usingPriority(.almostRequired),
            textFieldLabel.heightAnchor.constraint(equalToConstant: CGFloat(size - spacing * 2)).usingPriority(.almostRequired),
            textFieldLabel.widthAnchor.constraint(equalToConstant: CGFloat(size - spacing * 2)).usingPriority(.almostRequired),
            ])

    }
    
    @objc func placeHolder(){
        if textField.hasText { textField.leftViewMode = UITextField.ViewMode.never }
        else {  textField.leftViewMode = UITextField.ViewMode.unlessEditing }
    }
    
    func hasText() -> Bool { return textField.hasText}
}

