//
//  OSlideModesView.swift
//  FNP
//
//  Created by Andrey Chernyshev on 10.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class OSlideModesView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var fullSupportCell = makeCell(image: "Onboarding.Modes.Cell1",
                                        title: "Onboarding.Modes.Cell1.Title",
                                        subtitle: "Onboarding.Modes.Cell1.Subtitle",
                                        tag: 0)
    lazy var withoutExplanationsCell = makeCell(image: "Onboarding.Modes.Cell2",
                                                title: "Onboarding.Modes.Cell2.Title",
                                                subtitle: "Onboarding.Modes.Cell2.Subtitle",
                                                tag: 1)
    lazy var examStyleCell = makeCell(image: "Onboarding.Modes.Cell3",
                                      title: "Onboarding.Modes.Cell3.Title",
                                      subtitle: "Onboarding.Modes.Cell3.Subtitle",
                                      tag: 2)
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var profileManager = ProfileManagerCore()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OSlideModesView {
    func initialize() {
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }

                guard let mode = [
                    self.fullSupportCell,
                    self.withoutExplanationsCell,
                    self.examStyleCell
                ]
                .first(where: { $0.isSelected })?
                .tag else {
                    return .never()
                }
                
                return self.profileManager
                    .set(testMode: mode)
                    .map { true }
                    .catchAndReturn(false)
            }
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] success in
                guard success else {
                    Toast.notify(with: "Onboarding.FailedToSave".localized, style: .danger)
                    return
                }

                self?.onNext()
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func selected(tapGesture: UITapGestureRecognizer) {
        guard let cell = tapGesture.view as? OModeCell else {
            return
        }
        
        [
            fullSupportCell,
            withoutExplanationsCell,
            examStyleCell
        ].forEach { $0.isSelected = false }
        
        cell.isSelected = true
    }
}

// MARK: Make constraints
private extension OSlideModesView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 134.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            fullSupportCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            fullSupportCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            fullSupportCell.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 44.scale)
        ])
        
        NSLayoutConstraint.activate([
            withoutExplanationsCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            withoutExplanationsCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            withoutExplanationsCell.topAnchor.constraint(equalTo: fullSupportCell.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            examStyleCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            examStyleCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            examStyleCell.topAnchor.constraint(equalTo: withoutExplanationsCell.bottomAnchor, constant: 12.scale)
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
private extension OSlideModesView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.black)
            .font(Fonts.SFProRounded.bold(size: 27.scale))
            .lineHeight(32.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Modes.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(image: String,
                  title: String,
                  subtitle: String,
                  tag: Int) -> OModeCell {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selected(tapGesture:)))
        
        let view = OModeCell()
        view.tag = tag
        view.imageView.image = UIImage(named: image)
        view.title = title.localized
        view.subtitle = subtitle.localized
        view.isSelected = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProRounded.semiBold(size: 20.scale))
            .textAlignment(.center)
        
        let view = UIButton()
        view.backgroundColor = Appearance.mainColor
        view.layer.cornerRadius = 30.scale
        view.setAttributedTitle("Onboarding.Proceed".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
