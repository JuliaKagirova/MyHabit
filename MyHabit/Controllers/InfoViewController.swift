//
//  InfoViewController.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 24.04.2023.
//

import UIKit

class InfoViewController: UIViewController, UIScrollViewDelegate {
    
    private var label: UILabel = {
        var label = UILabel()
        label.text = "Привычка за 21 день"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var descriptionName: UILabel = {
        var label = UILabel()
        label.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n\n 1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n\n 2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n\n 3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.\n\n 4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n\n 5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n\n 6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 16
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        scrollView.center = view.center
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: 300, height: 800)
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.scrollsToTop = true
        return scrollView
    }()
  
    override func viewDidLoad() {
        view.backgroundColor = .white
        self.title = "Информация"
        setupLabel()
        setupUI()
        descriptionName.frame.size = scrollView.contentSize
        scrollView.contentOffset = CGPoint(x: 150, y: 150)
    }
    
    private func setupLabel() {
        scrollView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        ])
    }
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionName)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            descriptionName.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16)
        ])
    }
}



