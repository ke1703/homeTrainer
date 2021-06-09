import UIKit

final class DatePickerViewController: ViewController<DatePickerView>, ModalDismissalDelegate {
    
    // MARK: - Injected Properties.
    
    private let safeAreaInsets: UIEdgeInsets
    private let handler: (Date) -> Void
    
    // MARK: - Properties.
    
    private var interactionController: UIPercentDrivenInteractiveTransition?
    
    // MARK: - Initialization.
    
    init(safeAreaInsets: UIEdgeInsets, selectedDate: Date?, mode: UIDatePicker.Mode, handler: @escaping (Date) -> Void) {
        self.safeAreaInsets = safeAreaInsets
        self.handler = handler
        super.init(nibName: nil, bundle: nil)

        ui.datePicker.date = selectedDate ?? Date()
        ui.datePicker.datePickerMode = mode
        
        if case .date = mode {
            ui.datePicker.minimumDate = Date()
        }

        modalPresentationStyle = .custom
        transitioningDelegate = self
        ui.dismissalDelegate = self
        
        ui.cancelButton.target = self
        ui.cancelButton.action = #selector(cancel)
        
        ui.cancelButton.target = self
        ui.doneButton.action = #selector(save)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - User Interaction.
    
    @objc
    private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func save() {
        dismiss(animated: true, completion: { [weak self] in
            guard let self = self else {
                return
            }
            
            let dateComponents = Calendar.current.dateComponents([ .year, .month, .day, .hour, .minute ], from: self.ui.datePicker.date)
            let date = Calendar.current.date(from: dateComponents)!
                    
            self.handler(date)
        })
    }
    
}

extension DatePickerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let preferredHeight = 40 + 216 + safeAreaInsets.bottom
        return BottomSheetAnimator(action: .present(preferredHeight: CGFloat(preferredHeight)))
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetAnimator(action: .dismiss)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}
