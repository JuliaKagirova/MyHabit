//
//  HabitCollectionViewCell3.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 01.05.2023.
//

import UIKit

class HabitCollectionViewCell3: UICollectionViewCell {
    static let id = "HabitCollectionViewCell3"

    private var backgroudView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var labelSleep:UILabel = {
        var label = UILabel()
        label.text = "Лечь спать до 23:00 и\n проснуться в 7:00"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var placeHolder:UILabel = {
        var label = UILabel()
        label.text = "Каждый день в 22:30"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var countLabel:UILabel = {
        var label = UILabel()
        label.text = "Счётчик: 4"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var colorCircle: UIButton = {
        var circle = UIButton()
        circle.backgroundColor = .clear
        circle.layer.borderColor = UIColor.systemIndigo.cgColor
        circle.layer.borderWidth = 1
        circle.layer.cornerRadius = 18
        circle.addTarget(HabitCollectionViewCell3.self, action: #selector(addHabit), for: .touchUpInside)
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(backgroudView)
        backgroudView.addSubview(labelSleep)
        backgroudView.addSubview(placeHolder)
        backgroudView.addSubview(countLabel)
        backgroudView.addSubview(colorCircle)

        NSLayoutConstraint.activate([
            backgroudView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 220),
            backgroudView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroudView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroudView.widthAnchor.constraint(equalToConstant: 360),
            backgroudView.heightAnchor.constraint(equalToConstant: 130),

            labelSleep.topAnchor.constraint(equalTo: backgroudView.topAnchor, constant: 20),
            labelSleep.leadingAnchor.constraint(equalTo: backgroudView.leadingAnchor, constant: 20),
            labelSleep.trailingAnchor.constraint(equalTo: backgroudView.trailingAnchor, constant: -100),
            labelSleep.bottomAnchor.constraint(equalTo: backgroudView.bottomAnchor, constant: -66),
            
            placeHolder.topAnchor.constraint(equalTo: labelSleep.bottomAnchor, constant: 4),
            placeHolder.leadingAnchor.constraint(equalTo: backgroudView.leadingAnchor, constant: 20),
            placeHolder.trailingAnchor.constraint(equalTo: backgroudView.trailingAnchor, constant: -206),
            placeHolder.bottomAnchor.constraint(equalTo: backgroudView.bottomAnchor, constant: -46),
            
            countLabel.topAnchor.constraint(equalTo: placeHolder.bottomAnchor, constant: 8),
            countLabel.leadingAnchor.constraint(equalTo: backgroudView.leadingAnchor, constant: 20),
            countLabel.bottomAnchor.constraint(equalTo: backgroudView.bottomAnchor,constant: -20),
            
            colorCircle.topAnchor.constraint(equalTo: backgroudView.topAnchor, constant: 47),
            colorCircle.trailingAnchor.constraint(equalTo: backgroudView.trailingAnchor, constant: -26),
            colorCircle.widthAnchor.constraint(equalToConstant: 36),
            colorCircle.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    @objc func addHabit(sender: UIButton) {
        // при нажатии должна появиться галочка в кружке, покраситься в синий и выйти окно правок
        colorCircle.backgroundColor = .systemIndigo
        colorCircle.setImage(UIImage(systemName: "checkmark"), for: .normal)

    }
}
