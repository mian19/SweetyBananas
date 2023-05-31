
import UIKit

extension Double {
    func adjustWidth() -> Double {
        let iPhone13_ProMaxScreenWidth = 428 / self
        return UIScreen.main.bounds.width / iPhone13_ProMaxScreenWidth
    }

}
