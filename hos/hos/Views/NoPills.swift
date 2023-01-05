import SwiftUI

struct NoPills: View {
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    let backgroundGrey = Color("BackgroundGrey")
    
    var body: some View {
        ScrollView {
            VStack {
                Text("There are no pills")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text("Add pills to your cabinet. You can also create new pills or delete ones you don't need.")
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                NavigationLink(destination: AddPills(),
                               label: {
                    Text("Add Something")
                        .foregroundColor(backgroundGrey)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondaryAccentColor : Color.accentColor)
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
        .background(backgroundGrey)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct NoPills_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoPills()
                .navigationTitle("Title")
        }
    }
}
