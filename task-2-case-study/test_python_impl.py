"""Dynamic checks for the Python safe-division counterpart."""

import unittest

from python_impl import safe_div


class SafeDivTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(safe_div(12, 3), 4)
        self.assertEqual(safe_div(7, 2), 3)
        self.assertEqual(safe_div(0, 5), 0)

    def test_zero_denominator(self) -> None:
        self.assertIsNone(safe_div(5, 0))
        self.assertIsNone(safe_div(0, 0))

    def test_quotient_bounds_for_bounded_inputs(self) -> None:
        for numerator in range(20):
            for denominator in range(1, 20):
                quotient = safe_div(numerator, denominator)
                if quotient is None:
                    self.fail("positive denominator unexpectedly produced None")
                self.assertLessEqual(quotient * denominator, numerator)
                self.assertLess(numerator, (quotient + 1) * denominator)

    def test_negative_inputs_are_rejected(self) -> None:
        for numerator, denominator in ((-1, 2), (1, -2), (-1, -2)):
            with self.subTest(numerator=numerator, denominator=denominator):
                with self.assertRaises(ValueError):
                    safe_div(numerator, denominator)


if __name__ == "__main__":
    unittest.main()
