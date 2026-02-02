//
//  TimeCapsule.swift
//  Sentinelle
//
//  Created by Sebby on 05/12/2024.
//

import Foundation
import SwiftData

@Model
class TimeCapsule: Identifiable {
    @Attribute(.unique) var id: UUID
    var message: String
    var creationDate: Date
    var openDate: Date
    var isOpened: Bool = false
    
    init(message: String, openDate: Date) {
        self.id = UUID()
        self.message = message
        self.creationDate = Date.now
        self.openDate = openDate
    }
    
    
}
