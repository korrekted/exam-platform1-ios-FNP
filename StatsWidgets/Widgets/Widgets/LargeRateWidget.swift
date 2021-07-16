//
//  LargeRateWidget.swift
//  StatsWidgetsExtension
//
//  Created by Andrey Chernyshev on 13.07.2021.
//

import SwiftUI
import WidgetKit

struct LargeRateWidget: Widget {
    let placeholder = StatsContent(date: Date(),
                                   passRate: 75,
                                   testTaken: CGFloat(80) / 100,
                                   testsTakenNum: 0,
                                   correctAnswers: CGFloat(76) / 100,
                                   correctAnswersNum: 0,
                                   questionsTaken: CGFloat(94) / 100,
                                   answeredQuestions: 0)
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "LargeRateWidget", provider: Provider(placeholder: placeholder)) { entry in 
            VStack(alignment: .leading) {
                ZStack() {
                    PassRateView(title: "Widgets.PassRate".localized,
                                 progressFontSize: 19.scale,
                                 progress: entry.passRate / 100,
                                 titleColor: Color(red: 247 / 255, green: 250 / 255, blue: 255 / 255),
                                 progressColor: Color(red: 247 / 255, green: 250 / 255, blue: 255 / 255))
                        .padding(EdgeInsets(top: 8.scale, leading: 16.scale, bottom: 0, trailing: 16.scale))
                }
                .cornerRadius(22.scale)
                .background(Color(red: 224 / 255, green: 117 / 255, blue: 140 / 255))
                Spacer()
                HorizontalRateView(progress: entry.testTaken,
                                   title: "Widgets.TestsTaken".localized,
                                   titleColor: Color(red: 19 / 255, green: 24 / 255, blue: 42 / 255),
                                   progressColor: Color(red: 76 / 255, green: 99 / 255, blue: 130 / 255))
                    .padding(EdgeInsets(top: 4.scale, leading: 16.scale, bottom: 4.scale, trailing: 16.scale))
                Spacer()
                HorizontalRateView(progress: entry.correctAnswers,
                                   title: "Widgets.CorrectAnswers".localized,
                                   titleColor: Color(red: 19 / 255, green: 24 / 255, blue: 42 / 255),
                                   progressColor: Color(red: 224 / 255, green: 117 / 255, blue: 140 / 255))
                    .padding(EdgeInsets(top: 4.scale, leading: 16.scale, bottom: 4.scale, trailing: 16.scale))
                Spacer()
                HorizontalRateView(progress: entry.questionsTaken,
                                   title: "Widgets.QuestionsTaken".localized,
                                   titleColor: Color(red: 19 / 255, green: 24 / 255, blue: 42 / 255),
                                   progressColor: Color(red: 226 / 255, green: 114 / 255, blue: 75 / 255))
                    .padding(EdgeInsets(top: 4.scale, leading: 16.scale, bottom: 16.scale, trailing: 16.scale))
            }
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName("Widgets.Large.Name".localized)
        .description("Widgets.Large.Description".localized)
    }
}
