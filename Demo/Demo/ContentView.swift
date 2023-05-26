//
//  ContentView.swift
//  Demo
//
//  Created by Alvaro Sanz Rodrigo on 26/5/23.
//

import SwiftUI
import SuperScrollView

struct ContentView: View {
    @State private var scrollOffset: CGPoint = .zero
    @State private var scrollSize: CGSize = .zero
    @State private var isScrolling: Bool = false
    
    var body: some View {
        VStack {
            Text("Offset: \(scrollOffset.y)")
            Text("Size Width: \(scrollSize.width)")
            Text("Size Height: \(scrollSize.height)")
            Text("Is scrolling: \(isScrolling.description)")
            HStack {
                SuperScrollView(offset: $scrollOffset, size: $scrollSize, isScrolling: $isScrolling) { proxy in
                    ForEach(0..<100) { index in
                        Text("This is row \(index)")
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
