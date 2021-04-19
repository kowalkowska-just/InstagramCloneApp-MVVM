//
//  Extension - UIViewController - JGProgressHUD.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 19/04/2021.
//

import JGProgressHUD

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
}
