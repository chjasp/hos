import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    let accentGrey = Color("AccentGrey")
    
    var body: some View {
        
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowSeparatorTint(accentGrey)
                            .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    //.onMove(perform: listViewModel.moveItem)
                }
                .padding(.top, 10)
                .background(.black)
                .listRowBackground(Color.clear)
                .listStyle(.grouped)
                .navigationTitle("Potential Activities 📝")
                .listRowBackground(Color.clear)
            }
        }
        .navigationBarItems(leading: EditButton(), trailing: NavigationLink("Add", destination: AddView()))
        .background(.black)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
