//
//  Home.swift
//  Walls
//
//  Created by Nour Yehia on 8/18/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import SwiftUI

struct Home: View {
    let id: Int
    
    var body: some View {
        VStack {
            Text("Home Page")
            Text("User ID: \(id)")
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(id: 1)
    }
}
