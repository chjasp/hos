import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    let accentRed = Color("AccentRed")
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "minus.circle" : "plus.circle")
                .foregroundColor(item.isCompleted ? accentRed : Color.accentColor)
            Text(item.title)
                .foregroundColor(.white)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(.black)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "first item", isCompleted: false)
    static var item2 = ItemModel(title: "second iten", isCompleted: true)
    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
