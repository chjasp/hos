import SwiftUI
import HealthKit


struct HealthHome: View {
    
    private var healthStore: HealthStore?
    // Possibly better: Have the steps viewmodel as a pusblished/observable object
    @State private var steps: [Step] = [Step]()
    
    init() {
        // HealthStore itself initializes the HKHealthStore
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date:  statistics.startDate)
            steps.append(step)
            
        }
    }
    
    var body: some View {
        
        VStack {
            LineGraphHealth(data: steps.map({ step in
                CGFloat(step.count)
            }))
            .frame(width: 300, height: 250)
            .shadow(color: .black,
                    radius: 8,
                    x: 0.0,
                    y: 8)
            .padding(.top, 10)
            .padding(.bottom, 12)
        }
        
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
        .background(.white)
    }
}

struct HealthHome_Previews: PreviewProvider {
    static var previews: some View {
        HealthHome()
    }
}
