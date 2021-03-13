//
//  Extension+Fonts.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 20/02/2021.
//

import Foundation
import SwiftUI


enum MontserratFontName: String, CaseIterable {
    case regular = "Montserrat-Regular"
    case bold = "Montserrat-Bold"
}

extension Font {
    // Create a custom font with the given Poppins Font `name` and `size` that scales with
    /// the body text style.
    static func montSerrat(_ name: MontserratFontName, size: CGFloat = 16) -> Font {
        return .custom(name.rawValue, size: size)
    }
}
