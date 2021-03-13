//
//  TaskModel.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Foundation
import SwiftUI

enum TaskPriority: String, CaseIterable {
    case low = "Low", medium = "Medium", high = "High"
}

struct TaskModel: Identifiable {
    var id = UUID()
    var title = ""
    var image: UIImage?
    var description = ""
    // CreateDate(date of creation of the todo item)
    var createDate = Date()
    // ModifiedDate(date of modification of the todo item)
    var modifiedDate = Date()
    // Priority (LOW, MEDIUM, HIGH)
    var priority: TaskPriority  = .medium
    var isDone: Bool = false
    
    var priorityColor: Color{
        switch priority {
        case .low: return .green
        case .medium: return .blue
        case .high: return .red
        }
    }
}

extension TaskModel {
    func convertToStoreable() -> StoredTaskModel {
        StoredTaskModel(
            id: id.description,
            title: title,
            image: image?.pngData(),
            description: description,
            createDate: createDate,
            modifiedDate: modifiedDate,
            priority: priority.rawValue,
            isDone: isDone
        )
    }
}

struct StoredTaskModel: Identifiable,  Codable {
    var id: String
    var title: String
    var image: Data?
    var description: String
    var createDate: Date
    var modifiedDate: Date
    var priority: String
    var isDone: Bool
    
    
}
extension StoredTaskModel {
    func convertToTask() -> TaskModel {
        TaskModel(
            id: UUID(uuidString: id)!,
            title: title,
            image: UIImage(data: image ?? Data()),
            description: description,
            createDate: createDate,
            modifiedDate: modifiedDate,
            priority: TaskPriority(rawValue: priority)!, isDone: isDone
        )
    }
}

struct TODOUserModel: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var role: String?
    var phoneNumber: String?
    var pin: Int?
    var avatar: Data?
    var name: String {
        firstName.trimmingCharacters(in: .whitespacesAndNewlines) + " " +  lastName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
