"""Executable reference implementation for the safe-division case study."""

from __future__ import annotations

from typing import Optional


def safe_div(numerator: int, denominator: int) -> Optional[int]:
    """Return floor(numerator / denominator), or None for a zero denominator.

    The inputs model Lean's natural numbers, so negative values are rejected.
    """
    if numerator < 0 or denominator < 0:
        raise ValueError("safe_div expects natural numbers")
    if denominator == 0:
        return None
    return numerator // denominator


def _self_test() -> None:
    """Run representative examples and a bounded comparison to the contract."""
    assert safe_div(12, 3) == 4
    assert safe_div(7, 2) == 3
    assert safe_div(0, 5) == 0
    assert safe_div(5, 0) is None
    for numerator in range(20):
        for denominator in range(20):
            result = safe_div(numerator, denominator)
            if denominator == 0:
                assert result is None
            else:
                assert result == numerator // denominator
                assert result * denominator <= numerator
                assert numerator < (result + 1) * denominator


if __name__ == "__main__":
    _self_test()
    print("safe_div examples and bounded checks passed")

