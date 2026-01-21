//
//  HomeService.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//

import Foundation
import Playgrounds
import FoundationModels

final class HomeService {
    
    private let session: LanguageModelSession
    
    
    init(session: LanguageModelSession = .init()) {
        self.session = session
    }
    
    func getLetter(name: String, profession: String, goal: String, date: Date) async throws -> String {
        let futureYear = Calendar.current.component(.year, from: date)
        let currentYear = Calendar.current.component(.year, from: Date())
        let yearsAhead = futureYear - currentYear
        
        let response = try await session.respond(to: """
    You are \(name), writing a handwritten letter from \(futureYear) to yourself in \(currentYear).

    Current context: You're a \(profession) in \(currentYear), working toward "\(goal)". \(yearsAhead) years have passed since then.

    Write this as a TRADITIONAL PERSONAL LETTER—the kind you'd write by hand and mail to someone. Not a blog post, not structured paragraphs, not an article.

    LETTER GUIDELINES:

    Start with:
    "Hey \(name)," or "Dear \(name)," followed by a natural opening line.

    Write in a flowing, conversational style:
    - Let thoughts connect naturally, like you're talking
    - Break lines when you'd pause in speech, not at paragraph boundaries
    - Use shorter line breaks between thoughts (single line breaks, not double)
    - Write the way you'd actually speak to yourself—casual, knowing, direct
    - Mix short and long sentences organically
    - Reference specific moments, feelings, or situations related to \(profession) and \(goal)
    - Share 1-2 concrete pieces of wisdom or experiences from the \(yearsAhead) years
    - Mention at least one specific challenge or turning point

    End naturally:
    Close with something brief and real, then sign off simply with your name.

    FORMAT EXAMPLE (follow this flow, not the content):
    ```
    Hey [name],

    Writing to you from [year]. Been thinking about where you are right now. [Brief reflection on current situation].

    [Share first insight or memory]. I remember [specific moment]. That taught me [lesson].

    Here's something I wish I'd known earlier: [concrete advice]. When [specific situation related to profession/goal], [what you learned].

    [Another brief thought or reassurance].

    [Simple closing line].

    - [Name]
    ```

    STRICT REQUIREMENTS:
    - 200-280 words total
    - Single line breaks between thoughts (not double-spaced paragraphs)
    - Conversational, natural flow—like stream of consciousness
    - At least 2 specific references to moments or experiences
    - NO formal paragraph structure
    - NO section headers or structured blocks
    - Write as spoken thought, not written prose
    - Use "I" and "you" naturally
    - Keep it grounded—share real insights, not motivational fluff
    - Maximum 1 emoji
    - Sign off with just "\(name)" or "- \(name)" or "Your future self, \(name)"

    TONE:
    Like you're sitting across from yourself having coffee. Honest, a bit nostalgic, knowing. Not writing an essay—just talking through time.

    AVOID:
    - Multiple paragraph blocks
    - Formal writing structure
    - Repeating "Remember when..." more than once
    - Generic advice ("believe in yourself", "you can do it")
    - Over-dramatizing
    - Mentioning AI, prompts, or instructions

    Write the letter as a natural flow of thoughts, not structured sections:
    """)
        print(response.content)
        return response.content
    }
    
    
    
//    func getLetter(name: String,profession: String, goal: String,date: Date) async throws -> String {
//        let response = try await session.respond(to: """
//You are an AI writing a personal letter from the future.
//
//Context:
//- The year is \(date).
//- The letter is written by the user's future self.
//- The audience is the user's present self.
//
//User details:
//- Name: \(name)
//- Profession: \(profession)
//- Personal goal: \(goal)
//
//Writing instructions:
//- Write in first person (“I”).
//- Address the user by their name naturally.
//- Reflect on the journey, struggles, growth, and lessons learned.
//- Acknowledge doubts the user might be feeling now.
//- Encourage patience, consistency, and self-belief.
//- Refer to the profession and goal in a subtle, meaningful way.
//- Keep the tone calm, warm, hopeful, and emotionally grounded.
//- Avoid clichés, exaggeration, or unrealistic success claims.
//- Do not mention being an AI or a model.
//- Do not mention prompts, instructions, or metadata.
//
//Style rules:
//- Length: 3–4 really very short paragraphs.
//- do not write long para's.
//- Language: simple, human, and sincere.
//- 1-2 emojis if needed.
//- No bullet points.
//- No headings.
//- End with a reassuring closing line that feels personal.
//
//Purpose:
//The letter should feel like a quiet moment of reassurance from the future — honest, reflective, and deeply personal.
//
//""")
//        return response.content
//    }
}
