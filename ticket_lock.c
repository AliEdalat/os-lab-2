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
	initlock(&lk->lk, "ticket lock");
	lk->name = name;
	lk->pid = 0;
	lk->ticket = 0;
	lk->turn = 0;
}

void ticket_acquire(struct ticket_lock* lk) {
	int me;
	acquire(&lk->lk);
	//cprintf("before panic\n");
	if (ticket_holding(lk))
		panic("acquire");
	me = read_and_increment(&lk->ticket, 1);
	//cprintf("after inc %d %d\n", me, lk->ticket);
	while(lk->turn != me){
		sleep(lk, &lk->lk);
		//cprintf("add to sleep queue\n");
	}
	lk->pid = myproc()->pid;
	release(&lk->lk);
}

void ticket_release(struct ticket_lock* lk) {
	acquire(&lk->lk);
	if (!ticket_holding(lk))
		panic("release");
	if (/*(lk->ticket == lk->turn) &&*/ (lk->pid == myproc()->pid))
	{
		lk->pid = 0;
		lk->turn += 1;
		wakeup(lk);
	}
	release(&lk->lk);
}

int ticket_holding(struct ticket_lock* lk) {
	return (lk->ticket != lk->turn) && (lk->pid == myproc()->pid);
}
