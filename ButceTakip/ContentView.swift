import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Transaction.date, order: .reverse) var transactions: [Transaction]
    @State private var isFormOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Arka plan rengi
                Color(.sRGB, red: 0.1098, green: 0.1098, blue: 0.1058)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        
                VStack {
                    SummaryView()
                        .cornerRadius(20)
                        .padding(20)
                    
                    ScrollView {
                        ForEach(transactions, id: \.self) { transaction in
                            TransactionView(transaction: transaction)
                        }
                    }
                    Spacer()
                }
                .padding(20)
                // Navigation ayarlarını içteki ana görünüme (VStack) bağlıyoruz
                .navigationTitle("Bütçe Takip")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: { isFormOpen = true }) {
                            Label("Add Transaction", systemImage: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .sheet(isPresented: $isFormOpen) {
                FormView(isPresented: $isFormOpen)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
