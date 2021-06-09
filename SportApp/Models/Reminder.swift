import RealmSwift
/// модель напоминаия
struct Reminder: CacheInitializable {
    /// время
    var time: Date
    /// индикатор влючено ли напоминание
    var isOn: Bool
    /// id
    let id: String
    /// время создания напоминания
    let createdDate: Date

    // MARK: - Initialization.

    init(time: Date, isOn: Bool = false, id: String, createdDate: Date ) {
        self.id = id
        self.isOn = isOn
        self.time = time
        self.createdDate = createdDate
    }

    init?(cached: Object?) {
        guard
            let cached = cached as? DBTimeModel,
            let time = cached.time,
            let createdDate = cached.createdDate
            else {
                assertionFailure("TimeModel: failed to init from DBTimeModel")
                return nil
        }

        self.id = cached.id
        self.isOn = cached.isOn
        self.time = time
        self.createdDate = createdDate
    }


    // MARK: - Public Methods.

    func cache() {
        DBTimeModel(timeModel: self)
    }

    func update() {
        let realm = try! Realm()
        if let old = realm.object(ofType: DBTimeModel.self, forPrimaryKey: id) {

            try! realm.write {
                old.isOn = isOn
                old.time = time
            }
        }
    }
}

extension Reminder {
    static var current: [Reminder ] {
        let realm = try! Realm()
        let cached = realm.objects(DBTimeModel.self)
        return cached.compactMap({ Reminder(cached: $0)}).sorted(by: { $0.createdDate > $1.createdDate })
    }

    var cached: DBTimeModel? {
        let realm = try! Realm()
        return realm.object(ofType: DBTimeModel.self, forPrimaryKey: id)
    }
}
