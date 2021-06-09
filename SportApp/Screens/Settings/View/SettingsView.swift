import UIKit

final class SettingsView: UIView {
    
    // MARK: - UI Properties.

    /// Заголовок Настройки
    private let titleLabel = UILabel().apply {
        $0.font = .squadHeavy
        $0.textColor = .black
        $0.text = "Настройки"
        $0.textAlignment = .center
    }

    /// перерыв между упражнениями, секунд
    let breakLabel = UILabel().apply {
        $0.font = .footnoteRegular
        $0.textColor = .textLightGray
        $0.text = "Перерыв между упражнениями, секунд"
    }
    
    /// для ввода времени в секундах
    let breakTextField = BasicTextField(placeholder: "Value").apply {
        $0.keyboardType = .numberPad
    }

    /// кнопка звуки "Звуки включены"
    let switchSounds = UISwitch().apply {
        $0.isOn = true
    }
    
    /// soundsLabel  Switch "Звуки включены"
    let soundsLabel = UILabel().apply {
        $0.font = .footnoteRegular
        $0.textColor = .textPrimary
        $0.text = "Звуки включены"
    }

    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        // Настройки
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(-38)
            $0.applyWidth(16)
        }
        // перерыв между упражнениями, секунд
        addSubview(breakLabel)
        breakLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.applyWidth(16)
        }
        // для ввода времени в секундах value
        addSubview(breakTextField)
        breakTextField.snp.makeConstraints {
            $0.top.equalTo(breakLabel.snp.bottom).offset(8)
            $0.applyWidth(16)
        }        
        // кнопка звуки "Звуки включены"
        addSubview(switchSounds)
        switchSounds.snp.makeConstraints {
            $0.top.equalTo(breakTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(16)
        }
        /// soundsLable  Switch "Звуки включены"
        addSubview(soundsLabel)
        soundsLabel.snp.makeConstraints {
            $0.centerY.equalTo(switchSounds.snp.centerY)
            $0.right.equalToSuperview().inset(16)
            $0.left.equalTo(switchSounds.snp.right).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
