import UIKit
import RealmSwift

final class WorkoutsViewController: ViewController<WorkoutsView> {
    
    // MARK: - Properties.

    //массивы данных коллекций
    let beginnerWorkouts: [Workouts] = [.beginnerabs, .beginnerchest, .beginnerarms, .beginnerlegs, .beginnerShouldersAndBack]
    let continuingWorkouts: [Workouts] = [.test, .continuingAbs, .continuingChest, .continuingArms, .continuationLegs, .continuingShouldersAndBack]  //
    let advancedWorkouts: [Workouts] = [.advancedAbs, .advancedChest, .advancedArms, .advancedLegs, .advancedShouldersAndBack]  //
    var user: ProfileModel?
    
    // MARK: - Initialization.

    init() {
        super.init(nibName: nil, bundle: nil)
        navigationController?.navigationBar.isHidden = true
        // для действий с ячейками коллекций и заполнения данными
        ui.beginnerCollectionView.dataSource = self
        ui.beginnerCollectionView.delegate = self

        ui.continuingCollectionView.dataSource = self
        ui.continuingCollectionView.delegate = self

        ui.advancedCollectionView.dataSource = self
        ui.advancedCollectionView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle.

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        let realm = try! Realm()// проверяем есть ли у нас пользователь
        user = realm.objects(ProfileModel.self).first
        ui.beginnerCollectionView.reloadData()
        ui.continuingCollectionView.reloadData()
        ui.advancedCollectionView.reloadData()
    }
}

// extension  для работы с коллекцией
extension WorkoutsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var workout: Workouts?
        //выбор массива и нужной тренеровки (добавлены-didSelectItemAt indexPath, var workout,switch collectionView  -теперь можем брать по индексу в зависимости от выбранной ячейки
        switch collectionView {
        case ui.beginnerCollectionView:
            workout = beginnerWorkouts[indexPath.row]
        case ui.continuingCollectionView:
            workout = continuingWorkouts[indexPath.row]
        case ui.advancedCollectionView:
            workout = advancedWorkouts[indexPath.row]
        default:
            break
        }
        guard let currentWorkout = workout else { return }
        let vc = WorkoutComplexViewController(workout: currentWorkout)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WorkoutsViewController: UICollectionViewDataSource {
    //UICollectionViewDataSource - Этот протокол сообщает представлению коллекции, какую ячейку отображать, сколько ячеек отображать, в каком разделе отображать ячейки и т.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case ui.beginnerCollectionView:
            return beginnerWorkouts.count
        case ui.continuingCollectionView:
            return continuingWorkouts.count
        case ui.advancedCollectionView:
            return advancedWorkouts.count
        default:
            return 0
        }
    }

    //создали ячейку с названием PreviewCollectionViewCell,и у нее есть методы,
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutsCollectionViewCell.reuseID, for: indexPath) as! WorkoutsCollectionViewCell
        var workouts: Workouts?

        switch collectionView {
        case ui.beginnerCollectionView:
            workouts = beginnerWorkouts[indexPath.row]
        case ui.continuingCollectionView:
            workouts = continuingWorkouts[indexPath.row]
        case ui.advancedCollectionView:
            workouts = advancedWorkouts[indexPath.row]
        default:
            break
        }
        var image = workouts?.image
        if let user = user,
           !user.isMan {
            image = workouts?.girlImage
        }
        cell.configure(name: workouts?.name ?? "", image: image)
        return cell
    }
}
