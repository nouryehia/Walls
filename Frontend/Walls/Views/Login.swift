//
//  Login.swift
//  Walls
//
//  Created by Nour Yehia on 8/18/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import SwiftUI

struct Login: View {
    @State var incorrectCredentials = false
    @State var usernameOrEmail = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username or email", text: $usernameOrEmail)
                TextField("Password", text: $password)
                
                if (incorrectCredentials) {
                    Text("Incorrect credentials.")
                }
                
                NavigationLink(destination: Home()) {
                   Text("Log In")
                }.disabled(usernameOrEmail == "" || password == "")
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: Signup()) {
                        Text("Sign up")
                    }
                    Text(".")
                        .padding(.leading, -8.5)
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
