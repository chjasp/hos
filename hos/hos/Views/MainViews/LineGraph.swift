import SwiftUI


/*
 (1) Plot data
 (2) Handle time horizons
 */
struct LineGraph: View {
      
    var data: [CGFloat]
    
    @State var currentPlot = ""
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var translation: CGFloat = 0
    
    let accentGreen = Color("AccentGreen")
    let accentGreyDark = Color("AccentGreyDark")
    let backgroundGrey = Color("BackgroundGrey")
    
    var body: some View {
        
        GeometryReader { proxy in

            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count)
            let maxPoint = (data.max() ?? 0) + 150
            let points = data.enumerated().compactMap { item -> CGPoint in
                
                let progress = item.element / maxPoint
                let pathHeight = progress * height
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: height - pathHeight)
                
            }
            
            ZStack {
               
                Path { path in
                    
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLines(points)
                    
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                .fill(
                    LinearGradient(colors: [Color.accentColor, accentGreen],
                                   startPoint: .leading, endPoint: .trailing))
                
                .padding(.leading, 10)
            }
            .overlay(
                // Drag indicator
                VStack(spacing: 0) {
                    
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(accentGreen, in: Capsule())
                        .offset(x: translation < 10 ? 30 : 0)
                        .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                        .offset(y: offset.height < -180 ? 10 : 0)
                   
                    Rectangle()
                        .fill(accentGreen)
                        .frame(width: 1, height: 7)
                        .padding(.top)
                    
                    Circle()
                        .fill(accentGreen)
                        .frame(width: 22, height: 22)
                        .overlay(
                            Circle()
                                .fill(backgroundGrey)
                                .frame(width: 10, height: 10)
                            )
                    
                    Rectangle()
                        .fill(accentGreen)
                        .frame(width: 1, height: 7)
                    
                }
                    .frame(width: 80, height: 170)
                    .offset(y: 70)
                    .offset(offset)
                    .opacity(showPlot ? 1 : 0),
                
                alignment: .bottomLeading
            )
            .contentShape(Rectangle())
            .gesture(DragGesture().onChanged({ value in
            
                withAnimation { showPlot = true }
                
                let translation = value.location.x - 40
                let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)
                
                currentPlot = "\(data[index])"
                self.translation = translation
                
                let progress = points[index].y / maxPoint
                let pathHeight = progress * height
                
                offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                
            }).onEnded({ value in
                
                withAnimation { showPlot = false }
                
            }))
            
        }
        .padding(.horizontal, 10)
        .background(LinearGradient(gradient: Gradient(colors: [.black, accentGreyDark]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(30)
    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Home()
        }
        .environmentObject(ListViewModel())
    }
}
