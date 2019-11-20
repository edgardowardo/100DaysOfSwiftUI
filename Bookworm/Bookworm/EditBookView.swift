//
//  EditBookView.swift
//  Bookworm
//
//  Created by EDGARDO AGNO on 19/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI
import CoreData

extension Book {
    var displayedTitle: String { title ?? "Unknown title" }
    var displayedAuthor : String { author ?? "Unknown author" }
    var displayedGenre : String { genre ?? "Unknown genre" }
    var displayedReview : String { review ?? "Unknown review" }
}

class EditBookViewModel: ObservableObject {
    @Published var title: String { didSet { book.title = title }}
    @Published var author: String { didSet { book.author = author }}
    @Published var rating: Int { didSet { book.rating = Int16(rating) }}
    @Published var genre: String { didSet { book.genre = genre }}
    @Published var review: String { didSet { book.review = review }}
    
    let book: Book

    init(book: Book) {
        self.book = book
        title = book.displayedTitle
        author = book.displayedAuthor
        rating = Int(book.rating)
        genre = book.displayedGenre
        review = book.displayedReview
    }
}

struct EditBookView: View {
    
    @ObservedObject var viewModel: EditBookViewModel
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Technology"]
    
    var isSavable: Bool {
        !viewModel.title.isEmpty && !viewModel.author.isEmpty && !viewModel.genre.isEmpty && moc.hasChanges
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $viewModel.title)
                    TextField("Author's name", text: $viewModel.author)

                    Picker("Genre", selection: $viewModel.genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $viewModel.rating)
                    TextField("Write a review", text: $viewModel.review)
                }
                
                Section {
                    Button("Save") {
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(isSavable == false)

            }
            .navigationBarTitle("Edit Book")
            .onDisappear {
                if self.moc.hasChanges {
                    self.moc.rollback()
                }
            }
        }
    }
}

struct EditBookView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return EditBookView(viewModel: EditBookViewModel(book: book))
    }
}
