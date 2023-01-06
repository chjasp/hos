import Foundation

struct PillModel: Identifiable, Codable {
    
    let id: String
    let title: String
    let isInCabinet: Bool
    let hasBeenTaken: Bool
    
    init(id: String = UUID().uuidString, title: String, isInCabinet: Bool, hasBeenTaken: Bool) {
        self.id = id
        self.title = title
        self.isInCabinet = isInCabinet
        self.hasBeenTaken = hasBeenTaken
    }
    
    func updateCabinet() -> PillModel {
        return PillModel(id: id, title: title, isInCabinet: !isInCabinet, hasBeenTaken: hasBeenTaken)
    }
    
    func updateTakingPill() -> PillModel {
        return PillModel(id: id, title: title, isInCabinet: isInCabinet, hasBeenTaken: !hasBeenTaken)
    }
    
}
