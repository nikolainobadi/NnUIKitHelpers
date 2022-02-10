//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import UIKitExtensions

open class NnViewController: UIViewController {
    
    // MARK: - Init
    public init(hasTextFields: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        if hasTextFields { hideKeyboardWhenTappedAround() }
    }
    
    @available(*, unavailable, message: "Can't load VC from nib.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Can't load VC from nib.")
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Can't load VC from nib.")
    }
    
    
    // MARK: - KeyboardObserver Helpers
    
}


