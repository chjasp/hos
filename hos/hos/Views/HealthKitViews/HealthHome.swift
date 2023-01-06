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
        
        List(steps, id: \.id) { step in
            VStack {
                Text("\(step.count)")
                Text(step.date, style: .date)
                    .opacity(0.5)
            }
            
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
    }
}

struct HealthHome_Previews: PreviewProvider {
    static var previews: some View {
        HealthHome()
    }
}
