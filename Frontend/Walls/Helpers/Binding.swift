//
//  Binding.swift
//  Walls
//
//  Created by Nour Yehia on 8/21/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import SwiftUI

func binding(_ condition: Bool) -> Binding<Bool> {
    return Binding(get: { return condition }, set: { (_) in })
}
