//
//  CustomPickerView.swift
//  CustomPicker
//
//  Created by Ibrahim Gedami on 26/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isSheetPresented = false
    @State var selectedIndex: Int? = 3
    let items = Colors.allCases
    
    var body: some View {
        ZStack {
            VStack {
                Text("Selected Item: \(items[selectedIndex ?? 0].rawValue.capitalized)")
                    .padding()
                
                Button(action: {
                    withAnimation {
                        isSheetPresented.toggle()
                    }
                }) {
                    Text("Show Custom Sheet")
                }
            }
            
            if isSheetPresented {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        CustomSheetView(selectedIndex: $selectedIndex, doneAction: { index in
                            self.selectedIndex = index
                            withAnimation {
                                isSheetPresented = false
                            }
                        }, closeAction: {
                            withAnimation {
                                isSheetPresented = false
                            }
                        })
                        .frame(height: geometry.size.height / 2.4)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .transition(.move(edge: .bottom))
                    }
                }
                .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
                .onTapGesture {
                    withAnimation {
                        isSheetPresented = false
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct CustomSheetView: View {
    
    @Binding var selectedIndex: Int?
    var doneAction: ((Int?) -> Void)?
    var closeAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    closeAction?()
                }) {
                    Text("Close")
                }
                .padding()
                .frame(width: 80, height: 50)
                .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    doneAction?(selectedIndex)
                }) {
                    Text("Done")
                }
                .padding()
                .frame(width: 80, height: 50)
                .foregroundColor(.white)
            }
            .background(Color(UIColor.brown))
            .padding(.bottom, 5)
            Spacer()
            
            PickerView(selectedIndex: $selectedIndex)
        }
    }
}



#Preview {
    ContentView()
}

