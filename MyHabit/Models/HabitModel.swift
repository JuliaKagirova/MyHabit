//
//  HabitModel.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 02.05.2023.
//

import UIKit

struct HabitModel {
    
    let id: Int?
    var name: String
    var date: Date
    var color: UIColor
    var count: Int
    var isNew: Bool { get { id == nil }}
    
    init() {
        self.id = nil
        self.name = ""
        self.date = Date()
        self.color = .orange
        self.count = Int()
    }
    
    init(name: String, date: Date, color: UIColor, count: Int) {
        self.id = nil
        self.name = name
        self.date = date
        self.color = color
        self.count = count
    }
    
    init(id: Int, name: String, date: Date, color: UIColor, count: Int) {
        self.id = id
        self.name = name
        self.date = date
        self.color = color
        self.count = count
    }
    
    func getHabit() -> Habit? {
        guard let index = id else {
            return nil
        }
        return HabitsStore.shared.habits[index]
    }
    
    mutating func updateData() {
        guard let habit = getHabit() else {
            return
        }
        
        self.name = habit.name
        self.date = habit.date
        self.color = habit.color
        self.count = habit.count
    }
}
