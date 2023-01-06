import SwiftUI


/*
 (1) Handle case when cabinet is empty
 (2) Most likely subjec to refactoring (see similarities to NoPills-View)
 */
struct FillCabinet: View {
    
    let accentGrey = Color("AccentGrey")
    let accentColor = Color("AccentColor")
    let backgroundGrey = Color("BackgroundGrey")
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    @State var animate: Bool = false
    
    var body: some View {
        VStack {
            Text("Cabinet is empty")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text("Add pills to your cabinet. You can add pills to your cabinet by selecting them from the pharmacy.")
                .foregroundColor(.white)
                .padding(.bottom, 20)
            NavigationLink(destination: Pharmacy(),
                           label: {
                Text("Fill Cabinet")
                    .foregroundColor(backgroundGrey)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(animate ? secondaryAccentColor : accentColor)
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
        .background(backgroundGrey)
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

struct FillCabinet_Previews: PreviewProvider {
    static var previews: some View {
        FillCabinet()
    }
}
