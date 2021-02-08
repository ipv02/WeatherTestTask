
import UIKit

enum typeUnixConvertor {
    case time
    case timeWithTimezone
    case date
    case weekDay
}

func unixConvertor(unixTime: Double, timezone: Int = 0, type: typeUnixConvertor) -> String {
    let time = NSDate(timeIntervalSince1970: unixTime)
    let dateFormatter = DateFormatter()
    
    switch type {
    case .date:
        dateFormatter.dateFormat = "EEEE, MMM d"
        let dateAsString = dateFormatter.string(from: time as Date)
        dateFormatter.dateFormat = "EEEE, MMM d"
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "EEEE, MMM d"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
    case .time:
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale?
        dateFormatter.dateFormat = "hh:mm a"
        let dateAsString = dateFormatter.string(from: time as Date)
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
    case .timeWithTimezone:
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale?
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.dateFormat = "hh:mm a"
        let dateAsString = dateFormatter.string(from: time as Date)
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
    case .weekDay:
        dateFormatter.dateFormat = "EEEE"
        let dateAsString = dateFormatter.string(from: time as Date)
        dateFormatter.dateFormat = "EEEE"
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "EEEE"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
    }
}
