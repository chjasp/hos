import Foundation

struct ItemModel: Identifiable, Codable {
    
    let id: String
    let title: String
    let isRoutine: Bool
    
    init(id: String = UUID().uuidString, title: String, isRoutine: Bool) {
        self.id = id
        self.title = title
        self.isRoutine = isRoutine
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isRoutine: !isRoutine)
    }
    
}
