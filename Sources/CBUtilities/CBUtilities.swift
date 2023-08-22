import UIKit

struct CBUtilities {
    var text = "Hello, World!"
}

@IBDesignable
class DebuggingGridView: UIView {
    @IBInspectable var gridSpacing: CGSize = .zero {
        didSet { self.setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.darkGray.setStroke()
        guard self.gridSpacing != .zero else { return }

        let xCount = Int(rect.width/max(1, self.gridSpacing.width))
        let yCount = Int(rect.height/(max(1, self.gridSpacing.height)))
        let path = UIBezierPath()
        for i in 1..<xCount {
            path.move(toX: CGFloat(i)*self.gridSpacing.width, y: 0)
            path.move(toX: CGFloat(i)*self.gridSpacing.width, y: rect.height)

        }
        for i in 1..<yCount {
            path.move(toX: 0, y: CGFloat(i)*self.gridSpacing.height)
            path.move(toX: rect.width, y: CGFloat(i)*self.gridSpacing.height)
        }
        path.lineWidth = 1/UIScreen.main.scale

        path.stroke()

    }
}

extension UIAlertController {

    /// the action handlers are called after this method dismisses the alert controller
    public static func yesNoAlert(_ title: String, message: String, yes: @escaping ((UIAlertAction) -> Void), no: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in controller.dismiss(animated: true) { yes(action) } }
        let noAction = UIAlertAction(title: "No", style: .default) { action in controller.dismiss(animated: true) { no?(action) } }
        controller.addAction(noAction)
        controller.addAction(yesAction)
        return controller
    }
}

