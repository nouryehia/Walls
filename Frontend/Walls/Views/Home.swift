//
//  Home.swift
//  Walls
//
//  Created by Nour Yehia on 8/18/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import SwiftUI

struct Home: View {
    @Binding var id: Int
    
    var body: some View {
        VStack {
            Text("Home Page")
            Text("User ID: \(id)")
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: Id().id) var id: Int

        var body: some View {
            Home(id: $id)
        }
    }
}
