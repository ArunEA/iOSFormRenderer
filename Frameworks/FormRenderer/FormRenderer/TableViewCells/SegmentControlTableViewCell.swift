//
//  SegmentControlTableViewCell.swift
//  Form
//
//  Created by Arun Eswaramurthi on 07/10/20.
//  Copyright © 2020 Knila. All rights reserved.
//

import UIKit

protocol SegmentCellDelegate: class {
	func segmentTapped(key: String, _ value: String)
}

class SegmentControlTableViewCell: UITableViewCell {
    
    static let reuseId = "SegmentSelectionTableViewCell"
    
    weak var delegate: SegmentCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Individual", "Company"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.layer.cornerRadius = 5.0
        segmentControl.clipsToBounds = true
        segmentControl.tintColor = #colorLiteral(red: 1, green: 0.3411764706, blue: 0.2, alpha: 1)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.3411764706, blue: 0.2, alpha: 1)], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        if #available(iOS 13.0, *) {
            segmentControl.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.3411764706, blue: 0.2, alpha: 1)
        }
        
        segmentControl.addTarget(self, action: #selector(segmentTapped(sender:)), for: .valueChanged)
        self.contentView.addSubview(segmentControl)
        
        return segmentControl
    }()
	
	private var model: SegmentControlModel?
	
	func configure(_ model: SegmentControlModel) {
		self.segmentControl.removeAllSegments()
		self.model = model
		
		if let selectedItem = self.model?.selectedItem, let index = model.items.firstIndex(of: selectedItem) {
			segmentControl.selectedSegmentIndex = index
		}
		
		var index = 0
		model.items.forEach { (item) in
			self.segmentControl.insertSegment(withTitle: item, at: index, animated: false)
			index += 1
		}
	}
    
    @objc func segmentTapped(sender: UISegmentedControl) {
		delegate?.segmentTapped(key: model?.key ?? "", sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "")
    }

    private func commonInit() {
        setConstraints()
    }
    
    private func setConstraints() {
        let constraints = [
            
            segmentControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .kTableCellPadding),
            segmentControl.heightAnchor.constraint(equalToConstant: 30),
            segmentControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            segmentControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}