//
//  NewTaskView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 20/02/2021.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var options: [TaskPriority] = TaskPriority.allCases
    @State private var showDropDownOptions = false
    @State private var titleError = false
    @State private var imageError = false
    @State private var enableCreation = false
    @State private var showPickerOption = false
    
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
            
            VStack(alignment: .leading, spacing: 15) {
                Text(vm.isNewTask ? "New task" : "Update task ")
                    .font(.montSerrat(.bold, size: 24))
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Add Image")
                                    .font(.montSerrat(.bold, size: 12))
                                
                                if imageError {
                                    Text("This image is too large, the maximum size 2MB")
                                        .font(.montSerrat(.regular, size: 10))
                                        .foregroundColor(.red)
                                }
                            }
                            .onReceive(vm.validImage) { imageError = !$0 }
                            ZStack {
                                Color.lightenGray
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        showPickerOption.toggle()
                                    }
                                    .overlay(
                                        ZStack(alignment:vm.selectedTask.image == nil ? .center : .trailing ) {
                                            if let img = vm.selectedTask.image {
                                                Image(uiImage: img)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                
                                                HStack {
                                                    Button(action: {
                                                        showPickerOption.toggle()
                                                    }) {
                                                        Text("Change")
                                                            .font(.caption2)
                                                            .foregroundColor(.white)
                                                            .padding(.horizontal, 10)
                                                            .padding(.vertical , 5)
                                                            .background(Color.black.opacity(0.9))
                                                            .cornerRadius(3)
                                                            .padding(5)
                                                    }
                                                    Spacer()
                                                    Button(action: {
                                                        withAnimation {
                                                            vm.selectedTask.image = nil
                                                        }
                                                    }) {
                                                        Text("Delete")
                                                            .font(.caption2)
                                                            .foregroundColor(.red)
                                                            .padding(.horizontal, 10)
                                                            .padding(.vertical , 5)
                                                            .background(Color.black.opacity(0.9))
                                                            .cornerRadius(3)
                                                            .padding(5)
                                                    }
                                                }
                                                .frame(height: 100, alignment: .bottom)
                                                
                                            } else {
                                                Text("Tap to add Image")
                                                    .font(.montSerrat(.regular, size: 14))
                                            }
                                        }
                                    )
                                
                            }
                            .frame(height: 100)
                            .clipped()
                            .cornerRadius(3)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 1) {
                                Text("Title")
                                    .font(.montSerrat(.bold, size: 12))
                                if vm.selectedTask.title.count > 1 {
                                Text(": \(vm.selectedTask.title.count) characters")
                                    .font(.montSerrat(.regular, size: 10))
                                }
                                
                                if titleError {
                                    Text("This title is already taken.")
                                        .font(.montSerrat(.regular, size: 10))
                                        .foregroundColor(.red)
                                }
                            }
                            TextField("Task title (140 Characters)", text: $vm.selectedTask.title.onChange({ text in
                                if text.count > 140 {
                                    vm.selectedTask.title = String(text.prefix(140))
                                }
                            }))
                                .font(.montSerrat(.regular, size: 14))
                                .padding(.leading, 8)
                                .padding(.vertical, 10)
                                .background(Color.lightenGray)
                                .cornerRadius(3)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Description")
                                .font(.montSerrat(.bold, size: 12))
                            ZStack {
                                TextView(text: $vm.selectedTask.description)
                                    .font(.montSerrat(.regular, size: 14))
                                    .padding(.leading, 5)
                                    .frame(height: 70)
                                    .background(Color.lightenGray)
                                    .cornerRadius(3)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Priority")
                                .font(.montSerrat(.bold, size: 12))
                            
                            VStack(alignment: .leading) {
                                if showDropDownOptions {
                                    ForEach(0..<options.count) { index in
                                        Button(action: {
                                            vm.selectedTask.priority = options[index]
                                            withAnimation {
                                                showDropDownOptions.toggle()
                                            }
                                        }) {
                                            Text(options[index].rawValue)
                                                .font(.montSerrat(.bold, size: 14))
                                                .foregroundColor(.darkBlack)
                                                .padding(.leading, 5)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .frame(height: 30)
                                                .animation(nil)
                                        }
                                    }
                                } else {
                                    HStack {
                                        Text(vm.selectedTask.priority.rawValue)
                                            .font(.montSerrat(.bold, size: 14))
                                            .foregroundColor(.darkBlack)
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                            .padding(.vertical, 8)
                                        Spacer()
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .imageScale(.small)
                                            .padding()
                                            .foregroundColor(.darkBlack)
                                            .frame(width: 40, height: 36)
                                    }
                                    .padding(.leading, 5)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            showDropDownOptions.toggle()
                                        }
                                    }
                                }
                            }
                            .padding(.leading, 8)
                            .clipped()
                            .frame(height: showDropDownOptions ? 33.0*CGFloat(options.count) : 40, alignment: .leading)
                            .background(Color.lightenGray)
                            .cornerRadius(3)
                        }
                        
                        
                        HStack {
                            Button(action: {
                                if vm.isNewTask {
                                    vm.createTask()
                                    vm.selectedTask = TaskModel()
                                } else {
                                    vm.selectedTask.modifiedDate = Date()
                                    vm.updateTask()
                                }
                                presentationMode.wrappedValue.dismiss()
                                
                            }) {
                                Text(vm.isNewTask ? "CREATE TASK" : "UPDATE TASK")
                                    .font(.montSerrat(.bold, size: 10))
                                    .foregroundColor(Color(.systemBackground))
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 30)
                                    .background(Color.darkBlack)
                                    .cornerRadius(5)
                            }
                            .disabled(!enableCreation)
                            .opacity(enableCreation ? 1.0 : 0.5)
                            .onReceive(vm.enableTaskCreation) { enableCreation = $0 }
                            Spacer()
                        }
                        .padding(.top)
                    }
                }
            }
            .padding()
            .actionSheet(isPresented: $showPickerOption, content: {
                ActionSheet(
                    title: Text("Pick one option"),
                    message: nil,
                    buttons: [
                        .default(Text("Select from gallery"), action: vm.takePictureFromGallery),
                        .default(Text("Capture with camera"), action:  vm.takePictureFromCamera),
                        .destructive(Text("Cancel"))
                    ])
            })
            
        }
        .background(Color(.systemBackground).onTapGesture {
            print("got damn")
            hideKeyboard()
        })
        .onReceive(vm.invalidTitle) { titleError = $0 }
        .fullScreenCover(isPresented: $vm.showImagePicker) {
            ImagePicker(image: $vm.selectedTask.image, sourceType: $vm.imagePickerSourceType)
        }
        .onAppear {
            if vm.isNewTask {
                vm.selectedTask = TaskModel()
            }
        }
        .onDisappear {
            if vm.isNewTask == false {
                vm.isNewTask = true
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
            .environmentObject(MainViewModel())
        //            .environment(\.colorScheme, .dark)
    }
}

struct TextView: View {
    
    @Binding var text: String
    
    init(text: Binding<String>) {
        _text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        TextEditor(text: $text)
    }
}
