//
//  HabitsViewController.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 24.04.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    private var labelToday: UILabel = {
        var label = UILabel()
        label.text = "Сегодня"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupCollectionView()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAdd))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupUI() {
        view.addSubview(labelToday)
        NSLayoutConstraint.activate([
            labelToday.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            labelToday.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14)
        ])
    }
    
    private func setupCollectionView() {
        layout = setupFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .systemGray6
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.id )
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.reuseId )
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        return layout
    }
    
    @objc private func buttonAdd() {
        let habitVC = HabitViewController(data: HabitModel())
        habitVC.delegate = self
        let habitNavigationViewController = UINavigationController(rootViewController: habitVC)
        self.navigationController?.pushViewController(habitVC, animated: true)
    }
    
    private func cancelButton() {
        dismiss(animated: true)
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.reuseId, for: indexPath)
            if let editCell = cell as? ProgressCollectionViewCell {
                editCell.updateCell(object: HabitsStore.shared.todayProgress)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.reuseId, for: indexPath)
            if let editCell = cell as? HabitCollectionViewCell {
                editCell.delegate = self
                let habit = HabitsStore.shared.habits[indexPath.item]
                editCell.updateCell(object: HabitModel(id: indexPath.item, name: habit.name, date: habit.date, color: habit.color, count: habit.count))
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            let habit = HabitsStore.shared.habits[indexPath.item]
            let habitVC = HabitVC(data: HabitModel(id: indexPath.item, name: habit.name, date: habit.date, color: habit.color, count: habit.count))
            habitVC.delegate = self
            navigationController?.pushViewController(habitVC, animated: true)
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    private func widthForSection(collectionViewWidth: CGFloat,
                                 numberOfItems: CGFloat,
                                 indent: CGFloat) -> CGFloat {
        return (collectionViewWidth - indent * (numberOfItems + 1)) / numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = widthForSection(collectionViewWidth: collectionView.frame.width, numberOfItems: 1, indent: 16)
        return indexPath.section == 0
        ? CGSize(width: width, height: 60)
        : CGSize(width: width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0
        ? 18
        : 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return section == 0
        ? UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        : UIEdgeInsets(top: 18, left: 16, bottom: 22, right: 16)
    }
} 

extension HabitsViewController: Delegate {
    
    func updateData() {
        collectionView.reloadData()
    }
    
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }
}
