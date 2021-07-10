//
//  OnboardingAnalytics.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 16.02.2021.
//

final class OnboardingAnalytics {
    func log(step: OnboardingView.Step) {
        let name: String
        
        switch step {
        case .welcome:
            name = "Welcome Screen"
        case .references:
            name = "References Screen"
        case .whenTaking:
            name = "When Exam Screen"
        case .goals:
            name = "Goals Screen"
        case .modes:
            name = "Modes Screen"
        case .slide6:
            name = "Level Screen"
        case .slide7:
            name = "Test Time Screen"
        case .slide8:
            name = "Tests Number Screen"
        case .slide9:
            name = "Improve Screen"
        case .slide14:
            name = "Plan Preparing Screen"
        case .slide15:
            name = "Personal Plan Screen"
        }
        
        SDKStorage.shared
            .amplitudeManager
            .logEvent(name: name, parameters: [:])
    }
}
