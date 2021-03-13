//
//  HeaderView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 22/02/2021.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()

            }, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                    .frame(width: 35, height: 32, alignment: .leading)
                    .foregroundColor(Color(.label))
            })
            
            Spacer()
        }
        .padding(10)
        .background(Color(.systemBackground).ignoresSafeArea(.all, edges: .top))
        .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 1)
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.fixed(width: 400, height: 60))
    }
    
}
