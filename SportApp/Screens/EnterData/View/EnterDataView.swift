import UIKit
/// вью заполнение данных "Введите данные пользователя"
final class EnterDataView: UIView {
    
    // MARK: - UI Properties.
    
    /// заголовок
    private let titleLabel = UILabel().apply {
        $0.font = .squadHeavy
        $0.textColor = .black
        $0.text = "Введите данные пользователя"
        $0.numberOfLines = 0
    }
    
    /// кнопки Мужчина и Женщина
    let maleButton = GenderButton(title: "Мужчина", image: UIImage(named: "male"))
    let womanButton = GenderButton(title: "Женщина", image: UIImage(named: "female"))
    
    /// стек для кнопок м и ж
    private lazy var buttonStackView = UIStackView().apply {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 24
    }
    
    /// заголовок имя
    private let nameLabel = UILabel().apply { //созаем имя лэйбл 1
        $0.font = .footnoteRegular//задаем размер шрифта,толщину шрифта, стиль шрифта
        $0.textColor = .textLightGray
        $0.text = "Имя"//задаем содержание текста ИМЯ
        $0.numberOfLines = 0 //устанавливаем кол-во строк
    }
    
    /// поле ввода имя
    let nameTextField = BasicTextField(placeholder: "Введите ваше имя")

    /// вью со слайдером для ввода роста
    let heightView = SliderView(title: "Рост", smallImage: UIImage(named: "maleSmall"), bigImage: UIImage(named: "maleBig"), currency: "см", min: 100, max: 300)
    
    /// вью со слайдером для ввода веса
    let weightView = SliderView(title: "Вес", smallImage: UIImage(named: "maleMiniWeight"), bigImage: UIImage(named: "maleMaxiWeight"), currency: "кг", min: 20, max: 250)
    
    /// кнопка Далее
    let nextButton = UIButton().apply {
        $0.setImage(UIImage(named: "Next"), for: .normal)
        $0.backgroundColor = .black
    }
    
    /// кнопка Сохранить
    let saveButton = ImageTextButton(title: "Сохранить", imageBefore: nil, imageAfter: UIImage(named: "Save")).apply {
        $0.isHidden = true
    }
    
    /// скролл вью для маленьких экранов
    let scrollView = UIScrollView().apply {
        $0.backgroundColor = .white
        $0.bounces = false
    }
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        // скролл
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)// верх скрола до безопасного расположения на экране
            $0.applyWidth()
            $0.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.applyWidth(28)
        }
        
        buttonStackView.addArrangedSubviews([maleButton, womanButton])
        
        scrollView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.applyWidth(28)
            $0.height.equalTo(174)
        }
        
        scrollView.addSubview(nameLabel)// добавили констрейны лэйблу-Имя
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(14)//крепим верх до низа стэка
            $0.applyWidth(28) //крепим по краям
        }
        
        scrollView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.applyWidth(28)
            $0.height.equalTo(48)
        }
        //рост
        scrollView.addSubview(heightView)
        heightView.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
            $0.applyWidth(28)
        }
        //вес
        scrollView.addSubview(weightView)
        weightView.snp.makeConstraints {
            $0.top.equalTo(heightView.snp.bottom).offset(28)
            $0.applyWidth(28)
            $0.bottom.equalToSuperview().inset(86)
        }
        //кнопка далее
        scrollView.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom).offset(16)
            $0.right.equalTo(weightView.snp.right)
            $0.size.equalTo(70)
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom).offset(16)
            $0.right.equalTo(weightView.snp.right)
            $0.height.equalTo(70)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layoutSubviews().
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nextButton.layer.cornerRadius = 35
    }
}
