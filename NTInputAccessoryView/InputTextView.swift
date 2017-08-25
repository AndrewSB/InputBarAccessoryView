//
//  InputTextView.swift
//  NTInputAccessoryView
//
//  Copyright © 2017 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 8/18/17.
//

open class InputTextView: UITextView {
    
    // MARK: - Properties

    open let placeholderLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.text = "Aa"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var placeholderLabelConstraintSet: NSLayoutConstraintSet?
    
    open var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
        }
    }
    
    open var placeholderTextColor: UIColor {
        get {
            return placeholderLabel.textColor
        }
        set {
            placeholderLabel.textColor = newValue
        }
    }
    
    override open var font: UIFont! {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    open override var textContainerInset: UIEdgeInsets {
        didSet {
            placeholderLabelInsets = textContainerInset
        }
    }

    open var placeholderLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4) {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    public weak var inputBarAccessoryView: InputBarAccessoryView?
    
    // MARK: - Initializers
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open func setup() {
        
        font = UIFont.preferredFont(forTextStyle: .body)
        isScrollEnabled = false
        addSubviews()
        addObservers()
        addConstraints()
    }
    
    private func addSubviews() {
        
        addSubview(placeholderLabel)
    }
    
    private func addConstraints() {
        
        placeholderLabelConstraintSet = NSLayoutConstraintSet(
            top:    placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: placeholderLabelInsets.top),
            bottom: placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -placeholderLabelInsets.bottom),
            left:   placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: placeholderLabelInsets.left),
            right:  placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -placeholderLabelInsets.right)
        ).activated()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        
        placeholderLabelConstraintSet?.top?.constant = textContainerInset.top
        placeholderLabelConstraintSet?.bottom?.constant = -textContainerInset.bottom
        placeholderLabelConstraintSet?.left?.constant = textContainerInset.left
        placeholderLabelConstraintSet?.right?.constant = -textContainerInset.bottom
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(InputTextView.textDidChange(notification:)),
                                               name: Notification.Name.UITextViewTextDidChange,
                                               object: nil)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    
    // MARK: - Notifications
    
    func textDidChange(notification: Notification) {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

