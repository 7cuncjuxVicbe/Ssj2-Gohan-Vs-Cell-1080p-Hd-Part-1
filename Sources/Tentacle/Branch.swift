//
//  Branch.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2017-02-15.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    /// A request for the branches in the repository.
    ///
    /// https://developer.github.com/v3/repos/branches/#list-branches
    public var branches: Request<[Branch]> {
        return Request(method: .get, path: "/repos/\(owner)/\(name)/branches")
    }
}

public struct Branch: ResourceType {

    /// Name of the branch
    public let name: String

    /// Sha of the commit the branch points to
    public let sha: SHA

    public init(name: String, sha: SHA) {
        self.name = name
        self.sha = sha
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case sha = "commit"
    }
}

extension Branch: Hashable {
    public static func ==(lhs: Branch, rhs: Branch) -> Bool {
        return lhs.name == rhs.name && lhs.sha == rhs.sha
    }

    public var hashValue: Int {
        return name.hashValue ^ sha.hashValue
    }
}

