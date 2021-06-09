import Foundation
import UIKit

class RemindersViewController: ViewController<RemindersView> {

    // MARK: - Properties.

    private var reminders: [Reminder] = []
    private let notificationsPermissionManager = NotificationsPermissionManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    private var isEditingTable = false

    // MARK: - Initialization.

    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        ui.tableView.dataSource = self
        ui.tableView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle.

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        reminders = Reminder.current
        changeNavbarRightItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func changeNavbarRightItem() {
        if !reminders.isEmpty {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: isEditingTable ? "Готово" : "Править", style: .plain, target: self, action:  #selector(self.edit))
            navigationItem.rightBarButtonItem?.tintColor = .black
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    private func saveDate(_ date: Date) {
        notificationsPermissionManager.checkNotificationsAccess(askingForPermission: true) { [weak self] (isAllowed) in
            if isAllowed {
                self?.scheduleNotification(date: date)
            }
        }
    }

    func scheduleNotification (date : Date, _ timeModel: Reminder? = nil ) {
        var uuidSttring = UUID().uuidString
        var newTime = Reminder(time: date, isOn: true, id: uuidSttring, createdDate: Date())

        if let timeModel = timeModel {
            uuidSttring = timeModel.id
            newTime = timeModel
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [uuidSttring])
            newTime.update()
        } else {
            newTime.cache()
        }

        let body = "🏋️‍♀️ Пришло время для твоей тренировки 🏆"

        let content = UNMutableNotificationContent ()
        content.body = body
        content.sound = UNNotificationSound.default

        let triggerDate = Calendar.current.dateComponents ([ .hour, .minute, .second,], from: date)
        let trigger = UNCalendarNotificationTrigger (dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: uuidSttring, content: content, trigger: trigger)

        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else {
                if let index = self.reminders.firstIndex(where: { $0.time == newTime.time}) {
                    self.reminders[index] = newTime
                } else {
                    self.reminders.insert(newTime, at: 0)
                }

                DispatchQueue.main.async {
                    self.ui.tableView.reloadData()
                    self.changeNavbarRightItem()
                }
            }
        }
    }

    // MARK: - User Interaction.

    @objc
    private func edit(_ sender: Any) {
        isEditingTable = !isEditingTable
        navigationItem.rightBarButtonItem?.title = isEditingTable ? "Готово" : "Править"
        ui.tableView.reloadData()
    }

    private func openAlert(time: Reminder) {
        let actionSheet = UIAlertController(title: String(describing: time.time.toString(dateFormat: .time)!), message: nil, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (action) in
            if let index = self.reminders.firstIndex(where: { $0.time == time.time}) {
                if let cached = time.cached {
                    Cache<Reminder, DBTimeModel>().remove(cached: cached)
                }
                self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [time.id])
                self.reminders.remove(at: index)
                self.isEditingTable = !self.isEditingTable
                self.changeNavbarRightItem()
                self.ui.tableView.reloadData()
            }
        }

        let editAction = UIAlertAction(title: "Редактировать", style: .destructive) { (action) in
            if let index = self.reminders.firstIndex(where: { $0.time == time.time}) {
                self.selectTime(selectedDate: self.reminders[index].time) { [weak self]  in
                    self?.reminders[index].time = $0
                    if (self?.reminders[index].isOn)! {
                        self?.notificationsPermissionManager.checkNotificationsAccess(askingForPermission: true) { [weak self] _ in
                            self?.scheduleNotification(date: (self?.reminders[index].time)!, self?.reminders[index]) }
                    }
                    else {
                        self?.reminders[index].update()
                        self?.ui.tableView.reloadData()
                    }
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (action) in }
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(editAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = Section(rawValue: indexPath.section)!

        switch section {
        case .header:
            break
        case .notifications:
            if isEditingTable {
                selectTime(selectedDate: reminders[indexPath.row].time) { [weak self]  in
                    self?.reminders[indexPath.row].time = $0
                    if (self?.reminders[indexPath.row].isOn)! {
                        self?.notificationsPermissionManager.checkNotificationsAccess(askingForPermission: true) { [weak self] _ in
                            self?.scheduleNotification(date: (self?.reminders[indexPath.row].time)!, self?.reminders[indexPath.row]) }
                    }
                    else {
                        self?.reminders[indexPath.row].update()
                        self?.ui.tableView.reloadData()
                    }
                }
            }
        case .add:
            selectTime(selectedDate: nil) { [weak self]  in
                self?.saveDate($0)
            }
        }
    }
}

extension RemindersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)!

        switch section {
        case .header:
            return 1
        case .notifications:
            return reminders.count
        case .add:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)!

        switch section {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: DisclaimerTVCell.reuseID, for: indexPath) as! DisclaimerTVCell
            cell.configure(text: "Установите напоминания, чтобы не пропустить тренировку")
            return cell
        case .notifications:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseID, for: indexPath) as! NotificationTableViewCell
            cell.configure(model: reminders[indexPath.row], isEditing: isEditingTable)
            cell.delegateSwitch = self
            cell.deleteDelegate = self
            return cell
        case .add:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddItemTVCell.reuseID, for: indexPath) as! AddItemTVCell
            cell.configure(isEditing: false)
            cell.configure(kind: .notification)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let section = Section(rawValue: indexPath.section)!

        switch section {
        case .header:
            return false
        case .notifications:
            return true
        case .add:
            return false
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension RemindersViewController: DeleteNotificationDelegate{
    func deleteTime(timeModel: Reminder) {
        openAlert(time: timeModel)
    }
}

extension RemindersViewController: SwitchNotificationDelegate {
    func changeSwitch(timeModel: Reminder) {
        if let index = reminders.firstIndex(where: { $0.time == timeModel.time}) {
            timeModel.update()
            reminders = Reminder.current
            guard timeModel.isOn else {
                deleteNotification(time: reminders[index])
                return
            }

            notificationsPermissionManager.checkNotificationsAccess(askingForPermission: true) { [weak self] _ in
                self?.scheduleNotification(date: (self?.reminders[index].time)!, self?.reminders[index])
            }
        }
    }
}

extension RemindersViewController {
    @objc func switchTapped(_ sender: UISwitch) {
        let index = sender.tag
        reminders[index].isOn = sender.isOn

        reminders[index].update()
        reminders = Reminder.current
        guard sender.isOn else {
            deleteNotification(time: reminders[index])
            return
        }

        notificationsPermissionManager.checkNotificationsAccess(askingForPermission: true) { [weak self] _ in
            self?.scheduleNotification(date: (self?.reminders[index].time)!, self?.reminders[index])
        }
    }

    func deleteNotification(time: Reminder) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [time.id])
    }
}

extension RemindersViewController {
    enum Section: Int {
        case header
        case add
        case notifications
    }
}
