//
//  JustTextTableViewCell.swift
//  Form
//
//  Created by Arun Eswaramurthi on 07/07/20.
//  Copyright © 2020 Knila. All rights reserved.
//

import UIKit

class JustTextTableViewCell: UITableViewCell {
    static let reuseId = "JustTextTableViewCell"

    // MARK: - UIRelated
    private lazy var contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setConstraints()
    }
    
    private func setConstraints() {
        contentView.addSubview(contentLabel)
        
        let constraints = [
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .kTableCellPadding),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.kTableCellPadding),
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .kInternalPadding),
            contentLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -.kInternalPadding)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
	
	private var model: TextDisplayModel?
    
	func configure(_ model: TextDisplayModel) {
        if let model = model as? SimpleTextDisplayModel {
			contentLabel.text = model.textValue
        } else if let model = model as? AttrTextDisplayModel {
			contentLabel.attributedText = model.textValue
        }
        
		contentLabel.textAlignment = model.alignment
		self.model = model
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		if #available(iOS 13.0, *) {
			contentLabel.textColor = .label
		} else {
			contentLabel.textColor = .darkGray
		}
	}
}
