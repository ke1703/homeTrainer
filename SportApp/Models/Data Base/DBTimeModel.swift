import Foundation
import RealmSwift
/// модель для сохранения напоминаний в базу
final class DBTimeModel: Object {

    // MARK: - Primary Key.

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: - Properties.
    /// id
    @objc dynamic var id: String = ""
    /// время напоминания
    @objc dynamic var time: Date? = nil
    /// индикатор влючено ли напоминание
    @objc dynamic var isOn: Bool = false
    /// время создания напоминания
    @objc dynamic var createdDate: Date? = nil

    // MARK: - Initialization.

    @discardableResult
    required convenience init(timeModel: Reminder) {
        self.init()

        self.id = timeModel.id
        self.time = timeModel.time
        self.isOn = timeModel.isOn
        self.createdDate = timeModel.createdDate

        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: .all)
        }
    }
}
