import UIKit

final class BirthView: BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let textFont = R.Fonts.interMedium(with: 16)
        static let imageLeading: CGFloat = 20
        static let birhLeading: CGFloat = 14
        static let yearsTrailing: CGFloat = -20
        
        enum View {
            static let widht: CGFloat = UIScreen.main.bounds.width
            static let height: CGFloat = 73.5
        }
        
        enum Line {
            static let top: CGFloat = 27.5
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let width: CGFloat = UIScreen.main.bounds.size.width - 32.0
            static let height: CGFloat = 0.5
        }
    }
    
    // MARK: - Views
    
    private let birthView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.View.widht,
                                                 height: Constants.View.height))
    private let starImageView = UIImageView()
    private let birthDataLabel = UILabel()
    private let yearsLabel = UILabel()
    private let dividingLine = UIView(frame: .zero)
    
    // MARK: - Initialization
    
    override func setup() {
        setupUI()
        setupConstraints()
    }
}

// MARK: - Set Data

extension BirthView {
    func setData(dateBirth: String, years: String) {
        self.birthDataLabel.text = "\(dateBirth)"
        self.yearsLabel.text = "\(years)"
    }
}

// MARK: - Private Methods

private extension BirthView {
    
    func setupUI() {
        starImageView.image = R.Images.Profile.start
        
        birthDataLabel.textColor = R.Colors.Text.active
        birthDataLabel.font = Constants.textFont
        
        yearsLabel.textColor = R.Colors.Text.inActive
        yearsLabel.font = Constants.textFont
        
        dividingLine.backgroundColor = R.Colors.separator
    }
    
    func setupConstraints() {
        [birthView, starImageView, birthDataLabel, yearsLabel, dividingLine].forEach { addSubview($0) }
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.centerYAnchor.constraint(equalTo: birthView.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageLeading)
        ])
        
        birthDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            birthDataLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            birthDataLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor,
                                                    constant: Constants.birhLeading)
        ])
        
        yearsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearsLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            yearsLabel.trailingAnchor.constraint(equalTo: birthView.trailingAnchor, constant: Constants.yearsTrailing)
        ])
        
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dividingLine.topAnchor.constraint(equalTo: yearsLabel.bottomAnchor, constant: Constants.Line.top),
            dividingLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Line.leading),
            dividingLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Line.trailing),
            dividingLine.widthAnchor.constraint(equalToConstant: Constants.Line.width),
            dividingLine.heightAnchor.constraint(equalToConstant: Constants.Line.height)
        ])
    }
}
