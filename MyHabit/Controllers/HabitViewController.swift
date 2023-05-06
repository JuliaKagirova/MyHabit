//
//  HabitViewController.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 06.05.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    weak var delegate: Delegate?
    private var isNew: Bool { get { habitView.data.isNew } }
    private lazy var habitView: HabitView =  {
        var view = HabitView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    
    convenience init(data: HabitModel) {
        self.init()
        self.habitView.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = isNew ? "Создать" : "Править"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem?.tintColor = .purple
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem?.tintColor = .purple
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(habitView)
        NSLayoutConstraint.activate([
            habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func save() {
        if (isNew == false) {
            if let habit = habitView.data.getHabit() {
                habit.name = habitView.data.name
                habit.date = habitView.data.date
                habit.color = habitView.data.color
                HabitsStore.shared.save()
            }
        } else {
            HabitsStore.shared.habits.append(Habit(name: habitView.data.name, date: habitView.data.date, color: habitView.data.color, count: habitView.data.count))
        }
        delegate?.updateData()
        cancel()
    }
    
    @objc private func cancel() {
        let habitsVC = HabitsViewController()
        self.navigationController?.pushViewController(habitsVC, animated: true)
    }
}
 
extension HabitViewController: Delegate {
    
    func updateData() {
        delegate?.updateData()
    }
    
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
        delegate?.dismissController(animated: true, completion: nil)
    }
}

