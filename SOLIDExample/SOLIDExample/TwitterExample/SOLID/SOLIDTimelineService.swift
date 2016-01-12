//
//  SOLIDTimelineService.swift
//  SOLIDExample
//
//  Created by Harlan Kellaway on 1/12/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

struct SOLIDTimelineService: Service {
    
    private let freq: Int
    let userID: String
    
    init(frequency: Int, userID: String) {
        self.freq = frequency
        self.userID = userID
    }
    
    // MARK: - Public methods
    
    func frequency() -> Int {
        return self.freq
    }
    
    func execute() {
        self.fetchTimelineForUserID(self.userID)
    }
    
    // MARK: - Private methods
    
    private func fetchTimelineForUserID(userID: String) {
        print("fetched timeline")
    }
    
}