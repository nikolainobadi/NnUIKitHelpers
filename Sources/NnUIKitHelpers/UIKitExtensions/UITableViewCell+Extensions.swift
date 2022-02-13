//
//  UITableViewCell+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

import UIKit

public extension UITableViewCell {
    
    func setCustomLabel(_ text: String,
                        textColor: UIColor? = .label,
                        multipleLines: Bool = false,
                        fontName: FontName = .markerThin) {
        
        guard let label = self.textLabel else { return }
        
        let fontSize = getFontSize(.detail)
        
        if let font = UIFont(name: fontName.rawValue,  size: fontSize) {
            label.font = font
        }
        
        if multipleLines { label.numberOfLines = 0 }
        
        label.text = text
        label.textColor = textColor
    }
}
