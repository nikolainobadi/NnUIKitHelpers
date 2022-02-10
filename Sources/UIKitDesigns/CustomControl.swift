//
//  CustomControl.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import UIKitExtensions

open class CustomControl: UISegmentedControl {
    
    // MARK: - Init
    public init(items: [Any]?, tint: UIColor? = .systemBackground) {
        super.init(items: items)
        
        selectedSegmentIndex = 0
        selectedSegmentTintColor = tint
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1, height: 2.0)
    }
}
