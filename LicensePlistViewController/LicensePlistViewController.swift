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

open class LicensePlistViewController: UITableViewController {
    public enum CellIndicator {
        case accessoryType(accessoryType: UITableViewCell.AccessoryType)
        case image(image: UIImage, width: CGFloat? = nil)
    }

    public static let defaultPlistPath = Bundle.main.path(forResource: "com.mono0926.LicensePlist", ofType: "plist")
    public static let defaultTitle = "License"
    public static let defaultHeaderHeight: CGFloat? = nil
    public static let defaultTextColor: UIColor? = nil
    public static let defaultLinkTextColor: UIColor? = nil
    public static let defaultBackgroundColor: UIColor? = nil
    public static let defaultCellIndicator: CellIndicator? = CellIndicator.accessoryType(accessoryType: .disclosureIndicator)
    public static let defaultCellBackgroundColor: UIColor? = nil
    public static let defaultSelectedCellBackgroundColor: UIColor? = nil

    private var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var textColor: UIColor? = LicensePlistViewController.defaultTextColor
    private var linkTextColor: UIColor? = LicensePlistViewController.defaultLinkTextColor
    private var backgroundColor: UIColor? = LicensePlistViewController.defaultBackgroundColor
    private var cellIndicator: CellIndicator? = LicensePlistViewController.defaultCellIndicator
    private var cellBackgroundColor: UIColor? = LicensePlistViewController.defaultCellBackgroundColor
    private var selectedCellBackgroundColor: UIColor? = LicensePlistViewController.defaultSelectedCellBackgroundColor

    public convenience init(
        fileNamed fileName: String,
        title: String? = LicensePlistViewController.defaultTitle,
        headerHeight: CGFloat? = LicensePlistViewController.defaultHeaderHeight,
        tableViewStyle: UITableView.Style = .grouped,
        textColor: UIColor? = LicensePlistViewController.defaultTextColor,
        linkTextColor: UIColor? = LicensePlistViewController.defaultLinkTextColor,
        backgroundColor: UIColor? = LicensePlistViewController.defaultBackgroundColor,
        cellIndicator: CellIndicator? = LicensePlistViewController.defaultCellIndicator,
        cellBackgroundColor: UIColor? = LicensePlistViewController.defaultCellBackgroundColor,
        selectedCellBackgroundColor: UIColor? = LicensePlistViewController.defaultSelectedCellBackgroundColor
    ) {
        let path = Bundle.main.path(forResource: fileName, ofType: "plist")
        self.init(
            plistPath: path,
            title: title,
            headerHeight: headerHeight,
            tableViewStyle: tableViewStyle,
            textColor: textColor,
            linkTextColor: linkTextColor,
            backgroundColor: backgroundColor,
            cellIndicator: cellIndicator,
            cellBackgroundColor: cellBackgroundColor,
            selectedCellBackgroundColor: selectedCellBackgroundColor
        )
    }

    public init(
        plistPath: String? = LicensePlistViewController.defaultPlistPath,
        title: String? = LicensePlistViewController.defaultTitle,
        headerHeight: CGFloat? = LicensePlistViewController.defaultHeaderHeight,
        tableViewStyle: UITableView.Style = .grouped,
        textColor: UIColor? = LicensePlistViewController.defaultTextColor,
        linkTextColor: UIColor? = LicensePlistViewController.defaultLinkTextColor,
        backgroundColor: UIColor? = LicensePlistViewController.defaultBackgroundColor,
        cellIndicator: CellIndicator? = LicensePlistViewController.defaultCellIndicator,
        cellBackgroundColor: UIColor? = LicensePlistViewController.defaultCellBackgroundColor,
        selectedCellBackgroundColor: UIColor? = LicensePlistViewController.defaultSelectedCellBackgroundColor
    ) {
        super.init(style: tableViewStyle)
        self.commonInit(
            plistPath: plistPath,
            title: title,
            headerHeight: headerHeight,
            textColor: textColor,
            linkTextColor: linkTextColor,
            backgroundColor: backgroundColor,
            cellIndicator: cellIndicator,
            cellBackgroundColor: cellBackgroundColor,
            selectedCellBackgroundColor: selectedCellBackgroundColor
        )
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(style: .grouped)
        self.commonInit(
            plistPath: LicensePlistViewController.defaultPlistPath,
            title: LicensePlistViewController.defaultTitle,
            headerHeight: LicensePlistViewController.defaultHeaderHeight,
            textColor: LicensePlistViewController.defaultTextColor,
            linkTextColor: LicensePlistViewController.defaultLinkTextColor,
            backgroundColor: LicensePlistViewController.defaultBackgroundColor,
            cellIndicator: LicensePlistViewController.defaultCellIndicator,
            cellBackgroundColor: LicensePlistViewController.defaultCellBackgroundColor,
            selectedCellBackgroundColor: LicensePlistViewController.defaultSelectedCellBackgroundColor
        )
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(style: .grouped)
        self.commonInit(
            plistPath: LicensePlistViewController.defaultPlistPath,
            title: LicensePlistViewController.defaultTitle,
            headerHeight: LicensePlistViewController.defaultHeaderHeight,
            textColor: LicensePlistViewController.defaultTextColor,
            linkTextColor: LicensePlistViewController.defaultLinkTextColor,
            backgroundColor: LicensePlistViewController.defaultBackgroundColor,
            cellIndicator: LicensePlistViewController.defaultCellIndicator,
            cellBackgroundColor: LicensePlistViewController.defaultCellBackgroundColor,
            selectedCellBackgroundColor: LicensePlistViewController.defaultSelectedCellBackgroundColor
        )
    }

    private func commonInit(
        plistPath: String?,
        title: String?,
        headerHeight: CGFloat?,
        textColor: UIColor?,
        linkTextColor: UIColor?,
        backgroundColor: UIColor?,
        cellIndicator: CellIndicator?,
        cellBackgroundColor: UIColor?,
        selectedCellBackgroundColor: UIColor?
    ) {
        self.title = title
        self.items = LicensePlistParser.parse(plistPath: plistPath)
        if headerHeight == 0 {
            self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        } else if let headerHeight = headerHeight, headerHeight > 0 {
            self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: headerHeight))
        }
        if let backgroundColor = backgroundColor {
            tableView.backgroundColor = backgroundColor
        }
        self.textColor = textColor
        self.linkTextColor = linkTextColor
        self.backgroundColor = backgroundColor
        self.cellIndicator = cellIndicator
        self.cellBackgroundColor = cellBackgroundColor
        self.selectedCellBackgroundColor = selectedCellBackgroundColor
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        if let navigationController = self.navigationController {
            if self.presentingViewController != nil && navigationController.viewControllers.first == self {
                let item = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController(_:)))
                self.navigationItem.leftBarButtonItem = item
            }
        }
    }

    // MARK: - Actions
    
    @IBAction open func dismissViewController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension LicensePlistViewController {
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        let cell: UITableViewCell
        if let dequeuedCell = dequeuedCell {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
        }

        let item = items[indexPath.row]
        cell.textLabel?.text = item.title

        switch cellIndicator {
        case let .accessoryType(accessoryType):
            cell.accessoryType = accessoryType
            cell.accessoryView = nil
        case let .image(image, width):
            cell.accessoryType = .none
            let indicatorImageView = UIImageView(image: image)
            let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: width ?? indicatorImageView.frame.width, height: cell.frame.height))
            indicatorView.addSubview(indicatorImageView)
            indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
            indicatorImageView.trailingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 0).isActive = true
            indicatorImageView.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor, constant: 0).isActive = true
            cell.accessoryView = indicatorView
        case .none:
            cell.accessoryType = .none
            cell.accessoryView = nil
        }

        if let textColor = self.textColor {
            cell.textLabel?.textColor = textColor
        }
        if let cellBackgroundColor = self.cellBackgroundColor {
            cell.backgroundColor = cellBackgroundColor
        }
        if let selectedCellBackgroundColor = self.selectedCellBackgroundColor {
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = selectedCellBackgroundColor
            cell.selectedBackgroundView = selectedBackgroundView
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension LicensePlistViewController {
     open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
         let viewController = LicensePlistDetailViewController(
            item: item,
            textColor: textColor,
            linkTextColor: linkTextColor,
            backgroundColor: backgroundColor
         )
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
