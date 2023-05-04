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
            .foregroundColor(Color.accentColor)
    }
}

struct FormattedTime: View {
    var time: Date
    var body: some View {
        Text(time.formatted(date: .omitted, time: .shortened))
            .foregroundColor(Color.accentColor)
    }
}
