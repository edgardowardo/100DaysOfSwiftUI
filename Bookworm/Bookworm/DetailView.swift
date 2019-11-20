//
//  DetailView.swift
//  Bookworm
//
//  Created by EDGARDO AGNO on 18/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI
import CoreData

extension Book {
    var displayedPublishDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: publishDate ?? Date())
    }
}

struct DetailView: View {
    
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    @State private var showingEditMode = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)

                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }

                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.displayedPublishDate)
                    .font(.body)

                Text(self.book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
//                NavigationLink("Edit", destination: EditBookView(viewModel: EditBookViewModel(book: self.book)))
//                    .padding()

                Spacer()
                
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: HStack(spacing: 10) {
                Button(action: {
                    self.showingEditMode = true
                }) {
                    Image(systemName: "square.and.pencil")
                }
                Button(action: {
                    self.showingDeleteAlert = true
                }) {
                    Image(systemName: "trash")
                }
            }
        )
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $showingEditMode) {
            EditBookView(viewModel: EditBookViewModel(book: self.book)).environment(\.managedObjectContext, self.moc)
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
    }
}
