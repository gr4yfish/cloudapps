# Independent F5 Host Header Redirect Verification

## Purpose
This repository provides independent, reproducible proof that BIG‑IP issues redirects based on the HTTP `Host` header.

## Method
Two HTTPS requests are sent to the same URI and TLS endpoint. Redirect following is disabled. Only the HTTP `Host` header differs.

## Expected results

| Test | Host header | Expected first response |
|----|----|----|
| Test 1 | www2.sahealth.ha.sa.gov.au | 302 → auth.sahealth.sa.gov.au (ADFS) |
| Test 2 | www.sahealth.sa.gov.au | 302 → public sahealth.sa.gov.au |

## Conclusion
Redirect logic is enforced at the BIG‑IP layer (LTM policy / iRule / HTTP profile) prior to backend application selection.

## How to run
1. Open GitHub Actions
2. Select **Independent Verification – F5 Host Header Redirects**
3. Click **Run workflow**

All output is timestamped and retained by GitHub.
