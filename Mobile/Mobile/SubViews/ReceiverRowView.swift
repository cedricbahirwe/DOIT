//
//  ReceiverRowView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 23/02/2021.
//

import SwiftUI

struct ReceiverRowView: View {
    var body: some View {
        HStack {
            Image("me-gray")
                .resizable()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
                .shadow(radius: 0.1)
            VStack(alignment: .leading, spacing:5) {
                Text("Cédric Bahirwe")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("This is a message from Fraterne Bahirwe.")
                    .font(.system(size: 14, weight: .light))
                    .lineLimit(3)
            }
            Spacer(minLength: 5)
        }
        .padding(8)
        .background(Color.senderBG)
    }
}

struct ReceiverRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverRowView()
    }
}
