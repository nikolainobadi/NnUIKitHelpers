//
//  TextFieldToolBar.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

struct ToolBarInfo {
    var leftButtonTitle: String? = nil
    var rightButtonTitle: String? = nil
    var leftButtonAction: (() -> Void)? = nil
    var rightButtonAction: (() -> Void)? = nil
    var tint: UIColor? = nil
}

public final class TextFieldToolBar: UIToolbar {
    
    // MARK: - Properties
    private let rightButtonText: String
    private let leftButtonText: String
    private let rightButtonAction: (() -> Void)?
    private let leftButtonAction: (() -> Void)?

    
    // MARK: - Buttons
    lazy var nextButton: UIBarButtonItem = {
        UIBarButtonItem(title: rightButtonText,
                        style: .plain,
                        target: self,
                        action: #selector(didTapNextButton))
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        UIBarButtonItem(title: leftButtonText,
                        style: .plain,
                        target: self,
                        action: #selector(didTapCancelButton))
    }()
    
    lazy var spaceButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                        target: nil,
                        action: nil)
    }()
    
    
    // MARK: - Init
    public init(leftButtonText: String = "Cancel",
                rightButtonText: String = "Next",
                onNextTapped: (() -> Void)? = nil,
                onCancelTapped: (() -> Void)? = nil,
                tintColor: UIColor? = .white) {
        
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        self.leftButtonAction = onCancelTapped
        self.rightButtonAction = onNextTapped
        super.init(frame: .zero)
        
        self.sizeToFit()
        self.tintColor = tintColor
        
        let leftButton = onCancelTapped != nil ? cancelButton : spaceButton
        let rightButton = onNextTapped != nil ? nextButton : spaceButton

        setItems([leftButton, spaceButton, rightButton], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Actions
    @objc func didTapNextButton() {
        rightButtonAction?()
    }
    
    @objc func didTapCancelButton() {
        leftButtonAction?()
    }
}
