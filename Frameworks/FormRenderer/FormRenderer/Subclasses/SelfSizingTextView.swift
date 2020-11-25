//
//  SelfSizingTextView.swift
//  Actio
//
//  Created by Arun Eswaramurthi on 08/07/20.
//  Copyright © 2020 Knila. All rights reserved.
//

import UIKit

private extension UIEdgeInsets {
	var horizontal: CGFloat { return right + left }
	var vertical: CGFloat { return top + bottom }
}

private extension CGSize {
	func paddedBy(_ insets: UIEdgeInsets) -> CGSize {
		return CGSize(width: width + insets.horizontal, height: height + insets.vertical)
	}
	
	var roundedUp: CGSize {
		return CGSize(width: ceil(width), height: ceil(height))
	}
}

extension UITextView {
    func textSize(for width: CGFloat) -> CGSize {
        let containerSize = CGSize(width: width - textContainerInset.horizontal,
                                   height: CGFloat.greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.lineFragmentPadding = textContainer.lineFragmentPadding
        let storage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(container)
        storage.addLayoutManager(layoutManager)
        layoutManager.glyphRange(for: container)
        let rawSize =  layoutManager.usedRect(for: container).size.paddedBy(textContainerInset)
        return rawSize.roundedUp
    }
}

class SelfSizingTextView: UITextView {
    var preferredMaxLayoutWidth: CGFloat? {
        didSet {
            if preferredMaxLayoutWidth != oldValue {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        guard isScrollEnabled, let width = preferredMaxLayoutWidth else {
            return super.intrinsicContentSize
        }
        return textSize(for: width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        preferredMaxLayoutWidth = bounds.size.width
    }
}
