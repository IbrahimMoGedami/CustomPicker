//
//  Colors.swift
//  CustomPicker
//
//  Created by Ibrahim Gedami on 26/05/2024.
//

import SwiftUI

enum Colors: String, CaseIterable, Identifiable {
    
    case red
    case blue
    case orange
    case purple
    case green
    case gray
    case yellow
    case cyan
    case pink
    case mint
    
    var id: Colors { self }
    
    var color: Color {
        switch self {
        case .red:
            Color.red
        case .blue:
            Color.blue
        case .orange:
            Color.orange
        case .purple:
            Color.purple
        case .green:
            Color.green
        case .gray:
            Color.gray
        case .yellow:
                .yellow
        case .cyan:
                .cyan
        case .pink:
                .pink
        case .mint:
                .mint
        }
    }
    
}
