import SwiftUI


/*
 List sections in cabinet
*/
enum RoutineSections: String, CaseIterable {
    case taken = "Taken Pills"
    case open = "Open Pills"
}


/*
 (1) Display all pills present in cabinet
 (2) Handle pill intake
 (3) Handle animations related to intakes
 */
struct Cabinet: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    let accentGrey = Color("AccentGrey")
    let accentGreen = Color("AccentGreen")
    let accentColor = Color("AccentColor")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var openPills: [ItemModel] {
        listViewModel.items.filter { $0.isInCabinet && !$0.hasBeenTaken}
    }
    
    var takenPills: [ItemModel] {
        listViewModel.items.filter { $0.isInCabinet && $0.hasBeenTaken}
    }
    
   
    var body: some View {
        
        
        VStack {
            
            ZStack {
                if listViewModel.items.isEmpty {
                    FillCabinet()
                        .background(backgroundGrey)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    
                    ZStack {
                        List {
                            
                            ForEach(RoutineSections.allCases, id: \.self) { section in
                                
                                Section {
                                    
                                    let filteredPills = section == .open ? openPills : takenPills
                                    
                                    ForEach(filteredPills) { item in
                                        PillRow(item: item, usedInCabinet: true)
                                            .onTapGesture {
                                                withAnimation(.linear) {
                                                    listViewModel.updateTakingPill(item: item)
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
            }
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
