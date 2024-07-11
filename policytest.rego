package s3bucket

test_allow_access {
    allow with input as {
        "request": {
            "user": {
                "role": "st-access-role"
            }
        }
    }
}

test_deny_access {
    not allow with input as {
        "request": {
            "user": {
                "role": "other-role"
            }
        }
    }
}
