import UIKit
import AVFoundation

class ViewController<UI: UIView>: UIViewController {

    // MARK: - UI Properties.

    var audioPlayer = AVAudioPlayer()
    internal let ui = UI()

    // MARK: - Lifecycle.

    override func loadView() {
        view = ui
    }
    
    // Загрузка аудио из файла
    func loadAudio(name: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!))
            audioPlayer.play()
        } catch {
            print("фаил \(name) не загрузился")
        }
    }

    func stopAudio() {
        audioPlayer.stop()
    }
    
}
