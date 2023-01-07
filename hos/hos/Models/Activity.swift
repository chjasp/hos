import Foundation


/*
 Should extract health data for specific time frame.
 For now: Week
 
 Daily activities to be covered (Basic):
 1. Steps (steps per day)
 2. Sleep (hours per day)
 3. Minimum resting heart rate (MRHR per day)
 */
class Activity {
    
}


/*
func saveSleepAnalysis() {
    
    // alarmTime and endTime are NSDate objects
    if let sleepType = HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis) {
        
        // we create our new object we want to push in Health app
        let object = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.InBed.rawValue, startDate: self.alarmTime, endDate: self.endTime)
        
        // at the end, we save it
        healthStore.saveObject(object, withCompletion: { (success, error) -> Void in
            
            if error != nil {
                // something happened
                return
            }
            
            if success {
                print("My new data was saved in HealthKit")
                
            } else {
                // something happened again
            }
            
        })
        
        
        let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.Asleep.rawValue, startDate: self.alarmTime, endDate: self.endTime)
        
        healthStore.saveObject(object2, withCompletion: { (success, error) -> Void in
            if error != nil {
                // something happened
                return
            }
            
            if success {
                print("My new data (2) was saved in HealthKit")
            } else {
                // something happened again
            }
            
        })
        
    }
    
}
*/
