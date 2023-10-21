contract TouchIdContract {
    /**
    * DEPENDENCIES
    */
    use dep::std;
    use dep::aztec;
    use dep::authwit;

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
        fn init(_ctx: aztec::context::Context) -> pub Self {
            Storage {
                pub_key_x: [0; 32],
                pub_key_y: [0; 32]
            }
        }
    }

    /**
    * CONSTRUCTOR / INITIALIZER
    */
    #[aztec(private)]
    fn constructor(pub_key_x: [u8; 32], pub_key_y: [u8; 32]) {
        // TODO: there is an ICE error here with the _callInitialize function
        // _callInitialize(&mut context, pub_key_x, pub_key_y);
        let mut serialized_args = [0; 64];
        serialized_args[0] = pub_key_x[0] as Field;
        serialized_args[1] = pub_key_x[1] as Field;
        serialized_args[2] = pub_key_x[2] as Field;
        serialized_args[3] = pub_key_x[3] as Field;
        serialized_args[4] = pub_key_x[4] as Field;
        serialized_args[5] = pub_key_x[5] as Field;
        serialized_args[6] = pub_key_x[6] as Field;
        serialized_args[7] = pub_key_x[7] as Field;
        serialized_args[8] = pub_key_x[8] as Field;
        serialized_args[9] = pub_key_x[9] as Field;
        serialized_args[10] = pub_key_x[10] as Field;
        serialized_args[11] = pub_key_x[11] as Field;
        serialized_args[12] = pub_key_x[12] as Field;
        serialized_args[13] = pub_key_x[13] as Field;
        serialized_args[14] = pub_key_x[14] as Field;
        serialized_args[15] = pub_key_x[15] as Field;
        serialized_args[16] = pub_key_x[16] as Field;
        serialized_args[17] = pub_key_x[17] as Field;
        serialized_args[18] = pub_key_x[18] as Field;
        serialized_args[19] = pub_key_x[19] as Field;
        serialized_args[20] = pub_key_x[20] as Field;
        serialized_args[21] = pub_key_x[21] as Field;
        serialized_args[22] = pub_key_x[22] as Field;
        serialized_args[23] = pub_key_x[23] as Field;
        serialized_args[24] = pub_key_x[24] as Field;
        serialized_args[25] = pub_key_x[25] as Field;
        serialized_args[26] = pub_key_x[26] as Field;
        serialized_args[27] = pub_key_x[27] as Field;
        serialized_args[28] = pub_key_x[28] as Field;
        serialized_args[29] = pub_key_x[29] as Field;
        serialized_args[30] = pub_key_x[30] as Field;
        serialized_args[31] = pub_key_x[31] as Field;
        serialized_args[32] = pub_key_y[0] as Field;
        serialized_args[33] = pub_key_y[1] as Field;
        serialized_args[34] = pub_key_y[2] as Field;
        serialized_args[35] = pub_key_y[3] as Field;
        serialized_args[36] = pub_key_y[4] as Field;
        serialized_args[37] = pub_key_y[5] as Field;
        serialized_args[38] = pub_key_y[6] as Field;
        serialized_args[39] = pub_key_y[7] as Field;
        serialized_args[40] = pub_key_y[8] as Field;
        serialized_args[41] = pub_key_y[9] as Field;
        serialized_args[42] = pub_key_y[10] as Field;
        serialized_args[43] = pub_key_y[11] as Field;
        serialized_args[44] = pub_key_y[12] as Field;
        serialized_args[45] = pub_key_y[13] as Field;
        serialized_args[46] = pub_key_y[14] as Field;
        serialized_args[47] = pub_key_y[15] as Field;
        serialized_args[48] = pub_key_y[16] as Field;
        serialized_args[49] = pub_key_y[17] as Field;
        serialized_args[50] = pub_key_y[18] as Field;
        serialized_args[51] = pub_key_y[19] as Field;
        serialized_args[52] = pub_key_y[20] as Field;
        serialized_args[53] = pub_key_y[21] as Field;
        serialized_args[54] = pub_key_y[22] as Field;
        serialized_args[55] = pub_key_y[23] as Field;
        serialized_args[56] = pub_key_y[24] as Field;
        serialized_args[57] = pub_key_y[25] as Field;
        serialized_args[58] = pub_key_y[26] as Field;
        serialized_args[59] = pub_key_y[27] as Field;
        serialized_args[60] = pub_key_y[28] as Field;
        serialized_args[61] = pub_key_y[29] as Field;
        serialized_args[62] = pub_key_y[30] as Field;
        serialized_args[63] = pub_key_y[31] as Field;

        context.call_public_function(context.this_address(), 0x598d0c9b, serialized_args);
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

    // TODO: does this need to be private?
    #[aztec(public)]
    fn entrypoint(payload: pub authwit::entrypoint::EntrypointPayload) {
        let actions = authwit::account::AccountActions::public(&mut context, ACCOUNT_ACTIONS_STORAGE_SLOT, is_valid_impl);
        actions.entrypoint(payload);
    }

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
        // TODO: touch id here 
        // // docs:start:entrypoint
        // // Load public key from storage
        // let storage = Storage::init(Context::private(context));
        // // docs:start:get_note
        // let public_key = storage.signing_public_key.get_note();
        // // docs:end:get_note
        // // Load auth witness
        // let witness: [Field; 64] = get_auth_witness(message_hash);
        // let mut signature: [u8; 64] = [0; 64];
        // for i in 0..64 { signature[i] = witness[i] as u8; }

        // // Verify signature of the payload bytes
        // let verification = std::schnorr::verify_signature(public_key.x, public_key.y, signature, message_hash.to_be_bytes(32));
        // assert(verification == true);
        // // docs:end:entrypoint
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

    /// @dev serialize the public function call as a field array 😥
    // internal fn _callInitialize(
    //     context: &mut aztec::context::PrivateContext,
    //     pub_key_x: [u8;32],
    //     pub_key_y: [u8;32]
    // ) {
    //     let mut serialized_args = [0; 64];
    //     serialized_args[0] = pub_key_x[0] as Field;
    //     serialized_args[1] = pub_key_x[1] as Field;
    //     serialized_args[2] = pub_key_x[2] as Field;
    //     serialized_args[3] = pub_key_x[3] as Field;
    //     serialized_args[4] = pub_key_x[4] as Field;
    //     serialized_args[5] = pub_key_x[5] as Field;
    //     serialized_args[6] = pub_key_x[6] as Field;
    //     serialized_args[7] = pub_key_x[7] as Field;
    //     serialized_args[8] = pub_key_x[8] as Field;
    //     serialized_args[9] = pub_key_x[9] as Field;
    //     serialized_args[10] = pub_key_x[10] as Field;
    //     serialized_args[11] = pub_key_x[11] as Field;
    //     serialized_args[12] = pub_key_x[12] as Field;
    //     serialized_args[13] = pub_key_x[13] as Field;
    //     serialized_args[14] = pub_key_x[14] as Field;
    //     serialized_args[15] = pub_key_x[15] as Field;
    //     serialized_args[16] = pub_key_x[16] as Field;
    //     serialized_args[17] = pub_key_x[17] as Field;
    //     serialized_args[18] = pub_key_x[18] as Field;
    //     serialized_args[19] = pub_key_x[19] as Field;
    //     serialized_args[20] = pub_key_x[20] as Field;
    //     serialized_args[21] = pub_key_x[21] as Field;
    //     serialized_args[22] = pub_key_x[22] as Field;
    //     serialized_args[23] = pub_key_x[23] as Field;
    //     serialized_args[24] = pub_key_x[24] as Field;
    //     serialized_args[25] = pub_key_x[25] as Field;
    //     serialized_args[26] = pub_key_x[26] as Field;
    //     serialized_args[27] = pub_key_x[27] as Field;
    //     serialized_args[28] = pub_key_x[28] as Field;
    //     serialized_args[29] = pub_key_x[29] as Field;
    //     serialized_args[30] = pub_key_x[30] as Field;
    //     serialized_args[31] = pub_key_x[31] as Field;
    //     serialized_args[32] = pub_key_y[0] as Field;
    //     serialized_args[33] = pub_key_y[1] as Field;
    //     serialized_args[34] = pub_key_y[2] as Field;
    //     serialized_args[35] = pub_key_y[3] as Field;
    //     serialized_args[36] = pub_key_y[4] as Field;
    //     serialized_args[37] = pub_key_y[5] as Field;
    //     serialized_args[38] = pub_key_y[6] as Field;
    //     serialized_args[39] = pub_key_y[7] as Field;
    //     serialized_args[40] = pub_key_y[8] as Field;
    //     serialized_args[41] = pub_key_y[9] as Field;
    //     serialized_args[42] = pub_key_y[10] as Field;
    //     serialized_args[43] = pub_key_y[11] as Field;
    //     serialized_args[44] = pub_key_y[12] as Field;
    //     serialized_args[45] = pub_key_y[13] as Field;
    //     serialized_args[46] = pub_key_y[14] as Field;
    //     serialized_args[47] = pub_key_y[15] as Field;
    //     serialized_args[48] = pub_key_y[16] as Field;
    //     serialized_args[49] = pub_key_y[17] as Field;
    //     serialized_args[50] = pub_key_y[18] as Field;
    //     serialized_args[51] = pub_key_y[19] as Field;
    //     serialized_args[52] = pub_key_y[20] as Field;
    //     serialized_args[53] = pub_key_y[21] as Field;
    //     serialized_args[54] = pub_key_y[22] as Field;
    //     serialized_args[55] = pub_key_y[23] as Field;
    //     serialized_args[56] = pub_key_y[24] as Field;
    //     serialized_args[57] = pub_key_y[25] as Field;
    //     serialized_args[58] = pub_key_y[26] as Field;
    //     serialized_args[59] = pub_key_y[27] as Field;
    //     serialized_args[60] = pub_key_y[28] as Field;
    //     serialized_args[61] = pub_key_y[29] as Field;
    //     serialized_args[62] = pub_key_y[30] as Field;
    //     serialized_args[63] = pub_key_y[31] as Field;

    //     context.call_public_function(context.this_address(), 0x598d0c9b, serialized_args);
    // }
}
