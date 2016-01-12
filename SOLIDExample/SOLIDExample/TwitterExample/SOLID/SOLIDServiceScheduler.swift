//
//  SOLIDServiceScheduler.swift
//  SOLIDExample
//
//  Created by Harlan Kellaway on 1/12/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

struct SOLIDServiceScheduler {
    
    // MARK: - Public methods
    
    let timer: Timer
    var services: [Service]
    
    init(timer: Timer) {
        self.init(timer: timer, services: [])
    }
    
    init(timer: Timer, services: [Service]) {
        self.timer = timer
        self.services = services
    }
    
    mutating func registerService(service: Service) {
        self.services.append(service)
    }
    
    func start() {
        self.timer.onTick() {
            tick in
            
            self.timerDidTick(tick)
        }
        
        self.timer.start()
    }
    
    func stop() {
        self.timer.stop()
    }
    
    // MARK: - Private methods
    
    private func timerDidTick(tick: Int) {
        self.runServicesWithTick(tick)
    }
    
    private func runServicesWithTick(tick: Int) {
        for service in self.services {
            if (self.shouldExecuteFrequency(service.frequency(), onTick:tick)) {
                service.execute()
            }
        }
    }
    
    private func shouldExecuteFrequency(frequency: Int, onTick: Int) -> Bool {
        return true
    }
    
}

protocol Timer {
    
    func onTick(action: Int -> ())
    func start()
    func stop()
    
}

class SOLIDTimer: Timer {
    
    private var internalTimer: NSTimer?
    private var tick: Int
    private var tickAction: (Int -> ())?
    
    init() {
        self.internalTimer = nil
        self.tick = 0
        self.tickAction = nil
    }
    
    func onTick(action: Int -> ()) {
        self.tickAction = action
    }
    
    func start() {
        self.internalTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerDidFire:", userInfo: nil, repeats: true)
    }
    
    func stop() {
        self.internalTimer?.invalidate()
        self.internalTimer = nil
    }
    
    func currentTick() -> Int {
        return self.tick
    }
    
    // MARK: - Private methods
    
    private func timerDidFire(timer: NSTimer) {
        self.tick++
        
        self.tickAction?(self.tick)
    }
    
}

protocol Service {
    
    func execution() -> () -> ()
    func frequency() -> Int
    func execute()
    
}

extension Service {
    
    func execute() {
        self.execution()()
    }
    
}

struct SOLIDService: Service {
    
    enum Frequency: Int {
        case High = 1
        case Low = 2
    }
    
    let freq: Frequency
    let exec: () -> ()
    
    init(frequency: Frequency, execution: () -> ()) {
        self.freq = frequency
        self.exec = execution
    }
    
    func execution() -> () -> () {
        return self.exec
    }
    
    func frequency() -> Int {
        return self.freq.rawValue
    }
    
}

struct SOLIDTimelineService {
    
    static func fetchTimelineForUserID(userID: String) {
        print("fetched timeline")
    }
    
}

struct SOLIDProfileService {
    
    static func fetchProfileForUserID(userID: String) {
        print("fetched profile")
    }
    
}

struct ServiceFactory {
    
    static func twitterTimelineServiceWithUserID(userID: String) -> Service {
        return SOLIDService(frequency: .High) {
            SOLIDTimelineService.fetchTimelineForUserID(userID)
        }
    }
    
    static func twitterProfileServiceWithUserID(userID: String) -> Service {
        return SOLIDService(frequency: .Low) {
            SOLIDTimelineService.fetchTimelineForUserID(userID)
        }
    }
    
}

struct SchedulerFactory {
    
    static func twitterServiceSchedulerWithUserID(userID: String) -> SOLIDServiceScheduler {
        let timer = self.clockTimer()
        var twitterScheduler = SOLIDServiceScheduler.init(timer: timer)
        
        twitterScheduler.registerService(ServiceFactory.twitterTimelineServiceWithUserID(userID))
        twitterScheduler.registerService(ServiceFactory.twitterProfileServiceWithUserID(userID))
        
        return twitterScheduler
    }
    
    static func clockTimer() -> Timer {
        return SOLIDTimer()
    }
    
}
