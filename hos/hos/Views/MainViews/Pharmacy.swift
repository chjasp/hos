import SwiftUI
import UIKit


/*
 List sections in pharmacy
*/
enum Sections: String, CaseIterable {
    case cabinet = "Cabinet Pills"
    case notCabinet = "Other Pills"
}


/*
 (1) Contains all pills
 (2) Manages assignment of pills to cabinet
 (3) Manages creation or deletion of pills
 */
struct Pharmacy: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    let accentColor = Color("AccentColor")
    let backgroundGrey = Color("BackgroundGrey")
    
    var cabinetPills: [PillModel] {
        listViewModel.items.filter { $0.isInCabinet }
    }
    
    var otherPills: [PillModel] {
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

                                    PillRow(item: item, usedInCabinet: false)
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
                            
                        } header: {
                            Text(section.rawValue)
                                .foregroundColor(accentColor)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(backgroundGrey)
            }
        }
        .navigationBarItems(trailing: NavigationLink("Add", destination: AddPills()))
        .navigationTitle("Pharmacy")
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
