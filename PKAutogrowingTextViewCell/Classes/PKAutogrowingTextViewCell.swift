//
//  PKAutogrowingTextViewCell.swift
//  PKAutogrowingTextViewCell
//
//  Created by Pavel Krasnobrovkin on 08/11/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

open class PKAutogrowingTextViewCell: UITableViewCell {
	
	public weak var delegate: PKAutogrowingTextViewCellDelegate?
	
	open var textViewClass: UITextView.Type {
		UITextView.self
	}
	
	public var textViewMargins = UIEdgeInsets.zero {
		didSet {
			requestHeightChange()
		}
	}
	
	public var textContainerInsets = UIEdgeInsets.zero {
		didSet {
			textView.textContainerInset = textContainerInsets
			requestHeightChange()
		}
	}
	
	public var textFont = UIFont.systemFont(ofSize: 14) {
		didSet {
			textView.font = textFont
			requestHeightChange()
		}
	}
	
	public var textViewText = "" {
		didSet {
			textView.text = textViewText
			requestHeightChange()
		}
	}
	
	private lazy var textView = {
		textViewClass.init()
	}()
	
	open override func sizeThatFits(_ size: CGSize) -> CGSize {
		var size = super.sizeThatFits(size)
		size.height = textViewMargins.top + textViewMargins.bottom
		size.height += currentTextHeight
		return size
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		textView.frame = CGRect(
			x: textViewMargins.left,
			y: textViewMargins.top,
			width: contentView.bounds.width - textViewMargins.left - textViewMargins.right,
			height: currentTextHeight - textViewMargins.top - textViewMargins.bottom)
	}
	
	open override func becomeFirstResponder() -> Bool {
		return textView.becomeFirstResponder()
	}
	
	public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		contentView.subviews.forEach { $0.removeFromSuperview() }
		commonInit()
	}
}

// MARK: - UITextViewDelegate
extension PKAutogrowingTextViewCell: UITextViewDelegate {
	
	open func textViewDidChange(_ textView: UITextView) {
		delegate?.pkAutogrowingTextViewCell(self, didChangeText: textView.text)
		requestHeightChangeIfNeeded()
	}
}

// MARK: - Private
private extension PKAutogrowingTextViewCell {
	
	var currentTextHeight: CGFloat {
		let width = contentView.bounds.width - textViewMargins.left - textViewMargins.right
		let limit = CGSize(width: width, height: .greatestFiniteMagnitude)
		return textView.sizeThatFits(limit).height
	}
	
	func commonInit() {
		textView.delegate = self
		textView.font = textFont
		textView.textContainerInset = textContainerInsets
		
		textView.isScrollEnabled = false
		textView.showsVerticalScrollIndicator = false
		contentView.addSubview(textView)
	}
	
	func requestHeightChangeIfNeeded() {
		let newTextHeight = currentTextHeight + textViewMargins.top + textViewMargins.bottom
		guard newTextHeight != bounds.height else {
			return
		}
		
		requestHeightChange()
	}
	
	func requestHeightChange() {
		delegate?.pkAutogrowingTextViewCellDidRequestToChangeHeight(self)
	}
}
