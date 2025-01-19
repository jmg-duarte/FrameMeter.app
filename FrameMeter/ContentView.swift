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

    @State private var chronometer: Chronometer = .init()

    let totalRectangles = 24
    let totalRectanglesCycles = 12

    var TopLabel: some View {
        HStack {
            Text("\(chronometer.totalCycles)")
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text("+")
            Text("\(chronometer.currentFrame)")
                .frame(maxWidth: .infinity, alignment: .leading)
        }.font(.system(size: 24, design: .monospaced))
    }
    
    var ToggleButton: some View {
        Button(action: {
            withAnimation(.none) {
                chronometer.toggle()
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
    }

    var ResetButton: some View {
        Button(action: {
            withAnimation(.none) {
                chronometer.reset()
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
    
    var body: some View {
        VStack {
            TopLabel
            
            HStack {
                VStack(spacing: 4) {
                    ForEach(0 ..< totalRectanglesCycles, id: \.self) { index in
                        Rectangle()
                            .fill((
                                index < chronometer.currentCycle) ? Color.blue : Color.gray)
                            .frame(height: 45)
                    }
                }
                .padding(.bottom)

                VStack(spacing: 4) {
                    ForEach(0 ..< totalRectangles, id: \.self) { index in
                        Rectangle()
                            .fill((
                                index < chronometer.currentFrame) ? Color.blue : Color.gray)
                            .frame(height: 20)
                    }
                }
                .padding(.bottom)
            }

            HStack {
                ToggleButton
                ResetButton
            }
        }
        .padding(.horizontal)
    }

}

#Preview {
    ContentView()
}
