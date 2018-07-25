//
// Copyright (c) 2018 Yuichi Hirano
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
        if let root = data as? Dictionary<String, Any> {
            return parseRoot(dictonary: root, directory: plistPath.deletingLastPathComponent)
        }
        return []
    }

    private static func parseRoot(dictonary dict: Dictionary<String, Any>, directory: String) -> [Item] {
        let preferenceSpecifiers = dict["PreferenceSpecifiers"] as? [Any]
        guard preferenceSpecifiers != nil, preferenceSpecifiers?.isEmpty == false else {
            return []
        }

        return preferenceSpecifiers!
            .compactMap { $0 as? Dictionary<String, Any> }
            .map { v -> Item in
                let title = v["Title"] as? String
                let file = v["File"] as? String
                if let file = file,
                   let filePath = directory.appendingPathComponent(file).appendingPathExtension("plist") {
                    return Item(title: title,
                                text: parseItem(filePath: filePath))
                } else {
                    return Item(title: title, text: nil)
                }
            }
    }

    private static func parseItem(filePath: String) -> String? {
        let data = NSDictionary(contentsOfFile: filePath)
        if let dict = data as? Dictionary<String, Any> {
            let preferenceSpecifiers = dict["PreferenceSpecifiers"] as? [Any]
            guard preferenceSpecifiers != nil, preferenceSpecifiers?.isEmpty == false else {
                return nil
            }

            return preferenceSpecifiers!
                .compactMap { $0 as? Dictionary<String, Any> }
                .map { v -> String? in
                    return v["FooterText"] as? String
                }
                .compactMap { $0 }
                .first
        } else {
            return nil
        }
    }
}
