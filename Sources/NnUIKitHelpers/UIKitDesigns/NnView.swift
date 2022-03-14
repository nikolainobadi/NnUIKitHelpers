//
//  NnView.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

open class NnView: UIView {
    
    // MARK: - Init
    public init(frame: CGRect = .zero, color: UIColor? = .systemBackground) {
        super.init(frame: frame)
        
        addSubviews()
        backgroundColor = color
    }
    
    @available(*, unavailable, message: "Can't load from a nib, fool!")
    required public init?(coder: NSCoder) {
        fatalError("Can't load from a nib, fool!")
    }
    
    // MARK: - Display Setup
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        setupConstraints()
    }
    
    open func addSubviews() { }
    open func setupConstraints() { }
    
    public func addShadowEffect(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowRadius = 4
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1, height: 2.0)
    }
}


