//
//  SwiftUIView.swift
//  
//
//  Created by Alvaro Sanz Rodrigo on 26/5/23.
//

import SwiftUI

struct HelloView: View {
    @Binding var hello: String
    var body: some View {
        Text("Hello, World!")
    }
}

struct HelloView_Previews: PreviewProvider {
    static var previews: some View {
        HelloView(hello: .constant("Hello"))
    }
}
