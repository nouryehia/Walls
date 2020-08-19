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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign Up Page")
                
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
