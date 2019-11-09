//
//  LabelCell.swift
//  PKAutogrowingTextViewCell_Example
//
//  Created by Pavel Krasnobrovkin on 09/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

final class LabelCell: UITableViewCell {
	
	static let id = String(describing: LabelCell.self)
	
	private let labelMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
	private let label = UILabel()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		contentView.subviews.forEach { $0.removeFromSuperview() }
		commonInit()
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		var size = super.sizeThatFits(size)
		size.height = label.intrinsicContentSize.height
		size.height += labelMargins.top + labelMargins.bottom
		return size
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let origin = CGPoint(x: labelMargins.left, y: labelMargins.top)
		var size = contentView.bounds.size
		size.width -= origin.x + labelMargins.right
		size.height -= origin.y + labelMargins.bottom
		label.frame = CGRect(origin: origin, size: size)
	}
	
	private func commonInit() {
		label.font = UIFont.systemFont(ofSize: 14)
		label.text = "Hello world, I am label cell"
		contentView.addSubview(label)
	}
}
