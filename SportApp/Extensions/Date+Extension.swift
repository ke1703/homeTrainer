import Foundation

extension Date {
    func toString(dateFormat: DateFormat, using dateFormatter: DateFormatter = DateFormatter()) -> String? {
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale.init(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}

typealias DateFormat = String

extension DateFormat {
    static let fullDate = "dd.MM.yyyy"
    static let time = "HH:mm"
    static let serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let expirationDate = "HH:mm, dd MMMM yyyy"
    static let targetDate = "yyyy-MM-dd HH:mm:ss"
}
