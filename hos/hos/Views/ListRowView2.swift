/*

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isRoutine: Bool = false
}

/*
enum Sections: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}
*/
 
struct ListRowView2: View {
    
    // what is a state?
    @State private var tasks = [Task(name: "Mow the lawn", isRoutine: true), Task(name: "Wash the car"), Task(name: "Feed the rabbit")]
    
    // what is a binding?
    var pendingTask: [Binding<Task>] {
        $tasks.filter { !$0.isRoutine.wrappedValue }
    }
    
    // dollar-operator?
    var completedTasks: [Binding<Task>] {
        $tasks.filter { $0.isRoutine.wrappedValue }
    }
    
    var body: some View {
        List {
            ForEach(Sections.allCases, id: \.self) { section in
                Section {
                    
                    let filterTasks = section == .pending ? pendingTask : completedTasks
                    
                    if filterTasks.isEmpty {
                        Text("No activity available.")
                    }
                    
                    ForEach(section == .pending ? pendingTask : completedTasks) { $task in
                        Text(task.name)
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let taskToDelete = filterTasks[index]
                            tasks = tasks.filter { $0.id != taskToDelete.id }
                        }
                    }
                    
                    
                } header: {
                    Text(section.rawValue)
                }
                
            }
        }
    }
}

struct TaskViewCell: View {
    
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isRoutine ? "checkmark.squary" : "square")
                .onTapGesture {
                    task.isRoutine.toggle()
                }
            Text(task.name)
        }
    }
}

struct ListRowView2_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView2()
    }
}


// ---

import SwiftUI

enum Sections: String, CaseIterable {
    case routine = "Routine Activities"
    case notRoutine = "Other Activities"
}

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    let accentGrey = Color("AccentGrey")
    let backgroundGrey = Color("BackgroundGrey")
    
    var routineActivities: [ItemModel] {
        listViewModel.items.filter { $0.isRoutine }
    }
    
    var otherActivities: [ItemModel] {
        listViewModel.items.filter { !$0.isRoutine }
    }

    var body: some View {
        
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
            } else {
                List {
                    
                    ForEach(Sections.allCases, id: \.self) { section in
                        
                        Section {
                            
                            let filteredActivities = section == .routine ? routineActivities : otherActivities
                            
                            if filteredActivities.isEmpty {
                                Text("No activities available.")
                            }
                            
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
                            
                        } header: {
                            Text(section.rawValue)
                        }
                        
                    }
                    
// -----
                    
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
                    //.onDelete(perform: listViewModel.deleteItem)
                    //.onMove(perform: listViewModel.moveItem)
                }
                .padding(.top, 10)
                .background(backgroundGrey)
                .listStyle(.grouped)
                .navigationTitle("Potential Activities 📝")
                .listRowBackground(Color.clear)
                .background(backgroundGrey)
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


*/
