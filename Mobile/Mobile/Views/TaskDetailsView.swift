//
//  TaskDetailsView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: MainViewModel
    @State private var showDeleteView = false
    @State private var showUpdateView = false
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HeaderView()
                Image(uiImage: vm.selectedTask.image ?? UIImage(named: "abc-logo")!)
                    .renderingMode(vm.selectedTask.image == nil ? .template : .original)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: size.width-10, maxHeight: size.height/3)
                    .clipped()
                    .zIndex(-10)
                
                HStack {
                    Text(vm.selectedTask.priority.rawValue)
                        .font(.montSerrat(.bold, size: 10))
                        .padding(.vertical, 5)
                        .frame(width: 65)
                        .foregroundColor(.white)
                        .background(vm.selectedTask.priorityColor)
                        .clipShape(Capsule())
                    Spacer()
                    
                    if vm.selectedTask.isDone == false {
                        HStack {
                            Button(action: {
                                vm.isNewTask = false
                                showUpdateView.toggle()
                            }, label: {
                                Image(systemName: "pencil")
                                    .frame(width: 30, height: 30)
                                    .background(Color.lightenGray)
                                    .cornerRadius(3)
                            })
                            .sheet(isPresented: $showUpdateView) {
                                UpdateTaskView()
                            }
                            Button(action: {
                                showDeleteView = true
                            }, label: {
                                Image(systemName: "plus")
                                    .rotationEffect(.radians(.pi/4))
                                    .frame(width: 30, height: 30)
                                    .background(Color.lightenGray)
                                    .cornerRadius(3)
                            })
                            
                            Button(action: {
                                vm.finishTask()
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("DONE")
                                    .font(.montSerrat(.bold, size: 14))
                                    .frame(width: 100, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.darkBlue, lineWidth: 1.5)
                                    )
                            }
                        }
                        .foregroundColor(.darkBlue)
                        .font(.montSerrat(.bold, size: 14))
                    } else {
                        Button(action: {
                            showDeleteView.toggle()
                        }, label: {
                            Text("Delete")
                                .font(.montSerrat(.bold, size: 10))
                                .padding(.vertical, 5)
                                .frame(width: 70)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Capsule())
                        })
                        
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(vm.selectedTask.title)
                        .font(.montSerrat(.bold, size: 23))
                        .fontWeight(.black)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(.montSerrat(.bold, size: 14))
                        Text(vm.selectedTask.description)
                            .font(.montSerrat(.regular, size: 14))
                            .padding(.leading, 5)
                        
                        VStack(alignment: .leading) {
                            Text("Created at: " + vm.selectedTask.createDate.formatted)
                                .font(.montSerrat(.regular, size: 14))
                                .padding(.leading, 5)
                            Text("Modified at: " + vm.selectedTask.modifiedDate.formatted)
                                .font(.montSerrat(.regular, size: 14))
                                .padding(.leading, 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                Spacer()
            }
            
            
            VStack(spacing: 10) {
                VStack(spacing: 2) {
                    Text("Do you want to delete this task?")
                        .font(.montSerrat(.bold, size: 16))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    
                    Text("This task will be deleted. This action cannot be undone.")
                        .font(.montSerrat(.regular, size: 10))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    Divider()
                    Button(action: {
                        showDeleteView = false
                        vm.deleteTask()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Delete")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                    })
                }
                .padding([.top])
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .cornerRadius(8)
                .neumorphismShadow(3)
                
                HStack {
                    Button(action: {
                        showDeleteView = false
                    }, label: {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                    })
                    
                }
                .background(Color.background)
                .cornerRadius(8)
                .neumorphismShadow(3)
                .padding(.bottom, 10)
            }
            .animation(Animation.spring(response: 0.5, dampingFraction: 0.7))
            .padding(10)
            .offset(y: showDeleteView ? 0 : 400)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView()
            .environmentObject(MainViewModel())
    }
}
