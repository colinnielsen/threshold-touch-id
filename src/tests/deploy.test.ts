import { AccountWallet, Contract, createAccount } from "@aztec/aztec.js";
import { createSandbox } from "@aztec/aztec-sandbox";
import { TouchIdContractContract } from "../contracts/types/TouchIdContract.js";

describe("private token contract", () => {
  let pxe: any;
  let stop: VoidFunction;
  let owner: AccountWallet;
  let recipient: AccountWallet;
  let contract: Contract;

  beforeAll(async () => {
    ({ pxe, stop } = await createSandbox());
  });

  beforeEach(async () => {
    [owner, recipient] = await Promise.all([
      createAccount(pxe),
      createAccount(pxe),
    ]);

    const deploymentTx = await TouchIdContractContract.deploy(pxe, [1], [2]);
  }, 30_000);

  // it("increases recipient funds on mint", async () => {
  //   const recipientAddress = recipient.getAddress();
  //   expect(
  //     await token.methods.balance_of_private(recipientAddress).view()
  //   ).toEqual(0n);

  //   const mintAmount = 20n;
  //   const secret = Fr.random();
  //   const secretHash = await computeMessageSecretHash(secret);
  //   const receipt = await token.methods
  //     .mint_private(mintAmount, secretHash)
  //     .send()
  //     .wait();

  //   const storageSlot = new Fr(5); // The storage slot of `pending_shields` is 5.
  //   const preimage = new NotePreimage([new Fr(mintAmount), secretHash]);
  //   await pxe.addNote(
  //     recipientAddress,
  //     token.address,
  //     storageSlot,
  //     preimage,
  //     receipt.txHash
  //   );

  //   await token.methods
  //     .redeem_shield(recipientAddress, mintAmount, secret)
  //     .send()
  //     .wait();
  //   expect(
  //     await token.methods.balance_of_private(recipientAddress).view()
  //   ).toEqual(20n);
  // }, 30_000);
});

// await main();
