module MyModule::SimpleMove {
    use aptos_framework::signer;
    use aptos_framework::coin::{Self, Coin};
    use aptos_framework::aptos_coin::AptosCoin;

    struct SimpleData has key, store {
        balance: u64,
    }

    public fun create_account(user: &signer) {
        let simple_data = SimpleData { balance: 0 };
        move_to(user, simple_data);
    }

    public fun deposit(user: &signer, amount: u64) acquires SimpleData {
        let coins = coin::withdraw<AptosCoin>(user, amount);
        let simple_data = borrow_global_mut<SimpleData>(signer::address_of(user));
        simple_data.balance += amount;
        coin::deposit<AptosCoin>(signer::address_of(user), coins);
    }
}