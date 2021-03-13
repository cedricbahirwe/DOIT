//
//  Extension+View.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Foundation
import SwiftUI

extension View {
    // Apply Neumorphism light and dark shadow
    func neumorphismShadow(_ radius: CGFloat = 8) -> some View {
        self
            .shadow(color: .lightShadow, radius: radius, x: -radius, y: -radius)
            .shadow(color: .darkShadow, radius: radius, x: radius, y: radius)
    }
    public func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
    
}
