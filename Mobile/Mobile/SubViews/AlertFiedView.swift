//
//  AlertFiedView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 23/02/2021.
//

import SwiftUI

struct AlertFiedView: View {
    @Binding var isPresented: Bool
    @Binding var username: String
    @State private var textValue = ""
    var body: some View {
        ZStack {
            Color.black.opacity(0.91).edgesIgnoringSafeArea(.all)
                .blur(radius: 0.7)
                .allowsHitTesting(false)
                .animation(nil)
            VStack(spacing: 15) {
                Text("Change your user name")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.vertical, 12)
                TextField("Change your username", text: $textValue)
                    .textContentType(.nickname)
                    .disableAutocorrection(false)
                    .autocapitalization(.words)
                    .padding(5)
                    .textFieldStyle(PlainTextFieldStyle())
                    .border(Color.gray, width: 0.5)
                    .padding(.horizontal)
                HStack(spacing: 0) {
                    Button(action: {
                        hideKeyboard()
                        textValue = ""
                        isPresented.toggle()
                    }, label: {
                        Text("Cancel")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 38)
                            .foregroundColor(.red)
                    })
                    Divider()
                        .frame(height: 38)
                    Button(action: {
                        username = textValue.trimmingCharacters(in: .whitespaces)
                        splitAndStore(username)
                        hideKeyboard()
                        isPresented.toggle()
                        
                        
                    }, label: {
                        Text("Done")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                        
                    })
                    .disabled(textValue.count < 3)
                    .opacity(textValue.count < 3 ? 0.3 : 1.0)
                }
                .overlay(Color.gray.frame(height: 0.5), alignment: .top)
                
            }
            .padding(.top)
            .background(Color(red: 0.965, green: 0.965, blue: 0.965))
            .cornerRadius(6)
            .shadow(radius: 0.5)
            .padding()
            .colorScheme(.light)
            .onAppear {
                textValue = username
            }
        }
        .offset(y: isPresented ? 0 : 1200)
        .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))

    }
    
    /// SplitAndStore
    /// - Parameter name:
    private func splitAndStore(_ name: String) {
        let splittedNames = name.split(separator: " ")
        var storeableUser =  TODOSession.shared.toDoUser!

        if splittedNames.count > 1 {
            let fname = String(splittedNames[0])
            let lname = String(splittedNames[1])
            storeableUser.firstName = fname
            storeableUser.lastName = lname
        } else {
            storeableUser.firstName = name
            storeableUser.lastName = ""
        }
        TODOSession.shared.toDoUser  = storeableUser
    }
}
