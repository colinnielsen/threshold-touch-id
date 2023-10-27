use dep::std::hash::{ pedersen_hash_with_separator };
use dep::aztec::{
    note::{
        note_header::NoteHeader,
        note_interface::NoteInterface,
        utils::compute_unique_siloed_note_hash,
    },
    oracle::{
        get_secret_key::get_secret_key,
        get_public_key::get_public_key,
    },
    log::emit_encrypted_log,
    context::PrivateContext,
    types::{ type_serialization::TypeSerializationInterface, address::AztecAddress },
};

global SPENDING_POLICY_SERIALIZED_LEN: Field = 3;

struct SpendingPolicy {
    token_address: Field,
    amount: Field,
    // the function signature of whatever the "balanceOf" function is on the token
    balance_of_sig: Field
}

fn deserializeSP (fields: [Field; SPENDING_POLICY_SERIALIZED_LEN]) -> SpendingPolicy {
    SpendingPolicy {
        token: AztecAddress::new(fields[0]),
        amount: fields[1],
        balance_of_sig: fields[2]
    }
}

fn serializeSP (spending_policy: SpendingPolicy) -> [Field; SPENDING_POLICY_SERIALIZED_LEN] {
    [spending_policy.token.address, spending_policy.amount, spending_policy.balance_of_sig]
}

global SpendingPolicySerializationMethods = TypeSerializationInterface {
    serialize: serializeSP,
    deserialize: deserializeSP
};

//
// IF SPENDING POLCIES EVER NEED TO BE PRIVATE 
//

// global SPENDING_POLICY_NOTE_LEN: Field = 3;

// struct SpendingPolicy {
//     amount: Field,
//     // the function signature of whatever the "balanceOf" function is on the token
//     balance_of_sig: Field,
//     owner: Field,
//     header: NoteHeader
// }

// impl SpendingPolicy {
//     pub fn new(amount: Field, balance_of_sig: Field, owner: Field) -> Self {
//         SpendingPolicy {
//             amount,
//             balance_of_sig,
//             owner,
//             header: NoteHeader::empty(),
//         }
//     }

//     pub fn serialize(self) -> [Field; SPENDING_POLICY_NOTE_LEN] {
//         [self.amount, self.balance_of_sig, self.owner]
//     }

//     pub fn set_header(&mut self, new_header: NoteHeader) {
//         self.header = new_header;
//     }

//     pub fn compute_nullifier(self) -> Field {
//         let unique_siloed_note_hash = compute_unique_siloed_note_hash(SpendingPolicyNoteMethods, self);
//         let secret = get_secret_key(self.owner);

//         pedersen_hash_with_separator([
//             unique_siloed_note_hash,
//             secret.low,
//             secret.high,
//         ],0)
//     }

//     pub fn broadcast(self, context: &mut PrivateContext, slot: Field) {
//         let encryption_pub_key = get_public_key(self.owner);
//         emit_encrypted_log(
//             context,
//             (*context).this_address(),
//             slot,
//             encryption_pub_key,
//             self.serialize(),
//         );
//     }
// }

// fn serialize(note: SpendingPolicy) -> [Field; SPENDING_POLICY_NOTE_LEN] {
//     [note.amount, note.balance_of_sig, note.owner]
// }

// fn deserialize(preimage: [Field; SPENDING_POLICY_NOTE_LEN]) -> SpendingPolicy {
//     SpendingPolicy {
//         amount: preimage[0],
//         balance_of_sig: preimage[1],
//         owner: preimage[2],
//         header: NoteHeader::empty(),
//     }
// }

// fn compute_note_hash(note: SpendingPolicy) -> Field {
//     pedersen_hash_with_separator(note.serialize(), 0)
// }

// fn compute_nullifier(note: SpendingPolicy) -> Field {
//     note.compute_nullifier()
// }

// fn get_header(note: SpendingPolicy) -> NoteHeader {
//     note.header
// }

// fn set_header(note: &mut SpendingPolicy, header: NoteHeader) {
//     note.set_header(header);
// }

// fn broadcast(context: &mut PrivateContext, slot: Field, note: SpendingPolicy) {
//     note.broadcast(context, slot);
// }

// global SpendingPolicyNoteMethods = NoteInterface {
//     compute_note_hash,
//     compute_nullifier,
//     deserialize,
//     get_header,
//     serialize,
//     set_header
// };