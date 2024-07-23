package s3bucket

default allow = false

allow {
    input.request.user.role == "st-access-role"
}
allow {
    input.request.user.role == "st-admin-role"
}

