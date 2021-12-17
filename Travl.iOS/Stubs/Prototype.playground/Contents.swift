import UIKit
import CloudKit

let dateFormatter = DateFormatter()

dateFormatter.dateFormat = "YY-M-d HH:mm:ss Z"
let endDate = "2021-11-29 16:00:00 +0000"
let convert = dateFormatter.date(from: endDate)

dateFormatter.timeStyle = .none
dateFormatter.dateStyle = .medium
dateFormatter.string(from: convert!)


let dateFormatter2 = DateFormatter()

let otherDate = "Nov 29, 2021"
dateFormatter2.dateFormat = "MM d, y"
let convert2 = dateFormatter2.date(from: otherDate)
dateFormatter2.timeStyle = .none
dateFormatter2.dateStyle = .medium
dateFormatter2.string(from: convert2!)

// Event that want to support in analytics
enum AnalyticsEvent {
    case loginScreenViewed
    case loginAttempted
    case loginFailed(reason : String)
    case loginSucceeded
    case messageListViewed
    case messageSelected(index : Int)
    case messageDeleted(index : Int, read : Bool)
}
// Engine for the analytics
protocol AnalyticsEngine : AnyObject {
    func sendAnalyticsEvent(named name : String, metadata : [String:String])
}
// Engine implementations
final class CloudKitAnalyticsEngine : AnalyticsEngine {
    
    private let database : CKDatabase
    
    init(database : CKDatabase = CKContainer.default().publicCloudDatabase) {
        self.database = database
    }
    
    //MARK: - Analytics Engine (Send data to Analytics SDK/Database)
    func sendAnalyticsEvent(named name: String, metadata: [String : String]) {
        let record = CKRecord(recordType: "AnalyticsEvent.\(name)")
        
        for(key,value) in metadata {
            record[key] = value as String
        }
        
        database.save(record) { _, _ in}
    }
    
}

// Serialize AnalyticEvent value to prepare it for consumption by Analytic Engine
/// 1. Name of the event
extension AnalyticsEvent {
    var name : String {
        switch self {
        case .loginScreenViewed,.loginAttempted,
                .loginSucceeded,.messageListViewed :
            return String(describing: self)
        case .loginFailed:
            return "Login Failed"
        case .messageSelected:
            return "Message Selected"
        case .messageDeleted:
            return "Message Deleted"
        }
    }
}
/// 2. Metadata
extension AnalyticsEvent {
    var metadata : [String:String] {
        switch self {
        case .loginScreenViewed,.loginAttempted,
                .loginSucceeded,.messageListViewed :
            return [:]
        case .loginFailed(reason: let reason):
            return ["reason":String(describing: reason)]
        case .messageSelected(index: let index):
            return ["index": "\(index)"]
        case .messageDeleted(index: let index, read: let read):
            return ["index" : "\(index)", "read": "\(read)"]
        }
    }
}

// AnalyticManager, conform to AnalyticEngine and provide API to log give event
final class AnalyticManager {
    private let engine : AnalyticsEngine
    
    init(engine : AnalyticsEngine) {
        self.engine = engine
    }
    
    func log(_ event : AnalyticsEvent) {
        print(event)
        engine.sendAnalyticsEvent(named: event.name, metadata: event.metadata)
    }
}


// Usage, implement the analytics system in VC
class SampleVC : UIViewController {
    private let analytics : AnalyticManager

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(analytics : AnalyticManager) {
        self.analytics = analytics
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics.log(.loginScreenViewed)
    }
    
    private func deleteMessage(at index : Int) {
        analytics.log(.messageDeleted(index: index, read: true))
    }
}
