import {
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
import { TokenContract } from "@aztec/noir-contracts/types";

import { format } from "util";

const { PXE_URL = "http://localhost:8080" } = process.env;

async function main() {
  ////////////// CREATE THE CLIENT INTERFACE AND CONTACT THE SANDBOX //////////////
  const logger = createDebugLogger("token");

  // We create PXE client connected to the sandbox URL
  const pxe = createPXEClient(PXE_URL);
  // Wait for sandbox to be ready
  await waitForSandbox(pxe);

  const nodeInfo = await pxe.getNodeInfo();

  logger(format("Aztec Sandbox Info ", nodeInfo));
}

await main();
