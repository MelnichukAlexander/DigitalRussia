//
//  NLPManager.swift
//  DigitalAdviser
//
//  Created by Александр on 27.07.2019.
//  Copyright © 2019 Alexander Melnichuk. All rights reserved.
//

import Foundation

typealias TaggedToken = (token: String, tag: NSLinguisticTag?, tokenRange: NSRange)

class NLPManager {
    
    private func tag(text: String, scheme: NSLinguisticTagScheme, unit: NSLinguisticTaggerUnit = .word) -> [TaggedToken] {
        
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(for: unit, language: "en"), options: 0)
        
        tagger.string = text
        
        let range = NSMakeRange(0, text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitOther]
        
        var taggedTokens: [TaggedToken] = []
        
        tagger.enumerateTags(in: range, unit: unit, scheme: scheme, options: options) { (tag, tokenRange, _) in
            guard let tag = tag else { return }
            
            let token = (text as NSString).substring(with: tokenRange)
            taggedTokens.append((token, tag, tokenRange))
        }
        
        return taggedTokens
    }
    
    // Helpers
    
    func lemmatize(text: String) -> [TaggedToken] {
        return tag(text: text, scheme: .lemma)
    }
    
    func lemmatizeSingleWord(text: String) -> [TaggedToken] {
        
        let newText = "please show me \(text)"
        
        return tag(text: newText, scheme: .lemma)
}
}
