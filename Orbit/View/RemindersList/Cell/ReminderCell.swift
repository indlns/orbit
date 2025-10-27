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
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private lazy var descriptionLabel: UILabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private lazy var dateLabel: UILabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.layer.opacity = 0.5
        $0.sizeToFit()
    }
    
    private lazy var completedImage: UIImageView = UIImageView().apply {
        $0.image = UIImage(named: "completed")
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.contentMode = .scaleToFill
    }
    
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
         dateLabel].forEach({ contentView.addSubview($0) })
    }
    
    // MARK: - Configure Cell
    
    public func configure(model: Reminders) {
        setupCompletedToDo(completed: model.isDone, text: model.title ?? "")
        descriptionLabel.text = model.desc
        dateLabel.text = model.date ?? "9999"
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        completedImage.layer.cornerRadius = completedImage.frame.size.width / 2
        completedImage.clipsToBounds = true
    }
    
    private func setupCompletedToDo(completed: Bool, text: String) {
        if completed {
            titleLabel.attributedText = NSAttributedString(
                string: text,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.gray
                ]
            )
        } else {
            titleLabel.attributedText = NSAttributedString(string: text)
        }
        completedImage.image = completed == true ? UIImage(named: "completed") : UIImage(systemName: "cirle")
        completedImage.layer.borderColor = completed == true ? UIColor.yellow.cgColor : UIColor.gray.cgColor
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
        dateLabel.pin
            .top(to: descriptionLabel.edge.bottom).margin(6)
            .left(to: completedImage.edge.right).margin(8)
            .right(20)
            .bottom(12)
    }
}
