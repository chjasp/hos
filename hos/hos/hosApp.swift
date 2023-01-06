import SwiftUI

@main
struct hosApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            HealthHome()
            /*NavigationView {
                Home()
            }
            .environmentObject(listViewModel)*/
        }
    }
}
