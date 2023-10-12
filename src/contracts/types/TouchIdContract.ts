
/* Autogenerated file, do not edit! */

/* eslint-disable */
import { AztecAddress, CompleteAddress, Contract, ContractBase, ContractFunctionInteraction, ContractMethod, DeployMethod, EthAddress, FieldLike, AztecAddressLike, EthAddressLike, Wallet } from '@aztec/aztec.js';
import { Fr, Point } from '@aztec/foundation/fields';
import { PXE, PublicKey } from '@aztec/types';
import { ContractArtifact } from '@aztec/foundation/abi';
import TouchIdContractContractArtifactJson from '../target/TouchIdContract.json' assert { type: 'json' };
export const TouchIdContractContractArtifact = TouchIdContractContractArtifactJson as ContractArtifact;

/**
 * Type-safe interface for contract TouchIdContract;
 */
export class TouchIdContractContract extends ContractBase {
  
  private constructor(
    completeAddress: CompleteAddress,
    wallet: Wallet,
    portalContract = EthAddress.ZERO
  ) {
    super(completeAddress, TouchIdContractContractArtifact, wallet, portalContract);
  }
  

  
  /**
   * Creates a contract instance.
   * @param address - The deployed contract's address.
   * @param wallet - The wallet to use when interacting with the contract.
   * @returns A promise that resolves to a new Contract instance.
   */
  public static async at(
    address: AztecAddress,
    wallet: Wallet,
  ) {
    return Contract.at(address, TouchIdContractContract.artifact, wallet) as Promise<TouchIdContractContract>;
  }

  
  /**
   * Creates a tx to deploy a new instance of this contract.
   */
  public static deploy(pxe: PXE, pub_key_x: (bigint | number)[], pub_key_y: (bigint | number)[]) {
    return new DeployMethod<TouchIdContractContract>(Point.ZERO, pxe, TouchIdContractContractArtifact, Array.from(arguments).slice(1));
  }

  /**
   * Creates a tx to deploy a new instance of this contract using the specified public key to derive the address.
   */
  public static deployWithPublicKey(pxe: PXE, publicKey: PublicKey, pub_key_x: (bigint | number)[], pub_key_y: (bigint | number)[]) {
    return new DeployMethod<TouchIdContractContract>(publicKey, pxe, TouchIdContractContractArtifact, Array.from(arguments).slice(2));
  }
  

  
  /**
   * Returns this contract's artifact.
   */
  public static get artifact(): ContractArtifact {
    return TouchIdContractContractArtifact;
  }
  

  /** Type-safe wrappers for the public methods exposed by the contract. */
  public methods!: {
    
    /** entrypoint(payload: struct) */
    entrypoint: ((payload: { function_calls: { args_hash: FieldLike, function_selector: FieldLike, target_address: FieldLike, is_public: boolean }[], nonce: FieldLike }) => ContractFunctionInteraction) & Pick<ContractMethod, 'selector'>;

    /** get_keys() */
    get_keys: (() => ContractFunctionInteraction) & Pick<ContractMethod, 'selector'>;
  };
}
