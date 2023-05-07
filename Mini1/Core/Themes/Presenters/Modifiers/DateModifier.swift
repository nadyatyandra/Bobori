//
//  DateModifier.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import SwiftUI

struct FormattedDate: View {
    var date: String
    var body: some View {
        Text(date)
            .font(Font.custom("Nunito ExtraLight", size: 32))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.leading)
            .padding(.top, -250)
            .padding(.leading, -10)
            .bold()
    }
}

struct FormattedTime: View {
    var time: Date
    var body: some View {
        Text(time.formatted(date: .omitted, time: .shortened))
            .font(Font.custom("Comfortaa", size: 18))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.leading)
            .padding(.leading, 10)
        
    }
}
