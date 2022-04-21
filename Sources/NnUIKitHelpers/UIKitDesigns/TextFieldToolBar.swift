//
//  TextFieldToolBar.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

public final class TextFieldToolBar: UIToolbar {
    
    // MARK: - Properties
    private let onNextTapped: (() -> Void)?
    private let onCancelTapped: (() -> Void)?

    
    // MARK: - Buttons
    lazy var nextButton: UIBarButtonItem = {
        UIBarButtonItem(title: "Next",
                        style: .plain,
                        target: self,
                        action: #selector(didTapNextButton))
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        UIBarButtonItem(title: "Cancel",
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
    public init(onNextTapped: (() -> Void)? = nil,
                onCancelTapped: (() -> Void)? = nil,
                tintColor: UIColor? = .white) {
        
        self.onNextTapped = onNextTapped
        self.onCancelTapped = onCancelTapped
        super.init(frame: .zero)
        
        sizeToFit()
        self.tintColor = tintColor
        
        setItems([cancelButton, spaceButton, nextButton],
                 animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Actions
    @objc func didTapNextButton() {
        onNextTapped?()
    }
    
    @objc func didTapCancelButton() {
        onCancelTapped?()
    }
}


