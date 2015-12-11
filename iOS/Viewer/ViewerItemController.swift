import UIKit

protocol ViewerItemControllerDelegate: class {
    func viewerItemControllerDidTapItem(viewerItemController: ViewerItemController, completion: (() -> ())?)
}

class ViewerItemController: UIViewController {
    weak var controllerDelegate: ViewerItemControllerDelegate?

    var viewerItem: ViewerItem? {
        didSet {
            if let photo = viewerItem as? Photo {
                self.label.text = String(photo.id ?? 0)
                self.imageView.image = photo.image
            }
        }
    }

    var index = 0

    lazy var label: UILabel = {
        let label = UILabel(frame: UIScreen.mainScreen().bounds)
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        label.font = UIFont.systemFontOfSize(80)
        label.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

        return label
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.clearColor()
        view.contentMode = .ScaleAspectFit
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.userInteractionEnabled = true

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.label)
        self.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tapAction")
        self.view.addGestureRecognizer(tapRecognizer)
    }

    func tapAction() {
        self.controllerDelegate?.viewerItemControllerDidTapItem(self, completion: nil)
    }
}