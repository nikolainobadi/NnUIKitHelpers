//
//  UISegmentedControls+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//
import UIKit 

public extension UISegmentedControl {
    
    func setAction(action: @escaping () -> Void) -> UISegmentedControl {
        self.addAction(UIAction { _ in action() }, for: .valueChanged)
        
        return self
    }
    
    func setItemFonts(selectedStyle: FontStyle = .detail,
                      unselectedStyle: FontStyle = .errorLabel) -> UISegmentedControl {
        
        setAttributes(fontStyle: selectedStyle, for: .selected)
        setAttributes(fontStyle: unselectedStyle, for: .normal)
        
        return self
    }
    
    func setBackgroundColor(_ color: UIColor?) -> UISegmentedControl {
        self.backgroundColor = color
        
        return self
    }
}


// MARK: - Private Methods
private extension UISegmentedControl {
    
    func setAttributes(fontStyle: FontStyle, for state: UIControl.State) {
        
        if let font = makeFont(fontStyle) {
            setTitleTextAttributes([NSAttributedString.Key.font: font], for: state)
        }
    }
    
    func makeFont(_ fontStyle: FontStyle) -> UIFont? {
        UIFont(name: "MarkerFelt-Thin", size: getFontSize(fontStyle))
    }
}
