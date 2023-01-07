import Foundation

struct PillModel: Identifiable, Codable {
    
    let id: String
    let title: String
    let isInCabinet: Bool
    let hasBeenTaken: Bool
    let tookOnDates: [Date]
    
    init(id: String = UUID().uuidString, title: String, isInCabinet: Bool, hasBeenTaken: Bool, tookOnDates: [Date]) {
        self.id = id
        self.title = title
        self.isInCabinet = isInCabinet
        self.hasBeenTaken = hasBeenTaken
        self.tookOnDates = tookOnDates
    }
    
    func updateCabinet() -> PillModel {
        return PillModel(id: id, title: title, isInCabinet: !isInCabinet, hasBeenTaken: hasBeenTaken, tookOnDates: tookOnDates)
    }
    
    func updateTakingPill() -> PillModel {
        if hasBeenTaken {
            // Delete current date if exists
            return PillModel(id: id, title: title, isInCabinet: isInCabinet, hasBeenTaken: !hasBeenTaken, tookOnDates: tookOnDates)
        }
        // Add current date to list of dates
        return PillModel(id: id, title: title, isInCabinet: isInCabinet, hasBeenTaken: !hasBeenTaken, tookOnDates: tookOnDates)
    }
    
}
