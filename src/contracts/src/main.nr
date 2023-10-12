contract TouchIdContract {
    use dep::std;
    use dep::aztec::context::Context;

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

    /**
    * @dev return the pub key x,y as a tuple
    */
    unconstrained fn get_keys() -> ([u8; 32], [u8; 32]) {
        (storage.pub_key_x, storage.pub_key_y)
    }
}
