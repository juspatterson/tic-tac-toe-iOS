//
//  EmojiTextField.swift
//  emoji tic tac tow
//
//  Created by Justin Patterson on 11/9/21.
//

import UIKit

class EmojiTextField: UITextField, UITextInputDelegate {
    func selectionWillChange(_ textInput: UITextInput?) {}
    
    func selectionDidChange(_ textInput: UITextInput?) { hideDockView() }
    
    func textWillChange(_ textInput: UITextInput?) {}
    
    func textDidChange(_ textInput: UITextInput?) {}


    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        inputDelegate = self
        
            commonInit()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)

        commonInit()
    }

    func commonInit() {
        NotificationCenter.default.addObserver(self,selector: #selector(inputModeDidChange),name: UITextInputMode.currentInputModeDidChangeNotification,object: nil)
            
    }
    
    @objc func inputModeDidChange(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) { self.hideDockView() }
    }
    
    func hideDockView() {
        UIApplication.shared.keyboardWindow?.dockView.forEach { $0.isHidden = true }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
    

    
    
}

