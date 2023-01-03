import SwiftUI
import UIKit

enum RoutineSections: String, CaseIterable {
    case open = "Open Activities"
    case finished = "Finished Activities"
}

struct RoutineView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    let accentGrey = Color("AccentGrey")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    
    var openActivities: [ItemModel] {
        listViewModel.items.filter { $0.isRoutine }
    }
    
    var finishedActivities: [ItemModel] {
        listViewModel.items.filter { !$0.isRoutine }
    }
    
    var body: some View {
        
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
            } else {
                List {
                    
                    ForEach(RoutineSections.allCases, id: \.self) { section in
                        
                        Section {
                            
                            let filteredActivities = section == .open ? openActivities : finishedActivities
                            
                            
                            ForEach(filteredActivities) { item in
                                ListRowView(item: item)
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            listViewModel.updateItem(item: item)
                                        }
                                    }
                                    .listRowInsets(EdgeInsets())
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 7)
                                    .shadow(color: .black,
                                            radius: 4,
                                            x: 0.0,
                                            y: 6)
                                
                            }
                            .background(.clear)
                            
                        } header: {
                            Text(section.rawValue)
                                .foregroundColor(Color.accentColor)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(backgroundGrey)
            }
        }
        .navigationBarItems(trailing: NavigationLink("Edit", destination: ListView()))
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineView()
        }
        .environmentObject(ListViewModel())
    }
}
