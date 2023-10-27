mod utils;
mod spending_policy;

contract TouchIdContract {
    /**
    * DEPENDENCIES
    */
    use dep::std;
    use dep::aztec;
    use dep::authwit;

    // use crate::utils;
    use crate::spending_policy::{SpendingPolicy, SpendingPolicySerializationMethods, SPENDING_POLICY_SERIALIZED_LEN};
    use dep::aztec::state_vars::{map::Map, public_state::PublicState};

    /**
    * STORAGE LAYOUT
    */
    struct Storage {
        // slot 1
        pub_key_x: [u8; 32],
        // slot 2
        pub_key_y: [u8; 32],
        // slot 3 see ACCOUNT_ACTIONS_STORAGE_SLOT:
        // action_witnesses: Map<bool> (managed by dep::authwit)
        // slot 4
        spending_policy: SpendingPolicy,
    }

    /**
    * @dev the mapping slot for approved actions
    * can be visualized to the solidity ajacent:
    * mapping(Field => bool)
    *
    * used by the authwit to store witnesses (think: transaction approvals)
    */
    global ACCOUNT_ACTIONS_STORAGE_SLOT = 3;
    
    impl Storage {
        fn init(ctx: aztec::context::Context) -> Self {
            Storage {
                pub_key_x: [0; 32],
                pub_key_y: [0; 32],
                spendingLimit: SpendingPolicy {
                    token: 0,
                    amount: 0,
                    balance_of_sig: 0
                }
        }
    }

    // Map<PublicState<SpendingPolicy, SPENDING_POLICY_SERIALIZED_LEN>>,
    //     Map::new(
    //         ctx,
    //         4,
    //         |ctx, slot| {
    //             PublicState::new(
    //                 ctx,
    //                 slot,
    //                 SpendingPolicySerializationMethods,
    //             )
    //         } 
    //     )
    // }

    /**
    * CONSTRUCTOR / INITIALIZER
    */
    #[aztec(private)]
    fn constructor(pub_key_x: [u8; 32], pub_key_y: [u8; 32]) {
        utils::_callInitialize(&mut context, pub_key_x, pub_key_y);
    }

    #[aztec(public)]
    internal fn _initialize(pub_key_x: [u8; 32], pub_key_y: [u8; 32]) {
        let mut storage_x = storage.pub_key_x;
        let mut storage_y = storage.pub_key_y;

        storage_x = pub_key_x;
        storage_y = pub_key_y;
    }

    /**
    * FUNCTIONS
    */

    // // TODO: does this need to be private?
    // #[aztec(private)]
    // fn entrypoint(payload: pub authwit::entrypoint::EntrypointPayload) {
    //     let policy: SpendingPolicy = storage.spending_policy;
    //     let mut balance_before: Field = 0;

    //     for call in payload.function_calls {
    //         // if call.target_address
    //     }
    //     let actions = authwit::account::AccountActions::private(&mut context, ACCOUNT_ACTIONS_STORAGE_SLOT, is_valid_impl);
    //     actions.entrypoint(payload);
    // }

    /// @returns the IS_VALID_SELECTOR hash if valid
    #[aztec(private)]
    fn is_valid(message_hash: Field) -> Field {
        let actions = authwit::account::AccountActions::private(&mut context, ACCOUNT_ACTIONS_STORAGE_SLOT, is_valid_impl);
        actions.is_valid_public(message_hash)
    }

    /// @returns the IS_VALID_SELECTOR hash if valid
    #[aztec(public)]
    fn is_valid_public(message_hash: Field) -> Field {
        let actions = authwit::account::AccountActions::public(&mut context, ACCOUNT_ACTIONS_STORAGE_SLOT, is_valid_impl);
        actions.is_valid_public(message_hash)
    }

    #[contract_library_method]
    fn is_valid_impl(context: &mut aztec::context::PrivateContext, message_hash: Field) -> pub bool {
        // let storage = Storage::init(aztec::context::Context::private(context));

        // let public_key_x = storage.pub_key_x;
        // let public_key_y = storage.pub_key_y;

        // let witness: [Field; 64] = authwit::auth_witness::get_auth_witness(message_hash);
        // let mut signature: [u8; 64] = [0; 64];
        // for i in 0..64 { signature[i] = witness[i] as u8; }

        // let verification = std::ecdsa_secp256r1::verify_signature(public_key_x, public_key_y, signature, message_hash.to_be_bytes(32));
        // assert(verification == true);

        true
    }

    /**
    * VIEW FUNCTIONS
    */

    /// @dev return the pub key x,y as a tuple
    unconstrained fn get_keys() -> ([u8; 32], [u8; 32]) {
        (storage.pub_key_x, storage.pub_key_y)
    }

    /**
    * INTERNAL / UTILITY FUNCTIONS
    */

    #[aztec(public)]
    internal fn set_is_valid_storage(message_hash: Field, is_valid: bool) {
        let actions = authwit::account::AccountActions::public(&mut context, ACCOUNT_ACTIONS_STORAGE_SLOT, is_valid_impl);
        actions.internal_set_is_valid_storage(ACCOUNT_ACTIONS_STORAGE_SLOT, is_valid);
    }
}
