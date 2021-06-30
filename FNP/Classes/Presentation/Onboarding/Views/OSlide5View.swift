//
//  OSlide5View.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 24.01.2021.
//

import UIKit

final class OSlide5View: OSlideView {
    lazy var skipButton = makeSkipButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var datePickerView = makeDatePickerView()
    lazy var button = makeButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension OSlide5View {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.scale),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 49.scale : 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 134.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            datePickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePickerView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.scale),
            button.heightAnchor.constraint(equalToConstant: 60.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -70.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OSlide5View {
    func makeSkipButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.black)
            .font(Fonts.SFProRounded.semiBold(size: 13.scale))
            .letterSpacing(-0.6.scale)
            .lineHeight(20.scale)
        
        let view = UIButton()
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.black)
            .font(Fonts.SFProRounded.bold(size: 27.scale))
            .lineHeight(32.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Slide5.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDatePickerView() -> UIDatePicker {
        let minimumDate = Calendar.current.date(byAdding: .day, value: 6, to: Date()) ?? Date()
        
        let startDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        
        let view = UIDatePicker()
        view.backgroundColor = UIColor.clear
        view.minimumDate = minimumDate
        view.datePickerMode = .date
        view.date = startDate
        view.locale = Locale.current
        if #available(iOS 13.4, *) {
             view.preferredDatePickerStyle = .wheels
        }
        view.setValue(Appearance.mainColor, forKeyPath: "textColor")
        view.datePickerMode = .countDownTimer
        view.datePickerMode = .date
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProRounded.semiBold(size: 20.scale))
            .lineHeight(23.scale)
            .textAlignment(.center)
        
        let view = UIButton()
        view.backgroundColor = Appearance.mainColor
        view.layer.cornerRadius = 30.scale
        view.setAttributedTitle("Onboarding.Proceed".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
