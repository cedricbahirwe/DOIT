//
//  UpdateTaskView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import SwiftUI

struct UpdateTaskView: View {
    @EnvironmentObject var vm : MainViewModel
    var body: some View {
        NewTaskView()
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskView()
    }
}
