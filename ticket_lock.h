struct ticket_lock
{
	uint ticket;
	uint turn;
	int pid;
	struct spinlock lk;
	// For debugging:
	char *name;        // Name of lock.
};