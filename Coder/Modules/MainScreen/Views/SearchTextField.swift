import UIKit

class SearchTextField: UITextField {

    public let rightImageButton = UIButton(frame: .zero)

    private var insets: UIEdgeInsets

    init(inset: UIEdgeInsets) {
        self.insets = inset
        super.init(frame: .zero)

        let leftImage = UIImageView(frame: .zero)
        leftImage.image = UIImage(named: "Vector")
        leftImage.image = leftImage.image?.withRenderingMode(.alwaysTemplate)
        leftImage.tintColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        self.leftViewMode = .always
        self.leftView = leftImage

        rightImageButton.setImage(UIImage(named: "list-ui-alt"), for: .normal)
        rightImageButton.setImage(UIImage(named: "list-ui-alt_selected"), for: .selected)
        self.rightViewMode = .always
        self.rightView = rightImageButton

        self.layer.backgroundColor = CGColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 0
        self.placeholder = "Введите имя, тег, почту.."
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
         bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         bounds.inset(by: insets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         bounds.inset(by: UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 30))
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: bounds.width - 20 - 13.5,
                      y: bounds.height / 2 - 10,
                      width: 20,
                      height: 20)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: 14, y: bounds.height / 2 - 10, width: 20, height: 20)
    }

}
