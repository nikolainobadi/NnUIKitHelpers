//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

public extension UIButton {
    
    func setFont(_ fontStyle: FontStyle, fontName: FontName = .markerThin) -> UIButton {
        titleLabel?.font = UIFont(name: fontName.rawValue,
                                  size: getFontSize(fontStyle))
        return self
    }
    
    func autoSizeLabel() -> UIButton {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.2
        
        return self
    }
    
    func padding() -> UIButton {
        let verticalInset = getSize(xs: 3, l: 5)
        contentEdgeInsets = UIEdgeInsets(top: verticalInset,
                                         left: 10,
                                         bottom: verticalInset,
                                         right: 10)
        return self
    }
    
    func setColor(_ textColor: UIColor? = .systemBackground,
                  backgroundColor: UIColor? = .label) -> UIButton {
        
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
        
        return self
    }
    
    func addShadow(color: UIColor? = .label) -> UIButton {
        layer.shadowRadius = 4
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1,
                                    height: 2.0)
        return self
    }
    
    func addBorder(color: UIColor? = .label, width: CGFloat = 1) -> UIButton {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        
        return self
    }
    
    func setAction(_ action: @escaping () -> Void) -> UIButton {
        let tapAction = UIAction { [weak self] _ in
            self?.pulse()
            action()
        }
    
        self.addAction(tapAction, for: .touchUpInside)
        
        return self
    }
    
    func setAlpha(_ alpha: CGFloat) -> UIButton {
        self.alpha = alpha
        
        return self
    }
    
    func setEnabled(_ isEnabled: Bool) -> UIButton {
        self.isEnabled = isEnabled
        
        return self
    }
    
    func underline() -> UIButton {
        self.underlineTitleLabel()
        
        return self
    }
    
    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 1.0
        pulse.toValue = 0.95
        pulse.autoreverses = true
        pulse.initialVelocity = 1
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
    
    func underlineTitleLabel() {
        if let underlinedText = titleLabel?.getUnderlinedText() {
            setAttributedTitle(underlinedText, for: .normal)
        }
    }
}
