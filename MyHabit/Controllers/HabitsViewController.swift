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
    
    func setupCollectionView() {
        layout = setupFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.id )
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.id )
        collectionView.register(HabitCollectionViewCell2.self, forCellWithReuseIdentifier: HabitCollectionViewCell2.id )
        collectionView.register(HabitCollectionViewCell3.self, forCellWithReuseIdentifier: HabitCollectionViewCell3.id )
        collectionView.register(HabitCollectionViewCell4.self, forCellWithReuseIdentifier: HabitCollectionViewCell4.id )
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }
    
    @objc private func buttonAdd() {
        let habitVC = HabitViewController()
        self.navigationController?.pushViewController(habitVC, animated: true)
    }
    
    func cancelButton() {
        dismiss(animated: true)
    }
}

extension HabitsViewController: UICollectionViewDelegate {
    
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProgressCollectionViewCell.self)", for: indexPath) as? ProgressCollectionViewCell else { fatalError() }
            return cell
        } else if indexPath.row == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HabitCollectionViewCell.self)", for: indexPath) as? HabitCollectionViewCell else { fatalError() }
            return cell
        } else if indexPath.row == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HabitCollectionViewCell2.self)", for: indexPath) as? HabitCollectionViewCell2 else { fatalError() }
            return cell
        } else if indexPath.row == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HabitCollectionViewCell3.self)", for: indexPath) as? HabitCollectionViewCell3 else { fatalError() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HabitCollectionViewCell4.self)", for: indexPath) as? HabitCollectionViewCell4 else { fatalError() }
            return cell
        }
    }
}

