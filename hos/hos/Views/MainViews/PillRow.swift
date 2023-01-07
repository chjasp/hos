import SwiftUI


/*
 (1) Model the basic design of a pill item
 (2) Handle animations; esp. on-tab animations
 */
struct PillRow: View {
    
    let item: PillModel
    let usedInCabinet: Bool
    let accentRed = Color("AccentRed")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    
    var body: some View {
        HStack {
            Image(systemName: usedInCabinet ? (item.hasBeenTaken ? "pill.fill" : "pill") : (item.isInCabinet ? "cabinet.fill" : "cabinet"))
                .foregroundColor(accentGreen)
            Text(item.title)
                .foregroundColor(.white)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(LinearGradient(gradient: Gradient(colors: [.black, accentGreyDark]), startPoint: .leading, endPoint: .trailing))
    }
}


struct PillRow_Previews: PreviewProvider {
    
    static var item1 = PillModel(title: "first item", isInCabinet: false, hasBeenTaken: false, tookOnDates: [])
    static var item2 = PillModel(title: "second iten", isInCabinet: true, hasBeenTaken: true, tookOnDates: [])
    static var item3 = PillModel(title: "third iten", isInCabinet: true, hasBeenTaken: false, tookOnDates: [])
    static var item4 = PillModel(title: "fourth iten", isInCabinet: true, hasBeenTaken: true, tookOnDates: [])
    
    static var previews: some View {
        Group {
            PillRow(item: item1, usedInCabinet: false)
            PillRow(item: item2, usedInCabinet: false)
            PillRow(item: item3, usedInCabinet: true)
            PillRow(item: item4, usedInCabinet: true)
        }
        .previewLayout(.sizeThatFits)
    }
}
