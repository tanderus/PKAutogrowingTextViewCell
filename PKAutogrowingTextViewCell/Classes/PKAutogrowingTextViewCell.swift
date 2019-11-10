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
	
	public var maximumLinesAllowed: UInt = 5 {
		didSet {
			guard maximumLinesAllowed != oldValue else { return }
			requestHeightChange()
		}
	}
	
	public var textViewMargins = UIEdgeInsets.zero {
		didSet {
			guard textViewMargins != oldValue else { return }
			requestHeightChange()
		}
	}
	
	public lazy var textView = {
		textViewClass.init()
	}()
	
	private var kvObservations = [NSKeyValueObservation]()
	
	open override func sizeThatFits(_ size: CGSize) -> CGSize {
		var size = super.sizeThatFits(size)
		size.height = textViewMargins.top + textViewMargins.bottom
		size.height += limitedTextViewHeight
		return size
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		textView.frame = CGRect(
			x: textViewMargins.left,
			y: textViewMargins.top,
			width: contentView.bounds.width - textViewMargins.left - textViewMargins.right,
			height: limitedTextViewHeight)
		
		let verticalScrollEnabled = currentTextHeight > maximumTextViewHeight
		textView.isScrollEnabled = verticalScrollEnabled
		textView.showsVerticalScrollIndicator = verticalScrollEnabled
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
	
	public func requestHeightChangeIfNeeded() {
		let newTextHeight = currentTextHeight + textViewMargins.top + textViewMargins.bottom
		guard newTextHeight != bounds.height else {
			return
		}
		
		requestHeightChange()
	}
	
	public func requestHeightChange() {
		delegate?.pkAutogrowingTextViewCellDidRequestToChangeHeight(self)
	}
	
	deinit {
		kvObservations.forEach { $0.invalidate() }
		kvObservations = []
	}
}

// MARK: - UITextViewDelegate
extension PKAutogrowingTextViewCell: UITextViewDelegate {
	
	open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		delegate?.pkAutogrowingTextViewCellShouldBeginEditing(self) ?? true
	}
	
	open func textViewDidBeginEditing(_ textView: UITextView) {
		delegate?.pkAutogrowingTextViewCellDidBeginEditing(self)
	}
	
	open func textViewDidEndEditing(_ textView: UITextView) {
		delegate?.pkAutogrowingTextViewCellDidEndEditing(self)
	}
	
	open func textViewDidChange(_ textView: UITextView) {
		delegate?.pkAutogrowingTextViewCell(self, didChangeText: textView.text)
		requestHeightChangeIfNeeded()
	}
}

// MARK: - Private
private extension PKAutogrowingTextViewCell {
	
	var limitedTextViewHeight: CGFloat {
		ceil(max(minimumTextViewHeight, min(maximumTextViewHeight, currentTextHeight)))
	}
	
	var minimumTextViewHeight: CGFloat {
		ceil(textFont.lineHeight + textContainerVerticalInsets)
	}
	
	var maximumTextViewHeight: CGFloat {
		ceil(CGFloat(maximumLinesAllowed) * textFont.lineHeight + textContainerVerticalInsets)
	}
	
	var currentTextHeight: CGFloat {
		let width = contentView.bounds.width - textViewMargins.left - textViewMargins.right
		let limit = CGSize(width: width, height: .greatestFiniteMagnitude)
		return ceil(textView.sizeThatFits(limit).height)
	}
	
	var textFont: UIFont {
		textView.font ?? .preferredFont(forTextStyle: .body)
	}
	
	var textContainerVerticalInsets: CGFloat {
		textView.textContainerInset.top + textView.textContainerInset.bottom
	}
	
	func commonInit() {
		textView.delegate = self
		textView.bounces = false
		contentView.addSubview(textView)
		
		kvObservations.append(
			textView.observe(\.text) { [weak self] (_, _) in
				self?.requestHeightChangeIfNeeded()
			}
		)
		
		kvObservations.append(
			textView.observe(\.font) { [weak self] (_, _) in
				self?.requestHeightChangeIfNeeded()
			}
		)
		
		kvObservations.append(
			textView.observe(\.textContainerInset) { [weak self] (_, _) in
				self?.requestHeightChangeIfNeeded()
			}
		)
		
		kvObservations.append(
			textView.observe(\.attributedText) { [weak self] (_, _) in
				self?.requestHeightChangeIfNeeded()
			}
		)
	}
}
