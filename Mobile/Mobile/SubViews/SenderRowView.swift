//
//  SenderRowView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 23/02/2021.
//

import SwiftUI

struct SenderRowView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing:5) {
                Text("Cédric Bahirwe")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("This is a message from Fraterne Bahirwe.")
                    .font(.system(size: 14, weight: .light))
                    .lineLimit(3)
            }
            Spacer(minLength: 5)
            Image("me-edit")
                .resizable()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
                .shadow(radius: 0.1)
        }
        .padding(8)
        .background(Color.receiverBG)
    }
}

struct SenderRowView_Previews: PreviewProvider {
    static var previews: some View {
        SenderRowView()
    }
}
