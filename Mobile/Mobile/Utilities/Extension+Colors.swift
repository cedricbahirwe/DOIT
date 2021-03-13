//
//  Extension+Colors.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 20/02/2021.
//

import Foundation
import SwiftUI


fileprivate enum Colors: String {
    case petrol, darkBlue, lightBlue, lightGray, darkBlack
}
public extension Color {
    
    static let petrol = Color(Colors.petrol.rawValue)
    
    static let lightenGray = Color(Colors.lightGray.rawValue)
    
    static let lightBlue = Color(Colors.lightBlue.rawValue)
    
    static let darkBlue = Color(Colors.darkBlue.rawValue)
    
    static let darkBlack = Color(Colors.darkBlack.rawValue)
    
    
    // Neumorphism Colors
    static let background = Color("background")
    static let lightShadow = Color("lightShadow")
    static let darkShadow = Color("darkShadow")
    
    
    
    // Multipeer Connectivity
    static let senderBG = Color("userBG")
    static let receiverBG = Color("clientBG")
}
