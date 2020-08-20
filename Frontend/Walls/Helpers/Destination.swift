//
//  Destination.swift
//  Walls
//
//  Created by Nour Yehia on 8/20/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import SwiftUI

struct Destination<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
