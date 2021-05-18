//
//  Extension - UIViewController - Create Alert.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 19/05/2021.
//

import UIKit

extension UIViewController {
    
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

