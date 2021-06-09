import Foundation
import UIKit
import RealmSwift
import AVFoundation
import RxSwift
import RxCocoa
/// Экран ФИНИШ
 class FinishWorkoutViewController: ViewController<FinishWorkoutView> {
    
    // MARK: - Properties.
    
    var workout: Workouts!
    var curent: Int!
    var statistic: Statistic!
    var timer: Timer!
    let disposeBag = DisposeBag()
    
    // MARK: - Initialization.
    
    init(workout: Workouts, curent: Int, statistic: Statistic) {
        super.init(nibName: nil, bundle: nil)
        self.workout = workout
        self.curent = curent
        self.statistic = statistic
        setupToolbarAsAccessoryViewFor(textField: ui.changeWeightView.weightView.textField)
        /// обновляем отображение веса при изменеени слайдера на changeWeightView
        ui.changeWeightView.weightView.textField.delegate = self
    
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// запсали в статистику время окончания тренировки
        statistic.endTime = Int(Date().timeIntervalSince1970)
        /// вызов функции для заполнения веса пользователя
        updateWeight()
        /// действие для кнопки карандашик
        ui.editWeightButton.addTarget(self, action: #selector(showHelp), for: .touchUpInside)
        /// рассчет и заполнение времени тренировки
        ui.timeLabel.text = "\(Int(statistic.endTime! - statistic.startTime).times())"
        /// действие на кнопку "Записать"
        ui.changeWeightView.recordButton.addTarget(self, action: #selector(recordButton), for: .touchUpInside)
        /// действие на слайдер
        ui.changeWeightView.weightView.slider.addTarget(self, action: #selector(updateWeightLabel(sender:)), for: .allEvents)
        /// действие слайдера, запись в текст и лейбл
        ui.changeWeightView.weightView.slider.addTarget(self, action: #selector(updatesWeightLabel(sender:)), for: .allEvents)
        /// добавление обработки нажатия скрыть ввод веса
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide)) 
        ui.changeWeightView.addGestureRecognizer(tap)
        ui.moreWorcautButton.addTarget(self, action: #selector(saveBase), for: .touchUpInside)
        /// скролл вью
        ui.scrollView.rx.scrollToViewForInput(vc: self, margin: 16).disposed(by: self.disposeBag)
        if let soundOn = UserDefaults.standard.object(forKey: "SoundOn") as? Bool, soundOn {
            //запуск аудио авации
            loadAudio(name: "Овации")
            
        }
        
        var seconds = 3
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            seconds -= 1
            
            if seconds <= 0 {
                self.stopAudio()
                self.timer.invalidate()
            }
        }
    }
    
    // MARK: - Private Methods.
    
    /// функция обновления веса
    private func updateWeight() {
        let realm = try! Realm()// проверяем есть ли у нас пользователь
        if let user = realm.objects(ProfileModel.self).first {
            ui.changeWeightView.weightView.valueLabel.text = String(user.weight) + " кг"
            ui.changeWeightView.weightView.slider.value = Float(user.weight)
            ui.weightLabel.text = String(user.weight) + " кг"
            statistic.weight = user.weight
        }
    }
    
    /// обновляем отображение веса при изменеени слайдера на changeWeightView
        @objc private func updatesWeightLabel(sender: UISlider!) {
            let intValue = Int(sender.value)
            DispatchQueue.main.async {
                self.ui.changeWeightView.weightView.textField.text = "\(intValue)"
                self.ui.changeWeightView.weightView.valueLabel.text = "\(intValue) кг"
                self.ui.changeWeightView.weightView.slider.value = Float(intValue)
            }
        }

    /// метод скрытия клавиатуры
    private func setupToolbarAsAccessoryViewFor(textField: UITextField) {
        textField.inputAccessoryView = nil
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.ui.frame.size.width, height: 44))
        let closeButton = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(closeInputView(button:)))
        closeButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        toolBar.items = [closeButton]
        toolBar.setItems([closeButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func closeInputView(button: UIBarButtonItem) {
        /// добавили в текст филды значения и скрываем клавиатуру после заполнения
        ui.changeWeightView.weightView.textField.endEditing(true)
    }
    
    // MARK: - User Interaction.
    
    /// функция сохранения в базу и перехода на главный экран
    @IBAction private func saveBase() {
        ProfileStatisticModel.create(startTime: statistic.startTime, endTime: statistic.endTime!, workoutName: statistic.workoutName, weight: Int(statistic.weight!), type: statistic.type.rawValue)
        let vc = TabBarViewController()
        stopAudio()
        timer.invalidate()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func showHelp() {
        ui.scrollView.isHidden = false
    }
    
    @IBAction private func recordButton() {
        // для кнопки записать
        ui.changeWeightView.weightView.textField.endEditing(true)
        statistic.weight = Int(ui.changeWeightView.weightView.slider.value)
        let realm = try! Realm()
        if let user = realm.objects(ProfileModel.self).first {
            try! realm.write {
                user.weight = Int(ui.changeWeightView.weightView.slider.value)
            }
        }
        updateWeight()
        hide()
    }
    /// вписыват данные веса в лэйбл
    @IBAction private func updateWeightLabel(sender: UISlider!) {
        DispatchQueue.main.async {
            self.ui.changeWeightView.weightView.valueLabel.text = String(sender.value) + " кг"
        }
    }
    
    @IBAction private func hide() {
        ui.scrollView.isHidden = true
    }
}

/// расширение действия делегата для изменения веса в слайдере и текст фиелд на changeWeightView
extension FinishWorkoutViewController: UITextFieldDelegate {
    // делегат, при изменение текста веса изменяем данные веса 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        var text = (textField.text ?? "") + string
        if string == "" {
            text = String(text.dropLast())
        }
        let intValue = Int(text) ?? 0
        if textField == ui.changeWeightView.weightView.textField {
            let value = max(min(intValue, 250), 20)
            ui.changeWeightView.weightView.slider.value = Float(value)
            ui.changeWeightView.weightView.valueLabel.text = "\(value)" + " кг"
        }
        return true
    }
}
