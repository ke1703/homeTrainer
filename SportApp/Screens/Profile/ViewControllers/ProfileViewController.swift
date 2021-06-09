import UIKit
import RealmSwift

final class ProfileViewController: ViewController<ProfileView> {
    
    // MARK: - Properties.
    private lazy var imagePicker = ImagePicker()
    private let cameraPermissionManager = CameraPermissionManager()
    
    // MARK: - Initialization.
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // действие для кнопки уведомления
        ui.remindersButton.addTarget(self, action: #selector(openReminders), for: .touchUpInside)
        // действие для кнопки настройки
        ui.settingsButton.addTarget(self, action: #selector(settings), for: .touchUpInside)
        // действие для кнопки карандаш
        ui.editWeightButton.addTarget(self, action: #selector(showEnterData), for: .touchUpInside)
        // действие на кнопку фото
        ui.avatarButton.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserName()
        updateWorkout()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private Methods.
    
    // функция для перехода по кнопке карандаш
    @IBAction
    private func showEnterData() {
        let vc = EnterDataViewControllers()
        vc.ui.nextButton.isHidden = true
        vc.ui.saveButton.isHidden = false
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// функция обновления имя пользователя
    private func updateUserName() {
        /// проверяем есть ли у нас пользователь
        let realm = try! Realm()
        if let user = realm.objects(ProfileModel.self).first {
            /// если есть, записать в лэйбл текста  имя пользователя
            ui.nameLabel.text = user.name
            if let data = UserDefaults.standard.object(forKey: "image") as? Data {
                ui.avatarImageView.image = UIImage(data: data)
                ui.avatarButton.setImage(nil, for: .normal)
            } else {
                ui.avatarButton.setImage(UIImage(named: "icons8-unsplash-100 1"), for: .normal)
            }
        }
    }
    
    /// функция обновления последней тренировки пользователя
    private func updateWorkout() {
        let realm = try! Realm()
        
        if let workout = realm.objects(ProfileStatisticModel.self).last {
            /// установить в beginnerLabel   из библиотеки тип нового названия
            ui.beginnerLabel.text = workout.type
        }
    }
    
    /// при нажатии на кнопку переход на другой коннтроллер SettingsViewController
    @objc private func settings() {
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// при нажатии на кнопку переход на другой коннтроллер RemindersViewController
    @objc private func openReminders() {
        let vc = RemindersViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// при нажатии на кнопку переход сделать фото для аватарки
    @objc private func changePhoto() {
        cameraPermissionManager.checkCameraAccess(askingForPermission: true) { [weak self] (isAllowed) in
            guard isAllowed else {
                return
            }
            self?.showMenu()
        }
    }
    
    /// показать меню картинок в фотогаллерее
    private func showMenu() {
        ImageMenu().show(showsRemoveImageOption: false, then: { [weak self] in
            switch $0 {
            case .takePhoto:
                self?.imagePicker.show(.camera, then: { (image) in
                    self?.handleImage(image)
                })
            case .pickFromLibrary:
                self?.imagePicker.show(.photoLibrary, then: { (image) in
                    self?.handleImage(image)
                })
            case .delete, .cancel:
                break
            }
        })
    }
    
    /// установить выбранный аватар
    private func handleImage(_ image: UIImage) {
        ui.avatarImageView.image = image
        let yourDataImagePNG = image.pngData()
        ui.avatarButton.setImage(nil, for: .normal)
        UserDefaults().set(yourDataImagePNG, forKey: "image")
    }
}
