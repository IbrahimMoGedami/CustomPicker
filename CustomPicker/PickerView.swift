//
//  PickerView.swift
//  CustomPicker
//
//  Created by Ibrahim Gedami on 26/05/2024.
//

import SwiftUI
import AudioToolbox

struct PickerView: View {
    @Binding var selectedIndex: Int?
    var items = Colors.allCases
    var soundId: SystemSoundID = 1127  // focus_change_small.caf
    var itemHeight: CGFloat = 58.0
    var menuHeightMultiplier: CGFloat = 5

    var body: some View {
        let itemsCountAbove = Double(Int((menuHeightMultiplier - 1) / 2))
        let degreesMultiplier: Double = -40.0 / itemsCountAbove
        let scaleMultiplier: CGFloat = 0.1 / itemsCountAbove

        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(0..<items.count, id: \.self) { index in
                    let category = items[index]
                    let indexDiff = Double(index - (selectedIndex ?? 0))
                    HStack {
                        Image(systemName: "circle.fill")
                        Text(category.rawValue.capitalized)
                            .foregroundColor(category.color)
                            .padding()
                            .frame(width: 100)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.2)))
                            .id(index)
                    }
                    .frame(height: itemHeight)
                    .rotation3DEffect(
                        Angle(degrees: indexDiff * degreesMultiplier),
                        axis: (x: 1.0, y: 0.0, z: 0.0),
                        perspective: 0.6
                    )
                    .scaleEffect(x: 1 - CGFloat(abs(indexDiff) * scaleMultiplier))
                }
            }
            .scrollTargetLayout()
            .padding(.vertical, itemHeight * itemsCountAbove)
        }
        .scrollPosition(id: $selectedIndex, anchor: .center)
        .frame(height: itemHeight * (itemsCountAbove * 2 + 1))
        .padding(.vertical, (Int(menuHeightMultiplier) % 2 == 0) ? itemHeight * 0.5 : 0)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.7), lineWidth: 1))
                .frame(height: itemHeight)
                .allowsHitTesting(false)
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .onChange(of: selectedIndex, perform: { _ in
            AudioServicesPlaySystemSound(soundId)
        })
    }
}

struct WheelPickerDemo: View {
    
    @State var selectedIndex: Int? = 3
    let items = Colors.allCases
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Favorite Color? \(items[selectedIndex ?? 0])")
                .foregroundStyle(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16))
            PickerView(selectedIndex: $selectedIndex)
            
        }
    }
    
}

#Preview {
    
    WheelPickerDemo()
    
}
