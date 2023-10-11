contract Main {

    use dep::aztec::context::Context;

    struct Storage {
        number: Field,
    }
    
    impl Storage {
        fn init(_ctx: Context) -> pub Self {
            Storage {
                number: 1
            }
        }
    }

    unconstrained fn get_storage() -> pub Field {
        storage.number
    }
}
