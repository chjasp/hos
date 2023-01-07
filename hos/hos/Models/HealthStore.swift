import Foundation
import HealthKit


/*
 Wrap around features of the healthkit
 */
class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        // Check if health data is available or not
        if HKHealthStore.isHealthDataAvailable() {
            // ... then create an instance of HK healthstore
            healthStore = HKHealthStore()
        }
    }

    // Implement the request to health data
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        // Request step count data
        // TBD: Extend to other types of health data
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let hrType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        // Guard non-initialized healthstore
        guard let healthStore = self.healthStore else {
            return completion(false)
        }
        
        // Handle failed and successful requests
        // Remark from video: We should call requestAuthorization from content view
        // Make sure info.plist-equivalent information and entitlements are provided
        healthStore.requestAuthorization(toShare: [], read: [stepType, hrType]) {
            (success, error) in completion(success)
        }
    }
    
    // Function to retrieve and accumulate steps from time range
    // We should call this in the contentView when we are authorized
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
        // We are for now only intersted in stepcount
        // TBD: Extend to other types of health information
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        // Go back seven days from now ("A week ago")
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        // Anchor data/Anchor time: When does the date actually start?
        let anchorDate = Date.monday12AM()
        let daily = DateComponents(day: 1)
        //
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    // Function to retrieve the resting heart reate from time range
    // We should call this in the contentView when we are authorized
    func calculateRHR(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        // Go back seven days from now ("A week ago")
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        // Anchor data/Anchor time: When does the date actually start?
        let anchorDate = Date.monday12AM()
        let daily = DateComponents(day: 1)
        //
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .discreteMin, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    // Function to retrieve the resting heart reate from time range
    // We should call this in the contentView when we are authorized
    func calculateSleep(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
        let sleepType = HKCategoryType(.sleepAnalysis)
        
        // Go back seven days from now ("A week ago")
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let allAsleepPredicate: NSPredicate
        
        // Predicate for all asleep samples (unspecified, core, deep, REM)
        if #available(iOS 16.0, *) {
            allAsleepPredicate = HKCategoryValueSleepAnalysis.predicateForSamples(equalTo: HKCategoryValueSleepAnalysis.allAsleepValues)
        } else {
            allAsleepPredicate = HKQuery.predicateForCategorySamples(
                with: .equalTo,
                value: HKCategoryValueSleepAnalysis.asleep.rawValue)
        
        let dateRangePredicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [dateRangePredicate, allAsleepPredicate])
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate)
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
}
