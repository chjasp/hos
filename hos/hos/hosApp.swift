import SwiftUI

/*
 MVVM architecture
 
 Model - data point
 View - UI
 ViewModel - manages models for view
 
 */

@main
struct hosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
        }
    }
}
