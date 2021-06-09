import UIKit
/// Экран Настройки
final class SettingsViewController: ViewController<SettingsView> {
    
    // MARK: - Initialization.
    
    init() {
        super.init(nibName: nil, bundle: nil)
        ui.switchSounds.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        setupToolbarAsAccessoryViewFor(textField: ui.breakTextField)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        if let soundOn = UserDefaults.standard.object(forKey: "SoundOn") as? Bool {
            ui.switchSounds.isOn = soundOn
        }
        
        if let seconds = UserDefaults.standard.object(forKey: "RelaxTime") as? Int {
            ui.breakTextField.text = String(seconds)
        }
    }
    
    // MARK: - User Interaction.
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        ui.soundsLabel.text = sender.isOn
            ? "Звуки включены"
            : "Звуки отключены"
        UserDefaults().set(sender.isOn, forKey: "SoundOn")
    }
    
    private func setupToolbarAsAccessoryViewFor(textField: UITextField) {
        textField.inputAccessoryView = nil
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.ui.frame.size.width, height: 44))
        let closeButton = UIBarButtonItem(title: "Записать", style:  .plain, target: self, action: #selector(closeInputView(button:)))
        closeButton.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        toolBar.items = [closeButton]
        toolBar.setItems([closeButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func closeInputView(button: UIBarButtonItem) {
        ui.breakTextField.endEditing(true)
        UserDefaults().set( Int(ui.breakTextField.text ?? "30") ?? 30, forKey: "RelaxTime")
    }
}
