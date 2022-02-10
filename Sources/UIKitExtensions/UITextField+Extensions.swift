//
//  UITextField+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import Combine

public extension UITextField {
    
    func trimmedText() -> String? {
        text?.trimmingCharacters(in: .whitespaces)
    }
    
    var noWaitTextPublisher: AnyPublisher<String, Never> {
            NotificationCenter.default
                .publisher(for: UITextField.textDidChangeNotification, object: self)
                .compactMap { $0.object as? UITextField }
                .map { $0.text ?? "" }
                .eraseToAnyPublisher()
    }
    
    var textPublisher: AnyPublisher<String, Never> {
            noWaitTextPublisher
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
    }
    
    var endEditingPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}


// MARK: - Modifiers
public extension UITextField {
    
    func autoCapitalize(_ autoType: UITextAutocapitalizationType) -> UITextField {
        self.autocapitalizationType = autoType
        
        return self
    }
    
    func setTag(_ num: Int) -> UITextField {
        self.tag = num
        
        return self
    }
    
    func setText(_ text: String) -> UITextField {
        self.text = text
        
        return self
    }
    
    func setTouchDownAction(_ touchDownAction: @escaping () -> Void) -> UITextField {
        
        let action = UIAction { _ in
            touchDownAction()
        }
        
        self.addAction(action, for: .editingDidBegin)
        
        return self
    }
    
    func setEditAction(_ editAction: @escaping () -> Void) -> UITextField {
        
        let action = UIAction { _ in
            editAction()
        }
        
        self.addAction(action, for: .editingChanged)
        
        return self
    }
    
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> UITextField {
        self.keyboardType = keyboardType
        
        return self
    }
    
    func isPassword() -> UITextField {
        self.isSecureTextEntry = true
        
        return self
    }
}






