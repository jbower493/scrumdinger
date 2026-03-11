//
//  ContentView.swift
//  scrumdinger
//
//  Created by Jamie Bower on 9/3/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var sharedText: String = "Nothing shared yet"
    
    func readSharedData() {
        let defaults = UserDefaults(suiteName: "group.com.scrumdingerJbower")

        if let type = defaults?.string(forKey: "shared_type"),
           let value = defaults?.string(forKey: "shared_value") {
            sharedText = "\(type): \(value)"
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text(sharedText)
            .padding()
            .onAppear {
                readSharedData()
            }
        }
        .padding()
    }
}
