//
//  ReminderCell.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import UIKit
import PinLayout

class ReminderCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private lazy var descriptionLabel: UILabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private lazy var createdDateLabel: UILabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.layer.opacity = 0.5
        $0.sizeToFit()
    }
    
    private lazy var endDateLabel: UILabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.layer.opacity = 0.5
        $0.sizeToFit()
    }
    
    private lazy var completedImage: UIImageView = UIImageView().apply {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.contentMode = .scaleToFill
        $0.isUserInteractionEnabled = true
        $0.clipsToBounds = true
    }
    
    var makeCompleted: ((Reminders) -> Void)?
    var reminderModel: Reminders!
    
    // MARK: - Life Cycle
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        layout()
        setupViews()
    }
    
    private func addSubviews() {
        [titleLabel,
         completedImage,
         descriptionLabel,
         createdDateLabel,
         endDateLabel].forEach({ contentView.addSubview($0) })
    }
    
    // MARK: - Configure Cell
    
    public func configure(model: Reminders) {
        self.reminderModel = model
        titleLabel.text = model.title
        descriptionLabel.text = model.desc
        createdDateLabel.text = "Создано: " + DateFormatHelper.getString(from: model.createdDate ?? .now) + " в \(DateFormatHelper.getTimeString(from: model.createdDate ?? .now))"
        endDateLabel.text = "Завершение: " + DateFormatHelper.getString(from: model.endDate ?? .now)
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        completedImage.layer.cornerRadius = completedImage.frame.size.width / 2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeComplete))
        completedImage.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    
    @objc private func makeComplete() {
        makeCompleted?(reminderModel)
    }
    
    // MARK: - Layout
    
    private func layout() {
        completedImage.pin
            .top(12)
            .left(20)
            .size(24)
        
        titleLabel.sizeToFit()
        titleLabel.pin
            .vCenter(to: completedImage.edge.vCenter)
            .after(of: completedImage).marginLeft(8)
            .right(20)
        
        descriptionLabel.sizeToFit()
        descriptionLabel.pin
            .top(to: titleLabel.edge.bottom).margin(6)
            .left(to: completedImage.edge.right).margin(8)
            .right(20)
        
        descriptionLabel.sizeToFit()
        createdDateLabel.pin
            .top(to: descriptionLabel.edge.bottom).margin(6)
            .left(to: completedImage.edge.right).margin(8)
            .right(20)
            .height(20)
        
        endDateLabel.sizeToFit()
        endDateLabel.pin
            .top(to: createdDateLabel.edge.bottom).margin(6)
            .left(to: completedImage.edge.right).margin(8)
            .right(20)
            .bottom(5)
    }
}
