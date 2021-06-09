import Foundation
import RealmSwift
/// модель для сохранения статистики в базу
final class ProfileStatisticModel: Object {

    // MARK: - Properties.
    /// id
    @objc dynamic var id = 0
    /// время начало треировки
    @objc dynamic var startTime = 0
    /// время окончания тренировки
    @objc dynamic var endTime = 0
    /// название
    @objc dynamic var workoutName = ""
    /// вес
    @objc dynamic var weight = 0
    /// тип тренровки
    @objc dynamic var type = ""
    
    /// функция создания и сохранение в базу
    static func create(startTime: Int, endTime: Int, workoutName: String, weight: Int, type: String)  {
        let model = ProfileStatisticModel()
        model.id = Int(startTime)
        model.startTime = startTime
        model.endTime = endTime
        model.workoutName = workoutName
        model.weight = weight
        model.type = type
        
        //сохранение в базу
        let realm = try! Realm()
        try! realm.write {
            realm.add(model, update: .all)
        }
    }

    // MARK: - Primary Key.

    override static func primaryKey() -> String? {
        return "id"
    }

}
