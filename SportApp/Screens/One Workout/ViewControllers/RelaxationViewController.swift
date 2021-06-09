import Foundation
import UIKit
import AVFoundation

///  Экран ОТДЫХ
final class RelaxationViewController: ViewController<RelaxationView> {

    // MARK: - Properties.
    
    var workout: Workouts!
    var curent: Int!
    var timer: Timer!
    var seconds = 30
    var statistic: Statistic!
    
    // MARK: - Initialization.

    init(workout: Workouts, curent: Int, statistic: Statistic) {
        super.init(nibName: nil, bundle: nil)
        self.workout = workout
        self.curent = curent
        self.statistic = statistic

        hidesBottomBarWhenPushed = true
        if let relaxTime = UserDefaults.standard.object(forKey: "RelaxTime") as? Int {
            seconds = relaxTime
            ui.timerLabel.text = seconds.times()
        }

        ui.exerciseDescriptionView.configure(lesson: workout.lessons[curent], allCount: workout.lessons.count, currentCount: curent, isHideButtons: true)
        //нужно добавить обработку конца тренировки
        if curent + 1 >= workout.lessons.count {
            ui.grayView.isHidden = true
            timer = nil
        } else {
            ui.nextLessonNameLabel.text = workout.lessons[curent + 1].name
            var text = ""
            if let counts = workout.lessons[curent + 1].counts {
                text = "x \(counts)"
            }
            if let time = workout.lessons[curent + 1].time {
                text = "\(time.times())"
            }
            ui.descriptionNextLessonLabel.text = text
            ui.lessonsCountLabel.text = "Следующее \(curent + 2) из \(workout.lessons.count)"

            ui.exerciseDescriptionView.configure(lesson: workout.lessons[curent + 1], allCount: workout.lessons.count, currentCount: curent + 1, isHideButtons: true)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        // добавление обработки нажания на exerciseDescriptionView
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        // при нажатии на вью выполнить hide
        ui.exerciseDescriptionView.addGestureRecognizer(tap)
        // добавляем действие на кнопку пропустить
        ui.skipButton.addTarget(self, action: #selector(skipButton), for: .touchUpInside)
        // добавляем действие кнопке добавить 20 секунд
        ui.secondsButton.addTarget(self, action: #selector(secondsButton), for: .touchUpInside)
        // добавляем действие на кнопку помощь
        ui.helpButton.addTarget(self, action: #selector(watchHelp), for: .touchUpInside)
        //добавляем дейcтвие на кнопку "завершить тренировку"
        ui.finishWorkoutButton.addTarget(self, action: #selector (finish), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // добавляем таймер отдыха
        startTimer()
    }

    // MARK: - Private Methods.

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            self.ui.timerLabel.text = self.seconds.times()
            self.seconds -= 1
            if self.seconds <= 5,
               let soundOn = UserDefaults.standard.object(forKey: "SoundOn") as? Bool,
               soundOn {
                //запуск аудио тиканье
                self.loadAudio(name: "audio")
            }

            if self.seconds <= 0 {
                timer.invalidate()
                // переход к окну подготовки
                let vc = LessonViewController(workout: self.workout, curent: self.curent + 1, statistic: self.statistic)
                vc.modalPresentationStyle = .fullScreen
                self.stopAudio()
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
    //MARK: - User Interaction.

    // просмотр упражнения с интрукцией кнопка помощь --------
    @IBAction private func watchHelp() {
        ui.exerciseDescriptionView.isHidden = false
    }

    //добавление всплывающего окна при нажатии на кнопку помощь
    @IBAction private func hide() {
        ui.exerciseDescriptionView.isHidden = true
    }

    //skip -кнопка пропустить, при нажатии на кнопку, переходим к следующему упражнению
    @IBAction private func skipButton() {
        self.timer.invalidate()
        let vc = LessonViewController(workout: self.workout, curent: self.curent + 1, statistic: statistic)
        vc.modalPresentationStyle = .fullScreen
        self.stopAudio()
        self.present(vc, animated: false, completion: nil)
    }

    // добавление 20 секунд к отдыху
    @IBAction private func secondsButton() {
        seconds += 20
        stopAudio()
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
