

#if canImport(UIKit)
import UIKit

extension UIImage {
 
  @nonobjc public func resized(to newSize: CGSize, scale: CGFloat = 1) -> UIImage {
    let format = UIGraphicsImageRendererFormat.default()
    format.scale = scale
    let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
    let image = renderer.image { _ in
      draw(in: CGRect(origin: .zero, size: newSize))
    }
    return image
  }
}

#endif
