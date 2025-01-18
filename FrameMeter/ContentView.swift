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

    @State private var totalCycles = 0
    @State private var activeCycle = -1
    
    let totalRectangles = 24
    let totalRectanglesCycles = 12
    let interval = 1.0 / 24.0 // Time interval between rectangle updates

    var body: some View {
        VStack {
            HStack {
                Text("\(totalCycles)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("+")
                Text("\(activeIndex + 1)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.font(.system(size: 24, design: .monospaced))

            HStack {
                LazyVStack(spacing: 4) {
                    ForEach(0 ..< totalRectanglesCycles, id: \.self) { index in
                        Rectangle()
                            .fill((
                                index <= activeCycle) ? Color.blue : Color.gray)
                            .frame(height: 45)
                            // .animation(.linear(duration: interval), value: activeIndex)
                    }
                }
                .padding(.bottom)
                
                LazyVStack(spacing: 4) {
                    ForEach(0 ..< totalRectangles, id: \.self) { index in
                        Rectangle()
                            .fill((
                                index <= activeIndex) ? Color.blue : Color.gray)
                            .frame(height: 20)
                            // .animation(.linear(duration: interval), value: activeIndex)
                    }
                }
                .padding(.bottom)
            }
            

            HStack {
                Button(action: {
                    withAnimation(.none) {
                        toggleChronometer()
                    }
                }) {
                    Text(isRunning ? "Stop" : "Start")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .animation(nil, value: isRunning)
                }
                .animation(nil, value: isRunning)

                
                Button(action: {
                    withAnimation(.none) {
                        stopChronometer()
                        activeIndex = -1
                        totalCycles = 0
                    }
                }) {
                    Text("Reset")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal)
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
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if activeIndex == totalRectangles {
                totalCycles += 1
                activeIndex = -1
                
                activeCycle = (activeCycle + 1) % totalRectanglesCycles
                
            } else {
                activeIndex += 1
            }
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
