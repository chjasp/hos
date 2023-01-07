import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

struct HeartRate: Identifiable {
    let id = UUID()
    let bpm: Int
    let date: Date
}
