import {
  AccountWallet,
  Contract,
  Fr,
  NotePreimage,
  PXE,
  computeMessageSecretHash,
  createDebugLogger,
  createPXEClient,
  getSandboxAccountsWallets,
  getSchnorrAccount,
  waitForSandbox,
} from "@aztec/aztec.js";
import { GrumpkinScalar } from "@aztec/circuits.js";
import { readFileSync, writeFileSync } from "fs";
import {
  compileUsingNargo,
  generateTypescriptContractInterface,
} from "@aztec/noir-compiler";

import { format } from "util";

const { PXE_URL = "http://localhost:8080" } = process.env;

describe("private token contract", () => {
  let pxe: PXE;
  let owner: AccountWallet;
  let recipient: AccountWallet;
  let contract: Contract;

  beforeEach(async () => {
    pxe = createPXEClient(PXE_URL);
    [owner, recipient] = await getSandboxAccountsWallets(pxe);

    const compiled = await compileUsingNargo("../contracts/");
    const abiImportPath = "../contracts/threshold_touch_id/target/Main.json";
    writeFileSync(
      "./Main.ts",
      generateTypescriptContractInterface(compiled[0], abiImportPath)
    );
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

await main();
