//
//  NotSOLIDServiceScheduler.swift
//  SOLIDExample
//
//  Created by Harlan Kellaway on 1/12/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

class NotSOLIDServiceScheduler: NSObject {
    
    private var serviceTimer: NSTimer? = nil
    private var timerTick: Int = 0
    
    // MARK: - Public methods
    
    func start() {
        // starts timer
        self.serviceTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerDidFire:", userInfo: nil, repeats: true)
    }
    
    func stop() {
        self.serviceTimer?.invalidate()
        self.serviceTimer = nil
    }
    
    // MARK: - Private methods
    
    private func timerDidFire(timer: NSTimer) {
        self.timerTick++
        self.runServicesWithTick(self.timerTick)
    }
    
    private func runServicesWithTick(tick: Int) {
        // decides frequencies
        if ((tick % 1) == 0) {
            self.runTimelineUpdateService()
        } else if ((tick % 2) == 0) {
            self.runProfileUpdateService()
        }
    }
    
    // executes services
    private func runTimelineUpdateService() {
        NotSOLIDTimelineService.fetchTimelineForUserID("123")
    }
    
    private func runProfileUpdateService() {
        NotSOLIDProfileService.fetchProfileForUserID("123")
    }
    
}
