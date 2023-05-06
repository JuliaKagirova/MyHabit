//
//  CellProtocol.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 06.05.2023.
//

import UIKit

protocol CellProtocol {
    
    associatedtype CellType
    
    static var reuseId: String { get }
    
    func layoutUpdate()
    func updateCell(object: CellType)
}
