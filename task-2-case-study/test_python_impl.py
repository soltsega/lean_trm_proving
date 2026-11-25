"""Dynamic checks for the Python safe-division counterpart."""

import unittest

from python_impl import decrypt, encrypt, generate_keys, safe_div


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


class ToyRSATests(unittest.TestCase):
    def test_round_trip_for_every_message(self) -> None:
        public_key, private_key = generate_keys(3, 11, 3)
        for message in range(33):
            with self.subTest(message=message):
                ciphertext = encrypt(message, public_key)
                self.assertEqual(decrypt(ciphertext, private_key), message)

    def test_ciphertext_is_in_residue_range(self) -> None:
        public_key, _ = generate_keys(3, 11, 3)
        for message in range(33):
            ciphertext = encrypt(message, public_key)
            self.assertGreaterEqual(ciphertext, 0)
            self.assertLess(ciphertext, 33)

    def test_out_of_range_values_are_rejected(self) -> None:
        public_key, private_key = generate_keys(3, 11, 3)
        for function, key in ((encrypt, public_key), (decrypt, private_key)):
            for value in (-1, 33):
                with self.subTest(function=function.__name__, value=value):
                    with self.assertRaises(ValueError):
                        function(value, key)

    def test_another_small_valid_key(self) -> None:
        # p=5, q=7, n=35, phi(n)=24, e=5, d=5; e*d = 25 = 1 mod 24.
        public_key, private_key = generate_keys(5, 7, 5)
        for message in range(35):
            self.assertEqual(decrypt(encrypt(message, public_key), private_key), message)

    def test_key_generation_rejects_invalid_inputs(self) -> None:
        invalid_inputs = ((9, 11, 3), (3, 3, 3), (3, 11, 2), (3, 11, 6))
        for args in invalid_inputs:
            with self.subTest(args=args):
                with self.assertRaises(ValueError):
                    generate_keys(*args)

    def test_sample_key_and_message(self) -> None:
        public_key, private_key = generate_keys(61, 53, 17)
        self.assertEqual(public_key, (17, 3233))
        self.assertEqual(private_key, (2753, 3233))
        ciphertext = encrypt(42, public_key)
        self.assertEqual(decrypt(ciphertext, private_key), 42)


if __name__ == "__main__":
    unittest.main()
