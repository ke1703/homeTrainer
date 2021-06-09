import Foundation
import UIKit
import RealmSwift

/// Одна тренировка - WorkoutComplexViewController
final class WorkoutComplexViewController: ViewController<WorkoutComplexView> , UIGestureRecognizerDelegate {

    // MARK: - Properties.

    var workout: Workouts!
    var curent = 0

    // MARK: - Initialization.

    init(workout: Workouts) {
        super.init(nibName: nil, bundle: nil)
        self.workout = workout
        let realm = try! Realm()// проверяем есть ли у нас пользователь
        var image = workout.image
        if let user = realm.objects(ProfileModel.self).first,
           !user.isMan {
            image = workout.girlImage
        }
        ui.imageView.image = image
        ui.titleLabel.text = workout.name
        ui.tableView.delegate = self
        ui.tableView.dataSource = self
        ui.timeCountView.titleLabelNumber.text = workout.lessons.count.workout(true)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //добавление обработки нажания на exerciseDescriptionView
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide)) // при нажатии на вью выполнить hide
        tap.delegate = self //за нажатями на вью сдледит селф и тут же обрабатывает  нажатие
        ui.exerciseDescriptionView.addGestureRecognizer(tap)// добавляем действие нажатие на вью
        //добавляем переключение к следующему экрану
        ui.exerciseDescriptionView.nextButton.addTarget(self, action: #selector(openNext), for: .touchUpInside)
        //переключение к предыдущему экрану
        ui.exerciseDescriptionView.backButton.addTarget(self, action: #selector(openPrevious), for: .touchUpInside)
        //настройка кнопки внешнего вида назад
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        //начинаем тренировку
        ui.buttonStart.addTarget(self, action: #selector(start), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - User Interaction.

    @IBAction private func start() {
        let vc = WaitingViewController(workout: workout, curent: 0, statistic: Statistic(startTime: Int(Date().timeIntervalSince1970), workoutName: workout.name, type: workout.type))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // функция скрывает exerciseDescriptionView
    @IBAction private func hide() {
        ui.exerciseDescriptionView.isHidden = true
    }

    // переключение на следующий элемент тренировки
    @IBAction private func openNext() {
        if curent + 1 <= workout.lessons.count - 1 {
            curent += 1
            ui.exerciseDescriptionView.configure(lesson: workout.lessons[curent], allCount: workout.lessons.count, currentCount: curent)
        }
    }

    // переключение назад на предыдущий элемент тренировки
    @IBAction private func openPrevious() {
        if curent - 1 >= 0 {
            curent -= 1
            ui.exerciseDescriptionView.configure(lesson: workout.lessons[curent], allCount: workout.lessons.count, currentCount: curent)
        }
    }
}

extension WorkoutComplexViewController: UITableViewDelegate {
    // нажали на ячейку тренировки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curent = indexPath.row
        // показываем вью с описанием
        ui.exerciseDescriptionView.isHidden = false
        // из всех тренировок берем тренировку по индексу
        ui.exerciseDescriptionView.configure(lesson: workout.lessons[indexPath.row], allCount: workout.lessons.count, currentCount: indexPath.row)//передаем данные тренировки для заполнения
    }
}

extension WorkoutComplexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(workout.lessons.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // настройка ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.reuseID) as! WorkoutTableViewCell
        cell.nameLabel.text = workout.lessons[indexPath.row].name
        var text = ""
        if let counts = workout.lessons[indexPath.row].counts {
            text = "x \(counts)"
        }
        if let time = workout.lessons[indexPath.row].time {
            text = "\(time.times())"
        }
        cell.workoutImageView.image = workout.lessons[indexPath.row].imageSmall//добавлены мелкие картинки в таблицу
        
        cell.descriptionLabel.text = text
        return cell
    }
}
