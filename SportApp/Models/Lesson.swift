import UIKit
/// модель упражнения
struct Lesson {
    /// название
    let name: String
    /// время сколько выполнять если есть
    let time: Int?
    /// количество повторений если есть
    let counts: Int?
    /// описание упраженения
    let text: String
    /// картинка упраженения большая
    let imageBig: UIImage?
    /// картинка упраженения маленькая
    let imageSmall: UIImage?
}
