import SwiftUI

struct ChartView: View {
    
    let values: [Int]
    let labels: [String]
    let xAxisLabels: [String]
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [Color(red: 16/255, green: 33/255, blue: 80/255), Color(red: 12/255, green: 39/255, blue: 76/255)],
                startPoint: .top,
                endPoint: .bottom)
            .ignoresSafeArea()
            
            GeometryReader { geo in
                
                HStack(alignment: .bottom) {
                    
                    ForEach(0..<values.count) { idx in
                        let max = values.max() ?? 0
                        
                        VStack {
                            Text(labels[idx])
                                .foregroundColor(.white)
                            
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.white)
                                .frame(width: 20, height:  CGFloat(values[idx])/CGFloat(max) * geo.size.height * 0.6)
                            
                            Text(xAxisLabels[idx])
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.background(Color(red: 21/255, green: 21/255, blue: 21/255))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            }
        }
        }
    }

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let values = [34, 42, 88, 24, 11, 45]
        let labels = ["1", "2", "3", "4", "5", "6"]
        let xAxisValues = ["M1","M2","M3","M4","M5","M6"]
        
        ChartView(values: values, labels: labels, xAxisLabels: xAxisValues)
    }
}
