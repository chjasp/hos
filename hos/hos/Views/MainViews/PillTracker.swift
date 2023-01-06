import SwiftUI


/*
 (1) Extract all available data for all pills
 (2) Display days on which pills have been consumed as lines
 (3) Assign colors to pills and bars. Or take colors from item
 */
struct PillTracker: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    let accentGreyDark = Color("AccentGreyDark")
    
    var takenPills: [PillModel] {
        listViewModel.items.filter { $0.isInCabinet && $0.hasBeenTaken}
    }
    
    var body: some View {
        
        VStack {
            ForEach(takenPills) { pill in
                Rectangle()
                    .frame(width: 360, height: 5)
                    // TBD: Change color-assignment
                    .foregroundColor(Color(
                        red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1)
                    ))
                
            }
        }
        .frame(width: 360, height: 30)
        .padding(.top, 10)
        .padding(.bottom, 15)
        .background(LinearGradient(gradient: Gradient(colors: [.black, accentGreyDark]), startPoint: .leading, endPoint: .trailing))
    }
}

struct PillTracker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PillTracker()
        }
        .environmentObject(ListViewModel())
    }
}
