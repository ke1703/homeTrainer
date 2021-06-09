import UIKit

final class AddItemTVCell: UITableViewCell {
    
    // MARK: - UI Properties.
    
    let checkMarkButton = UIButton().apply {
        $0.tintColor = .textBordo
        $0.setImage(UIImage(named: "icon_plus"), for: .normal)

        $0.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
    }

    let addTextLabel = UILabel().apply {
        $0.font = .textRegular
        $0.textColor = .textBordo
        $0.textAlignment = .left
    }

    let textField = UITextField().apply {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.keyboardType = .default
        $0.textColor = .black
        $0.tintColor = .black
        $0.attributedPlaceholder = NSAttributedString(string: "Новое уведомление",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])
    }
    let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: nil)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

    let doneButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: nil)
        barButtonItem.isEnabled = false

        return barButtonItem
    }()

    let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.white
        toolbar.backgroundColor = UIColor.black
        toolbar.setBackgroundImage(UIImage(),
                                   forToolbarPosition: .any,
                                   barMetrics: .default)
        toolbar.setShadowImage(UIImage(),
                               forToolbarPosition: .any)

        return toolbar
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ checkMarkButton, addTextLabel, textField ])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 12

        return stackView
    }()

    // MARK: - Injected Properties.
    
    weak var delegate: CreationDelegate?
    var state: State = .notification

    // MARK: - Initialization.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalTo(self).offset(14)
            $0.top.bottom.equalTo(self).inset(8)
            $0.trailing.equalTo(self).inset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure.

    func configure(state: AddItemTVCell.State) {
        addTextLabel.text = state.title
        textField.placeholder = state.placeholderText
    }

    func configure(edited: Bool) {
        addTextLabel.isHidden = edited
        textField.isHidden = !edited
        checkMarkButton.isHidden = edited
        if edited {
            textField.becomeFirstResponder()
        } else {
            textField.text = nil
            doneButton.isEnabled = false
        }
    }
    
    func configure(kind: State) {
        self.state = kind
        configure(state: kind)
        
        if kind != .notification {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAdd))
            addTextLabel.isUserInteractionEnabled = true
            addTextLabel.addGestureRecognizer(gesture)
            checkMarkButton.addTarget(self, action: #selector(tapAdd), for: .touchUpInside)

            textField.delegate = self
            cancelButton.target = self
            doneButton.target = self
            cancelButton.action = #selector(cancel)
            doneButton.action = #selector(done)
        }
    }

    func configure(isEditing: Bool) {
        configure(edited: isEditing)
    }
    
    // MARK: - User Interaction.
    
    @objc
    func tapAdd() {
        if state != .notification {
            configure(edited: true)
        }
    }
    
    @objc
    private func cancel() {
        configure(edited: false)
        self.endEditing(true)
    }
    
    @objc
    private func done() {
        guard let name = textField.text, name.count > 0 else {
            return
        }
        
        delegate?.addItem(named: name)
        textField.text = ""
    }
}

extension AddItemTVCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text ?? "") + string
        doneButton.isEnabled = newText != ""
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        done()
        return true
    }
}

extension AddItemTVCell {
    enum State {
        case notification
        
        // MARK: - Computed Properties.

        var title: String {
            switch self {
            case .notification:
                return "Добавить напоминание"
            }
        }
        
        var placeholderText: String {
            switch self {
            case .notification:
                return "Новое напомнинание"
            }
        }
    }
}
