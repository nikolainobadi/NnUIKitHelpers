//
//  UIView+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit

// MARK: - Device Size
public extension UIView {
    
    enum PhoneSize {
        case xs, small, medium, large, xl, xxl, unknown
    }
    
    var screenHeight: CGFloat { UIScreen.main.bounds.height }
    var screenWidth: CGFloat { UIScreen.main.bounds.width }
    var buttonHeight: CGFloat { heightPercent(5) }
    
    var phoneSize: PhoneSize {
        let height = UIScreen.main.bounds.height
        
        switch height {
        case 0..<668: return .xs        // SE
        case 668..<737: return .small   // 8 plus
        case 737..<813: return .medium  // X
        case 813..<845: return .large   // 12
        case 845..<897: return .xl      // 11 pro max
        case 897..<927: return .xxl     // 12 pro max
        default: print(height); return .unknown
        }
    }
    
    func heightPercent(_ percent: CGFloat) -> CGFloat {
        let adjustedPercent = percent * 0.01
        
        return screenHeight * adjustedPercent
    }
    
    func widthPercent(_ percent: CGFloat) -> CGFloat {
        let adjustedPercent = percent * 0.01
        
        return screenWidth * adjustedPercent
    }
    
    func getSize(xs: CGFloat,
                 s: CGFloat? = nil,
                 m: CGFloat? = nil,
                 l: CGFloat? = nil,
                 xl: CGFloat? = nil,
                 xxl: CGFloat? = nil) -> CGFloat {
        
        switch phoneSize {
        case .xs: return xs
        case .small: return s ?? xs
        case .medium: return m ?? s ?? xs
        case .large: return l ?? m ?? s ?? xs
        case .xl: return xl ?? l ?? m ?? s ?? xs
        case .xxl: return xxl ?? xl ?? l ?? m ?? s ?? xs
        default: fatalError("Unexpected phone size")
        }
    }
}


// MARK: - Font Size
public extension UIView {
    
    // MARK: Enum
    enum FontStyle {
        case giant, largeTitle, title, smallTitle, largeDetail, detail, smallDetail, errorLabel, speechBubble
    }
    
    
    // MARK: Get Font Size
    func getFontSize(_ fontStyle: FontStyle) -> CGFloat {
    
        switch fontStyle {
        
        case .giant: return getSize(xs: 130, s: 160, xl: 180, xxl: 200)
        
        // title
        case .largeTitle: return getSize(xs: 70, s: 75, l: 78, xl: 80)
        case .title: return getSize(xs: 45, s: 50, l: 52, xl: 54)
        case .smallTitle: return getSize(xs: 38, s: 40, xl: 42, xxl: 45)
            
        // detail
        case .largeDetail: return getSize(xs: 25, s: 30, l: 32, xl: 35)
        case .detail: return getSize(xs: 18, s: 20, xxl: 22)
        case .smallDetail: return getSize(xs: 15, s: 18)
            
        // other
        case .speechBubble: return getSize(xs: 20, s: 21, l: 23, xl: 24, xxl: 25)
        case .errorLabel: return getSize(xs: 12, l: 14, xxl: 16)
        }
    }
}


// MARK: Anchors
public extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.topAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.bottomAnchor
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                topConstant: CGFloat = 0,
                leftConstant: CGFloat = 0,
                bottomConstant: CGFloat = 0,
                rightConstant: CGFloat = 0,
                widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top,
                                    left: left,
                                    bottom: bottom,
                                    right: right,
                                    topConstant: topConstant,
                                    leftConstant: leftConstant,
                                    bottomConstant: bottomConstant,
                                    rightConstant: rightConstant,
                                    widthConstant: widthConstant,
                                    heightConstant: heightConstant)
    }
    
    func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil,
                                 left: NSLayoutXAxisAnchor? = nil,
                                 bottom: NSLayoutYAxisAnchor? = nil,
                                 right: NSLayoutXAxisAnchor? = nil,
                                 topConstant: CGFloat = 0,
                                 leftConstant: CGFloat = 0,
                                 bottomConstant: CGFloat = 0,
                                 rightConstant: CGFloat = 0,
                                 widthConstant: CGFloat = 0,
                                 heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor,
                                     constant: constant).isActive = true
        }
    }
    
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor,
                                     constant: constant).isActive = true
        }
    }
    
    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}


// MARK: - Frames
public extension UIView {
    
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        guard subview.isDescendant(of: self) else {
            return nil
        }
        
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }
        
        return superview!.convert(frame, to: self)
    }
}

