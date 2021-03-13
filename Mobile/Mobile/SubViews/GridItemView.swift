//
//  GridItemView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import SwiftUI

struct GridItemView: View {
    let title: String
    let subtitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.montSerrat(.bold, size: 20))
                .foregroundColor(.petrol)
            Text(subtitle)
                .font(.montSerrat(.bold, size: 12))
                .lineLimit(1)
                .minimumScaleFactor(0.4)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
        .cornerRadius(3)
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        GridItemView(title: "Title", subtitle: "Subtitle")
    }
}
