import SwiftUI
import UIKit

enum RoutineSections: String, CaseIterable {
    case open = "Open Pills"
    case taken = "Taken Pills"
}

struct Cabinet: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    let accentGrey = Color("AccentGrey")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    
    var openPills: [ItemModel] {
        listViewModel.items.filter { $0.isInCabinet }
    }
    
    var takenPills: [ItemModel] {
        listViewModel.items.filter { !$0.isInCabinet }
    }
    
    var body: some View {
        
        
        VStack {
            
            Text("Cabinet")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color.accentColor)
                .padding(.bottom, 2)
            
            ZStack {
                if listViewModel.items.isEmpty {
                    NoPills()
                } else {
                    List {
                        
                        ForEach(RoutineSections.allCases, id: \.self) { section in
                            
                            Section {
                                
                                let filteredPills = section == .open ? openPills : takenPills
                                
                                ForEach(filteredPills) { item in
                                    PharmacyRow(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                listViewModel.updateCabinet(item: item)
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
                }
            }
            //.navigationBarItems(trailing: NavigationLink("Edit", destination: ListView()))
        }
        .background(backgroundGrey)
    }
}

struct Cabinet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Cabinet()
        }
        .environmentObject(ListViewModel())
    }
}
