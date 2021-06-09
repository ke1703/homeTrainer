import UIKit

final class DatePickerView: UIView {
    
    // MARK: - UI Properties.
    
    let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: nil)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: nil)
    
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.white
        toolbar.backgroundColor = UIColor.black
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        return toolbar
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00)
        datePicker.locale = Locale.init(identifier: "ru_RU")
        datePicker.minuteInterval = 1
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        return datePicker
    }()
    
    // MARK: - Properties.
    
    weak var dismissalDelegate: ModalDismissalDelegate?
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00)
        
        addSubview(toolbar)
        toolbar.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
        }
        
        addSubview(datePicker)
        datePicker.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Hit Test.
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else {
            dismissalDelegate?.dismiss(animated: true, completion: nil)
            return nil
        }
        
        return view
    }
    
}
