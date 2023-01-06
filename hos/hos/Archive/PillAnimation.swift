import SwiftUI

struct PillAnimation: View {
    var body: some View {
        Loading()
    }
}

struct PillAnimation_Previews: PreviewProvider {
    static var previews: some View {
        PillAnimation()
    }
}

struct Loading: View {
    
    @State var animate = false
    let accentGreen = Color("AccentGreen")
    
    var body: some View {
        
        ZStack {
            
            Circle().fill(LinearGradient(colors: [Color.accentColor, accentGreen],
                                         startPoint: .leading, endPoint: .trailing)).frame(width: 30, height: 30)
                .scaleEffect(self.animate ? 0 : 1)
            Circle().fill(LinearGradient(colors: [Color.accentColor, accentGreen],
                                         startPoint: .leading, endPoint: .trailing).opacity(0.8)).frame(width: 100, height: 100)
                .scaleEffect(self.animate ? 0 : 1)
            Circle().fill(LinearGradient(colors: [Color.accentColor, accentGreen],
                                         startPoint: .leading, endPoint: .trailing).opacity(0.6)).frame(width: 200, height: 200)
                .scaleEffect(self.animate ? 0 : 1)
            Circle().fill(LinearGradient(colors: [Color.accentColor, accentGreen],
                                         startPoint: .leading, endPoint: .trailing).opacity(0.4)).frame(width: 300, height: 300)
                .scaleEffect(self.animate ? 0 : 1)
            Circle().fill(LinearGradient(colors: [Color.accentColor, accentGreen],
                                         startPoint: .leading, endPoint: .trailing).opacity(0.2)).frame(width: 500, height: 500)
                .scaleEffect(self.animate ? 0 : 1)
            Circle().fill(LinearGradient(colors: [Color.accentColor, accentGreen],
                                         startPoint: .leading, endPoint: .trailing).opacity(0.1)).frame(width: 1000, height: 1000)
                .scaleEffect(self.animate ? 0 : 1)
        }
        .onAppear {
            self.animate.toggle()
        }
        .animation(Animation.linear(duration: 2.0))
    }
}
