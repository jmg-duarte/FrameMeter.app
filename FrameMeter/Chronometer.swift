//
//  Chronometer.swift
//  FrameMeter
//
//  Created by José Duarte on 18/01/2025.
//

import SwiftUI

@Observable class Chronometer {
    
    private let cycleLength = 24 // Frames
    private let interval = 1.0 / 24.0
    
    let cycles = 12

    private var timer: Timer?
    
    private(set) var totalFrames = 0
    private(set) var totalCycles = 0
    
    private(set) var currentFrame = 0
    private(set) var currentCycle = 0
    
    private var isRunning = false
    
    func toggle() {
        if isRunning {
            stop()
        } else {
            start()
        }
    }
    
    func start() {
        isRunning = true
        timer = Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: true
        ) { [self] _ in
            totalFrames += 1
            
            if currentFrame < cycleLength {
                currentFrame += 1
                return
            }
            
            currentFrame = 0
            totalCycles += 1
            
            if currentCycle < cycles {
                currentCycle += 1
                return
            }
            
            currentCycle = 1
        }
    }
    
    func stop() {
        isRunning = false
        timer?.invalidate()
    }
    
    func reset() {
        stop()
        
        totalCycles = 0
        totalFrames = 0
        currentFrame = 0
        currentCycle = 0
    }
}
