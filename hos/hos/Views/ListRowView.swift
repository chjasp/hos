import SwiftUI

struct ListRowView: View {
    
    let title: String
    
    
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
            Text("This is the first item!")
            Spacer()
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "This is the first title")
    }
}
