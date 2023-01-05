import SwiftUI


struct AddPills: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    let secondaryAccentColor = Color("SecondaryAccentColor")
    let accentGrey = Color("AccentGrey")
    let backgroundGrey = Color("BackgroundGrey")
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                ZStack(alignment: .leading) {
                    if textFieldText.isEmpty {
                        Text("Type Here")
                            .foregroundColor(.white.opacity(0.7))
                        
                    }
                    TextField("", text: $textFieldText)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .frame(height: 55)
                .background(accentGrey.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 10)
                
                Button(action: {
                    saveButtonPressed()
                }, label: {
                    Text("Save".uppercased())
                        .foregroundColor(backgroundGrey)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add a pill")
        .background(backgroundGrey)
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new pill must be at least 3 characters long! 😱"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddPills_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddPills()
        }
        .environmentObject(ListViewModel())
    }
}
