//
//  MediumRateWidget.swift
//  StatsWidgetsExtension
//
//  Created by Andrey Chernyshev on 01.07.2021.
//

import WidgetKit
import SwiftUI

struct MediumRateWidget: Widget {
    let placeholder = StatsContent(date: Date(),
                                   passRate: 50,
                                   testTaken: 0,
                                   testsTakenNum: 0,
                                   correctAnswers: 0,
                                   correctAnswersNum: 0,
                                   questionsTaken: 0,
                                   answeredQuestions: 0)
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "SmallRateWidget", provider: Provider(placeholder: placeholder)) { entry in
            VStack(alignment: .leading) {
                Text("Widgets.PassRate".localized)
                    .font(.system(size: 19.scale))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 76 / 255, green: 99 / 255, blue: 130 / 255))
                Spacer()
                Text(String(format: "%.0f%%", min(entry.passRate / 100, 1.0) * 100.0))
                    .font(.system(size: 42.scale))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 224 / 255, green: 117 / 255, blue: 140 / 255))
                Spacer(minLength: 10.scale)
                LineProgressView(progress: entry.passRate / 100,
                                 color: Color(red: 224 / 255, green: 117 / 255, blue: 140 / 255))
                    .frame(height: 6.scale)
            }
            .padding(16)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Widgets.Small.Name".localized)
        .description("Widgets.Small.Description".localized)
    }
}
