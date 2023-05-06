//
//  HabitTableViewCell.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 06.05.2023.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var checkImage: UIImageView = {
        var image = UIImageView()
        image.tintColor = UIColor.purple
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUpdate() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(checkImage)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: checkImage.leadingAnchor, constant: -240),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:-10),
            dateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 22),
            
            checkImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            checkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            checkImage.heightAnchor.constraint(equalToConstant: 44),
            checkImage.widthAnchor.constraint(equalToConstant: 26)
        ])
    }
}
 
extension HabitTableViewCell: CellProtocol {
    typealias CellType = CellModel
    static var reuseId: String { String(describing: self) }
    
    func updateCell(object: CellModel) {
        var dateStr: String?
        if (Calendar.current.isDateInToday(object.date)) { dateStr = "Сегодня" }
        else if (Calendar.current.isDateInYesterday(object.date)) { dateStr = "Вчера" }
        else {
            let currentDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date())
            let inDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: object.date)
            if (currentDateComponents.year == inDateComponents.year &&
                currentDateComponents.month == inDateComponents.month &&
                (currentDateComponents.day ?? 0) - (inDateComponents.day ?? 0) == 2) {
                dateStr = "Позавчера"
            } else {
                if let indexDate = HabitsStore.shared.dates.lastIndex(of: object.date) {
                    dateStr = HabitsStore.shared.trackDateString(forIndex: indexDate)
                }
            }
        }
        dateLabel.text = dateStr
        if (object.isCheck) {
            checkImage.image = UIImage(systemName: "check")
        }
    }
}
