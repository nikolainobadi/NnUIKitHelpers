//
//  KeyboardObserver.swift
//
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import Combine

public final class KeyboardObserver {
    
    // MARK: - Properties
    private let notifCenter = NotificationCenter.default
    
    
    // MARK: - Init
    public init() { }
}


// MARK: - Keyboard Observer
extension KeyboardObserver {
    
    public var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(willShowPublisher, willHidePublisher)
            .eraseToAnyPublisher()
    }
}


// MARK: - Private
private extension KeyboardObserver {
    
    var willShowPublisher: AnyPublisher<CGFloat, Never> {
        notifCenter.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }
            .eraseToAnyPublisher()
    }
    
    var willHidePublisher: AnyPublisher<CGFloat, Never> {
        notifCenter.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .eraseToAnyPublisher()
    }
}
