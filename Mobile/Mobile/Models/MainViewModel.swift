//
//  MainViewModel.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    
    @Published var filterOption: TaskPriority? // = "All"
    @Published var selectedTask: TaskModel = TaskModel()
    @Published var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var showImagePicker = false
    @Published var isNewTask = true
    @Published var searchText: String = ""
    
    @Published var holderEvents: [TaskModel] = []
    
    @Published var searchedEvents: [TaskModel] = []
    @Published var isSearching = false
    
    @Published var goToTaskDetails: Bool = false


    
    var filteredTasks: [TaskModel]  {
        switch filterOption {
        case .low: return lowPriorities
        case .medium: return mediumPriorities
        case .high:  return highPriorities
        default: return tasks
        }
    }
    var lowPriorities: [TaskModel] {
        tasks.filter { $0.priority == .low }
    }
    var mediumPriorities: [TaskModel] {
        tasks.filter { $0.priority == .medium }
    }
    var highPriorities: [TaskModel] {
        tasks.filter { $0.priority == .high }
    }
    
    var totalTasks: Int {
        tasks.count
    }
    
    var activeTasks: Int {
        totalTasks - doneTasks
    }
    
    var doneTasks: Int {
        tasks.filter(\.isDone).count
    }
    
    var activeHighPriorityTasks: Int {
        tasks.filter({ $0.priority == .high  && !$0.isDone}).count
    }
    
    
    func validedImage(_ image: UIImage?) -> Bool {
        if let img = image {
            let imgData = Data(img.jpegData(compressionQuality: 1)!)
            let imageSize: Int = imgData.count
            return Double(imageSize) / 1000.0 <= 2_048
        }
        return true
    }
    
    var validImage: AnyPublisher<Bool, Never> {
        return $selectedTask
            .map({ self.validedImage($0.image) })
            .eraseToAnyPublisher()
    }
    
    /// Use CombineLatest to create a Publisher combining
    /// the output of two publishers
    var enableTaskCreation:AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3(invalidTitle, validInputField, validImage)
            .map {!$0 && $1 && $2}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    /// Publisher connected to title of selected Task @Published var
    /// that publish a Bool value to check if the title is valid
    var invalidTitle: AnyPublisher<Bool, Never> {
        return $selectedTask
            .map { selectedTask in self.tasks.contains(where: { task in task.title == selectedTask.title && self.isNewTask
                
            })}
            .eraseToAnyPublisher()
    }
    
    var validInputField: AnyPublisher<Bool, Never> {
        return $selectedTask
            .map {
                $0.description.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 &&
                    $0.title.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
                
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        loadStoredStasks()
    }
    
    
    func storeTasks() {
        if tasks.count > 0 {
            holderEvents = tasks
        }
    }
    
    func restoreTasks() {
        if holderEvents.count <= 0 {
            tasks = holderEvents
        }
    }
    
    
    func takePictureFromCamera() {
        imagePickerSourceType = .camera
        showImagePicker.toggle()
    }
    
    
    func takePictureFromGallery() {
        imagePickerSourceType = .photoLibrary
        showImagePicker.toggle()
    }
    
    func loadStoredStasks() {
        
        self.tasks = TODOSession.shared.storedTasks?.map{ $0.convertToTask() } ?? []
    }
    
    func storeAllTasks() {
        TODOSession.shared.storedTasks = tasks.map({ $0.convertToStoreable() })
    }
    
    func createTask() {
        self.tasks.append(selectedTask)
    }
    
    /// Delete a task
    /// - Parameter task: the task to be deleted
    func deleteTask() {
        if let index = tasks.firstIndex(where: { $0.id == selectedTask.id }) {
            self.tasks.remove(at: index)
        }
    }
    
    /// Update a task
    /// - Parameter task: the task to be updated
    func updateTask() {
        if let index = tasks.firstIndex(where: { $0.id == selectedTask.id }) {
            self.tasks[index] = selectedTask
        }
    }
    
    /// Finish a task
    /// - Parameter task: the task to be finished
    func finishTask() {
        if selectedTask.isDone == false {
            guard  let index =  tasks.firstIndex(where: { $0.id == selectedTask.id })  else { return }
            tasks[index].isDone = true
            //            selectedTask =  tasks[index]
        }
    }
}
