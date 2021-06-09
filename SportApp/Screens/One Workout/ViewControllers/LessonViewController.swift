import Foundation
import UIKit
import AVFoundation

final class LessonViewController: ViewController<LessonView> {
    
    // MARK: - Properties.
    
    var workout: Workouts!
    var curent: Int!
    var timer: Timer!
    var seconds = 0
    var statistic: Statistic!
    
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
        if curent + 1 >= workout.lessons.count {
            ui.finishWorkoutButton.isHidden = false
            ui.nextButton.isHidden = true
        }
        if let time = self.workout.lessons[curent].time {
            seconds = time
            self.ui.timerLabel.text = time.times()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        //добавление обработки нажания на exerciseDescriptionView
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide)) // при нажатии на вью выполнить hide
        ui.exerciseDescriptionView.addGestureRecognizer(tap)
        
        // добавляем действие на кнопку подсказка
        ui.helpButton.addTarget(self, action: #selector(showHelp), for: .touchUpInside)
        
        // добавляем действие на кнопку пауза
        ui.pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)

        // добавляем действие на кнопку пропустить
        ui.nextButton.addTarget(self, action: #selector(toNext), for: .touchUpInside)
        
        // добавляем действие на кнопку finish
        ui.finishWorkoutButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //запуск аудио свисток в начале тренировки
        if let soundOn = UserDefaults.standard.object(forKey: "SoundOn") as? Bool, soundOn {
            loadAudio(name: "Свисток")
        }

        // добавляем таймер тренировки если тренировка в секундах
        startTimer()
    }

    // MARK: - Private Methods.

    private func startTimer() {
        if self.workout.lessons[curent].time != nil {
            ui.pauseButton.isHidden = false
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.ui.timerLabel.text = self.seconds.times()
                self.seconds -= 1
                if self.seconds <= 5 {
                    if let soundOn = UserDefaults.standard.object(forKey: "SoundOn") as? Bool, soundOn {
                        //запуск аудио тиканье
                        self.loadAudio(name: "audio")
                    }
                }
                if let soundOn = UserDefaults.standard.object(forKey: "SoundOn") as? Bool, soundOn {
                    if self.seconds == 0 {
                        if self.ui.finishWorkoutButton.isHidden {
                            //запуск аудио свисток в конце тренировки
                            self.loadAudio(name: "Свисток")
                        } else {
                            //запуск аудио гонг в конце всей тренировки
                            self.loadAudio(name: "Гонг")
                        }}
                }
                if self.seconds < 0 {
                    self.ui.timerLabel.text = "00:00"
                    if self.ui.finishWorkoutButton.isHidden {
                        self.gotToRelaxation()
                    } else {
                        self.finish()
                    }
                }

            }
        } else if let count = self.workout.lessons[curent].counts {
            ui.pauseButton.isHidden = true
            ui.timerLabel.text =  "x \(count)"
        }
    }
    /// отключение таймера, аудио дорожки и переход к окну отдых
    private func gotToRelaxation() {
        // если таймер запущен то выключить его
        if self.timer != nil {
            self.timer.invalidate()
        }
        // если аудио запущено тоо выключить его
        stopAudio()
        // переход на окно отдыха
        let vc = RelaxationViewController(workout: self.workout, curent: self.curent, statistic: self.statistic)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }

    // MARK: - User Interaction.
    
    @IBAction private func hide() {
        ui.exerciseDescriptionView.isHidden = true
    }
    
    @IBAction private func showHelp() {
        ui.exerciseDescriptionView.isHidden = false
    }

    @IBAction private func pause() {
        if timer != nil, timer.isValid {
            timer.invalidate()
            // если аудио запущено то выключить его
            stopAudio()
            ui.pauseButton.iconImageView.image = UIImage(named: "start")
            ui.pauseButton.nameLabel.text = "Старт"
        } else {
            startTimer()
            ui.pauseButton.iconImageView.image = UIImage(named: "пауза")
            ui.pauseButton.nameLabel.text = "Пауза"
        }
    }
    
    @IBAction private func toNext() {
        if self.workout.lessons[curent].time != nil {
            let alert = UIAlertController(title: nil, message: "Вы действительно хотите пропустить упражнениее?", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "ДА", style: UIAlertAction.Style.default, handler: {_ in
                self.gotToRelaxation()
            }))
            alert.addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel, handler: nil))

            self.present(alert, animated: true, completion: nil)
        } else {
            gotToRelaxation()
        }
    }
    
    @IBAction private func finish() {
        // если таймер запущен то выключить его
        if self.timer != nil {
            self.timer.invalidate()
        }
        // если аудио запущено тоо выключить его
        stopAudio()
        // go to finish screen
        let vc = FinishWorkoutViewController(workout: self.workout, curent: self.curent, statistic: self.statistic)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
