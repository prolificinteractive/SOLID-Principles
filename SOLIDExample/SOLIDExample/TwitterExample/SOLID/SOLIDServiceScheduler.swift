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
    private var services: [Service]
    
    init(timer: Timer) {
        self.timer = timer
        self.services = []
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
    
    private func shouldExecuteFrequency(frequency: Int, onTick tick: Int) -> Bool {
        return (tick % frequency) == 0
    }
    
}
