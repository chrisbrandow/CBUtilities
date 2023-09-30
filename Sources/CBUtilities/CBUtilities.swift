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

public struct StoryboardID {
//    public enum Error: Swift.Error {
//        case notFound(StoryboardID)
//    }

    public let name: String
    public let instanceIdentifier: String?
    public let bundle: Bundle?

    public init(name: String, instanceIdentifier: String?, bundle: Bundle? = nil) {
        self.name = name
        self.instanceIdentifier = instanceIdentifier
        self.bundle = bundle
    }
}

public protocol StoryBoardInstantiatable: UIViewController {
    static var storyboardID: StoryboardID { get }
    static func instantiate() -> Self?
}

//extension StoryboardID.Error: ErrorReportable {
//    public var reportingProperties: [String: String?]? {
//        switch self {
//        case let .notFound(id):
//            return ["name": id.name,
//                    "instanceIdentifier": id.instanceIdentifier,
//                    "bundle": id.bundle?.name]
//        }
//    }
//}

extension StoryBoardInstantiatable {

    public static func instantiate() -> Self? {
        let storyboard = UIStoryboard(name: self.storyboardID.name, bundle: self.storyboardID.bundle)
        let vc: UIViewController?
        if let vcID = self.storyboardID.instanceIdentifier {
            vc = storyboard.instantiateViewController(withIdentifier: vcID)
        } else {
            vc = storyboard.instantiateInitialViewController()
        }

        guard let result = vc as? Self else {
//            ServiceLocator.shared.errorService?.track(StoryboardID.Error.notFound(self.storyboardID))
            return nil
        }

        return result
    }

    public static func instantiateWithNavigationController() -> (navigationController: UINavigationController, viewController: Self)? {
        guard let controller = Self.instantiate() else { return nil}
        let navigationController = UINavigationController(rootViewController: controller)
        return (navigationController, controller)
    }
}

public extension StoryboardID {
    var storyboard: UIStoryboard { UIStoryboard(name: self.name, bundle: self.bundle) }

//    /// Instantiates an instance of the view controller referenced by this storyboard ID, delegating initialization to
//    /// the provided closure.
//    ///
//    /// This allows for classes instantiated by UIStoryboard to have custom initizers i.e. to provide required properties.
//    ///
//    /// In this example, we can make `foo` a non-optional property:
//    ///
//    /// ```
//    ///    static func instantiate(foo: Int) -> Self? {
//    ///        self.storyboardID.instantiate { coder in
//    ///            self.init(coder: coder, foo: foo)
//    ///        }
//    ///    }
//    ///
//    ///    required init?(coder: NSCoder, foo: Int) {
//    ///        self.foo = foo
//    ///        super.init(coder: coder)
//    ///    }
//    /// ```
//    @MainActor
//    func instantiate<ViewController>(creator: @escaping (NSCoder) -> ViewController?) -> ViewController? where ViewController: UIViewController {
//
//        let maybeVC: ViewController?
//        if let identifier = self.instanceIdentifier {
//            maybeVC = self.storyboard.instantiateViewController(identifier: identifier, creator: creator)
//        } else {
//            maybeVC = self.storyboard.instantiateInitialViewController(creator: creator)
//        }
//
//        guard let vc = maybeVC else {
//            let error = StoryboardID.Error.notFound(self)
//            ServiceLocator.shared.errorService?.track(error)
//            return nil
//        }
//
//        return vc
//    }
}
