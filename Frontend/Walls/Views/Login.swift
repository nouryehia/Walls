//
//  Login.swift
//  Walls
//
//  Created by Nour Yehia on 8/18/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import SwiftUI

struct Login: View {
    @State var invalidCredentials = false

    @State var userOrEmail = ""
    @State var password = ""
    
    @State var login: [String: Any] = ["temp": 0]
    @State var id = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username or email", text: $userOrEmail)
                SecureField("Password", text: $password)
                
                if (invalidCredentials) {
                    Text("Invalid credentials.")
                }
                
                NavigationLink(destination: Home(id: self.id), isActive: binding(id != 0)) {
                    Text("Login")
                
                }.disabled(userOrEmail == "" || password == "")
                
                 .simultaneousGesture(TapGesture().onEnded {
                    if (!(self.userOrEmail == "" || self.password == "")) {
                        
                        self.login = api(endpoint: "user/login", method: "POST",
                                         body: ["user_or_email": self.userOrEmail.lowercased(),
                                                "password": self.password]) as! [String : Any]
                        
                        if self.login["login"] as! Bool {
                            self.id = self.login["id"] as! Int
                        } else {
                            self.invalidCredentials = true
                        }
                    }
                })
                
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
