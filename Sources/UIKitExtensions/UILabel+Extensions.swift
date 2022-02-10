//
//  UILabel+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

public extension UILabel {
    
    // MARK: - Text Init
    convenience init(_ text: String = "") {
        self.init(frame: .zero)

        self.text = text
    }
    
    
    // MARK: Modifiers
    func setFontByStyle(_ style: FontStyle,
                        fontName: FontName = .markerThin) -> UILabel {
    
        font = UIFont(name: fontName.rawValue,
                      size: getFontSize(style))
        return self
    }
    
    func setFontBySize(_ size: CGFloat,
                       fontName: FontName = .markerThin) -> UILabel {
    
        font = UIFont(name: fontName.rawValue,
                      size: size)
        return self
    }

    func setAlignment(_ alignment: NSTextAlignment) -> UILabel {
        
        textAlignment = alignment
        
        return self
    }
    
    func autoSize(_ minimumScale: CGFloat = 0.2) -> UILabel {
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = minimumScale
        
        return self
    }
    
    func multipleLines(_ number: Int = 0) -> UILabel {
        
        numberOfLines = number
        
        return self
    }
    
    func setColor(_ textColor: UIColor?,
                  backgroundColor: UIColor? = .clear) -> UILabel {
        
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        
        return self
    }
    
    
    // MARK: Label Additions
    func addShadow(color: UIColor? = .label,
                   offset: CGSize? = nil) -> UILabel {
        
        let offset = offset ?? CGSize(width: 0.5,
                                      height: 1.5)
        shadowColor = color
        shadowOffset = offset
        
        return self
    }
}


// MARK: - Other Attributes
public extension UILabel {
    
    func getUnderlinedText() -> NSAttributedString? {
        guard let textString = text else { return nil }
        
        let attributedString = NSMutableAttributedString(string: textString)
        
        attributedString.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0,
            length: attributedString.length))
        
        return attributedString
    }
    
    func underlined() -> UILabel {
        if let underlinedText = getUnderlinedText() {
            attributedText = underlinedText
        }
        
        return self
    }
}



