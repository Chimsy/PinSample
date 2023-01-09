//
//  HideKeyboardOnEnterDelegate.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/09.
//  Copyright © 2023 Udacity. All rights reserved.
//

import Foundation
import UIKit

class HideKeyboardOnEnterDelegate: NSObject, UITextFieldDelegate {
    var activeTextField: UITextField? = nil
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard when user press enter
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
