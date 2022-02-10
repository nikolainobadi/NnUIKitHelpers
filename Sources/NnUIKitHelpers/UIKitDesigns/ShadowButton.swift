//
//  ShadowButton.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

open class ShadowButton: UIButton {
    
    // MARK: - Properties
    public let type: ButtonType
    
    public enum ButtonType { case shadow, naked, circle }
    
    
    // MARK: - Init
    public init(_ text: String = "", buttonType: ButtonType = .shadow, addDefaultDesign: Bool = false) {
        self.type = buttonType
        super.init(frame: .zero)
        
        setTitle(text, for: .normal)
        
        if addDefaultDesign { setDefaultDesign(buttonType) }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switch type {
        case .shadow:
            layer.cornerRadius = bounds.height / 2
        case .circle:
            layer.cornerRadius = bounds.width / 2
        default:
            break
        }
    }
    
    
    // MARK: - Helpers
    func setDefaultDesign(_ buttonType: ButtonType) {
        let style: FontStyle = buttonType == .naked ? .errorLabel : .largeDetail
        let size = getFontSize(style)
        
        let verticalInsets = getSize(xs: 3, l: 5)
        
        // colors
        setTitleColor(buttonType == .naked ? .label : .white, for: .normal)
        
        // shadow
        if buttonType != .naked {
            layer.shadowRadius = 4
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.label.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 2.0)
        }
        
        // font
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.2
        
        let fontName: FontName = buttonType == .naked ? .thonburi : .markerThin
        titleLabel?.font = UIFont(name: fontName.rawValue, size: size)
        
        // padding
        var topPadding = verticalInsets
        if type == .circle { topPadding *= 4 }
        
        contentEdgeInsets = UIEdgeInsets(top: topPadding,
                                         left: 10,
                                         bottom: verticalInsets,
                                         right: 10)
    }
}
