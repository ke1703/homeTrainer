import UIKit

final class WorkoutsView: UIView {
    
    // MARK: - UI Properties.

    /// заголовок тренировки
    private let titleLabel = UILabel().apply {
        $0.font = .squadHeavy
        $0.textColor = .black
        $0.text = "Тренировки"
        $0.textAlignment = .center
    }

    /// заголовок коллекции новичок
    private let beginnerTitleLabel = UILabel().apply {
        $0.font = .textBold20
        $0.textColor = .black
        $0.text = "Новичок"
    }

    /// коллекция новичок
    let beginnerCollectionView: UICollectionView = {
        let layout = CarouselCollectionViewFlowLayout(itemSize: CGSize(width: 234, height: 144), leftInset: 16, rightInset: 0, minLineSpacing: 16, space: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.clipsToBounds = false
        collectionView.register(WorkoutsCollectionViewCell.self)
        
        return collectionView
    }()

    /// заголовок коллекции "Продолжающий"
    private let continuingTitleLabel = UILabel().apply { // название - continuing
        $0.font = .textBold20
        $0.textColor = .black
        $0.text = "Продолжающий"
    }

    /// коллекция "Продолжающий"
    let continuingCollectionView: UICollectionView = {
        let layout = CarouselCollectionViewFlowLayout(itemSize: CGSize(width: 234, height: 144), leftInset: 16, rightInset: 0, minLineSpacing: 16, space: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.clipsToBounds = false
        collectionView.register(WorkoutsCollectionViewCell.self)
        
        return collectionView
    }()

    /// заголовок коллекции "Продвинутый"
    private let advancedTitleLabel = UILabel().apply { // название - advanced
        $0.font = .textBold20
        $0.textColor = .black
        $0.text = "Продвинутый"
    }

    /// коллекция "Продвинутый"
    let advancedCollectionView: UICollectionView = {
        let layout = CarouselCollectionViewFlowLayout(itemSize: CGSize(width: 234, height: 144), leftInset: 16, rightInset: 0, minLineSpacing: 16, space: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.clipsToBounds = false
        collectionView.register(WorkoutsCollectionViewCell.self)
        
        return collectionView
    }()

    /// скролл вью для маленьких экранов
    let scrollView = UIScrollView().apply {
        $0.backgroundColor = .white
        $0.bounces = false
    }
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(titleLabel)//заголовок тренировка
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.applyWidth(24)
        }
        /// скролл вью 
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.applyWidth()
            $0.bottom.equalToSuperview()
        }

        scrollView.addSubview(beginnerTitleLabel)// заголовок новичок
        beginnerTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.applyWidth(16)
        }

        scrollView.addSubview(beginnerCollectionView) //коллекция Новичок
        beginnerCollectionView.snp.makeConstraints {
            $0.top.equalTo(beginnerTitleLabel.snp.bottom).offset(16)
            $0.applyWidth()
            $0.height.equalTo(144)
        }
        
        scrollView.addSubview(continuingTitleLabel)//Продолжающий (заголовок)
        continuingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(beginnerCollectionView.snp.bottom).offset(22)
            $0.applyWidth(16)
        }

        scrollView.addSubview(continuingCollectionView)// коллекция Продолжающий - continuing
        continuingCollectionView.snp.makeConstraints {
            $0.top.equalTo(continuingTitleLabel.snp.bottom).offset(16)
            $0.applyWidth()
            $0.height.equalTo(144)
        }

        scrollView.addSubview(advancedTitleLabel)//advanced (заголовок)Продвинутый
        advancedTitleLabel.snp.makeConstraints {
            $0.top.equalTo(continuingCollectionView.snp.bottom).offset(22)
            $0.applyWidth(16)
        }

        scrollView.addSubview(advancedCollectionView)// коллекция Продвинутый - advanced
        advancedCollectionView.snp.makeConstraints {
            $0.top.equalTo(advancedTitleLabel.snp.bottom).offset(16)
            $0.applyWidth()
            $0.height.equalTo(144)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
