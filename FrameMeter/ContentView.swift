//
//  ContentView.swift
//  FrameMeter
//
//  Created by José Duarte on 17/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var activeIndex = -1 // Tracks which rectangle to light up
    @State private var timer: Timer? // Timer to control the sequence
    @State private var isRunning = false // Button state

    let totalRectangles = 24
    let interval = 1.0 / 24.0 // Time interval between rectangle updates

    var body: some View {
        VStack {
            LazyVStack(spacing: 4) {
                ForEach(0 ..< totalRectangles, id: \.self) { index in
                    Rectangle()
                        .fill((
                            index <= activeIndex) ? Color.blue : Color.gray)
                        .frame(height: 20)
                        // .animation(.linear(duration: interval), value: activeIndex)
                }
            }
            .padding()

            // Start Button
            Button(action: {
                withAnimation(.none) {
                    toggleChronometer()
                }
            }) {
                Text(isRunning ? "Stop" : "Start")
                    .padding()
                    .background(isRunning ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .animation(nil, value: isRunning)
            }
            .animation(nil, value: isRunning)
        }
    }
    
    func toggleChronometer() {
        if isRunning {
            stopChronometer()
        } else {
            startChronometer()
        }
    }

    func startChronometer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { t in
            activeIndex = activeIndex == totalRectangles ? -1 : activeIndex + 1
        }
    }

    func stopChronometer() {
        timer?.invalidate()
        isRunning = false
    }
}

#Preview {
    ContentView()
}
