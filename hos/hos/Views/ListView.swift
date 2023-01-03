import SwiftUI
import UIKit

enum Sections: String, CaseIterable {
    case routine = "Routine Activities"
    case notRoutine = "Other Activities"
}

struct ListView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    let accentGrey = Color("AccentGrey")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    
    var routineActivities: [ItemModel] {
        listViewModel.items.filter { $0.isRoutine }
    }
    
    var otherActivities: [ItemModel] {
        listViewModel.items.filter { !$0.isRoutine }
    }
    
    var body: some View {
        
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
            } else {
                List {
                    
                    ForEach(Sections.allCases, id: \.self) { section in
                        
                        Section {
                            
                            let filteredActivities = section == .routine ? routineActivities : otherActivities
                            
                            
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
        .navigationBarItems(trailing: NavigationLink("Add", destination: AddView()))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
