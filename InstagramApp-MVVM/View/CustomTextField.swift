//
//  CustomTextField.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 17/03/2021.
//

import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Properties
    
    var spacer = UIView()
    
    //MARK: - Initializer
        
    init(placeholder: String, isSecureTextEntry: Bool) {
        super.init(frame: .zero)
        
        configureTextField(withPlaceholder: placeholder, isSecure: isSecureTextEntry)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    
    private func configureTextField(withPlaceholder placeholder: String, isSecure: Bool) {
        
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        isSecureTextEntry = isSecure
    }
}
