import UIKit

final class WorkoutsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties.
    
    /// название коллекции
    private let textLabel = UILabel().apply {
        $0.font = .textRegular24
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .center //текст в лэйбле по центру
    }
    
    /// приватная  картинка тренировки
    private let imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    /// приватная вью непрозрачного затемнения для названия коллекции
    private let view = UIView().apply {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.7)//непрозрачное затемнение
    }
    
    // MARK: - Initialization.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 24 //radius
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(view)
        view.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.applyWidth()
            $0.height.equalTo(40)//высота подложки?
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalToSuperview()
            $0.applyWidth()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration.
    
    //создаем функцию конфигурации ячейки, настройка внешнего вида
    func configure(name: String, image: UIImage?) {
        textLabel.text = name
        imageView.image = image
    }
}
