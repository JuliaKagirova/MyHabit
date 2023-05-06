//
//  HabitVC.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 06.05.2023.
//

import UIKit

class HabitVC: UIViewController {
    
    weak var delegate: Delegate?
    private var data: HabitModel
    private lazy var editButton: UIBarButtonItem = {
        var button = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(edit))
        button.tintColor = UIColor.purple
        return button
    }()
    private lazy var backButton: UIBarButtonItem = {
        var button = UIBarButtonItem(title: "Сегодня", style: .done, target: self, action: #selector(back))
        button.tintColor = UIColor.purple
        return button
    }()
    private lazy var tableView: UITableView =  {
        var table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.reuseId)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(data: HabitModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = data.name
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = editButton
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func edit() {
        let habitViewController = HabitViewController(data: data)
        habitViewController.delegate = self
        let habitNavigationViewController = UINavigationController(rootViewController: habitViewController)
        navigationController?.present(habitNavigationViewController, animated: true, completion: nil)
    }
    
    @objc private func back() {
        let habitsVC = HabitsViewController()
        self.navigationController?.pushViewController(habitsVC, animated: true)
    }
}

extension HabitVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "АКТИВНОСТЬ"}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { HabitsStore.shared.dates.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.reuseId, for: indexPath)
        if let editCell = cell as? HabitTableViewCell, let index = data.id {
            let habit = HabitsStore.shared.habits[index]
            let date = HabitsStore.shared.dates.sorted(by: { $0.compare($1) == .orderedDescending })[indexPath.row]
            let isCheck = HabitsStore.shared.habit(habit, isTrackedIn: date)
            editCell.updateCell(object: CellModel(date: date, isCheck: isCheck))
        }
        return cell
    }
}
 
extension HabitVC: Delegate {
    func updateData() {
        data.updateData()
        title = data.name
        delegate?.updateData()
    }
    
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        delegate?.updateData()
        navigationController?.popViewController(animated: true)
    }
}


