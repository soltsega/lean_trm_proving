"""Executable Python counterpart to the Lean safe-division definition."""

from __future__ import annotations

import math


def safe_div(numerator: int, denominator: int) -> int | None:
    """Return the natural-number floor quotient, or ``None`` for zero.

    The accepted domain mirrors Lean's ``Nat``: negative integers are rejected.
    """
    if numerator < 0 or denominator < 0:
        raise ValueError("safe_div expects natural numbers")
    if denominator == 0:
        return None
    return numerator // denominator


def _is_prime(value: int) -> bool:
    """Return whether value is prime, using trial division for this demo."""
    if value < 2:
        return False
    divisor = 2
    while divisor * divisor <= value:
        if value % divisor == 0:
            return False
        divisor += 1
    return True


def generate_keys(
    p: int, q: int, e: int = 65537
) -> tuple[tuple[int, int], tuple[int, int]]:
    """Generate public ``(e, n)`` and private ``(d, n)`` keys.

    This educational implementation uses trial division to check the input
    primes. It is intended only for small examples, not production RSA.
    """
    if not _is_prime(p) or not _is_prime(q):
        raise ValueError("p and q must both be prime")
    if p == q:
        raise ValueError("Primes p and q must be distinct")
    n = p * q
    totient = (p - 1) * (q - 1)
    if e <= 1 or e >= totient:
        raise ValueError("e must satisfy 1 < e < phi(n)")
    if math.gcd(e, totient) != 1:
        raise ValueError(f"e={e} is not coprime to phi(n)={totient}")
    d = pow(e, -1, totient)
    return (e, n), (d, n)


def encrypt(message: int, public_key: tuple[int, int]) -> int:
    """Encrypt a message with a public ``(e, n)`` key."""
    e, n = public_key
    if not 0 <= message < n:
        raise ValueError("Message must be in the range [0, n)")
    return pow(message, e, n)


def decrypt(ciphertext: int, private_key: tuple[int, int]) -> int:
    """Decrypt a ciphertext with a private ``(d, n)`` key."""
    d, n = private_key
    if not 0 <= ciphertext < n:
        raise ValueError("Ciphertext must be in the range [0, n)")
    return pow(ciphertext, d, n)


if __name__ == "__main__":
    examples = ((12, 3), (7, 2), (0, 5), (5, 0))
    for numerator, denominator in examples:
        print(f"safe_div({numerator}, {denominator}) = {safe_div(numerator, denominator)}")
    public_key, private_key = generate_keys(61, 53, 17)
    message = 42
    ciphertext = encrypt(message, public_key)
    recovered = decrypt(ciphertext, private_key)
    assert recovered == message
    print(f"RSA keys: public={public_key}, private={private_key}")
    print(f"message={message}, ciphertext={ciphertext}, decrypted={recovered}")
