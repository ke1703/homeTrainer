import Foundation
/// модель статистики
struct Statistic {
    /// время начала тренировки
    var startTime: Int
    /// время окончания тренировки
    var endTime: Int?
    /// название тренировки
    var workoutName: String
    /// вес пользователя
    var weight: Int?
    /// тип тренировки
    var type: Type
    
    init(startTime: Int, workoutName: String, type: Type) {
        self.startTime = startTime
        self.workoutName = workoutName
        self.type = type
    }
}
