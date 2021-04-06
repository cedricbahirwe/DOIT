//
//  LoginView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Combine
import SwiftUI
import SafariServices

struct LoginView: View {
    // MARK: - Main Class for Authenticaton Management
    @ObservedObject var authVM: AuthenticationViewModel
    
    @State private var enableLoginButton = true
    @State private var validateEmail: Bool = false
    @State private var validatePassword: Bool = false
    
    var validFirstName: Bool {
        authVM.user.firstName.trimmingCharacters(in: .whitespaces).count >= 3
    }
    var validLastName: Bool {
        return authVM.user.lastName.trimmingCharacters(in: .whitespaces).count >= 3
    }
    var body: some View {
        VStack(spacing: 35) {
            Spacer().frame(minHeight: 10)

            Image("abc-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 80)
            
            VStack(spacing: 18) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("First name")
                            .font(.montSerrat(.regular))
                        
                        TextField("John", text: $authVM.user.firstName)
                            .keyboardType(.default)
                            .textContentType(.givenName)
                            .disableAutocorrection(true)
                            .padding(.vertical, 5)
                            .foregroundColor(Color(.label))
                            .overlay(Color.darkBlue.frame(height: 1), alignment: .bottom)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Last name")
                            .font(.montSerrat(.regular))
                        
                        TextField("Doe", text: $authVM.user.lastName)
                            .keyboardType(.default)
                            .textContentType(.familyName)
                            .disableAutocorrection(true)
                            .padding(.vertical, 5)
                            .overlay(Color.darkBlue.frame(height: 1), alignment: .bottom)
                    }
                }
                .foregroundColor(Color(.label))
                
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 5) {
                        Text("Email Address")
                            .font(.montSerrat(.regular))
                        if validateEmail {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.darkBlue)
                        }
                        
                    }
                    TextField("example@gmail.com", text: $authVM.email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.vertical, 5)
                        .overlay(Color.darkBlue.frame(height: 1), alignment: .bottom)
                }
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 5) {
                        Text("Password")
                            .font(.montSerrat(.regular))
                        if validatePassword {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.darkBlue)
                        }
                    }
                    
                    
                    SecureField("**************", text: $authVM.password)
                        .textContentType(.password)
                        .padding(.vertical, 5)
                        .foregroundColor(Color(.label))
                        .overlay(Color.darkBlue.frame(height: 1), alignment: .bottom)
                    
                }
            }
            
            VStack(alignment: .trailing, spacing: 10) {
                Button(action: {
                    authVM.authenticate()
                    hideKeyboard()
                }) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .font(.montSerrat(.bold))
                        .foregroundColor(Color(.systemBackground))
                        .background(Color(.label))
                        .cornerRadius(5)
                }
                .disabled(!(validateEmail && validatePassword && validFirstName && validLastName))
                .opacity(validateEmail && validatePassword && validFirstName && validLastName ? 1 : 0.5)
                
            }
            
            Spacer().frame(minHeight: 10)
            Spacer().frame(minHeight: 10)

        }
        .padding(.horizontal)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onReceive(authVM.enableAuthentication) { enableLoginButton = !$0 }
        .onReceive(authVM.validEmail) { validateEmail = $0 }
        .onReceive(authVM.validPassword) {validatePassword = $0 }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authVM: AuthenticationViewModel())
    }
}
