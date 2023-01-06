import Foundation

/*
 Return most recent monday 12 AM date
 */
extension Date {
    static func monday12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}
