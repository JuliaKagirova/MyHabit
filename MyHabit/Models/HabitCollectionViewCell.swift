//
//  HabitCollectionViewCell.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 06.05.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: Delegate?
    private var data: HabitModel = HabitModel() {
        didSet {
            nameLabel.text = data.name
            nameLabel.textColor = data.color
            if let habit = data.getHabit() {
                dateLabel.text = habit.dateString
                updateCheckButton(habit: habit)
                updateDescriptionLabel(habit: habit)
            }
        }
    }
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var checkButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 3
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateCheckButton(habit: Habit) {
        if (habit.isAlreadyTakenToday != false) {
            checkButton.backgroundColor = habit.color
            checkButton.layer.borderColor = habit.color.cgColor
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            checkButton.backgroundColor = nil
            checkButton.layer.borderColor = habit.color.cgColor
            checkButton.setImage(nil, for: .normal)
        }
    }
    
    private func updateDescriptionLabel(habit: Habit) {
        descriptionLabel.text = "Счётчик: \(habit.trackDates.count)"
    }
    @objc private func checkHabit() {
        if let habit = data.getHabit(), habit.isAlreadyTakenToday == false {
            HabitsStore.shared.track(habit)
            delegate?.updateData()
        }
    }
}

extension HabitCollectionViewCell: CellProtocol {
    typealias CellType = HabitModel
    static var reuseId: String { String(describing: self) }
    
    func layoutUpdate() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        [nameLabel, dateLabel, descriptionLabel, checkButton].forEach { sub in
            contentView.addSubview(sub)
        }
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 36),
            checkButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
     
    func updateCell(object: HabitModel) { self.data = object }
}
