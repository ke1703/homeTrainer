import Foundation
import RealmSwift
/// модель для сохранения данных пользователя при входе в базу
final class ProfileModel: Object {
    
    // MARK: - Properties.

    /// id 
    @objc dynamic var id = 0
    /// пол
    @objc dynamic var isMan = false
    /// имя
    @objc dynamic var name = ""
    /// вес
    @objc dynamic var weight = 0
    /// рост
    @objc dynamic var height = 0
    
    /// функция создания и сохранение профиля в базу
    static func create(id: Int, isMan: Bool, name: String, weight: Int, height: Int)  {
        let profileModel = ProfileModel()
        profileModel.id = id
        profileModel.isMan = isMan
        profileModel.name = name
        profileModel.weight = weight
        profileModel.height = height
        
        //сохранение в базу
        let realm = try! Realm()
        try! realm.write {
            realm.add(profileModel, update: .all)
        }
    }
    
    // MARK: - Primary Key.
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
