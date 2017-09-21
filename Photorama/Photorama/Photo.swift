//
//  Photo.swift
//  Photorama
//
//  Created by Michael Pettiford on 9/20/17.
//  Copyright © 2017 Michael Pettiford. All rights reserved.
//

import Foundation


class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}
