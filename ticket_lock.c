// Ticket locks

#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "date.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "ticket_lock.h"

void init_ticket_lock(struct ticket_lock* lk, char* name) {
	lk->name = name;
	lk->proc = 0;
	lk->ticket = 0;
	lk->turn = 0;
}

void ticket_acquire(struct ticket_lock* lk) {
	int me;
	if (ticket_holding(lk))
		panic("acquire")
	me = read_and_increment(&lk->ticket);
	while(lk->turn != me)
		;
	lk->cpu = mycpu();
	lk->proc = proc;
	getcallerpcs(&lk, lk->pcs);
}

void ticket_release(struct ticket_lock* lk) {
	if (!ticket_holding(lk))
		panic("release")
	lk->cpu = 0;
	lk->proc = 0;
	lk->pcs[0] = 0;
	lk->turn += 1;
}

int ticket_holding(struct ticket_lock* lk) {
	return (lk->ticket != lk->turn) && (lk->proc == proc);
}