# AWS

---

## Warning
I wouldn't recommend this provider as (updating) reconciliation on details (such as tags) nonexistent with my tests.

Perhaps use [jet-aws](../jet-aws) instead.

---

We put manifests here for aws in this example.
It's same level as [mock-cloud](../mock-cloud) but just for different provider.

## Verifications
- `make verify`

## Test Automatic Recovery by Crossplane
- `make test-recovery` 

Think an accidental deletion from honest mistakes and it will be mitigated quickly by Crossplane's continuous reconciliation.
