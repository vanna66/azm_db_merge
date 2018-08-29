python azm_db_merge.py --azm_file "example_logs/" --target_db_type postgresql --server_user kasidit --server_database azqdb --server_password pass --call_preprocess_func_in_module_before_import "example_preprocess_module.py"


Please help i got error

checking --sqlite3_executable:  sqlite3
error - sqlite3 check exception estr:  [Errno 2] No such file or directory
Traceback (most recent call last):
  File "azm_db_merge.py", line 943, in <module>
    ret = call(cmd, shell=False)
  File "/usr/lib/python2.7/subprocess.py", line 172, in call
    return Popen(*popenargs, **kwargs).wait()
  File "/usr/lib/python2.7/subprocess.py", line 394, in __init__
    errread, errwrite)
  File "/usr/lib/python2.7/subprocess.py", line 1047, in _execute_child
    raise child_exception
OSError: [Errno 2] No such file or directory
