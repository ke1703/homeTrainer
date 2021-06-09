import RealmSwift
/// модель для упрощения работы с базой 
struct Cache<Model, DBModel> where Model: CacheInitializable, DBModel: RealmSwift.Object {

    // MARK: - Public Methods.

    func objects(with predicate: NSPredicate? = nil) -> [Model] {
        let cached = self.cached(with: predicate)
        let objects: [Model] = cached.compactMap { Model(cached: $0) }
        return objects
    }

    func cached(with predicate: NSPredicate?) -> Results<DBModel> {
        let realm = try! Realm()

        if let predicate = predicate {
            return realm.objects(DBModel.self).filter(predicate)
        }
        else {
            return realm.objects(DBModel.self)
        }
    }

    func remove(cached: DBModel) {
        let realm = try! Realm()

        try! realm.write {
            realm.delete(cached)
        }
    }

    func removeAll() {
        let realm = try! Realm()
        let cached = realm.objects(DBModel.self)

        try! realm.write {
            realm.delete(cached)
        }
    }

}
