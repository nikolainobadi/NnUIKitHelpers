//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import Combine

open class NnViewController: UIViewController {
    
    // MARK: - Properties
    private var fieldsToObserve: [UITextField]? = nil
    private var pubStore: AnyCancellable?
    
    
    // MARK: - Init
    public init(hasTextFields: Bool = false, fieldsToObserve: [UITextField]? = nil) {
        
        self.fieldsToObserve = fieldsToObserve
        super.init(nibName: nil, bundle: nil)
        
        if hasTextFields { hideKeyboardWhenTappedAround() }
        if fieldsToObserve != nil { setupKeyboardObserver() }
    }
    
    @available(*, unavailable, message: "Can't load VC from nib.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Can't load VC from nib.")
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Can't load VC from nib.")
    }
}


// MARK: - Private
private extension NnViewController {
    
    func setupKeyboardObserver() {
        pubStore = KeyboardObserver().keyboardHeightPublisher
            .sink { [weak self] in self?.moveContentAbove($0) }
    }
    
    func getFirstResponder() -> UIView? {
        fieldsToObserve?.first(where: { $0.isFirstResponder })
    }
    
    func moveContentAbove(_ keyboardHeight: CGFloat) {
        guard
            let currentField = getFirstResponder(),
            let fieldBottom = view.getConvertedFrame(fromSubview: currentField)?.maxY
        else { return }
        
        var toolbarHeight: CGFloat = 0
        
        if let toolbar = currentField.inputAccessoryView {
            toolbarHeight = view.getConvertedFrame(fromSubview: toolbar)?.maxY ?? 0
        }

        let keyboardTop = view.screenHeight - keyboardHeight - toolbarHeight

        if fieldBottom > keyboardTop {
            view.frame.origin.y = -(fieldBottom - keyboardTop)
        } else {
            view.frame.origin.y = 0
        }
    }
}
