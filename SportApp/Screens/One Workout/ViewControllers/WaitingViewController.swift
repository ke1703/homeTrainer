import Foundation
import UIKit
import AVFoundation

// Ожидание просмотра
final class WaitingViewController: ViewController<WaitingView> {
    
    // MARK: - Properties.
    
    var workout: Workouts!
    var curent: Int!
    var isSkip = false
    var statistic: Statistic!
    var timer: Timer!
    
    // MARK: - Initialization.
    
    init(workout: Workouts, curent: Int, statistic: Statistic) {
        super.init(nibName: nil, bundle: nil)
        self.workout = workout
        self.curent = curent
        self.statistic = statistic
        hidesBottomBarWhenPushed = true
        ui.titleLabel.text = workout.lessons[curent].name
        ui.imageView.image = workout.lessons[curent].imageBig
        ui.exerciseDescriptionView.configure(lesson: workout.lessons[curent], allCount: workout.lessons.count, currentCount: curent, isHideButtons: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isSkip = false
        ui.timer.animate(from: 30, to: 0, duration: nil, isRemovedOnCompletion: true) {
            guard !self.isSkip else { return}
            let vc = LessonViewController(workout: self.workout, curent: self.curent, statistic: self.statistic)
            vc.modalPresentationStyle = .fullScreen
            self.stopAudio()
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // добавление обработки нажания на exerciseDescriptionView
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        // при нажатии на вью выполнить hide
        ui.exerciseDescriptionView.addGestureRecognizer(tap)
        
        ui.skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
        ui.helpButton.addTarget(self, action: #selector(showHelp), for: .touchUpInside)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // запуск секундомера
        var seconds = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            seconds -= 1
        // запуск аудио
            if seconds <= 5 {
                if let soundOn = UserDefaults.standard.object(forKey: "SoundOn") as? Bool, soundOn {
                    self.loadAudio(name: "audio")
                }
            }
        // стоп аудио и секундомер
            if seconds <= 0 {
                self.stopAudio()
                self.timer.invalidate()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopAudio()
        self.timer.invalidate()
    }
    
    // MARK: - User Interaction.

    @IBAction private func hide() {
        ui.exerciseDescriptionView.isHidden = true
    }
    
    @IBAction private func showHelp() {
        ui.exerciseDescriptionView.isHidden = false
    }
    
    @IBAction private func skip() {
        let alert = UIAlertController(title: nil, message: "Вы действительно хотите пропустить подготовку?", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "ДА", style: UIAlertAction.Style.default, handler: {_ in
            self.isSkip = true
            self.stopAudio()
            self.timer.invalidate()
            let vc = LessonViewController(workout: self.workout, curent: self.curent, statistic: self.statistic)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
