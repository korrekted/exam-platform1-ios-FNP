//
//  BottomView.swift
//  FNP
//
//  Created by Vitaliy Zagorodnov on 11.07.2021.
//

import UIKit

class BottomView: UIView {
    
    lazy var bottomButton = makeBottomButton()
    lazy var gradientView = makeGradientView()
    lazy var stackView = makeStackView()
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
}

// MARK: Public
extension BottomView {
    func setup(state: TestBottomButtonState) {
        switch state {
        case .confirm:
            bottomButton.setAttributedTitle("Question.Continue".localized.attributed(with: Self.buttonAttr), for: .normal)
        case .submit:
            bottomButton.setAttributedTitle("Question.Submit".localized.attributed(with: Self.buttonAttr), for: .normal)
        case .back:
            bottomButton.setAttributedTitle("Question.BackToStudying".localized.attributed(with: Self.buttonAttr), for: .normal)
        case .hidden:
            break
        }
        
        bottomButton.isHidden = state == .hidden
        
    }
    
    static func height(for state: TestBottomButtonState) -> CGFloat {
        sizingView.setup(state: state)
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        return sizingView.systemLayoutSizeFitting(size, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
    }
}

// MARK: Private
private extension BottomView {
    static let sizingView = BottomView()
    
    func initialize() {
        backgroundColor = .clear
        [gradientView, stackView, bottomButton].forEach(addSubview)
        stackView.addArrangedSubview(bottomButton)
    }
    
    static let buttonAttr = TextAttributes()
        .font(Fonts.SFProRounded.regular(size: 20.scale))
        .lineHeight(23.scale)
        .textColor(.white)
        .textAlignment(.center)
}

// MARK: Make constraints
private extension BottomView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 71.scale),
            stackView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 26.scale),
            stackView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -26.scale),
            stackView.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -36.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension BottomView {
    func makeBottomButton() -> UIButton {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30.scale
        view.backgroundColor = Appearance.mainColor
        view.heightAnchor.constraint(equalToConstant: 60.scale).isActive = true
        return view
    }
    
    func makeGradientView() -> UIView {
        let view = UIView()
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(integralRed: 241, green: 244, blue: 251).cgColor]
        gradientLayer.locations = [0, 0.65]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        view.layer.mask = gradientLayer
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeStackView() -> UIStackView {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
