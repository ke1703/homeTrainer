import Foundation
import UIKit

final class TimeCountView: UIView {
    
    // MARK: - UI Properties.
    
    /// картинка с часиками
    private let imageViewTime = UIImageView().apply {
        $0.image = UIImage(named: "Time")
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.black.cgColor
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }

    /// лэйбл для отображения количества тренировок
    let titleLabelNumber = UILabel().apply {
        $0.font = .textMedium16
        $0.textColor = .black
    }

    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        // констрейны imageViewTime
        addSubview(imageViewTime)
        imageViewTime.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(20)//когда ширина и высота равны
        }
        // констрейны для titleLabelNumber
        addSubview(titleLabelNumber)
        titleLabelNumber.snp.makeConstraints {
            $0.width.equalTo(225)
            $0.left.equalTo(imageViewTime.snp.right).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
