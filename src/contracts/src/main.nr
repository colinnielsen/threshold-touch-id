mod utils;
mod spending_policy;

// global pub_x: Field = 0x0ede3d33c920df8fdf43f3e39ed38b0882c25b056620ef52fd016fe811aa2443;
// global pub_y: Field = 0x29155934ffaa105323695b5f91faadd84acc21f4a8bda2fad760f992d692bc7f;

contract SpendingLimitWallet {
    /**
    * DEPENDENCIES
    */
    use dep::std;
    use dep::aztec;
    use dep::authwit;

    use crate::utils;
    use crate::spending_policy::{SpendingPolicy, SpendingPolicySerializationMethods, SPENDING_POLICY_SERIALIZED_LEN};
    use dep::aztec::state_vars::{map::Map, public_state::PublicState};

    /**
    * STORAGE LAYOUT
    */
    struct Storage {
        // slot 1
        pub_key_x: Field,
        // slot 2
        pub_key_y: Field,
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
        fn init(_ctx: aztec::context::Context) -> Self {
            Storage {
                pub_key_x: 0,
                pub_key_y: 0,
                spending_policy: SpendingPolicy::empty()
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
    internal fn _initialize(pub_key_x: Field, pub_key_y: Field) {
        let mut storage_x = storage.pub_key_x;
        let mut storage_y = storage.pub_key_y;

        storage_x = pub_key_x;
        storage_y = pub_key_y;
    }

    /**
    * FUNCTIONS
    */

    #[aztec(private)]
    fn entrypoint(payload: pub authwit::entrypoint::EntrypointPayload) {
        let selector = aztec::selector::compute_selector("entrypoint_public((Field,Field,Field,Field))");
        context.call_public_function(context.this_address(), selector, payload.serialize());
    }

    #[aztec(public)]
    internal fn entrypoint_public(payload: authwit::entrypoint::EntrypointPayload) {
        let policy: SpendingPolicy = storage.spending_policy;
        let mut balance_before: Field = 0;

        for call in payload.function_calls {
            if call.target_address == policy.token.address {
                balance_before = context.call_public_function(
                    call.target_address,
                    policy.balance_of_sig,
                    [context.this_address()]
                )[0];
            }
        }

        let actions = authwit::account::AccountActions::public(&mut context, ACCOUNT_ACTIONS_STORAGE_SLOT, is_valid_impl);
        actions.entrypoint(payload);

        if balance_before != 0 {
            let balance_after: Field = context.call_public_function(
                    policy.token.address,
                    policy.balance_of_sig,
                    [context.this_address()]
                )[0];

            if (balance_after as u120) < (balance_before as u120) {
                if balance_after as u120 - balance_before as u120 < policy.limit as u120 {
                    assert(false); // revert
                    // todo: second signature
                }
            }
        }
    }

    #[contract_library_method]
    fn is_valid_impl(context: &mut aztec::context::PrivateContext, message_hash: Field) -> pub bool {
        let storage = Storage::init(aztec::context::Context::private(context));

        let public_key_x = storage.pub_key_x;
        let public_key_y = storage.pub_key_y;

        let witness: [Field; 64] = authwit::auth_witness::get_auth_witness(message_hash);
        let mut signature: [u8; 64] = [0; 64];
        for i in 0..64 { signature[i] = witness[i] as u8; }

        let verification = std::schnorr::verify_signature(
            public_key_x,
            public_key_y,
            signature,
            message_hash.to_be_bytes(32)
        );

        assert(verification == true);

        true
    }

    /**
    * VIEW FUNCTIONS
    */

    /// @dev return the pub key x,y as a tuple
    unconstrained fn get_keys() -> (Field, Field) {
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
