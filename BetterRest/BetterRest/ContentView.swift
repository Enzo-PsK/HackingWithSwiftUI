//
//  ContentView.swift
//  BetterRest
//
//  Created by Enzo Borges on 09/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    //var components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
    //let hour = components.hour ?? 0
    //let minute = components.minute ?? 0
    //let date = Calendar.current.date(from: components) ?? Date.now
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Section{
                Stepper("\(sleepAmount.formatted()) Hours", value: $sleepAmount, in: 4...12, step: 0.5)
                DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
                    .labelsHidden()
            }
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
