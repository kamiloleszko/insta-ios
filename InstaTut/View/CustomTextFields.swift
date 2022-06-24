//
//  CustomTextFields.swift
//  InstaTut
//
//  Created by kamil on 10/06/2022.
//

import UIKit

class CustomTextFields: UITextField {
     
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        layer.cornerRadius =  15.0
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .default
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
        )
        
        if (placeholder == "Password") {
            isSecureTextEntry = true
        }
        
        if (placeholder == "Email") {
            keyboardType = .emailAddress
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
