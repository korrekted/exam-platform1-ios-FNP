//
//  MediumVerticalRateView.swift
//  StatsWidgetsExtension
//
//  Created by Vitaliy Zagorodnov on 12.07.2021.
//

import WidgetKit
import SwiftUI

struct MediumVerticalRateView: View {
    @State var count: Int
    @State var title: String
    @State var color: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var titleColor: Color {
        colorScheme == .dark
            ? Color(red: 247 / 255, green: 250 / 255, blue: 255 / 255)
            : Color(red: 31 / 255, green: 31 / 255, blue: 31 / 255)
    }
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundColor(color)
            Spacer(minLength: 2)
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(titleColor)
        }
    }
}
