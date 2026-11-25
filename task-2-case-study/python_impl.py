"""Executable Python counterpart to the Lean safe-division definition."""

from __future__ import annotations


def safe_div(numerator: int, denominator: int) -> int | None:
    """Return the natural-number floor quotient, or ``None`` for zero.

    The accepted domain mirrors Lean's ``Nat``: negative integers are rejected.
    """
    if numerator < 0 or denominator < 0:
        raise ValueError("safe_div expects natural numbers")
    if denominator == 0:
        return None
    return numerator // denominator


if __name__ == "__main__":
    examples = ((12, 3), (7, 2), (0, 5), (5, 0))
    for numerator, denominator in examples:
        print(f"safe_div({numerator}, {denominator}) = {safe_div(numerator, denominator)}")
