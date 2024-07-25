//
//  MenuPreview.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/3/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct DropdownPreview: View {
    
    var pickerOptions: [String] = ["Option 1", "Option 2", "Option 3", "Option 4"]
    @State var selectedOption = ""
    
    var body: some View {
        ScrollView {
//            SeugiDropdown("Option", pickerOptions: pickerOptions, selection: $selectedOption)
        }
    }
}
