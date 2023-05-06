//
//  CellModel.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 02.05.2023.
//

import UIKit

struct CellModel {
     
    let date: Date
    let isCheck: Bool
    
    init(date: Date, isCheck: Bool) {
        self.date = date
        self.isCheck = isCheck
    }
}
