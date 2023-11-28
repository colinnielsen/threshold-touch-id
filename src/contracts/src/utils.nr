use dep::aztec;

pub fn _callInitialize(
    context: &mut aztec::context::PrivateContext,
    pub_key_x: [u8; 32],
    pub_key_y: [u8; 32]
) {
    let mut serialized_args = [0; 64];
    for i in 0..64 {
        if (i < 32 as u8) { serialized_args[i] = pub_key_x[i] as Field; }
        else { serialized_args[i] = pub_key_y[i - 32] as Field; }
    }

    context.call_public_function(context.this_address(), 0x598d0c9b, serialized_args);
}
