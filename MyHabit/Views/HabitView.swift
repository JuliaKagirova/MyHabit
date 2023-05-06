//
//  HabitViewController.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 25.04.2023.
//

import UIKit

class HabitView: UIView {
    
    weak var delegate: Delegate?
    
    var data: HabitModel = HabitModel()
    {
        didSet {
            nameText.text = data.name
            colorButton.backgroundColor = data.color
            datePicker.date = data.date
            updateDateDescription()
            
            if (data.isNew) {
                nameText.becomeFirstResponder()
                delButton.removeFromSuperview()
            }
        }
    }
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nameText: UITextField = {
        var text = UITextField(frame: .zero)
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        text.addTarget(self, action: #selector(updateName(_:)), for: .editingChanged)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private lazy var colorLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text =  "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var colorButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(updateColor), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateDescriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var datePicker: UIDatePicker = {
        var picker = UIDatePicker(frame: .zero)
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(updateDate(_:)), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    private lazy var delButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(del), for: .touchUpInside)
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [nameLabel, nameText, colorLabel, colorButton, dateLabel, dateDescriptionLabel, datePicker, delButton].forEach {
            sub in
            addSubview(sub)
        }
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            nameText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            colorLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            dateDescriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            dateDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: dateDescriptionLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            delButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            delButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }
    
    private func updateDateDescription(){
        let baseStr = NSMutableAttributedString(string: "Каждый день в ",
                                                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        let dateStr = NSAttributedString(string: formatter.string(from: data.date),
                                         attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                                      NSAttributedString.Key.foregroundColor: UIColor.purple])
        baseStr.append(dateStr)
        dateDescriptionLabel.attributedText = baseStr
    }
    @objc private func updateName(_ textField: UITextField) {
        data.name = textField.text ?? ""
    }
    
    @objc private func updateColor() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = data.color
        picker.delegate = self
        delegate?.presentController(picker, animated: true, completion: nil)
    }
    
    @objc private func updateDate(_ datePicker: UIDatePicker) {
        if data.date != datePicker.date {
            data.date = datePicker.date
            updateDateDescription()
        }
    }
    
    @objc private func del() {
        weak var weakSelf = self
        let alert = UIAlertController(title: "Удалить привычку",
                                      message: "Вы хотите удалить привычку \"\(String(describing: data.name))\"?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
            if let index = weakSelf?.data.id { HabitsStore.shared.habits.remove(at: index) }
            weakSelf?.delegate?.dismissController(animated: true, completion: nil)
        }))
        delegate?.presentController(alert, animated: true, completion: nil)
    }
}

extension HabitView: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if data.color != viewController.selectedColor {
            data.color = viewController.selectedColor
            colorButton.backgroundColor = data.color
        }
    }
}
