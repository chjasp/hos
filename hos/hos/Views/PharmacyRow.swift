import SwiftUI

struct PharmacyRow: View {
    
    let item: ItemModel
    let accentRed = Color("AccentRed")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    
    var body: some View {
        HStack {
            Image(systemName: item.isInCabinet ? "minus.circle" : "plus.circle")
                .foregroundColor(item.isInCabinet ? accentRed : accentGreen)
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

struct PharmacyRow_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "first item", isInCabinet: false, hasBeenTaken: false)
    static var item2 = ItemModel(title: "second iten", isInCabinet: true, hasBeenTaken: true)
    
    static var previews: some View {
        Group {
            PharmacyRow(item: item1)
            PharmacyRow(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
