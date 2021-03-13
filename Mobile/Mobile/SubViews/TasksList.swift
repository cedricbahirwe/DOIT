//
//  TasksList.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import SwiftUI

struct TasksList: View {
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
        List(
            vm.isSearching ?
            vm.searchedEvents :
            vm.filteredTasks
        )
        { task in
            HStack(alignment: .top) {
                Image(systemName: task.isDone ? "checkmark.square.fill" : "checkmark.square")
                    .imageScale(.large)
                    .foregroundColor(.darkBlue)
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(task.title)
                            .font(.montSerrat(.bold))
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .rotationEffect(.radians(.pi/2))
                    }
                    Text(task.priority.rawValue)
                        .font(.montSerrat(.bold, size: 8))
                        .padding(.vertical, 4)
                        .frame(width: 60)
                        .foregroundColor(.white)
                        .background(task.priorityColor)
                        .clipShape(Capsule())
                    HStack {
                        Text("Created " + task.createDate.formatted)
                        Text("Modified " + task.modifiedDate.formatted)
                    }
                    .font(.montSerrat(.regular, size: 10))
                    .foregroundColor(.darkBlue)
                }
            }
            .blur(radius: task.isDone ?  0.5 : 0.0)
            .opacity(task.isDone ? 0.5 : 1.0)
            .contentShape(Rectangle())
            .onTapGesture {
                vm.selectedTask = task
                vm.goToTaskDetails.toggle()
            }
        }.listStyle(PlainListStyle())
    }
}

struct TasksList_Previews: PreviewProvider {
    static var previews: some View {
        TasksList()
            .environmentObject(MainViewModel())
    }
}
