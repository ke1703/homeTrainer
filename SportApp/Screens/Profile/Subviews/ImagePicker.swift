import UIKit

final class ImagePicker: NSObject {
    
    // MARK: - Properties.
    
    /// приватное средство выбора изображения
    private let picker = UIImagePickerController()
    
    /// завершение выбора изображения
    private var completion: ((_ image: UIImage) -> Void)?
    
    // MARK: - Initialization.
    
    override init() {
        super.init()
        picker.mediaTypes = ["public.image"]
        picker.delegate = self
    }
    
    // MARK: - Public Methods.
    
    /// показ фото сделаное с камеры телефона
    func show(_ source: UIImagePickerController.SourceType, isFrontFacing: Bool = true, then completion: @escaping (_ image: UIImage) -> Void) {
        picker.sourceType = source
        if source == .camera {
            if isFrontFacing {
                picker.cameraDevice = .front
            }
            else {
                picker.cameraDevice = .rear
            }
        }
        
        self.completion = completion
        UIViewController.current()?.present(picker, animated: true, completion: nil)
    }
    
}
/// расширение, показ выбранной картинки
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        completion?(image)
        picker.dismiss(animated: true, completion: nil)
    }
    /// отмена выбранного изображения
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
