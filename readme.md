
# Cloud Security Engineer Challenge

## Description

This repository contains the OPA policy for controlling access to an S3 bucket based on user roles.

## Files

- `policy.rego`: The REGO policy for access control.
- `policy_test.rego`: Test cases for the policy.
- `input_allow.json`: Test input JSON to allow access.
- `input_deny.json`: Test input JSON to deny access.

## Usage

1. Install OPA from [Open Policy Agent](https://www.openpolicyagent.org/docs/latest/#1-download-opa).
2. Run the tests using the command:
    ```sh
    opa test policy.rego policy_test.rego
    ```

## Policy

### policy.rego

```rego
package s3bucket

default allow = false

allow {
    input.request.user.role == "st-access-role"
}













#  Edge Cases


1. Missing Role Input:
-If the user's role is not provided in the input, the policy should deny access by default.

-This ensures that incomplete or malformed requests do not inadvertently bypass the policy.

2. Role Case Sensitivity:

The policy checks for the role st-access-role in a case-sensitive manner. Ensure role names in the IAM system match exactly.
Consider normalizing roles to lowercase in both policy and input to avoid case mismatch issues.
3. Unexpected Input Structure:

-If the input JSON structure deviates from the expected format, the policy should handle such cases gracefully and deny access.
-Implement input validation to ensure that the structure conforms to the expected schema.

## Potential Bypass Techniques
1.Role Spoofing:

-An attacker could attempt to inject a different role in the input.
-Ensure that the source of the role information is trustworthy and cannot be manipulated.

2. Policy Misconfiguration:

Incorrectly specifying the role or policy conditions could allow unintended access.
Regularly review and audit policies to ensure they reflect the intended access controls.
Logging and Monitoring
Logging
Implement logging within the policy to capture access requests and policy decisions.

Use OPA's built-in logging capabilities or integrate with external logging systems such as AWS CloudWatch.

Monitoring
Set up monitoring to detect and alert on policy violations or anomalies.
Use AWS CloudWatch or similar monitoring tools to track policy enforcement and access patterns.
Implement alerts for unauthorized access attempts or policy errors.
Assumptions
The input JSON structure represents a typical AWS IAM access request with a nested user role.
The role st-access-role is predefined and assigned to users who should have access to the S3 bucket.
The policy is case-sensitive regarding role names, and roles are specified exactly as defined.
All access requests are authenticated, and the role information is reliable and tamper-proof.
