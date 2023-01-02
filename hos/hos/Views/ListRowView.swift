import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    let accentRed = Color("AccentRed")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    
    var body: some View {
        HStack {
            Image(systemName: item.isRoutine ? "minus.circle" : "plus.circle")
                .foregroundColor(item.isRoutine ? accentRed : accentGreen)
            Text(item.title)
                .foregroundColor(.white)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(LinearGradient(gradient: Gradient(colors: [.black, accentGreyDark]), startPoint: .leading, endPoint: .trailing))
        //#29292C
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "first item", isRoutine: false)
    static var item2 = ItemModel(title: "second iten", isRoutine: true)
    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
