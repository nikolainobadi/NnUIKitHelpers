//
//  ShadowField.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

open class ShadowField: UITextField {
    
    // MARK: - Properties
    private let nakedField: Bool
    private let withErrorLabel: Bool

    private var errorPadding: CGFloat?
    
    
    // MARK: - Views
    public lazy var errorLabel: UILabel = {
        UILabel()
            .setColor(.systemRed)
            .setAlignment(.center)
            .setFontByStyle(.errorLabel)
    }()
    
    
    // MARK: - Init
    public init(_ placeholder: String,
                nakedField: Bool = false,
                withErrorLabel: Bool = false,
                withDefaultDesign: Bool = true) {
        
        self.nakedField = nakedField
        self.withErrorLabel = withErrorLabel
        super.init(frame: .zero)
        
        font = UIFont(name: "MarkerFelt-Thin", size: getSize(xs: 22, s: 24, xl: 26))
        self.placeholder = placeholder
        
        if withErrorLabel { addErrorLabel() }
        if withDefaultDesign { setDefaultDesign() }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Layout Subviews
public extension ShadowField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !nakedField else { return  }
        
        // background
        layer.backgroundColor = UIColor.systemBackground.cgColor
        
        // border
        borderStyle = .none
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0,
                                    height: 1.0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


// MARK: - ErrorLabel
public extension ShadowField {
    
    func setErrorMessage(_ message: String) {
        guard withErrorLabel else { return }
        
        errorLabel.text = message
        errorPadding = message == "" ? nil : getSize(xs: 2,
                                                     l: 6,
                                                     xxl: 10)
    }
}

// MARK: - Modifiers
public extension ShadowField {
    
    func autoCapitalize(_ autoType: UITextAutocapitalizationType) -> ShadowField {
        self.autocapitalizationType = autoType
        
        return self
    }
    
    func setTag(_ num: Int) -> ShadowField {
        self.tag = num
        
        return self
    }
    
    func setText(_ text: String) -> ShadowField {
        self.text = text
        
        return self
    }
    
    func setTouchDownAction(_ touchDownAction: @escaping () -> Void) -> ShadowField {
        
        let action = UIAction { _ in
            touchDownAction()
        }
        
        self.addAction(action, for: .editingDidBegin)
        
        return self
    }
    
    func setEditAction(_ editAction: @escaping () -> Void) -> ShadowField {
        
        let action = UIAction { _ in
            editAction()
        }
        
        self.addAction(action, for: .editingChanged)
        
        return self
    }
    
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> ShadowField {
        self.keyboardType = keyboardType
        
        return self
    }
    
    func isPassword() -> ShadowField {
        self.isSecureTextEntry = true
        
        return self
    }
}


// MARK: - Private Methods
private extension ShadowField {
    
    var padding: UIEdgeInsets {
        UIEdgeInsets(top: 0,
                     left: 5,
                     bottom: errorPadding ?? 0,
                     right: 5)
    }
    
    func setDefaultDesign() {
        textAlignment = .center
        keyboardAppearance = .dark
        autocorrectionType = .no
        autocapitalizationType = .none
    }
    
    func addErrorLabel() {
        addSubview(errorLabel)
        errorLabel.anchor(bottom: bottomAnchor)
        errorLabel.anchorCenterXToSuperview()
        
        let action = UIAction { [weak self] _ in
            self?.setErrorMessage("")
        }
        
        addAction(action, for: .editingChanged)
    }
}


