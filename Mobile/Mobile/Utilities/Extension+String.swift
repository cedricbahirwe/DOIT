//
//  Extension+String.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Foundation

extension String {
    // check if a given String has an Email format
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
