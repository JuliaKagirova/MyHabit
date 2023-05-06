//
//  Delegate.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 06.05.2023.
//

import UIKit

protocol Delegate: AnyObject {
    
    func updateData()
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismissController(animated: Bool, completion: (() -> Void)?)
}
