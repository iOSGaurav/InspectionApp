//
//  String+Extension.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//
import Foundation

extension String {
    func isValidEmail() -> Bool {
        // Basic email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
