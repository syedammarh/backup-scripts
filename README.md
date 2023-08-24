# backup-script
Wrapper Backup Script for Snapshot backup of MongoDB (including fsynclock())
This wrapper script will backup mongoDB on each VM one by one , it will also perform fsynclock if storage engine is wiredTiger , performs backup and unlockFsync after bacup complete
