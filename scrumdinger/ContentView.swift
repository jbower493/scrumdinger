//
//  ContentView.swift
//  scrumdinger
//
//  Created by Jamie Bower on 9/3/2026.
//

import SwiftUI

struct ContentView: View {
    init() {
        print("mate") // works here
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
