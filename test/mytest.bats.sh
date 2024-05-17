#!/usr/bin/env bats

setup() {
  load ../lib/bsfl.sh
  load ../lib/ext_bsfl.sh
}
#load ../lib/bsfl.sh

@test "test_directory_exist_fun_should_ok" {
  run directory_exists "/home/nome/autodg"
  [ "$output" == ''  ]

}

@test "test_/tmp_exists_ok" {
  [  -d '/tmp' ]
}

@test "test_/tmpa_not_exists_ok" {
  [ ! -d '/tmpa' ]
}
