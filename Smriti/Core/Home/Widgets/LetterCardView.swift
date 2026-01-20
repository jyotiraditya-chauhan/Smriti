//
//  LetterCardView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//

import SwiftUI

struct LetterCardView: View {

    let letter: Letter

    var body: some View {
        NavigationLink(value: letter) {
            HStack(spacing: 15) {

                Image("envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading, spacing: 4) {
                    Text(letter.profession)
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(letter.goal ?? "")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(letter.createdAt, format: .dateTime.day().month())
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))

                    Text(letter.createdAt, format: .dateTime.hour().minute())
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .padding(16)
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
    }
}
