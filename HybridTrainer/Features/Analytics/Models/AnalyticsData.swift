import Foundation

struct WeeklyStats {
    let run: ActivityStat
    let bike: ActivityStat
    let swim: ActivityStat
}

struct ActivityStat {
    let value: String
    let unit: String
    let label: String
}

// Sample Data
let sampleWeeklyStats = WeeklyStats(
    run: ActivityStat(value: "26.2", unit: "mi", label: "Run"),
    bike: ActivityStat(value: "120", unit: "mi", label: "Bike"),
    swim: ActivityStat(value: "4.5", unit: "mi", label: "Swim")
)

let previousWeekStats = WeeklyStats(
    run: ActivityStat(value: "23.1", unit: "mi", label: "Run"),
    bike: ActivityStat(value: "95", unit: "mi", label: "Bike"),
    swim: ActivityStat(value: "3.8", unit: "mi", label: "Swim")
) 