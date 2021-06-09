import UIKit

extension Int {
    func times() -> String {//использование 5.times(),  получится 00:05
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = ((self % 3600) % 60)
        var time: String =  ""
        if h > 0 && h < 10 {time += "0\(h):"} else if h > 10{ time += "\(h):" }
        if m >= 0 && m < 10 {time += "0\(m):"} else { time += "\(m):" }
        if s >= 0 && s < 10 {time += "0\(s)"} else { time += "\(s)" }
        return time
    }

    func workout(_ needSelf: Bool = true) -> String {
        var dayString: String!
        if self < 0                          {return "Нет тренировок"}
        if "1".contains("\(self % 10)")      {dayString = "Тренировка"}
        if "234".contains("\(self % 10)")    {dayString = "Тренировки" }
        if "567890".contains("\(self % 10)") {dayString = "Тренировок"}
        if 11...14 ~= self % 100             {dayString = "Тренировок"}

        if needSelf {
            return "\(self) " + dayString
        } else {
            return dayString
        }
    }
}
