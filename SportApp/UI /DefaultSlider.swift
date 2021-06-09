import SnapKit
import UIKit

final class DefaultSlider: UISlider {

    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)

        setThumbImage(UIImage(named: "Toggle"), for: .normal)
        minimumTrackTintColor = .black
        maximumTrackTintColor = .sliderGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 8
        return newBounds
    }
    
    private func thumbRect() -> CGRect {
        let trackRect = self.trackRect(forBounds: self.bounds)
        let thumbRect = self.thumbRect(forBounds: self.bounds, trackRect: trackRect, value: self.value)
        return thumbRect
    }
   
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let percent = Float(touch.location(in: self).x / bounds.size.width)
        let delta = percent * (maximumValue - minimumValue)
        
        let newValue = minimumValue + delta
        self.setValue(newValue, animated: false)
        super.sendActions(for: .valueChanged)
        return true
    }
}
