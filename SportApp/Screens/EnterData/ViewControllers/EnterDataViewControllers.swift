import UIKit
import RealmSwift
import RxSwift
import RxCocoa

final class EnterDataViewControllers: ViewController<EnterDataView> {
    
    // MARK: - Properties.
    
    let disposeBag = DisposeBag()// утилизировать данные?
    var isManSelected = false
    
    // MARK: - Initialization.
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // при переходе с экрана скрывать таббар
        hidesBottomBarWhenPushed = true
        ui.weightView.textField.delegate = self
        ui.heightView.textField.delegate = self
        // скрываем клавиатуру после заполнения
        setupToolbarAsAccessoryViewFor(textField: ui.nameTextField)
        // скрываем клавиатуру после заполнения
        setupToolbarAsAccessoryViewFor(textField: ui.heightView.textField)
        // скрываем клавиатуру после заполнения
        setupToolbarAsAccessoryViewFor(textField: ui.weightView.textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAction()
        changeGender()
        checkUser()
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - User Interaction.
    
    // добавлем действия
    private func createAction() {
        ui.maleButton.addTarget(self, action: #selector(manSelected), for: .touchUpInside)
        ui.womanButton.addTarget(self, action: #selector(womanSelected), for: .touchUpInside)
        ui.heightView.slider.addTarget(self, action: #selector(updateHeightLabel(sender:)), for: .allEvents)
        ui.weightView.slider.addTarget(self, action: #selector(updateWeightLabel(sender:)), for: .allEvents)
        ui.nextButton.addTarget(self, action: #selector(nextButton), for: .touchUpInside)
        ui.saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        ui.scrollView.rx.scrollToViewForInput(vc: self, margin: 16).disposed(by: self.disposeBag)
    }

    /// проверяем еесть ли пользователь в базе если да отображаем его данные
    private func checkUser() {
        let realm = try! Realm()
        guard let user = realm.objects(ProfileModel.self).first else {
            UserDefaults().set(30, forKey: "RelaxTime")
            UserDefaults().set(true, forKey: "SoundOn")
            return
        }
        isManSelected = user.isMan
        changeGender()

        ui.heightView.slider.value = Float(Int(user.height))
        ui.weightView.slider.value = Float(user.weight)
        ui.weightView.textField.text = String(user.weight)
        ui.heightView.textField.text = "\(Int(user.height))"
        ui.nameTextField.text = user.name
    }
    
    // выбор данных "м"
    @objc private func manSelected() {
        isManSelected = true
        changeGender()
    }
    
    // выбор данных "ж"
    @objc private func womanSelected() {
        isManSelected = false
        changeGender()
    }
    
    // изменяем выбранную кнопку пола
    private func changeGender() {
        ui.maleButton.isSelect = isManSelected
        ui.womanButton.isSelect = !isManSelected
    }
    
    /// обновляем отображение роста при изменеени слайдера
    @objc private func updateHeightLabel(sender: UISlider!) {
        let intValue = Int(sender.value)
        DispatchQueue.main.async {
            self.ui.heightView.textField.text = "\(intValue)"
            self.ui.heightView.valueLabel.text = "\(intValue) см"
        }
    }
    
    /// обновляем отображение веса при изменеени слайдера
    @objc private func updateWeightLabel(sender: UISlider!) {
        let intValue = Int(sender.value)
        DispatchQueue.main.async {
            self.ui.weightView.textField.text = "\(intValue)"
            self.ui.weightView.valueLabel.text = "\(intValue) кг"
        }
    }

    /// переходим к следующему окну и сохраняем в базу
    @objc private func nextButton() {
        guard let name = ui.nameTextField.text else { return }
        let height = ui.heightView.slider.value
        let weight = ui.weightView.slider.value

        ProfileModel.create(id: 0, isMan: isManSelected, name: name, weight: Int(weight), height: Int(height))
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    /// переходим назад и сохраняемм данные в базу
    @objc private func save() {
        ///
        guard let name = ui.nameTextField.text else { return }
        let height = ui.heightView.slider.value
        let weight = ui.weightView.slider.value

        let realm = try! Realm()
        guard let user = realm.objects(ProfileModel.self).first else {
            return
        }
        try! realm.write {
            user.height = Int(height)
            user.weight = Int(weight)
            user.name = name
            user.isMan = isManSelected
        }

        navigationController?.popViewController(animated: true)
    }
    
    /// функция скрытия клавиатуры
    private func setupToolbarAsAccessoryViewFor(textField: UITextField) {
        textField.inputAccessoryView = nil
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.ui.frame.size.width, height: 44))
        let closeButton = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(closeInputView(button:)))
        closeButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        toolBar.items = [closeButton]
        toolBar.setItems([closeButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    /// добавление значения и скрытие клавиатуры с экрана
    @objc private func closeInputView(button: UIBarButtonItem) {
        // добавили в текст филд значения и скрываем клавиатуру после заполнения
        ui.nameTextField.endEditing(true)
        // добавили в текст филд значения и скрываем клавиатуру после заполнения
        ui.heightView.textField.endEditing(true)
        // добавили в текст филд значения и скрываем клавиатуру после заполнения
        ui.weightView.textField.endEditing(true)
    }
}

// расширение действия делегата
extension EnterDataViewControllers: UITextFieldDelegate {
    // делегат при изменение теста веса или роста изменяем данные
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        var text = (textField.text ?? "") + string
        if string == "" {
            text = String(text.dropLast())
        }
        let intValue = Int(text) ?? 0
        if textField == ui.heightView.textField {
            let value = max(min(intValue, 300), 100)
            ui.heightView.slider.value = Float(value)
            ui.heightView.valueLabel.text = "\(value)" + " см"
        } else if textField == ui.weightView.textField {
            let value = max(min(intValue, 250), 20)
            ui.weightView.slider.value = Float(value)
            ui.weightView.valueLabel.text = "\(value)" + " кг"
        }
        return true
    }
}
