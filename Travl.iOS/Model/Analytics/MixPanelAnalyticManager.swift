//
//  MixPanelAnalyticManager.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 17/12/2021.
//

import Foundation

final class AnalyticManager {
    private let engine : AnalyticEngine
    
    init(engine : AnalyticEngine) {
        self.engine = engine
    }
    
    func log(_ event : AnalyticEvents) {
        engine.sendAnalyticsEvent(named: event.name, metadata: event.metadata)
    }
}
