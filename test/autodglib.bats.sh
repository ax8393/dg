#!/usr/bin/env bats
#setup first
setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
  load '../src/lib/bsfl.sh'
  load '../src/lib/ext_bsfl.sh'
  load '../src/lib/autodglib.sh'
  if [ ! -d ../tmp ]; then
    mkdir ../tmp
  else
    # rm -rf ../tmp/*
    echo ""
  fi
#  rm -f ./pri_convert.txt
#  rm -f ./dg_convert.txt

}

@test "check_path_ends_with_slash_ok" {
  run check_path_ends_with_slash '../src/para.cfg'
  assert_output ""
}

#  "oracle_base_pr=/u01/app/oracle/" should be returned.
@test "check_path_ends_with_slash_fail" {
  run check_path_ends_with_slash '../src/para2.cfg'
#  refute_output ""
  assert_output -p "oracle_base_pr=/u01/app/oracle/"
}
#
@test "test_end_with_slash_ok" {

  run end_with "abc/" "/"
  [ "$status" -eq 0 ]
  [ "$output" == "" ]
}
@test "test_end_with_slash_fail" {
  run end_with "abc/c" "/"
  [ "$status" -eq 1 ]
  [ "$output" == "" ]
}

@test "test_get_one_row_data_ok" {
  run get_one_row_data  "../tmp/dbname.tmp" "../tmp/dbname.txt"
  assert_output  "ctp"
  # [ "$output" == "ctp" ]
  # [ `cat tmp/dbname.txt`  == "ctp" ]
}

@test "test_get_one_row_data_fail_nofile" {
  run get_one_row_data "../tmp/nofile.tmp" "../tmp/nofile.txt"
  assert_output ""
  [ ! -f "../tmp/nofile.txt" ]
}
@test "test_get_one_row_data_fail_nodata" {
  run get_one_row_data "../tmp/empty.tmp" "../tmp/empty.txt"
  assert_output ""
  [ ! -f "../tmp/empty.txt" ]
}

@test "test_get_multiple_row_data_ok" {
  run get_multiple_row_data "../tmp/dbpath.tmp" "../tmp/dbpath.txt"
  assert_output -p "/u02/oradata/ctp"
  [ -f ../tmp/dbpath.txt ]
}
@test "test_get_multiple_row_+asm_ok" {
  run get_multiple_row_data "../tmp/dbpath-asm.tmp" "../tmp/dbpath-asm.txt"
  assert_output -p "+DATA/ctp/datafile/data2"
  assert_output -p "+DATA/ctp/datafile"
  assert_output -p "+DATA/ctp/tempfile"
  [ -f ../tmp/dbpath-asm.txt ]
}
@test "test_get_diskgroup_name_ok" {
  run get_diskgroup_name "../tmp/dbpath-asm.tmp" "../tmp/dg.txt"
  assert_output "+DATA"
}

@test "makeup_file_convert_fail" {
  run makeup_file_convert '../tmp/nofile-dbpath.txt' '/u03/oradata/orcldg' '../tmp/pri_convert.txt' '../tmp/dg_convert.txt'
  assert_failure
  
}
@test "makeup_file_convert_ok" {
  run makeup_file_convert '../tmp/dbpath.txt' '/u03/oradata/orcldg' '../tmp/pri_convert.txt' '../tmp/dg_convert.txt'
  assert_success
  
}

@test "makeup_convert_oneline_fail" {
  run makeup_convert_oneline '../tmp/pri_convert_no.txt' '../tmp/pri_convert_oneline.txt'
  assert_failure
}

@test "makeup_convert_oneline_ok" {
  run makeup_convert_oneline '../tmp/pri_convert.txt' '../tmp/pri_convert_oneline.txt'
  assert_success
  [ -f ../tmp/pri_convert_oneline.txt ]
}
## teardown cleanup 
teardown() {
  echo ""
#  rm -f ../tmp/*.txt
#  echo "teardown"
}

