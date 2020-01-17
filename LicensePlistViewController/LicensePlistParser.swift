//
// Copyright (c) 2018-2020 Yuichi Hirano
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

import Foundation

internal class LicensePlistParser {
    private init() {
    }

    static func parse(plistPath: String?) -> [Item] {
        guard let plistPath = plistPath else {
            return []
        }

        let data = NSDictionary(contentsOfFile: plistPath)
        guard let root = data as? Dictionary<String, Any> else {
            return []
        }
        return parseRoot(dictonary: root, directory: plistPath.deletingLastPathComponent)
    }

    private static func parseRoot(dictonary dict: Dictionary<String, Any>, directory: String) -> [Item] {
        guard let preferenceSpecifiers = dict["PreferenceSpecifiers"] as? [Any],
              preferenceSpecifiers.isEmpty == false else {
            return []
        }

        return preferenceSpecifiers
            .compactMap { $0 as? Dictionary<String, Any> }
            .filter { $0["Type"] as? String == "PSChildPaneSpecifier" }
            .map { v -> Item in
                let title = v["Title"] as? String
                let file = v["File"] as? String
                if let file = file,
                   let filePath = directory.appendingPathComponent(file).appendingPathExtension("plist") {
                    return Item(title: title, text: parseItem(filePath: filePath))
                } else {
                    return Item(title: title, text: nil)
                }
            }
    }

    private static func parseItem(filePath: String) -> String? {
        guard let data = NSDictionary(contentsOfFile: filePath), let dict = data as? Dictionary<String, Any> else {
            return nil
        }

        guard let preferenceSpecifiers = dict["PreferenceSpecifiers"] as? [Any],
              preferenceSpecifiers.isEmpty == false else {
            return nil
        }

        // Seach "FooterText" in preferenceSpecifiers.
        for preferenceSpecifier in preferenceSpecifiers {
            guard let dict = preferenceSpecifier as? Dictionary<String, Any>,
                  let footerText = dict["FooterText"] as? String else {
                continue
            }
            return footerText
        }

        // Not found "FooterText" in preferenceSpecifiers.
        return nil
    }
}
