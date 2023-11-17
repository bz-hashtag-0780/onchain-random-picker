import "Xorshift128plus"
import "RandomResultStorage"

/// This contract & transaction is intended for this project's statistical testing which needs persistent PRG state
/// across large numbers of random number generations.
///
/// Generates and adds the specified number of random numbers to the contract's result field, enabling continuous
/// random number generation across an arbitrary number of transactions.
///
transaction(generationLength: Int) {

    prepare(signer: AuthAccount) {
        signer.borrow<&RandomResultStorage.Admin>(from: RandomResultStorage.STORAGE_PATH)
            ?.generateResults(length: generationLength)
            ?? panic("Signer is not admin for RandomResultStorage!")
    }
}
