import UIKit

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
