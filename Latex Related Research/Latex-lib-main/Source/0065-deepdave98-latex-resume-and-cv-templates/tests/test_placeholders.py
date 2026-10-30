"""Tests for the placeholder integration checker; no TeX or Poppler required."""

from contextlib import redirect_stderr
from io import StringIO
import unittest
from unittest.mock import patch

import check_placeholders as checker


class PlaceholderCheckerTests(unittest.TestCase):
    def test_reminders_extract_only_class_placeholder_warnings(self):
        log = "\n".join([
            "Package hyperref Warning: unrelated warning",
            checker.WARNING + "entry 3 bullets.",
            "(resume) Replace sample values and bracketed prompts before sharing on input line 24.",
            checker.WARNING + "contact details.",
        ])
        self.assertEqual(checker.reminders(log), ["entry 3 bullets.", "contact details."])

    def test_missing_tools_return_actionable_failure(self):
        output = StringIO()
        with patch.object(checker.shutil, "which", return_value=None), redirect_stderr(output):
            self.assertEqual(checker.main(), 1)
        self.assertIn("xelatex, pdftotext", output.getvalue())
        self.assertIn("Install XeLaTeX and Poppler", output.getvalue())

    def test_failed_integration_tests_return_failure(self):
        with patch.object(checker.shutil, "which", return_value="tool"):
            with patch.object(checker.unittest, "TextTestRunner") as runner:
                runner.return_value.run.return_value.wasSuccessful.return_value = False
                self.assertEqual(checker.main(), 1)

    def test_successful_integration_tests_return_success(self):
        with patch.object(checker.shutil, "which", return_value="tool"):
            with patch.object(checker.unittest, "TextTestRunner") as runner:
                runner.return_value.run.return_value.wasSuccessful.return_value = True
                self.assertEqual(checker.main(), 0)


if __name__ == "__main__":
    unittest.main()
