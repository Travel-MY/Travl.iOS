//
//  MixPanelAnalyticEngine.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 17/12/2021.
//

import Foundation
import Mixpanel

// Engine Implementation
final class MixPanelAnalyticEngine : AnalyticEngine {
    
    private let mixpanel = Mixpanel.mainInstance()
    
    func sendAnalyticsEvent(named name: String, metadata: [String : String]) {
     
        for(key,value) in metadata {
            print("""
                  AnalyticsEvent LOG ->
                  Name : \(name),
                  Metadata : \([key:value])
                  """)
            mixpanel.track(event: "AnalyticEvent : \(name)", properties: [key:value])
        }
    }
}
