//
//  UIKitExtensions.swift
//  FormRenderer
//
//  Created by Arun Eswaramurthi on 23/11/20.
//

import UIKit

extension CGFloat {
	static let kExternalPadding: CGFloat = 20
	static let kTableCellPadding: CGFloat = 15
	static let kInternalPadding: CGFloat = 10
}

extension Date {
	var ddMMyyyy: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy"
		
		return dateFormatter.string(from: self)
	}
}

extension String {
	var toDate: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy"
		
		return dateFormatter.date(from: self)
	}
}

extension NSLayoutAnchor {
	@objc func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat = 0, priority: UILayoutPriority) -> NSLayoutConstraint {
		let constraint = self.constraint(equalTo: anchor, constant: constant)
		constraint.priority = priority
		
		return constraint
	}
	
	@objc func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat = 0, priority: UILayoutPriority) -> NSLayoutConstraint {
		let constraint = self.constraint(lessThanOrEqualTo: anchor, constant: constant)
		constraint.priority = priority
		
		return constraint
	}
}
