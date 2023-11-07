//
// Copyright (c) 2018-2022 Yuichi Hirano
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

internal class LicensePlistDetailViewController: UIViewController {
    private let topMargin: CGFloat = 16
    private let bottomMargin: CGFloat = 16

    private let item: Item
    private let textColor: UIColor?
    private let linkTextColor: UIColor?
    private let backgroundColor: UIColor?

    private weak var textView: UITextView?

    init(item: Item, textColor: UIColor?, linkTextColor: UIColor?, backgroundColor: UIColor?) {
        self.item = item
        self.linkTextColor = linkTextColor
        self.textColor = textColor
        self.backgroundColor = backgroundColor

        super.init(nibName: nil, bundle: nil)
        self.title = item.title
        if let backgroundColor = backgroundColor {
            view.backgroundColor = backgroundColor
        }
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let textView = UITextView(frame: view.bounds)
        textView.alwaysBounceVertical = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        if let textColor = self.textColor {
            textView.textColor = textColor
        }
        if let linkTextColor = self.linkTextColor {
            textView.linkTextAttributes = [.foregroundColor: linkTextColor]
        }
        if let backgroundColor = self.backgroundColor {
            textView.backgroundColor = backgroundColor
        }
        view.addSubview(textView)

        self.textView = textView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateTextViewInsets()

        // Need to set the textView text after the layout is completed,
        // so that the content inset and offset properties can be adjusted automatically.
        textView?.text = item.text
    }

    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()

        updateTextViewInsets()
    }

    private func updateTextViewInsets() {
        textView?.textContainerInset = .init(
            top: topMargin,
            left: self.view.layoutMargins.left,
            bottom: bottomMargin,
            right: self.view.layoutMargins.right
        )
    }
}
