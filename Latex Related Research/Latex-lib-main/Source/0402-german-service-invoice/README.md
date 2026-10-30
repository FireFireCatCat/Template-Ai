# German Service Invoice

A German service-invoice starter following the data/document split of
`d-koppenhagen/latex-rechnung`. Sender, customer, bank and payment fields live
in `invoice-data.tex`; the document and itemised service rows are in
`main.tex`. The `invoice` package calculates the service subtotal and discount
from the line items.

The example is original and uses fictional parties. Replace the values in
`invoice-data.tex` before sending an invoice, and have the tax treatment
reviewed for your jurisdiction.

The upstream `latex-rechnung` repository is GPL-2.0, with no non-commercial
restriction: https://github.com/d-koppenhagen/latex-rechnung
The `invoice` package itself is supplied by TeX Live.

## Build

    pdflatex main
