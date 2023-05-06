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
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProgressCollectionViewCell: CellProtocol {
    typealias CellType = Float
    static var reuseId: String { String(describing: self) }
    
    func layoutUpdate() {
        [backgroudViewProgress, labelProgress, progress, progressBar].forEach { sub in
            addSubview(sub)
        }
        NSLayoutConstraint.activate([
            backgroudViewProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroudViewProgress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroudViewProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroudViewProgress.widthAnchor.constraint(equalToConstant: 380),
            backgroudViewProgress.heightAnchor.constraint(equalToConstant: 60),
            
            labelProgress.topAnchor.constraint(equalTo: backgroudViewProgress.topAnchor, constant: 10),
            labelProgress.leadingAnchor.constraint(equalTo: backgroudViewProgress.leadingAnchor, constant: 12),
            labelProgress.trailingAnchor.constraint(equalTo: backgroudViewProgress.trailingAnchor, constant: -115),
            
            progress.topAnchor.constraint(equalTo: backgroudViewProgress.topAnchor, constant: 10),
            progress.leadingAnchor.constraint(equalTo: backgroudViewProgress.leadingAnchor, constant: 236),
            progress.trailingAnchor.constraint(equalTo: backgroudViewProgress.trailingAnchor, constant: -12),
            progress.bottomAnchor.constraint(equalTo: backgroudViewProgress.bottomAnchor, constant: -32),
            
            progressBar.topAnchor.constraint(equalTo: backgroudViewProgress.topAnchor, constant: 38),
            progressBar.leadingAnchor.constraint(equalTo: backgroudViewProgress.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: backgroudViewProgress.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: backgroudViewProgress.bottomAnchor, constant: -15),
            progressBar.widthAnchor.constraint(equalToConstant: 319),
            progressBar.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
    
    func updateCell(object: Float) {
        progressBar.progress = object
        progress.text = String(format: "%.0f %%", object * 100)
    }
}
