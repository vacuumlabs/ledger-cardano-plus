sealed class LedgerCardanoResponseCodeException implements Exception {
  late int statusCode = switch (this) {
    // ── v7 ───────────────────────────────────────────────────────────────────
    WrongAppOpenedException(ledgerStatusCode: final ledgerStatusCode) => ledgerStatusCode,
    BadClaException() => 0x6E02,
    UnknownInstructionException() => 0x6E03,
    StillInCallException() => 0x6E04,
    InvalidRequestParametersException() => 0x6E05,
    InvalidStateException() => 0x6E06,
    InvalidDataException() => 0x6E07,
    InvalidBip44PathException() => 0x6E08,
    UserRejectedException() => 0x6E09,
    PolicyRejectedException() => 0x6E10,
    DeviceLockedException() => 0x6E11,
    // ── v8 ───────────────────────────────────────────────────────────────────
    InvalidAddressParamsException() => 0x6B06,
    InsufficientMemoryException() => 0x6A84,
    SwapException() => 0x6001,
    InvalidTxException(ledgerStatusCode: final ledgerStatusCode) => ledgerStatusCode,
    InvalidNativeScriptException(ledgerStatusCode: final ledgerStatusCode) => ledgerStatusCode,
    InvalidCVoteException(ledgerStatusCode: final ledgerStatusCode) => ledgerStatusCode,
    InvalidMessageSigningException(ledgerStatusCode: final ledgerStatusCode) => ledgerStatusCode,
    // ─────────────────────────────────────────────────────────────────────────
    UnknownResponseCodeException(ledgerStatusCode: final ledgerStatusCode) => ledgerStatusCode,
  };

  final String message;

  LedgerCardanoResponseCodeException({
    required this.message,
  });

  static LedgerCardanoResponseCodeException fromLedgerStatusCode(int statusCode) => switch (statusCode) {
    // ── v7 codes — 0x6EXX ────────────────────────────────────────────────────
    0x6E00 || 0x6E01 || 0x6A80 || 0x6A81 || 0x6A15 || 0x6511 => WrongAppOpenedException(ledgerStatusCode: statusCode),
    0x6E02 => BadClaException(),
    0x6E03 => UnknownInstructionException(),
    0x6E04 => StillInCallException(),
    0x6E05 => InvalidRequestParametersException(),
    0x6E06 => InvalidStateException(),
    0x6E07 => InvalidDataException(),
    0x6E08 => InvalidBip44PathException(),
    0x6E09 => UserRejectedException(),
    0x6E10 => PolicyRejectedException(),
    0x6E11 || 0x6B0C || 0x5515 => DeviceLockedException(),

    // ── v8 standard SDK codes ─────────────────────────────────────────────────
    0x6985 => UserRejectedException(),
    0x6982 => PolicyRejectedException(),
    0x6980 => InvalidStateException(),
    0x6D00 => UnknownInstructionException(),
    0x6A86 => InvalidRequestParametersException(),
    0x6A87 => InvalidDataException(),
    0x6A84 => InsufficientMemoryException(),

    // ── v8 Cardano-specific codes — 0x6BXX ───────────────────────────────────

    // BIP44 / address
    0x6B05 => InvalidBip44PathException(),
    0x6B06 => InvalidAddressParamsException(),

    // OpCert (same semantics as generic data errors)
    0x6B10 || 0x6B11 || 0x6B12 || 0x6B13 || 0x6B14 => InvalidDataException(),

    // Transaction
    0x6B00 => InvalidTxException(ledgerStatusCode: 0x6B00, detail: "invalid length"),
    0x6B01 => InvalidTxException(ledgerStatusCode: 0x6B01, detail: "parse failure"),
    0x6B02 => InvalidTxException(ledgerStatusCode: 0x6B02, detail: "malformed INIT APDU"),
    0x6B20 => InvalidTxException(ledgerStatusCode: 0x6B20, detail: "inputs"),
    0x6B21 => InvalidTxException(ledgerStatusCode: 0x6B21, detail: "outputs"),
    0x6B22 => InvalidTxException(ledgerStatusCode: 0x6B22, detail: "fee"),
    0x6B23 => InvalidTxException(ledgerStatusCode: 0x6B23, detail: "TTL"),
    0x6B24 => InvalidTxException(ledgerStatusCode: 0x6B24, detail: "certificates"),
    0x6B25 => InvalidTxException(ledgerStatusCode: 0x6B25, detail: "withdrawals"),
    0x6B28 => InvalidTxException(ledgerStatusCode: 0x6B28, detail: "validity interval start"),
    0x6B29 => InvalidTxException(ledgerStatusCode: 0x6B29, detail: "mint"),
    0x6B2B => InvalidTxException(ledgerStatusCode: 0x6B2B, detail: "script data hash"),
    0x6B2D => InvalidTxException(ledgerStatusCode: 0x6B2D, detail: "collateral inputs"),
    0x6B2E => InvalidTxException(ledgerStatusCode: 0x6B2E, detail: "required signers"),
    0x6B30 => InvalidTxException(ledgerStatusCode: 0x6B30, detail: "collateral output"),
    0x6B31 => InvalidTxException(ledgerStatusCode: 0x6B31, detail: "total collateral"),
    0x6B32 => InvalidTxException(ledgerStatusCode: 0x6B32, detail: "reference inputs"),
    0x6B33 => InvalidTxException(ledgerStatusCode: 0x6B33, detail: "voting procedures"),
    0x6B35 => InvalidTxException(ledgerStatusCode: 0x6B35, detail: "treasury"),
    0x6B36 => InvalidTxException(ledgerStatusCode: 0x6B36, detail: "donation"),
    0x6B37 => InvalidTxException(ledgerStatusCode: 0x6B37, detail: "invalid network ID"),
    0x6B38 => InvalidTxException(ledgerStatusCode: 0x6B38, detail: "invalid protocol magic"),
    0x6B39 => InvalidTxException(ledgerStatusCode: 0x6B39, detail: "inclusion flag"),
    0x6B3A => InvalidTxException(ledgerStatusCode: 0x6B3A, detail: "buffer not fully consumed"),
    0x6B3B => InvalidTxException(ledgerStatusCode: 0x6B3B, detail: "CBOR canonical order"),
    0x6B3C => InvalidTxException(ledgerStatusCode: 0x6B3C, detail: "invalid signing mode"),
    0x6B3D => InvalidTxException(ledgerStatusCode: 0x6B3D, detail: "ambiguous signing mode"),

    // Native script
    0x6B41 => InvalidNativeScriptException(ledgerStatusCode: 0x6B41, detail: "pubkey credential"),
    0x6B42 => InvalidNativeScriptException(ledgerStatusCode: 0x6B42, detail: "script type"),
    0x6B43 => InvalidNativeScriptException(ledgerStatusCode: 0x6B43, detail: "nesting"),
    0x6B44 => InvalidNativeScriptException(ledgerStatusCode: 0x6B44, detail: "timelock"),
    0x6B45 => InvalidNativeScriptException(ledgerStatusCode: 0x6B45, detail: "depth unsupported"),
    0x6B46 => InvalidNativeScriptException(ledgerStatusCode: 0x6B46, detail: "script count"),
    0x6B47 => InvalidNativeScriptException(ledgerStatusCode: 0x6B47, detail: "display format"),

    // CVote
    0x6B50 => InvalidCVoteException(ledgerStatusCode: 0x6B50, detail: "aux data parse failure"),
    0x6B51 => InvalidCVoteException(ledgerStatusCode: 0x6B51, detail: "vote plan ID"),
    0x6B52 => InvalidCVoteException(ledgerStatusCode: 0x6B52, detail: "proposal index"),
    0x6B53 => InvalidCVoteException(ledgerStatusCode: 0x6B53, detail: "payload type tag"),
    0x6B54 => InvalidCVoteException(ledgerStatusCode: 0x6B54, detail: "remaining votecast bytes"),

    // Message signing
    0x6B60 => InvalidMessageSigningException(ledgerStatusCode: 0x6B60, detail: "message length"),
    0x6B61 => InvalidMessageSigningException(ledgerStatusCode: 0x6B61, detail: "signing path"),
    0x6B62 => InvalidMessageSigningException(ledgerStatusCode: 0x6B62, detail: "hash payload flag"),
    0x6B63 => InvalidMessageSigningException(ledgerStatusCode: 0x6B63, detail: "isAscii flag"),
    0x6B64 => InvalidMessageSigningException(ledgerStatusCode: 0x6B64, detail: "address field type"),
    0x6B65 => InvalidMessageSigningException(ledgerStatusCode: 0x6B65, detail: "address params"),
    0x6B66 => InvalidMessageSigningException(ledgerStatusCode: 0x6B66, detail: "chunk size"),
    0x6B67 => InvalidMessageSigningException(ledgerStatusCode: 0x6B67, detail: "chunk data"),
    0x6B68 => InvalidMessageSigningException(ledgerStatusCode: 0x6B68, detail: "invalid chunk size"),
    0x6B69 => InvalidMessageSigningException(ledgerStatusCode: 0x6B69, detail: "invalid ASCII"),
    0x6B6A => InvalidMessageSigningException(ledgerStatusCode: 0x6B6A, detail: "invalid address field type"),
    0x6B6B => InvalidMessageSigningException(ledgerStatusCode: 0x6B6B, detail: "confirm APDU must be empty"),

    // Swap
    0x6001 => SwapException(),

    _ => UnknownResponseCodeException(ledgerStatusCode: statusCode),
  };
}

// ── v7 exception classes ──────────────────────────────────────────────────────

class WrongAppOpenedException extends LedgerCardanoResponseCodeException {
  final int ledgerStatusCode;
  WrongAppOpenedException({required this.ledgerStatusCode}) : super(message: "Wrong app opened on Ledger device");
}

class BadClaException extends LedgerCardanoResponseCodeException {
  BadClaException() : super(message: "Bad CLA (Command Link Assurance)");
}

class UnknownInstructionException extends LedgerCardanoResponseCodeException {
  UnknownInstructionException() : super(message: "Unknown instruction");
}

class StillInCallException extends LedgerCardanoResponseCodeException {
  StillInCallException() : super(message: "Still in call");
}

class InvalidRequestParametersException extends LedgerCardanoResponseCodeException {
  InvalidRequestParametersException() : super(message: "Invalid request parameters");
}

class InvalidStateException extends LedgerCardanoResponseCodeException {
  InvalidStateException() : super(message: "Invalid state");
}

class InvalidDataException extends LedgerCardanoResponseCodeException {
  InvalidDataException() : super(message: "Invalid data");
}

class InvalidBip44PathException extends LedgerCardanoResponseCodeException {
  InvalidBip44PathException() : super(message: "Invalid BIP44 path");
}

class UserRejectedException extends LedgerCardanoResponseCodeException {
  UserRejectedException() : super(message: "Rejected by user");
}

class PolicyRejectedException extends LedgerCardanoResponseCodeException {
  PolicyRejectedException() : super(message: "Rejected by policy");
}

class DeviceLockedException extends LedgerCardanoResponseCodeException {
  DeviceLockedException() : super(message: "Device is locked");
}

// ── v8 exception classes ──────────────────────────────────────────────────────

class InvalidAddressParamsException extends LedgerCardanoResponseCodeException {
  InvalidAddressParamsException() : super(message: "Invalid address parameters");
}

class InsufficientMemoryException extends LedgerCardanoResponseCodeException {
  InsufficientMemoryException() : super(message: "Insufficient memory on device");
}

class SwapException extends LedgerCardanoResponseCodeException {
  SwapException() : super(message: "Swap parameter validation failed");
}

class InvalidTxException extends LedgerCardanoResponseCodeException {
  final int ledgerStatusCode;
  InvalidTxException({required this.ledgerStatusCode, required String detail})
      : super(message: "Invalid transaction: $detail");
}

class InvalidNativeScriptException extends LedgerCardanoResponseCodeException {
  final int ledgerStatusCode;
  InvalidNativeScriptException({required this.ledgerStatusCode, required String detail})
      : super(message: "Invalid native script: $detail");
}

class InvalidCVoteException extends LedgerCardanoResponseCodeException {
  final int ledgerStatusCode;
  InvalidCVoteException({required this.ledgerStatusCode, required String detail})
      : super(message: "Invalid CVote data: $detail");
}

class InvalidMessageSigningException extends LedgerCardanoResponseCodeException {
  final int ledgerStatusCode;
  InvalidMessageSigningException({required this.ledgerStatusCode, required String detail})
      : super(message: "Invalid message signing data: $detail");
}

// ─────────────────────────────────────────────────────────────────────────────

class UnknownResponseCodeException extends LedgerCardanoResponseCodeException {
  final int ledgerStatusCode;
  UnknownResponseCodeException({required this.ledgerStatusCode}) : super(message: "Unknown error code");
}
