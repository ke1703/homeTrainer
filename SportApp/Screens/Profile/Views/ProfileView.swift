import UIKit

final class ProfileView: UIView {
    
    // MARK: - UI Properties.
    
    /// профиль
    private let titleLabel = UILabel().apply {
        $0.font = .squadHeavy
        $0.textColor = .black
        $0.text = "Профиль"
        $0.textAlignment = .center
    }
    
    /// имя пользователя
    let nameLabel = UILabel().apply {
        $0.font = .textRegular
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    ///карандаш
    let editWeightButton = UIButton().apply {
        $0.setImage(UIImage(named: "free-icon-pencil-3094216"), for: .normal)
    }
    
    /// фото аватар avatarImageView
    let avatarImageView = UIImageView().apply {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 50
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorButton.cgColor
    }
    
    /// кнопка для фото
    let avatarButton = UIButton().apply {
        $0.setImage(UIImage(named: "icons8-unsplash-100 1"), for: .normal)
        $0.tintColor = .textBordo
        $0.layer.cornerRadius = 50
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorButton.cgColor
    }
    
    /// новичок
    let beginnerLabel = UILabel().apply {
        $0.font = .textRegular
        $0.textColor = .textBordo
        $0.textAlignment = .center
    }
    
    /// кнопки  (title: String?, color: UIColor?)
    let remindersButton = BasicButton(title: "Напоминания", color: .colorButton)
    let settingsButton = BasicButton(title: "Настройки", color: .colorButton)
    
    /// стек вью кнопок
    private lazy var buttonStackView = UIStackView().apply {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    /// добавляем скролл
    let scrollView = UIScrollView().apply {
        $0.backgroundColor = .white
        $0.bounces = false
    }
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        ///добавляем скролл
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.applyWidth()
        }
        // профиль
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.applyWidth(16)
        }
        // имя пользователя
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        //карандаш
        scrollView.addSubview(editWeightButton)
        editWeightButton.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.right).offset(16)
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.size.equalTo(25)
        }
        // фото аватар avatarImageView
        scrollView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        // кнопка аватар
        scrollView.addSubview(avatarButton)
        avatarButton.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        // новичок
        scrollView.addSubview(beginnerLabel)
        beginnerLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(24)
            $0.applyWidth(16)
        }
        /// добавили кнопки в стек
        buttonStackView.addArrangedSubviews([remindersButton , settingsButton])
        
        /// в скролл вью добаение стэка из кнопок
        scrollView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(beginnerLabel.snp.bottom).offset(44)
            $0.applyWidth(16)
            $0.height.equalTo(140)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layoutSubviews().
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 50
    }
}
