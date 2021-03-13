//
//  AuthenticationViewModel.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Foundation
import Combine
import AudioToolbox

/// Produces Heavy Vibration on Event Occured
///
// MARK: - This Action may fail if device has disabled SystemSound
public func produceHeavyVibration () {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
}

/// View Model for the Main Login view
/// Uses two Published variables to track the text input
/// and has 3 Combine publishers to validate the inputs
class AuthenticationViewModel: ObservableObject {
    
    @Published var email : String = "" { didSet { user.email = email } }
    @Published var password : String = "" { didSet {user.password = password }}
    @Published var isError : (state: Bool, message: String?) = (false, nil) {
        didSet {
            if isError.state == true {
                produceHeavyVibration()
            }
        }
    }
    
    @Published var isLoggedIn : Bool = TODOSession.shared.isLoggedIn
    @Published var user = TODOUserModel.init()
    
    /// Use CombineLatest to create a Publisher combining
    /// the output of two publishers
    var enableAuthentication:AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validEmail, validPassword)
            .map {$0 && $1}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    /// Publisher connected to email @Published var
    /// that publish a Bool value to check if the email is valid
    /// by checking its character count and its format
    var validEmail: AnyPublisher<Bool, Never> {
        return $email
            .map {$0.isValidEmail && $0.count > 8}
            .eraseToAnyPublisher()
    }
    
    /// Returns a Bool by checking the character count of
    /// the Published var password
    var validPassword:AnyPublisher<Bool, Never> {
        return $password
            .map {$0.count >= 8 }
            .eraseToAnyPublisher()
    }
    
    func authenticate(){
        TODOSession.shared.toDoUser = user
        isLoggedIn = true
        TODOSession.shared.isLoggedIn = isLoggedIn
    }
    
}
