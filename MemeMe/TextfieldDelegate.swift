//
//  TextfieldDelegate.swift
//  MemeMe
//
//  Created by Reinaldo Verdugo on 15/10/16.
//  Copyright © 2016 Reinaldo Verdugo. All rights reserved.
//

import UIKit

class TextfieldDelegate: NSObject, UITextFieldDelegate {
    
    var edited = false
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !edited {
            textField.text = ""
            edited = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
