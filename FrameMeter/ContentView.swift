//
//  ContentView.swift
//  FrameMeter
//
//  Created by José Duarte on 17/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var chronometer: Chronometer = .init()
    
    private let barSpacing = 4.0

    let totalRectangles = 24
    let totalRectanglesCycles = 12

    var TopLabel: some View {
        HStack {
            HStack {
                Text("\(chronometer.totalCycles)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("+")
                    .frame(alignment: .center)
                Text("\(chronometer.currentFrame)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            

        }
        .font(.system(size: 24, design: .monospaced))
    }

    var ToggleButton: some View {
        Button(action: {
            withAnimation(.none) {
                chronometer.toggle()
            }
        }) {
            Text(chronometer.isRunning ? "Stop" : "Start")
                .padding()
                .frame(maxWidth: .infinity)
                .background(chronometer.isRunning ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .animation(nil, value: chronometer.isRunning)
        }
        .animation(nil, value: chronometer.isRunning)
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
    
    func calculateHeight(height: Double, spacing: Double, numberElements: Int) -> Double {
        return (height - (spacing * Double(numberElements - 1))) / Double(numberElements)
    }

    var body: some View {
        VStack {
            TopLabel

            GeometryReader { geometry in
                HStack(spacing: barSpacing ) {
                    VStack(spacing: barSpacing) {
                        ForEach(0 ..< totalRectanglesCycles, id: \.self) { index in
                            Rectangle()
                                .fill((
                                    index < chronometer.currentCycle) ? Color.blue : Color.gray)
                                .frame(height: calculateHeight(height: geometry.size.height, spacing: barSpacing, numberElements: totalRectanglesCycles))
                        }
                    }

                    VStack(spacing: barSpacing) {
                        ForEach(0 ..< totalRectangles, id: \.self) { index in
                            Rectangle()
                                .fill((
                                    index < chronometer.currentFrame) ? Color.blue : Color.gray)
                                .frame(height: calculateHeight(height: geometry.size.height, spacing: barSpacing, numberElements: totalRectangles))
                        }
                    }
                }
                
            }
            .frame(maxHeight: .infinity)
            .clipShape(.rect(cornerRadius: 8))
            
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
