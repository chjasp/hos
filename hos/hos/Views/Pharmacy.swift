import SwiftUI
import UIKit

enum Sections: String, CaseIterable {
    case cabinet = "Cabinet Pills"
    case notCabinet = "Other Pills"
}

struct Pharmacy: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    let accentGrey = Color("AccentGrey")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    
    var cabinetPills: [ItemModel] {
        listViewModel.items.filter { $0.isInCabinet }
    }
    
    var otherPills: [ItemModel] {
        listViewModel.items.filter { !$0.isInCabinet }
    }
    
    var body: some View {
        
        ZStack {
            if listViewModel.items.isEmpty {
                NoPills()
            } else {
                List {
                    
                    ForEach(Sections.allCases, id: \.self) { section in
                        
                        Section {
                            
                            let filteredPills = section == .cabinet ? cabinetPills : otherPills
                            
                            
                            ForEach(filteredPills) { item in
                                PharmacyRow(item: item, usedInCabinet: false)
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
                            .onDelete(perform: listViewModel.deleteItem)
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
        .navigationBarItems(trailing: NavigationLink("Add", destination: AddPills()))
    }
}

struct Pharmacy_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Pharmacy()
        }
        .environmentObject(ListViewModel())
    }
}
