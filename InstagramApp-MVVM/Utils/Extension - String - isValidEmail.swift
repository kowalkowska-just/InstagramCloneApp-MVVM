//
//  Extension - String - isValidEmail.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 20/03/2021.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
