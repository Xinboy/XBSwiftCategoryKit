//
//  DateExtensions.swift
//  XBSwiftCategoryKit
//
//  Created by Xinbo Hong on 2019/7/11.
//

import Foundation

// MARK: - 常用方法
extension Date {
    
    ///默认yyyy-MM-dd
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// 字符串转 Date，默认yyyy-MM-dd
    static func toDate(from string: String?,format: String = "yyyy-MM-dd") -> Date? {
        if string != nil{
            let formatter = DateFormatter.init()
            formatter.dateFormat = format
            return formatter.date(from: string!)
        } else {
            return Date.init()
        }
    }
    
    /// 获取阴历年月日x
    func luner() -> String {
        let chineseYears = ["甲子", "乙丑", "丙寅", "丁卯", "戊辰", "己巳", "庚午", "辛未", "壬申", "癸酉","甲戌", "乙亥", "丙子", "丁丑", "戊寅", "己卯", "庚辰", "辛己", "壬午", "癸未","甲申", "乙酉", "丙戌", "丁亥", "戊子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳","甲午", "乙未", "丙申", "丁酉", "戊戌", "己亥", "庚子", "辛丑", "壬寅", "癸丑","甲辰", "乙巳", "丙午", "丁未", "戊申", "己酉", "庚戌", "辛亥", "壬子", "癸丑","甲寅", "乙卯", "丙辰", "丁巳", "戊午", "己未", "庚申", "辛酉", "壬戌", "癸亥"]
        
        let chineseMonths = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月","九月", "十月", "冬月", "腊月"]
        
        let chineseDays = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十","十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十","廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
        
        let calendar = Calendar.init(identifier: .chinese)
        var localeComp = calendar.dateComponents([.year, .month, .day], from: self)
        let yearString = chineseYears[localeComp.year!]
        let monthString = chineseMonths[localeComp.month!]
        let dayString = chineseDays[localeComp.day!]
        
        return String.init(format: "%@年 %@%@", yearString, monthString, dayString)
   
    }
    
    /// 时间戳：将当前时间转换为时间戳字符串
    func timeStamp() -> String {
        return String.init(format: "%ld", self.timeIntervalSince1970)
    }
    
    /// 时间戳：根据传入时间字符串(yyyy-MM-dd HH:mm:ss)转换为时间戳字符串
    static func timeStamp(with timeString: String?) -> String {
        if timeString!.count > 0 {
            let time = timeString!
            let formatter = DateFormatter.init()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let versionDate = formatter.date(from: time)
            return versionDate!.timeStamp()
        } else {
            return ""
        }
    }
    
    /// 时间戳：根据传入时间字符串(yyyy-MM-dd HH:mm:ss)转换为时间戳字符串
    static func timeStamp(with timeString: String?, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        if timeString!.count > 0 {
            let time = timeString!
            let formatter = DateFormatter.init()
            formatter.dateFormat = format
            let versionDate = formatter.date(from: time)
            return versionDate!.timeStamp()
        } else {
            return ""
        }
    }
}

// MARK: - 给定日期/当前日期的X（年/月/日/时/分/秒）前后日期
extension Date {
    enum AdjustingType: Int {
        case year = 0
        case month
        case day
        case hour
        case minute
        case second
    }
    
    
    /// 获取当前日期所在月的第一天
    static func beginMonthDay() -> Date {
        return Date.beginMonthDay(of: Date.init())
    }
    
    /// 获取给定日期所在月的第一天
    static func beginMonthDay(of date: Date) -> Date {
        return Date.date(day: date.day * -1 + 1, after: date)
    }
    
    /// 获取给定日期所在月的最后一天
    static func lastMonthDay() -> Date {
        return Date.lastMonthDay(of: Date.init())
    }
    
    /// 获取给定日期所在月的最后一天
    static func lastMonthDay(of date: Date) -> Date {
        let beginDate = Date.beginMonthDay(of: date)
        return Date.date(day: date.day * -1 + 1, after: beginDate)
    }
    
    /// 明天
    static func tomorrow() -> Date {
        return Date.dateAfterNow(day: 1)
    }
    
    /// 昨天
    static func yesterday() -> Date {
        return Date.dateBeforeNow(day: 1)
    }
    
    // MARK: - 年相关
    /// 当前日期的 year 年后的日期
    static func dateAfterNow(year: Int) -> Date {
        return Date.date(addingTime: year, from: Date.init(), type: .year)
    }

    /// 给定日期 year 年的日期
    static func date(year: Int, after date: Date) -> Date {
        return Date.date(subtractingTime: year, from: date, type: .year)
    }
    
    /// 当前日期的 year 年的日期
    static func dateBeforeNow(year: Int) -> Date {
        return Date.date(subtractingTime: year, from: Date.init(), type: .year)
    }
    
    /// 给定日期 year 年的日期
    static func date(year: Int, before date: Date) -> Date {
        return Date.date(subtractingTime: year, from: date, type: .year)
    }
    
    // MARK: - 月相关
    
    /// 当前日期的 month 月后的日期
    static func dateAfterNow(month: Int) -> Date {
        return Date.date(addingTime: month, from: Date.init(), type: .month)
    }
    
    /// 给定日期的 month 月后的日期
    static func date(month: Int, after date: Date) -> Date {
        return Date.date(subtractingTime: month, from: date, type: .month)
    }
    
    /// 当前日期的 month 月前的日期
    static func dateBeforeNow(month: Int) -> Date {
        return Date.date(subtractingTime: month, from: Date.init(), type: .month)
    }
    
    /// 给定日期的 month 月前的日期
    static func date(month: Int, before date: Date) -> Date {
        return Date.date(subtractingTime: month, from: date, type: .month)
    }
    
    // MARK: - 日相关
    /// 当前日期的 day 天后的日期
    static func dateAfterNow(day: Int) -> Date {
        return Date.date(addingTime: day, from: Date.init(), type: .day)
    }
    
    /// 给定日期的 day 天后的日期
    static func date(day:Int, after date: Date) -> Date {
        return Date.date(subtractingTime: day, from: date, type: .day)
    }
    
    /// 当前日期的 day 天前的日期
    static func dateBeforeNow(day: Int) -> Date {
        return Date.date(subtractingTime: day, from: Date.init(), type: .day)
    }
    
    /// 给定日期的 day 天前的日期
    static func date(day:Int, before date: Date) -> Date {
        return Date.date(subtractingTime: day, from: date, type: .day)
    }
    
    // MARK: - 时相关
    /// 当前日期的 hour 天后的日期
    static func dateAfterNow(hour: Int) -> Date {
        return Date.date(addingTime: hour, from: Date.init(), type: .hour)
    }
    
    /// 给定日期的 hour 天后的日期
    static func date(hour:Int, after date: Date) -> Date {
        return Date.date(subtractingTime: hour, from: date, type: .hour)
    }
    
    /// 当前日期的 hour 天的日期
    static func dateBeforeNow(hour: Int) -> Date {
        return Date.date(subtractingTime: hour, from: Date.init(), type: .hour)
    }
    
    /// 给定日期的 hour 天前的日期
    static func date(hour:Int, before date: Date) -> Date {
        return Date.date(subtractingTime: hour, from: date, type: .hour)
    }
    
    
    // MARK: - 分相关
    /// 当前日期的 minute 天后的日期
    static func dateAfterNow(minute: Int) -> Date {
        return Date.date(addingTime: minute, from: Date.init(), type: .minute)
    }
    
    /// 给定日期的 minute 天后的日期
    static func date(minute: Int, after date: Date) -> Date {
        return Date.date(subtractingTime: minute, from: date, type: .minute)
    }
    
    /// 当前日期的的 minute 天前的日期
    static func dateBeforeNow(minute: Int) -> Date {
        return Date.date(subtractingTime: minute, from: Date.init(), type: .minute)
    }
    
    /// 给定日期的 minute 天前的日期
    static func date(minute: Int, before date: Date) -> Date {
        return Date.date(subtractingTime: minute, from: date, type: .minute)
    }
    
    // MARK: - 秒相关
    /// 当前日期的 second 天后的日期
    static func dateAfterNow(second: Int) -> Date {
        return Date.date(addingTime: second, from: Date.init(), type: .second)
    }
    
    /// 给定日期的 second 天后的日期
    static func date(second:Int, after date: Date) -> Date {
        return Date.date(subtractingTime: second, from: date, type: .second)
    }
    
    /// 当前日期的的 second 天前的日期
    static func dateBeforeNow(second: Int) -> Date {
        return Date.date(subtractingTime: second, from: Date.init(), type: .second)
    }
    
    /// 给定日期的 second 天前的日期
    static func date(with second:Int, before date: Date) -> Date {
        return Date.date(subtractingTime: second, from: date, type: .second)
    }
    
    
    // MARK: -
    
    /// 根据指定时间类型的数值，获取给定日期后的时间
    ///
    /// - Parameters:
    ///   - addingTime: 添加的数值
    ///   - date: 给定时间
    ///   - type: 给定时间类型
    /// - Returns: 最终时间
    private static  func date(addingTime:Int, from date:Date, type: AdjustingType) -> Date {
        var components = DateComponents.init()
        let calendar = Calendar.init(identifier: .gregorian)
        
        switch type {
        case .year:
            components.year = addingTime
            break
        case .month:
            components.month = addingTime
            break
        case .day:
            components.day = addingTime
            break
        case .hour:
            components.hour = addingTime
            break
        case .minute:
            components.minute = addingTime
            break
        case .second:
            components.second = addingTime
            break
        }
        return calendar.date(byAdding: components, to: date)!
    }
    
    /// 根据指定时间类型的数值，获取给定日期前的时间
    ///
    /// - Parameters:
    ///   - subtractingTime: 减少的数值
    ///   - date: 给定时间
    ///   - type: 给定时间类型
    /// - Returns: 最终时间
    private static  func date(subtractingTime: Int ,from date: Date, type: AdjustingType) -> Date {
        return self.date(addingTime: -subtractingTime, from: date, type: type)
    }
}

// MARK: - 获取某天/月/年的开始或结束日期 00:00:00 或者是 23:59:59
extension Date {

    /// 包含年月日时分秒的 Set<Calendar.Component>
    var ymdhms: Set<Calendar.Component> {
        var set: Set<Calendar.Component> = Set.init()
        set = [.era, .year, .month, .day, .hour, .minute, .second]
        return set
    }
    
    /// 获取今天的 00:00:00 日期
    func beginTimeOfDay() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        com.hour = 0
        com.minute = 0
        com.second = 0
        com.timeZone = calendar.timeZone
        return calendar.date(from: com)!
    }
    
    /// 获取明天的 00:00:00 日期
    func beginTimeOfNextDay() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        com.day = com.day! + 1
        com.hour = 0
        com.minute = 0
        com.second = 0
        com.timeZone = calendar.timeZone
        return calendar.date(from: com)!
    }
    
    /// 获取今天的 23:59:59 日期
    func endTimeOfDay() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        com.hour = 23
        com.minute = 59
        com.second = 59
        com.timeZone = calendar.timeZone
        return calendar.date(from: com)!
    }
    
    /// 获取本月第一天的 00:00:00 日期
    func beginTimeOfMonth() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        com.day = calendar.range(of: .day, in: .month, for: self)?.startIndex
        //时分秒重置
        return calendar.date(from: com)!.beginTimeOfDay()
    }
    
    /// 获取下月第一天的 00:00:00 日期
    func beginTimeOfNextMonth() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        com.month = com.month! + 1
        com.day = calendar.range(of: .day, in: .month, for: self)?.startIndex
        
        return calendar.date(from: com)!.beginTimeOfDay()
    }
    
    /// 获取本月最后一天的 23:59:59 日期
    func endTimeOfMonth() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        com.day = calendar.range(of: .day, in: .month, for: self)?.count
        
        return calendar.date(from: com)!.endTimeOfDay()
    }
    
    /// 获取今年第一天的 00:00:00 日期
    func beginTimeOfYear() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        let monthRange = calendar.range(of: .month, in: .year, for: self)
        let dayRange = calendar.range(of: .day, in: .month, for: self)
        com.month = monthRange?.startIndex
        com.day = dayRange?.startIndex
        
        return calendar.date(from: com)!.beginTimeOfDay()
    }
    
    /// 获取下年第一天的 00:00:00 日期
    func beginTimeOfNextYear() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        let monthRange = calendar.range(of: .month, in: .year, for: self)
        let dayRange = calendar.range(of: .day, in: .month, for: self)
        com.year = com.year! + 1
        com.month = monthRange?.startIndex
        com.day = dayRange?.startIndex
        
        return calendar.date(from: com)!.beginTimeOfDay()
    }
    
    /// 获取今年最后一天的 23:59:59 日期
    func endTimeOfYear() -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        var com =  calendar.dateComponents(self.ymdhms, from: self)
        
        //获取最后一个月
        let monthRange = calendar.range(of: .month, in: .year, for: self)
        com.month = monthRange?.count
        let endMonthDate = calendar.date(from: com)
        
        //获取最后一个月的天
        let dayRange = calendar.range(of: .day, in: .month, for: endMonthDate!)
        com.day = dayRange?.count
        return calendar.date(from: com)!.endTimeOfDay()
    }
    
    
}

// MARK: - 比较日期，判断是否为某一特征
extension Date {
    
    /// 比较两个日期，忽视时月分
    func isEqualToDateIgnoringTime(with otherDate:Date) -> Bool {
        let current = Calendar.init(identifier: .gregorian)
        
        let com1 = current.dateComponents([.era, .year, .month, .day], from: self)
        let com2 = current.dateComponents([.era, .year, .month, .day], from: otherDate)
        
        return (com1.era == com2.era) &&
            (com1.year == com2.year) &&
            (com1.month == com2.month) &&
            (com1.day == com2.day)
    }
    
    /// 判断当前日期是否是今天
    func isToday() -> Bool {
        return self.isEqualToDateIgnoringTime(with: Date.init())
    }
    
    /// 判断当前日期是否是明天
    func isTomorrow() -> Bool {
        return self.isEqualToDateIgnoringTime(with: Date.tomorrow())
    }
    
    
    /// 判断当前日期是否是昨天
    func isYestoday() -> Bool {
        return self.isEqualToDateIgnoringTime(with: Date.yesterday())
    }
    
    /// 判断当前日期是否和给定日期是同一周
    func isSameWeek(with date: Date) -> Bool {
        
        let current = Calendar.init(identifier: .gregorian)
        
        let com1 = current.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        let com2 = current.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        
        return (com1.weekOfYear == com2.weekOfYear) &&
            (com1.yearForWeekOfYear == com2.yearForWeekOfYear)
        
    }
    
     /// 判断当前日期是否是本周
    func isThisWeek() -> Bool {
        return self.isSameWeek(with: Date.init())
    }
    
     /// 判断当前日期是否是下周
    func isNextWeek() -> Bool {
        return self.isSameWeek(with: Date.dateAfterNow(day: self.weekday))
    }
    
     /// 判断当前日期是否是上周
    func isLastWeek() -> Bool {
        return self.isSameWeek(with: Date.dateBeforeNow(day: self.weekday))
    }
    
     /// 判断当前日期是否和给定日期是同一月
    func isSameMonth(with date: Date) -> Bool {
        let date1 = self.beginTimeOfMonth()
        let date2 = self.beginTimeOfMonth()
        return date1 == date2
    }

    /// 判断当前日期是否和给定日期是同一年
    func isSameYear(with date: Date) -> Bool {
        let date1 = self.beginTimeOfYear()
        let date2 = self.beginTimeOfYear()
        return date1 == date2
    }
    
    ///判断当前日期是否早于给定日期
    func isEarlier(than date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    ///判断当前日期是否晚于给定日期
    func isLater(than date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    ///判断当前日期是否早于或等于给定日期
    func isEarlierOrEqual(to date: Date) -> Bool {
        let result: ComparisonResult = self.compare(date)
        return result == .orderedAscending || result == .orderedSame
    }
    
    ///判断当前日期是否晚于或等于给定日期
    func isLaterOrEqual(to date: Date) -> Bool {
        let result: ComparisonResult = self.compare(date)
        return result == .orderedDescending || result == .orderedSame
    }
    
    ///判断当前日期是否在未来
    func isInFuture() -> Bool  {
        return self.isEarlier(than: Date.init())
    }
    
    ///判断当前日期是否在过去
    func isInPast() -> Bool  {
        return self.isLater(than: Date.init())
    }
}


// MARK: - 获取年月日，时分秒
extension Date {
    
    /// 获取给定日期的日
    var day: Int {
        return Date.day(date: self)
    }
    
    /// 获取给定日期的月
    var month: Int {
        return Date.month(date: self)
    }
    
    /// 获取给定日期的年
    var year: Int {
        return Date.year(date: self)
    }
    
    /// 获取给定日期的小时
    var hour: Int {
        return Date.hour(date: self)
    }
    
    /// 获取给定日期的分
    var minute: Int {
        return Date.minute(date: self)
    }
    
    /// 获取给定日期的秒
    var second: Int {
        return Date.second(date: self)
    }
    
    var weekday: Int {
        return  Calendar.current.maximumRange(of: .weekday)!.count
    }

    
    /// 获取给定日期的日
    static func day(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    /// 获取给定日期的月
    static func month(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        return components.month!
    }
    
    /// 获取给定日期的年
    static func year(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return components.year!
    }
    /// 获取给定日期的小时
    static func hour(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        return components.hour!
    }
    
    /// 获取给定日期的分
    static func minute(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date)
        return components.minute!
    }
    
    /// 获取给定日期的秒
    static func second(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: date)
        return components.second!
    }
    
}
