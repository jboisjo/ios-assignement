//
//  StringExtension.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-25.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

extension String {
    func formatISO8601() -> String {
        let formattedDuration = self.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")

        let components = formattedDuration.components(separatedBy: ":")
        var duration = ""
        for component in components {
            duration = duration.count > 0 ? duration + ":" : duration
            if component.count < 2 {
                duration += "0" + component
                continue
            }
            duration += component
        }

        return duration

    }
}
