import SwiftUI

@main
struct hosApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Home()
            }
            .environmentObject(listViewModel)
        }
    }
}
