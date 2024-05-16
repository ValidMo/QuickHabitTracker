#  Key Notes

share data between your app and its widget using App Groups and UserDefaults.

Scheduled Task
Background Tasks
Local Caching
---
If your app targets iOS 13 or later, consider using Background Tasks with the .completion handler. This allows your app to briefly wake up in the background when an internet connection becomes available.
Within the background task, attempt to send the cached data to the cloud storage service.

 Offline Queue
 ---
 Alternatively, you can implement an offline queue mechanism. When the user interacts with the app while offline, update the local cache and add the data to an "offline queue."
When an internet connection is established, the app automatically attempts to send the queued data to the cloud storage service in the background.

Local Reset with Cloud Sync
 ---
 The app locally resets the tracked data (habits, isDone) for the new day. However, the cached data for the previous day is still preserved locally and queued for cloud synchronization.

 silent notification



# Code

// Saving the "Day" model at the end of each day
func saveDay() {
    let currentDate = Date()
    let habits = loadHabitsFromUserDefaults()
    let day = Day(date: currentDate, habits: habits)
    persistDay(day)
    resetHabitsInUserDefaults()
}

// Resetting the "isDone" property of habits in UserDefaults
func resetHabitsInUserDefaults() {
    let userDefaults = UserDefaults.standard
    for key in userDefaults.dictionaryRepresentation().keys {
        if key.contains("habit_isDone") {
            userDefaults.set(false, forKey: key)
        }
    }
}

// Loading habits with their "isDone" state from UserDefaults
func loadHabitsForCurrentDay() -> [Habit] {
    let currentDate = Date()
    if let day = loadDayFromPersistentStorage(for: currentDate) {
        for habit in day.habits {
            let isDoneKey = "habit_\(habit.id)_isDone"
            habit.isDone = UserDefaults.standard.bool(forKey: isDoneKey)
        }
        return day.habits
    } else {
        // Create new habits with "isDone" set to false
        return createDefaultHabits()
    }
}

# Functions

  private func createHabit() {
        let newHabit = Habit(context: viewContext)
        newHabit.id = UUID()
        newHabit.name = "New Habit"
        newHabit.daysOfWeekToRepeat = [1, 3, 5] // Monday, Wednesday, Friday
        CoreDataHelper.shared.saveContext()
    }
    
    func getHabitsForDay(date: Date) -> [Habit] {
    let calendar = Calendar.current
    let dayOfWeek = calendar.component(.weekday, from: date)
    
    let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "daysOfWeekToRepeat CONTAINS %d", dayOfWeek)
    
    do {
        let context = CoreDataHelper.shared.persistentContainer.viewContext
        return try context.fetch(fetchRequest)
    } catch {
        print("Failed to fetch habits: \(error)")
        return []
    }
}


---

// Create a new day
func createDay(date: Date, habits: [Habit]) {
    let newDay = Day(context: viewContext)
    newDay.id = UUID()
    newDay.date = date
    newDay.habits = NSSet(array: habits)
    CoreDataHelper.shared.saveContext()
}

// Update an existing day
func updateDay(_ day: Day, with habits: [Habit]) {
    day.habits = NSSet(array: habits)
    CoreDataHelper.shared.saveContext()
}


---

first of all i should calculate which weekday from the date in TrackedHabitsByDate ✅
then according to the weekday i should fetch the habits where the isRepeated<WEEKDAY> is true ✅
then i should put the results to the notDoneHabits array(just the name of habits as array of string) challenge
then i should list the habits in notDoneHabits as buttons okay
when the buttons pressed the notDoneHabits goes to doneHabits and the appeariance changes okay
    

