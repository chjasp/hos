import SwiftUI
import UIKit

enum RoutineSections: String, CaseIterable {
    case taken = "Taken Pills"
    case open = "Open Pills"
}

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
            
            Text("Cabinet")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(accentColor)
                .padding(.bottom, 2)
            
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
                                        PharmacyRow(item: item, usedInCabinet: true)
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

struct FillCabinet: View {
    
    let accentGrey = Color("AccentGrey")
    let accentGreen = Color("AccentGreen")
    let accentColor = Color("AccentColor")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    @State var animate: Bool = false
    
    var body: some View {
        VStack {
            Text("Cabinet is empty")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text("Add pills to your cabinet. You can add pills to your cabinet by selecting them from the pharmacy.")
                .foregroundColor(.white)
                .padding(.bottom, 20)
            NavigationLink(destination: Pharmacy(),
                           label: {
                Text("Fill Cabinet")
                    .foregroundColor(backgroundGrey)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(animate ? secondaryAccentColor : accentColor)
                    .cornerRadius(10)
            })
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0.0,
                    y: animate ? 50 : 30)
            .scaleEffect(animate ? 1.1 : 1.0)
            .offset(y: animate ? -7 : 0)
        }
        .multilineTextAlignment(.center)
        .padding(40)
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}
