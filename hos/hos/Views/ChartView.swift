import SwiftUI

struct Home: View {
    
    let accentGrey = Color("AccentGrey")
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .font(.title2)
                }
                
                Spacer()
                
                /* Button {
                    
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                } */
            }
            .padding()
            .foregroundColor(Color.accentColor)
            
            VStack(spacing: 10) {
                
                Text("Health Score")
                    .fontWeight(.bold)
                
                Text("1546")
                    .font(.system(size: 38, weight: .bold))
            }
            .foregroundColor(Color.accentColor)
            .padding(.top, 20)
            
            Button {
                
            } label: {
                
                HStack(spacing: 5) {
                    Text("Day")
                    
                    Image(systemName: "chevron.down")
                }
                .font(.caption.bold())
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(LinearGradient(gradient: Gradient(colors: [.black, accentGreyDark]), startPoint: .leading, endPoint: .trailing), in: Capsule())
                .shadow(color: .black,
                        radius: 3,
                        x: 0,
                        y: 3)
            }
            LineGraph(data: samplePlot)
                .frame(height: 250)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(backgroundGrey)
    }
}

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

let samplePlot: [CGFloat] = [
    989, 1000, 560, 673, 456, 853, 643, 746, 735, 245, 245, 846, 666, 333, 888, 333, 555, 777, 785, 657, 889
]
