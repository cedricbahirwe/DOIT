//
//  Extension+Binding.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                wrappedValue = newValue
                handler(newValue )
            }
        )
    }
}
