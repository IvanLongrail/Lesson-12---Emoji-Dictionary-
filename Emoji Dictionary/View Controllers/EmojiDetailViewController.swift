//
//  EmojiDetailViewController.swift
//  Emoji Dictionary
//
//  Created by Denis Bystruev on 11/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class EmojiDetailViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var symbolField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var usageField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var emoji = Emoji()
    var keyboardActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func areFieldsReady() -> Bool {
        return !symbolField.isEmpty && !nameField.isEmpty && !descriptionField.isEmpty && !usageField.isEmpty
    }
    
    func saveEmoji() {
        emoji.symbol = symbolField.text ?? ""
        emoji.name = nameField.text ?? ""
        emoji.description = descriptionField.text ?? ""
        emoji.usage = usageField.text ?? ""
    }
    
    func setupUI() {
        symbolField.delegate = self
        nameField.delegate = self
        descriptionField.delegate = self
        usageField.delegate = self
        
        symbolField.text = emoji.symbol
        nameField.text = emoji.name
        descriptionField.text = emoji.description
        usageField.text = emoji.usage
    }
    
    func updateUI() {
        if symbolField.text!.count > 1 {
            symbolField.text = String( symbolField.text!.first! )
        }
        saveButton.isEnabled = areFieldsReady()
    }
    
    @IBAction func textChanged() {
        updateUI()
    }
}

// MARK: - Navigation
extension EmojiDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveEmoji()
    }
}

// MARK: - UITextFieldDelegate
extension EmojiDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension EmojiDetailViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {

            guard !keyboardActive else { return }

            self.view.frame.size.height -=  keyboardSize.height
            keyboardActive = true

        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            guard keyboardActive else { return }
            
            self.view.frame.size.height += keyboardSize.height
            keyboardActive = false
        }
    }
}
