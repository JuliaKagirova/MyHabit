//
//  ProgressCollectionViewCell.swift
//  MyHabit
//
//  Created by Юлия Кагирова on 01.05.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    static let id = "ProgressCollectionViewCell"
    private var backgroudViewProgress: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var labelProgress:UILabel = {
        var label = UILabel()
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var progressBar: UIProgressView = {
        var view = UIProgressView(frame: .zero)
        view.progressTintColor = UIColor.purple
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var progress: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(backgroudViewProgress)
        backgroudViewProgress.addSubview(labelProgress)
        backgroudViewProgress.addSubview(progressBar)
        backgroudViewProgress.addSubview(progress)

        NSLayoutConstraint.activate([
            backgroudViewProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            backgroudViewProgress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroudViewProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroudViewProgress.widthAnchor.constraint(equalToConstant: 360),
            backgroudViewProgress.heightAnchor.constraint(equalToConstant: 60),

            labelProgress.topAnchor.constraint(equalTo: backgroudViewProgress.topAnchor, constant: 10),
            labelProgress.leadingAnchor.constraint(equalTo: backgroudViewProgress.leadingAnchor, constant: 12),
            labelProgress.trailingAnchor.constraint(equalTo: backgroudViewProgress.trailingAnchor, constant: -115),
            labelProgress.bottomAnchor.constraint(equalTo: backgroudViewProgress.bottomAnchor, constant: -32),
            
            progressBar.topAnchor.constraint(equalTo: labelProgress.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: backgroudViewProgress.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: backgroudViewProgress.trailingAnchor, constant: -12),
            
            progress.topAnchor.constraint(equalTo: backgroudViewProgress.topAnchor, constant: 10),
            progress.trailingAnchor.constraint(equalTo: backgroudViewProgress.trailingAnchor, constant: -12),
            progress.widthAnchor.constraint(equalTo: labelProgress.widthAnchor)
            
        ])
    }
    func updateCell(object: Float) {
        progressBar.progress = object
        labelProgress.text = String(format: "%.0f %%", object * 100)
    }
}
