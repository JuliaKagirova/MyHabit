//
//  HabitViewController.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 25.04.2023.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    private var labelName: UILabel = {
        var label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var textField: UITextField = {
        var field = UITextField()
        field.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        field.textColor = .systemBlue
        field.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private var habitName: String = ""
    private var selectedTime: UIDatePicker!
    private var labelColor: UILabel = {
        var label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var labelTime: UILabel = {
        var label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var colorCircle: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    private var labelEveryDay: UILabel = {
        var label = UILabel()
        label.text = "Каждый день в " //+ dateFormatter.string(from: labelWhatTime)
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var labelWhatTime : Date = {
        var date = Date()
        // поместить на экран
        // покрасить в purple
//        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    private var delete: UIButton = {
        var button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .light)
        button.addTarget(nil, action: #selector(deleteButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var screenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var colorPicker: UIColorPickerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(colorCircleTapped))
        colorCircle.addGestureRecognizer(tapGestureRecognizer)
        self.title = "Создать"
        view.backgroundColor = .white
        setupUI()
        
        textField.delegate = self
        
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 50, y: 300, width: self.view.frame.width, height: 200)
        datePicker.timeZone = NSTimeZone.local
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(HabitViewController.datePickerValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(datePicker)

        let safeButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(tapSafeButton))
        safeButton.tintColor = .purple
        navigationItem.rightBarButtonItem = safeButton
        let dismissButton = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(tapDismissButton))
        dismissButton.tintColor = .purple
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    @objc func tapSafeButton() {
        let newHabit = Habit(name: "\(String(describing: textField.text))",
                             date: Date(),
                             color: .systemRed)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        
        
//        let infoVC = InfoViewController()
//        present(infoVC, animated: true, completion: nil) // модальное окно?
        
    }
    @objc func tapDismissButton() {
        let habitsVC = HabitsViewController()
        self.navigationController?.pushViewController(habitsVC, animated: true)
//        navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        view.addSubview(screenScrollView)
        [labelName, textField, labelColor, labelTime, delete, labelEveryDay,  //labelWhatTime,
         colorCircle].forEach {
            subs in view.addSubview(subs)
        }
        NSLayoutConstraint.activate([
            screenScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            screenScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            screenScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            screenScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            labelName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            labelName.leadingAnchor.constraint(equalTo: screenScrollView.leadingAnchor),

            textField.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 7),
            textField.leadingAnchor.constraint(equalTo: screenScrollView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -65),

            labelColor.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            labelColor.leadingAnchor.constraint(equalTo: screenScrollView.leadingAnchor),

            colorCircle.topAnchor.constraint(equalTo: labelColor.bottomAnchor, constant: 7),
            colorCircle.leadingAnchor.constraint(equalTo: screenScrollView.leadingAnchor),
            colorCircle.widthAnchor.constraint(equalToConstant: 30),
            colorCircle.heightAnchor.constraint(equalToConstant: 30),

            labelTime.topAnchor.constraint(equalTo: labelColor.bottomAnchor, constant: 52),
            labelTime.leadingAnchor.constraint(equalTo: screenScrollView.leadingAnchor),
            
            delete.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            delete.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 114),
            delete.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -113),
                        
            labelEveryDay.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 7),
            labelEveryDay.leadingAnchor.constraint(equalTo: screenScrollView.leadingAnchor),
//            labelEveryDay.trailingAnchor.constraint(equalTo: labelWhatTime.leadingAnchor, constant: -8),
//
//            labelWhatTime.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 7),
//            labelWhatTime.leadingAnchor.constraint(equalTo: labelEveryDay.trailingAnchor, constant: 4),
//            labelWhatTime.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -150)
        ])

    }
    @objc private func deleteButton() {
        let alert = UIAlertController(
            title: "Удалить привычку",
            message: "Вы хотите удалить привычку \(textField.text!)?",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {action in print("Yes") } ))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: {action in self.cancelButton(); print("No") } ))
        self.present(alert, animated: true)
            
    }
    func cancelButton() {
        dismiss(animated: true)
    }
    @objc func buttonPressed(sender: UIButton) {
        print(habitName)
    }
    
    @objc func habitNameChanged(_textField: UITextField) {
        labelName.text! = textField.text!
        print("Habit changed to \(labelName.text!)")
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            screenScrollView.contentOffset.y = keyboardSize.height - (screenScrollView.frame.height - delete.frame.minY)
            screenScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardHide(notification: NSNotification) {
        screenScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    @objc private func colorCircleTapped() {
        present(colorPicker, animated: true, completion: nil)
    }

    @objc func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorCircle.backgroundColor = viewController.selectedColor
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker){

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
//
//         lazy var dateFormatter: DateFormatter = {
//            let formatter = DateFormatter()
//            formatter.locale = Locale(identifier: "ru_RU")
//            formatter.timeStyle = .short
//            return formatter
//        }()
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        print("Выбранное время \(selectedDate)")
//        labelWhatTime. = "\(String(describing: selectedDate))"
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

