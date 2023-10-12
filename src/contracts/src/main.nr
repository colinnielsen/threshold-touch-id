contract TouchIdContract {
    use dep::std;
    use dep::std::option::Option;

    use dep::aztec::{
        context::{Context, PrivateContext},
        state_vars::public_state::PublicState,
    };
    use dep::authwit::{
        entrypoint::{ EntrypointPayload, ENTRYPOINT_PAYLOAD_SIZE },
        account::AccountActions,
        auth_witness::get_auth_witness,
    };

    struct Storage {
        pub_key_x: [u8; 32],
        pub_key_y: [u8; 32],
    }
    
    impl Storage {
        fn init(_ctx: Context) -> pub Self {
            Storage {
                pub_key_x: [0; 32],
                pub_key_y: [0; 32]
            }
        }
    }

    #[aztec(private)]
    fn constructor(pub_key_x: [u8; 32], pub_key_y: [u8; 32]) {
        let mut x = storage.pub_key_x;
        let mut y = storage.pub_key_y;

        x = pub_key_x;
        y = pub_key_y;
    }

    #[aztec(private)]
    fn entrypoint(payload: pub EntrypointPayload) {
        let actions = AccountActions::private(&mut context, 2, is_valid_impl);
        actions.entrypoint(payload);
    }

    #[contract_library_method]
    fn is_valid_impl(context: &mut PrivateContext, message_hash: Field) -> pub bool {
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
    * @dev return the pub key x,y as a tuple
    */
    unconstrained fn get_keys() -> ([u8; 32], [u8; 32]) {
        (storage.pub_key_x, storage.pub_key_y)
    }
}
