# Docker up and login

`docker-compose up -d`

`docker exec -it rperl-regex-bug_rperl_1 bash`

# Module implementation
Install dependencies

`cpanm Const::Fast`

# Module implementation
The code works, but PARALLEL is not honored
Verify by looking at runtime and processor usage

`rm -rf _Inline/ && prove -I lib/ t/01-basic.t -v`

# Executable implementation
## perl
Regular Perl report the expected output

`rm -rf _Inline/ && perl bin/rperl-re-list-matcher.pl`

## RPerl
RPerl will not match m/$expression/xmsi

`rm -rf _Inline/ && rperl bin/rperl-re-list-matcher.pl`
