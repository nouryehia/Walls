//
//  Signup.swift
//  Walls
//
//  Created by Nour Yehia on 8/18/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import SwiftUI

struct Signup: View {
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @State var firstName = ""
    @State var lastName = ""
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var confPassword = ""
    @State var profilePhoto = "ProfilePhoto"
    
    @State var takenUsername = false
    @State var invalidUsername = false
    @State var shortUsername = false
    @State var takenEmail = false
    @State var invalidEmail = false
    @State var shortPassword = false
    @State var unmatchedPasswords = false
    
    @State var disableButton = true
    
    @State var id = 0
    
    let usernames: [String]
    let emails: [String]
    
    let MAX_LENGTH = 255
    
    init() {
        let credentials = api(endpoint: "user/get_all_credentials", method: "GET")
                          as! Dictionary<String, Any>
        
        usernames = credentials["usernames"] as! [String]
        emails = credentials["emails"] as! [String]
    }
    
    func updateButtonState() {
        disableButton = firstName.isEmpty || lastName.isEmpty || username.isEmpty ||
                        email.isEmpty || password.isEmpty || confPassword.isEmpty ||
                        takenUsername || invalidUsername || shortUsername || takenEmail ||
                        invalidEmail || shortPassword || unmatchedPasswords
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("First name", text: $firstName, onEditingChanged: { edit in
                    if (!edit) {
                        self.updateButtonState()
                    }
                    
                }).onReceive(firstName.publisher.collect()) {
                    self.firstName = String($0.prefix(self.MAX_LENGTH))
                }
                
                TextField("Last name", text: $lastName, onEditingChanged: { edit in
                    if (!edit) {
                        self.updateButtonState()
                    }
                    
                }).onReceive(lastName.publisher.collect()) {
                    self.lastName = String($0.prefix(self.MAX_LENGTH))
                }
                
                Group {
                    if takenUsername {
                        Text("This username is unavailable.")

                    } else if invalidUsername {
                        Text("Usernames can only include letters, digits, ., and  _.")

                    } else if shortUsername {
                        Text("Usernames must contain at least 3 characters.")
                    }
                    
                    TextField("Username", text: $username, onEditingChanged: { edit in
                        if edit {
                            return
                        }
                        
                        if self.username.isEmpty {
                            self.takenUsername = false
                            self.invalidUsername = false
                            self.shortUsername = false
                            self.updateButtonState()
                            return
                        }
                        
                        self.takenUsername = self.usernames.contains(self.username.lowercased())
                        self.invalidUsername = self.username.matches(pattern: "[^a-zA-Z0-9_.]")
                        self.shortUsername = self.username.count < 3
                        
                        self.updateButtonState()
                        
                    }).onReceive(username.publisher.collect()) {
                        self.username = String($0.prefix(self.MAX_LENGTH))
                    }
                }
                
                Group {
                    if takenEmail {
                        Text("This email is unavailable.")

                    } else if invalidEmail {
                        Text("Invalid email.")
                    }
                    
                    TextField("Email", text: $email, onEditingChanged: { edit in
                        if edit {
                            return
                        }
                        
                        if self.email.isEmpty {
                            self.takenEmail = false
                            self.invalidEmail = false
                            self.updateButtonState()
                            return
                        }
                        
                        self.takenEmail = self.emails.contains(self.email.lowercased())
                        self.invalidEmail = !self.email.matches(pattern: Email.regex)
                        
                        self.updateButtonState()
                        
                    }).onReceive(email.publisher.collect()) {
                        self.email = String($0.prefix(self.MAX_LENGTH))
                    }
                }
                
                Group {
                    if shortPassword {
                        Text("Passwords must contain at least 6 characters.")
                    }
                    
                    TextField("Password", text: $password, onEditingChanged: { edit in
                        if edit {
                            return
                        }
                        
                        if self.password.isEmpty {
                            self.shortPassword = false
                            self.unmatchedPasswords = !self.confPassword.isEmpty
                            self.updateButtonState()
                            return
                        }
                        
                        self.shortPassword = self.password.count < 6

                        if (!self.confPassword.isEmpty) {
                            self.unmatchedPasswords = self.password != self.confPassword
                        }
                        
                        self.updateButtonState()
                        
                    }).onReceive(password.publisher.collect()) {
                        self.password = String($0.prefix(self.MAX_LENGTH))
                    }
                }
                
                Group {
                    if unmatchedPasswords {
                        Text("Passwords do not match.")
                    }
                    
                    TextField("Confirm password", text: $confPassword, onEditingChanged: { edit in
                        if (edit) {
                            return
                        }
                        
                        if self.confPassword.isEmpty {
                            self.unmatchedPasswords = false
                            self.updateButtonState()
                            return
                        }
                        
                        self.unmatchedPasswords = self.password != self.confPassword
                        
                        self.updateButtonState()
                        
                    }).onReceive(confPassword.publisher.collect()) {
                        self.confPassword = String($0.prefix(self.MAX_LENGTH))
                    }
                }
                
                NavigationLink(destination: Home(id: self.id), isActive: binding(id != 0)) {
                    Text("Sign Up")
                
                }.disabled(disableButton)
                
                 .simultaneousGesture(TapGesture().onEnded {
                    if (!self.disableButton) {
                        self.id = (api(endpoint: "user/signup", method: "POST",
                                       body: ["first_name": self.firstName,
                                              "last_name": self.lastName,
                                              "username": self.username.lowercased(),
                                              "email": self.email.lowercased(),
                                              "password": self.password,
                                              "profile_photo": self.profilePhoto])
                                   as! [String: Any])["id"] as! Int
                    }
                })
                
                HStack {
                    Text("Already have an account?")
                    Button(action: {self.presentation.wrappedValue.dismiss()}) {
                        Text("Log in")
                    }
                    Text(".")
                        .padding(.leading, -8.5)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}
