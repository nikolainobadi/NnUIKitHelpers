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
