import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [PillModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([PillModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func addItem(title: String) {
        let newItem = PillModel(title: title, isInCabinet: false, hasBeenTaken: false, tookOnDates: [])
        items.append(newItem)
    }
    
    func updateCabinet(item: PillModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCabinet()
        }
    }
    
    func updateTakingPill(item: PillModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateTakingPill()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
