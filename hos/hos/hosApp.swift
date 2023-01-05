import SwiftUI

/*
 MVVM architecture
 
 Model - data point
 View - UI
 ViewModel - manages models for view
 
 */

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
