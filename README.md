azm_db_merge 
============

Import all LTE/WCDMA/GSM test data (radio parameters, Layer-3 messages, etc) from [AZENQOS Android](http://www.azenqos.com) test logs (.azm files) into a target database for further Big data or radio analysis/research/reporting uses.

Notes:
- A ".azm" file is simply a renamed zip file so you can open/extract with
any zip manager software to view the azqdata.db file with any SQLite3 browser program on PC. (If you don't see this file in your .azm logs, go to AZENQOS app > Settings > Enable Database Logging to enable this feature).
- Required AZENQOS Android app version: v579 (3.0.579) or newer.
- Some logs are provided in the 'example_logs' folder.
- The full list of the parameters and their tables is available at:
https://docs.google.com/spreadsheets/d/1ddl-g_qyoMYLF8PMkjrYPrpXusdinTZxsWLQOzJ6xu8/edit?usp=sharing
- The Layer-3 messages are in the 'signalling' table and the events are in the 'events' table.

Please follow [SETUP.md](https://github.com/freewillfx-azenqos/azm_db_merge/blob/master/SETUP.md) to setup all requirements/dependencies first.

For a full list of options plesase use cmd:
python azm_db_merge.py --help

The current azm_db_merge support for PostgreSQL and Microsoft SQL Server implementation (through pyodbc + "SQL Server Natve Client 11.0" ODBC driver)
 has full support for all azm_db_merge features:
- auto table create
- if table already exists in server, auto add of coulmns found in .azm to server
- very fast import speed through bulk insert operations. (A 1 hour lte/wcdma drive takes about 10 seconds to import for MSSQL and around 4.3 seconds for PostgreSQL).
- prevent duplicate .azm imports.
- unmerge support.
- merge/unmerge transactions are atomic.


Generic usage
-------------

Specify --azm_file <file.azm or folder containing multiple .azm files> to import the .azm's log database to a central Database. To 'unmerge' (remove all data from target db that cam from this .azm file) simply add --unmerge .

This operation will CREATE (if requireD), ALTER (if new columns are detected)
and INSERT data from all tables in the 'azqdata.db' of the azm log file into
the target (central) database.

Note: For a list of all 'elements' (which form tables through binding to columns) of azm's azqdata.db please refer to:
https://docs.google.com/spreadsheets/d/1ddl-g_qyoMYLF8PMkjrYPrpXusdinTZxsWLQOzJ6xu8/

You need to specify the --target_db_type and its ODBC login settings too.
(for SQLite3 merges - specify all login, password, database as "" - not used).

PostgreSQL examples:
--------------------

Please open example GNU/Linux shell script files named below in a text editor:
- merge:
  - ex_postgre_merge_azm.sh
  - ex_postgre_merge_folder.sh
- unmerge:
  - ex_postgre_unmerge_azm.sh
  - ex_postgre_unmerge_folder.sh
  

Microsoft SQL Server examples:
------------------------------

Please open example Windows bat files named below in a text editor:
- merge:
  - ex_mssql_import_azm.bat
  - ex_mssql_import_azm_folder.bat
- unmerge:
  - ex_mssql_remove_azm.bat
  - ex_mssql_remove_azm_folder.bat


sqlite3 import/merge .azm example
---------------------------------

In below example we import one azm into 'merged.db':
python azm_db_merge.py --target_db_type sqlite3 --azm_file mod.azm --server_user "" --server_password "" --server_database "" --target_sqlite3_file merged.db

Note: the sqlite3 merge option is very early and does not have any CREATE, ALTER checks and no --unmerge support too.
So currently the merging of second, third files into the 'merged.db' would work
 but be reported as fail because there are no 'create if not exist' checks yet.
 Also, for sqlite3 target dbs - merging of a second file must be from the same
 azq app version only because there are no coulmn diff checks yet.


License
-------

Copyright (C) 2016 Freewill FX Co., Ltd. All rights reserved.

Released under the Apache-2.0 License. Please see LICENSE file.

Contact
-------

Please contact support@azenqos.com for further info and other queries.

