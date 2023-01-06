import SwiftUI


/*
 (1) Display chart and cabinet
 (2) Serve as central navigation node
 */
struct Home: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: ChartSettings(),
                               label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.title2)
                        .foregroundColor(accentColor)
                })
                Spacer()
                    NavigationLink(destination: Pharmacy(),
                                   label: {
                        Image(systemName: "pills")
                            .font(.title2)
                            .foregroundColor(accentColor)
                    })
            }
            .padding()
            Button {} label: {
    
                HStack(spacing: 5) {
                    Text("Week")
                    Image(systemName: "chevron.down")
                }
                .padding(.vertical, 5)
                .font(.caption.bold())

                .padding(.horizontal)
                .background(LinearGradient(gradient: Gradient(colors: [.black, accentGreyDark]), startPoint: .leading, endPoint: .trailing), in: Capsule())
                .shadow(color: .black,
                        radius: 3,
                        x: 0,
                        y: 3)
            }
            
            LineGraph(data: samplePlot)
                .frame(width: 360, height: 250)
                .shadow(color: .black,
                        radius: 8,
                        x: 0.0,
                        y: 8)
                .padding(.top, 10)
                .padding(.bottom, 12)
            
            PillTracker()
                .cornerRadius(10)
                .shadow(color: .black,
                        radius: 8,
                        x: 0.0,
                        y: 4)
                .padding(.bottom, 15)
            
            Cabinet()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(backgroundGrey)
    }
}

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Home()
        }
        .environmentObject(ListViewModel())
    }
}

let samplePlot: [CGFloat] = [
    200, 300, 560, 673, 456, 500, 643, 746, 735, 800, 810, 846, 666, 840, 888, 890, 900, 840, 820, 888, 889
]
