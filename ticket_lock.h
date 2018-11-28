struct ticket_lock
{
	uint ticket;
	uint turn;
	struct proc* proc;
	// For debugging:
	char *name;        // Name of lock.
	struct cpu *cpu;   // The cpu holding the lock.
	uint pcs[10];      // The call stack (an array of program counters)
    	               // that locked the lock.
};