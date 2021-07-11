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
        case .time:
            name = "Test Time Screen"
        case .count:
            name = "Tests Number Screen"
        case .whenStudy:
            name = "When Study Screen"
        case .push:
            name = "Push Screen"
        case .widgets:
            name = "Widgets Screen"
        case .preloader:
            name = "Plan Preparing Screen"
        case .plan:
            name = "Personal Plan Screen"
        }
        
        SDKStorage.shared
            .amplitudeManager
            .logEvent(name: name, parameters: [:])
    }
}
