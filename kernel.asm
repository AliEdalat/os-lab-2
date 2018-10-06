
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc e0 b5 10 80       	mov    $0x8010b5e0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 50 2f 10 80       	mov    $0x80102f50,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	c7 44 24 04 40 6d 10 	movl   $0x80106d40,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010005b:	e8 70 41 00 00       	call   801041d0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100060:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx

  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100065:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
8010006c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006f:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
80100076:	fc 10 80 
80100079:	eb 09                	jmp    80100084 <binit+0x44>
8010007b:	90                   	nop
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100082:	89 c3                	mov    %eax,%ebx
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 47 6d 10 	movl   $0x80106d47,0x4(%esp)
8010009b:	80 
8010009c:	e8 ff 3f 00 00       	call   801040a0 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b4:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ba:	75 c4                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bc:	83 c4 14             	add    $0x14,%esp
801000bf:	5b                   	pop    %ebx
801000c0:	5d                   	pop    %ebp
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000dc:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000e6:	e8 55 42 00 00       	call   80104340 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000f1:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100161:	e8 4a 42 00 00       	call   801043b0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 6f 3f 00 00       	call   801040e0 <acquiresleep>
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 12 21 00 00       	call   80102290 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100188:	c7 04 24 4e 6d 10 80 	movl   $0x80106d4e,(%esp)
8010018f:	e8 cc 01 00 00       	call   80100360 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 cb 3f 00 00       	call   80104180 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 c7 20 00 00       	jmp    80102290 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	c7 04 24 5f 6d 10 80 	movl   $0x80106d5f,(%esp)
801001d0:	e8 8b 01 00 00       	call   80100360 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 8a 3f 00 00       	call   80104180 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 3e 3f 00 00       	call   80104140 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100209:	e8 32 41 00 00       	call   80104340 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	83 6b 4c 01          	subl   $0x1,0x4c(%ebx)
80100212:	75 2f                	jne    80100243 <brelse+0x63>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100214:	8b 43 54             	mov    0x54(%ebx),%eax
80100217:	8b 53 50             	mov    0x50(%ebx),%edx
8010021a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021d:	8b 43 50             	mov    0x50(%ebx),%eax
80100220:	8b 53 54             	mov    0x54(%ebx),%edx
80100223:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100226:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
8010022b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
80100232:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100235:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
8010023a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023d:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
80100243:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
8010024a:	83 c4 10             	add    $0x10,%esp
8010024d:	5b                   	pop    %ebx
8010024e:	5e                   	pop    %esi
8010024f:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
80100250:	e9 5b 41 00 00       	jmp    801043b0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100255:	c7 04 24 66 6d 10 80 	movl   $0x80106d66,(%esp)
8010025c:	e8 ff 00 00 00       	call   80100360 <panic>
80100261:	66 90                	xchg   %ax,%ax
80100263:	66 90                	xchg   %ax,%ax
80100265:	66 90                	xchg   %ax,%ax
80100267:	66 90                	xchg   %ax,%ax
80100269:	66 90                	xchg   %ax,%ax
8010026b:	66 90                	xchg   %ax,%ax
8010026d:	66 90                	xchg   %ax,%ax
8010026f:	90                   	nop

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 1c             	sub    $0x1c,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	89 3c 24             	mov    %edi,(%esp)
80100282:	e8 79 16 00 00       	call   80101900 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010028e:	e8 ad 40 00 00       	call   80104340 <acquire>
  while(n > 0){
80100293:	8b 55 10             	mov    0x10(%ebp),%edx
80100296:	85 d2                	test   %edx,%edx
80100298:	0f 8e bc 00 00 00    	jle    8010035a <consoleread+0xea>
8010029e:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a1:	eb 25                	jmp    801002c8 <consoleread+0x58>
801002a3:	90                   	nop
801002a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(myproc()->killed){
801002a8:	e8 53 35 00 00       	call   80103800 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 74                	jne    80100328 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 40 a5 10 	movl   $0x8010a540,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
801002c3:	e8 98 3a 00 00       	call   80103d60 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c8:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002cd:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	8d 50 01             	lea    0x1(%eax),%edx
801002d8:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
801002de:	89 c2                	mov    %eax,%edx
801002e0:	83 e2 7f             	and    $0x7f,%edx
801002e3:	0f b6 8a 40 ff 10 80 	movzbl -0x7fef00c0(%edx),%ecx
801002ea:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 57                	je     80100349 <consoleread+0xd9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	83 c6 01             	add    $0x1,%esi
    --n;
801002f5:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
801002f8:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002fb:	88 4e ff             	mov    %cl,-0x1(%esi)
    --n;
    if(c == '\n')
801002fe:	74 53                	je     80100353 <consoleread+0xe3>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100300:	85 db                	test   %ebx,%ebx
80100302:	75 c4                	jne    801002c8 <consoleread+0x58>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
80100307:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010030e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100311:	e8 9a 40 00 00       	call   801043b0 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 02 15 00 00       	call   80101820 <ilock>
8010031e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
80100321:	eb 1e                	jmp    80100341 <consoleread+0xd1>
80100323:	90                   	nop
80100324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
80100328:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010032f:	e8 7c 40 00 00       	call   801043b0 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 e4 14 00 00       	call   80101820 <ilock>
        return -1;
8010033c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100341:	83 c4 1c             	add    $0x1c,%esp
80100344:	5b                   	pop    %ebx
80100345:	5e                   	pop    %esi
80100346:	5f                   	pop    %edi
80100347:	5d                   	pop    %ebp
80100348:	c3                   	ret    
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100349:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010034c:	76 05                	jbe    80100353 <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
8010034e:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100353:	8b 45 10             	mov    0x10(%ebp),%eax
80100356:	29 d8                	sub    %ebx,%eax
80100358:	eb ad                	jmp    80100307 <consoleread+0x97>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
8010035a:	31 c0                	xor    %eax,%eax
8010035c:	eb a9                	jmp    80100307 <consoleread+0x97>
8010035e:	66 90                	xchg   %ax,%ax

80100360 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100360:	55                   	push   %ebp
80100361:	89 e5                	mov    %esp,%ebp
80100363:	56                   	push   %esi
80100364:	53                   	push   %ebx
80100365:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100368:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100369:	c7 05 74 a5 10 80 00 	movl   $0x0,0x8010a574
80100370:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100373:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100376:	e8 45 25 00 00       	call   801028c0 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 6d 6d 10 80 	movl   $0x80106d6d,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 92 03 00 00       	call   80100720 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 87 03 00 00       	call   80100720 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 b7 76 10 80 	movl   $0x801076b7,(%esp)
801003a0:	e8 7b 03 00 00       	call   80100720 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 3c 3e 00 00       	call   801041f0 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 81 6d 10 80 	movl   $0x80106d81,(%esp)
801003c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c8:	e8 53 03 00 00       	call   80100720 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003cd:	39 f3                	cmp    %esi,%ebx
801003cf:	75 e7                	jne    801003b8 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d1:	c7 05 78 a5 10 80 01 	movl   $0x1,0x8010a578
801003d8:	00 00 00 
801003db:	eb fe                	jmp    801003db <panic+0x7b>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi

801003e0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003e0:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
801003e6:	85 d2                	test   %edx,%edx
801003e8:	74 06                	je     801003f0 <consputc+0x10>
801003ea:	fa                   	cli    
801003eb:	eb fe                	jmp    801003eb <consputc+0xb>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi
 // }
}

void
consputc(int c)
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	89 c6                	mov    %eax,%esi
801003f7:	53                   	push   %ebx
801003f8:	83 ec 1c             	sub    $0x1c,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003fb:	3d 00 01 00 00       	cmp    $0x100,%eax
80100400:	0f 84 0e 01 00 00    	je     80100514 <consputc+0x134>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
80100406:	8d 80 1e ff ff ff    	lea    -0xe2(%eax),%eax
8010040c:	83 f8 03             	cmp    $0x3,%eax
8010040f:	0f 87 0f 02 00 00    	ja     80100624 <consputc+0x244>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100415:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010041a:	b8 0e 00 00 00       	mov    $0xe,%eax
8010041f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100420:	b2 d5                	mov    $0xd5,%dl
80100422:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100423:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100426:	b2 d4                	mov    $0xd4,%dl
80100428:	c1 e3 08             	shl    $0x8,%ebx
8010042b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100430:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100431:	b2 d5                	mov    $0xd5,%dl
80100433:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100434:	0f b6 c0             	movzbl %al,%eax
80100437:	09 c3                	or     %eax,%ebx

  if(pos > maximum_pos)
80100439:	3b 1d 20 a5 10 80    	cmp    0x8010a520,%ebx
8010043f:	7e 07                	jle    80100448 <consputc+0x68>
    maximum_pos = pos;
80100441:	89 1d 20 a5 10 80    	mov    %ebx,0x8010a520
80100447:	90                   	nop
  if(pos < minimum_pos)
80100448:	3b 1d 00 80 10 80    	cmp    0x80108000,%ebx
8010044e:	7d 08                	jge    80100458 <consputc+0x78>
    minimum_pos = pos;
80100450:	89 1d 00 80 10 80    	mov    %ebx,0x80108000
80100456:	66 90                	xchg   %ax,%ax
  if(c == '\n')
80100458:	83 fe 0a             	cmp    $0xa,%esi
8010045b:	0f 84 a2 01 00 00    	je     80100603 <consputc+0x223>
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
80100461:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100467:	0f 84 50 01 00 00    	je     801005bd <consputc+0x1dd>
      if (pos > minimum_pos){
 	--pos;
	maximum_pos = pos + 1;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
8010046d:	81 fe e4 00 00 00    	cmp    $0xe4,%esi
80100473:	0f 84 2e 01 00 00    	je     801005a7 <consputc+0x1c7>
      if (pos > minimum_pos)
	--pos;
  } else if(c == RIGHT){
80100479:	81 fe e5 00 00 00    	cmp    $0xe5,%esi
8010047f:	0f 84 b8 00 00 00    	je     8010053d <consputc+0x15d>
      if (pos < maximum_pos) ++pos;
  } else if(c == UP){
80100485:	8d 86 1e ff ff ff    	lea    -0xe2(%esi),%eax
8010048b:	83 f8 01             	cmp    $0x1,%eax
8010048e:	76 4a                	jbe    801004da <consputc+0xfa>
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
80100490:	b8 80 07 00 00       	mov    $0x780,%eax
80100495:	29 d8                	sub    %ebx,%eax
80100497:	8d 3c 1b             	lea    (%ebx,%ebx,1),%edi
8010049a:	01 c0                	add    %eax,%eax
8010049c:	8d 97 00 80 0b 80    	lea    -0x7ff48000(%edi),%edx
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
801004a2:	83 c3 01             	add    $0x1,%ebx
  } else if(c == UP){
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
801004a5:	89 44 24 08          	mov    %eax,0x8(%esp)
801004a9:	8d 87 02 80 0b 80    	lea    -0x7ff47ffe(%edi),%eax
801004af:	89 54 24 04          	mov    %edx,0x4(%esp)
801004b3:	89 04 24             	mov    %eax,(%esp)
801004b6:	e8 e5 3f 00 00       	call   801044a0 <memmove>
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
801004bb:	89 f0                	mov    %esi,%eax
801004bd:	0f b6 f0             	movzbl %al,%esi
801004c0:	66 81 ce 00 07       	or     $0x700,%si
    if(pos > maximum_pos)
801004c5:	3b 1d 20 a5 10 80    	cmp    0x8010a520,%ebx
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
801004cb:	66 89 b7 00 80 0b 80 	mov    %si,-0x7ff48000(%edi)
    if(pos > maximum_pos)
801004d2:	7e 06                	jle    801004da <consputc+0xfa>
      maximum_pos = pos;
801004d4:	89 1d 20 a5 10 80    	mov    %ebx,0x8010a520
801004da:	89 d8                	mov    %ebx,%eax
  }

  if(pos < 0 || pos > 25*80)
801004dc:	3d d0 07 00 00       	cmp    $0x7d0,%eax
801004e1:	77 6e                	ja     80100551 <consputc+0x171>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
801004e3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004e9:	7f 72                	jg     8010055d <consputc+0x17d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004eb:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004f0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004f5:	ee                   	out    %al,(%dx)
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
801004f6:	89 d8                	mov    %ebx,%eax
801004f8:	b2 d5                	mov    $0xd5,%dl
801004fa:	c1 f8 08             	sar    $0x8,%eax
801004fd:	ee                   	out    %al,(%dx)
801004fe:	b8 0f 00 00 00       	mov    $0xf,%eax
80100503:	b2 d4                	mov    $0xd4,%dl
80100505:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
80100506:	0f b6 c3             	movzbl %bl,%eax
80100509:	b2 d5                	mov    $0xd5,%dl
8010050b:	ee                   	out    %al,(%dx)
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
    uartputc(c);
  }
  cgaputc(c);
}
8010050c:	83 c4 1c             	add    $0x1c,%esp
8010050f:	5b                   	pop    %ebx
80100510:	5e                   	pop    %esi
80100511:	5f                   	pop    %edi
80100512:	5d                   	pop    %ebp
80100513:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100514:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051b:	e8 90 53 00 00       	call   801058b0 <uartputc>
80100520:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100527:	e8 84 53 00 00       	call   801058b0 <uartputc>
8010052c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100533:	e8 78 53 00 00       	call   801058b0 <uartputc>
80100538:	e9 d8 fe ff ff       	jmp    80100415 <consputc+0x35>
      }
  } else if(c == LEFT){
      if (pos > minimum_pos)
	--pos;
  } else if(c == RIGHT){
      if (pos < maximum_pos) ++pos;
8010053d:	3b 1d 20 a5 10 80    	cmp    0x8010a520,%ebx
80100543:	7d 95                	jge    801004da <consputc+0xfa>
80100545:	83 c3 01             	add    $0x1,%ebx
80100548:	89 d8                	mov    %ebx,%eax
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
    if(pos > maximum_pos)
      maximum_pos = pos;
  }

  if(pos < 0 || pos > 25*80)
8010054a:	3d d0 07 00 00       	cmp    $0x7d0,%eax
8010054f:	76 92                	jbe    801004e3 <consputc+0x103>
    panic("pos under/overflow");
80100551:	c7 04 24 85 6d 10 80 	movl   $0x80106d85,(%esp)
80100558:	e8 03 fe ff ff       	call   80100360 <panic>

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010055d:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
80100564:	00 
    pos -= 80;
80100565:	8d 73 b0             	lea    -0x50(%ebx),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100568:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
8010056f:	80 
80100570:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100577:	e8 24 3f 00 00       	call   801044a0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010057c:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100581:	29 d8                	sub    %ebx,%eax
  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
80100583:	89 f3                	mov    %esi,%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100585:	01 c0                	add    %eax,%eax
80100587:	89 44 24 08          	mov    %eax,0x8(%esp)
8010058b:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
80100592:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100599:	00 
8010059a:	89 04 24             	mov    %eax,(%esp)
8010059d:	e8 5e 3e 00 00       	call   80104400 <memset>
801005a2:	e9 44 ff ff ff       	jmp    801004eb <consputc+0x10b>
 	--pos;
	maximum_pos = pos + 1;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
      if (pos > minimum_pos)
801005a7:	3b 1d 00 80 10 80    	cmp    0x80108000,%ebx
801005ad:	0f 8e 27 ff ff ff    	jle    801004da <consputc+0xfa>
	--pos;
801005b3:	83 eb 01             	sub    $0x1,%ebx
801005b6:	89 d8                	mov    %ebx,%eax
801005b8:	e9 1f ff ff ff       	jmp    801004dc <consputc+0xfc>
    minimum_pos = pos;
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos > minimum_pos){
801005bd:	3b 1d 00 80 10 80    	cmp    0x80108000,%ebx
801005c3:	0f 8e 11 ff ff ff    	jle    801004da <consputc+0xfa>
 	--pos;
	maximum_pos = pos + 1;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005c9:	b8 81 07 00 00       	mov    $0x781,%eax
801005ce:	29 d8                	sub    %ebx,%eax
801005d0:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
801005d3:	01 c0                	add    %eax,%eax
801005d5:	89 44 24 08          	mov    %eax,0x8(%esp)
801005d9:	8d 82 00 80 0b 80    	lea    -0x7ff48000(%edx),%eax
801005df:	81 ea 02 80 f4 7f    	sub    $0x7ff48002,%edx
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos > minimum_pos){
 	--pos;
801005e5:	8d 73 ff             	lea    -0x1(%ebx),%esi
	maximum_pos = pos + 1;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005e8:	89 44 24 04          	mov    %eax,0x4(%esp)
801005ec:	89 14 24             	mov    %edx,(%esp)
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos > minimum_pos){
 	--pos;
	maximum_pos = pos + 1;
801005ef:	89 1d 20 a5 10 80    	mov    %ebx,0x8010a520
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005f5:	89 f3                	mov    %esi,%ebx
801005f7:	e8 a4 3e 00 00       	call   801044a0 <memmove>
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos > minimum_pos){
 	--pos;
801005fc:	89 f0                	mov    %esi,%eax
801005fe:	e9 d9 fe ff ff       	jmp    801004dc <consputc+0xfc>
  if(pos > maximum_pos)
    maximum_pos = pos;
  if(pos < minimum_pos)
    minimum_pos = pos;
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
80100603:	89 d8                	mov    %ebx,%eax
80100605:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010060a:	f7 ea                	imul   %edx
8010060c:	c1 fb 1f             	sar    $0x1f,%ebx
8010060f:	c1 fa 05             	sar    $0x5,%edx
80100612:	29 da                	sub    %ebx,%edx
80100614:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100617:	c1 e0 04             	shl    $0x4,%eax
8010061a:	8d 58 50             	lea    0x50(%eax),%ebx
8010061d:	89 d8                	mov    %ebx,%eax
8010061f:	e9 b8 fe ff ff       	jmp    801004dc <consputc+0xfc>
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
    uartputc(c);
80100624:	89 34 24             	mov    %esi,(%esp)
80100627:	e8 84 52 00 00       	call   801058b0 <uartputc>
8010062c:	e9 e4 fd ff ff       	jmp    80100415 <consputc+0x35>
80100631:	eb 0d                	jmp    80100640 <printint>
80100633:	90                   	nop
80100634:	90                   	nop
80100635:	90                   	nop
80100636:	90                   	nop
80100637:	90                   	nop
80100638:	90                   	nop
80100639:	90                   	nop
8010063a:	90                   	nop
8010063b:	90                   	nop
8010063c:	90                   	nop
8010063d:	90                   	nop
8010063e:	90                   	nop
8010063f:	90                   	nop

80100640 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	89 d6                	mov    %edx,%esi
80100647:	53                   	push   %ebx
80100648:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 61                	je     801006b0 <printint+0x70>
8010064f:	85 c0                	test   %eax,%eax
80100651:	79 5d                	jns    801006b0 <printint+0x70>
    x = -xx;
80100653:	f7 d8                	neg    %eax
80100655:	bf 01 00 00 00       	mov    $0x1,%edi
  else
    x = xx;

  i = 0;
8010065a:	31 c9                	xor    %ecx,%ecx
8010065c:	eb 04                	jmp    80100662 <printint+0x22>
8010065e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
80100660:	89 d9                	mov    %ebx,%ecx
80100662:	31 d2                	xor    %edx,%edx
80100664:	f7 f6                	div    %esi
80100666:	8d 59 01             	lea    0x1(%ecx),%ebx
80100669:	0f b6 92 b0 6d 10 80 	movzbl -0x7fef9250(%edx),%edx
  }while((x /= base) != 0);
80100670:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
80100672:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100676:	75 e8                	jne    80100660 <printint+0x20>

  if(sign)
80100678:	85 ff                	test   %edi,%edi
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
8010067a:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);

  if(sign)
8010067c:	74 08                	je     80100686 <printint+0x46>
    buf[i++] = '-';
8010067e:	8d 59 02             	lea    0x2(%ecx),%ebx
80100681:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
80100686:	83 eb 01             	sub    $0x1,%ebx
80100689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
80100690:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100695:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
80100698:	e8 43 fd ff ff       	call   801003e0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010069d:	83 fb ff             	cmp    $0xffffffff,%ebx
801006a0:	75 ee                	jne    80100690 <printint+0x50>
    consputc(buf[i]);
}
801006a2:	83 c4 1c             	add    $0x1c,%esp
801006a5:	5b                   	pop    %ebx
801006a6:	5e                   	pop    %esi
801006a7:	5f                   	pop    %edi
801006a8:	5d                   	pop    %ebp
801006a9:	c3                   	ret    
801006aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;
801006b0:	31 ff                	xor    %edi,%edi
801006b2:	eb a6                	jmp    8010065a <printint+0x1a>
801006b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801006ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801006c0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006c0:	55                   	push   %ebp
801006c1:	89 e5                	mov    %esp,%ebp
801006c3:	57                   	push   %edi
801006c4:	56                   	push   %esi
801006c5:	53                   	push   %ebx
801006c6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801006c9:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006cc:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801006cf:	89 04 24             	mov    %eax,(%esp)
801006d2:	e8 29 12 00 00       	call   80101900 <iunlock>
  acquire(&cons.lock);
801006d7:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801006de:	e8 5d 3c 00 00       	call   80104340 <acquire>
801006e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
801006e6:	85 f6                	test   %esi,%esi
801006e8:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801006eb:	7e 12                	jle    801006ff <consolewrite+0x3f>
801006ed:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801006f0:	0f b6 07             	movzbl (%edi),%eax
801006f3:	83 c7 01             	add    $0x1,%edi
801006f6:	e8 e5 fc ff ff       	call   801003e0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
801006fb:	39 df                	cmp    %ebx,%edi
801006fd:	75 f1                	jne    801006f0 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
801006ff:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100706:	e8 a5 3c 00 00       	call   801043b0 <release>
  ilock(ip);
8010070b:	8b 45 08             	mov    0x8(%ebp),%eax
8010070e:	89 04 24             	mov    %eax,(%esp)
80100711:	e8 0a 11 00 00       	call   80101820 <ilock>

  return n;
}
80100716:	83 c4 1c             	add    $0x1c,%esp
80100719:	89 f0                	mov    %esi,%eax
8010071b:	5b                   	pop    %ebx
8010071c:	5e                   	pop    %esi
8010071d:	5f                   	pop    %edi
8010071e:	5d                   	pop    %ebp
8010071f:	c3                   	ret    

80100720 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100720:	55                   	push   %ebp
80100721:	89 e5                	mov    %esp,%ebp
80100723:	57                   	push   %edi
80100724:	56                   	push   %esi
80100725:	53                   	push   %ebx
80100726:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100729:	a1 74 a5 10 80       	mov    0x8010a574,%eax
  if(locking)
8010072e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100730:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100733:	0f 85 27 01 00 00    	jne    80100860 <cprintf+0x140>
    acquire(&cons.lock);

  if (fmt == 0)
80100739:	8b 45 08             	mov    0x8(%ebp),%eax
8010073c:	85 c0                	test   %eax,%eax
8010073e:	89 c1                	mov    %eax,%ecx
80100740:	0f 84 2b 01 00 00    	je     80100871 <cprintf+0x151>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100746:	0f b6 00             	movzbl (%eax),%eax
80100749:	31 db                	xor    %ebx,%ebx
8010074b:	89 cf                	mov    %ecx,%edi
8010074d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100750:	85 c0                	test   %eax,%eax
80100752:	75 4c                	jne    801007a0 <cprintf+0x80>
80100754:	eb 5f                	jmp    801007b5 <cprintf+0x95>
80100756:	66 90                	xchg   %ax,%ax
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100758:	83 c3 01             	add    $0x1,%ebx
8010075b:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
8010075f:	85 d2                	test   %edx,%edx
80100761:	74 52                	je     801007b5 <cprintf+0x95>
      break;
    switch(c){
80100763:	83 fa 70             	cmp    $0x70,%edx
80100766:	74 72                	je     801007da <cprintf+0xba>
80100768:	7f 66                	jg     801007d0 <cprintf+0xb0>
8010076a:	83 fa 25             	cmp    $0x25,%edx
8010076d:	8d 76 00             	lea    0x0(%esi),%esi
80100770:	0f 84 a2 00 00 00    	je     80100818 <cprintf+0xf8>
80100776:	83 fa 64             	cmp    $0x64,%edx
80100779:	75 7d                	jne    801007f8 <cprintf+0xd8>
    case 'd':
      printint(*argp++, 10, 1);
8010077b:	8d 46 04             	lea    0x4(%esi),%eax
8010077e:	b9 01 00 00 00       	mov    $0x1,%ecx
80100783:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100786:	8b 06                	mov    (%esi),%eax
80100788:	ba 0a 00 00 00       	mov    $0xa,%edx
8010078d:	e8 ae fe ff ff       	call   80100640 <printint>
80100792:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100795:	83 c3 01             	add    $0x1,%ebx
80100798:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
8010079c:	85 c0                	test   %eax,%eax
8010079e:	74 15                	je     801007b5 <cprintf+0x95>
    if(c != '%'){
801007a0:	83 f8 25             	cmp    $0x25,%eax
801007a3:	74 b3                	je     80100758 <cprintf+0x38>
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
801007a5:	e8 36 fc ff ff       	call   801003e0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007aa:	83 c3 01             	add    $0x1,%ebx
801007ad:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801007b1:	85 c0                	test   %eax,%eax
801007b3:	75 eb                	jne    801007a0 <cprintf+0x80>
      consputc(c);
      break;
    }
  }

  if(locking)
801007b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b8:	85 c0                	test   %eax,%eax
801007ba:	74 0c                	je     801007c8 <cprintf+0xa8>
    release(&cons.lock);
801007bc:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801007c3:	e8 e8 3b 00 00       	call   801043b0 <release>
}
801007c8:	83 c4 1c             	add    $0x1c,%esp
801007cb:	5b                   	pop    %ebx
801007cc:	5e                   	pop    %esi
801007cd:	5f                   	pop    %edi
801007ce:	5d                   	pop    %ebp
801007cf:	c3                   	ret    
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801007d0:	83 fa 73             	cmp    $0x73,%edx
801007d3:	74 53                	je     80100828 <cprintf+0x108>
801007d5:	83 fa 78             	cmp    $0x78,%edx
801007d8:	75 1e                	jne    801007f8 <cprintf+0xd8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801007da:	8d 46 04             	lea    0x4(%esi),%eax
801007dd:	31 c9                	xor    %ecx,%ecx
801007df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007e2:	8b 06                	mov    (%esi),%eax
801007e4:	ba 10 00 00 00       	mov    $0x10,%edx
801007e9:	e8 52 fe ff ff       	call   80100640 <printint>
801007ee:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
801007f1:	eb a2                	jmp    80100795 <cprintf+0x75>
801007f3:	90                   	nop
801007f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801007f8:	b8 25 00 00 00       	mov    $0x25,%eax
801007fd:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100800:	e8 db fb ff ff       	call   801003e0 <consputc>
      consputc(c);
80100805:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100808:	89 d0                	mov    %edx,%eax
8010080a:	e8 d1 fb ff ff       	call   801003e0 <consputc>
8010080f:	eb 99                	jmp    801007aa <cprintf+0x8a>
80100811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100818:	b8 25 00 00 00       	mov    $0x25,%eax
8010081d:	e8 be fb ff ff       	call   801003e0 <consputc>
      break;
80100822:	e9 6e ff ff ff       	jmp    80100795 <cprintf+0x75>
80100827:	90                   	nop
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100828:	8d 46 04             	lea    0x4(%esi),%eax
8010082b:	8b 36                	mov    (%esi),%esi
8010082d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100830:	b8 98 6d 10 80       	mov    $0x80106d98,%eax
80100835:	85 f6                	test   %esi,%esi
80100837:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
8010083a:	0f be 06             	movsbl (%esi),%eax
8010083d:	84 c0                	test   %al,%al
8010083f:	74 16                	je     80100857 <cprintf+0x137>
80100841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100848:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
8010084b:	e8 90 fb ff ff       	call   801003e0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100850:	0f be 06             	movsbl (%esi),%eax
80100853:	84 c0                	test   %al,%al
80100855:	75 f1                	jne    80100848 <cprintf+0x128>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100857:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010085a:	e9 36 ff ff ff       	jmp    80100795 <cprintf+0x75>
8010085f:	90                   	nop
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100860:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100867:	e8 d4 3a 00 00       	call   80104340 <acquire>
8010086c:	e9 c8 fe ff ff       	jmp    80100739 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
80100871:	c7 04 24 9f 6d 10 80 	movl   $0x80106d9f,(%esp)
80100878:	e8 e3 fa ff ff       	call   80100360 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
  int c, doprocdump = 0;
80100884:	31 ff                	xor    %edi,%edi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100886:	56                   	push   %esi
80100887:	53                   	push   %ebx
80100888:	83 ec 1c             	sub    $0x1c,%esp
8010088b:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, doprocdump = 0;

  acquire(&cons.lock);
8010088e:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100895:	e8 a6 3a 00 00       	call   80104340 <acquire>
8010089a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801008a0:	ff d6                	call   *%esi
801008a2:	85 c0                	test   %eax,%eax
801008a4:	89 c3                	mov    %eax,%ebx
801008a6:	78 48                	js     801008f0 <consoleintr+0x70>
    switch(c){
801008a8:	83 fb 7f             	cmp    $0x7f,%ebx
801008ab:	0f 84 87 01 00 00    	je     80100a38 <consoleintr+0x1b8>
801008b1:	7e 5d                	jle    80100910 <consoleintr+0x90>
801008b3:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
801008b9:	0f 84 09 01 00 00    	je     801009c8 <consoleintr+0x148>
801008bf:	90                   	nop
801008c0:	0f 8e e2 00 00 00    	jle    801009a8 <consoleintr+0x128>
801008c6:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
801008cc:	0f 84 8e 01 00 00    	je     80100a60 <consoleintr+0x1e0>
801008d2:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
801008d8:	75 51                	jne    8010092b <consoleintr+0xab>
        input.e--;
        consputc(c);
      }
      break;
    case RIGHT:
      consputc(c);
801008da:	b8 e5 00 00 00       	mov    $0xe5,%eax
801008df:	e8 fc fa ff ff       	call   801003e0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801008e4:	ff d6                	call   *%esi
801008e6:	85 c0                	test   %eax,%eax
801008e8:	89 c3                	mov    %eax,%ebx
801008ea:	79 bc                	jns    801008a8 <consoleintr+0x28>
801008ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
801008f0:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801008f7:	e8 b4 3a 00 00       	call   801043b0 <release>
  if(doprocdump) {
801008fc:	85 ff                	test   %edi,%edi
801008fe:	0f 85 84 01 00 00    	jne    80100a88 <consoleintr+0x208>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100904:	83 c4 1c             	add    $0x1c,%esp
80100907:	5b                   	pop    %ebx
80100908:	5e                   	pop    %esi
80100909:	5f                   	pop    %edi
8010090a:	5d                   	pop    %ebp
8010090b:	c3                   	ret    
8010090c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100910:	83 fb 10             	cmp    $0x10,%ebx
80100913:	0f 84 0f 01 00 00    	je     80100a28 <consoleintr+0x1a8>
80100919:	83 fb 15             	cmp    $0x15,%ebx
8010091c:	0f 84 b6 00 00 00    	je     801009d8 <consoleintr+0x158>
80100922:	83 fb 08             	cmp    $0x8,%ebx
80100925:	0f 84 0d 01 00 00    	je     80100a38 <consoleintr+0x1b8>
      break;
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010092b:	85 db                	test   %ebx,%ebx
8010092d:	8d 76 00             	lea    0x0(%esi),%esi
80100930:	0f 84 6a ff ff ff    	je     801008a0 <consoleintr+0x20>
80100936:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010093b:	89 c2                	mov    %eax,%edx
8010093d:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100943:	83 fa 7f             	cmp    $0x7f,%edx
80100946:	0f 87 54 ff ff ff    	ja     801008a0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010094c:	8d 50 01             	lea    0x1(%eax),%edx
8010094f:	83 e0 7f             	and    $0x7f,%eax
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100952:	83 fb 0d             	cmp    $0xd,%ebx
        input.buf[input.e++ % INPUT_BUF] = c;
80100955:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
8010095b:	0f 84 33 01 00 00    	je     80100a94 <consoleintr+0x214>
        input.buf[input.e++ % INPUT_BUF] = c;
80100961:	88 98 40 ff 10 80    	mov    %bl,-0x7fef00c0(%eax)
        consputc(c);
80100967:	89 d8                	mov    %ebx,%eax
80100969:	e8 72 fa ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010096e:	83 fb 04             	cmp    $0x4,%ebx
80100971:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100976:	74 19                	je     80100991 <consoleintr+0x111>
80100978:	83 fb 0a             	cmp    $0xa,%ebx
8010097b:	74 14                	je     80100991 <consoleintr+0x111>
8010097d:	8b 0d c0 ff 10 80    	mov    0x8010ffc0,%ecx
80100983:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
80100989:	39 d0                	cmp    %edx,%eax
8010098b:	0f 85 0f ff ff ff    	jne    801008a0 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
80100991:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
80100998:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
8010099d:	e8 4e 35 00 00       	call   80103ef0 <wakeup>
801009a2:	e9 f9 fe ff ff       	jmp    801008a0 <consoleintr+0x20>
801009a7:	90                   	nop
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
801009a8:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
801009ae:	0f 85 77 ff ff ff    	jne    8010092b <consoleintr+0xab>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case UP:
      consputc(c);
801009b4:	b8 e2 00 00 00       	mov    $0xe2,%eax
801009b9:	e8 22 fa ff ff       	call   801003e0 <consputc>
      break;
801009be:	e9 dd fe ff ff       	jmp    801008a0 <consoleintr+0x20>
801009c3:	90                   	nop
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case DOWN:
      consputc(c);
801009c8:	b8 e3 00 00 00       	mov    $0xe3,%eax
801009cd:	e8 0e fa ff ff       	call   801003e0 <consputc>
      break;
801009d2:	e9 c9 fe ff ff       	jmp    801008a0 <consoleintr+0x20>
801009d7:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801009d8:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801009dd:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801009e3:	75 2b                	jne    80100a10 <consoleintr+0x190>
801009e5:	e9 b6 fe ff ff       	jmp    801008a0 <consoleintr+0x20>
801009ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801009f0:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
801009f5:	b8 00 01 00 00       	mov    $0x100,%eax
801009fa:	e8 e1 f9 ff ff       	call   801003e0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801009ff:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100a04:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100a0a:	0f 84 90 fe ff ff    	je     801008a0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a10:	83 e8 01             	sub    $0x1,%eax
80100a13:	89 c2                	mov    %eax,%edx
80100a15:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100a18:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
80100a1f:	75 cf                	jne    801009f0 <consoleintr+0x170>
80100a21:	e9 7a fe ff ff       	jmp    801008a0 <consoleintr+0x20>
80100a26:	66 90                	xchg   %ax,%ax
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100a28:	bf 01 00 00 00       	mov    $0x1,%edi
80100a2d:	e9 6e fe ff ff       	jmp    801008a0 <consoleintr+0x20>
80100a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100a38:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100a3d:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100a43:	0f 84 57 fe ff ff    	je     801008a0 <consoleintr+0x20>
        input.e--;
80100a49:	83 e8 01             	sub    $0x1,%eax
80100a4c:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100a51:	b8 00 01 00 00       	mov    $0x100,%eax
80100a56:	e8 85 f9 ff ff       	call   801003e0 <consputc>
80100a5b:	e9 40 fe ff ff       	jmp    801008a0 <consoleintr+0x20>
      break;
    case DOWN:
      consputc(c);
      break;
    case LEFT:
      if(input.e != input.w){
80100a60:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100a65:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100a6b:	0f 84 2f fe ff ff    	je     801008a0 <consoleintr+0x20>
        input.e--;
80100a71:	83 e8 01             	sub    $0x1,%eax
80100a74:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(c);
80100a79:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100a7e:	e8 5d f9 ff ff       	call   801003e0 <consputc>
80100a83:	e9 18 fe ff ff       	jmp    801008a0 <consoleintr+0x20>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100a88:	83 c4 1c             	add    $0x1c,%esp
80100a8b:	5b                   	pop    %ebx
80100a8c:	5e                   	pop    %esi
80100a8d:	5f                   	pop    %edi
80100a8e:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100a8f:	e9 3c 35 00 00       	jmp    80103fd0 <procdump>
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100a94:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
80100a9b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100aa0:	e8 3b f9 ff ff       	call   801003e0 <consputc>
80100aa5:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100aaa:	e9 e2 fe ff ff       	jmp    80100991 <consoleintr+0x111>
80100aaf:	90                   	nop

80100ab0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100ab6:	c7 44 24 04 a8 6d 10 	movl   $0x80106da8,0x4(%esp)
80100abd:	80 
80100abe:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100ac5:	e8 06 37 00 00       	call   801041d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100aca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100ad1:	00 
80100ad2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100ad9:	c7 05 8c 09 11 80 c0 	movl   $0x801006c0,0x8011098c
80100ae0:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100ae3:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
80100aea:	02 10 80 
  cons.locking = 1;
80100aed:	c7 05 74 a5 10 80 01 	movl   $0x1,0x8010a574
80100af4:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100af7:	e8 24 19 00 00       	call   80102420 <ioapicenable>
}
80100afc:	c9                   	leave  
80100afd:	c3                   	ret    
80100afe:	66 90                	xchg   %ax,%ax

80100b00 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b00:	55                   	push   %ebp
80100b01:	89 e5                	mov    %esp,%ebp
80100b03:	57                   	push   %edi
80100b04:	56                   	push   %esi
80100b05:	53                   	push   %ebx
80100b06:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b0c:	e8 ef 2c 00 00       	call   80103800 <myproc>
80100b11:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100b17:	e8 54 21 00 00       	call   80102c70 <begin_op>

  if((ip = namei(path)) == 0){
80100b1c:	8b 45 08             	mov    0x8(%ebp),%eax
80100b1f:	89 04 24             	mov    %eax,(%esp)
80100b22:	e8 49 15 00 00       	call   80102070 <namei>
80100b27:	85 c0                	test   %eax,%eax
80100b29:	89 c3                	mov    %eax,%ebx
80100b2b:	0f 84 c2 01 00 00    	je     80100cf3 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b31:	89 04 24             	mov    %eax,(%esp)
80100b34:	e8 e7 0c 00 00       	call   80101820 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b39:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b3f:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100b46:	00 
80100b47:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100b4e:	00 
80100b4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b53:	89 1c 24             	mov    %ebx,(%esp)
80100b56:	e8 75 0f 00 00       	call   80101ad0 <readi>
80100b5b:	83 f8 34             	cmp    $0x34,%eax
80100b5e:	74 20                	je     80100b80 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b60:	89 1c 24             	mov    %ebx,(%esp)
80100b63:	e8 18 0f 00 00       	call   80101a80 <iunlockput>
    end_op();
80100b68:	e8 73 21 00 00       	call   80102ce0 <end_op>
  }
  return -1;
80100b6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b72:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100b78:	5b                   	pop    %ebx
80100b79:	5e                   	pop    %esi
80100b7a:	5f                   	pop    %edi
80100b7b:	5d                   	pop    %ebp
80100b7c:	c3                   	ret    
80100b7d:	8d 76 00             	lea    0x0(%esi),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b80:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b87:	45 4c 46 
80100b8a:	75 d4                	jne    80100b60 <exec+0x60>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b8c:	e8 ff 5e 00 00       	call   80106a90 <setupkvm>
80100b91:	85 c0                	test   %eax,%eax
80100b93:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b99:	74 c5                	je     80100b60 <exec+0x60>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b9b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ba2:	00 
80100ba3:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
80100ba9:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100bb0:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bb3:	0f 84 da 00 00 00    	je     80100c93 <exec+0x193>
80100bb9:	31 ff                	xor    %edi,%edi
80100bbb:	eb 18                	jmp    80100bd5 <exec+0xd5>
80100bbd:	8d 76 00             	lea    0x0(%esi),%esi
80100bc0:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bc7:	83 c7 01             	add    $0x1,%edi
80100bca:	83 c6 20             	add    $0x20,%esi
80100bcd:	39 f8                	cmp    %edi,%eax
80100bcf:	0f 8e be 00 00 00    	jle    80100c93 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bd5:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bdb:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100be2:	00 
80100be3:	89 74 24 08          	mov    %esi,0x8(%esp)
80100be7:	89 44 24 04          	mov    %eax,0x4(%esp)
80100beb:	89 1c 24             	mov    %ebx,(%esp)
80100bee:	e8 dd 0e 00 00       	call   80101ad0 <readi>
80100bf3:	83 f8 20             	cmp    $0x20,%eax
80100bf6:	0f 85 84 00 00 00    	jne    80100c80 <exec+0x180>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100bfc:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c03:	75 bb                	jne    80100bc0 <exec+0xc0>
      continue;
    if(ph.memsz < ph.filesz)
80100c05:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c0b:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100c11:	72 6d                	jb     80100c80 <exec+0x180>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c13:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100c19:	72 65                	jb     80100c80 <exec+0x180>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c1b:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c1f:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c25:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c29:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c2f:	89 04 24             	mov    %eax,(%esp)
80100c32:	e8 c9 5c 00 00       	call   80106900 <allocuvm>
80100c37:	85 c0                	test   %eax,%eax
80100c39:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100c3f:	74 3f                	je     80100c80 <exec+0x180>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100c41:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c47:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100c4c:	75 32                	jne    80100c80 <exec+0x180>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c4e:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100c54:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c58:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c5e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100c62:	89 54 24 10          	mov    %edx,0x10(%esp)
80100c66:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100c6c:	89 04 24             	mov    %eax,(%esp)
80100c6f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100c73:	e8 c8 5b 00 00       	call   80106840 <loaduvm>
80100c78:	85 c0                	test   %eax,%eax
80100c7a:	0f 89 40 ff ff ff    	jns    80100bc0 <exec+0xc0>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c80:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c86:	89 04 24             	mov    %eax,(%esp)
80100c89:	e8 82 5d 00 00       	call   80106a10 <freevm>
80100c8e:	e9 cd fe ff ff       	jmp    80100b60 <exec+0x60>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100c93:	89 1c 24             	mov    %ebx,(%esp)
80100c96:	e8 e5 0d 00 00       	call   80101a80 <iunlockput>
80100c9b:	90                   	nop
80100c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100ca0:	e8 3b 20 00 00       	call   80102ce0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100ca5:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100cab:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cb0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cb5:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100cbb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cbf:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100cc5:	89 54 24 08          	mov    %edx,0x8(%esp)
80100cc9:	89 04 24             	mov    %eax,(%esp)
80100ccc:	e8 2f 5c 00 00       	call   80106900 <allocuvm>
80100cd1:	85 c0                	test   %eax,%eax
80100cd3:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100cd9:	75 33                	jne    80100d0e <exec+0x20e>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100cdb:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ce1:	89 04 24             	mov    %eax,(%esp)
80100ce4:	e8 27 5d 00 00       	call   80106a10 <freevm>
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cee:	e9 7f fe ff ff       	jmp    80100b72 <exec+0x72>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100cf3:	e8 e8 1f 00 00       	call   80102ce0 <end_op>
    cprintf("exec: fail\n");
80100cf8:	c7 04 24 c1 6d 10 80 	movl   $0x80106dc1,(%esp)
80100cff:	e8 1c fa ff ff       	call   80100720 <cprintf>
    return -1;
80100d04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d09:	e9 64 fe ff ff       	jmp    80100b72 <exec+0x72>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d0e:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100d14:	89 d8                	mov    %ebx,%eax
80100d16:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d1b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d1f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d25:	89 04 24             	mov    %eax,(%esp)
80100d28:	e8 13 5e 00 00       	call   80106b40 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d30:	8b 00                	mov    (%eax),%eax
80100d32:	85 c0                	test   %eax,%eax
80100d34:	0f 84 59 01 00 00    	je     80100e93 <exec+0x393>
80100d3a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100d3d:	31 d2                	xor    %edx,%edx
80100d3f:	8d 71 04             	lea    0x4(%ecx),%esi
80100d42:	89 cf                	mov    %ecx,%edi
80100d44:	89 d1                	mov    %edx,%ecx
80100d46:	89 f2                	mov    %esi,%edx
80100d48:	89 fe                	mov    %edi,%esi
80100d4a:	89 cf                	mov    %ecx,%edi
80100d4c:	eb 0a                	jmp    80100d58 <exec+0x258>
80100d4e:	66 90                	xchg   %ax,%ax
80100d50:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100d53:	83 ff 20             	cmp    $0x20,%edi
80100d56:	74 83                	je     80100cdb <exec+0x1db>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d58:	89 04 24             	mov    %eax,(%esp)
80100d5b:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100d61:	e8 ba 38 00 00       	call   80104620 <strlen>
80100d66:	f7 d0                	not    %eax
80100d68:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d6a:	8b 06                	mov    (%esi),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d6c:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d6f:	89 04 24             	mov    %eax,(%esp)
80100d72:	e8 a9 38 00 00       	call   80104620 <strlen>
80100d77:	83 c0 01             	add    $0x1,%eax
80100d7a:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100d7e:	8b 06                	mov    (%esi),%eax
80100d80:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100d84:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d88:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d8e:	89 04 24             	mov    %eax,(%esp)
80100d91:	e8 0a 5f 00 00       	call   80106ca0 <copyout>
80100d96:	85 c0                	test   %eax,%eax
80100d98:	0f 88 3d ff ff ff    	js     80100cdb <exec+0x1db>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d9e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100da4:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100daa:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100db1:	83 c7 01             	add    $0x1,%edi
80100db4:	8b 02                	mov    (%edx),%eax
80100db6:	89 d6                	mov    %edx,%esi
80100db8:	85 c0                	test   %eax,%eax
80100dba:	75 94                	jne    80100d50 <exec+0x250>
80100dbc:	89 fa                	mov    %edi,%edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dbe:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100dc5:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dc9:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
80100dd0:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dd6:	89 da                	mov    %ebx,%edx
80100dd8:	29 c2                	sub    %eax,%edx

  sp -= (3+argc+1) * 4;
80100dda:	83 c0 0c             	add    $0xc,%eax
80100ddd:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ddf:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100de3:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100de9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100ded:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100df1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100df8:	ff ff ff 
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100dfb:	89 04 24             	mov    %eax,(%esp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dfe:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e04:	e8 97 5e 00 00       	call   80106ca0 <copyout>
80100e09:	85 c0                	test   %eax,%eax
80100e0b:	0f 88 ca fe ff ff    	js     80100cdb <exec+0x1db>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e11:	8b 45 08             	mov    0x8(%ebp),%eax
80100e14:	0f b6 10             	movzbl (%eax),%edx
80100e17:	84 d2                	test   %dl,%dl
80100e19:	74 19                	je     80100e34 <exec+0x334>
80100e1b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100e1e:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100e21:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e24:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100e27:	0f 44 c8             	cmove  %eax,%ecx
80100e2a:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e2d:	84 d2                	test   %dl,%dl
80100e2f:	75 f0                	jne    80100e21 <exec+0x321>
80100e31:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100e34:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100e3a:	8b 45 08             	mov    0x8(%ebp),%eax
80100e3d:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100e44:	00 
80100e45:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e49:	89 f8                	mov    %edi,%eax
80100e4b:	83 c0 6c             	add    $0x6c,%eax
80100e4e:	89 04 24             	mov    %eax,(%esp)
80100e51:	e8 8a 37 00 00       	call   801045e0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100e56:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100e5c:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100e5f:	8b 47 18             	mov    0x18(%edi),%eax
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100e62:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100e65:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100e6b:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100e6d:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e73:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e76:	8b 47 18             	mov    0x18(%edi),%eax
80100e79:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e7c:	89 3c 24             	mov    %edi,(%esp)
80100e7f:	e8 2c 58 00 00       	call   801066b0 <switchuvm>
  freevm(oldpgdir);
80100e84:	89 34 24             	mov    %esi,(%esp)
80100e87:	e8 84 5b 00 00       	call   80106a10 <freevm>
  return 0;
80100e8c:	31 c0                	xor    %eax,%eax
80100e8e:	e9 df fc ff ff       	jmp    80100b72 <exec+0x72>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e93:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100e99:	31 d2                	xor    %edx,%edx
80100e9b:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100ea1:	e9 18 ff ff ff       	jmp    80100dbe <exec+0x2be>
80100ea6:	66 90                	xchg   %ax,%ax
80100ea8:	66 90                	xchg   %ax,%ax
80100eaa:	66 90                	xchg   %ax,%ax
80100eac:	66 90                	xchg   %ax,%ax
80100eae:	66 90                	xchg   %ax,%ax

80100eb0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100eb6:	c7 44 24 04 cd 6d 10 	movl   $0x80106dcd,0x4(%esp)
80100ebd:	80 
80100ebe:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100ec5:	e8 06 33 00 00       	call   801041d0 <initlock>
}
80100eca:	c9                   	leave  
80100ecb:	c3                   	ret    
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ed0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ed0:	55                   	push   %ebp
80100ed1:	89 e5                	mov    %esp,%ebp
80100ed3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ed4:	bb 14 00 11 80       	mov    $0x80110014,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ed9:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100edc:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100ee3:	e8 58 34 00 00       	call   80104340 <acquire>
80100ee8:	eb 11                	jmp    80100efb <filealloc+0x2b>
80100eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ef0:	83 c3 18             	add    $0x18,%ebx
80100ef3:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100ef9:	74 25                	je     80100f20 <filealloc+0x50>
    if(f->ref == 0){
80100efb:	8b 43 04             	mov    0x4(%ebx),%eax
80100efe:	85 c0                	test   %eax,%eax
80100f00:	75 ee                	jne    80100ef0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f02:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100f09:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f10:	e8 9b 34 00 00       	call   801043b0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f15:	83 c4 14             	add    $0x14,%esp
  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      release(&ftable.lock);
      return f;
80100f18:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f1a:	5b                   	pop    %ebx
80100f1b:	5d                   	pop    %ebp
80100f1c:	c3                   	ret    
80100f1d:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f20:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100f27:	e8 84 34 00 00       	call   801043b0 <release>
  return 0;
}
80100f2c:	83 c4 14             	add    $0x14,%esp
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
80100f2f:	31 c0                	xor    %eax,%eax
}
80100f31:	5b                   	pop    %ebx
80100f32:	5d                   	pop    %ebp
80100f33:	c3                   	ret    
80100f34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100f40 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	53                   	push   %ebx
80100f44:	83 ec 14             	sub    $0x14,%esp
80100f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f4a:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100f51:	e8 ea 33 00 00       	call   80104340 <acquire>
  if(f->ref < 1)
80100f56:	8b 43 04             	mov    0x4(%ebx),%eax
80100f59:	85 c0                	test   %eax,%eax
80100f5b:	7e 1a                	jle    80100f77 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100f5d:	83 c0 01             	add    $0x1,%eax
80100f60:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f63:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100f6a:	e8 41 34 00 00       	call   801043b0 <release>
  return f;
}
80100f6f:	83 c4 14             	add    $0x14,%esp
80100f72:	89 d8                	mov    %ebx,%eax
80100f74:	5b                   	pop    %ebx
80100f75:	5d                   	pop    %ebp
80100f76:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100f77:	c7 04 24 d4 6d 10 80 	movl   $0x80106dd4,(%esp)
80100f7e:	e8 dd f3 ff ff       	call   80100360 <panic>
80100f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f90 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	57                   	push   %edi
80100f94:	56                   	push   %esi
80100f95:	53                   	push   %ebx
80100f96:	83 ec 1c             	sub    $0x1c,%esp
80100f99:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100f9c:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100fa3:	e8 98 33 00 00       	call   80104340 <acquire>
  if(f->ref < 1)
80100fa8:	8b 57 04             	mov    0x4(%edi),%edx
80100fab:	85 d2                	test   %edx,%edx
80100fad:	0f 8e 89 00 00 00    	jle    8010103c <fileclose+0xac>
    panic("fileclose");
  if(--f->ref > 0){
80100fb3:	83 ea 01             	sub    $0x1,%edx
80100fb6:	85 d2                	test   %edx,%edx
80100fb8:	89 57 04             	mov    %edx,0x4(%edi)
80100fbb:	74 13                	je     80100fd0 <fileclose+0x40>
    release(&ftable.lock);
80100fbd:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fc4:	83 c4 1c             	add    $0x1c,%esp
80100fc7:	5b                   	pop    %ebx
80100fc8:	5e                   	pop    %esi
80100fc9:	5f                   	pop    %edi
80100fca:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100fcb:	e9 e0 33 00 00       	jmp    801043b0 <release>
    return;
  }
  ff = *f;
80100fd0:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100fd4:	8b 37                	mov    (%edi),%esi
80100fd6:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
80100fd9:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100fdf:	88 45 e7             	mov    %al,-0x19(%ebp)
80100fe2:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100fe5:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100fec:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100fef:	e8 bc 33 00 00       	call   801043b0 <release>

  if(ff.type == FD_PIPE)
80100ff4:	83 fe 01             	cmp    $0x1,%esi
80100ff7:	74 0f                	je     80101008 <fileclose+0x78>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ff9:	83 fe 02             	cmp    $0x2,%esi
80100ffc:	74 22                	je     80101020 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100ffe:	83 c4 1c             	add    $0x1c,%esp
80101001:	5b                   	pop    %ebx
80101002:	5e                   	pop    %esi
80101003:	5f                   	pop    %edi
80101004:	5d                   	pop    %ebp
80101005:	c3                   	ret    
80101006:	66 90                	xchg   %ax,%ax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80101008:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
8010100c:	89 1c 24             	mov    %ebx,(%esp)
8010100f:	89 74 24 04          	mov    %esi,0x4(%esp)
80101013:	e8 a8 23 00 00       	call   801033c0 <pipeclose>
80101018:	eb e4                	jmp    80100ffe <fileclose+0x6e>
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80101020:	e8 4b 1c 00 00       	call   80102c70 <begin_op>
    iput(ff.ip);
80101025:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101028:	89 04 24             	mov    %eax,(%esp)
8010102b:	e8 10 09 00 00       	call   80101940 <iput>
    end_op();
  }
}
80101030:	83 c4 1c             	add    $0x1c,%esp
80101033:	5b                   	pop    %ebx
80101034:	5e                   	pop    %esi
80101035:	5f                   	pop    %edi
80101036:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80101037:	e9 a4 1c 00 00       	jmp    80102ce0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
8010103c:	c7 04 24 dc 6d 10 80 	movl   $0x80106ddc,(%esp)
80101043:	e8 18 f3 ff ff       	call   80100360 <panic>
80101048:	90                   	nop
80101049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101050 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	53                   	push   %ebx
80101054:	83 ec 14             	sub    $0x14,%esp
80101057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010105a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010105d:	75 31                	jne    80101090 <filestat+0x40>
    ilock(f->ip);
8010105f:	8b 43 10             	mov    0x10(%ebx),%eax
80101062:	89 04 24             	mov    %eax,(%esp)
80101065:	e8 b6 07 00 00       	call   80101820 <ilock>
    stati(f->ip, st);
8010106a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010106d:	89 44 24 04          	mov    %eax,0x4(%esp)
80101071:	8b 43 10             	mov    0x10(%ebx),%eax
80101074:	89 04 24             	mov    %eax,(%esp)
80101077:	e8 24 0a 00 00       	call   80101aa0 <stati>
    iunlock(f->ip);
8010107c:	8b 43 10             	mov    0x10(%ebx),%eax
8010107f:	89 04 24             	mov    %eax,(%esp)
80101082:	e8 79 08 00 00       	call   80101900 <iunlock>
    return 0;
  }
  return -1;
}
80101087:	83 c4 14             	add    $0x14,%esp
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
8010108a:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
8010108c:	5b                   	pop    %ebx
8010108d:	5d                   	pop    %ebp
8010108e:	c3                   	ret    
8010108f:	90                   	nop
80101090:	83 c4 14             	add    $0x14,%esp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101093:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101098:	5b                   	pop    %ebx
80101099:	5d                   	pop    %ebp
8010109a:	c3                   	ret    
8010109b:	90                   	nop
8010109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010a0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	57                   	push   %edi
801010a4:	56                   	push   %esi
801010a5:	53                   	push   %ebx
801010a6:	83 ec 1c             	sub    $0x1c,%esp
801010a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801010af:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010b2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010b6:	74 68                	je     80101120 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
801010b8:	8b 03                	mov    (%ebx),%eax
801010ba:	83 f8 01             	cmp    $0x1,%eax
801010bd:	74 49                	je     80101108 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010bf:	83 f8 02             	cmp    $0x2,%eax
801010c2:	75 63                	jne    80101127 <fileread+0x87>
    ilock(f->ip);
801010c4:	8b 43 10             	mov    0x10(%ebx),%eax
801010c7:	89 04 24             	mov    %eax,(%esp)
801010ca:	e8 51 07 00 00       	call   80101820 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010cf:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801010d3:	8b 43 14             	mov    0x14(%ebx),%eax
801010d6:	89 74 24 04          	mov    %esi,0x4(%esp)
801010da:	89 44 24 08          	mov    %eax,0x8(%esp)
801010de:	8b 43 10             	mov    0x10(%ebx),%eax
801010e1:	89 04 24             	mov    %eax,(%esp)
801010e4:	e8 e7 09 00 00       	call   80101ad0 <readi>
801010e9:	85 c0                	test   %eax,%eax
801010eb:	89 c6                	mov    %eax,%esi
801010ed:	7e 03                	jle    801010f2 <fileread+0x52>
      f->off += r;
801010ef:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010f2:	8b 43 10             	mov    0x10(%ebx),%eax
801010f5:	89 04 24             	mov    %eax,(%esp)
801010f8:	e8 03 08 00 00       	call   80101900 <iunlock>
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010fd:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
801010ff:	83 c4 1c             	add    $0x1c,%esp
80101102:	5b                   	pop    %ebx
80101103:	5e                   	pop    %esi
80101104:	5f                   	pop    %edi
80101105:	5d                   	pop    %ebp
80101106:	c3                   	ret    
80101107:	90                   	nop
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101108:	8b 43 0c             	mov    0xc(%ebx),%eax
8010110b:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
8010110e:	83 c4 1c             	add    $0x1c,%esp
80101111:	5b                   	pop    %ebx
80101112:	5e                   	pop    %esi
80101113:	5f                   	pop    %edi
80101114:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101115:	e9 26 24 00 00       	jmp    80103540 <piperead>
8010111a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101125:	eb d8                	jmp    801010ff <fileread+0x5f>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80101127:	c7 04 24 e6 6d 10 80 	movl   $0x80106de6,(%esp)
8010112e:	e8 2d f2 ff ff       	call   80100360 <panic>
80101133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101140 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	57                   	push   %edi
80101144:	56                   	push   %esi
80101145:	53                   	push   %ebx
80101146:	83 ec 2c             	sub    $0x2c,%esp
80101149:	8b 45 0c             	mov    0xc(%ebp),%eax
8010114c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010114f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101152:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101155:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101159:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010115c:	0f 84 ae 00 00 00    	je     80101210 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101162:	8b 07                	mov    (%edi),%eax
80101164:	83 f8 01             	cmp    $0x1,%eax
80101167:	0f 84 c2 00 00 00    	je     8010122f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010116d:	83 f8 02             	cmp    $0x2,%eax
80101170:	0f 85 d7 00 00 00    	jne    8010124d <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101176:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101179:	31 db                	xor    %ebx,%ebx
8010117b:	85 c0                	test   %eax,%eax
8010117d:	7f 31                	jg     801011b0 <filewrite+0x70>
8010117f:	e9 9c 00 00 00       	jmp    80101220 <filewrite+0xe0>
80101184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101188:	8b 4f 10             	mov    0x10(%edi),%ecx
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
8010118b:	01 47 14             	add    %eax,0x14(%edi)
8010118e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101191:	89 0c 24             	mov    %ecx,(%esp)
80101194:	e8 67 07 00 00       	call   80101900 <iunlock>
      end_op();
80101199:	e8 42 1b 00 00       	call   80102ce0 <end_op>
8010119e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
801011a1:	39 f0                	cmp    %esi,%eax
801011a3:	0f 85 98 00 00 00    	jne    80101241 <filewrite+0x101>
        panic("short filewrite");
      i += r;
801011a9:	01 c3                	add    %eax,%ebx
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801011ab:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
801011ae:	7e 70                	jle    80101220 <filewrite+0xe0>
      int n1 = n - i;
801011b0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801011b3:	b8 00 06 00 00       	mov    $0x600,%eax
801011b8:	29 de                	sub    %ebx,%esi
801011ba:	81 fe 00 06 00 00    	cmp    $0x600,%esi
801011c0:	0f 4f f0             	cmovg  %eax,%esi
      if(n1 > max)
        n1 = max;

      begin_op();
801011c3:	e8 a8 1a 00 00       	call   80102c70 <begin_op>
      ilock(f->ip);
801011c8:	8b 47 10             	mov    0x10(%edi),%eax
801011cb:	89 04 24             	mov    %eax,(%esp)
801011ce:	e8 4d 06 00 00       	call   80101820 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011d3:	89 74 24 0c          	mov    %esi,0xc(%esp)
801011d7:	8b 47 14             	mov    0x14(%edi),%eax
801011da:	89 44 24 08          	mov    %eax,0x8(%esp)
801011de:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011e1:	01 d8                	add    %ebx,%eax
801011e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801011e7:	8b 47 10             	mov    0x10(%edi),%eax
801011ea:	89 04 24             	mov    %eax,(%esp)
801011ed:	e8 de 09 00 00       	call   80101bd0 <writei>
801011f2:	85 c0                	test   %eax,%eax
801011f4:	7f 92                	jg     80101188 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801011f6:	8b 4f 10             	mov    0x10(%edi),%ecx
801011f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011fc:	89 0c 24             	mov    %ecx,(%esp)
801011ff:	e8 fc 06 00 00       	call   80101900 <iunlock>
      end_op();
80101204:	e8 d7 1a 00 00       	call   80102ce0 <end_op>

      if(r < 0)
80101209:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010120c:	85 c0                	test   %eax,%eax
8010120e:	74 91                	je     801011a1 <filewrite+0x61>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101210:	83 c4 2c             	add    $0x2c,%esp
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
80101213:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101218:	5b                   	pop    %ebx
80101219:	5e                   	pop    %esi
8010121a:	5f                   	pop    %edi
8010121b:	5d                   	pop    %ebp
8010121c:	c3                   	ret    
8010121d:	8d 76 00             	lea    0x0(%esi),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101220:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80101223:	89 d8                	mov    %ebx,%eax
80101225:	75 e9                	jne    80101210 <filewrite+0xd0>
  }
  panic("filewrite");
}
80101227:	83 c4 2c             	add    $0x2c,%esp
8010122a:	5b                   	pop    %ebx
8010122b:	5e                   	pop    %esi
8010122c:	5f                   	pop    %edi
8010122d:	5d                   	pop    %ebp
8010122e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010122f:	8b 47 0c             	mov    0xc(%edi),%eax
80101232:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101235:	83 c4 2c             	add    $0x2c,%esp
80101238:	5b                   	pop    %ebx
80101239:	5e                   	pop    %esi
8010123a:	5f                   	pop    %edi
8010123b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010123c:	e9 0f 22 00 00       	jmp    80103450 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101241:	c7 04 24 ef 6d 10 80 	movl   $0x80106def,(%esp)
80101248:	e8 13 f1 ff ff       	call   80100360 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010124d:	c7 04 24 f5 6d 10 80 	movl   $0x80106df5,(%esp)
80101254:	e8 07 f1 ff ff       	call   80100360 <panic>
80101259:	66 90                	xchg   %ax,%ax
8010125b:	66 90                	xchg   %ax,%ax
8010125d:	66 90                	xchg   %ax,%ax
8010125f:	90                   	nop

80101260 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101260:	55                   	push   %ebp
80101261:	89 e5                	mov    %esp,%ebp
80101263:	57                   	push   %edi
80101264:	56                   	push   %esi
80101265:	53                   	push   %ebx
80101266:	83 ec 2c             	sub    $0x2c,%esp
80101269:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010126c:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101271:	85 c0                	test   %eax,%eax
80101273:	0f 84 8c 00 00 00    	je     80101305 <balloc+0xa5>
80101279:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101280:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101283:	89 f0                	mov    %esi,%eax
80101285:	c1 f8 0c             	sar    $0xc,%eax
80101288:	03 05 f8 09 11 80    	add    0x801109f8,%eax
8010128e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101292:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101295:	89 04 24             	mov    %eax,(%esp)
80101298:	e8 33 ee ff ff       	call   801000d0 <bread>
8010129d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801012a0:	a1 e0 09 11 80       	mov    0x801109e0,%eax
801012a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012a8:	31 c0                	xor    %eax,%eax
801012aa:	eb 33                	jmp    801012df <balloc+0x7f>
801012ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012b0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801012b3:	89 c2                	mov    %eax,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801012b5:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012b7:	c1 fa 03             	sar    $0x3,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801012ba:	83 e1 07             	and    $0x7,%ecx
801012bd:	bf 01 00 00 00       	mov    $0x1,%edi
801012c2:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012c4:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801012c9:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012cb:	0f b6 fb             	movzbl %bl,%edi
801012ce:	85 cf                	test   %ecx,%edi
801012d0:	74 46                	je     80101318 <balloc+0xb8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012d2:	83 c0 01             	add    $0x1,%eax
801012d5:	83 c6 01             	add    $0x1,%esi
801012d8:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012dd:	74 05                	je     801012e4 <balloc+0x84>
801012df:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801012e2:	72 cc                	jb     801012b0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801012e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801012e7:	89 04 24             	mov    %eax,(%esp)
801012ea:	e8 f1 ee ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801012ef:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012f6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012f9:	3b 05 e0 09 11 80    	cmp    0x801109e0,%eax
801012ff:	0f 82 7b ff ff ff    	jb     80101280 <balloc+0x20>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101305:	c7 04 24 ff 6d 10 80 	movl   $0x80106dff,(%esp)
8010130c:	e8 4f f0 ff ff       	call   80100360 <panic>
80101311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101318:	09 d9                	or     %ebx,%ecx
8010131a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010131d:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
80101321:	89 1c 24             	mov    %ebx,(%esp)
80101324:	e8 e7 1a 00 00       	call   80102e10 <log_write>
        brelse(bp);
80101329:	89 1c 24             	mov    %ebx,(%esp)
8010132c:	e8 af ee ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101331:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101334:	89 74 24 04          	mov    %esi,0x4(%esp)
80101338:	89 04 24             	mov    %eax,(%esp)
8010133b:	e8 90 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101340:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101347:	00 
80101348:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010134f:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101350:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101352:	8d 40 5c             	lea    0x5c(%eax),%eax
80101355:	89 04 24             	mov    %eax,(%esp)
80101358:	e8 a3 30 00 00       	call   80104400 <memset>
  log_write(bp);
8010135d:	89 1c 24             	mov    %ebx,(%esp)
80101360:	e8 ab 1a 00 00       	call   80102e10 <log_write>
  brelse(bp);
80101365:	89 1c 24             	mov    %ebx,(%esp)
80101368:	e8 73 ee ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010136d:	83 c4 2c             	add    $0x2c,%esp
80101370:	89 f0                	mov    %esi,%eax
80101372:	5b                   	pop    %ebx
80101373:	5e                   	pop    %esi
80101374:	5f                   	pop    %edi
80101375:	5d                   	pop    %ebp
80101376:	c3                   	ret    
80101377:	89 f6                	mov    %esi,%esi
80101379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101380 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101380:	55                   	push   %ebp
80101381:	89 e5                	mov    %esp,%ebp
80101383:	57                   	push   %edi
80101384:	89 c7                	mov    %eax,%edi
80101386:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101387:	31 f6                	xor    %esi,%esi
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101389:	53                   	push   %ebx

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010138a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010138f:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101392:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101399:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010139c:	e8 9f 2f 00 00       	call   80104340 <acquire>

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013a4:	eb 14                	jmp    801013ba <iget+0x3a>
801013a6:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013a8:	85 f6                	test   %esi,%esi
801013aa:	74 3c                	je     801013e8 <iget+0x68>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ac:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013b2:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801013b8:	74 46                	je     80101400 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013ba:	8b 4b 08             	mov    0x8(%ebx),%ecx
801013bd:	85 c9                	test   %ecx,%ecx
801013bf:	7e e7                	jle    801013a8 <iget+0x28>
801013c1:	39 3b                	cmp    %edi,(%ebx)
801013c3:	75 e3                	jne    801013a8 <iget+0x28>
801013c5:	39 53 04             	cmp    %edx,0x4(%ebx)
801013c8:	75 de                	jne    801013a8 <iget+0x28>
      ip->ref++;
801013ca:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
801013cd:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
801013cf:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801013d6:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801013d9:	e8 d2 2f 00 00       	call   801043b0 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801013de:	83 c4 1c             	add    $0x1c,%esp
801013e1:	89 f0                	mov    %esi,%eax
801013e3:	5b                   	pop    %ebx
801013e4:	5e                   	pop    %esi
801013e5:	5f                   	pop    %edi
801013e6:	5d                   	pop    %ebp
801013e7:	c3                   	ret    
801013e8:	85 c9                	test   %ecx,%ecx
801013ea:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ed:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013f3:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801013f9:	75 bf                	jne    801013ba <iget+0x3a>
801013fb:	90                   	nop
801013fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101400:	85 f6                	test   %esi,%esi
80101402:	74 29                	je     8010142d <iget+0xad>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101404:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101406:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101409:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101410:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101417:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010141e:	e8 8d 2f 00 00       	call   801043b0 <release>

  return ip;
}
80101423:	83 c4 1c             	add    $0x1c,%esp
80101426:	89 f0                	mov    %esi,%eax
80101428:	5b                   	pop    %ebx
80101429:	5e                   	pop    %esi
8010142a:	5f                   	pop    %edi
8010142b:	5d                   	pop    %ebp
8010142c:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
8010142d:	c7 04 24 15 6e 10 80 	movl   $0x80106e15,(%esp)
80101434:	e8 27 ef ff ff       	call   80100360 <panic>
80101439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101440 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101440:	55                   	push   %ebp
80101441:	89 e5                	mov    %esp,%ebp
80101443:	57                   	push   %edi
80101444:	56                   	push   %esi
80101445:	53                   	push   %ebx
80101446:	89 c3                	mov    %eax,%ebx
80101448:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010144b:	83 fa 0b             	cmp    $0xb,%edx
8010144e:	77 18                	ja     80101468 <bmap+0x28>
80101450:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
80101453:	8b 46 5c             	mov    0x5c(%esi),%eax
80101456:	85 c0                	test   %eax,%eax
80101458:	74 66                	je     801014c0 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010145a:	83 c4 1c             	add    $0x1c,%esp
8010145d:	5b                   	pop    %ebx
8010145e:	5e                   	pop    %esi
8010145f:	5f                   	pop    %edi
80101460:	5d                   	pop    %ebp
80101461:	c3                   	ret    
80101462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101468:	8d 72 f4             	lea    -0xc(%edx),%esi

  if(bn < NINDIRECT){
8010146b:	83 fe 7f             	cmp    $0x7f,%esi
8010146e:	77 77                	ja     801014e7 <bmap+0xa7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101470:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101476:	85 c0                	test   %eax,%eax
80101478:	74 5e                	je     801014d8 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010147a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010147e:	8b 03                	mov    (%ebx),%eax
80101480:	89 04 24             	mov    %eax,(%esp)
80101483:	e8 48 ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101488:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010148c:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
8010148e:	8b 32                	mov    (%edx),%esi
80101490:	85 f6                	test   %esi,%esi
80101492:	75 19                	jne    801014ad <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
80101494:	8b 03                	mov    (%ebx),%eax
80101496:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101499:	e8 c2 fd ff ff       	call   80101260 <balloc>
8010149e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014a1:	89 02                	mov    %eax,(%edx)
801014a3:	89 c6                	mov    %eax,%esi
      log_write(bp);
801014a5:	89 3c 24             	mov    %edi,(%esp)
801014a8:	e8 63 19 00 00       	call   80102e10 <log_write>
    }
    brelse(bp);
801014ad:	89 3c 24             	mov    %edi,(%esp)
801014b0:	e8 2b ed ff ff       	call   801001e0 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
801014b5:	83 c4 1c             	add    $0x1c,%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801014b8:	89 f0                	mov    %esi,%eax
    return addr;
  }

  panic("bmap: out of range");
}
801014ba:	5b                   	pop    %ebx
801014bb:	5e                   	pop    %esi
801014bc:	5f                   	pop    %edi
801014bd:	5d                   	pop    %ebp
801014be:	c3                   	ret    
801014bf:	90                   	nop
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
801014c0:	8b 03                	mov    (%ebx),%eax
801014c2:	e8 99 fd ff ff       	call   80101260 <balloc>
801014c7:	89 46 5c             	mov    %eax,0x5c(%esi)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014ca:	83 c4 1c             	add    $0x1c,%esp
801014cd:	5b                   	pop    %ebx
801014ce:	5e                   	pop    %esi
801014cf:	5f                   	pop    %edi
801014d0:	5d                   	pop    %ebp
801014d1:	c3                   	ret    
801014d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014d8:	8b 03                	mov    (%ebx),%eax
801014da:	e8 81 fd ff ff       	call   80101260 <balloc>
801014df:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
801014e5:	eb 93                	jmp    8010147a <bmap+0x3a>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801014e7:	c7 04 24 25 6e 10 80 	movl   $0x80106e25,(%esp)
801014ee:	e8 6d ee ff ff       	call   80100360 <panic>
801014f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101500 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	56                   	push   %esi
80101504:	53                   	push   %ebx
80101505:	83 ec 10             	sub    $0x10,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101508:	8b 45 08             	mov    0x8(%ebp),%eax
8010150b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101512:	00 
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101513:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101516:	89 04 24             	mov    %eax,(%esp)
80101519:	e8 b2 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010151e:	89 34 24             	mov    %esi,(%esp)
80101521:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101528:	00 
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
80101529:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010152b:	8d 40 5c             	lea    0x5c(%eax),%eax
8010152e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101532:	e8 69 2f 00 00       	call   801044a0 <memmove>
  brelse(bp);
80101537:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010153a:	83 c4 10             	add    $0x10,%esp
8010153d:	5b                   	pop    %ebx
8010153e:	5e                   	pop    %esi
8010153f:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101540:	e9 9b ec ff ff       	jmp    801001e0 <brelse>
80101545:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101550 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	57                   	push   %edi
80101554:	89 d7                	mov    %edx,%edi
80101556:	56                   	push   %esi
80101557:	53                   	push   %ebx
80101558:	89 c3                	mov    %eax,%ebx
8010155a:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
8010155d:	89 04 24             	mov    %eax,(%esp)
80101560:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
80101567:	80 
80101568:	e8 93 ff ff ff       	call   80101500 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010156d:	89 fa                	mov    %edi,%edx
8010156f:	c1 ea 0c             	shr    $0xc,%edx
80101572:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101578:	89 1c 24             	mov    %ebx,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
8010157b:	bb 01 00 00 00       	mov    $0x1,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
80101580:	89 54 24 04          	mov    %edx,0x4(%esp)
80101584:	e8 47 eb ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101589:	89 f9                	mov    %edi,%ecx
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
8010158b:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80101591:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
80101593:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101596:	c1 fa 03             	sar    $0x3,%edx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101599:	d3 e3                	shl    %cl,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
8010159b:	89 c6                	mov    %eax,%esi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
8010159d:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
801015a2:	0f b6 c8             	movzbl %al,%ecx
801015a5:	85 d9                	test   %ebx,%ecx
801015a7:	74 20                	je     801015c9 <bfree+0x79>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801015a9:	f7 d3                	not    %ebx
801015ab:	21 c3                	and    %eax,%ebx
801015ad:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
801015b1:	89 34 24             	mov    %esi,(%esp)
801015b4:	e8 57 18 00 00       	call   80102e10 <log_write>
  brelse(bp);
801015b9:	89 34 24             	mov    %esi,(%esp)
801015bc:	e8 1f ec ff ff       	call   801001e0 <brelse>
}
801015c1:	83 c4 1c             	add    $0x1c,%esp
801015c4:	5b                   	pop    %ebx
801015c5:	5e                   	pop    %esi
801015c6:	5f                   	pop    %edi
801015c7:	5d                   	pop    %ebp
801015c8:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
801015c9:	c7 04 24 38 6e 10 80 	movl   $0x80106e38,(%esp)
801015d0:	e8 8b ed ff ff       	call   80100360 <panic>
801015d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015e0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	53                   	push   %ebx
801015e4:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
801015e9:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801015ec:	c7 44 24 04 4b 6e 10 	movl   $0x80106e4b,0x4(%esp)
801015f3:	80 
801015f4:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801015fb:	e8 d0 2b 00 00       	call   801041d0 <initlock>
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101600:	89 1c 24             	mov    %ebx,(%esp)
80101603:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101609:	c7 44 24 04 52 6e 10 	movl   $0x80106e52,0x4(%esp)
80101610:	80 
80101611:	e8 8a 2a 00 00       	call   801040a0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101616:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
8010161c:	75 e2                	jne    80101600 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010161e:	8b 45 08             	mov    0x8(%ebp),%eax
80101621:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
80101628:	80 
80101629:	89 04 24             	mov    %eax,(%esp)
8010162c:	e8 cf fe ff ff       	call   80101500 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101631:	a1 f8 09 11 80       	mov    0x801109f8,%eax
80101636:	c7 04 24 b8 6e 10 80 	movl   $0x80106eb8,(%esp)
8010163d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101641:	a1 f4 09 11 80       	mov    0x801109f4,%eax
80101646:	89 44 24 18          	mov    %eax,0x18(%esp)
8010164a:	a1 f0 09 11 80       	mov    0x801109f0,%eax
8010164f:	89 44 24 14          	mov    %eax,0x14(%esp)
80101653:	a1 ec 09 11 80       	mov    0x801109ec,%eax
80101658:	89 44 24 10          	mov    %eax,0x10(%esp)
8010165c:	a1 e8 09 11 80       	mov    0x801109e8,%eax
80101661:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101665:	a1 e4 09 11 80       	mov    0x801109e4,%eax
8010166a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010166e:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101673:	89 44 24 04          	mov    %eax,0x4(%esp)
80101677:	e8 a4 f0 ff ff       	call   80100720 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
8010167c:	83 c4 24             	add    $0x24,%esp
8010167f:	5b                   	pop    %ebx
80101680:	5d                   	pop    %ebp
80101681:	c3                   	ret    
80101682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101690 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	57                   	push   %edi
80101694:	56                   	push   %esi
80101695:	53                   	push   %ebx
80101696:	83 ec 2c             	sub    $0x2c,%esp
80101699:	8b 45 0c             	mov    0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010169c:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801016a3:	8b 7d 08             	mov    0x8(%ebp),%edi
801016a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016a9:	0f 86 a2 00 00 00    	jbe    80101751 <ialloc+0xc1>
801016af:	be 01 00 00 00       	mov    $0x1,%esi
801016b4:	bb 01 00 00 00       	mov    $0x1,%ebx
801016b9:	eb 1a                	jmp    801016d5 <ialloc+0x45>
801016bb:	90                   	nop
801016bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801016c0:	89 14 24             	mov    %edx,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016c3:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801016c6:	e8 15 eb ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016cb:	89 de                	mov    %ebx,%esi
801016cd:	3b 1d e8 09 11 80    	cmp    0x801109e8,%ebx
801016d3:	73 7c                	jae    80101751 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
801016d5:	89 f0                	mov    %esi,%eax
801016d7:	c1 e8 03             	shr    $0x3,%eax
801016da:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016e0:	89 3c 24             	mov    %edi,(%esp)
801016e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801016e7:	e8 e4 e9 ff ff       	call   801000d0 <bread>
801016ec:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
801016ee:	89 f0                	mov    %esi,%eax
801016f0:	83 e0 07             	and    $0x7,%eax
801016f3:	c1 e0 06             	shl    $0x6,%eax
801016f6:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016fa:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016fe:	75 c0                	jne    801016c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101700:	89 0c 24             	mov    %ecx,(%esp)
80101703:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010170a:	00 
8010170b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101712:	00 
80101713:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101716:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101719:	e8 e2 2c 00 00       	call   80104400 <memset>
      dip->type = type;
8010171e:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
80101722:	8b 55 dc             	mov    -0x24(%ebp),%edx
  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
80101725:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
80101728:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
8010172b:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010172e:	89 14 24             	mov    %edx,(%esp)
80101731:	e8 da 16 00 00       	call   80102e10 <log_write>
      brelse(bp);
80101736:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101739:	89 14 24             	mov    %edx,(%esp)
8010173c:	e8 9f ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101741:	83 c4 2c             	add    $0x2c,%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101744:	89 f2                	mov    %esi,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101746:	5b                   	pop    %ebx
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101747:	89 f8                	mov    %edi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101749:	5e                   	pop    %esi
8010174a:	5f                   	pop    %edi
8010174b:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010174c:	e9 2f fc ff ff       	jmp    80101380 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101751:	c7 04 24 58 6e 10 80 	movl   $0x80106e58,(%esp)
80101758:	e8 03 ec ff ff       	call   80100360 <panic>
8010175d:	8d 76 00             	lea    0x0(%esi),%esi

80101760 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	83 ec 10             	sub    $0x10,%esp
80101768:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010176b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010176e:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101771:	c1 e8 03             	shr    $0x3,%eax
80101774:	03 05 f4 09 11 80    	add    0x801109f4,%eax
8010177a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010177e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101781:	89 04 24             	mov    %eax,(%esp)
80101784:	e8 47 e9 ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101789:	8b 53 a8             	mov    -0x58(%ebx),%edx
8010178c:	83 e2 07             	and    $0x7,%edx
8010178f:	c1 e2 06             	shl    $0x6,%edx
80101792:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101796:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
80101798:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010179c:	83 c2 0c             	add    $0xc,%edx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
8010179f:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
801017a3:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
801017a7:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
801017ab:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
801017af:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
801017b3:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
801017b7:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
801017bb:	8b 43 fc             	mov    -0x4(%ebx),%eax
801017be:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017c1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801017c5:	89 14 24             	mov    %edx,(%esp)
801017c8:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801017cf:	00 
801017d0:	e8 cb 2c 00 00       	call   801044a0 <memmove>
  log_write(bp);
801017d5:	89 34 24             	mov    %esi,(%esp)
801017d8:	e8 33 16 00 00       	call   80102e10 <log_write>
  brelse(bp);
801017dd:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017e0:	83 c4 10             	add    $0x10,%esp
801017e3:	5b                   	pop    %ebx
801017e4:	5e                   	pop    %esi
801017e5:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801017e6:	e9 f5 e9 ff ff       	jmp    801001e0 <brelse>
801017eb:	90                   	nop
801017ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017f0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	53                   	push   %ebx
801017f4:	83 ec 14             	sub    $0x14,%esp
801017f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017fa:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101801:	e8 3a 2b 00 00       	call   80104340 <acquire>
  ip->ref++;
80101806:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010180a:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101811:	e8 9a 2b 00 00       	call   801043b0 <release>
  return ip;
}
80101816:	83 c4 14             	add    $0x14,%esp
80101819:	89 d8                	mov    %ebx,%eax
8010181b:	5b                   	pop    %ebx
8010181c:	5d                   	pop    %ebp
8010181d:	c3                   	ret    
8010181e:	66 90                	xchg   %ax,%ax

80101820 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	56                   	push   %esi
80101824:	53                   	push   %ebx
80101825:	83 ec 10             	sub    $0x10,%esp
80101828:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010182b:	85 db                	test   %ebx,%ebx
8010182d:	0f 84 b3 00 00 00    	je     801018e6 <ilock+0xc6>
80101833:	8b 53 08             	mov    0x8(%ebx),%edx
80101836:	85 d2                	test   %edx,%edx
80101838:	0f 8e a8 00 00 00    	jle    801018e6 <ilock+0xc6>
    panic("ilock");

  acquiresleep(&ip->lock);
8010183e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101841:	89 04 24             	mov    %eax,(%esp)
80101844:	e8 97 28 00 00       	call   801040e0 <acquiresleep>

  if(ip->valid == 0){
80101849:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010184c:	85 c0                	test   %eax,%eax
8010184e:	74 08                	je     80101858 <ilock+0x38>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101850:	83 c4 10             	add    $0x10,%esp
80101853:	5b                   	pop    %ebx
80101854:	5e                   	pop    %esi
80101855:	5d                   	pop    %ebp
80101856:	c3                   	ret    
80101857:	90                   	nop
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101858:	8b 43 04             	mov    0x4(%ebx),%eax
8010185b:	c1 e8 03             	shr    $0x3,%eax
8010185e:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101864:	89 44 24 04          	mov    %eax,0x4(%esp)
80101868:	8b 03                	mov    (%ebx),%eax
8010186a:	89 04 24             	mov    %eax,(%esp)
8010186d:	e8 5e e8 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101872:	8b 53 04             	mov    0x4(%ebx),%edx
80101875:	83 e2 07             	and    $0x7,%edx
80101878:	c1 e2 06             	shl    $0x6,%edx
8010187b:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010187f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
80101881:	0f b7 02             	movzwl (%edx),%eax
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101884:	83 c2 0c             	add    $0xc,%edx
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
80101887:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010188b:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
8010188f:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101893:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
80101897:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
8010189b:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
8010189f:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
801018a3:	8b 42 fc             	mov    -0x4(%edx),%eax
801018a6:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018a9:	8d 43 5c             	lea    0x5c(%ebx),%eax
801018ac:	89 54 24 04          	mov    %edx,0x4(%esp)
801018b0:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801018b7:	00 
801018b8:	89 04 24             	mov    %eax,(%esp)
801018bb:	e8 e0 2b 00 00       	call   801044a0 <memmove>
    brelse(bp);
801018c0:	89 34 24             	mov    %esi,(%esp)
801018c3:	e8 18 e9 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
801018c8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
801018cd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018d4:	0f 85 76 ff ff ff    	jne    80101850 <ilock+0x30>
      panic("ilock: no type");
801018da:	c7 04 24 70 6e 10 80 	movl   $0x80106e70,(%esp)
801018e1:	e8 7a ea ff ff       	call   80100360 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801018e6:	c7 04 24 6a 6e 10 80 	movl   $0x80106e6a,(%esp)
801018ed:	e8 6e ea ff ff       	call   80100360 <panic>
801018f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101900 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101900:	55                   	push   %ebp
80101901:	89 e5                	mov    %esp,%ebp
80101903:	56                   	push   %esi
80101904:	53                   	push   %ebx
80101905:	83 ec 10             	sub    $0x10,%esp
80101908:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010190b:	85 db                	test   %ebx,%ebx
8010190d:	74 24                	je     80101933 <iunlock+0x33>
8010190f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101912:	89 34 24             	mov    %esi,(%esp)
80101915:	e8 66 28 00 00       	call   80104180 <holdingsleep>
8010191a:	85 c0                	test   %eax,%eax
8010191c:	74 15                	je     80101933 <iunlock+0x33>
8010191e:	8b 43 08             	mov    0x8(%ebx),%eax
80101921:	85 c0                	test   %eax,%eax
80101923:	7e 0e                	jle    80101933 <iunlock+0x33>
    panic("iunlock");

  releasesleep(&ip->lock);
80101925:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101928:	83 c4 10             	add    $0x10,%esp
8010192b:	5b                   	pop    %ebx
8010192c:	5e                   	pop    %esi
8010192d:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010192e:	e9 0d 28 00 00       	jmp    80104140 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101933:	c7 04 24 7f 6e 10 80 	movl   $0x80106e7f,(%esp)
8010193a:	e8 21 ea ff ff       	call   80100360 <panic>
8010193f:	90                   	nop

80101940 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	57                   	push   %edi
80101944:	56                   	push   %esi
80101945:	53                   	push   %ebx
80101946:	83 ec 1c             	sub    $0x1c,%esp
80101949:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010194c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010194f:	89 3c 24             	mov    %edi,(%esp)
80101952:	e8 89 27 00 00       	call   801040e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101957:	8b 56 4c             	mov    0x4c(%esi),%edx
8010195a:	85 d2                	test   %edx,%edx
8010195c:	74 07                	je     80101965 <iput+0x25>
8010195e:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101963:	74 2b                	je     80101990 <iput+0x50>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101965:	89 3c 24             	mov    %edi,(%esp)
80101968:	e8 d3 27 00 00       	call   80104140 <releasesleep>

  acquire(&icache.lock);
8010196d:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101974:	e8 c7 29 00 00       	call   80104340 <acquire>
  ip->ref--;
80101979:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010197d:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
80101984:	83 c4 1c             	add    $0x1c,%esp
80101987:	5b                   	pop    %ebx
80101988:	5e                   	pop    %esi
80101989:	5f                   	pop    %edi
8010198a:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
8010198b:	e9 20 2a 00 00       	jmp    801043b0 <release>
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101990:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101997:	e8 a4 29 00 00       	call   80104340 <acquire>
    int r = ip->ref;
8010199c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010199f:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801019a6:	e8 05 2a 00 00       	call   801043b0 <release>
    if(r == 1){
801019ab:	83 fb 01             	cmp    $0x1,%ebx
801019ae:	75 b5                	jne    80101965 <iput+0x25>
801019b0:	8d 4e 30             	lea    0x30(%esi),%ecx
801019b3:	89 f3                	mov    %esi,%ebx
801019b5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019b8:	89 cf                	mov    %ecx,%edi
801019ba:	eb 0b                	jmp    801019c7 <iput+0x87>
801019bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019c0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019c3:	39 fb                	cmp    %edi,%ebx
801019c5:	74 19                	je     801019e0 <iput+0xa0>
    if(ip->addrs[i]){
801019c7:	8b 53 5c             	mov    0x5c(%ebx),%edx
801019ca:	85 d2                	test   %edx,%edx
801019cc:	74 f2                	je     801019c0 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
801019ce:	8b 06                	mov    (%esi),%eax
801019d0:	e8 7b fb ff ff       	call   80101550 <bfree>
      ip->addrs[i] = 0;
801019d5:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
801019dc:	eb e2                	jmp    801019c0 <iput+0x80>
801019de:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
801019e0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801019e6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019e9:	85 c0                	test   %eax,%eax
801019eb:	75 2b                	jne    80101a18 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801019ed:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801019f4:	89 34 24             	mov    %esi,(%esp)
801019f7:	e8 64 fd ff ff       	call   80101760 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
801019fc:	31 c0                	xor    %eax,%eax
801019fe:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101a02:	89 34 24             	mov    %esi,(%esp)
80101a05:	e8 56 fd ff ff       	call   80101760 <iupdate>
      ip->valid = 0;
80101a0a:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101a11:	e9 4f ff ff ff       	jmp    80101965 <iput+0x25>
80101a16:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a18:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a1c:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101a1e:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a20:	89 04 24             	mov    %eax,(%esp)
80101a23:	e8 a8 e6 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101a28:	89 7d e0             	mov    %edi,-0x20(%ebp)
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
80101a2b:	8d 48 5c             	lea    0x5c(%eax),%ecx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101a31:	89 cf                	mov    %ecx,%edi
80101a33:	31 c0                	xor    %eax,%eax
80101a35:	eb 0e                	jmp    80101a45 <iput+0x105>
80101a37:	90                   	nop
80101a38:	83 c3 01             	add    $0x1,%ebx
80101a3b:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101a41:	89 d8                	mov    %ebx,%eax
80101a43:	74 10                	je     80101a55 <iput+0x115>
      if(a[j])
80101a45:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101a48:	85 d2                	test   %edx,%edx
80101a4a:	74 ec                	je     80101a38 <iput+0xf8>
        bfree(ip->dev, a[j]);
80101a4c:	8b 06                	mov    (%esi),%eax
80101a4e:	e8 fd fa ff ff       	call   80101550 <bfree>
80101a53:	eb e3                	jmp    80101a38 <iput+0xf8>
    }
    brelse(bp);
80101a55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a58:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a5b:	89 04 24             	mov    %eax,(%esp)
80101a5e:	e8 7d e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a63:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101a69:	8b 06                	mov    (%esi),%eax
80101a6b:	e8 e0 fa ff ff       	call   80101550 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a70:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101a77:	00 00 00 
80101a7a:	e9 6e ff ff ff       	jmp    801019ed <iput+0xad>
80101a7f:	90                   	nop

80101a80 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	53                   	push   %ebx
80101a84:	83 ec 14             	sub    $0x14,%esp
80101a87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a8a:	89 1c 24             	mov    %ebx,(%esp)
80101a8d:	e8 6e fe ff ff       	call   80101900 <iunlock>
  iput(ip);
80101a92:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101a95:	83 c4 14             	add    $0x14,%esp
80101a98:	5b                   	pop    %ebx
80101a99:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101a9a:	e9 a1 fe ff ff       	jmp    80101940 <iput>
80101a9f:	90                   	nop

80101aa0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	8b 55 08             	mov    0x8(%ebp),%edx
80101aa6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101aa9:	8b 0a                	mov    (%edx),%ecx
80101aab:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101aae:	8b 4a 04             	mov    0x4(%edx),%ecx
80101ab1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101ab4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101ab8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101abb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101abf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ac3:	8b 52 58             	mov    0x58(%edx),%edx
80101ac6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ac9:	5d                   	pop    %ebp
80101aca:	c3                   	ret    
80101acb:	90                   	nop
80101acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ad0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	57                   	push   %edi
80101ad4:	56                   	push   %esi
80101ad5:	53                   	push   %ebx
80101ad6:	83 ec 2c             	sub    $0x2c,%esp
80101ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101adc:	8b 7d 08             	mov    0x8(%ebp),%edi
80101adf:	8b 75 10             	mov    0x10(%ebp),%esi
80101ae2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101ae5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ae8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101aed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101af0:	0f 84 aa 00 00 00    	je     80101ba0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101af6:	8b 47 58             	mov    0x58(%edi),%eax
80101af9:	39 f0                	cmp    %esi,%eax
80101afb:	0f 82 c7 00 00 00    	jb     80101bc8 <readi+0xf8>
80101b01:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b04:	89 da                	mov    %ebx,%edx
80101b06:	01 f2                	add    %esi,%edx
80101b08:	0f 82 ba 00 00 00    	jb     80101bc8 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b0e:	89 c1                	mov    %eax,%ecx
80101b10:	29 f1                	sub    %esi,%ecx
80101b12:	39 d0                	cmp    %edx,%eax
80101b14:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b17:	31 c0                	xor    %eax,%eax
80101b19:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b1b:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b1e:	74 70                	je     80101b90 <readi+0xc0>
80101b20:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101b23:	89 c7                	mov    %eax,%edi
80101b25:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b28:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b2b:	89 f2                	mov    %esi,%edx
80101b2d:	c1 ea 09             	shr    $0x9,%edx
80101b30:	89 d8                	mov    %ebx,%eax
80101b32:	e8 09 f9 ff ff       	call   80101440 <bmap>
80101b37:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b3b:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b3d:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b42:	89 04 24             	mov    %eax,(%esp)
80101b45:	e8 86 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b4a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101b4d:	29 f9                	sub    %edi,%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b4f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b51:	89 f0                	mov    %esi,%eax
80101b53:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b58:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b5a:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b5e:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b60:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b64:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b67:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b6a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b6e:	01 df                	add    %ebx,%edi
80101b70:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101b72:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101b75:	89 04 24             	mov    %eax,(%esp)
80101b78:	e8 23 29 00 00       	call   801044a0 <memmove>
    brelse(bp);
80101b7d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b80:	89 14 24             	mov    %edx,(%esp)
80101b83:	e8 58 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b88:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b8b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b8e:	77 98                	ja     80101b28 <readi+0x58>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101b90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b93:	83 c4 2c             	add    $0x2c,%esp
80101b96:	5b                   	pop    %ebx
80101b97:	5e                   	pop    %esi
80101b98:	5f                   	pop    %edi
80101b99:	5d                   	pop    %ebp
80101b9a:	c3                   	ret    
80101b9b:	90                   	nop
80101b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ba0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101ba4:	66 83 f8 09          	cmp    $0x9,%ax
80101ba8:	77 1e                	ja     80101bc8 <readi+0xf8>
80101baa:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101bb1:	85 c0                	test   %eax,%eax
80101bb3:	74 13                	je     80101bc8 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101bb5:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101bb8:	89 75 10             	mov    %esi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101bbb:	83 c4 2c             	add    $0x2c,%esp
80101bbe:	5b                   	pop    %ebx
80101bbf:	5e                   	pop    %esi
80101bc0:	5f                   	pop    %edi
80101bc1:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101bc2:	ff e0                	jmp    *%eax
80101bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101bc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bcd:	eb c4                	jmp    80101b93 <readi+0xc3>
80101bcf:	90                   	nop

80101bd0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 2c             	sub    $0x2c,%esp
80101bd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bdc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101bdf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101be2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101be7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101bea:	8b 75 10             	mov    0x10(%ebp),%esi
80101bed:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bf0:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bf3:	0f 84 b7 00 00 00    	je     80101cb0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bf9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bfc:	39 70 58             	cmp    %esi,0x58(%eax)
80101bff:	0f 82 e3 00 00 00    	jb     80101ce8 <writei+0x118>
80101c05:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101c08:	89 c8                	mov    %ecx,%eax
80101c0a:	01 f0                	add    %esi,%eax
80101c0c:	0f 82 d6 00 00 00    	jb     80101ce8 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c12:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c17:	0f 87 cb 00 00 00    	ja     80101ce8 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c1d:	85 c9                	test   %ecx,%ecx
80101c1f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c26:	74 77                	je     80101c9f <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c28:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c2b:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c2d:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c32:	c1 ea 09             	shr    $0x9,%edx
80101c35:	89 f8                	mov    %edi,%eax
80101c37:	e8 04 f8 ff ff       	call   80101440 <bmap>
80101c3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c40:	8b 07                	mov    (%edi),%eax
80101c42:	89 04 24             	mov    %eax,(%esp)
80101c45:	e8 86 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c4a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101c4d:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c50:	8b 55 dc             	mov    -0x24(%ebp),%edx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c53:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c55:	89 f0                	mov    %esi,%eax
80101c57:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c5c:	29 c3                	sub    %eax,%ebx
80101c5e:	39 cb                	cmp    %ecx,%ebx
80101c60:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c63:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c67:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101c69:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c6d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101c71:	89 04 24             	mov    %eax,(%esp)
80101c74:	e8 27 28 00 00       	call   801044a0 <memmove>
    log_write(bp);
80101c79:	89 3c 24             	mov    %edi,(%esp)
80101c7c:	e8 8f 11 00 00       	call   80102e10 <log_write>
    brelse(bp);
80101c81:	89 3c 24             	mov    %edi,(%esp)
80101c84:	e8 57 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c89:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c8f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c92:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c95:	77 91                	ja     80101c28 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101c97:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c9a:	39 70 58             	cmp    %esi,0x58(%eax)
80101c9d:	72 39                	jb     80101cd8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ca2:	83 c4 2c             	add    $0x2c,%esp
80101ca5:	5b                   	pop    %ebx
80101ca6:	5e                   	pop    %esi
80101ca7:	5f                   	pop    %edi
80101ca8:	5d                   	pop    %ebp
80101ca9:	c3                   	ret    
80101caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cb0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cb4:	66 83 f8 09          	cmp    $0x9,%ax
80101cb8:	77 2e                	ja     80101ce8 <writei+0x118>
80101cba:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101cc1:	85 c0                	test   %eax,%eax
80101cc3:	74 23                	je     80101ce8 <writei+0x118>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101cc5:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101cc8:	83 c4 2c             	add    $0x2c,%esp
80101ccb:	5b                   	pop    %ebx
80101ccc:	5e                   	pop    %esi
80101ccd:	5f                   	pop    %edi
80101cce:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101ccf:	ff e0                	jmp    *%eax
80101cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101cd8:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cdb:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101cde:	89 04 24             	mov    %eax,(%esp)
80101ce1:	e8 7a fa ff ff       	call   80101760 <iupdate>
80101ce6:	eb b7                	jmp    80101c9f <writei+0xcf>
  }
  return n;
}
80101ce8:	83 c4 2c             	add    $0x2c,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101ceb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101cf0:	5b                   	pop    %ebx
80101cf1:	5e                   	pop    %esi
80101cf2:	5f                   	pop    %edi
80101cf3:	5d                   	pop    %ebp
80101cf4:	c3                   	ret    
80101cf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d00 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101d06:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d09:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d10:	00 
80101d11:	89 44 24 04          	mov    %eax,0x4(%esp)
80101d15:	8b 45 08             	mov    0x8(%ebp),%eax
80101d18:	89 04 24             	mov    %eax,(%esp)
80101d1b:	e8 00 28 00 00       	call   80104520 <strncmp>
}
80101d20:	c9                   	leave  
80101d21:	c3                   	ret    
80101d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d30 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	57                   	push   %edi
80101d34:	56                   	push   %esi
80101d35:	53                   	push   %ebx
80101d36:	83 ec 2c             	sub    $0x2c,%esp
80101d39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d3c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d41:	0f 85 97 00 00 00    	jne    80101dde <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d47:	8b 53 58             	mov    0x58(%ebx),%edx
80101d4a:	31 ff                	xor    %edi,%edi
80101d4c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d4f:	85 d2                	test   %edx,%edx
80101d51:	75 0d                	jne    80101d60 <dirlookup+0x30>
80101d53:	eb 73                	jmp    80101dc8 <dirlookup+0x98>
80101d55:	8d 76 00             	lea    0x0(%esi),%esi
80101d58:	83 c7 10             	add    $0x10,%edi
80101d5b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101d5e:	76 68                	jbe    80101dc8 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d60:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101d67:	00 
80101d68:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101d6c:	89 74 24 04          	mov    %esi,0x4(%esp)
80101d70:	89 1c 24             	mov    %ebx,(%esp)
80101d73:	e8 58 fd ff ff       	call   80101ad0 <readi>
80101d78:	83 f8 10             	cmp    $0x10,%eax
80101d7b:	75 55                	jne    80101dd2 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101d7d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d82:	74 d4                	je     80101d58 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101d84:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d87:	89 44 24 04          	mov    %eax,0x4(%esp)
80101d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d8e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d95:	00 
80101d96:	89 04 24             	mov    %eax,(%esp)
80101d99:	e8 82 27 00 00       	call   80104520 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101d9e:	85 c0                	test   %eax,%eax
80101da0:	75 b6                	jne    80101d58 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101da2:	8b 45 10             	mov    0x10(%ebp),%eax
80101da5:	85 c0                	test   %eax,%eax
80101da7:	74 05                	je     80101dae <dirlookup+0x7e>
        *poff = off;
80101da9:	8b 45 10             	mov    0x10(%ebp),%eax
80101dac:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101dae:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101db2:	8b 03                	mov    (%ebx),%eax
80101db4:	e8 c7 f5 ff ff       	call   80101380 <iget>
    }
  }

  return 0;
}
80101db9:	83 c4 2c             	add    $0x2c,%esp
80101dbc:	5b                   	pop    %ebx
80101dbd:	5e                   	pop    %esi
80101dbe:	5f                   	pop    %edi
80101dbf:	5d                   	pop    %ebp
80101dc0:	c3                   	ret    
80101dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dc8:	83 c4 2c             	add    $0x2c,%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101dcb:	31 c0                	xor    %eax,%eax
}
80101dcd:	5b                   	pop    %ebx
80101dce:	5e                   	pop    %esi
80101dcf:	5f                   	pop    %edi
80101dd0:	5d                   	pop    %ebp
80101dd1:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101dd2:	c7 04 24 99 6e 10 80 	movl   $0x80106e99,(%esp)
80101dd9:	e8 82 e5 ff ff       	call   80100360 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101dde:	c7 04 24 87 6e 10 80 	movl   $0x80106e87,(%esp)
80101de5:	e8 76 e5 ff ff       	call   80100360 <panic>
80101dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101df0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	89 cf                	mov    %ecx,%edi
80101df6:	56                   	push   %esi
80101df7:	53                   	push   %ebx
80101df8:	89 c3                	mov    %eax,%ebx
80101dfa:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dfd:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e00:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101e03:	0f 84 51 01 00 00    	je     80101f5a <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e09:	e8 f2 19 00 00       	call   80103800 <myproc>
80101e0e:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101e11:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101e18:	e8 23 25 00 00       	call   80104340 <acquire>
  ip->ref++;
80101e1d:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e21:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101e28:	e8 83 25 00 00       	call   801043b0 <release>
80101e2d:	eb 04                	jmp    80101e33 <namex+0x43>
80101e2f:	90                   	nop
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101e30:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101e33:	0f b6 03             	movzbl (%ebx),%eax
80101e36:	3c 2f                	cmp    $0x2f,%al
80101e38:	74 f6                	je     80101e30 <namex+0x40>
    path++;
  if(*path == 0)
80101e3a:	84 c0                	test   %al,%al
80101e3c:	0f 84 ed 00 00 00    	je     80101f2f <namex+0x13f>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e42:	0f b6 03             	movzbl (%ebx),%eax
80101e45:	89 da                	mov    %ebx,%edx
80101e47:	84 c0                	test   %al,%al
80101e49:	0f 84 b1 00 00 00    	je     80101f00 <namex+0x110>
80101e4f:	3c 2f                	cmp    $0x2f,%al
80101e51:	75 0f                	jne    80101e62 <namex+0x72>
80101e53:	e9 a8 00 00 00       	jmp    80101f00 <namex+0x110>
80101e58:	3c 2f                	cmp    $0x2f,%al
80101e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101e60:	74 0a                	je     80101e6c <namex+0x7c>
    path++;
80101e62:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e65:	0f b6 02             	movzbl (%edx),%eax
80101e68:	84 c0                	test   %al,%al
80101e6a:	75 ec                	jne    80101e58 <namex+0x68>
80101e6c:	89 d1                	mov    %edx,%ecx
80101e6e:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101e70:	83 f9 0d             	cmp    $0xd,%ecx
80101e73:	0f 8e 8f 00 00 00    	jle    80101f08 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101e79:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e7d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101e84:	00 
80101e85:	89 3c 24             	mov    %edi,(%esp)
80101e88:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e8b:	e8 10 26 00 00       	call   801044a0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101e90:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e93:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e95:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e98:	75 0e                	jne    80101ea8 <namex+0xb8>
80101e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101ea0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ea3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101ea6:	74 f8                	je     80101ea0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ea8:	89 34 24             	mov    %esi,(%esp)
80101eab:	e8 70 f9 ff ff       	call   80101820 <ilock>
    if(ip->type != T_DIR){
80101eb0:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101eb5:	0f 85 85 00 00 00    	jne    80101f40 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101ebb:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ebe:	85 d2                	test   %edx,%edx
80101ec0:	74 09                	je     80101ecb <namex+0xdb>
80101ec2:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ec5:	0f 84 a5 00 00 00    	je     80101f70 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101ecb:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101ed2:	00 
80101ed3:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101ed7:	89 34 24             	mov    %esi,(%esp)
80101eda:	e8 51 fe ff ff       	call   80101d30 <dirlookup>
80101edf:	85 c0                	test   %eax,%eax
80101ee1:	74 5d                	je     80101f40 <namex+0x150>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101ee3:	89 34 24             	mov    %esi,(%esp)
80101ee6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101ee9:	e8 12 fa ff ff       	call   80101900 <iunlock>
  iput(ip);
80101eee:	89 34 24             	mov    %esi,(%esp)
80101ef1:	e8 4a fa ff ff       	call   80101940 <iput>
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101ef6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ef9:	89 c6                	mov    %eax,%esi
80101efb:	e9 33 ff ff ff       	jmp    80101e33 <namex+0x43>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101f00:	31 c9                	xor    %ecx,%ecx
80101f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101f08:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101f0c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101f10:	89 3c 24             	mov    %edi,(%esp)
80101f13:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f16:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101f19:	e8 82 25 00 00       	call   801044a0 <memmove>
    name[len] = 0;
80101f1e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f21:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f24:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101f28:	89 d3                	mov    %edx,%ebx
80101f2a:	e9 66 ff ff ff       	jmp    80101e95 <namex+0xa5>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f32:	85 c0                	test   %eax,%eax
80101f34:	75 4c                	jne    80101f82 <namex+0x192>
80101f36:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101f38:	83 c4 2c             	add    $0x2c,%esp
80101f3b:	5b                   	pop    %ebx
80101f3c:	5e                   	pop    %esi
80101f3d:	5f                   	pop    %edi
80101f3e:	5d                   	pop    %ebp
80101f3f:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101f40:	89 34 24             	mov    %esi,(%esp)
80101f43:	e8 b8 f9 ff ff       	call   80101900 <iunlock>
  iput(ip);
80101f48:	89 34 24             	mov    %esi,(%esp)
80101f4b:	e8 f0 f9 ff ff       	call   80101940 <iput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f50:	83 c4 2c             	add    $0x2c,%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101f53:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f55:	5b                   	pop    %ebx
80101f56:	5e                   	pop    %esi
80101f57:	5f                   	pop    %edi
80101f58:	5d                   	pop    %ebp
80101f59:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101f5a:	ba 01 00 00 00       	mov    $0x1,%edx
80101f5f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f64:	e8 17 f4 ff ff       	call   80101380 <iget>
80101f69:	89 c6                	mov    %eax,%esi
80101f6b:	e9 c3 fe ff ff       	jmp    80101e33 <namex+0x43>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101f70:	89 34 24             	mov    %esi,(%esp)
80101f73:	e8 88 f9 ff ff       	call   80101900 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f78:	83 c4 2c             	add    $0x2c,%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101f7b:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f7d:	5b                   	pop    %ebx
80101f7e:	5e                   	pop    %esi
80101f7f:	5f                   	pop    %edi
80101f80:	5d                   	pop    %ebp
80101f81:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101f82:	89 34 24             	mov    %esi,(%esp)
80101f85:	e8 b6 f9 ff ff       	call   80101940 <iput>
    return 0;
80101f8a:	31 c0                	xor    %eax,%eax
80101f8c:	eb aa                	jmp    80101f38 <namex+0x148>
80101f8e:	66 90                	xchg   %ax,%ax

80101f90 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101f90:	55                   	push   %ebp
80101f91:	89 e5                	mov    %esp,%ebp
80101f93:	57                   	push   %edi
80101f94:	56                   	push   %esi
80101f95:	53                   	push   %ebx
80101f96:	83 ec 2c             	sub    $0x2c,%esp
80101f99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f9f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101fa6:	00 
80101fa7:	89 1c 24             	mov    %ebx,(%esp)
80101faa:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fae:	e8 7d fd ff ff       	call   80101d30 <dirlookup>
80101fb3:	85 c0                	test   %eax,%eax
80101fb5:	0f 85 8b 00 00 00    	jne    80102046 <dirlink+0xb6>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fbb:	8b 43 58             	mov    0x58(%ebx),%eax
80101fbe:	31 ff                	xor    %edi,%edi
80101fc0:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fc3:	85 c0                	test   %eax,%eax
80101fc5:	75 13                	jne    80101fda <dirlink+0x4a>
80101fc7:	eb 35                	jmp    80101ffe <dirlink+0x6e>
80101fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fd0:	8d 57 10             	lea    0x10(%edi),%edx
80101fd3:	39 53 58             	cmp    %edx,0x58(%ebx)
80101fd6:	89 d7                	mov    %edx,%edi
80101fd8:	76 24                	jbe    80101ffe <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fda:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101fe1:	00 
80101fe2:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101fe6:	89 74 24 04          	mov    %esi,0x4(%esp)
80101fea:	89 1c 24             	mov    %ebx,(%esp)
80101fed:	e8 de fa ff ff       	call   80101ad0 <readi>
80101ff2:	83 f8 10             	cmp    $0x10,%eax
80101ff5:	75 5e                	jne    80102055 <dirlink+0xc5>
      panic("dirlink read");
    if(de.inum == 0)
80101ff7:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ffc:	75 d2                	jne    80101fd0 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
80102001:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102008:	00 
80102009:	89 44 24 04          	mov    %eax,0x4(%esp)
8010200d:	8d 45 da             	lea    -0x26(%ebp),%eax
80102010:	89 04 24             	mov    %eax,(%esp)
80102013:	e8 78 25 00 00       	call   80104590 <strncpy>
  de.inum = inum;
80102018:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010201b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102022:	00 
80102023:	89 7c 24 08          	mov    %edi,0x8(%esp)
80102027:	89 74 24 04          	mov    %esi,0x4(%esp)
8010202b:	89 1c 24             	mov    %ebx,(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
8010202e:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102032:	e8 99 fb ff ff       	call   80101bd0 <writei>
80102037:	83 f8 10             	cmp    $0x10,%eax
8010203a:	75 25                	jne    80102061 <dirlink+0xd1>
    panic("dirlink");

  return 0;
8010203c:	31 c0                	xor    %eax,%eax
}
8010203e:	83 c4 2c             	add    $0x2c,%esp
80102041:	5b                   	pop    %ebx
80102042:	5e                   	pop    %esi
80102043:	5f                   	pop    %edi
80102044:	5d                   	pop    %ebp
80102045:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102046:	89 04 24             	mov    %eax,(%esp)
80102049:	e8 f2 f8 ff ff       	call   80101940 <iput>
    return -1;
8010204e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102053:	eb e9                	jmp    8010203e <dirlink+0xae>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102055:	c7 04 24 a8 6e 10 80 	movl   $0x80106ea8,(%esp)
8010205c:	e8 ff e2 ff ff       	call   80100360 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102061:	c7 04 24 9e 74 10 80 	movl   $0x8010749e,(%esp)
80102068:	e8 f3 e2 ff ff       	call   80100360 <panic>
8010206d:	8d 76 00             	lea    0x0(%esi),%esi

80102070 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80102070:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102071:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80102073:	89 e5                	mov    %esp,%ebp
80102075:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102078:	8b 45 08             	mov    0x8(%ebp),%eax
8010207b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010207e:	e8 6d fd ff ff       	call   80101df0 <namex>
}
80102083:	c9                   	leave  
80102084:	c3                   	ret    
80102085:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102090 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102090:	55                   	push   %ebp
  return namex(path, 1, name);
80102091:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102096:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102098:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010209b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010209e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
8010209f:	e9 4c fd ff ff       	jmp    80101df0 <namex>
801020a4:	66 90                	xchg   %ax,%ax
801020a6:	66 90                	xchg   %ax,%ax
801020a8:	66 90                	xchg   %ax,%ax
801020aa:	66 90                	xchg   %ax,%ax
801020ac:	66 90                	xchg   %ax,%ax
801020ae:	66 90                	xchg   %ax,%ax

801020b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	56                   	push   %esi
801020b4:	89 c6                	mov    %eax,%esi
801020b6:	83 ec 14             	sub    $0x14,%esp
  if(b == 0)
801020b9:	85 c0                	test   %eax,%eax
801020bb:	0f 84 99 00 00 00    	je     8010215a <idestart+0xaa>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020c1:	8b 48 08             	mov    0x8(%eax),%ecx
801020c4:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
801020ca:	0f 87 7e 00 00 00    	ja     8010214e <idestart+0x9e>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020d5:	8d 76 00             	lea    0x0(%esi),%esi
801020d8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020d9:	83 e0 c0             	and    $0xffffffc0,%eax
801020dc:	3c 40                	cmp    $0x40,%al
801020de:	75 f8                	jne    801020d8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020e0:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020e5:	31 c0                	xor    %eax,%eax
801020e7:	ee                   	out    %al,(%dx)
801020e8:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020ed:	b8 01 00 00 00       	mov    $0x1,%eax
801020f2:	ee                   	out    %al,(%dx)
801020f3:	0f b6 c1             	movzbl %cl,%eax
801020f6:	b2 f3                	mov    $0xf3,%dl
801020f8:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801020f9:	89 c8                	mov    %ecx,%eax
801020fb:	b2 f4                	mov    $0xf4,%dl
801020fd:	c1 f8 08             	sar    $0x8,%eax
80102100:	ee                   	out    %al,(%dx)
80102101:	31 c0                	xor    %eax,%eax
80102103:	b2 f5                	mov    $0xf5,%dl
80102105:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102106:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010210a:	b2 f6                	mov    $0xf6,%dl
8010210c:	83 e0 01             	and    $0x1,%eax
8010210f:	c1 e0 04             	shl    $0x4,%eax
80102112:	83 c8 e0             	or     $0xffffffe0,%eax
80102115:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102116:	f6 06 04             	testb  $0x4,(%esi)
80102119:	75 15                	jne    80102130 <idestart+0x80>
8010211b:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102120:	b8 20 00 00 00       	mov    $0x20,%eax
80102125:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102126:	83 c4 14             	add    $0x14,%esp
80102129:	5e                   	pop    %esi
8010212a:	5d                   	pop    %ebp
8010212b:	c3                   	ret    
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102130:	b2 f7                	mov    $0xf7,%dl
80102132:	b8 30 00 00 00       	mov    $0x30,%eax
80102137:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102138:	b9 80 00 00 00       	mov    $0x80,%ecx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
8010213d:	83 c6 5c             	add    $0x5c,%esi
80102140:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102145:	fc                   	cld    
80102146:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102148:	83 c4 14             	add    $0x14,%esp
8010214b:	5e                   	pop    %esi
8010214c:	5d                   	pop    %ebp
8010214d:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010214e:	c7 04 24 14 6f 10 80 	movl   $0x80106f14,(%esp)
80102155:	e8 06 e2 ff ff       	call   80100360 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010215a:	c7 04 24 0b 6f 10 80 	movl   $0x80106f0b,(%esp)
80102161:	e8 fa e1 ff ff       	call   80100360 <panic>
80102166:	8d 76 00             	lea    0x0(%esi),%esi
80102169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102170 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102176:	c7 44 24 04 26 6f 10 	movl   $0x80106f26,0x4(%esp)
8010217d:	80 
8010217e:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
80102185:	e8 46 20 00 00       	call   801041d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010218a:	a1 20 2d 11 80       	mov    0x80112d20,%eax
8010218f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102196:	83 e8 01             	sub    $0x1,%eax
80102199:	89 44 24 04          	mov    %eax,0x4(%esp)
8010219d:	e8 7e 02 00 00       	call   80102420 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021a2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021a7:	90                   	nop
801021a8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a9:	83 e0 c0             	and    $0xffffffc0,%eax
801021ac:	3c 40                	cmp    $0x40,%al
801021ae:	75 f8                	jne    801021a8 <ideinit+0x38>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021b0:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021b5:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021ba:	ee                   	out    %al,(%dx)
801021bb:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021c0:	b2 f7                	mov    $0xf7,%dl
801021c2:	eb 09                	jmp    801021cd <ideinit+0x5d>
801021c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801021c8:	83 e9 01             	sub    $0x1,%ecx
801021cb:	74 0f                	je     801021dc <ideinit+0x6c>
801021cd:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021ce:	84 c0                	test   %al,%al
801021d0:	74 f6                	je     801021c8 <ideinit+0x58>
      havedisk1 = 1;
801021d2:	c7 05 80 a5 10 80 01 	movl   $0x1,0x8010a580
801021d9:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021dc:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021e1:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021e6:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
801021e7:	c9                   	leave  
801021e8:	c3                   	ret    
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021f0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	57                   	push   %edi
801021f4:	56                   	push   %esi
801021f5:	53                   	push   %ebx
801021f6:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801021f9:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
80102200:	e8 3b 21 00 00       	call   80104340 <acquire>

  if((b = idequeue) == 0){
80102205:	8b 1d 84 a5 10 80    	mov    0x8010a584,%ebx
8010220b:	85 db                	test   %ebx,%ebx
8010220d:	74 30                	je     8010223f <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010220f:	8b 43 58             	mov    0x58(%ebx),%eax
80102212:	a3 84 a5 10 80       	mov    %eax,0x8010a584

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102217:	8b 33                	mov    (%ebx),%esi
80102219:	f7 c6 04 00 00 00    	test   $0x4,%esi
8010221f:	74 37                	je     80102258 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102221:	83 e6 fb             	and    $0xfffffffb,%esi
80102224:	83 ce 02             	or     $0x2,%esi
80102227:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102229:	89 1c 24             	mov    %ebx,(%esp)
8010222c:	e8 bf 1c 00 00       	call   80103ef0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102231:	a1 84 a5 10 80       	mov    0x8010a584,%eax
80102236:	85 c0                	test   %eax,%eax
80102238:	74 05                	je     8010223f <ideintr+0x4f>
    idestart(idequeue);
8010223a:	e8 71 fe ff ff       	call   801020b0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
8010223f:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
80102246:	e8 65 21 00 00       	call   801043b0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
8010224b:	83 c4 1c             	add    $0x1c,%esp
8010224e:	5b                   	pop    %ebx
8010224f:	5e                   	pop    %esi
80102250:	5f                   	pop    %edi
80102251:	5d                   	pop    %ebp
80102252:	c3                   	ret    
80102253:	90                   	nop
80102254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102258:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010225d:	8d 76 00             	lea    0x0(%esi),%esi
80102260:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102261:	89 c1                	mov    %eax,%ecx
80102263:	83 e1 c0             	and    $0xffffffc0,%ecx
80102266:	80 f9 40             	cmp    $0x40,%cl
80102269:	75 f5                	jne    80102260 <ideintr+0x70>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010226b:	a8 21                	test   $0x21,%al
8010226d:	75 b2                	jne    80102221 <ideintr+0x31>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
8010226f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80102272:	b9 80 00 00 00       	mov    $0x80,%ecx
80102277:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010227c:	fc                   	cld    
8010227d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010227f:	8b 33                	mov    (%ebx),%esi
80102281:	eb 9e                	jmp    80102221 <ideintr+0x31>
80102283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102290 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	53                   	push   %ebx
80102294:	83 ec 14             	sub    $0x14,%esp
80102297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010229a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010229d:	89 04 24             	mov    %eax,(%esp)
801022a0:	e8 db 1e 00 00       	call   80104180 <holdingsleep>
801022a5:	85 c0                	test   %eax,%eax
801022a7:	0f 84 9e 00 00 00    	je     8010234b <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022ad:	8b 03                	mov    (%ebx),%eax
801022af:	83 e0 06             	and    $0x6,%eax
801022b2:	83 f8 02             	cmp    $0x2,%eax
801022b5:	0f 84 a8 00 00 00    	je     80102363 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022bb:	8b 53 04             	mov    0x4(%ebx),%edx
801022be:	85 d2                	test   %edx,%edx
801022c0:	74 0d                	je     801022cf <iderw+0x3f>
801022c2:	a1 80 a5 10 80       	mov    0x8010a580,%eax
801022c7:	85 c0                	test   %eax,%eax
801022c9:	0f 84 88 00 00 00    	je     80102357 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022cf:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
801022d6:	e8 65 20 00 00       	call   80104340 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022db:	a1 84 a5 10 80       	mov    0x8010a584,%eax
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
801022e0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022e7:	85 c0                	test   %eax,%eax
801022e9:	75 07                	jne    801022f2 <iderw+0x62>
801022eb:	eb 4e                	jmp    8010233b <iderw+0xab>
801022ed:	8d 76 00             	lea    0x0(%esi),%esi
801022f0:	89 d0                	mov    %edx,%eax
801022f2:	8b 50 58             	mov    0x58(%eax),%edx
801022f5:	85 d2                	test   %edx,%edx
801022f7:	75 f7                	jne    801022f0 <iderw+0x60>
801022f9:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
801022fc:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
801022fe:	39 1d 84 a5 10 80    	cmp    %ebx,0x8010a584
80102304:	74 3c                	je     80102342 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102306:	8b 03                	mov    (%ebx),%eax
80102308:	83 e0 06             	and    $0x6,%eax
8010230b:	83 f8 02             	cmp    $0x2,%eax
8010230e:	74 1a                	je     8010232a <iderw+0x9a>
    sleep(b, &idelock);
80102310:	c7 44 24 04 a0 a5 10 	movl   $0x8010a5a0,0x4(%esp)
80102317:	80 
80102318:	89 1c 24             	mov    %ebx,(%esp)
8010231b:	e8 40 1a 00 00       	call   80103d60 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102320:	8b 13                	mov    (%ebx),%edx
80102322:	83 e2 06             	and    $0x6,%edx
80102325:	83 fa 02             	cmp    $0x2,%edx
80102328:	75 e6                	jne    80102310 <iderw+0x80>
    sleep(b, &idelock);
  }


  release(&idelock);
8010232a:	c7 45 08 a0 a5 10 80 	movl   $0x8010a5a0,0x8(%ebp)
}
80102331:	83 c4 14             	add    $0x14,%esp
80102334:	5b                   	pop    %ebx
80102335:	5d                   	pop    %ebp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102336:	e9 75 20 00 00       	jmp    801043b0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010233b:	b8 84 a5 10 80       	mov    $0x8010a584,%eax
80102340:	eb ba                	jmp    801022fc <iderw+0x6c>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102342:	89 d8                	mov    %ebx,%eax
80102344:	e8 67 fd ff ff       	call   801020b0 <idestart>
80102349:	eb bb                	jmp    80102306 <iderw+0x76>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010234b:	c7 04 24 2a 6f 10 80 	movl   $0x80106f2a,(%esp)
80102352:	e8 09 e0 ff ff       	call   80100360 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102357:	c7 04 24 55 6f 10 80 	movl   $0x80106f55,(%esp)
8010235e:	e8 fd df ff ff       	call   80100360 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102363:	c7 04 24 40 6f 10 80 	movl   $0x80106f40,(%esp)
8010236a:	e8 f1 df ff ff       	call   80100360 <panic>
8010236f:	90                   	nop

80102370 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	56                   	push   %esi
80102374:	53                   	push   %ebx
80102375:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102378:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
8010237f:	00 c0 fe 
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102382:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102389:	00 00 00 
  return ioapic->data;
8010238c:	8b 15 54 26 11 80    	mov    0x80112654,%edx
80102392:	8b 42 10             	mov    0x10(%edx),%eax
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102395:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010239b:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023a1:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023a8:	c1 e8 10             	shr    $0x10,%eax
801023ab:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
801023ae:	8b 43 10             	mov    0x10(%ebx),%eax
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
801023b1:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023b4:	39 c2                	cmp    %eax,%edx
801023b6:	74 12                	je     801023ca <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023b8:	c7 04 24 74 6f 10 80 	movl   $0x80106f74,(%esp)
801023bf:	e8 5c e3 ff ff       	call   80100720 <cprintf>
801023c4:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
801023ca:	ba 10 00 00 00       	mov    $0x10,%edx
801023cf:	31 c0                	xor    %eax,%eax
801023d1:	eb 07                	jmp    801023da <ioapicinit+0x6a>
801023d3:	90                   	nop
801023d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023d8:	89 cb                	mov    %ecx,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023da:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
801023dc:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
801023e2:	8d 48 20             	lea    0x20(%eax),%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801023e5:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801023eb:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801023ee:	89 4b 10             	mov    %ecx,0x10(%ebx)
801023f1:	8d 4a 01             	lea    0x1(%edx),%ecx
801023f4:	83 c2 02             	add    $0x2,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023f7:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801023f9:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801023ff:	39 c6                	cmp    %eax,%esi

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102401:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102408:	7d ce                	jge    801023d8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010240a:	83 c4 10             	add    $0x10,%esp
8010240d:	5b                   	pop    %ebx
8010240e:	5e                   	pop    %esi
8010240f:	5d                   	pop    %ebp
80102410:	c3                   	ret    
80102411:	eb 0d                	jmp    80102420 <ioapicenable>
80102413:	90                   	nop
80102414:	90                   	nop
80102415:	90                   	nop
80102416:	90                   	nop
80102417:	90                   	nop
80102418:	90                   	nop
80102419:	90                   	nop
8010241a:	90                   	nop
8010241b:	90                   	nop
8010241c:	90                   	nop
8010241d:	90                   	nop
8010241e:	90                   	nop
8010241f:	90                   	nop

80102420 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	8b 55 08             	mov    0x8(%ebp),%edx
80102426:	53                   	push   %ebx
80102427:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010242a:	8d 5a 20             	lea    0x20(%edx),%ebx
8010242d:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102431:	8b 15 54 26 11 80    	mov    0x80112654,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102437:	c1 e0 18             	shl    $0x18,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010243a:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
8010243c:	8b 15 54 26 11 80    	mov    0x80112654,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102442:	83 c1 01             	add    $0x1,%ecx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102445:	89 5a 10             	mov    %ebx,0x10(%edx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102448:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
8010244a:	8b 15 54 26 11 80    	mov    0x80112654,%edx
80102450:	89 42 10             	mov    %eax,0x10(%edx)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102453:	5b                   	pop    %ebx
80102454:	5d                   	pop    %ebp
80102455:	c3                   	ret    
80102456:	66 90                	xchg   %ax,%ax
80102458:	66 90                	xchg   %ax,%ax
8010245a:	66 90                	xchg   %ax,%ax
8010245c:	66 90                	xchg   %ax,%ax
8010245e:	66 90                	xchg   %ax,%ax

80102460 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	53                   	push   %ebx
80102464:	83 ec 14             	sub    $0x14,%esp
80102467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010246a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102470:	75 7c                	jne    801024ee <kfree+0x8e>
80102472:	81 fb c8 54 11 80    	cmp    $0x801154c8,%ebx
80102478:	72 74                	jb     801024ee <kfree+0x8e>
8010247a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102480:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102485:	77 67                	ja     801024ee <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102487:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010248e:	00 
8010248f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102496:	00 
80102497:	89 1c 24             	mov    %ebx,(%esp)
8010249a:	e8 61 1f 00 00       	call   80104400 <memset>

  if(kmem.use_lock)
8010249f:	8b 15 94 26 11 80    	mov    0x80112694,%edx
801024a5:	85 d2                	test   %edx,%edx
801024a7:	75 37                	jne    801024e0 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024a9:	a1 98 26 11 80       	mov    0x80112698,%eax
801024ae:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024b0:	a1 94 26 11 80       	mov    0x80112694,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
801024b5:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
801024bb:	85 c0                	test   %eax,%eax
801024bd:	75 09                	jne    801024c8 <kfree+0x68>
    release(&kmem.lock);
}
801024bf:	83 c4 14             	add    $0x14,%esp
801024c2:	5b                   	pop    %ebx
801024c3:	5d                   	pop    %ebp
801024c4:	c3                   	ret    
801024c5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801024c8:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
801024cf:	83 c4 14             	add    $0x14,%esp
801024d2:	5b                   	pop    %ebx
801024d3:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801024d4:	e9 d7 1e 00 00       	jmp    801043b0 <release>
801024d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024e0:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801024e7:	e8 54 1e 00 00       	call   80104340 <acquire>
801024ec:	eb bb                	jmp    801024a9 <kfree+0x49>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801024ee:	c7 04 24 a6 6f 10 80 	movl   $0x80106fa6,(%esp)
801024f5:	e8 66 de ff ff       	call   80100360 <panic>
801024fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102500 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102500:	55                   	push   %ebp
80102501:	89 e5                	mov    %esp,%ebp
80102503:	56                   	push   %esi
80102504:	53                   	push   %ebx
80102505:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102508:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
8010250b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010250e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102514:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010251a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102520:	39 de                	cmp    %ebx,%esi
80102522:	73 08                	jae    8010252c <freerange+0x2c>
80102524:	eb 18                	jmp    8010253e <freerange+0x3e>
80102526:	66 90                	xchg   %ax,%ax
80102528:	89 da                	mov    %ebx,%edx
8010252a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010252c:	89 14 24             	mov    %edx,(%esp)
8010252f:	e8 2c ff ff ff       	call   80102460 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102534:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010253a:	39 f0                	cmp    %esi,%eax
8010253c:	76 ea                	jbe    80102528 <freerange+0x28>
    kfree(p);
}
8010253e:	83 c4 10             	add    $0x10,%esp
80102541:	5b                   	pop    %ebx
80102542:	5e                   	pop    %esi
80102543:	5d                   	pop    %ebp
80102544:	c3                   	ret    
80102545:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102550 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	56                   	push   %esi
80102554:	53                   	push   %ebx
80102555:	83 ec 10             	sub    $0x10,%esp
80102558:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010255b:	c7 44 24 04 ac 6f 10 	movl   $0x80106fac,0x4(%esp)
80102562:	80 
80102563:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
8010256a:	e8 61 1c 00 00       	call   801041d0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010256f:	8b 45 08             	mov    0x8(%ebp),%eax
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102572:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102579:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010257c:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102582:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102588:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010258e:	39 de                	cmp    %ebx,%esi
80102590:	73 0a                	jae    8010259c <kinit1+0x4c>
80102592:	eb 1a                	jmp    801025ae <kinit1+0x5e>
80102594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102598:	89 da                	mov    %ebx,%edx
8010259a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010259c:	89 14 24             	mov    %edx,(%esp)
8010259f:	e8 bc fe ff ff       	call   80102460 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025a4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801025aa:	39 c6                	cmp    %eax,%esi
801025ac:	73 ea                	jae    80102598 <kinit1+0x48>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801025ae:	83 c4 10             	add    $0x10,%esp
801025b1:	5b                   	pop    %ebx
801025b2:	5e                   	pop    %esi
801025b3:	5d                   	pop    %ebp
801025b4:	c3                   	ret    
801025b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025c0 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	56                   	push   %esi
801025c4:	53                   	push   %ebx
801025c5:	83 ec 10             	sub    $0x10,%esp

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025c8:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801025cb:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801025ce:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801025d4:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025da:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801025e0:	39 de                	cmp    %ebx,%esi
801025e2:	73 08                	jae    801025ec <kinit2+0x2c>
801025e4:	eb 18                	jmp    801025fe <kinit2+0x3e>
801025e6:	66 90                	xchg   %ax,%ax
801025e8:	89 da                	mov    %ebx,%edx
801025ea:	89 c3                	mov    %eax,%ebx
    kfree(p);
801025ec:	89 14 24             	mov    %edx,(%esp)
801025ef:	e8 6c fe ff ff       	call   80102460 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025f4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801025fa:	39 c6                	cmp    %eax,%esi
801025fc:	73 ea                	jae    801025e8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801025fe:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
80102605:	00 00 00 
}
80102608:	83 c4 10             	add    $0x10,%esp
8010260b:	5b                   	pop    %ebx
8010260c:	5e                   	pop    %esi
8010260d:	5d                   	pop    %ebp
8010260e:	c3                   	ret    
8010260f:	90                   	nop

80102610 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	53                   	push   %ebx
80102614:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
80102617:	a1 94 26 11 80       	mov    0x80112694,%eax
8010261c:	85 c0                	test   %eax,%eax
8010261e:	75 30                	jne    80102650 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102620:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102626:	85 db                	test   %ebx,%ebx
80102628:	74 08                	je     80102632 <kalloc+0x22>
    kmem.freelist = r->next;
8010262a:	8b 13                	mov    (%ebx),%edx
8010262c:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
80102632:	85 c0                	test   %eax,%eax
80102634:	74 0c                	je     80102642 <kalloc+0x32>
    release(&kmem.lock);
80102636:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
8010263d:	e8 6e 1d 00 00       	call   801043b0 <release>
  return (char*)r;
}
80102642:	83 c4 14             	add    $0x14,%esp
80102645:	89 d8                	mov    %ebx,%eax
80102647:	5b                   	pop    %ebx
80102648:	5d                   	pop    %ebp
80102649:	c3                   	ret    
8010264a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102650:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
80102657:	e8 e4 1c 00 00       	call   80104340 <acquire>
8010265c:	a1 94 26 11 80       	mov    0x80112694,%eax
80102661:	eb bd                	jmp    80102620 <kalloc+0x10>
80102663:	66 90                	xchg   %ax,%ax
80102665:	66 90                	xchg   %ax,%ax
80102667:	66 90                	xchg   %ax,%ax
80102669:	66 90                	xchg   %ax,%ax
8010266b:	66 90                	xchg   %ax,%ax
8010266d:	66 90                	xchg   %ax,%ax
8010266f:	90                   	nop

80102670 <kbdgetc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102670:	ba 64 00 00 00       	mov    $0x64,%edx
80102675:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102676:	a8 01                	test   $0x1,%al
80102678:	0f 84 ba 00 00 00    	je     80102738 <kbdgetc+0xc8>
8010267e:	b2 60                	mov    $0x60,%dl
80102680:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102681:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102684:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010268a:	0f 84 88 00 00 00    	je     80102718 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102690:	84 c0                	test   %al,%al
80102692:	79 2c                	jns    801026c0 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102694:	8b 15 d4 a5 10 80    	mov    0x8010a5d4,%edx
8010269a:	f6 c2 40             	test   $0x40,%dl
8010269d:	75 05                	jne    801026a4 <kbdgetc+0x34>
8010269f:	89 c1                	mov    %eax,%ecx
801026a1:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801026a4:	0f b6 81 e0 70 10 80 	movzbl -0x7fef8f20(%ecx),%eax
801026ab:	83 c8 40             	or     $0x40,%eax
801026ae:	0f b6 c0             	movzbl %al,%eax
801026b1:	f7 d0                	not    %eax
801026b3:	21 d0                	and    %edx,%eax
801026b5:	a3 d4 a5 10 80       	mov    %eax,0x8010a5d4
    return 0;
801026ba:	31 c0                	xor    %eax,%eax
801026bc:	c3                   	ret    
801026bd:	8d 76 00             	lea    0x0(%esi),%esi
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	53                   	push   %ebx
801026c4:	8b 1d d4 a5 10 80    	mov    0x8010a5d4,%ebx
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026ca:	f6 c3 40             	test   $0x40,%bl
801026cd:	74 09                	je     801026d8 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026cf:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801026d2:	83 e3 bf             	and    $0xffffffbf,%ebx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026d5:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
801026d8:	0f b6 91 e0 70 10 80 	movzbl -0x7fef8f20(%ecx),%edx
  shift ^= togglecode[data];
801026df:	0f b6 81 e0 6f 10 80 	movzbl -0x7fef9020(%ecx),%eax
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
801026e6:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801026e8:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801026ea:	89 d0                	mov    %edx,%eax
801026ec:	83 e0 03             	and    $0x3,%eax
801026ef:	8b 04 85 c0 6f 10 80 	mov    -0x7fef9040(,%eax,4),%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801026f6:	89 15 d4 a5 10 80    	mov    %edx,0x8010a5d4
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
801026fc:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801026ff:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102703:	74 0b                	je     80102710 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
80102705:	8d 50 9f             	lea    -0x61(%eax),%edx
80102708:	83 fa 19             	cmp    $0x19,%edx
8010270b:	77 1b                	ja     80102728 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010270d:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102710:	5b                   	pop    %ebx
80102711:	5d                   	pop    %ebp
80102712:	c3                   	ret    
80102713:	90                   	nop
80102714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102718:	83 0d d4 a5 10 80 40 	orl    $0x40,0x8010a5d4
    return 0;
8010271f:	31 c0                	xor    %eax,%eax
80102721:	c3                   	ret    
80102722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102728:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010272b:	8d 50 20             	lea    0x20(%eax),%edx
8010272e:	83 f9 19             	cmp    $0x19,%ecx
80102731:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
80102734:	eb da                	jmp    80102710 <kbdgetc+0xa0>
80102736:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010273d:	c3                   	ret    
8010273e:	66 90                	xchg   %ax,%ax

80102740 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
80102743:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102746:	c7 04 24 70 26 10 80 	movl   $0x80102670,(%esp)
8010274d:	e8 2e e1 ff ff       	call   80100880 <consoleintr>
}
80102752:	c9                   	leave  
80102753:	c3                   	ret    
80102754:	66 90                	xchg   %ax,%ax
80102756:	66 90                	xchg   %ax,%ax
80102758:	66 90                	xchg   %ax,%ax
8010275a:	66 90                	xchg   %ax,%ax
8010275c:	66 90                	xchg   %ax,%ax
8010275e:	66 90                	xchg   %ax,%ax

80102760 <fill_rtcdate>:
  return inb(CMOS_RETURN);
}

static void
fill_rtcdate(struct rtcdate *r)
{
80102760:	55                   	push   %ebp
80102761:	89 c1                	mov    %eax,%ecx
80102763:	89 e5                	mov    %esp,%ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102765:	ba 70 00 00 00       	mov    $0x70,%edx
8010276a:	31 c0                	xor    %eax,%eax
8010276c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010276d:	b2 71                	mov    $0x71,%dl
8010276f:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
80102770:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102773:	b2 70                	mov    $0x70,%dl
80102775:	89 01                	mov    %eax,(%ecx)
80102777:	b8 02 00 00 00       	mov    $0x2,%eax
8010277c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010277d:	b2 71                	mov    $0x71,%dl
8010277f:	ec                   	in     (%dx),%al
80102780:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102783:	b2 70                	mov    $0x70,%dl
80102785:	89 41 04             	mov    %eax,0x4(%ecx)
80102788:	b8 04 00 00 00       	mov    $0x4,%eax
8010278d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010278e:	b2 71                	mov    $0x71,%dl
80102790:	ec                   	in     (%dx),%al
80102791:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102794:	b2 70                	mov    $0x70,%dl
80102796:	89 41 08             	mov    %eax,0x8(%ecx)
80102799:	b8 07 00 00 00       	mov    $0x7,%eax
8010279e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010279f:	b2 71                	mov    $0x71,%dl
801027a1:	ec                   	in     (%dx),%al
801027a2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027a5:	b2 70                	mov    $0x70,%dl
801027a7:	89 41 0c             	mov    %eax,0xc(%ecx)
801027aa:	b8 08 00 00 00       	mov    $0x8,%eax
801027af:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027b0:	b2 71                	mov    $0x71,%dl
801027b2:	ec                   	in     (%dx),%al
801027b3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b6:	b2 70                	mov    $0x70,%dl
801027b8:	89 41 10             	mov    %eax,0x10(%ecx)
801027bb:	b8 09 00 00 00       	mov    $0x9,%eax
801027c0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027c1:	b2 71                	mov    $0x71,%dl
801027c3:	ec                   	in     (%dx),%al
801027c4:	0f b6 c0             	movzbl %al,%eax
801027c7:	89 41 14             	mov    %eax,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
801027ca:	5d                   	pop    %ebp
801027cb:	c3                   	ret    
801027cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027d0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027d0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801027d5:	55                   	push   %ebp
801027d6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801027d8:	85 c0                	test   %eax,%eax
801027da:	0f 84 c0 00 00 00    	je     801028a0 <lapicinit+0xd0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027e7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ea:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ed:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027fa:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102801:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102804:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102807:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010280e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102811:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102814:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010281b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010281e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102821:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102828:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010282b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010282e:	8b 50 30             	mov    0x30(%eax),%edx
80102831:	c1 ea 10             	shr    $0x10,%edx
80102834:	80 fa 03             	cmp    $0x3,%dl
80102837:	77 6f                	ja     801028a8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102839:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102840:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102843:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102846:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010284d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102850:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102853:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010285a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010285d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102860:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102867:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010286a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010286d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102874:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102877:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010287a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102881:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102884:	8b 50 20             	mov    0x20(%eax),%edx
80102887:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102888:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010288e:	80 e6 10             	and    $0x10,%dh
80102891:	75 f5                	jne    80102888 <lapicinit+0xb8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102893:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010289a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010289d:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028a0:	5d                   	pop    %ebp
801028a1:	c3                   	ret    
801028a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028af:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028b2:	8b 50 20             	mov    0x20(%eax),%edx
801028b5:	eb 82                	jmp    80102839 <lapicinit+0x69>
801028b7:	89 f6                	mov    %esi,%esi
801028b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028c0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801028c0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801028c5:	55                   	push   %ebp
801028c6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801028c8:	85 c0                	test   %eax,%eax
801028ca:	74 0c                	je     801028d8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801028cc:	8b 40 20             	mov    0x20(%eax),%eax
}
801028cf:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
801028d0:	c1 e8 18             	shr    $0x18,%eax
}
801028d3:	c3                   	ret    
801028d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
801028d8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801028da:	5d                   	pop    %ebp
801028db:	c3                   	ret    
801028dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028e0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028e0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
801028e5:	55                   	push   %ebp
801028e6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801028e8:	85 c0                	test   %eax,%eax
801028ea:	74 0d                	je     801028f9 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ec:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028f3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028f6:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
801028f9:	5d                   	pop    %ebp
801028fa:	c3                   	ret    
801028fb:	90                   	nop
801028fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102900 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102900:	55                   	push   %ebp
80102901:	89 e5                	mov    %esp,%ebp
}
80102903:	5d                   	pop    %ebp
80102904:	c3                   	ret    
80102905:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102910 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102910:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102911:	ba 70 00 00 00       	mov    $0x70,%edx
80102916:	89 e5                	mov    %esp,%ebp
80102918:	b8 0f 00 00 00       	mov    $0xf,%eax
8010291d:	53                   	push   %ebx
8010291e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102921:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102924:	ee                   	out    %al,(%dx)
80102925:	b8 0a 00 00 00       	mov    $0xa,%eax
8010292a:	b2 71                	mov    $0x71,%dl
8010292c:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010292d:	31 c0                	xor    %eax,%eax
8010292f:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102935:	89 d8                	mov    %ebx,%eax
80102937:	c1 e8 04             	shr    $0x4,%eax
8010293a:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102940:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102945:	c1 e1 18             	shl    $0x18,%ecx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102948:	c1 eb 0c             	shr    $0xc,%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010294b:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102951:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102954:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
8010295b:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010295e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102961:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102968:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010296b:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010296e:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102974:	8b 50 20             	mov    0x20(%eax),%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102977:	89 da                	mov    %ebx,%edx
80102979:	80 ce 06             	or     $0x6,%dh

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010297c:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102982:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102985:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010298b:	8b 48 20             	mov    0x20(%eax),%ecx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010298e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102994:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102997:	5b                   	pop    %ebx
80102998:	5d                   	pop    %ebp
80102999:	c3                   	ret    
8010299a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029a0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029a0:	55                   	push   %ebp
801029a1:	ba 70 00 00 00       	mov    $0x70,%edx
801029a6:	89 e5                	mov    %esp,%ebp
801029a8:	b8 0b 00 00 00       	mov    $0xb,%eax
801029ad:	57                   	push   %edi
801029ae:	56                   	push   %esi
801029af:	53                   	push   %ebx
801029b0:	83 ec 4c             	sub    $0x4c,%esp
801029b3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029b4:	b2 71                	mov    $0x71,%dl
801029b6:	ec                   	in     (%dx),%al
801029b7:	88 45 b7             	mov    %al,-0x49(%ebp)
801029ba:	8d 5d b8             	lea    -0x48(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029bd:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
801029c1:	8d 7d d0             	lea    -0x30(%ebp),%edi
801029c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c8:	be 70 00 00 00       	mov    $0x70,%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
801029cd:	89 d8                	mov    %ebx,%eax
801029cf:	e8 8c fd ff ff       	call   80102760 <fill_rtcdate>
801029d4:	b8 0a 00 00 00       	mov    $0xa,%eax
801029d9:	89 f2                	mov    %esi,%edx
801029db:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029dc:	ba 71 00 00 00       	mov    $0x71,%edx
801029e1:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801029e2:	84 c0                	test   %al,%al
801029e4:	78 e7                	js     801029cd <cmostime+0x2d>
        continue;
    fill_rtcdate(&t2);
801029e6:	89 f8                	mov    %edi,%eax
801029e8:	e8 73 fd ff ff       	call   80102760 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029ed:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
801029f4:	00 
801029f5:	89 7c 24 04          	mov    %edi,0x4(%esp)
801029f9:	89 1c 24             	mov    %ebx,(%esp)
801029fc:	e8 4f 1a 00 00       	call   80104450 <memcmp>
80102a01:	85 c0                	test   %eax,%eax
80102a03:	75 c3                	jne    801029c8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a05:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102a09:	75 78                	jne    80102a83 <cmostime+0xe3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a0b:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a0e:	89 c2                	mov    %eax,%edx
80102a10:	83 e0 0f             	and    $0xf,%eax
80102a13:	c1 ea 04             	shr    $0x4,%edx
80102a16:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a19:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a1c:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a1f:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a22:	89 c2                	mov    %eax,%edx
80102a24:	83 e0 0f             	and    $0xf,%eax
80102a27:	c1 ea 04             	shr    $0x4,%edx
80102a2a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a2d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a30:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a33:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a36:	89 c2                	mov    %eax,%edx
80102a38:	83 e0 0f             	and    $0xf,%eax
80102a3b:	c1 ea 04             	shr    $0x4,%edx
80102a3e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a41:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a44:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a47:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a4a:	89 c2                	mov    %eax,%edx
80102a4c:	83 e0 0f             	and    $0xf,%eax
80102a4f:	c1 ea 04             	shr    $0x4,%edx
80102a52:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a55:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a58:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a5b:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a5e:	89 c2                	mov    %eax,%edx
80102a60:	83 e0 0f             	and    $0xf,%eax
80102a63:	c1 ea 04             	shr    $0x4,%edx
80102a66:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a69:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a6f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a72:	89 c2                	mov    %eax,%edx
80102a74:	83 e0 0f             	and    $0xf,%eax
80102a77:	c1 ea 04             	shr    $0x4,%edx
80102a7a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a80:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a83:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102a86:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a89:	89 01                	mov    %eax,(%ecx)
80102a8b:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a8e:	89 41 04             	mov    %eax,0x4(%ecx)
80102a91:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a94:	89 41 08             	mov    %eax,0x8(%ecx)
80102a97:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a9a:	89 41 0c             	mov    %eax,0xc(%ecx)
80102a9d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102aa0:	89 41 10             	mov    %eax,0x10(%ecx)
80102aa3:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102aa6:	89 41 14             	mov    %eax,0x14(%ecx)
  r->year += 2000;
80102aa9:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
}
80102ab0:	83 c4 4c             	add    $0x4c,%esp
80102ab3:	5b                   	pop    %ebx
80102ab4:	5e                   	pop    %esi
80102ab5:	5f                   	pop    %edi
80102ab6:	5d                   	pop    %ebp
80102ab7:	c3                   	ret    
80102ab8:	66 90                	xchg   %ax,%ax
80102aba:	66 90                	xchg   %ax,%ax
80102abc:	66 90                	xchg   %ax,%ax
80102abe:	66 90                	xchg   %ax,%ax

80102ac0 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	57                   	push   %edi
80102ac4:	56                   	push   %esi
80102ac5:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ac6:	31 db                	xor    %ebx,%ebx
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102ac8:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102acb:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102ad0:	85 c0                	test   %eax,%eax
80102ad2:	7e 78                	jle    80102b4c <install_trans+0x8c>
80102ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ad8:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102add:	01 d8                	add    %ebx,%eax
80102adf:	83 c0 01             	add    $0x1,%eax
80102ae2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ae6:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102aeb:	89 04 24             	mov    %eax,(%esp)
80102aee:	e8 dd d5 ff ff       	call   801000d0 <bread>
80102af3:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102af5:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102afc:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102aff:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b03:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102b08:	89 04 24             	mov    %eax,(%esp)
80102b0b:	e8 c0 d5 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b10:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102b17:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b18:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b1a:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b21:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b24:	89 04 24             	mov    %eax,(%esp)
80102b27:	e8 74 19 00 00       	call   801044a0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b2c:	89 34 24             	mov    %esi,(%esp)
80102b2f:	e8 6c d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b34:	89 3c 24             	mov    %edi,(%esp)
80102b37:	e8 a4 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b3c:	89 34 24             	mov    %esi,(%esp)
80102b3f:	e8 9c d6 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b44:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102b4a:	7f 8c                	jg     80102ad8 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102b4c:	83 c4 1c             	add    $0x1c,%esp
80102b4f:	5b                   	pop    %ebx
80102b50:	5e                   	pop    %esi
80102b51:	5f                   	pop    %edi
80102b52:	5d                   	pop    %ebp
80102b53:	c3                   	ret    
80102b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102b60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
80102b63:	57                   	push   %edi
80102b64:	56                   	push   %esi
80102b65:	53                   	push   %ebx
80102b66:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b69:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102b6e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b72:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102b77:	89 04 24             	mov    %eax,(%esp)
80102b7a:	e8 51 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b7f:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b85:	31 d2                	xor    %edx,%edx
80102b87:	85 db                	test   %ebx,%ebx
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b89:	89 c7                	mov    %eax,%edi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b8b:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102b8e:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102b91:	7e 17                	jle    80102baa <write_head+0x4a>
80102b93:	90                   	nop
80102b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102b98:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102b9f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ba3:	83 c2 01             	add    $0x1,%edx
80102ba6:	39 da                	cmp    %ebx,%edx
80102ba8:	75 ee                	jne    80102b98 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102baa:	89 3c 24             	mov    %edi,(%esp)
80102bad:	e8 ee d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bb2:	89 3c 24             	mov    %edi,(%esp)
80102bb5:	e8 26 d6 ff ff       	call   801001e0 <brelse>
}
80102bba:	83 c4 1c             	add    $0x1c,%esp
80102bbd:	5b                   	pop    %ebx
80102bbe:	5e                   	pop    %esi
80102bbf:	5f                   	pop    %edi
80102bc0:	5d                   	pop    %ebp
80102bc1:	c3                   	ret    
80102bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bd0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	56                   	push   %esi
80102bd4:	53                   	push   %ebx
80102bd5:	83 ec 30             	sub    $0x30,%esp
80102bd8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102bdb:	c7 44 24 04 e0 71 10 	movl   $0x801071e0,0x4(%esp)
80102be2:	80 
80102be3:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102bea:	e8 e1 15 00 00       	call   801041d0 <initlock>
  readsb(dev, &sb);
80102bef:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bf2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bf6:	89 1c 24             	mov    %ebx,(%esp)
80102bf9:	e8 02 e9 ff ff       	call   80101500 <readsb>
  log.start = sb.logstart;
80102bfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102c01:	8b 55 e8             	mov    -0x18(%ebp),%edx

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c04:	89 1c 24             	mov    %ebx,(%esp)
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102c07:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c0d:	89 44 24 04          	mov    %eax,0x4(%esp)

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c11:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c17:	a3 d4 26 11 80       	mov    %eax,0x801126d4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c1c:	e8 af d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102c21:	31 d2                	xor    %edx,%edx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102c23:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102c26:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102c29:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102c2b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102c31:	7e 17                	jle    80102c4a <initlog+0x7a>
80102c33:	90                   	nop
80102c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102c38:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102c3c:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102c43:	83 c2 01             	add    $0x1,%edx
80102c46:	39 da                	cmp    %ebx,%edx
80102c48:	75 ee                	jne    80102c38 <initlog+0x68>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102c4a:	89 04 24             	mov    %eax,(%esp)
80102c4d:	e8 8e d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c52:	e8 69 fe ff ff       	call   80102ac0 <install_trans>
  log.lh.n = 0;
80102c57:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102c5e:	00 00 00 
  write_head(); // clear the log
80102c61:	e8 fa fe ff ff       	call   80102b60 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102c66:	83 c4 30             	add    $0x30,%esp
80102c69:	5b                   	pop    %ebx
80102c6a:	5e                   	pop    %esi
80102c6b:	5d                   	pop    %ebp
80102c6c:	c3                   	ret    
80102c6d:	8d 76 00             	lea    0x0(%esi),%esi

80102c70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102c76:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102c7d:	e8 be 16 00 00       	call   80104340 <acquire>
80102c82:	eb 18                	jmp    80102c9c <begin_op+0x2c>
80102c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c88:	c7 44 24 04 a0 26 11 	movl   $0x801126a0,0x4(%esp)
80102c8f:	80 
80102c90:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102c97:	e8 c4 10 00 00       	call   80103d60 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c9c:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102ca1:	85 c0                	test   %eax,%eax
80102ca3:	75 e3                	jne    80102c88 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ca5:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102caa:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102cb0:	83 c0 01             	add    $0x1,%eax
80102cb3:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cb6:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cb9:	83 fa 1e             	cmp    $0x1e,%edx
80102cbc:	7f ca                	jg     80102c88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cbe:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102cc5:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102cca:	e8 e1 16 00 00       	call   801043b0 <release>
      break;
    }
  }
}
80102ccf:	c9                   	leave  
80102cd0:	c3                   	ret    
80102cd1:	eb 0d                	jmp    80102ce0 <end_op>
80102cd3:	90                   	nop
80102cd4:	90                   	nop
80102cd5:	90                   	nop
80102cd6:	90                   	nop
80102cd7:	90                   	nop
80102cd8:	90                   	nop
80102cd9:	90                   	nop
80102cda:	90                   	nop
80102cdb:	90                   	nop
80102cdc:	90                   	nop
80102cdd:	90                   	nop
80102cde:	90                   	nop
80102cdf:	90                   	nop

80102ce0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	57                   	push   %edi
80102ce4:	56                   	push   %esi
80102ce5:	53                   	push   %ebx
80102ce6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ce9:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102cf0:	e8 4b 16 00 00       	call   80104340 <acquire>
  log.outstanding -= 1;
80102cf5:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102cfa:	8b 15 e0 26 11 80    	mov    0x801126e0,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d00:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102d03:	85 d2                	test   %edx,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d05:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102d0a:	0f 85 f3 00 00 00    	jne    80102e03 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102d10:	85 c0                	test   %eax,%eax
80102d12:	0f 85 cb 00 00 00    	jne    80102de3 <end_op+0x103>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d18:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d1f:	31 db                	xor    %ebx,%ebx
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102d21:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102d28:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d2b:	e8 80 16 00 00       	call   801043b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d30:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102d35:	85 c0                	test   %eax,%eax
80102d37:	0f 8e 90 00 00 00    	jle    80102dcd <end_op+0xed>
80102d3d:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d40:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d45:	01 d8                	add    %ebx,%eax
80102d47:	83 c0 01             	add    $0x1,%eax
80102d4a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d4e:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102d53:	89 04 24             	mov    %eax,(%esp)
80102d56:	e8 75 d3 ff ff       	call   801000d0 <bread>
80102d5b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d5d:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d64:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d67:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d6b:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102d70:	89 04 24             	mov    %eax,(%esp)
80102d73:	e8 58 d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102d78:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102d7f:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d80:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d82:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d85:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d89:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d8c:	89 04 24             	mov    %eax,(%esp)
80102d8f:	e8 0c 17 00 00       	call   801044a0 <memmove>
    bwrite(to);  // write the log
80102d94:	89 34 24             	mov    %esi,(%esp)
80102d97:	e8 04 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d9c:	89 3c 24             	mov    %edi,(%esp)
80102d9f:	e8 3c d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102da4:	89 34 24             	mov    %esi,(%esp)
80102da7:	e8 34 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102dac:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102db2:	7c 8c                	jl     80102d40 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102db4:	e8 a7 fd ff ff       	call   80102b60 <write_head>
    install_trans(); // Now install writes to home locations
80102db9:	e8 02 fd ff ff       	call   80102ac0 <install_trans>
    log.lh.n = 0;
80102dbe:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102dc5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dc8:	e8 93 fd ff ff       	call   80102b60 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102dcd:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dd4:	e8 67 15 00 00       	call   80104340 <acquire>
    log.committing = 0;
80102dd9:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102de0:	00 00 00 
    wakeup(&log);
80102de3:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dea:	e8 01 11 00 00       	call   80103ef0 <wakeup>
    release(&log.lock);
80102def:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102df6:	e8 b5 15 00 00       	call   801043b0 <release>
  }
}
80102dfb:	83 c4 1c             	add    $0x1c,%esp
80102dfe:	5b                   	pop    %ebx
80102dff:	5e                   	pop    %esi
80102e00:	5f                   	pop    %edi
80102e01:	5d                   	pop    %ebp
80102e02:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102e03:	c7 04 24 e4 71 10 80 	movl   $0x801071e4,(%esp)
80102e0a:	e8 51 d5 ff ff       	call   80100360 <panic>
80102e0f:	90                   	nop

80102e10 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e17:	a1 e8 26 11 80       	mov    0x801126e8,%eax
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e1c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e1f:	83 f8 1d             	cmp    $0x1d,%eax
80102e22:	0f 8f 98 00 00 00    	jg     80102ec0 <log_write+0xb0>
80102e28:	8b 0d d8 26 11 80    	mov    0x801126d8,%ecx
80102e2e:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102e31:	39 d0                	cmp    %edx,%eax
80102e33:	0f 8d 87 00 00 00    	jge    80102ec0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e39:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102e3e:	85 c0                	test   %eax,%eax
80102e40:	0f 8e 86 00 00 00    	jle    80102ecc <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e46:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e4d:	e8 ee 14 00 00       	call   80104340 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e52:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102e58:	83 fa 00             	cmp    $0x0,%edx
80102e5b:	7e 54                	jle    80102eb1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e5d:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e60:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e62:	39 0d ec 26 11 80    	cmp    %ecx,0x801126ec
80102e68:	75 0f                	jne    80102e79 <log_write+0x69>
80102e6a:	eb 3c                	jmp    80102ea8 <log_write+0x98>
80102e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e70:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102e77:	74 2f                	je     80102ea8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e79:	83 c0 01             	add    $0x1,%eax
80102e7c:	39 d0                	cmp    %edx,%eax
80102e7e:	75 f0                	jne    80102e70 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e80:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e87:	83 c2 01             	add    $0x1,%edx
80102e8a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102e90:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e93:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102e9a:	83 c4 14             	add    $0x14,%esp
80102e9d:	5b                   	pop    %ebx
80102e9e:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e9f:	e9 0c 15 00 00       	jmp    801043b0 <release>
80102ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ea8:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102eaf:	eb df                	jmp    80102e90 <log_write+0x80>
80102eb1:	8b 43 08             	mov    0x8(%ebx),%eax
80102eb4:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102eb9:	75 d5                	jne    80102e90 <log_write+0x80>
80102ebb:	eb ca                	jmp    80102e87 <log_write+0x77>
80102ebd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102ec0:	c7 04 24 f3 71 10 80 	movl   $0x801071f3,(%esp)
80102ec7:	e8 94 d4 ff ff       	call   80100360 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102ecc:	c7 04 24 09 72 10 80 	movl   $0x80107209,(%esp)
80102ed3:	e8 88 d4 ff ff       	call   80100360 <panic>
80102ed8:	66 90                	xchg   %ax,%ax
80102eda:	66 90                	xchg   %ax,%ax
80102edc:	66 90                	xchg   %ax,%ax
80102ede:	66 90                	xchg   %ax,%ax

80102ee0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	53                   	push   %ebx
80102ee4:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102ee7:	e8 f4 08 00 00       	call   801037e0 <cpuid>
80102eec:	89 c3                	mov    %eax,%ebx
80102eee:	e8 ed 08 00 00       	call   801037e0 <cpuid>
80102ef3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102ef7:	c7 04 24 24 72 10 80 	movl   $0x80107224,(%esp)
80102efe:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f02:	e8 19 d8 ff ff       	call   80100720 <cprintf>
  idtinit();       // load idt register
80102f07:	e8 d4 26 00 00       	call   801055e0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f0c:	e8 4f 08 00 00       	call   80103760 <mycpu>
80102f11:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f13:	b8 01 00 00 00       	mov    $0x1,%eax
80102f18:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f1f:	e8 9c 0b 00 00       	call   80103ac0 <scheduler>
80102f24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102f30 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f36:	e8 55 37 00 00       	call   80106690 <switchkvm>
  seginit();
80102f3b:	e8 90 36 00 00       	call   801065d0 <seginit>
  lapicinit();
80102f40:	e8 8b f8 ff ff       	call   801027d0 <lapicinit>
  mpmain();
80102f45:	e8 96 ff ff ff       	call   80102ee0 <mpmain>
80102f4a:	66 90                	xchg   %ax,%ax
80102f4c:	66 90                	xchg   %ax,%ax
80102f4e:	66 90                	xchg   %ax,%ax

80102f50 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f54:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f59:	83 e4 f0             	and    $0xfffffff0,%esp
80102f5c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f5f:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102f66:	80 
80102f67:	c7 04 24 c8 54 11 80 	movl   $0x801154c8,(%esp)
80102f6e:	e8 dd f5 ff ff       	call   80102550 <kinit1>
  kvmalloc();      // kernel page table
80102f73:	e8 a8 3b 00 00       	call   80106b20 <kvmalloc>
  mpinit();        // detect other processors
80102f78:	e8 73 01 00 00       	call   801030f0 <mpinit>
80102f7d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102f80:	e8 4b f8 ff ff       	call   801027d0 <lapicinit>
  seginit();       // segment descriptors
80102f85:	e8 46 36 00 00       	call   801065d0 <seginit>
  picinit();       // disable pic
80102f8a:	e8 21 03 00 00       	call   801032b0 <picinit>
80102f8f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102f90:	e8 db f3 ff ff       	call   80102370 <ioapicinit>
  consoleinit();   // console hardware
80102f95:	e8 16 db ff ff       	call   80100ab0 <consoleinit>
  uartinit();      // serial port
80102f9a:	e8 61 29 00 00       	call   80105900 <uartinit>
80102f9f:	90                   	nop
  pinit();         // process table
80102fa0:	e8 9b 07 00 00       	call   80103740 <pinit>
  tvinit();        // trap vectors
80102fa5:	e8 96 25 00 00       	call   80105540 <tvinit>
  binit();         // buffer cache
80102faa:	e8 91 d0 ff ff       	call   80100040 <binit>
80102faf:	90                   	nop
  fileinit();      // file table
80102fb0:	e8 fb de ff ff       	call   80100eb0 <fileinit>
  ideinit();       // disk 
80102fb5:	e8 b6 f1 ff ff       	call   80102170 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fba:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102fc1:	00 
80102fc2:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102fc9:	80 
80102fca:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102fd1:	e8 ca 14 00 00       	call   801044a0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fd6:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80102fdd:	00 00 00 
80102fe0:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fe5:	39 d8                	cmp    %ebx,%eax
80102fe7:	76 6a                	jbe    80103053 <main+0x103>
80102fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102ff0:	e8 6b 07 00 00       	call   80103760 <mycpu>
80102ff5:	39 d8                	cmp    %ebx,%eax
80102ff7:	74 41                	je     8010303a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ff9:	e8 12 f6 ff ff       	call   80102610 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102ffe:	c7 05 f8 6f 00 80 30 	movl   $0x80102f30,0x80006ff8
80103005:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103008:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010300f:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80103012:	05 00 10 00 00       	add    $0x1000,%eax
80103017:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
8010301c:	0f b6 03             	movzbl (%ebx),%eax
8010301f:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80103026:	00 
80103027:	89 04 24             	mov    %eax,(%esp)
8010302a:	e8 e1 f8 ff ff       	call   80102910 <lapicstartap>
8010302f:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103030:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103036:	85 c0                	test   %eax,%eax
80103038:	74 f6                	je     80103030 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010303a:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80103041:	00 00 00 
80103044:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010304a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010304f:	39 c3                	cmp    %eax,%ebx
80103051:	72 9d                	jb     80102ff0 <main+0xa0>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103053:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
8010305a:	8e 
8010305b:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103062:	e8 59 f5 ff ff       	call   801025c0 <kinit2>
  userinit();      // first user process
80103067:	e8 c4 07 00 00       	call   80103830 <userinit>
  mpmain();        // finish this processor's setup
8010306c:	e8 6f fe ff ff       	call   80102ee0 <mpmain>
80103071:	66 90                	xchg   %ax,%ax
80103073:	66 90                	xchg   %ax,%ax
80103075:	66 90                	xchg   %ax,%ax
80103077:	66 90                	xchg   %ax,%ax
80103079:	66 90                	xchg   %ax,%ax
8010307b:	66 90                	xchg   %ax,%ax
8010307d:	66 90                	xchg   %ax,%ax
8010307f:	90                   	nop

80103080 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103080:	55                   	push   %ebp
80103081:	89 e5                	mov    %esp,%ebp
80103083:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103084:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010308a:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010308b:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010308e:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103091:	39 de                	cmp    %ebx,%esi
80103093:	73 3c                	jae    801030d1 <mpsearch1+0x51>
80103095:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103098:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010309f:	00 
801030a0:	c7 44 24 04 38 72 10 	movl   $0x80107238,0x4(%esp)
801030a7:	80 
801030a8:	89 34 24             	mov    %esi,(%esp)
801030ab:	e8 a0 13 00 00       	call   80104450 <memcmp>
801030b0:	85 c0                	test   %eax,%eax
801030b2:	75 16                	jne    801030ca <mpsearch1+0x4a>
801030b4:	31 c9                	xor    %ecx,%ecx
801030b6:	31 d2                	xor    %edx,%edx
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030b8:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030bc:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801030bf:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030c1:	83 fa 10             	cmp    $0x10,%edx
801030c4:	75 f2                	jne    801030b8 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c6:	84 c9                	test   %cl,%cl
801030c8:	74 10                	je     801030da <mpsearch1+0x5a>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030ca:	83 c6 10             	add    $0x10,%esi
801030cd:	39 f3                	cmp    %esi,%ebx
801030cf:	77 c7                	ja     80103098 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030d1:	83 c4 10             	add    $0x10,%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801030d4:	31 c0                	xor    %eax,%eax
}
801030d6:	5b                   	pop    %ebx
801030d7:	5e                   	pop    %esi
801030d8:	5d                   	pop    %ebp
801030d9:	c3                   	ret    
801030da:	83 c4 10             	add    $0x10,%esp
801030dd:	89 f0                	mov    %esi,%eax
801030df:	5b                   	pop    %ebx
801030e0:	5e                   	pop    %esi
801030e1:	5d                   	pop    %ebp
801030e2:	c3                   	ret    
801030e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801030f0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	57                   	push   %edi
801030f4:	56                   	push   %esi
801030f5:	53                   	push   %ebx
801030f6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801030f9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103100:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103107:	c1 e0 08             	shl    $0x8,%eax
8010310a:	09 d0                	or     %edx,%eax
8010310c:	c1 e0 04             	shl    $0x4,%eax
8010310f:	85 c0                	test   %eax,%eax
80103111:	75 1b                	jne    8010312e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103113:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010311a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103121:	c1 e0 08             	shl    $0x8,%eax
80103124:	09 d0                	or     %edx,%eax
80103126:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103129:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010312e:	ba 00 04 00 00       	mov    $0x400,%edx
80103133:	e8 48 ff ff ff       	call   80103080 <mpsearch1>
80103138:	85 c0                	test   %eax,%eax
8010313a:	89 c7                	mov    %eax,%edi
8010313c:	0f 84 22 01 00 00    	je     80103264 <mpinit+0x174>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103142:	8b 77 04             	mov    0x4(%edi),%esi
80103145:	85 f6                	test   %esi,%esi
80103147:	0f 84 30 01 00 00    	je     8010327d <mpinit+0x18d>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010314d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103153:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010315a:	00 
8010315b:	c7 44 24 04 3d 72 10 	movl   $0x8010723d,0x4(%esp)
80103162:	80 
80103163:	89 04 24             	mov    %eax,(%esp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103166:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103169:	e8 e2 12 00 00       	call   80104450 <memcmp>
8010316e:	85 c0                	test   %eax,%eax
80103170:	0f 85 07 01 00 00    	jne    8010327d <mpinit+0x18d>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103176:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010317d:	3c 04                	cmp    $0x4,%al
8010317f:	0f 85 0b 01 00 00    	jne    80103290 <mpinit+0x1a0>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103185:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010318c:	85 c0                	test   %eax,%eax
8010318e:	74 21                	je     801031b1 <mpinit+0xc1>
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
80103190:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
80103192:	31 d2                	xor    %edx,%edx
80103194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103198:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
8010319f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031a0:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031a3:	01 d9                	add    %ebx,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031a5:	39 d0                	cmp    %edx,%eax
801031a7:	7f ef                	jg     80103198 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031a9:	84 c9                	test   %cl,%cl
801031ab:	0f 85 cc 00 00 00    	jne    8010327d <mpinit+0x18d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801031b4:	85 c0                	test   %eax,%eax
801031b6:	0f 84 c1 00 00 00    	je     8010327d <mpinit+0x18d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031bc:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801031c2:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
801031c7:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031cc:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801031d3:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801031d9:	03 55 e4             	add    -0x1c(%ebp),%edx
801031dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031e0:	39 c2                	cmp    %eax,%edx
801031e2:	76 1b                	jbe    801031ff <mpinit+0x10f>
801031e4:	0f b6 08             	movzbl (%eax),%ecx
    switch(*p){
801031e7:	80 f9 04             	cmp    $0x4,%cl
801031ea:	77 74                	ja     80103260 <mpinit+0x170>
801031ec:	ff 24 8d 7c 72 10 80 	jmp    *-0x7fef8d84(,%ecx,4)
801031f3:	90                   	nop
801031f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801031f8:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031fb:	39 c2                	cmp    %eax,%edx
801031fd:	77 e5                	ja     801031e4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801031ff:	85 db                	test   %ebx,%ebx
80103201:	0f 84 93 00 00 00    	je     8010329a <mpinit+0x1aa>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103207:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
8010320b:	74 12                	je     8010321f <mpinit+0x12f>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010320d:	ba 22 00 00 00       	mov    $0x22,%edx
80103212:	b8 70 00 00 00       	mov    $0x70,%eax
80103217:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103218:	b2 23                	mov    $0x23,%dl
8010321a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010321b:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010321e:	ee                   	out    %al,(%dx)
  }
}
8010321f:	83 c4 1c             	add    $0x1c,%esp
80103222:	5b                   	pop    %ebx
80103223:	5e                   	pop    %esi
80103224:	5f                   	pop    %edi
80103225:	5d                   	pop    %ebp
80103226:	c3                   	ret    
80103227:	90                   	nop
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103228:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
8010322e:	83 fe 07             	cmp    $0x7,%esi
80103231:	7f 17                	jg     8010324a <mpinit+0x15a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103233:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80103237:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
        ncpu++;
8010323d:	83 05 20 2d 11 80 01 	addl   $0x1,0x80112d20
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103244:	88 8e a0 27 11 80    	mov    %cl,-0x7feed860(%esi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010324a:	83 c0 14             	add    $0x14,%eax
      continue;
8010324d:	eb 91                	jmp    801031e0 <mpinit+0xf0>
8010324f:	90                   	nop
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103250:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103254:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103257:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
8010325d:	eb 81                	jmp    801031e0 <mpinit+0xf0>
8010325f:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103260:	31 db                	xor    %ebx,%ebx
80103262:	eb 83                	jmp    801031e7 <mpinit+0xf7>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103264:	ba 00 00 01 00       	mov    $0x10000,%edx
80103269:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010326e:	e8 0d fe ff ff       	call   80103080 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103273:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103275:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103277:	0f 85 c5 fe ff ff    	jne    80103142 <mpinit+0x52>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
8010327d:	c7 04 24 42 72 10 80 	movl   $0x80107242,(%esp)
80103284:	e8 d7 d0 ff ff       	call   80100360 <panic>
80103289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103290:	3c 01                	cmp    $0x1,%al
80103292:	0f 84 ed fe ff ff    	je     80103185 <mpinit+0x95>
80103298:	eb e3                	jmp    8010327d <mpinit+0x18d>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
8010329a:	c7 04 24 5c 72 10 80 	movl   $0x8010725c,(%esp)
801032a1:	e8 ba d0 ff ff       	call   80100360 <panic>
801032a6:	66 90                	xchg   %ax,%ax
801032a8:	66 90                	xchg   %ax,%ax
801032aa:	66 90                	xchg   %ax,%ax
801032ac:	66 90                	xchg   %ax,%ax
801032ae:	66 90                	xchg   %ax,%ax

801032b0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801032b0:	55                   	push   %ebp
801032b1:	ba 21 00 00 00       	mov    $0x21,%edx
801032b6:	89 e5                	mov    %esp,%ebp
801032b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032bd:	ee                   	out    %al,(%dx)
801032be:	b2 a1                	mov    $0xa1,%dl
801032c0:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801032c1:	5d                   	pop    %ebp
801032c2:	c3                   	ret    
801032c3:	66 90                	xchg   %ax,%ax
801032c5:	66 90                	xchg   %ax,%ax
801032c7:	66 90                	xchg   %ax,%ax
801032c9:	66 90                	xchg   %ax,%ax
801032cb:	66 90                	xchg   %ax,%ax
801032cd:	66 90                	xchg   %ax,%ax
801032cf:	90                   	nop

801032d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801032d0:	55                   	push   %ebp
801032d1:	89 e5                	mov    %esp,%ebp
801032d3:	57                   	push   %edi
801032d4:	56                   	push   %esi
801032d5:	53                   	push   %ebx
801032d6:	83 ec 1c             	sub    $0x1c,%esp
801032d9:	8b 75 08             	mov    0x8(%ebp),%esi
801032dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801032df:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801032e5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801032eb:	e8 e0 db ff ff       	call   80100ed0 <filealloc>
801032f0:	85 c0                	test   %eax,%eax
801032f2:	89 06                	mov    %eax,(%esi)
801032f4:	0f 84 a4 00 00 00    	je     8010339e <pipealloc+0xce>
801032fa:	e8 d1 db ff ff       	call   80100ed0 <filealloc>
801032ff:	85 c0                	test   %eax,%eax
80103301:	89 03                	mov    %eax,(%ebx)
80103303:	0f 84 87 00 00 00    	je     80103390 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103309:	e8 02 f3 ff ff       	call   80102610 <kalloc>
8010330e:	85 c0                	test   %eax,%eax
80103310:	89 c7                	mov    %eax,%edi
80103312:	74 7c                	je     80103390 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
80103314:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010331b:	00 00 00 
  p->writeopen = 1;
8010331e:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103325:	00 00 00 
  p->nwrite = 0;
80103328:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010332f:	00 00 00 
  p->nread = 0;
80103332:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103339:	00 00 00 
  initlock(&p->lock, "pipe");
8010333c:	89 04 24             	mov    %eax,(%esp)
8010333f:	c7 44 24 04 90 72 10 	movl   $0x80107290,0x4(%esp)
80103346:	80 
80103347:	e8 84 0e 00 00       	call   801041d0 <initlock>
  (*f0)->type = FD_PIPE;
8010334c:	8b 06                	mov    (%esi),%eax
8010334e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103354:	8b 06                	mov    (%esi),%eax
80103356:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010335a:	8b 06                	mov    (%esi),%eax
8010335c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103360:	8b 06                	mov    (%esi),%eax
80103362:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103365:	8b 03                	mov    (%ebx),%eax
80103367:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010336d:	8b 03                	mov    (%ebx),%eax
8010336f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103373:	8b 03                	mov    (%ebx),%eax
80103375:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103379:	8b 03                	mov    (%ebx),%eax
  return 0;
8010337b:	31 db                	xor    %ebx,%ebx
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
8010337d:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103380:	83 c4 1c             	add    $0x1c,%esp
80103383:	89 d8                	mov    %ebx,%eax
80103385:	5b                   	pop    %ebx
80103386:	5e                   	pop    %esi
80103387:	5f                   	pop    %edi
80103388:	5d                   	pop    %ebp
80103389:	c3                   	ret    
8010338a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103390:	8b 06                	mov    (%esi),%eax
80103392:	85 c0                	test   %eax,%eax
80103394:	74 08                	je     8010339e <pipealloc+0xce>
    fileclose(*f0);
80103396:	89 04 24             	mov    %eax,(%esp)
80103399:	e8 f2 db ff ff       	call   80100f90 <fileclose>
  if(*f1)
8010339e:	8b 03                	mov    (%ebx),%eax
    fileclose(*f1);
  return -1;
801033a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
801033a5:	85 c0                	test   %eax,%eax
801033a7:	74 d7                	je     80103380 <pipealloc+0xb0>
    fileclose(*f1);
801033a9:	89 04 24             	mov    %eax,(%esp)
801033ac:	e8 df db ff ff       	call   80100f90 <fileclose>
  return -1;
}
801033b1:	83 c4 1c             	add    $0x1c,%esp
801033b4:	89 d8                	mov    %ebx,%eax
801033b6:	5b                   	pop    %ebx
801033b7:	5e                   	pop    %esi
801033b8:	5f                   	pop    %edi
801033b9:	5d                   	pop    %ebp
801033ba:	c3                   	ret    
801033bb:	90                   	nop
801033bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801033c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	56                   	push   %esi
801033c4:	53                   	push   %ebx
801033c5:	83 ec 10             	sub    $0x10,%esp
801033c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801033ce:	89 1c 24             	mov    %ebx,(%esp)
801033d1:	e8 6a 0f 00 00       	call   80104340 <acquire>
  if(writable){
801033d6:	85 f6                	test   %esi,%esi
801033d8:	74 3e                	je     80103418 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->nread);
801033da:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
801033e0:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801033e7:	00 00 00 
    wakeup(&p->nread);
801033ea:	89 04 24             	mov    %eax,(%esp)
801033ed:	e8 fe 0a 00 00       	call   80103ef0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033f2:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033f8:	85 d2                	test   %edx,%edx
801033fa:	75 0a                	jne    80103406 <pipeclose+0x46>
801033fc:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103402:	85 c0                	test   %eax,%eax
80103404:	74 32                	je     80103438 <pipeclose+0x78>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103406:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103409:	83 c4 10             	add    $0x10,%esp
8010340c:	5b                   	pop    %ebx
8010340d:	5e                   	pop    %esi
8010340e:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010340f:	e9 9c 0f 00 00       	jmp    801043b0 <release>
80103414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103418:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
8010341e:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103425:	00 00 00 
    wakeup(&p->nwrite);
80103428:	89 04 24             	mov    %eax,(%esp)
8010342b:	e8 c0 0a 00 00       	call   80103ef0 <wakeup>
80103430:	eb c0                	jmp    801033f2 <pipeclose+0x32>
80103432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103438:	89 1c 24             	mov    %ebx,(%esp)
8010343b:	e8 70 0f 00 00       	call   801043b0 <release>
    kfree((char*)p);
80103440:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
80103443:	83 c4 10             	add    $0x10,%esp
80103446:	5b                   	pop    %ebx
80103447:	5e                   	pop    %esi
80103448:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103449:	e9 12 f0 ff ff       	jmp    80102460 <kfree>
8010344e:	66 90                	xchg   %ax,%ax

80103450 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	57                   	push   %edi
80103454:	56                   	push   %esi
80103455:	53                   	push   %ebx
80103456:	83 ec 1c             	sub    $0x1c,%esp
80103459:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010345c:	89 1c 24             	mov    %ebx,(%esp)
8010345f:	e8 dc 0e 00 00       	call   80104340 <acquire>
  for(i = 0; i < n; i++){
80103464:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103467:	85 c9                	test   %ecx,%ecx
80103469:	0f 8e b2 00 00 00    	jle    80103521 <pipewrite+0xd1>
8010346f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103472:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103478:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010347e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103484:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103487:	03 4d 10             	add    0x10(%ebp),%ecx
8010348a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010348d:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103493:	81 c1 00 02 00 00    	add    $0x200,%ecx
80103499:	39 c8                	cmp    %ecx,%eax
8010349b:	74 38                	je     801034d5 <pipewrite+0x85>
8010349d:	eb 55                	jmp    801034f4 <pipewrite+0xa4>
8010349f:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
801034a0:	e8 5b 03 00 00       	call   80103800 <myproc>
801034a5:	8b 40 24             	mov    0x24(%eax),%eax
801034a8:	85 c0                	test   %eax,%eax
801034aa:	75 33                	jne    801034df <pipewrite+0x8f>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034ac:	89 3c 24             	mov    %edi,(%esp)
801034af:	e8 3c 0a 00 00       	call   80103ef0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034b4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801034b8:	89 34 24             	mov    %esi,(%esp)
801034bb:	e8 a0 08 00 00       	call   80103d60 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034c0:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801034c6:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801034cc:	05 00 02 00 00       	add    $0x200,%eax
801034d1:	39 c2                	cmp    %eax,%edx
801034d3:	75 23                	jne    801034f8 <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
801034d5:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034db:	85 d2                	test   %edx,%edx
801034dd:	75 c1                	jne    801034a0 <pipewrite+0x50>
        release(&p->lock);
801034df:	89 1c 24             	mov    %ebx,(%esp)
801034e2:	e8 c9 0e 00 00       	call   801043b0 <release>
        return -1;
801034e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034ec:	83 c4 1c             	add    $0x1c,%esp
801034ef:	5b                   	pop    %ebx
801034f0:	5e                   	pop    %esi
801034f1:	5f                   	pop    %edi
801034f2:	5d                   	pop    %ebp
801034f3:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034f4:	89 c2                	mov    %eax,%edx
801034f6:	66 90                	xchg   %ax,%ax
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034f8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801034fb:	8d 42 01             	lea    0x1(%edx),%eax
801034fe:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103504:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
8010350a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010350e:	0f b6 09             	movzbl (%ecx),%ecx
80103511:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103515:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103518:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
8010351b:	0f 85 6c ff ff ff    	jne    8010348d <pipewrite+0x3d>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103521:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103527:	89 04 24             	mov    %eax,(%esp)
8010352a:	e8 c1 09 00 00       	call   80103ef0 <wakeup>
  release(&p->lock);
8010352f:	89 1c 24             	mov    %ebx,(%esp)
80103532:	e8 79 0e 00 00       	call   801043b0 <release>
  return n;
80103537:	8b 45 10             	mov    0x10(%ebp),%eax
8010353a:	eb b0                	jmp    801034ec <pipewrite+0x9c>
8010353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103540 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	57                   	push   %edi
80103544:	56                   	push   %esi
80103545:	53                   	push   %ebx
80103546:	83 ec 1c             	sub    $0x1c,%esp
80103549:	8b 75 08             	mov    0x8(%ebp),%esi
8010354c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010354f:	89 34 24             	mov    %esi,(%esp)
80103552:	e8 e9 0d 00 00       	call   80104340 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103557:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010355d:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103563:	75 5b                	jne    801035c0 <piperead+0x80>
80103565:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010356b:	85 db                	test   %ebx,%ebx
8010356d:	74 51                	je     801035c0 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010356f:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103575:	eb 25                	jmp    8010359c <piperead+0x5c>
80103577:	90                   	nop
80103578:	89 74 24 04          	mov    %esi,0x4(%esp)
8010357c:	89 1c 24             	mov    %ebx,(%esp)
8010357f:	e8 dc 07 00 00       	call   80103d60 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103584:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010358a:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103590:	75 2e                	jne    801035c0 <piperead+0x80>
80103592:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103598:	85 d2                	test   %edx,%edx
8010359a:	74 24                	je     801035c0 <piperead+0x80>
    if(myproc()->killed){
8010359c:	e8 5f 02 00 00       	call   80103800 <myproc>
801035a1:	8b 48 24             	mov    0x24(%eax),%ecx
801035a4:	85 c9                	test   %ecx,%ecx
801035a6:	74 d0                	je     80103578 <piperead+0x38>
      release(&p->lock);
801035a8:	89 34 24             	mov    %esi,(%esp)
801035ab:	e8 00 0e 00 00       	call   801043b0 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035b0:	83 c4 1c             	add    $0x1c,%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
801035b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035b8:	5b                   	pop    %ebx
801035b9:	5e                   	pop    %esi
801035ba:	5f                   	pop    %edi
801035bb:	5d                   	pop    %ebp
801035bc:	c3                   	ret    
801035bd:	8d 76 00             	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c0:	8b 55 10             	mov    0x10(%ebp),%edx
    if(p->nread == p->nwrite)
801035c3:	31 db                	xor    %ebx,%ebx
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c5:	85 d2                	test   %edx,%edx
801035c7:	7f 2b                	jg     801035f4 <piperead+0xb4>
801035c9:	eb 31                	jmp    801035fc <piperead+0xbc>
801035cb:	90                   	nop
801035cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035d0:	8d 48 01             	lea    0x1(%eax),%ecx
801035d3:	25 ff 01 00 00       	and    $0x1ff,%eax
801035d8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801035de:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801035e3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035e6:	83 c3 01             	add    $0x1,%ebx
801035e9:	3b 5d 10             	cmp    0x10(%ebp),%ebx
801035ec:	74 0e                	je     801035fc <piperead+0xbc>
    if(p->nread == p->nwrite)
801035ee:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801035f4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801035fa:	75 d4                	jne    801035d0 <piperead+0x90>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035fc:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103602:	89 04 24             	mov    %eax,(%esp)
80103605:	e8 e6 08 00 00       	call   80103ef0 <wakeup>
  release(&p->lock);
8010360a:	89 34 24             	mov    %esi,(%esp)
8010360d:	e8 9e 0d 00 00       	call   801043b0 <release>
  return i;
}
80103612:	83 c4 1c             	add    $0x1c,%esp
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
80103615:	89 d8                	mov    %ebx,%eax
}
80103617:	5b                   	pop    %ebx
80103618:	5e                   	pop    %esi
80103619:	5f                   	pop    %edi
8010361a:	5d                   	pop    %ebp
8010361b:	c3                   	ret    
8010361c:	66 90                	xchg   %ax,%ax
8010361e:	66 90                	xchg   %ax,%ax

80103620 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103624:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103629:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010362c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103633:	e8 08 0d 00 00       	call   80104340 <acquire>
80103638:	eb 11                	jmp    8010364b <allocproc+0x2b>
8010363a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103640:	83 c3 7c             	add    $0x7c,%ebx
80103643:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103649:	74 7d                	je     801036c8 <allocproc+0xa8>
    if(p->state == UNUSED)
8010364b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010364e:	85 c0                	test   %eax,%eax
80103650:	75 ee                	jne    80103640 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103652:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103657:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010365e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103665:	8d 50 01             	lea    0x1(%eax),%edx
80103668:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
8010366e:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
80103671:	e8 3a 0d 00 00       	call   801043b0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103676:	e8 95 ef ff ff       	call   80102610 <kalloc>
8010367b:	85 c0                	test   %eax,%eax
8010367d:	89 43 08             	mov    %eax,0x8(%ebx)
80103680:	74 5a                	je     801036dc <allocproc+0xbc>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103682:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103688:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010368d:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103690:	c7 40 14 35 55 10 80 	movl   $0x80105535,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103697:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010369e:	00 
8010369f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801036a6:	00 
801036a7:	89 04 24             	mov    %eax,(%esp)
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
801036aa:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036ad:	e8 4e 0d 00 00       	call   80104400 <memset>
  p->context->eip = (uint)forkret;
801036b2:	8b 43 1c             	mov    0x1c(%ebx),%eax
801036b5:	c7 40 10 f0 36 10 80 	movl   $0x801036f0,0x10(%eax)

  return p;
801036bc:	89 d8                	mov    %ebx,%eax
}
801036be:	83 c4 14             	add    $0x14,%esp
801036c1:	5b                   	pop    %ebx
801036c2:	5d                   	pop    %ebp
801036c3:	c3                   	ret    
801036c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801036c8:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801036cf:	e8 dc 0c 00 00       	call   801043b0 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801036d4:	83 c4 14             	add    $0x14,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;
801036d7:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801036d9:	5b                   	pop    %ebx
801036da:	5d                   	pop    %ebp
801036db:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801036dc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036e3:	eb d9                	jmp    801036be <allocproc+0x9e>
801036e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036f0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036f6:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801036fd:	e8 ae 0c 00 00       	call   801043b0 <release>

  if (first) {
80103702:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103707:	85 c0                	test   %eax,%eax
80103709:	75 05                	jne    80103710 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010370b:	c9                   	leave  
8010370c:	c3                   	ret    
8010370d:	8d 76 00             	lea    0x0(%esi),%esi
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103710:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103717:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010371e:	00 00 00 
    iinit(ROOTDEV);
80103721:	e8 ba de ff ff       	call   801015e0 <iinit>
    initlog(ROOTDEV);
80103726:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010372d:	e8 9e f4 ff ff       	call   80102bd0 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103732:	c9                   	leave  
80103733:	c3                   	ret    
80103734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010373a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103740 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103746:	c7 44 24 04 95 72 10 	movl   $0x80107295,0x4(%esp)
8010374d:	80 
8010374e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103755:	e8 76 0a 00 00       	call   801041d0 <initlock>
}
8010375a:	c9                   	leave  
8010375b:	c3                   	ret    
8010375c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103760 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	56                   	push   %esi
80103764:	53                   	push   %ebx
80103765:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103768:	9c                   	pushf  
80103769:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
8010376a:	f6 c4 02             	test   $0x2,%ah
8010376d:	75 57                	jne    801037c6 <mycpu+0x66>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010376f:	e8 4c f1 ff ff       	call   801028c0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103774:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
8010377a:	85 f6                	test   %esi,%esi
8010377c:	7e 3c                	jle    801037ba <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010377e:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
80103785:	39 c2                	cmp    %eax,%edx
80103787:	74 2d                	je     801037b6 <mycpu+0x56>
80103789:	b9 50 28 11 80       	mov    $0x80112850,%ecx
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
8010378e:	31 d2                	xor    %edx,%edx
80103790:	83 c2 01             	add    $0x1,%edx
80103793:	39 f2                	cmp    %esi,%edx
80103795:	74 23                	je     801037ba <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103797:	0f b6 19             	movzbl (%ecx),%ebx
8010379a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801037a0:	39 c3                	cmp    %eax,%ebx
801037a2:	75 ec                	jne    80103790 <mycpu+0x30>
      return &cpus[i];
801037a4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
801037aa:	83 c4 10             	add    $0x10,%esp
801037ad:	5b                   	pop    %ebx
801037ae:	5e                   	pop    %esi
801037af:	5d                   	pop    %ebp
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
801037b0:	05 a0 27 11 80       	add    $0x801127a0,%eax
  }
  panic("unknown apicid\n");
}
801037b5:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801037b6:	31 d2                	xor    %edx,%edx
801037b8:	eb ea                	jmp    801037a4 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
801037ba:	c7 04 24 9c 72 10 80 	movl   $0x8010729c,(%esp)
801037c1:	e8 9a cb ff ff       	call   80100360 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
801037c6:	c7 04 24 78 73 10 80 	movl   $0x80107378,(%esp)
801037cd:	e8 8e cb ff ff       	call   80100360 <panic>
801037d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037e0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037e6:	e8 75 ff ff ff       	call   80103760 <mycpu>
}
801037eb:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801037ec:	2d a0 27 11 80       	sub    $0x801127a0,%eax
801037f1:	c1 f8 04             	sar    $0x4,%eax
801037f4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037fa:	c3                   	ret    
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103800 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	53                   	push   %ebx
80103804:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103807:	e8 44 0a 00 00       	call   80104250 <pushcli>
  c = mycpu();
8010380c:	e8 4f ff ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103811:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103817:	e8 74 0a 00 00       	call   80104290 <popcli>
  return p;
}
8010381c:	83 c4 04             	add    $0x4,%esp
8010381f:	89 d8                	mov    %ebx,%eax
80103821:	5b                   	pop    %ebx
80103822:	5d                   	pop    %ebp
80103823:	c3                   	ret    
80103824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010382a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103830 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	53                   	push   %ebx
80103834:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103837:	e8 e4 fd ff ff       	call   80103620 <allocproc>
8010383c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010383e:	a3 d8 a5 10 80       	mov    %eax,0x8010a5d8
  if((p->pgdir = setupkvm()) == 0)
80103843:	e8 48 32 00 00       	call   80106a90 <setupkvm>
80103848:	85 c0                	test   %eax,%eax
8010384a:	89 43 04             	mov    %eax,0x4(%ebx)
8010384d:	0f 84 d4 00 00 00    	je     80103927 <userinit+0xf7>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103853:	89 04 24             	mov    %eax,(%esp)
80103856:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
8010385d:	00 
8010385e:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103865:	80 
80103866:	e8 55 2f 00 00       	call   801067c0 <inituvm>
  p->sz = PGSIZE;
8010386b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103871:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103878:	00 
80103879:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103880:	00 
80103881:	8b 43 18             	mov    0x18(%ebx),%eax
80103884:	89 04 24             	mov    %eax,(%esp)
80103887:	e8 74 0b 00 00       	call   80104400 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010388c:	8b 43 18             	mov    0x18(%ebx),%eax
8010388f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103894:	b9 23 00 00 00       	mov    $0x23,%ecx
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103899:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010389d:	8b 43 18             	mov    0x18(%ebx),%eax
801038a0:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801038a4:	8b 43 18             	mov    0x18(%ebx),%eax
801038a7:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038ab:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038af:	8b 43 18             	mov    0x18(%ebx),%eax
801038b2:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038b6:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038ba:	8b 43 18             	mov    0x18(%ebx),%eax
801038bd:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038c4:	8b 43 18             	mov    0x18(%ebx),%eax
801038c7:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038ce:	8b 43 18             	mov    0x18(%ebx),%eax
801038d1:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038d8:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038db:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801038e2:	00 
801038e3:	c7 44 24 04 c5 72 10 	movl   $0x801072c5,0x4(%esp)
801038ea:	80 
801038eb:	89 04 24             	mov    %eax,(%esp)
801038ee:	e8 ed 0c 00 00       	call   801045e0 <safestrcpy>
  p->cwd = namei("/");
801038f3:	c7 04 24 ce 72 10 80 	movl   $0x801072ce,(%esp)
801038fa:	e8 71 e7 ff ff       	call   80102070 <namei>
801038ff:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103902:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103909:	e8 32 0a 00 00       	call   80104340 <acquire>

  p->state = RUNNABLE;
8010390e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103915:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010391c:	e8 8f 0a 00 00       	call   801043b0 <release>
}
80103921:	83 c4 14             	add    $0x14,%esp
80103924:	5b                   	pop    %ebx
80103925:	5d                   	pop    %ebp
80103926:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103927:	c7 04 24 ac 72 10 80 	movl   $0x801072ac,(%esp)
8010392e:	e8 2d ca ff ff       	call   80100360 <panic>
80103933:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103940 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	56                   	push   %esi
80103944:	53                   	push   %ebx
80103945:	83 ec 10             	sub    $0x10,%esp
80103948:	8b 75 08             	mov    0x8(%ebp),%esi
  uint sz;
  struct proc *curproc = myproc();
8010394b:	e8 b0 fe ff ff       	call   80103800 <myproc>

  sz = curproc->sz;
  if(n > 0){
80103950:	83 fe 00             	cmp    $0x0,%esi
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();
80103953:	89 c3                	mov    %eax,%ebx

  sz = curproc->sz;
80103955:	8b 00                	mov    (%eax),%eax
  if(n > 0){
80103957:	7e 2f                	jle    80103988 <growproc+0x48>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103959:	01 c6                	add    %eax,%esi
8010395b:	89 74 24 08          	mov    %esi,0x8(%esp)
8010395f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103963:	8b 43 04             	mov    0x4(%ebx),%eax
80103966:	89 04 24             	mov    %eax,(%esp)
80103969:	e8 92 2f 00 00       	call   80106900 <allocuvm>
8010396e:	85 c0                	test   %eax,%eax
80103970:	74 36                	je     801039a8 <growproc+0x68>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103972:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103974:	89 1c 24             	mov    %ebx,(%esp)
80103977:	e8 34 2d 00 00       	call   801066b0 <switchuvm>
  return 0;
8010397c:	31 c0                	xor    %eax,%eax
}
8010397e:	83 c4 10             	add    $0x10,%esp
80103981:	5b                   	pop    %ebx
80103982:	5e                   	pop    %esi
80103983:	5d                   	pop    %ebp
80103984:	c3                   	ret    
80103985:	8d 76 00             	lea    0x0(%esi),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103988:	74 e8                	je     80103972 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010398a:	01 c6                	add    %eax,%esi
8010398c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103990:	89 44 24 04          	mov    %eax,0x4(%esp)
80103994:	8b 43 04             	mov    0x4(%ebx),%eax
80103997:	89 04 24             	mov    %eax,(%esp)
8010399a:	e8 51 30 00 00       	call   801069f0 <deallocuvm>
8010399f:	85 c0                	test   %eax,%eax
801039a1:	75 cf                	jne    80103972 <growproc+0x32>
801039a3:	90                   	nop
801039a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
801039a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039ad:	eb cf                	jmp    8010397e <growproc+0x3e>
801039af:	90                   	nop

801039b0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	57                   	push   %edi
801039b4:	56                   	push   %esi
801039b5:	53                   	push   %ebx
801039b6:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
801039b9:	e8 42 fe ff ff       	call   80103800 <myproc>
801039be:	89 c3                	mov    %eax,%ebx

  // Allocate process.
  if((np = allocproc()) == 0){
801039c0:	e8 5b fc ff ff       	call   80103620 <allocproc>
801039c5:	85 c0                	test   %eax,%eax
801039c7:	89 c7                	mov    %eax,%edi
801039c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039cc:	0f 84 bc 00 00 00    	je     80103a8e <fork+0xde>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039d2:	8b 03                	mov    (%ebx),%eax
801039d4:	89 44 24 04          	mov    %eax,0x4(%esp)
801039d8:	8b 43 04             	mov    0x4(%ebx),%eax
801039db:	89 04 24             	mov    %eax,(%esp)
801039de:	e8 8d 31 00 00       	call   80106b70 <copyuvm>
801039e3:	85 c0                	test   %eax,%eax
801039e5:	89 47 04             	mov    %eax,0x4(%edi)
801039e8:	0f 84 a7 00 00 00    	je     80103a95 <fork+0xe5>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
801039ee:	8b 03                	mov    (%ebx),%eax
801039f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039f3:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
  *np->tf = *curproc->tf;
801039f5:	8b 79 18             	mov    0x18(%ecx),%edi
801039f8:	89 c8                	mov    %ecx,%eax
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
801039fa:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801039fd:	8b 73 18             	mov    0x18(%ebx),%esi
80103a00:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a05:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a07:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103a09:	8b 40 18             	mov    0x18(%eax),%eax
80103a0c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103a13:	90                   	nop
80103a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103a18:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a1c:	85 c0                	test   %eax,%eax
80103a1e:	74 0f                	je     80103a2f <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a20:	89 04 24             	mov    %eax,(%esp)
80103a23:	e8 18 d5 ff ff       	call   80100f40 <filedup>
80103a28:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a2b:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a2f:	83 c6 01             	add    $0x1,%esi
80103a32:	83 fe 10             	cmp    $0x10,%esi
80103a35:	75 e1                	jne    80103a18 <fork+0x68>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a37:	8b 43 68             	mov    0x68(%ebx),%eax

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a3a:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a3d:	89 04 24             	mov    %eax,(%esp)
80103a40:	e8 ab dd ff ff       	call   801017f0 <idup>
80103a45:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103a48:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a4b:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a4e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103a52:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103a59:	00 
80103a5a:	89 04 24             	mov    %eax,(%esp)
80103a5d:	e8 7e 0b 00 00       	call   801045e0 <safestrcpy>

  pid = np->pid;
80103a62:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103a65:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a6c:	e8 cf 08 00 00       	call   80104340 <acquire>

  np->state = RUNNABLE;
80103a71:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103a78:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a7f:	e8 2c 09 00 00       	call   801043b0 <release>

  return pid;
80103a84:	89 d8                	mov    %ebx,%eax
}
80103a86:	83 c4 1c             	add    $0x1c,%esp
80103a89:	5b                   	pop    %ebx
80103a8a:	5e                   	pop    %esi
80103a8b:	5f                   	pop    %edi
80103a8c:	5d                   	pop    %ebp
80103a8d:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103a8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a93:	eb f1                	jmp    80103a86 <fork+0xd6>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103a95:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103a98:	8b 47 08             	mov    0x8(%edi),%eax
80103a9b:	89 04 24             	mov    %eax,(%esp)
80103a9e:	e8 bd e9 ff ff       	call   80102460 <kfree>
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
80103aa3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
80103aa8:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103aaf:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103ab6:	eb ce                	jmp    80103a86 <fork+0xd6>
80103ab8:	90                   	nop
80103ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ac0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	57                   	push   %edi
80103ac4:	56                   	push   %esi
80103ac5:	53                   	push   %ebx
80103ac6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103ac9:	e8 92 fc ff ff       	call   80103760 <mycpu>
80103ace:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ad0:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ad7:	00 00 00 
80103ada:	8d 78 04             	lea    0x4(%eax),%edi
80103add:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103ae0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103ae1:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ae8:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103aed:	e8 4e 08 00 00       	call   80104340 <acquire>
80103af2:	eb 0f                	jmp    80103b03 <scheduler+0x43>
80103af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103af8:	83 c3 7c             	add    $0x7c,%ebx
80103afb:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103b01:	74 45                	je     80103b48 <scheduler+0x88>
      if(p->state != RUNNABLE)
80103b03:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b07:	75 ef                	jne    80103af8 <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103b09:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103b0f:	89 1c 24             	mov    %ebx,(%esp)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b12:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103b15:	e8 96 2b 00 00       	call   801066b0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103b1a:	8b 43 a0             	mov    -0x60(%ebx),%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103b1d:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103b24:	89 3c 24             	mov    %edi,(%esp)
80103b27:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b2b:	e8 0b 0b 00 00       	call   8010463b <swtch>
      switchkvm();
80103b30:	e8 5b 2b 00 00       	call   80106690 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b35:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103b3b:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b42:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b45:	75 bc                	jne    80103b03 <scheduler+0x43>
80103b47:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103b48:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103b4f:	e8 5c 08 00 00       	call   801043b0 <release>

  }
80103b54:	eb 8a                	jmp    80103ae0 <scheduler+0x20>
80103b56:	8d 76 00             	lea    0x0(%esi),%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b60 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	56                   	push   %esi
80103b64:	53                   	push   %ebx
80103b65:	83 ec 10             	sub    $0x10,%esp
  int intena;
  struct proc *p = myproc();
80103b68:	e8 93 fc ff ff       	call   80103800 <myproc>

  if(!holding(&ptable.lock))
80103b6d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();
80103b74:	89 c3                	mov    %eax,%ebx

  if(!holding(&ptable.lock))
80103b76:	e8 85 07 00 00       	call   80104300 <holding>
80103b7b:	85 c0                	test   %eax,%eax
80103b7d:	74 4f                	je     80103bce <sched+0x6e>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103b7f:	e8 dc fb ff ff       	call   80103760 <mycpu>
80103b84:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b8b:	75 65                	jne    80103bf2 <sched+0x92>
    panic("sched locks");
  if(p->state == RUNNING)
80103b8d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b91:	74 53                	je     80103be6 <sched+0x86>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b93:	9c                   	pushf  
80103b94:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103b95:	f6 c4 02             	test   $0x2,%ah
80103b98:	75 40                	jne    80103bda <sched+0x7a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b9a:	e8 c1 fb ff ff       	call   80103760 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b9f:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103ba2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103ba8:	e8 b3 fb ff ff       	call   80103760 <mycpu>
80103bad:	8b 40 04             	mov    0x4(%eax),%eax
80103bb0:	89 1c 24             	mov    %ebx,(%esp)
80103bb3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bb7:	e8 7f 0a 00 00       	call   8010463b <swtch>
  mycpu()->intena = intena;
80103bbc:	e8 9f fb ff ff       	call   80103760 <mycpu>
80103bc1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bc7:	83 c4 10             	add    $0x10,%esp
80103bca:	5b                   	pop    %ebx
80103bcb:	5e                   	pop    %esi
80103bcc:	5d                   	pop    %ebp
80103bcd:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103bce:	c7 04 24 d0 72 10 80 	movl   $0x801072d0,(%esp)
80103bd5:	e8 86 c7 ff ff       	call   80100360 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103bda:	c7 04 24 fc 72 10 80 	movl   $0x801072fc,(%esp)
80103be1:	e8 7a c7 ff ff       	call   80100360 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103be6:	c7 04 24 ee 72 10 80 	movl   $0x801072ee,(%esp)
80103bed:	e8 6e c7 ff ff       	call   80100360 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103bf2:	c7 04 24 e2 72 10 80 	movl   $0x801072e2,(%esp)
80103bf9:	e8 62 c7 ff ff       	call   80100360 <panic>
80103bfe:	66 90                	xchg   %ax,%ax

80103c00 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	56                   	push   %esi
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103c04:	31 f6                	xor    %esi,%esi
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c06:	53                   	push   %ebx
80103c07:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103c0a:	e8 f1 fb ff ff       	call   80103800 <myproc>
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103c0f:	3b 05 d8 a5 10 80    	cmp    0x8010a5d8,%eax
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
80103c15:	89 c3                	mov    %eax,%ebx
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103c17:	0f 84 ea 00 00 00    	je     80103d07 <exit+0x107>
80103c1d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103c20:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c24:	85 c0                	test   %eax,%eax
80103c26:	74 10                	je     80103c38 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103c28:	89 04 24             	mov    %eax,(%esp)
80103c2b:	e8 60 d3 ff ff       	call   80100f90 <fileclose>
      curproc->ofile[fd] = 0;
80103c30:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103c37:	00 

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103c38:	83 c6 01             	add    $0x1,%esi
80103c3b:	83 fe 10             	cmp    $0x10,%esi
80103c3e:	75 e0                	jne    80103c20 <exit+0x20>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c40:	e8 2b f0 ff ff       	call   80102c70 <begin_op>
  iput(curproc->cwd);
80103c45:	8b 43 68             	mov    0x68(%ebx),%eax
80103c48:	89 04 24             	mov    %eax,(%esp)
80103c4b:	e8 f0 dc ff ff       	call   80101940 <iput>
  end_op();
80103c50:	e8 8b f0 ff ff       	call   80102ce0 <end_op>
  curproc->cwd = 0;
80103c55:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)

  acquire(&ptable.lock);
80103c5c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103c63:	e8 d8 06 00 00       	call   80104340 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103c68:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c6b:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103c70:	eb 11                	jmp    80103c83 <exit+0x83>
80103c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c78:	83 c2 7c             	add    $0x7c,%edx
80103c7b:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80103c81:	74 1d                	je     80103ca0 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
80103c83:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c87:	75 ef                	jne    80103c78 <exit+0x78>
80103c89:	3b 42 20             	cmp    0x20(%edx),%eax
80103c8c:	75 ea                	jne    80103c78 <exit+0x78>
      p->state = RUNNABLE;
80103c8e:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c95:	83 c2 7c             	add    $0x7c,%edx
80103c98:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80103c9e:	75 e3                	jne    80103c83 <exit+0x83>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103ca0:	a1 d8 a5 10 80       	mov    0x8010a5d8,%eax
80103ca5:	b9 74 2d 11 80       	mov    $0x80112d74,%ecx
80103caa:	eb 0f                	jmp    80103cbb <exit+0xbb>
80103cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cb0:	83 c1 7c             	add    $0x7c,%ecx
80103cb3:	81 f9 74 4c 11 80    	cmp    $0x80114c74,%ecx
80103cb9:	74 34                	je     80103cef <exit+0xef>
    if(p->parent == curproc){
80103cbb:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103cbe:	75 f0                	jne    80103cb0 <exit+0xb0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103cc0:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103cc4:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103cc7:	75 e7                	jne    80103cb0 <exit+0xb0>
80103cc9:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103cce:	eb 0b                	jmp    80103cdb <exit+0xdb>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cd0:	83 c2 7c             	add    $0x7c,%edx
80103cd3:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80103cd9:	74 d5                	je     80103cb0 <exit+0xb0>
    if(p->state == SLEEPING && p->chan == chan)
80103cdb:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103cdf:	75 ef                	jne    80103cd0 <exit+0xd0>
80103ce1:	3b 42 20             	cmp    0x20(%edx),%eax
80103ce4:	75 ea                	jne    80103cd0 <exit+0xd0>
      p->state = RUNNABLE;
80103ce6:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103ced:	eb e1                	jmp    80103cd0 <exit+0xd0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103cef:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103cf6:	e8 65 fe ff ff       	call   80103b60 <sched>
  panic("zombie exit");
80103cfb:	c7 04 24 1d 73 10 80 	movl   $0x8010731d,(%esp)
80103d02:	e8 59 c6 ff ff       	call   80100360 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103d07:	c7 04 24 10 73 10 80 	movl   $0x80107310,(%esp)
80103d0e:	e8 4d c6 ff ff       	call   80100360 <panic>
80103d13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d20 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d26:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103d2d:	e8 0e 06 00 00       	call   80104340 <acquire>
  myproc()->state = RUNNABLE;
80103d32:	e8 c9 fa ff ff       	call   80103800 <myproc>
80103d37:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103d3e:	e8 1d fe ff ff       	call   80103b60 <sched>
  release(&ptable.lock);
80103d43:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103d4a:	e8 61 06 00 00       	call   801043b0 <release>
}
80103d4f:	c9                   	leave  
80103d50:	c3                   	ret    
80103d51:	eb 0d                	jmp    80103d60 <sleep>
80103d53:	90                   	nop
80103d54:	90                   	nop
80103d55:	90                   	nop
80103d56:	90                   	nop
80103d57:	90                   	nop
80103d58:	90                   	nop
80103d59:	90                   	nop
80103d5a:	90                   	nop
80103d5b:	90                   	nop
80103d5c:	90                   	nop
80103d5d:	90                   	nop
80103d5e:	90                   	nop
80103d5f:	90                   	nop

80103d60 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	57                   	push   %edi
80103d64:	56                   	push   %esi
80103d65:	53                   	push   %ebx
80103d66:	83 ec 1c             	sub    $0x1c,%esp
80103d69:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103d6f:	e8 8c fa ff ff       	call   80103800 <myproc>
  
  if(p == 0)
80103d74:	85 c0                	test   %eax,%eax
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
80103d76:	89 c3                	mov    %eax,%ebx
  
  if(p == 0)
80103d78:	0f 84 7c 00 00 00    	je     80103dfa <sleep+0x9a>
    panic("sleep");

  if(lk == 0)
80103d7e:	85 f6                	test   %esi,%esi
80103d80:	74 6c                	je     80103dee <sleep+0x8e>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103d82:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80103d88:	74 46                	je     80103dd0 <sleep+0x70>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103d8a:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103d91:	e8 aa 05 00 00       	call   80104340 <acquire>
    release(lk);
80103d96:	89 34 24             	mov    %esi,(%esp)
80103d99:	e8 12 06 00 00       	call   801043b0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103d9e:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103da1:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103da8:	e8 b3 fd ff ff       	call   80103b60 <sched>

  // Tidy up.
  p->chan = 0;
80103dad:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103db4:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103dbb:	e8 f0 05 00 00       	call   801043b0 <release>
    acquire(lk);
80103dc0:	89 75 08             	mov    %esi,0x8(%ebp)
  }
}
80103dc3:	83 c4 1c             	add    $0x1c,%esp
80103dc6:	5b                   	pop    %ebx
80103dc7:	5e                   	pop    %esi
80103dc8:	5f                   	pop    %edi
80103dc9:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103dca:	e9 71 05 00 00       	jmp    80104340 <acquire>
80103dcf:	90                   	nop
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103dd0:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103dd3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
80103dda:	e8 81 fd ff ff       	call   80103b60 <sched>

  // Tidy up.
  p->chan = 0;
80103ddf:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103de6:	83 c4 1c             	add    $0x1c,%esp
80103de9:	5b                   	pop    %ebx
80103dea:	5e                   	pop    %esi
80103deb:	5f                   	pop    %edi
80103dec:	5d                   	pop    %ebp
80103ded:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103dee:	c7 04 24 2f 73 10 80 	movl   $0x8010732f,(%esp)
80103df5:	e8 66 c5 ff ff       	call   80100360 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103dfa:	c7 04 24 29 73 10 80 	movl   $0x80107329,(%esp)
80103e01:	e8 5a c5 ff ff       	call   80100360 <panic>
80103e06:	8d 76 00             	lea    0x0(%esi),%esi
80103e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e10 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	56                   	push   %esi
80103e14:	53                   	push   %ebx
80103e15:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103e18:	e8 e3 f9 ff ff       	call   80103800 <myproc>
  
  acquire(&ptable.lock);
80103e1d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103e24:	89 c6                	mov    %eax,%esi
  
  acquire(&ptable.lock);
80103e26:	e8 15 05 00 00       	call   80104340 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103e2b:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e2d:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80103e32:	eb 0f                	jmp    80103e43 <wait+0x33>
80103e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e38:	83 c3 7c             	add    $0x7c,%ebx
80103e3b:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103e41:	74 1d                	je     80103e60 <wait+0x50>
      if(p->parent != curproc)
80103e43:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e46:	75 f0                	jne    80103e38 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103e48:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e4c:	74 2f                	je     80103e7d <wait+0x6d>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e4e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103e51:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e56:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103e5c:	75 e5                	jne    80103e43 <wait+0x33>
80103e5e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103e60:	85 c0                	test   %eax,%eax
80103e62:	74 6e                	je     80103ed2 <wait+0xc2>
80103e64:	8b 46 24             	mov    0x24(%esi),%eax
80103e67:	85 c0                	test   %eax,%eax
80103e69:	75 67                	jne    80103ed2 <wait+0xc2>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103e6b:	c7 44 24 04 40 2d 11 	movl   $0x80112d40,0x4(%esp)
80103e72:	80 
80103e73:	89 34 24             	mov    %esi,(%esp)
80103e76:	e8 e5 fe ff ff       	call   80103d60 <sleep>
  }
80103e7b:	eb ae                	jmp    80103e2b <wait+0x1b>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103e7d:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103e80:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103e83:	89 04 24             	mov    %eax,(%esp)
80103e86:	e8 d5 e5 ff ff       	call   80102460 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103e8b:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103e8e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103e95:	89 04 24             	mov    %eax,(%esp)
80103e98:	e8 73 2b 00 00       	call   80106a10 <freevm>
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
80103e9d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103ea4:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103eab:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103eb2:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103eb6:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ebd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103ec4:	e8 e7 04 00 00       	call   801043b0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ec9:	83 c4 10             	add    $0x10,%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103ecc:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ece:	5b                   	pop    %ebx
80103ecf:	5e                   	pop    %esi
80103ed0:	5d                   	pop    %ebp
80103ed1:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103ed2:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ed9:	e8 d2 04 00 00       	call   801043b0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ede:	83 c4 10             	add    $0x10,%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80103ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ee6:	5b                   	pop    %ebx
80103ee7:	5e                   	pop    %esi
80103ee8:	5d                   	pop    %ebp
80103ee9:	c3                   	ret    
80103eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ef0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	53                   	push   %ebx
80103ef4:	83 ec 14             	sub    $0x14,%esp
80103ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103efa:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f01:	e8 3a 04 00 00       	call   80104340 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f06:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103f0b:	eb 0d                	jmp    80103f1a <wakeup+0x2a>
80103f0d:	8d 76 00             	lea    0x0(%esi),%esi
80103f10:	83 c0 7c             	add    $0x7c,%eax
80103f13:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103f18:	74 1e                	je     80103f38 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103f1a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f1e:	75 f0                	jne    80103f10 <wakeup+0x20>
80103f20:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f23:	75 eb                	jne    80103f10 <wakeup+0x20>
      p->state = RUNNABLE;
80103f25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f2c:	83 c0 7c             	add    $0x7c,%eax
80103f2f:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103f34:	75 e4                	jne    80103f1a <wakeup+0x2a>
80103f36:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f38:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
80103f3f:	83 c4 14             	add    $0x14,%esp
80103f42:	5b                   	pop    %ebx
80103f43:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f44:	e9 67 04 00 00       	jmp    801043b0 <release>
80103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f50 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 14             	sub    $0x14,%esp
80103f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103f5a:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f61:	e8 da 03 00 00       	call   80104340 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f66:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103f6b:	eb 0d                	jmp    80103f7a <kill+0x2a>
80103f6d:	8d 76 00             	lea    0x0(%esi),%esi
80103f70:	83 c0 7c             	add    $0x7c,%eax
80103f73:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103f78:	74 36                	je     80103fb0 <kill+0x60>
    if(p->pid == pid){
80103f7a:	39 58 10             	cmp    %ebx,0x10(%eax)
80103f7d:	75 f1                	jne    80103f70 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f7f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80103f83:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f8a:	74 14                	je     80103fa0 <kill+0x50>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103f8c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f93:	e8 18 04 00 00       	call   801043b0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103f98:	83 c4 14             	add    $0x14,%esp
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
80103f9b:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103f9d:	5b                   	pop    %ebx
80103f9e:	5d                   	pop    %ebp
80103f9f:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103fa0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103fa7:	eb e3                	jmp    80103f8c <kill+0x3c>
80103fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103fb0:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103fb7:	e8 f4 03 00 00       	call   801043b0 <release>
  return -1;
}
80103fbc:	83 c4 14             	add    $0x14,%esp
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
80103fbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103fc4:	5b                   	pop    %ebx
80103fc5:	5d                   	pop    %ebp
80103fc6:	c3                   	ret    
80103fc7:	89 f6                	mov    %esi,%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fd0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	57                   	push   %edi
80103fd4:	56                   	push   %esi
80103fd5:	53                   	push   %ebx
80103fd6:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80103fdb:	83 ec 4c             	sub    $0x4c,%esp
80103fde:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103fe1:	eb 20                	jmp    80104003 <procdump+0x33>
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103fe8:	c7 04 24 b7 76 10 80 	movl   $0x801076b7,(%esp)
80103fef:	e8 2c c7 ff ff       	call   80100720 <cprintf>
80103ff4:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ff7:	81 fb e0 4c 11 80    	cmp    $0x80114ce0,%ebx
80103ffd:	0f 84 8d 00 00 00    	je     80104090 <procdump+0xc0>
    if(p->state == UNUSED)
80104003:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104006:	85 c0                	test   %eax,%eax
80104008:	74 ea                	je     80103ff4 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010400a:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
8010400d:	ba 40 73 10 80       	mov    $0x80107340,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104012:	77 11                	ja     80104025 <procdump+0x55>
80104014:	8b 14 85 a0 73 10 80 	mov    -0x7fef8c60(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010401b:	b8 40 73 10 80       	mov    $0x80107340,%eax
80104020:	85 d2                	test   %edx,%edx
80104022:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104025:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80104028:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010402c:	89 54 24 08          	mov    %edx,0x8(%esp)
80104030:	c7 04 24 44 73 10 80 	movl   $0x80107344,(%esp)
80104037:	89 44 24 04          	mov    %eax,0x4(%esp)
8010403b:	e8 e0 c6 ff ff       	call   80100720 <cprintf>
    if(p->state == SLEEPING){
80104040:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104044:	75 a2                	jne    80103fe8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104046:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104049:	89 44 24 04          	mov    %eax,0x4(%esp)
8010404d:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104050:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104053:	8b 40 0c             	mov    0xc(%eax),%eax
80104056:	83 c0 08             	add    $0x8,%eax
80104059:	89 04 24             	mov    %eax,(%esp)
8010405c:	e8 8f 01 00 00       	call   801041f0 <getcallerpcs>
80104061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104068:	8b 17                	mov    (%edi),%edx
8010406a:	85 d2                	test   %edx,%edx
8010406c:	0f 84 76 ff ff ff    	je     80103fe8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104072:	89 54 24 04          	mov    %edx,0x4(%esp)
80104076:	83 c7 04             	add    $0x4,%edi
80104079:	c7 04 24 81 6d 10 80 	movl   $0x80106d81,(%esp)
80104080:	e8 9b c6 ff ff       	call   80100720 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104085:	39 f7                	cmp    %esi,%edi
80104087:	75 df                	jne    80104068 <procdump+0x98>
80104089:	e9 5a ff ff ff       	jmp    80103fe8 <procdump+0x18>
8010408e:	66 90                	xchg   %ax,%ax
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104090:	83 c4 4c             	add    $0x4c,%esp
80104093:	5b                   	pop    %ebx
80104094:	5e                   	pop    %esi
80104095:	5f                   	pop    %edi
80104096:	5d                   	pop    %ebp
80104097:	c3                   	ret    
80104098:	66 90                	xchg   %ax,%ax
8010409a:	66 90                	xchg   %ax,%ax
8010409c:	66 90                	xchg   %ax,%ax
8010409e:	66 90                	xchg   %ax,%ax

801040a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 14             	sub    $0x14,%esp
801040a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801040aa:	c7 44 24 04 b8 73 10 	movl   $0x801073b8,0x4(%esp)
801040b1:	80 
801040b2:	8d 43 04             	lea    0x4(%ebx),%eax
801040b5:	89 04 24             	mov    %eax,(%esp)
801040b8:	e8 13 01 00 00       	call   801041d0 <initlock>
  lk->name = name;
801040bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801040c0:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801040c6:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801040cd:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801040d0:	83 c4 14             	add    $0x14,%esp
801040d3:	5b                   	pop    %ebx
801040d4:	5d                   	pop    %ebp
801040d5:	c3                   	ret    
801040d6:	8d 76 00             	lea    0x0(%esi),%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	56                   	push   %esi
801040e4:	53                   	push   %ebx
801040e5:	83 ec 10             	sub    $0x10,%esp
801040e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801040eb:	8d 73 04             	lea    0x4(%ebx),%esi
801040ee:	89 34 24             	mov    %esi,(%esp)
801040f1:	e8 4a 02 00 00       	call   80104340 <acquire>
  while (lk->locked) {
801040f6:	8b 13                	mov    (%ebx),%edx
801040f8:	85 d2                	test   %edx,%edx
801040fa:	74 16                	je     80104112 <acquiresleep+0x32>
801040fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104100:	89 74 24 04          	mov    %esi,0x4(%esp)
80104104:	89 1c 24             	mov    %ebx,(%esp)
80104107:	e8 54 fc ff ff       	call   80103d60 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010410c:	8b 03                	mov    (%ebx),%eax
8010410e:	85 c0                	test   %eax,%eax
80104110:	75 ee                	jne    80104100 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104112:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104118:	e8 e3 f6 ff ff       	call   80103800 <myproc>
8010411d:	8b 40 10             	mov    0x10(%eax),%eax
80104120:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104123:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104126:	83 c4 10             	add    $0x10,%esp
80104129:	5b                   	pop    %ebx
8010412a:	5e                   	pop    %esi
8010412b:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010412c:	e9 7f 02 00 00       	jmp    801043b0 <release>
80104131:	eb 0d                	jmp    80104140 <releasesleep>
80104133:	90                   	nop
80104134:	90                   	nop
80104135:	90                   	nop
80104136:	90                   	nop
80104137:	90                   	nop
80104138:	90                   	nop
80104139:	90                   	nop
8010413a:	90                   	nop
8010413b:	90                   	nop
8010413c:	90                   	nop
8010413d:	90                   	nop
8010413e:	90                   	nop
8010413f:	90                   	nop

80104140 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	56                   	push   %esi
80104144:	53                   	push   %ebx
80104145:	83 ec 10             	sub    $0x10,%esp
80104148:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010414b:	8d 73 04             	lea    0x4(%ebx),%esi
8010414e:	89 34 24             	mov    %esi,(%esp)
80104151:	e8 ea 01 00 00       	call   80104340 <acquire>
  lk->locked = 0;
80104156:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010415c:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104163:	89 1c 24             	mov    %ebx,(%esp)
80104166:	e8 85 fd ff ff       	call   80103ef0 <wakeup>
  release(&lk->lk);
8010416b:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010416e:	83 c4 10             	add    $0x10,%esp
80104171:	5b                   	pop    %ebx
80104172:	5e                   	pop    %esi
80104173:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104174:	e9 37 02 00 00       	jmp    801043b0 <release>
80104179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104180 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	57                   	push   %edi
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
80104184:	31 ff                	xor    %edi,%edi
  release(&lk->lk);
}

int
holdingsleep(struct sleeplock *lk)
{
80104186:	56                   	push   %esi
80104187:	53                   	push   %ebx
80104188:	83 ec 1c             	sub    $0x1c,%esp
8010418b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010418e:	8d 73 04             	lea    0x4(%ebx),%esi
80104191:	89 34 24             	mov    %esi,(%esp)
80104194:	e8 a7 01 00 00       	call   80104340 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104199:	8b 03                	mov    (%ebx),%eax
8010419b:	85 c0                	test   %eax,%eax
8010419d:	74 13                	je     801041b2 <holdingsleep+0x32>
8010419f:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801041a2:	e8 59 f6 ff ff       	call   80103800 <myproc>
801041a7:	3b 58 10             	cmp    0x10(%eax),%ebx
801041aa:	0f 94 c0             	sete   %al
801041ad:	0f b6 c0             	movzbl %al,%eax
801041b0:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801041b2:	89 34 24             	mov    %esi,(%esp)
801041b5:	e8 f6 01 00 00       	call   801043b0 <release>
  return r;
}
801041ba:	83 c4 1c             	add    $0x1c,%esp
801041bd:	89 f8                	mov    %edi,%eax
801041bf:	5b                   	pop    %ebx
801041c0:	5e                   	pop    %esi
801041c1:	5f                   	pop    %edi
801041c2:	5d                   	pop    %ebp
801041c3:	c3                   	ret    
801041c4:	66 90                	xchg   %ax,%ax
801041c6:	66 90                	xchg   %ax,%ax
801041c8:	66 90                	xchg   %ax,%ax
801041ca:	66 90                	xchg   %ax,%ax
801041cc:	66 90                	xchg   %ax,%ax
801041ce:	66 90                	xchg   %ax,%ax

801041d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801041d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801041d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801041df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801041e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801041e9:	5d                   	pop    %ebp
801041ea:	c3                   	ret    
801041eb:	90                   	nop
801041ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801041f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801041f3:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801041f6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801041f9:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801041fa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801041fd:	31 c0                	xor    %eax,%eax
801041ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104200:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104206:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010420c:	77 1a                	ja     80104228 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010420e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104211:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104214:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104217:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104219:	83 f8 0a             	cmp    $0xa,%eax
8010421c:	75 e2                	jne    80104200 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010421e:	5b                   	pop    %ebx
8010421f:	5d                   	pop    %ebp
80104220:	c3                   	ret    
80104221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104228:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010422f:	83 c0 01             	add    $0x1,%eax
80104232:	83 f8 0a             	cmp    $0xa,%eax
80104235:	74 e7                	je     8010421e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104237:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010423e:	83 c0 01             	add    $0x1,%eax
80104241:	83 f8 0a             	cmp    $0xa,%eax
80104244:	75 e2                	jne    80104228 <getcallerpcs+0x38>
80104246:	eb d6                	jmp    8010421e <getcallerpcs+0x2e>
80104248:	90                   	nop
80104249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104250 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	53                   	push   %ebx
80104254:	83 ec 04             	sub    $0x4,%esp
80104257:	9c                   	pushf  
80104258:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104259:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010425a:	e8 01 f5 ff ff       	call   80103760 <mycpu>
8010425f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104265:	85 c0                	test   %eax,%eax
80104267:	75 11                	jne    8010427a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104269:	e8 f2 f4 ff ff       	call   80103760 <mycpu>
8010426e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104274:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010427a:	e8 e1 f4 ff ff       	call   80103760 <mycpu>
8010427f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104286:	83 c4 04             	add    $0x4,%esp
80104289:	5b                   	pop    %ebx
8010428a:	5d                   	pop    %ebp
8010428b:	c3                   	ret    
8010428c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104290 <popcli>:

void
popcli(void)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104296:	9c                   	pushf  
80104297:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104298:	f6 c4 02             	test   $0x2,%ah
8010429b:	75 49                	jne    801042e6 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010429d:	e8 be f4 ff ff       	call   80103760 <mycpu>
801042a2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801042a8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801042ab:	85 d2                	test   %edx,%edx
801042ad:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801042b3:	78 25                	js     801042da <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801042b5:	e8 a6 f4 ff ff       	call   80103760 <mycpu>
801042ba:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801042c0:	85 d2                	test   %edx,%edx
801042c2:	74 04                	je     801042c8 <popcli+0x38>
    sti();
}
801042c4:	c9                   	leave  
801042c5:	c3                   	ret    
801042c6:	66 90                	xchg   %ax,%ax
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801042c8:	e8 93 f4 ff ff       	call   80103760 <mycpu>
801042cd:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801042d3:	85 c0                	test   %eax,%eax
801042d5:	74 ed                	je     801042c4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801042d7:	fb                   	sti    
    sti();
}
801042d8:	c9                   	leave  
801042d9:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801042da:	c7 04 24 da 73 10 80 	movl   $0x801073da,(%esp)
801042e1:	e8 7a c0 ff ff       	call   80100360 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801042e6:	c7 04 24 c3 73 10 80 	movl   $0x801073c3,(%esp)
801042ed:	e8 6e c0 ff ff       	call   80100360 <panic>
801042f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	56                   	push   %esi
  int r;
  pushcli();
  r = lock->locked && lock->cpu == mycpu();
80104304:	31 f6                	xor    %esi,%esi
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104306:	53                   	push   %ebx
80104307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  pushcli();
8010430a:	e8 41 ff ff ff       	call   80104250 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010430f:	8b 03                	mov    (%ebx),%eax
80104311:	85 c0                	test   %eax,%eax
80104313:	74 12                	je     80104327 <holding+0x27>
80104315:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104318:	e8 43 f4 ff ff       	call   80103760 <mycpu>
8010431d:	39 c3                	cmp    %eax,%ebx
8010431f:	0f 94 c0             	sete   %al
80104322:	0f b6 c0             	movzbl %al,%eax
80104325:	89 c6                	mov    %eax,%esi
  popcli();
80104327:	e8 64 ff ff ff       	call   80104290 <popcli>
  return r;
}
8010432c:	89 f0                	mov    %esi,%eax
8010432e:	5b                   	pop    %ebx
8010432f:	5e                   	pop    %esi
80104330:	5d                   	pop    %ebp
80104331:	c3                   	ret    
80104332:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104340 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104347:	e8 04 ff ff ff       	call   80104250 <pushcli>
  if(holding(lk))
8010434c:	8b 45 08             	mov    0x8(%ebp),%eax
8010434f:	89 04 24             	mov    %eax,(%esp)
80104352:	e8 a9 ff ff ff       	call   80104300 <holding>
80104357:	85 c0                	test   %eax,%eax
80104359:	75 3c                	jne    80104397 <acquire+0x57>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010435b:	b9 01 00 00 00       	mov    $0x1,%ecx
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104360:	8b 55 08             	mov    0x8(%ebp),%edx
80104363:	89 c8                	mov    %ecx,%eax
80104365:	f0 87 02             	lock xchg %eax,(%edx)
80104368:	85 c0                	test   %eax,%eax
8010436a:	75 f4                	jne    80104360 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010436c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104371:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104374:	e8 e7 f3 ff ff       	call   80103760 <mycpu>
80104379:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
8010437c:	8b 45 08             	mov    0x8(%ebp),%eax
8010437f:	83 c0 0c             	add    $0xc,%eax
80104382:	89 44 24 04          	mov    %eax,0x4(%esp)
80104386:	8d 45 08             	lea    0x8(%ebp),%eax
80104389:	89 04 24             	mov    %eax,(%esp)
8010438c:	e8 5f fe ff ff       	call   801041f0 <getcallerpcs>
}
80104391:	83 c4 14             	add    $0x14,%esp
80104394:	5b                   	pop    %ebx
80104395:	5d                   	pop    %ebp
80104396:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104397:	c7 04 24 e1 73 10 80 	movl   $0x801073e1,(%esp)
8010439e:	e8 bd bf ff ff       	call   80100360 <panic>
801043a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043b0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	53                   	push   %ebx
801043b4:	83 ec 14             	sub    $0x14,%esp
801043b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801043ba:	89 1c 24             	mov    %ebx,(%esp)
801043bd:	e8 3e ff ff ff       	call   80104300 <holding>
801043c2:	85 c0                	test   %eax,%eax
801043c4:	74 23                	je     801043e9 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
801043c6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801043cd:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801043d4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801043d9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
801043df:	83 c4 14             	add    $0x14,%esp
801043e2:	5b                   	pop    %ebx
801043e3:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801043e4:	e9 a7 fe ff ff       	jmp    80104290 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801043e9:	c7 04 24 e9 73 10 80 	movl   $0x801073e9,(%esp)
801043f0:	e8 6b bf ff ff       	call   80100360 <panic>
801043f5:	66 90                	xchg   %ax,%ax
801043f7:	66 90                	xchg   %ax,%ax
801043f9:	66 90                	xchg   %ax,%ax
801043fb:	66 90                	xchg   %ax,%ax
801043fd:	66 90                	xchg   %ax,%ax
801043ff:	90                   	nop

80104400 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	8b 55 08             	mov    0x8(%ebp),%edx
80104406:	57                   	push   %edi
80104407:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010440a:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
8010440b:	f6 c2 03             	test   $0x3,%dl
8010440e:	75 05                	jne    80104415 <memset+0x15>
80104410:	f6 c1 03             	test   $0x3,%cl
80104413:	74 13                	je     80104428 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104415:	89 d7                	mov    %edx,%edi
80104417:	8b 45 0c             	mov    0xc(%ebp),%eax
8010441a:	fc                   	cld    
8010441b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010441d:	5b                   	pop    %ebx
8010441e:	89 d0                	mov    %edx,%eax
80104420:	5f                   	pop    %edi
80104421:	5d                   	pop    %ebp
80104422:	c3                   	ret    
80104423:	90                   	nop
80104424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104428:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010442c:	c1 e9 02             	shr    $0x2,%ecx
8010442f:	89 f8                	mov    %edi,%eax
80104431:	89 fb                	mov    %edi,%ebx
80104433:	c1 e0 18             	shl    $0x18,%eax
80104436:	c1 e3 10             	shl    $0x10,%ebx
80104439:	09 d8                	or     %ebx,%eax
8010443b:	09 f8                	or     %edi,%eax
8010443d:	c1 e7 08             	shl    $0x8,%edi
80104440:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80104442:	89 d7                	mov    %edx,%edi
80104444:	fc                   	cld    
80104445:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104447:	5b                   	pop    %ebx
80104448:	89 d0                	mov    %edx,%eax
8010444a:	5f                   	pop    %edi
8010444b:	5d                   	pop    %ebp
8010444c:	c3                   	ret    
8010444d:	8d 76 00             	lea    0x0(%esi),%esi

80104450 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	8b 45 10             	mov    0x10(%ebp),%eax
80104456:	57                   	push   %edi
80104457:	56                   	push   %esi
80104458:	8b 75 0c             	mov    0xc(%ebp),%esi
8010445b:	53                   	push   %ebx
8010445c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010445f:	85 c0                	test   %eax,%eax
80104461:	8d 78 ff             	lea    -0x1(%eax),%edi
80104464:	74 26                	je     8010448c <memcmp+0x3c>
    if(*s1 != *s2)
80104466:	0f b6 03             	movzbl (%ebx),%eax
80104469:	31 d2                	xor    %edx,%edx
8010446b:	0f b6 0e             	movzbl (%esi),%ecx
8010446e:	38 c8                	cmp    %cl,%al
80104470:	74 16                	je     80104488 <memcmp+0x38>
80104472:	eb 24                	jmp    80104498 <memcmp+0x48>
80104474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104478:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
8010447d:	83 c2 01             	add    $0x1,%edx
80104480:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104484:	38 c8                	cmp    %cl,%al
80104486:	75 10                	jne    80104498 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104488:	39 fa                	cmp    %edi,%edx
8010448a:	75 ec                	jne    80104478 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010448c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010448d:	31 c0                	xor    %eax,%eax
}
8010448f:	5e                   	pop    %esi
80104490:	5f                   	pop    %edi
80104491:	5d                   	pop    %ebp
80104492:	c3                   	ret    
80104493:	90                   	nop
80104494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104498:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104499:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010449b:	5e                   	pop    %esi
8010449c:	5f                   	pop    %edi
8010449d:	5d                   	pop    %ebp
8010449e:	c3                   	ret    
8010449f:	90                   	nop

801044a0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	57                   	push   %edi
801044a4:	8b 45 08             	mov    0x8(%ebp),%eax
801044a7:	56                   	push   %esi
801044a8:	8b 75 0c             	mov    0xc(%ebp),%esi
801044ab:	53                   	push   %ebx
801044ac:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801044af:	39 c6                	cmp    %eax,%esi
801044b1:	73 35                	jae    801044e8 <memmove+0x48>
801044b3:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801044b6:	39 c8                	cmp    %ecx,%eax
801044b8:	73 2e                	jae    801044e8 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
801044ba:	85 db                	test   %ebx,%ebx

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
801044bc:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
    while(n-- > 0)
801044bf:	8d 53 ff             	lea    -0x1(%ebx),%edx
801044c2:	74 1b                	je     801044df <memmove+0x3f>
801044c4:	f7 db                	neg    %ebx
801044c6:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
801044c9:	01 fb                	add    %edi,%ebx
801044cb:	90                   	nop
801044cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
801044d0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801044d4:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801044d7:	83 ea 01             	sub    $0x1,%edx
801044da:	83 fa ff             	cmp    $0xffffffff,%edx
801044dd:	75 f1                	jne    801044d0 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801044df:	5b                   	pop    %ebx
801044e0:	5e                   	pop    %esi
801044e1:	5f                   	pop    %edi
801044e2:	5d                   	pop    %ebp
801044e3:	c3                   	ret    
801044e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801044e8:	31 d2                	xor    %edx,%edx
801044ea:	85 db                	test   %ebx,%ebx
801044ec:	74 f1                	je     801044df <memmove+0x3f>
801044ee:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801044f0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801044f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801044f7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801044fa:	39 da                	cmp    %ebx,%edx
801044fc:	75 f2                	jne    801044f0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801044fe:	5b                   	pop    %ebx
801044ff:	5e                   	pop    %esi
80104500:	5f                   	pop    %edi
80104501:	5d                   	pop    %ebp
80104502:	c3                   	ret    
80104503:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104510 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104513:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104514:	e9 87 ff ff ff       	jmp    801044a0 <memmove>
80104519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104520 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	56                   	push   %esi
80104524:	8b 75 10             	mov    0x10(%ebp),%esi
80104527:	53                   	push   %ebx
80104528:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010452b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010452e:	85 f6                	test   %esi,%esi
80104530:	74 30                	je     80104562 <strncmp+0x42>
80104532:	0f b6 01             	movzbl (%ecx),%eax
80104535:	84 c0                	test   %al,%al
80104537:	74 2f                	je     80104568 <strncmp+0x48>
80104539:	0f b6 13             	movzbl (%ebx),%edx
8010453c:	38 d0                	cmp    %dl,%al
8010453e:	75 46                	jne    80104586 <strncmp+0x66>
80104540:	8d 51 01             	lea    0x1(%ecx),%edx
80104543:	01 ce                	add    %ecx,%esi
80104545:	eb 14                	jmp    8010455b <strncmp+0x3b>
80104547:	90                   	nop
80104548:	0f b6 02             	movzbl (%edx),%eax
8010454b:	84 c0                	test   %al,%al
8010454d:	74 31                	je     80104580 <strncmp+0x60>
8010454f:	0f b6 19             	movzbl (%ecx),%ebx
80104552:	83 c2 01             	add    $0x1,%edx
80104555:	38 d8                	cmp    %bl,%al
80104557:	75 17                	jne    80104570 <strncmp+0x50>
    n--, p++, q++;
80104559:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010455b:	39 f2                	cmp    %esi,%edx
    n--, p++, q++;
8010455d:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104560:	75 e6                	jne    80104548 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104562:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80104563:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80104565:	5e                   	pop    %esi
80104566:	5d                   	pop    %ebp
80104567:	c3                   	ret    
80104568:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010456b:	31 c0                	xor    %eax,%eax
8010456d:	8d 76 00             	lea    0x0(%esi),%esi
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104570:	0f b6 d3             	movzbl %bl,%edx
80104573:	29 d0                	sub    %edx,%eax
}
80104575:	5b                   	pop    %ebx
80104576:	5e                   	pop    %esi
80104577:	5d                   	pop    %ebp
80104578:	c3                   	ret    
80104579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104580:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
80104584:	eb ea                	jmp    80104570 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104586:	89 d3                	mov    %edx,%ebx
80104588:	eb e6                	jmp    80104570 <strncmp+0x50>
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104590 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	8b 45 08             	mov    0x8(%ebp),%eax
80104596:	56                   	push   %esi
80104597:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010459a:	53                   	push   %ebx
8010459b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010459e:	89 c2                	mov    %eax,%edx
801045a0:	eb 19                	jmp    801045bb <strncpy+0x2b>
801045a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045a8:	83 c3 01             	add    $0x1,%ebx
801045ab:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801045af:	83 c2 01             	add    $0x1,%edx
801045b2:	84 c9                	test   %cl,%cl
801045b4:	88 4a ff             	mov    %cl,-0x1(%edx)
801045b7:	74 09                	je     801045c2 <strncpy+0x32>
801045b9:	89 f1                	mov    %esi,%ecx
801045bb:	85 c9                	test   %ecx,%ecx
801045bd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801045c0:	7f e6                	jg     801045a8 <strncpy+0x18>
    ;
  while(n-- > 0)
801045c2:	31 c9                	xor    %ecx,%ecx
801045c4:	85 f6                	test   %esi,%esi
801045c6:	7e 0f                	jle    801045d7 <strncpy+0x47>
    *s++ = 0;
801045c8:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801045cc:	89 f3                	mov    %esi,%ebx
801045ce:	83 c1 01             	add    $0x1,%ecx
801045d1:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801045d3:	85 db                	test   %ebx,%ebx
801045d5:	7f f1                	jg     801045c8 <strncpy+0x38>
    *s++ = 0;
  return os;
}
801045d7:	5b                   	pop    %ebx
801045d8:	5e                   	pop    %esi
801045d9:	5d                   	pop    %ebp
801045da:	c3                   	ret    
801045db:	90                   	nop
801045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045e0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045e6:	56                   	push   %esi
801045e7:	8b 45 08             	mov    0x8(%ebp),%eax
801045ea:	53                   	push   %ebx
801045eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801045ee:	85 c9                	test   %ecx,%ecx
801045f0:	7e 26                	jle    80104618 <safestrcpy+0x38>
801045f2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801045f6:	89 c1                	mov    %eax,%ecx
801045f8:	eb 17                	jmp    80104611 <safestrcpy+0x31>
801045fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104600:	83 c2 01             	add    $0x1,%edx
80104603:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104607:	83 c1 01             	add    $0x1,%ecx
8010460a:	84 db                	test   %bl,%bl
8010460c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010460f:	74 04                	je     80104615 <safestrcpy+0x35>
80104611:	39 f2                	cmp    %esi,%edx
80104613:	75 eb                	jne    80104600 <safestrcpy+0x20>
    ;
  *s = 0;
80104615:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104618:	5b                   	pop    %ebx
80104619:	5e                   	pop    %esi
8010461a:	5d                   	pop    %ebp
8010461b:	c3                   	ret    
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104620 <strlen>:

int
strlen(const char *s)
{
80104620:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104621:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104623:	89 e5                	mov    %esp,%ebp
80104625:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104628:	80 3a 00             	cmpb   $0x0,(%edx)
8010462b:	74 0c                	je     80104639 <strlen+0x19>
8010462d:	8d 76 00             	lea    0x0(%esi),%esi
80104630:	83 c0 01             	add    $0x1,%eax
80104633:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104637:	75 f7                	jne    80104630 <strlen+0x10>
    ;
  return n;
}
80104639:	5d                   	pop    %ebp
8010463a:	c3                   	ret    

8010463b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010463b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010463f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104643:	55                   	push   %ebp
  pushl %ebx
80104644:	53                   	push   %ebx
  pushl %esi
80104645:	56                   	push   %esi
  pushl %edi
80104646:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104647:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104649:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010464b:	5f                   	pop    %edi
  popl %esi
8010464c:	5e                   	pop    %esi
  popl %ebx
8010464d:	5b                   	pop    %ebx
  popl %ebp
8010464e:	5d                   	pop    %ebp
  ret
8010464f:	c3                   	ret    

80104650 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	53                   	push   %ebx
80104654:	83 ec 04             	sub    $0x4,%esp
80104657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010465a:	e8 a1 f1 ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010465f:	8b 00                	mov    (%eax),%eax
80104661:	39 d8                	cmp    %ebx,%eax
80104663:	76 1b                	jbe    80104680 <fetchint+0x30>
80104665:	8d 53 04             	lea    0x4(%ebx),%edx
80104668:	39 d0                	cmp    %edx,%eax
8010466a:	72 14                	jb     80104680 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010466c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010466f:	8b 13                	mov    (%ebx),%edx
80104671:	89 10                	mov    %edx,(%eax)
  return 0;
80104673:	31 c0                	xor    %eax,%eax
}
80104675:	83 c4 04             	add    $0x4,%esp
80104678:	5b                   	pop    %ebx
80104679:	5d                   	pop    %ebp
8010467a:	c3                   	ret    
8010467b:	90                   	nop
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104685:	eb ee                	jmp    80104675 <fetchint+0x25>
80104687:	89 f6                	mov    %esi,%esi
80104689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104690 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 04             	sub    $0x4,%esp
80104697:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010469a:	e8 61 f1 ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz)
8010469f:	39 18                	cmp    %ebx,(%eax)
801046a1:	76 26                	jbe    801046c9 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
801046a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801046a6:	89 da                	mov    %ebx,%edx
801046a8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801046aa:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801046ac:	39 c3                	cmp    %eax,%ebx
801046ae:	73 19                	jae    801046c9 <fetchstr+0x39>
    if(*s == 0)
801046b0:	80 3b 00             	cmpb   $0x0,(%ebx)
801046b3:	75 0d                	jne    801046c2 <fetchstr+0x32>
801046b5:	eb 21                	jmp    801046d8 <fetchstr+0x48>
801046b7:	90                   	nop
801046b8:	80 3a 00             	cmpb   $0x0,(%edx)
801046bb:	90                   	nop
801046bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c0:	74 16                	je     801046d8 <fetchstr+0x48>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801046c2:	83 c2 01             	add    $0x1,%edx
801046c5:	39 d0                	cmp    %edx,%eax
801046c7:	77 ef                	ja     801046b8 <fetchstr+0x28>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801046c9:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801046cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801046d1:	5b                   	pop    %ebx
801046d2:	5d                   	pop    %ebp
801046d3:	c3                   	ret    
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046d8:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801046db:	89 d0                	mov    %edx,%eax
801046dd:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801046df:	5b                   	pop    %ebx
801046e0:	5d                   	pop    %ebp
801046e1:	c3                   	ret    
801046e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046f0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	8b 75 0c             	mov    0xc(%ebp),%esi
801046f7:	53                   	push   %ebx
801046f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801046fb:	e8 00 f1 ff ff       	call   80103800 <myproc>
80104700:	89 75 0c             	mov    %esi,0xc(%ebp)
80104703:	8b 40 18             	mov    0x18(%eax),%eax
80104706:	8b 40 44             	mov    0x44(%eax),%eax
80104709:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
8010470d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80104710:	5b                   	pop    %ebx
80104711:	5e                   	pop    %esi
80104712:	5d                   	pop    %ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104713:	e9 38 ff ff ff       	jmp    80104650 <fetchint>
80104718:	90                   	nop
80104719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104720 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	83 ec 20             	sub    $0x20,%esp
80104728:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010472b:	e8 d0 f0 ff ff       	call   80103800 <myproc>
80104730:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104732:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104735:	89 44 24 04          	mov    %eax,0x4(%esp)
80104739:	8b 45 08             	mov    0x8(%ebp),%eax
8010473c:	89 04 24             	mov    %eax,(%esp)
8010473f:	e8 ac ff ff ff       	call   801046f0 <argint>
80104744:	85 c0                	test   %eax,%eax
80104746:	78 28                	js     80104770 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104748:	85 db                	test   %ebx,%ebx
8010474a:	78 24                	js     80104770 <argptr+0x50>
8010474c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010474f:	8b 06                	mov    (%esi),%eax
80104751:	39 c2                	cmp    %eax,%edx
80104753:	73 1b                	jae    80104770 <argptr+0x50>
80104755:	01 d3                	add    %edx,%ebx
80104757:	39 d8                	cmp    %ebx,%eax
80104759:	72 15                	jb     80104770 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010475b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010475e:	89 10                	mov    %edx,(%eax)
  return 0;
}
80104760:	83 c4 20             	add    $0x20,%esp
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
80104763:	31 c0                	xor    %eax,%eax
}
80104765:	5b                   	pop    %ebx
80104766:	5e                   	pop    %esi
80104767:	5d                   	pop    %ebp
80104768:	c3                   	ret    
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104770:	83 c4 20             	add    $0x20,%esp
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
80104773:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}
80104778:	5b                   	pop    %ebx
80104779:	5e                   	pop    %esi
8010477a:	5d                   	pop    %ebp
8010477b:	c3                   	ret    
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104780 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104786:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104789:	89 44 24 04          	mov    %eax,0x4(%esp)
8010478d:	8b 45 08             	mov    0x8(%ebp),%eax
80104790:	89 04 24             	mov    %eax,(%esp)
80104793:	e8 58 ff ff ff       	call   801046f0 <argint>
80104798:	85 c0                	test   %eax,%eax
8010479a:	78 14                	js     801047b0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010479c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010479f:	89 44 24 04          	mov    %eax,0x4(%esp)
801047a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047a6:	89 04 24             	mov    %eax,(%esp)
801047a9:	e8 e2 fe ff ff       	call   80104690 <fetchstr>
}
801047ae:	c9                   	leave  
801047af:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801047b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801047b5:	c9                   	leave  
801047b6:	c3                   	ret    
801047b7:	89 f6                	mov    %esi,%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
801047c5:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
801047c8:	e8 33 f0 ff ff       	call   80103800 <myproc>

  num = curproc->tf->eax;
801047cd:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
801047d0:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801047d2:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801047d5:	8d 50 ff             	lea    -0x1(%eax),%edx
801047d8:	83 fa 14             	cmp    $0x14,%edx
801047db:	77 1b                	ja     801047f8 <syscall+0x38>
801047dd:	8b 14 85 20 74 10 80 	mov    -0x7fef8be0(,%eax,4),%edx
801047e4:	85 d2                	test   %edx,%edx
801047e6:	74 10                	je     801047f8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801047e8:	ff d2                	call   *%edx
801047ea:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801047ed:	83 c4 10             	add    $0x10,%esp
801047f0:	5b                   	pop    %ebx
801047f1:	5e                   	pop    %esi
801047f2:	5d                   	pop    %ebp
801047f3:	c3                   	ret    
801047f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801047f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
801047fc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801047ff:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104803:	8b 43 10             	mov    0x10(%ebx),%eax
80104806:	c7 04 24 f1 73 10 80 	movl   $0x801073f1,(%esp)
8010480d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104811:	e8 0a bf ff ff       	call   80100720 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104816:	8b 43 18             	mov    0x18(%ebx),%eax
80104819:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104820:	83 c4 10             	add    $0x10,%esp
80104823:	5b                   	pop    %ebx
80104824:	5e                   	pop    %esi
80104825:	5d                   	pop    %ebp
80104826:	c3                   	ret    
80104827:	66 90                	xchg   %ax,%ax
80104829:	66 90                	xchg   %ax,%ax
8010482b:	66 90                	xchg   %ax,%ax
8010482d:	66 90                	xchg   %ax,%ax
8010482f:	90                   	nop

80104830 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	89 c3                	mov    %eax,%ebx
80104836:	83 ec 04             	sub    $0x4,%esp
  int fd;
  struct proc *curproc = myproc();
80104839:	e8 c2 ef ff ff       	call   80103800 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
8010483e:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
80104840:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104844:	85 c9                	test   %ecx,%ecx
80104846:	74 18                	je     80104860 <fdalloc+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104848:	83 c2 01             	add    $0x1,%edx
8010484b:	83 fa 10             	cmp    $0x10,%edx
8010484e:	75 f0                	jne    80104840 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
80104850:	83 c4 04             	add    $0x4,%esp
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80104853:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104858:	5b                   	pop    %ebx
80104859:	5d                   	pop    %ebp
8010485a:	c3                   	ret    
8010485b:	90                   	nop
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104860:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
      return fd;
    }
  }
  return -1;
}
80104864:	83 c4 04             	add    $0x4,%esp
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
80104867:	89 d0                	mov    %edx,%eax
    }
  }
  return -1;
}
80104869:	5b                   	pop    %ebx
8010486a:	5d                   	pop    %ebp
8010486b:	c3                   	ret    
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104870 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	57                   	push   %edi
80104874:	56                   	push   %esi
80104875:	53                   	push   %ebx
80104876:	83 ec 4c             	sub    $0x4c,%esp
80104879:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010487c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010487f:	8d 5d da             	lea    -0x26(%ebp),%ebx
80104882:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104886:	89 04 24             	mov    %eax,(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104889:	89 55 c4             	mov    %edx,-0x3c(%ebp)
8010488c:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010488f:	e8 fc d7 ff ff       	call   80102090 <nameiparent>
80104894:	85 c0                	test   %eax,%eax
80104896:	89 c7                	mov    %eax,%edi
80104898:	0f 84 da 00 00 00    	je     80104978 <create+0x108>
    return 0;
  ilock(dp);
8010489e:	89 04 24             	mov    %eax,(%esp)
801048a1:	e8 7a cf ff ff       	call   80101820 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801048a6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801048a9:	89 44 24 08          	mov    %eax,0x8(%esp)
801048ad:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801048b1:	89 3c 24             	mov    %edi,(%esp)
801048b4:	e8 77 d4 ff ff       	call   80101d30 <dirlookup>
801048b9:	85 c0                	test   %eax,%eax
801048bb:	89 c6                	mov    %eax,%esi
801048bd:	74 41                	je     80104900 <create+0x90>
    iunlockput(dp);
801048bf:	89 3c 24             	mov    %edi,(%esp)
801048c2:	e8 b9 d1 ff ff       	call   80101a80 <iunlockput>
    ilock(ip);
801048c7:	89 34 24             	mov    %esi,(%esp)
801048ca:	e8 51 cf ff ff       	call   80101820 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801048cf:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801048d4:	75 12                	jne    801048e8 <create+0x78>
801048d6:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801048db:	89 f0                	mov    %esi,%eax
801048dd:	75 09                	jne    801048e8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801048df:	83 c4 4c             	add    $0x4c,%esp
801048e2:	5b                   	pop    %ebx
801048e3:	5e                   	pop    %esi
801048e4:	5f                   	pop    %edi
801048e5:	5d                   	pop    %ebp
801048e6:	c3                   	ret    
801048e7:	90                   	nop
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
801048e8:	89 34 24             	mov    %esi,(%esp)
801048eb:	e8 90 d1 ff ff       	call   80101a80 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801048f0:	83 c4 4c             	add    $0x4c,%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
801048f3:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801048f5:	5b                   	pop    %ebx
801048f6:	5e                   	pop    %esi
801048f7:	5f                   	pop    %edi
801048f8:	5d                   	pop    %ebp
801048f9:	c3                   	ret    
801048fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104900:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104903:	89 44 24 04          	mov    %eax,0x4(%esp)
80104907:	8b 07                	mov    (%edi),%eax
80104909:	89 04 24             	mov    %eax,(%esp)
8010490c:	e8 7f cd ff ff       	call   80101690 <ialloc>
80104911:	85 c0                	test   %eax,%eax
80104913:	89 c6                	mov    %eax,%esi
80104915:	0f 84 c0 00 00 00    	je     801049db <create+0x16b>
    panic("create: ialloc");

  ilock(ip);
8010491b:	89 04 24             	mov    %eax,(%esp)
8010491e:	e8 fd ce ff ff       	call   80101820 <ilock>
  ip->major = major;
80104923:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104927:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010492b:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
8010492f:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104933:	b8 01 00 00 00       	mov    $0x1,%eax
80104938:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010493c:	89 34 24             	mov    %esi,(%esp)
8010493f:	e8 1c ce ff ff       	call   80101760 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104944:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104949:	74 35                	je     80104980 <create+0x110>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
8010494b:	8b 46 04             	mov    0x4(%esi),%eax
8010494e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104952:	89 3c 24             	mov    %edi,(%esp)
80104955:	89 44 24 08          	mov    %eax,0x8(%esp)
80104959:	e8 32 d6 ff ff       	call   80101f90 <dirlink>
8010495e:	85 c0                	test   %eax,%eax
80104960:	78 6d                	js     801049cf <create+0x15f>
    panic("create: dirlink");

  iunlockput(dp);
80104962:	89 3c 24             	mov    %edi,(%esp)
80104965:	e8 16 d1 ff ff       	call   80101a80 <iunlockput>

  return ip;
}
8010496a:	83 c4 4c             	add    $0x4c,%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
8010496d:	89 f0                	mov    %esi,%eax
}
8010496f:	5b                   	pop    %ebx
80104970:	5e                   	pop    %esi
80104971:	5f                   	pop    %edi
80104972:	5d                   	pop    %ebp
80104973:	c3                   	ret    
80104974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104978:	31 c0                	xor    %eax,%eax
8010497a:	e9 60 ff ff ff       	jmp    801048df <create+0x6f>
8010497f:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104980:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104985:	89 3c 24             	mov    %edi,(%esp)
80104988:	e8 d3 cd ff ff       	call   80101760 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010498d:	8b 46 04             	mov    0x4(%esi),%eax
80104990:	c7 44 24 04 94 74 10 	movl   $0x80107494,0x4(%esp)
80104997:	80 
80104998:	89 34 24             	mov    %esi,(%esp)
8010499b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010499f:	e8 ec d5 ff ff       	call   80101f90 <dirlink>
801049a4:	85 c0                	test   %eax,%eax
801049a6:	78 1b                	js     801049c3 <create+0x153>
801049a8:	8b 47 04             	mov    0x4(%edi),%eax
801049ab:	c7 44 24 04 93 74 10 	movl   $0x80107493,0x4(%esp)
801049b2:	80 
801049b3:	89 34 24             	mov    %esi,(%esp)
801049b6:	89 44 24 08          	mov    %eax,0x8(%esp)
801049ba:	e8 d1 d5 ff ff       	call   80101f90 <dirlink>
801049bf:	85 c0                	test   %eax,%eax
801049c1:	79 88                	jns    8010494b <create+0xdb>
      panic("create dots");
801049c3:	c7 04 24 87 74 10 80 	movl   $0x80107487,(%esp)
801049ca:	e8 91 b9 ff ff       	call   80100360 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
801049cf:	c7 04 24 96 74 10 80 	movl   $0x80107496,(%esp)
801049d6:	e8 85 b9 ff ff       	call   80100360 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
801049db:	c7 04 24 78 74 10 80 	movl   $0x80107478,(%esp)
801049e2:	e8 79 b9 ff ff       	call   80100360 <panic>
801049e7:	89 f6                	mov    %esi,%esi
801049e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049f0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	56                   	push   %esi
801049f4:	89 c6                	mov    %eax,%esi
801049f6:	53                   	push   %ebx
801049f7:	89 d3                	mov    %edx,%ebx
801049f9:	83 ec 20             	sub    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801049fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a03:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104a0a:	e8 e1 fc ff ff       	call   801046f0 <argint>
80104a0f:	85 c0                	test   %eax,%eax
80104a11:	78 2d                	js     80104a40 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104a13:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104a17:	77 27                	ja     80104a40 <argfd.constprop.0+0x50>
80104a19:	e8 e2 ed ff ff       	call   80103800 <myproc>
80104a1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a21:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104a25:	85 c0                	test   %eax,%eax
80104a27:	74 17                	je     80104a40 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104a29:	85 f6                	test   %esi,%esi
80104a2b:	74 02                	je     80104a2f <argfd.constprop.0+0x3f>
    *pfd = fd;
80104a2d:	89 16                	mov    %edx,(%esi)
  if(pf)
80104a2f:	85 db                	test   %ebx,%ebx
80104a31:	74 1d                	je     80104a50 <argfd.constprop.0+0x60>
    *pf = f;
80104a33:	89 03                	mov    %eax,(%ebx)
  return 0;
80104a35:	31 c0                	xor    %eax,%eax
}
80104a37:	83 c4 20             	add    $0x20,%esp
80104a3a:	5b                   	pop    %ebx
80104a3b:	5e                   	pop    %esi
80104a3c:	5d                   	pop    %ebp
80104a3d:	c3                   	ret    
80104a3e:	66 90                	xchg   %ax,%ax
80104a40:	83 c4 20             	add    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104a43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104a48:	5b                   	pop    %ebx
80104a49:	5e                   	pop    %esi
80104a4a:	5d                   	pop    %ebp
80104a4b:	c3                   	ret    
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104a50:	31 c0                	xor    %eax,%eax
80104a52:	eb e3                	jmp    80104a37 <argfd.constprop.0+0x47>
80104a54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a60 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104a60:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104a61:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104a63:	89 e5                	mov    %esp,%ebp
80104a65:	53                   	push   %ebx
80104a66:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104a69:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104a6c:	e8 7f ff ff ff       	call   801049f0 <argfd.constprop.0>
80104a71:	85 c0                	test   %eax,%eax
80104a73:	78 23                	js     80104a98 <sys_dup+0x38>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a78:	e8 b3 fd ff ff       	call   80104830 <fdalloc>
80104a7d:	85 c0                	test   %eax,%eax
80104a7f:	89 c3                	mov    %eax,%ebx
80104a81:	78 15                	js     80104a98 <sys_dup+0x38>
    return -1;
  filedup(f);
80104a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a86:	89 04 24             	mov    %eax,(%esp)
80104a89:	e8 b2 c4 ff ff       	call   80100f40 <filedup>
  return fd;
80104a8e:	89 d8                	mov    %ebx,%eax
}
80104a90:	83 c4 24             	add    $0x24,%esp
80104a93:	5b                   	pop    %ebx
80104a94:	5d                   	pop    %ebp
80104a95:	c3                   	ret    
80104a96:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a9d:	eb f1                	jmp    80104a90 <sys_dup+0x30>
80104a9f:	90                   	nop

80104aa0 <sys_read>:
  return fd;
}

int
sys_read(void)
{
80104aa0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104aa1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104aa3:	89 e5                	mov    %esp,%ebp
80104aa5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104aa8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104aab:	e8 40 ff ff ff       	call   801049f0 <argfd.constprop.0>
80104ab0:	85 c0                	test   %eax,%eax
80104ab2:	78 54                	js     80104b08 <sys_read+0x68>
80104ab4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ab7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104abb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104ac2:	e8 29 fc ff ff       	call   801046f0 <argint>
80104ac7:	85 c0                	test   %eax,%eax
80104ac9:	78 3d                	js     80104b08 <sys_read+0x68>
80104acb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ace:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104ad5:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ad9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104adc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ae0:	e8 3b fc ff ff       	call   80104720 <argptr>
80104ae5:	85 c0                	test   %eax,%eax
80104ae7:	78 1f                	js     80104b08 <sys_read+0x68>
    return -1;
  return fileread(f, p, n);
80104ae9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104aec:	89 44 24 08          	mov    %eax,0x8(%esp)
80104af0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104af3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104af7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104afa:	89 04 24             	mov    %eax,(%esp)
80104afd:	e8 9e c5 ff ff       	call   801010a0 <fileread>
}
80104b02:	c9                   	leave  
80104b03:	c3                   	ret    
80104b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104b08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104b0d:	c9                   	leave  
80104b0e:	c3                   	ret    
80104b0f:	90                   	nop

80104b10 <sys_write>:

int
sys_write(void)
{
80104b10:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b11:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104b13:	89 e5                	mov    %esp,%ebp
80104b15:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b18:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104b1b:	e8 d0 fe ff ff       	call   801049f0 <argfd.constprop.0>
80104b20:	85 c0                	test   %eax,%eax
80104b22:	78 54                	js     80104b78 <sys_write+0x68>
80104b24:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b27:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b2b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104b32:	e8 b9 fb ff ff       	call   801046f0 <argint>
80104b37:	85 c0                	test   %eax,%eax
80104b39:	78 3d                	js     80104b78 <sys_write+0x68>
80104b3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b45:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b4c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b50:	e8 cb fb ff ff       	call   80104720 <argptr>
80104b55:	85 c0                	test   %eax,%eax
80104b57:	78 1f                	js     80104b78 <sys_write+0x68>
    return -1;
  return filewrite(f, p, n);
80104b59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b5c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b63:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b67:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b6a:	89 04 24             	mov    %eax,(%esp)
80104b6d:	e8 ce c5 ff ff       	call   80101140 <filewrite>
}
80104b72:	c9                   	leave  
80104b73:	c3                   	ret    
80104b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104b7d:	c9                   	leave  
80104b7e:	c3                   	ret    
80104b7f:	90                   	nop

80104b80 <sys_close>:

int
sys_close(void)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104b86:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104b89:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b8c:	e8 5f fe ff ff       	call   801049f0 <argfd.constprop.0>
80104b91:	85 c0                	test   %eax,%eax
80104b93:	78 23                	js     80104bb8 <sys_close+0x38>
    return -1;
  myproc()->ofile[fd] = 0;
80104b95:	e8 66 ec ff ff       	call   80103800 <myproc>
80104b9a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104b9d:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104ba4:	00 
  fileclose(f);
80104ba5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba8:	89 04 24             	mov    %eax,(%esp)
80104bab:	e8 e0 c3 ff ff       	call   80100f90 <fileclose>
  return 0;
80104bb0:	31 c0                	xor    %eax,%eax
}
80104bb2:	c9                   	leave  
80104bb3:	c3                   	ret    
80104bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104bb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104bbd:	c9                   	leave  
80104bbe:	c3                   	ret    
80104bbf:	90                   	nop

80104bc0 <sys_fstat>:

int
sys_fstat(void)
{
80104bc0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104bc1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104bc3:	89 e5                	mov    %esp,%ebp
80104bc5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104bc8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104bcb:	e8 20 fe ff ff       	call   801049f0 <argfd.constprop.0>
80104bd0:	85 c0                	test   %eax,%eax
80104bd2:	78 34                	js     80104c08 <sys_fstat+0x48>
80104bd4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bd7:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104bde:	00 
80104bdf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104be3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104bea:	e8 31 fb ff ff       	call   80104720 <argptr>
80104bef:	85 c0                	test   %eax,%eax
80104bf1:	78 15                	js     80104c08 <sys_fstat+0x48>
    return -1;
  return filestat(f, st);
80104bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf6:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bfd:	89 04 24             	mov    %eax,(%esp)
80104c00:	e8 4b c4 ff ff       	call   80101050 <filestat>
}
80104c05:	c9                   	leave  
80104c06:	c3                   	ret    
80104c07:	90                   	nop
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104c08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104c0d:	c9                   	leave  
80104c0e:	c3                   	ret    
80104c0f:	90                   	nop

80104c10 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	57                   	push   %edi
80104c14:	56                   	push   %esi
80104c15:	53                   	push   %ebx
80104c16:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104c19:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104c1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104c27:	e8 54 fb ff ff       	call   80104780 <argstr>
80104c2c:	85 c0                	test   %eax,%eax
80104c2e:	0f 88 e6 00 00 00    	js     80104d1a <sys_link+0x10a>
80104c34:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104c37:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c42:	e8 39 fb ff ff       	call   80104780 <argstr>
80104c47:	85 c0                	test   %eax,%eax
80104c49:	0f 88 cb 00 00 00    	js     80104d1a <sys_link+0x10a>
    return -1;

  begin_op();
80104c4f:	e8 1c e0 ff ff       	call   80102c70 <begin_op>
  if((ip = namei(old)) == 0){
80104c54:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104c57:	89 04 24             	mov    %eax,(%esp)
80104c5a:	e8 11 d4 ff ff       	call   80102070 <namei>
80104c5f:	85 c0                	test   %eax,%eax
80104c61:	89 c3                	mov    %eax,%ebx
80104c63:	0f 84 ac 00 00 00    	je     80104d15 <sys_link+0x105>
    end_op();
    return -1;
  }

  ilock(ip);
80104c69:	89 04 24             	mov    %eax,(%esp)
80104c6c:	e8 af cb ff ff       	call   80101820 <ilock>
  if(ip->type == T_DIR){
80104c71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104c76:	0f 84 91 00 00 00    	je     80104d0d <sys_link+0xfd>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104c7c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104c81:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104c84:	89 1c 24             	mov    %ebx,(%esp)
80104c87:	e8 d4 ca ff ff       	call   80101760 <iupdate>
  iunlock(ip);
80104c8c:	89 1c 24             	mov    %ebx,(%esp)
80104c8f:	e8 6c cc ff ff       	call   80101900 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104c94:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104c97:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c9b:	89 04 24             	mov    %eax,(%esp)
80104c9e:	e8 ed d3 ff ff       	call   80102090 <nameiparent>
80104ca3:	85 c0                	test   %eax,%eax
80104ca5:	89 c6                	mov    %eax,%esi
80104ca7:	74 4f                	je     80104cf8 <sys_link+0xe8>
    goto bad;
  ilock(dp);
80104ca9:	89 04 24             	mov    %eax,(%esp)
80104cac:	e8 6f cb ff ff       	call   80101820 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104cb1:	8b 03                	mov    (%ebx),%eax
80104cb3:	39 06                	cmp    %eax,(%esi)
80104cb5:	75 39                	jne    80104cf0 <sys_link+0xe0>
80104cb7:	8b 43 04             	mov    0x4(%ebx),%eax
80104cba:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104cbe:	89 34 24             	mov    %esi,(%esp)
80104cc1:	89 44 24 08          	mov    %eax,0x8(%esp)
80104cc5:	e8 c6 d2 ff ff       	call   80101f90 <dirlink>
80104cca:	85 c0                	test   %eax,%eax
80104ccc:	78 22                	js     80104cf0 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104cce:	89 34 24             	mov    %esi,(%esp)
80104cd1:	e8 aa cd ff ff       	call   80101a80 <iunlockput>
  iput(ip);
80104cd6:	89 1c 24             	mov    %ebx,(%esp)
80104cd9:	e8 62 cc ff ff       	call   80101940 <iput>

  end_op();
80104cde:	e8 fd df ff ff       	call   80102ce0 <end_op>
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104ce3:	83 c4 3c             	add    $0x3c,%esp
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;
80104ce6:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104ce8:	5b                   	pop    %ebx
80104ce9:	5e                   	pop    %esi
80104cea:	5f                   	pop    %edi
80104ceb:	5d                   	pop    %ebp
80104cec:	c3                   	ret    
80104ced:	8d 76 00             	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104cf0:	89 34 24             	mov    %esi,(%esp)
80104cf3:	e8 88 cd ff ff       	call   80101a80 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
80104cf8:	89 1c 24             	mov    %ebx,(%esp)
80104cfb:	e8 20 cb ff ff       	call   80101820 <ilock>
  ip->nlink--;
80104d00:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104d05:	89 1c 24             	mov    %ebx,(%esp)
80104d08:	e8 53 ca ff ff       	call   80101760 <iupdate>
  iunlockput(ip);
80104d0d:	89 1c 24             	mov    %ebx,(%esp)
80104d10:	e8 6b cd ff ff       	call   80101a80 <iunlockput>
  end_op();
80104d15:	e8 c6 df ff ff       	call   80102ce0 <end_op>
  return -1;
}
80104d1a:	83 c4 3c             	add    $0x3c,%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104d1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d22:	5b                   	pop    %ebx
80104d23:	5e                   	pop    %esi
80104d24:	5f                   	pop    %edi
80104d25:	5d                   	pop    %ebp
80104d26:	c3                   	ret    
80104d27:	89 f6                	mov    %esi,%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d30 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	57                   	push   %edi
80104d34:	56                   	push   %esi
80104d35:	53                   	push   %ebx
80104d36:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104d39:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104d3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d40:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104d47:	e8 34 fa ff ff       	call   80104780 <argstr>
80104d4c:	85 c0                	test   %eax,%eax
80104d4e:	0f 88 76 01 00 00    	js     80104eca <sys_unlink+0x19a>
    return -1;

  begin_op();
80104d54:	e8 17 df ff ff       	call   80102c70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104d59:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104d5c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104d5f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d63:	89 04 24             	mov    %eax,(%esp)
80104d66:	e8 25 d3 ff ff       	call   80102090 <nameiparent>
80104d6b:	85 c0                	test   %eax,%eax
80104d6d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104d70:	0f 84 4f 01 00 00    	je     80104ec5 <sys_unlink+0x195>
    end_op();
    return -1;
  }

  ilock(dp);
80104d76:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104d79:	89 34 24             	mov    %esi,(%esp)
80104d7c:	e8 9f ca ff ff       	call   80101820 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104d81:	c7 44 24 04 94 74 10 	movl   $0x80107494,0x4(%esp)
80104d88:	80 
80104d89:	89 1c 24             	mov    %ebx,(%esp)
80104d8c:	e8 6f cf ff ff       	call   80101d00 <namecmp>
80104d91:	85 c0                	test   %eax,%eax
80104d93:	0f 84 21 01 00 00    	je     80104eba <sys_unlink+0x18a>
80104d99:	c7 44 24 04 93 74 10 	movl   $0x80107493,0x4(%esp)
80104da0:	80 
80104da1:	89 1c 24             	mov    %ebx,(%esp)
80104da4:	e8 57 cf ff ff       	call   80101d00 <namecmp>
80104da9:	85 c0                	test   %eax,%eax
80104dab:	0f 84 09 01 00 00    	je     80104eba <sys_unlink+0x18a>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104db1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104db4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104db8:	89 44 24 08          	mov    %eax,0x8(%esp)
80104dbc:	89 34 24             	mov    %esi,(%esp)
80104dbf:	e8 6c cf ff ff       	call   80101d30 <dirlookup>
80104dc4:	85 c0                	test   %eax,%eax
80104dc6:	89 c3                	mov    %eax,%ebx
80104dc8:	0f 84 ec 00 00 00    	je     80104eba <sys_unlink+0x18a>
    goto bad;
  ilock(ip);
80104dce:	89 04 24             	mov    %eax,(%esp)
80104dd1:	e8 4a ca ff ff       	call   80101820 <ilock>

  if(ip->nlink < 1)
80104dd6:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104ddb:	0f 8e 24 01 00 00    	jle    80104f05 <sys_unlink+0x1d5>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104de1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104de6:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104de9:	74 7d                	je     80104e68 <sys_unlink+0x138>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104deb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104df2:	00 
80104df3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104dfa:	00 
80104dfb:	89 34 24             	mov    %esi,(%esp)
80104dfe:	e8 fd f5 ff ff       	call   80104400 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104e03:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104e06:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104e0d:	00 
80104e0e:	89 74 24 04          	mov    %esi,0x4(%esp)
80104e12:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e16:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e19:	89 04 24             	mov    %eax,(%esp)
80104e1c:	e8 af cd ff ff       	call   80101bd0 <writei>
80104e21:	83 f8 10             	cmp    $0x10,%eax
80104e24:	0f 85 cf 00 00 00    	jne    80104ef9 <sys_unlink+0x1c9>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104e2a:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e2f:	0f 84 a3 00 00 00    	je     80104ed8 <sys_unlink+0x1a8>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104e35:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e38:	89 04 24             	mov    %eax,(%esp)
80104e3b:	e8 40 cc ff ff       	call   80101a80 <iunlockput>

  ip->nlink--;
80104e40:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e45:	89 1c 24             	mov    %ebx,(%esp)
80104e48:	e8 13 c9 ff ff       	call   80101760 <iupdate>
  iunlockput(ip);
80104e4d:	89 1c 24             	mov    %ebx,(%esp)
80104e50:	e8 2b cc ff ff       	call   80101a80 <iunlockput>

  end_op();
80104e55:	e8 86 de ff ff       	call   80102ce0 <end_op>

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104e5a:	83 c4 5c             	add    $0x5c,%esp
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;
80104e5d:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104e5f:	5b                   	pop    %ebx
80104e60:	5e                   	pop    %esi
80104e61:	5f                   	pop    %edi
80104e62:	5d                   	pop    %ebp
80104e63:	c3                   	ret    
80104e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104e68:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104e6c:	0f 86 79 ff ff ff    	jbe    80104deb <sys_unlink+0xbb>
80104e72:	bf 20 00 00 00       	mov    $0x20,%edi
80104e77:	eb 15                	jmp    80104e8e <sys_unlink+0x15e>
80104e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e80:	8d 57 10             	lea    0x10(%edi),%edx
80104e83:	3b 53 58             	cmp    0x58(%ebx),%edx
80104e86:	0f 83 5f ff ff ff    	jae    80104deb <sys_unlink+0xbb>
80104e8c:	89 d7                	mov    %edx,%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104e8e:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104e95:	00 
80104e96:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104e9a:	89 74 24 04          	mov    %esi,0x4(%esp)
80104e9e:	89 1c 24             	mov    %ebx,(%esp)
80104ea1:	e8 2a cc ff ff       	call   80101ad0 <readi>
80104ea6:	83 f8 10             	cmp    $0x10,%eax
80104ea9:	75 42                	jne    80104eed <sys_unlink+0x1bd>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104eab:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104eb0:	74 ce                	je     80104e80 <sys_unlink+0x150>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104eb2:	89 1c 24             	mov    %ebx,(%esp)
80104eb5:	e8 c6 cb ff ff       	call   80101a80 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104eba:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104ebd:	89 04 24             	mov    %eax,(%esp)
80104ec0:	e8 bb cb ff ff       	call   80101a80 <iunlockput>
  end_op();
80104ec5:	e8 16 de ff ff       	call   80102ce0 <end_op>
  return -1;
}
80104eca:	83 c4 5c             	add    $0x5c,%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80104ecd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ed2:	5b                   	pop    %ebx
80104ed3:	5e                   	pop    %esi
80104ed4:	5f                   	pop    %edi
80104ed5:	5d                   	pop    %ebp
80104ed6:	c3                   	ret    
80104ed7:	90                   	nop

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104ed8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104edb:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80104ee0:	89 04 24             	mov    %eax,(%esp)
80104ee3:	e8 78 c8 ff ff       	call   80101760 <iupdate>
80104ee8:	e9 48 ff ff ff       	jmp    80104e35 <sys_unlink+0x105>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104eed:	c7 04 24 b8 74 10 80 	movl   $0x801074b8,(%esp)
80104ef4:	e8 67 b4 ff ff       	call   80100360 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104ef9:	c7 04 24 ca 74 10 80 	movl   $0x801074ca,(%esp)
80104f00:	e8 5b b4 ff ff       	call   80100360 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80104f05:	c7 04 24 a6 74 10 80 	movl   $0x801074a6,(%esp)
80104f0c:	e8 4f b4 ff ff       	call   80100360 <panic>
80104f11:	eb 0d                	jmp    80104f20 <sys_open>
80104f13:	90                   	nop
80104f14:	90                   	nop
80104f15:	90                   	nop
80104f16:	90                   	nop
80104f17:	90                   	nop
80104f18:	90                   	nop
80104f19:	90                   	nop
80104f1a:	90                   	nop
80104f1b:	90                   	nop
80104f1c:	90                   	nop
80104f1d:	90                   	nop
80104f1e:	90                   	nop
80104f1f:	90                   	nop

80104f20 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	57                   	push   %edi
80104f24:	56                   	push   %esi
80104f25:	53                   	push   %ebx
80104f26:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104f29:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104f2c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f37:	e8 44 f8 ff ff       	call   80104780 <argstr>
80104f3c:	85 c0                	test   %eax,%eax
80104f3e:	0f 88 d1 00 00 00    	js     80105015 <sys_open+0xf5>
80104f44:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104f47:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f52:	e8 99 f7 ff ff       	call   801046f0 <argint>
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 b6 00 00 00    	js     80105015 <sys_open+0xf5>
    return -1;

  begin_op();
80104f5f:	e8 0c dd ff ff       	call   80102c70 <begin_op>

  if(omode & O_CREATE){
80104f64:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104f68:	0f 85 82 00 00 00    	jne    80104ff0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104f6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f71:	89 04 24             	mov    %eax,(%esp)
80104f74:	e8 f7 d0 ff ff       	call   80102070 <namei>
80104f79:	85 c0                	test   %eax,%eax
80104f7b:	89 c6                	mov    %eax,%esi
80104f7d:	0f 84 8d 00 00 00    	je     80105010 <sys_open+0xf0>
      end_op();
      return -1;
    }
    ilock(ip);
80104f83:	89 04 24             	mov    %eax,(%esp)
80104f86:	e8 95 c8 ff ff       	call   80101820 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104f8b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104f90:	0f 84 92 00 00 00    	je     80105028 <sys_open+0x108>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104f96:	e8 35 bf ff ff       	call   80100ed0 <filealloc>
80104f9b:	85 c0                	test   %eax,%eax
80104f9d:	89 c3                	mov    %eax,%ebx
80104f9f:	0f 84 93 00 00 00    	je     80105038 <sys_open+0x118>
80104fa5:	e8 86 f8 ff ff       	call   80104830 <fdalloc>
80104faa:	85 c0                	test   %eax,%eax
80104fac:	89 c7                	mov    %eax,%edi
80104fae:	0f 88 94 00 00 00    	js     80105048 <sys_open+0x128>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104fb4:	89 34 24             	mov    %esi,(%esp)
80104fb7:	e8 44 c9 ff ff       	call   80101900 <iunlock>
  end_op();
80104fbc:	e8 1f dd ff ff       	call   80102ce0 <end_op>

  f->type = FD_INODE;
80104fc1:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104fc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
80104fca:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80104fcd:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80104fd4:	89 c2                	mov    %eax,%edx
80104fd6:	83 e2 01             	and    $0x1,%edx
80104fd9:	83 f2 01             	xor    $0x1,%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104fdc:	a8 03                	test   $0x3,%al
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104fde:	88 53 08             	mov    %dl,0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
80104fe1:	89 f8                	mov    %edi,%eax

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104fe3:	0f 95 43 09          	setne  0x9(%ebx)
  return fd;
}
80104fe7:	83 c4 2c             	add    $0x2c,%esp
80104fea:	5b                   	pop    %ebx
80104feb:	5e                   	pop    %esi
80104fec:	5f                   	pop    %edi
80104fed:	5d                   	pop    %ebp
80104fee:	c3                   	ret    
80104fef:	90                   	nop
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104ff0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ff3:	31 c9                	xor    %ecx,%ecx
80104ff5:	ba 02 00 00 00       	mov    $0x2,%edx
80104ffa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105001:	e8 6a f8 ff ff       	call   80104870 <create>
    if(ip == 0){
80105006:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105008:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010500a:	75 8a                	jne    80104f96 <sys_open+0x76>
8010500c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
80105010:	e8 cb dc ff ff       	call   80102ce0 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105015:	83 c4 2c             	add    $0x2c,%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105018:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010501d:	5b                   	pop    %ebx
8010501e:	5e                   	pop    %esi
8010501f:	5f                   	pop    %edi
80105020:	5d                   	pop    %ebp
80105021:	c3                   	ret    
80105022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105028:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010502b:	85 c0                	test   %eax,%eax
8010502d:	0f 84 63 ff ff ff    	je     80104f96 <sys_open+0x76>
80105033:	90                   	nop
80105034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
80105038:	89 34 24             	mov    %esi,(%esp)
8010503b:	e8 40 ca ff ff       	call   80101a80 <iunlockput>
80105040:	eb ce                	jmp    80105010 <sys_open+0xf0>
80105042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105048:	89 1c 24             	mov    %ebx,(%esp)
8010504b:	e8 40 bf ff ff       	call   80100f90 <fileclose>
80105050:	eb e6                	jmp    80105038 <sys_open+0x118>
80105052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105060 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105066:	e8 05 dc ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010506b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010506e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105072:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105079:	e8 02 f7 ff ff       	call   80104780 <argstr>
8010507e:	85 c0                	test   %eax,%eax
80105080:	78 2e                	js     801050b0 <sys_mkdir+0x50>
80105082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105085:	31 c9                	xor    %ecx,%ecx
80105087:	ba 01 00 00 00       	mov    $0x1,%edx
8010508c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105093:	e8 d8 f7 ff ff       	call   80104870 <create>
80105098:	85 c0                	test   %eax,%eax
8010509a:	74 14                	je     801050b0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010509c:	89 04 24             	mov    %eax,(%esp)
8010509f:	e8 dc c9 ff ff       	call   80101a80 <iunlockput>
  end_op();
801050a4:	e8 37 dc ff ff       	call   80102ce0 <end_op>
  return 0;
801050a9:	31 c0                	xor    %eax,%eax
}
801050ab:	c9                   	leave  
801050ac:	c3                   	ret    
801050ad:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801050b0:	e8 2b dc ff ff       	call   80102ce0 <end_op>
    return -1;
801050b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801050ba:	c9                   	leave  
801050bb:	c3                   	ret    
801050bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050c0 <sys_mknod>:

int
sys_mknod(void)
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801050c6:	e8 a5 db ff ff       	call   80102c70 <begin_op>
  if((argstr(0, &path)) < 0 ||
801050cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801050ce:	89 44 24 04          	mov    %eax,0x4(%esp)
801050d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801050d9:	e8 a2 f6 ff ff       	call   80104780 <argstr>
801050de:	85 c0                	test   %eax,%eax
801050e0:	78 5e                	js     80105140 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801050e2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050e5:	89 44 24 04          	mov    %eax,0x4(%esp)
801050e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050f0:	e8 fb f5 ff ff       	call   801046f0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801050f5:	85 c0                	test   %eax,%eax
801050f7:	78 47                	js     80105140 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801050f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050fc:	89 44 24 04          	mov    %eax,0x4(%esp)
80105100:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105107:	e8 e4 f5 ff ff       	call   801046f0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
8010510c:	85 c0                	test   %eax,%eax
8010510e:	78 30                	js     80105140 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105110:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105114:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80105119:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010511d:	89 04 24             	mov    %eax,(%esp)
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105120:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105123:	e8 48 f7 ff ff       	call   80104870 <create>
80105128:	85 c0                	test   %eax,%eax
8010512a:	74 14                	je     80105140 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010512c:	89 04 24             	mov    %eax,(%esp)
8010512f:	e8 4c c9 ff ff       	call   80101a80 <iunlockput>
  end_op();
80105134:	e8 a7 db ff ff       	call   80102ce0 <end_op>
  return 0;
80105139:	31 c0                	xor    %eax,%eax
}
8010513b:	c9                   	leave  
8010513c:	c3                   	ret    
8010513d:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105140:	e8 9b db ff ff       	call   80102ce0 <end_op>
    return -1;
80105145:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010514a:	c9                   	leave  
8010514b:	c3                   	ret    
8010514c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105150 <sys_chdir>:

int
sys_chdir(void)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	56                   	push   %esi
80105154:	53                   	push   %ebx
80105155:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105158:	e8 a3 e6 ff ff       	call   80103800 <myproc>
8010515d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010515f:	e8 0c db ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105164:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105167:	89 44 24 04          	mov    %eax,0x4(%esp)
8010516b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105172:	e8 09 f6 ff ff       	call   80104780 <argstr>
80105177:	85 c0                	test   %eax,%eax
80105179:	78 4a                	js     801051c5 <sys_chdir+0x75>
8010517b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010517e:	89 04 24             	mov    %eax,(%esp)
80105181:	e8 ea ce ff ff       	call   80102070 <namei>
80105186:	85 c0                	test   %eax,%eax
80105188:	89 c3                	mov    %eax,%ebx
8010518a:	74 39                	je     801051c5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010518c:	89 04 24             	mov    %eax,(%esp)
8010518f:	e8 8c c6 ff ff       	call   80101820 <ilock>
  if(ip->type != T_DIR){
80105194:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80105199:	89 1c 24             	mov    %ebx,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
8010519c:	75 22                	jne    801051c0 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010519e:	e8 5d c7 ff ff       	call   80101900 <iunlock>
  iput(curproc->cwd);
801051a3:	8b 46 68             	mov    0x68(%esi),%eax
801051a6:	89 04 24             	mov    %eax,(%esp)
801051a9:	e8 92 c7 ff ff       	call   80101940 <iput>
  end_op();
801051ae:	e8 2d db ff ff       	call   80102ce0 <end_op>
  curproc->cwd = ip;
  return 0;
801051b3:	31 c0                	xor    %eax,%eax
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
801051b5:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
}
801051b8:	83 c4 20             	add    $0x20,%esp
801051bb:	5b                   	pop    %ebx
801051bc:	5e                   	pop    %esi
801051bd:	5d                   	pop    %ebp
801051be:	c3                   	ret    
801051bf:	90                   	nop
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801051c0:	e8 bb c8 ff ff       	call   80101a80 <iunlockput>
    end_op();
801051c5:	e8 16 db ff ff       	call   80102ce0 <end_op>
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
801051ca:	83 c4 20             	add    $0x20,%esp
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
801051cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
801051d2:	5b                   	pop    %ebx
801051d3:	5e                   	pop    %esi
801051d4:	5d                   	pop    %ebp
801051d5:	c3                   	ret    
801051d6:	8d 76 00             	lea    0x0(%esi),%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051e0 <sys_exec>:

int
sys_exec(void)
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	57                   	push   %edi
801051e4:	56                   	push   %esi
801051e5:	53                   	push   %ebx
801051e6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801051ec:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801051f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801051f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051fd:	e8 7e f5 ff ff       	call   80104780 <argstr>
80105202:	85 c0                	test   %eax,%eax
80105204:	0f 88 84 00 00 00    	js     8010528e <sys_exec+0xae>
8010520a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105210:	89 44 24 04          	mov    %eax,0x4(%esp)
80105214:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010521b:	e8 d0 f4 ff ff       	call   801046f0 <argint>
80105220:	85 c0                	test   %eax,%eax
80105222:	78 6a                	js     8010528e <sys_exec+0xae>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105224:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010522a:	31 db                	xor    %ebx,%ebx
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010522c:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80105233:	00 
80105234:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
8010523a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105241:	00 
80105242:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105248:	89 04 24             	mov    %eax,(%esp)
8010524b:	e8 b0 f1 ff ff       	call   80104400 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105250:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105256:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010525a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010525d:	89 04 24             	mov    %eax,(%esp)
80105260:	e8 eb f3 ff ff       	call   80104650 <fetchint>
80105265:	85 c0                	test   %eax,%eax
80105267:	78 25                	js     8010528e <sys_exec+0xae>
      return -1;
    if(uarg == 0){
80105269:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010526f:	85 c0                	test   %eax,%eax
80105271:	74 2d                	je     801052a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105273:	89 74 24 04          	mov    %esi,0x4(%esp)
80105277:	89 04 24             	mov    %eax,(%esp)
8010527a:	e8 11 f4 ff ff       	call   80104690 <fetchstr>
8010527f:	85 c0                	test   %eax,%eax
80105281:	78 0b                	js     8010528e <sys_exec+0xae>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105283:	83 c3 01             	add    $0x1,%ebx
80105286:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80105289:	83 fb 20             	cmp    $0x20,%ebx
8010528c:	75 c2                	jne    80105250 <sys_exec+0x70>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
8010528e:	81 c4 ac 00 00 00    	add    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105294:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105299:	5b                   	pop    %ebx
8010529a:	5e                   	pop    %esi
8010529b:	5f                   	pop    %edi
8010529c:	5d                   	pop    %ebp
8010529d:	c3                   	ret    
8010529e:	66 90                	xchg   %ax,%ax
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801052a0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801052a6:	89 44 24 04          	mov    %eax,0x4(%esp)
801052aa:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801052b0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801052b7:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801052bb:	89 04 24             	mov    %eax,(%esp)
801052be:	e8 3d b8 ff ff       	call   80100b00 <exec>
}
801052c3:	81 c4 ac 00 00 00    	add    $0xac,%esp
801052c9:	5b                   	pop    %ebx
801052ca:	5e                   	pop    %esi
801052cb:	5f                   	pop    %edi
801052cc:	5d                   	pop    %ebp
801052cd:	c3                   	ret    
801052ce:	66 90                	xchg   %ax,%ax

801052d0 <sys_pipe>:

int
sys_pipe(void)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	53                   	push   %ebx
801052d4:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801052d7:	8d 45 ec             	lea    -0x14(%ebp),%eax
801052da:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
801052e1:	00 
801052e2:	89 44 24 04          	mov    %eax,0x4(%esp)
801052e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801052ed:	e8 2e f4 ff ff       	call   80104720 <argptr>
801052f2:	85 c0                	test   %eax,%eax
801052f4:	78 6d                	js     80105363 <sys_pipe+0x93>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801052f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801052fd:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105300:	89 04 24             	mov    %eax,(%esp)
80105303:	e8 c8 df ff ff       	call   801032d0 <pipealloc>
80105308:	85 c0                	test   %eax,%eax
8010530a:	78 57                	js     80105363 <sys_pipe+0x93>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010530c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010530f:	e8 1c f5 ff ff       	call   80104830 <fdalloc>
80105314:	85 c0                	test   %eax,%eax
80105316:	89 c3                	mov    %eax,%ebx
80105318:	78 33                	js     8010534d <sys_pipe+0x7d>
8010531a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010531d:	e8 0e f5 ff ff       	call   80104830 <fdalloc>
80105322:	85 c0                	test   %eax,%eax
80105324:	78 1a                	js     80105340 <sys_pipe+0x70>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105326:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105329:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
8010532b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010532e:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
80105331:	83 c4 24             	add    $0x24,%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105334:	31 c0                	xor    %eax,%eax
}
80105336:	5b                   	pop    %ebx
80105337:	5d                   	pop    %ebp
80105338:	c3                   	ret    
80105339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105340:	e8 bb e4 ff ff       	call   80103800 <myproc>
80105345:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
8010534c:	00 
    fileclose(rf);
8010534d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105350:	89 04 24             	mov    %eax,(%esp)
80105353:	e8 38 bc ff ff       	call   80100f90 <fileclose>
    fileclose(wf);
80105358:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010535b:	89 04 24             	mov    %eax,(%esp)
8010535e:	e8 2d bc ff ff       	call   80100f90 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105363:	83 c4 24             	add    $0x24,%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
80105366:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010536b:	5b                   	pop    %ebx
8010536c:	5d                   	pop    %ebp
8010536d:	c3                   	ret    
8010536e:	66 90                	xchg   %ax,%ax

80105370 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105373:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105374:	e9 37 e6 ff ff       	jmp    801039b0 <fork>
80105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_exit>:
}

int
sys_exit(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 08             	sub    $0x8,%esp
  exit();
80105386:	e8 75 e8 ff ff       	call   80103c00 <exit>
  return 0;  // not reached
}
8010538b:	31 c0                	xor    %eax,%eax
8010538d:	c9                   	leave  
8010538e:	c3                   	ret    
8010538f:	90                   	nop

80105390 <sys_wait>:

int
sys_wait(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105393:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105394:	e9 77 ea ff ff       	jmp    80103e10 <wait>
80105399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053a0 <sys_kill>:
}

int
sys_kill(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801053a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053b4:	e8 37 f3 ff ff       	call   801046f0 <argint>
801053b9:	85 c0                	test   %eax,%eax
801053bb:	78 13                	js     801053d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801053bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053c0:	89 04 24             	mov    %eax,(%esp)
801053c3:	e8 88 eb ff ff       	call   80103f50 <kill>
}
801053c8:	c9                   	leave  
801053c9:	c3                   	ret    
801053ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801053d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801053d5:	c9                   	leave  
801053d6:	c3                   	ret    
801053d7:	89 f6                	mov    %esi,%esi
801053d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053e0 <sys_getpid>:

int
sys_getpid(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801053e6:	e8 15 e4 ff ff       	call   80103800 <myproc>
801053eb:	8b 40 10             	mov    0x10(%eax),%eax
}
801053ee:	c9                   	leave  
801053ef:	c3                   	ret    

801053f0 <sys_sbrk>:

int
sys_sbrk(void)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	53                   	push   %ebx
801053f4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801053f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801053fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105405:	e8 e6 f2 ff ff       	call   801046f0 <argint>
8010540a:	85 c0                	test   %eax,%eax
8010540c:	78 22                	js     80105430 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010540e:	e8 ed e3 ff ff       	call   80103800 <myproc>
  if(growproc(n) < 0)
80105413:	8b 55 f4             	mov    -0xc(%ebp),%edx
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105416:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105418:	89 14 24             	mov    %edx,(%esp)
8010541b:	e8 20 e5 ff ff       	call   80103940 <growproc>
80105420:	85 c0                	test   %eax,%eax
80105422:	78 0c                	js     80105430 <sys_sbrk+0x40>
    return -1;
  return addr;
80105424:	89 d8                	mov    %ebx,%eax
}
80105426:	83 c4 24             	add    $0x24,%esp
80105429:	5b                   	pop    %ebx
8010542a:	5d                   	pop    %ebp
8010542b:	c3                   	ret    
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105430:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105435:	eb ef                	jmp    80105426 <sys_sbrk+0x36>
80105437:	89 f6                	mov    %esi,%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105440 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	53                   	push   %ebx
80105444:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105447:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010544a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010544e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105455:	e8 96 f2 ff ff       	call   801046f0 <argint>
8010545a:	85 c0                	test   %eax,%eax
8010545c:	78 7e                	js     801054dc <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
8010545e:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105465:	e8 d6 ee ff ff       	call   80104340 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010546a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
8010546d:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
  while(ticks - ticks0 < n){
80105473:	85 d2                	test   %edx,%edx
80105475:	75 29                	jne    801054a0 <sys_sleep+0x60>
80105477:	eb 4f                	jmp    801054c8 <sys_sleep+0x88>
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105480:	c7 44 24 04 80 4c 11 	movl   $0x80114c80,0x4(%esp)
80105487:	80 
80105488:	c7 04 24 c0 54 11 80 	movl   $0x801154c0,(%esp)
8010548f:	e8 cc e8 ff ff       	call   80103d60 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105494:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80105499:	29 d8                	sub    %ebx,%eax
8010549b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010549e:	73 28                	jae    801054c8 <sys_sleep+0x88>
    if(myproc()->killed){
801054a0:	e8 5b e3 ff ff       	call   80103800 <myproc>
801054a5:	8b 40 24             	mov    0x24(%eax),%eax
801054a8:	85 c0                	test   %eax,%eax
801054aa:	74 d4                	je     80105480 <sys_sleep+0x40>
      release(&tickslock);
801054ac:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801054b3:	e8 f8 ee ff ff       	call   801043b0 <release>
      return -1;
801054b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801054bd:	83 c4 24             	add    $0x24,%esp
801054c0:	5b                   	pop    %ebx
801054c1:	5d                   	pop    %ebp
801054c2:	c3                   	ret    
801054c3:	90                   	nop
801054c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801054c8:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801054cf:	e8 dc ee ff ff       	call   801043b0 <release>
  return 0;
}
801054d4:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
801054d7:	31 c0                	xor    %eax,%eax
}
801054d9:	5b                   	pop    %ebx
801054da:	5d                   	pop    %ebp
801054db:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801054dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e1:	eb da                	jmp    801054bd <sys_sleep+0x7d>
801054e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	53                   	push   %ebx
801054f4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
801054f7:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801054fe:	e8 3d ee ff ff       	call   80104340 <acquire>
  xticks = ticks;
80105503:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
  release(&tickslock);
80105509:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105510:	e8 9b ee ff ff       	call   801043b0 <release>
  return xticks;
}
80105515:	83 c4 14             	add    $0x14,%esp
80105518:	89 d8                	mov    %ebx,%eax
8010551a:	5b                   	pop    %ebx
8010551b:	5d                   	pop    %ebp
8010551c:	c3                   	ret    

8010551d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010551d:	1e                   	push   %ds
  pushl %es
8010551e:	06                   	push   %es
  pushl %fs
8010551f:	0f a0                	push   %fs
  pushl %gs
80105521:	0f a8                	push   %gs
  pushal
80105523:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105524:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105528:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010552a:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010552c:	54                   	push   %esp
  call trap
8010552d:	e8 de 00 00 00       	call   80105610 <trap>
  addl $4, %esp
80105532:	83 c4 04             	add    $0x4,%esp

80105535 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105535:	61                   	popa   
  popl %gs
80105536:	0f a9                	pop    %gs
  popl %fs
80105538:	0f a1                	pop    %fs
  popl %es
8010553a:	07                   	pop    %es
  popl %ds
8010553b:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010553c:	83 c4 08             	add    $0x8,%esp
  iret
8010553f:	cf                   	iret   

80105540 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105540:	31 c0                	xor    %eax,%eax
80105542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105548:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010554f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105554:	66 89 0c c5 c2 4c 11 	mov    %cx,-0x7feeb33e(,%eax,8)
8010555b:	80 
8010555c:	c6 04 c5 c4 4c 11 80 	movb   $0x0,-0x7feeb33c(,%eax,8)
80105563:	00 
80105564:	c6 04 c5 c5 4c 11 80 	movb   $0x8e,-0x7feeb33b(,%eax,8)
8010556b:	8e 
8010556c:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
80105573:	80 
80105574:	c1 ea 10             	shr    $0x10,%edx
80105577:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
8010557e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010557f:	83 c0 01             	add    $0x1,%eax
80105582:	3d 00 01 00 00       	cmp    $0x100,%eax
80105587:	75 bf                	jne    80105548 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105589:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010558a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010558f:	89 e5                	mov    %esp,%ebp
80105591:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105594:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105599:	c7 44 24 04 d9 74 10 	movl   $0x801074d9,0x4(%esp)
801055a0:	80 
801055a1:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801055a8:	66 89 15 c2 4e 11 80 	mov    %dx,0x80114ec2
801055af:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
801055b5:	c1 e8 10             	shr    $0x10,%eax
801055b8:	c6 05 c4 4e 11 80 00 	movb   $0x0,0x80114ec4
801055bf:	c6 05 c5 4e 11 80 ef 	movb   $0xef,0x80114ec5
801055c6:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6

  initlock(&tickslock, "time");
801055cc:	e8 ff eb ff ff       	call   801041d0 <initlock>
}
801055d1:	c9                   	leave  
801055d2:	c3                   	ret    
801055d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055e0 <idtinit>:

void
idtinit(void)
{
801055e0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801055e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801055e6:	89 e5                	mov    %esp,%ebp
801055e8:	83 ec 10             	sub    $0x10,%esp
801055eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801055ef:	b8 c0 4c 11 80       	mov    $0x80114cc0,%eax
801055f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801055f8:	c1 e8 10             	shr    $0x10,%eax
801055fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801055ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105602:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105605:	c9                   	leave  
80105606:	c3                   	ret    
80105607:	89 f6                	mov    %esi,%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	57                   	push   %edi
80105614:	56                   	push   %esi
80105615:	53                   	push   %ebx
80105616:	83 ec 3c             	sub    $0x3c,%esp
80105619:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010561c:	8b 43 30             	mov    0x30(%ebx),%eax
8010561f:	83 f8 40             	cmp    $0x40,%eax
80105622:	0f 84 a0 01 00 00    	je     801057c8 <trap+0x1b8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105628:	83 e8 20             	sub    $0x20,%eax
8010562b:	83 f8 1f             	cmp    $0x1f,%eax
8010562e:	77 08                	ja     80105638 <trap+0x28>
80105630:	ff 24 85 80 75 10 80 	jmp    *-0x7fef8a80(,%eax,4)
80105637:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105638:	e8 c3 e1 ff ff       	call   80103800 <myproc>
8010563d:	85 c0                	test   %eax,%eax
8010563f:	90                   	nop
80105640:	0f 84 fa 01 00 00    	je     80105840 <trap+0x230>
80105646:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010564a:	0f 84 f0 01 00 00    	je     80105840 <trap+0x230>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105650:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105653:	8b 53 38             	mov    0x38(%ebx),%edx
80105656:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105659:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010565c:	e8 7f e1 ff ff       	call   801037e0 <cpuid>
80105661:	8b 73 30             	mov    0x30(%ebx),%esi
80105664:	89 c7                	mov    %eax,%edi
80105666:	8b 43 34             	mov    0x34(%ebx),%eax
80105669:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010566c:	e8 8f e1 ff ff       	call   80103800 <myproc>
80105671:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105674:	e8 87 e1 ff ff       	call   80103800 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105679:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010567c:	89 74 24 0c          	mov    %esi,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105680:	8b 75 e0             	mov    -0x20(%ebp),%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105683:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105686:	89 7c 24 14          	mov    %edi,0x14(%esp)
8010568a:	89 54 24 18          	mov    %edx,0x18(%esp)
8010568e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105691:	83 c6 6c             	add    $0x6c,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105694:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105698:	89 74 24 08          	mov    %esi,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010569c:	89 54 24 10          	mov    %edx,0x10(%esp)
801056a0:	8b 40 10             	mov    0x10(%eax),%eax
801056a3:	c7 04 24 3c 75 10 80 	movl   $0x8010753c,(%esp)
801056aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801056ae:	e8 6d b0 ff ff       	call   80100720 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801056b3:	e8 48 e1 ff ff       	call   80103800 <myproc>
801056b8:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801056bf:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801056c0:	e8 3b e1 ff ff       	call   80103800 <myproc>
801056c5:	85 c0                	test   %eax,%eax
801056c7:	74 0c                	je     801056d5 <trap+0xc5>
801056c9:	e8 32 e1 ff ff       	call   80103800 <myproc>
801056ce:	8b 50 24             	mov    0x24(%eax),%edx
801056d1:	85 d2                	test   %edx,%edx
801056d3:	75 4b                	jne    80105720 <trap+0x110>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801056d5:	e8 26 e1 ff ff       	call   80103800 <myproc>
801056da:	85 c0                	test   %eax,%eax
801056dc:	74 0d                	je     801056eb <trap+0xdb>
801056de:	66 90                	xchg   %ax,%ax
801056e0:	e8 1b e1 ff ff       	call   80103800 <myproc>
801056e5:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801056e9:	74 4d                	je     80105738 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801056eb:	e8 10 e1 ff ff       	call   80103800 <myproc>
801056f0:	85 c0                	test   %eax,%eax
801056f2:	74 1d                	je     80105711 <trap+0x101>
801056f4:	e8 07 e1 ff ff       	call   80103800 <myproc>
801056f9:	8b 40 24             	mov    0x24(%eax),%eax
801056fc:	85 c0                	test   %eax,%eax
801056fe:	74 11                	je     80105711 <trap+0x101>
80105700:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105704:	83 e0 03             	and    $0x3,%eax
80105707:	66 83 f8 03          	cmp    $0x3,%ax
8010570b:	0f 84 e8 00 00 00    	je     801057f9 <trap+0x1e9>
    exit();
}
80105711:	83 c4 3c             	add    $0x3c,%esp
80105714:	5b                   	pop    %ebx
80105715:	5e                   	pop    %esi
80105716:	5f                   	pop    %edi
80105717:	5d                   	pop    %ebp
80105718:	c3                   	ret    
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105720:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105724:	83 e0 03             	and    $0x3,%eax
80105727:	66 83 f8 03          	cmp    $0x3,%ax
8010572b:	75 a8                	jne    801056d5 <trap+0xc5>
    exit();
8010572d:	e8 ce e4 ff ff       	call   80103c00 <exit>
80105732:	eb a1                	jmp    801056d5 <trap+0xc5>
80105734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105738:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105740:	75 a9                	jne    801056eb <trap+0xdb>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105742:	e8 d9 e5 ff ff       	call   80103d20 <yield>
80105747:	eb a2                	jmp    801056eb <trap+0xdb>
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105750:	e8 8b e0 ff ff       	call   801037e0 <cpuid>
80105755:	85 c0                	test   %eax,%eax
80105757:	0f 84 b3 00 00 00    	je     80105810 <trap+0x200>
8010575d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105760:	e8 7b d1 ff ff       	call   801028e0 <lapiceoi>
    break;
80105765:	e9 56 ff ff ff       	jmp    801056c0 <trap+0xb0>
8010576a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105770:	e8 cb cf ff ff       	call   80102740 <kbdintr>
    lapiceoi();
80105775:	e8 66 d1 ff ff       	call   801028e0 <lapiceoi>
    break;
8010577a:	e9 41 ff ff ff       	jmp    801056c0 <trap+0xb0>
8010577f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105780:	e8 0b 02 00 00       	call   80105990 <uartintr>
    lapiceoi();
80105785:	e8 56 d1 ff ff       	call   801028e0 <lapiceoi>
    break;
8010578a:	e9 31 ff ff ff       	jmp    801056c0 <trap+0xb0>
8010578f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105790:	8b 7b 38             	mov    0x38(%ebx),%edi
80105793:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105797:	e8 44 e0 ff ff       	call   801037e0 <cpuid>
8010579c:	c7 04 24 e4 74 10 80 	movl   $0x801074e4,(%esp)
801057a3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801057a7:	89 74 24 08          	mov    %esi,0x8(%esp)
801057ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801057af:	e8 6c af ff ff       	call   80100720 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
801057b4:	e8 27 d1 ff ff       	call   801028e0 <lapiceoi>
    break;
801057b9:	e9 02 ff ff ff       	jmp    801056c0 <trap+0xb0>
801057be:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801057c0:	e8 2b ca ff ff       	call   801021f0 <ideintr>
801057c5:	eb 96                	jmp    8010575d <trap+0x14d>
801057c7:	90                   	nop
801057c8:	90                   	nop
801057c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
801057d0:	e8 2b e0 ff ff       	call   80103800 <myproc>
801057d5:	8b 70 24             	mov    0x24(%eax),%esi
801057d8:	85 f6                	test   %esi,%esi
801057da:	75 2c                	jne    80105808 <trap+0x1f8>
      exit();
    myproc()->tf = tf;
801057dc:	e8 1f e0 ff ff       	call   80103800 <myproc>
801057e1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801057e4:	e8 d7 ef ff ff       	call   801047c0 <syscall>
    if(myproc()->killed)
801057e9:	e8 12 e0 ff ff       	call   80103800 <myproc>
801057ee:	8b 48 24             	mov    0x24(%eax),%ecx
801057f1:	85 c9                	test   %ecx,%ecx
801057f3:	0f 84 18 ff ff ff    	je     80105711 <trap+0x101>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801057f9:	83 c4 3c             	add    $0x3c,%esp
801057fc:	5b                   	pop    %ebx
801057fd:	5e                   	pop    %esi
801057fe:	5f                   	pop    %edi
801057ff:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105800:	e9 fb e3 ff ff       	jmp    80103c00 <exit>
80105805:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105808:	e8 f3 e3 ff ff       	call   80103c00 <exit>
8010580d:	eb cd                	jmp    801057dc <trap+0x1cc>
8010580f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105810:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105817:	e8 24 eb ff ff       	call   80104340 <acquire>
      ticks++;
      wakeup(&ticks);
8010581c:	c7 04 24 c0 54 11 80 	movl   $0x801154c0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105823:	83 05 c0 54 11 80 01 	addl   $0x1,0x801154c0
      wakeup(&ticks);
8010582a:	e8 c1 e6 ff ff       	call   80103ef0 <wakeup>
      release(&tickslock);
8010582f:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105836:	e8 75 eb ff ff       	call   801043b0 <release>
8010583b:	e9 1d ff ff ff       	jmp    8010575d <trap+0x14d>
80105840:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105843:	8b 73 38             	mov    0x38(%ebx),%esi
80105846:	e8 95 df ff ff       	call   801037e0 <cpuid>
8010584b:	89 7c 24 10          	mov    %edi,0x10(%esp)
8010584f:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105853:	89 44 24 08          	mov    %eax,0x8(%esp)
80105857:	8b 43 30             	mov    0x30(%ebx),%eax
8010585a:	c7 04 24 08 75 10 80 	movl   $0x80107508,(%esp)
80105861:	89 44 24 04          	mov    %eax,0x4(%esp)
80105865:	e8 b6 ae ff ff       	call   80100720 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
8010586a:	c7 04 24 de 74 10 80 	movl   $0x801074de,(%esp)
80105871:	e8 ea aa ff ff       	call   80100360 <panic>
80105876:	66 90                	xchg   %ax,%ax
80105878:	66 90                	xchg   %ax,%ax
8010587a:	66 90                	xchg   %ax,%ax
8010587c:	66 90                	xchg   %ax,%ax
8010587e:	66 90                	xchg   %ax,%ax

80105880 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105880:	a1 dc a5 10 80       	mov    0x8010a5dc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105885:	55                   	push   %ebp
80105886:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105888:	85 c0                	test   %eax,%eax
8010588a:	74 14                	je     801058a0 <uartgetc+0x20>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010588c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105891:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105892:	a8 01                	test   $0x1,%al
80105894:	74 0a                	je     801058a0 <uartgetc+0x20>
80105896:	b2 f8                	mov    $0xf8,%dl
80105898:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105899:	0f b6 c0             	movzbl %al,%eax
}
8010589c:	5d                   	pop    %ebp
8010589d:	c3                   	ret    
8010589e:	66 90                	xchg   %ax,%ax

static int
uartgetc(void)
{
  if(!uart)
    return -1;
801058a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
801058a5:	5d                   	pop    %ebp
801058a6:	c3                   	ret    
801058a7:	89 f6                	mov    %esi,%esi
801058a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058b0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
801058b0:	a1 dc a5 10 80       	mov    0x8010a5dc,%eax
801058b5:	85 c0                	test   %eax,%eax
801058b7:	74 3f                	je     801058f8 <uartputc+0x48>
    uartputc(*p);
}

void
uartputc(int c)
{
801058b9:	55                   	push   %ebp
801058ba:	89 e5                	mov    %esp,%ebp
801058bc:	56                   	push   %esi
801058bd:	be fd 03 00 00       	mov    $0x3fd,%esi
801058c2:	53                   	push   %ebx
  int i;

  if(!uart)
801058c3:	bb 80 00 00 00       	mov    $0x80,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
801058c8:	83 ec 10             	sub    $0x10,%esp
801058cb:	eb 14                	jmp    801058e1 <uartputc+0x31>
801058cd:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
801058d0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801058d7:	e8 24 d0 ff ff       	call   80102900 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801058dc:	83 eb 01             	sub    $0x1,%ebx
801058df:	74 07                	je     801058e8 <uartputc+0x38>
801058e1:	89 f2                	mov    %esi,%edx
801058e3:	ec                   	in     (%dx),%al
801058e4:	a8 20                	test   $0x20,%al
801058e6:	74 e8                	je     801058d0 <uartputc+0x20>
    microdelay(10);
  outb(COM1+0, c);
801058e8:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801058ec:	ba f8 03 00 00       	mov    $0x3f8,%edx
801058f1:	ee                   	out    %al,(%dx)
}
801058f2:	83 c4 10             	add    $0x10,%esp
801058f5:	5b                   	pop    %ebx
801058f6:	5e                   	pop    %esi
801058f7:	5d                   	pop    %ebp
801058f8:	f3 c3                	repz ret 
801058fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105900 <uartinit>:
80105900:	ba fa 03 00 00       	mov    $0x3fa,%edx
80105905:	31 c0                	xor    %eax,%eax
80105907:	ee                   	out    %al,(%dx)
80105908:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010590d:	b2 fb                	mov    $0xfb,%dl
8010590f:	ee                   	out    %al,(%dx)
80105910:	b8 0c 00 00 00       	mov    $0xc,%eax
80105915:	b2 f8                	mov    $0xf8,%dl
80105917:	ee                   	out    %al,(%dx)
80105918:	31 c0                	xor    %eax,%eax
8010591a:	b2 f9                	mov    $0xf9,%dl
8010591c:	ee                   	out    %al,(%dx)
8010591d:	b8 03 00 00 00       	mov    $0x3,%eax
80105922:	b2 fb                	mov    $0xfb,%dl
80105924:	ee                   	out    %al,(%dx)
80105925:	31 c0                	xor    %eax,%eax
80105927:	b2 fc                	mov    $0xfc,%dl
80105929:	ee                   	out    %al,(%dx)
8010592a:	b8 01 00 00 00       	mov    $0x1,%eax
8010592f:	b2 f9                	mov    $0xf9,%dl
80105931:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105932:	b2 fd                	mov    $0xfd,%dl
80105934:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105935:	3c ff                	cmp    $0xff,%al
80105937:	74 4e                	je     80105987 <uartinit+0x87>

static int uart;    // is there a uart?

void
uartinit(void)
{
80105939:	55                   	push   %ebp
8010593a:	b2 fa                	mov    $0xfa,%dl
8010593c:	89 e5                	mov    %esp,%ebp
8010593e:	53                   	push   %ebx
8010593f:	83 ec 14             	sub    $0x14,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
  uart = 1;
80105942:	c7 05 dc a5 10 80 01 	movl   $0x1,0x8010a5dc
80105949:	00 00 00 
8010594c:	ec                   	in     (%dx),%al
8010594d:	b2 f8                	mov    $0xf8,%dl
8010594f:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105950:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105957:	00 

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105958:	bb 00 76 10 80       	mov    $0x80107600,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
8010595d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105964:	e8 b7 ca ff ff       	call   80102420 <ioapicenable>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105969:	b8 78 00 00 00       	mov    $0x78,%eax
8010596e:	66 90                	xchg   %ax,%ax
    uartputc(*p);
80105970:	89 04 24             	mov    %eax,(%esp)
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105973:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105976:	e8 35 ff ff ff       	call   801058b0 <uartputc>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010597b:	0f be 03             	movsbl (%ebx),%eax
8010597e:	84 c0                	test   %al,%al
80105980:	75 ee                	jne    80105970 <uartinit+0x70>
    uartputc(*p);
}
80105982:	83 c4 14             	add    $0x14,%esp
80105985:	5b                   	pop    %ebx
80105986:	5d                   	pop    %ebp
80105987:	f3 c3                	repz ret 
80105989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105990 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105996:	c7 04 24 80 58 10 80 	movl   $0x80105880,(%esp)
8010599d:	e8 de ae ff ff       	call   80100880 <consoleintr>
}
801059a2:	c9                   	leave  
801059a3:	c3                   	ret    

801059a4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801059a4:	6a 00                	push   $0x0
  pushl $0
801059a6:	6a 00                	push   $0x0
  jmp alltraps
801059a8:	e9 70 fb ff ff       	jmp    8010551d <alltraps>

801059ad <vector1>:
.globl vector1
vector1:
  pushl $0
801059ad:	6a 00                	push   $0x0
  pushl $1
801059af:	6a 01                	push   $0x1
  jmp alltraps
801059b1:	e9 67 fb ff ff       	jmp    8010551d <alltraps>

801059b6 <vector2>:
.globl vector2
vector2:
  pushl $0
801059b6:	6a 00                	push   $0x0
  pushl $2
801059b8:	6a 02                	push   $0x2
  jmp alltraps
801059ba:	e9 5e fb ff ff       	jmp    8010551d <alltraps>

801059bf <vector3>:
.globl vector3
vector3:
  pushl $0
801059bf:	6a 00                	push   $0x0
  pushl $3
801059c1:	6a 03                	push   $0x3
  jmp alltraps
801059c3:	e9 55 fb ff ff       	jmp    8010551d <alltraps>

801059c8 <vector4>:
.globl vector4
vector4:
  pushl $0
801059c8:	6a 00                	push   $0x0
  pushl $4
801059ca:	6a 04                	push   $0x4
  jmp alltraps
801059cc:	e9 4c fb ff ff       	jmp    8010551d <alltraps>

801059d1 <vector5>:
.globl vector5
vector5:
  pushl $0
801059d1:	6a 00                	push   $0x0
  pushl $5
801059d3:	6a 05                	push   $0x5
  jmp alltraps
801059d5:	e9 43 fb ff ff       	jmp    8010551d <alltraps>

801059da <vector6>:
.globl vector6
vector6:
  pushl $0
801059da:	6a 00                	push   $0x0
  pushl $6
801059dc:	6a 06                	push   $0x6
  jmp alltraps
801059de:	e9 3a fb ff ff       	jmp    8010551d <alltraps>

801059e3 <vector7>:
.globl vector7
vector7:
  pushl $0
801059e3:	6a 00                	push   $0x0
  pushl $7
801059e5:	6a 07                	push   $0x7
  jmp alltraps
801059e7:	e9 31 fb ff ff       	jmp    8010551d <alltraps>

801059ec <vector8>:
.globl vector8
vector8:
  pushl $8
801059ec:	6a 08                	push   $0x8
  jmp alltraps
801059ee:	e9 2a fb ff ff       	jmp    8010551d <alltraps>

801059f3 <vector9>:
.globl vector9
vector9:
  pushl $0
801059f3:	6a 00                	push   $0x0
  pushl $9
801059f5:	6a 09                	push   $0x9
  jmp alltraps
801059f7:	e9 21 fb ff ff       	jmp    8010551d <alltraps>

801059fc <vector10>:
.globl vector10
vector10:
  pushl $10
801059fc:	6a 0a                	push   $0xa
  jmp alltraps
801059fe:	e9 1a fb ff ff       	jmp    8010551d <alltraps>

80105a03 <vector11>:
.globl vector11
vector11:
  pushl $11
80105a03:	6a 0b                	push   $0xb
  jmp alltraps
80105a05:	e9 13 fb ff ff       	jmp    8010551d <alltraps>

80105a0a <vector12>:
.globl vector12
vector12:
  pushl $12
80105a0a:	6a 0c                	push   $0xc
  jmp alltraps
80105a0c:	e9 0c fb ff ff       	jmp    8010551d <alltraps>

80105a11 <vector13>:
.globl vector13
vector13:
  pushl $13
80105a11:	6a 0d                	push   $0xd
  jmp alltraps
80105a13:	e9 05 fb ff ff       	jmp    8010551d <alltraps>

80105a18 <vector14>:
.globl vector14
vector14:
  pushl $14
80105a18:	6a 0e                	push   $0xe
  jmp alltraps
80105a1a:	e9 fe fa ff ff       	jmp    8010551d <alltraps>

80105a1f <vector15>:
.globl vector15
vector15:
  pushl $0
80105a1f:	6a 00                	push   $0x0
  pushl $15
80105a21:	6a 0f                	push   $0xf
  jmp alltraps
80105a23:	e9 f5 fa ff ff       	jmp    8010551d <alltraps>

80105a28 <vector16>:
.globl vector16
vector16:
  pushl $0
80105a28:	6a 00                	push   $0x0
  pushl $16
80105a2a:	6a 10                	push   $0x10
  jmp alltraps
80105a2c:	e9 ec fa ff ff       	jmp    8010551d <alltraps>

80105a31 <vector17>:
.globl vector17
vector17:
  pushl $17
80105a31:	6a 11                	push   $0x11
  jmp alltraps
80105a33:	e9 e5 fa ff ff       	jmp    8010551d <alltraps>

80105a38 <vector18>:
.globl vector18
vector18:
  pushl $0
80105a38:	6a 00                	push   $0x0
  pushl $18
80105a3a:	6a 12                	push   $0x12
  jmp alltraps
80105a3c:	e9 dc fa ff ff       	jmp    8010551d <alltraps>

80105a41 <vector19>:
.globl vector19
vector19:
  pushl $0
80105a41:	6a 00                	push   $0x0
  pushl $19
80105a43:	6a 13                	push   $0x13
  jmp alltraps
80105a45:	e9 d3 fa ff ff       	jmp    8010551d <alltraps>

80105a4a <vector20>:
.globl vector20
vector20:
  pushl $0
80105a4a:	6a 00                	push   $0x0
  pushl $20
80105a4c:	6a 14                	push   $0x14
  jmp alltraps
80105a4e:	e9 ca fa ff ff       	jmp    8010551d <alltraps>

80105a53 <vector21>:
.globl vector21
vector21:
  pushl $0
80105a53:	6a 00                	push   $0x0
  pushl $21
80105a55:	6a 15                	push   $0x15
  jmp alltraps
80105a57:	e9 c1 fa ff ff       	jmp    8010551d <alltraps>

80105a5c <vector22>:
.globl vector22
vector22:
  pushl $0
80105a5c:	6a 00                	push   $0x0
  pushl $22
80105a5e:	6a 16                	push   $0x16
  jmp alltraps
80105a60:	e9 b8 fa ff ff       	jmp    8010551d <alltraps>

80105a65 <vector23>:
.globl vector23
vector23:
  pushl $0
80105a65:	6a 00                	push   $0x0
  pushl $23
80105a67:	6a 17                	push   $0x17
  jmp alltraps
80105a69:	e9 af fa ff ff       	jmp    8010551d <alltraps>

80105a6e <vector24>:
.globl vector24
vector24:
  pushl $0
80105a6e:	6a 00                	push   $0x0
  pushl $24
80105a70:	6a 18                	push   $0x18
  jmp alltraps
80105a72:	e9 a6 fa ff ff       	jmp    8010551d <alltraps>

80105a77 <vector25>:
.globl vector25
vector25:
  pushl $0
80105a77:	6a 00                	push   $0x0
  pushl $25
80105a79:	6a 19                	push   $0x19
  jmp alltraps
80105a7b:	e9 9d fa ff ff       	jmp    8010551d <alltraps>

80105a80 <vector26>:
.globl vector26
vector26:
  pushl $0
80105a80:	6a 00                	push   $0x0
  pushl $26
80105a82:	6a 1a                	push   $0x1a
  jmp alltraps
80105a84:	e9 94 fa ff ff       	jmp    8010551d <alltraps>

80105a89 <vector27>:
.globl vector27
vector27:
  pushl $0
80105a89:	6a 00                	push   $0x0
  pushl $27
80105a8b:	6a 1b                	push   $0x1b
  jmp alltraps
80105a8d:	e9 8b fa ff ff       	jmp    8010551d <alltraps>

80105a92 <vector28>:
.globl vector28
vector28:
  pushl $0
80105a92:	6a 00                	push   $0x0
  pushl $28
80105a94:	6a 1c                	push   $0x1c
  jmp alltraps
80105a96:	e9 82 fa ff ff       	jmp    8010551d <alltraps>

80105a9b <vector29>:
.globl vector29
vector29:
  pushl $0
80105a9b:	6a 00                	push   $0x0
  pushl $29
80105a9d:	6a 1d                	push   $0x1d
  jmp alltraps
80105a9f:	e9 79 fa ff ff       	jmp    8010551d <alltraps>

80105aa4 <vector30>:
.globl vector30
vector30:
  pushl $0
80105aa4:	6a 00                	push   $0x0
  pushl $30
80105aa6:	6a 1e                	push   $0x1e
  jmp alltraps
80105aa8:	e9 70 fa ff ff       	jmp    8010551d <alltraps>

80105aad <vector31>:
.globl vector31
vector31:
  pushl $0
80105aad:	6a 00                	push   $0x0
  pushl $31
80105aaf:	6a 1f                	push   $0x1f
  jmp alltraps
80105ab1:	e9 67 fa ff ff       	jmp    8010551d <alltraps>

80105ab6 <vector32>:
.globl vector32
vector32:
  pushl $0
80105ab6:	6a 00                	push   $0x0
  pushl $32
80105ab8:	6a 20                	push   $0x20
  jmp alltraps
80105aba:	e9 5e fa ff ff       	jmp    8010551d <alltraps>

80105abf <vector33>:
.globl vector33
vector33:
  pushl $0
80105abf:	6a 00                	push   $0x0
  pushl $33
80105ac1:	6a 21                	push   $0x21
  jmp alltraps
80105ac3:	e9 55 fa ff ff       	jmp    8010551d <alltraps>

80105ac8 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ac8:	6a 00                	push   $0x0
  pushl $34
80105aca:	6a 22                	push   $0x22
  jmp alltraps
80105acc:	e9 4c fa ff ff       	jmp    8010551d <alltraps>

80105ad1 <vector35>:
.globl vector35
vector35:
  pushl $0
80105ad1:	6a 00                	push   $0x0
  pushl $35
80105ad3:	6a 23                	push   $0x23
  jmp alltraps
80105ad5:	e9 43 fa ff ff       	jmp    8010551d <alltraps>

80105ada <vector36>:
.globl vector36
vector36:
  pushl $0
80105ada:	6a 00                	push   $0x0
  pushl $36
80105adc:	6a 24                	push   $0x24
  jmp alltraps
80105ade:	e9 3a fa ff ff       	jmp    8010551d <alltraps>

80105ae3 <vector37>:
.globl vector37
vector37:
  pushl $0
80105ae3:	6a 00                	push   $0x0
  pushl $37
80105ae5:	6a 25                	push   $0x25
  jmp alltraps
80105ae7:	e9 31 fa ff ff       	jmp    8010551d <alltraps>

80105aec <vector38>:
.globl vector38
vector38:
  pushl $0
80105aec:	6a 00                	push   $0x0
  pushl $38
80105aee:	6a 26                	push   $0x26
  jmp alltraps
80105af0:	e9 28 fa ff ff       	jmp    8010551d <alltraps>

80105af5 <vector39>:
.globl vector39
vector39:
  pushl $0
80105af5:	6a 00                	push   $0x0
  pushl $39
80105af7:	6a 27                	push   $0x27
  jmp alltraps
80105af9:	e9 1f fa ff ff       	jmp    8010551d <alltraps>

80105afe <vector40>:
.globl vector40
vector40:
  pushl $0
80105afe:	6a 00                	push   $0x0
  pushl $40
80105b00:	6a 28                	push   $0x28
  jmp alltraps
80105b02:	e9 16 fa ff ff       	jmp    8010551d <alltraps>

80105b07 <vector41>:
.globl vector41
vector41:
  pushl $0
80105b07:	6a 00                	push   $0x0
  pushl $41
80105b09:	6a 29                	push   $0x29
  jmp alltraps
80105b0b:	e9 0d fa ff ff       	jmp    8010551d <alltraps>

80105b10 <vector42>:
.globl vector42
vector42:
  pushl $0
80105b10:	6a 00                	push   $0x0
  pushl $42
80105b12:	6a 2a                	push   $0x2a
  jmp alltraps
80105b14:	e9 04 fa ff ff       	jmp    8010551d <alltraps>

80105b19 <vector43>:
.globl vector43
vector43:
  pushl $0
80105b19:	6a 00                	push   $0x0
  pushl $43
80105b1b:	6a 2b                	push   $0x2b
  jmp alltraps
80105b1d:	e9 fb f9 ff ff       	jmp    8010551d <alltraps>

80105b22 <vector44>:
.globl vector44
vector44:
  pushl $0
80105b22:	6a 00                	push   $0x0
  pushl $44
80105b24:	6a 2c                	push   $0x2c
  jmp alltraps
80105b26:	e9 f2 f9 ff ff       	jmp    8010551d <alltraps>

80105b2b <vector45>:
.globl vector45
vector45:
  pushl $0
80105b2b:	6a 00                	push   $0x0
  pushl $45
80105b2d:	6a 2d                	push   $0x2d
  jmp alltraps
80105b2f:	e9 e9 f9 ff ff       	jmp    8010551d <alltraps>

80105b34 <vector46>:
.globl vector46
vector46:
  pushl $0
80105b34:	6a 00                	push   $0x0
  pushl $46
80105b36:	6a 2e                	push   $0x2e
  jmp alltraps
80105b38:	e9 e0 f9 ff ff       	jmp    8010551d <alltraps>

80105b3d <vector47>:
.globl vector47
vector47:
  pushl $0
80105b3d:	6a 00                	push   $0x0
  pushl $47
80105b3f:	6a 2f                	push   $0x2f
  jmp alltraps
80105b41:	e9 d7 f9 ff ff       	jmp    8010551d <alltraps>

80105b46 <vector48>:
.globl vector48
vector48:
  pushl $0
80105b46:	6a 00                	push   $0x0
  pushl $48
80105b48:	6a 30                	push   $0x30
  jmp alltraps
80105b4a:	e9 ce f9 ff ff       	jmp    8010551d <alltraps>

80105b4f <vector49>:
.globl vector49
vector49:
  pushl $0
80105b4f:	6a 00                	push   $0x0
  pushl $49
80105b51:	6a 31                	push   $0x31
  jmp alltraps
80105b53:	e9 c5 f9 ff ff       	jmp    8010551d <alltraps>

80105b58 <vector50>:
.globl vector50
vector50:
  pushl $0
80105b58:	6a 00                	push   $0x0
  pushl $50
80105b5a:	6a 32                	push   $0x32
  jmp alltraps
80105b5c:	e9 bc f9 ff ff       	jmp    8010551d <alltraps>

80105b61 <vector51>:
.globl vector51
vector51:
  pushl $0
80105b61:	6a 00                	push   $0x0
  pushl $51
80105b63:	6a 33                	push   $0x33
  jmp alltraps
80105b65:	e9 b3 f9 ff ff       	jmp    8010551d <alltraps>

80105b6a <vector52>:
.globl vector52
vector52:
  pushl $0
80105b6a:	6a 00                	push   $0x0
  pushl $52
80105b6c:	6a 34                	push   $0x34
  jmp alltraps
80105b6e:	e9 aa f9 ff ff       	jmp    8010551d <alltraps>

80105b73 <vector53>:
.globl vector53
vector53:
  pushl $0
80105b73:	6a 00                	push   $0x0
  pushl $53
80105b75:	6a 35                	push   $0x35
  jmp alltraps
80105b77:	e9 a1 f9 ff ff       	jmp    8010551d <alltraps>

80105b7c <vector54>:
.globl vector54
vector54:
  pushl $0
80105b7c:	6a 00                	push   $0x0
  pushl $54
80105b7e:	6a 36                	push   $0x36
  jmp alltraps
80105b80:	e9 98 f9 ff ff       	jmp    8010551d <alltraps>

80105b85 <vector55>:
.globl vector55
vector55:
  pushl $0
80105b85:	6a 00                	push   $0x0
  pushl $55
80105b87:	6a 37                	push   $0x37
  jmp alltraps
80105b89:	e9 8f f9 ff ff       	jmp    8010551d <alltraps>

80105b8e <vector56>:
.globl vector56
vector56:
  pushl $0
80105b8e:	6a 00                	push   $0x0
  pushl $56
80105b90:	6a 38                	push   $0x38
  jmp alltraps
80105b92:	e9 86 f9 ff ff       	jmp    8010551d <alltraps>

80105b97 <vector57>:
.globl vector57
vector57:
  pushl $0
80105b97:	6a 00                	push   $0x0
  pushl $57
80105b99:	6a 39                	push   $0x39
  jmp alltraps
80105b9b:	e9 7d f9 ff ff       	jmp    8010551d <alltraps>

80105ba0 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ba0:	6a 00                	push   $0x0
  pushl $58
80105ba2:	6a 3a                	push   $0x3a
  jmp alltraps
80105ba4:	e9 74 f9 ff ff       	jmp    8010551d <alltraps>

80105ba9 <vector59>:
.globl vector59
vector59:
  pushl $0
80105ba9:	6a 00                	push   $0x0
  pushl $59
80105bab:	6a 3b                	push   $0x3b
  jmp alltraps
80105bad:	e9 6b f9 ff ff       	jmp    8010551d <alltraps>

80105bb2 <vector60>:
.globl vector60
vector60:
  pushl $0
80105bb2:	6a 00                	push   $0x0
  pushl $60
80105bb4:	6a 3c                	push   $0x3c
  jmp alltraps
80105bb6:	e9 62 f9 ff ff       	jmp    8010551d <alltraps>

80105bbb <vector61>:
.globl vector61
vector61:
  pushl $0
80105bbb:	6a 00                	push   $0x0
  pushl $61
80105bbd:	6a 3d                	push   $0x3d
  jmp alltraps
80105bbf:	e9 59 f9 ff ff       	jmp    8010551d <alltraps>

80105bc4 <vector62>:
.globl vector62
vector62:
  pushl $0
80105bc4:	6a 00                	push   $0x0
  pushl $62
80105bc6:	6a 3e                	push   $0x3e
  jmp alltraps
80105bc8:	e9 50 f9 ff ff       	jmp    8010551d <alltraps>

80105bcd <vector63>:
.globl vector63
vector63:
  pushl $0
80105bcd:	6a 00                	push   $0x0
  pushl $63
80105bcf:	6a 3f                	push   $0x3f
  jmp alltraps
80105bd1:	e9 47 f9 ff ff       	jmp    8010551d <alltraps>

80105bd6 <vector64>:
.globl vector64
vector64:
  pushl $0
80105bd6:	6a 00                	push   $0x0
  pushl $64
80105bd8:	6a 40                	push   $0x40
  jmp alltraps
80105bda:	e9 3e f9 ff ff       	jmp    8010551d <alltraps>

80105bdf <vector65>:
.globl vector65
vector65:
  pushl $0
80105bdf:	6a 00                	push   $0x0
  pushl $65
80105be1:	6a 41                	push   $0x41
  jmp alltraps
80105be3:	e9 35 f9 ff ff       	jmp    8010551d <alltraps>

80105be8 <vector66>:
.globl vector66
vector66:
  pushl $0
80105be8:	6a 00                	push   $0x0
  pushl $66
80105bea:	6a 42                	push   $0x42
  jmp alltraps
80105bec:	e9 2c f9 ff ff       	jmp    8010551d <alltraps>

80105bf1 <vector67>:
.globl vector67
vector67:
  pushl $0
80105bf1:	6a 00                	push   $0x0
  pushl $67
80105bf3:	6a 43                	push   $0x43
  jmp alltraps
80105bf5:	e9 23 f9 ff ff       	jmp    8010551d <alltraps>

80105bfa <vector68>:
.globl vector68
vector68:
  pushl $0
80105bfa:	6a 00                	push   $0x0
  pushl $68
80105bfc:	6a 44                	push   $0x44
  jmp alltraps
80105bfe:	e9 1a f9 ff ff       	jmp    8010551d <alltraps>

80105c03 <vector69>:
.globl vector69
vector69:
  pushl $0
80105c03:	6a 00                	push   $0x0
  pushl $69
80105c05:	6a 45                	push   $0x45
  jmp alltraps
80105c07:	e9 11 f9 ff ff       	jmp    8010551d <alltraps>

80105c0c <vector70>:
.globl vector70
vector70:
  pushl $0
80105c0c:	6a 00                	push   $0x0
  pushl $70
80105c0e:	6a 46                	push   $0x46
  jmp alltraps
80105c10:	e9 08 f9 ff ff       	jmp    8010551d <alltraps>

80105c15 <vector71>:
.globl vector71
vector71:
  pushl $0
80105c15:	6a 00                	push   $0x0
  pushl $71
80105c17:	6a 47                	push   $0x47
  jmp alltraps
80105c19:	e9 ff f8 ff ff       	jmp    8010551d <alltraps>

80105c1e <vector72>:
.globl vector72
vector72:
  pushl $0
80105c1e:	6a 00                	push   $0x0
  pushl $72
80105c20:	6a 48                	push   $0x48
  jmp alltraps
80105c22:	e9 f6 f8 ff ff       	jmp    8010551d <alltraps>

80105c27 <vector73>:
.globl vector73
vector73:
  pushl $0
80105c27:	6a 00                	push   $0x0
  pushl $73
80105c29:	6a 49                	push   $0x49
  jmp alltraps
80105c2b:	e9 ed f8 ff ff       	jmp    8010551d <alltraps>

80105c30 <vector74>:
.globl vector74
vector74:
  pushl $0
80105c30:	6a 00                	push   $0x0
  pushl $74
80105c32:	6a 4a                	push   $0x4a
  jmp alltraps
80105c34:	e9 e4 f8 ff ff       	jmp    8010551d <alltraps>

80105c39 <vector75>:
.globl vector75
vector75:
  pushl $0
80105c39:	6a 00                	push   $0x0
  pushl $75
80105c3b:	6a 4b                	push   $0x4b
  jmp alltraps
80105c3d:	e9 db f8 ff ff       	jmp    8010551d <alltraps>

80105c42 <vector76>:
.globl vector76
vector76:
  pushl $0
80105c42:	6a 00                	push   $0x0
  pushl $76
80105c44:	6a 4c                	push   $0x4c
  jmp alltraps
80105c46:	e9 d2 f8 ff ff       	jmp    8010551d <alltraps>

80105c4b <vector77>:
.globl vector77
vector77:
  pushl $0
80105c4b:	6a 00                	push   $0x0
  pushl $77
80105c4d:	6a 4d                	push   $0x4d
  jmp alltraps
80105c4f:	e9 c9 f8 ff ff       	jmp    8010551d <alltraps>

80105c54 <vector78>:
.globl vector78
vector78:
  pushl $0
80105c54:	6a 00                	push   $0x0
  pushl $78
80105c56:	6a 4e                	push   $0x4e
  jmp alltraps
80105c58:	e9 c0 f8 ff ff       	jmp    8010551d <alltraps>

80105c5d <vector79>:
.globl vector79
vector79:
  pushl $0
80105c5d:	6a 00                	push   $0x0
  pushl $79
80105c5f:	6a 4f                	push   $0x4f
  jmp alltraps
80105c61:	e9 b7 f8 ff ff       	jmp    8010551d <alltraps>

80105c66 <vector80>:
.globl vector80
vector80:
  pushl $0
80105c66:	6a 00                	push   $0x0
  pushl $80
80105c68:	6a 50                	push   $0x50
  jmp alltraps
80105c6a:	e9 ae f8 ff ff       	jmp    8010551d <alltraps>

80105c6f <vector81>:
.globl vector81
vector81:
  pushl $0
80105c6f:	6a 00                	push   $0x0
  pushl $81
80105c71:	6a 51                	push   $0x51
  jmp alltraps
80105c73:	e9 a5 f8 ff ff       	jmp    8010551d <alltraps>

80105c78 <vector82>:
.globl vector82
vector82:
  pushl $0
80105c78:	6a 00                	push   $0x0
  pushl $82
80105c7a:	6a 52                	push   $0x52
  jmp alltraps
80105c7c:	e9 9c f8 ff ff       	jmp    8010551d <alltraps>

80105c81 <vector83>:
.globl vector83
vector83:
  pushl $0
80105c81:	6a 00                	push   $0x0
  pushl $83
80105c83:	6a 53                	push   $0x53
  jmp alltraps
80105c85:	e9 93 f8 ff ff       	jmp    8010551d <alltraps>

80105c8a <vector84>:
.globl vector84
vector84:
  pushl $0
80105c8a:	6a 00                	push   $0x0
  pushl $84
80105c8c:	6a 54                	push   $0x54
  jmp alltraps
80105c8e:	e9 8a f8 ff ff       	jmp    8010551d <alltraps>

80105c93 <vector85>:
.globl vector85
vector85:
  pushl $0
80105c93:	6a 00                	push   $0x0
  pushl $85
80105c95:	6a 55                	push   $0x55
  jmp alltraps
80105c97:	e9 81 f8 ff ff       	jmp    8010551d <alltraps>

80105c9c <vector86>:
.globl vector86
vector86:
  pushl $0
80105c9c:	6a 00                	push   $0x0
  pushl $86
80105c9e:	6a 56                	push   $0x56
  jmp alltraps
80105ca0:	e9 78 f8 ff ff       	jmp    8010551d <alltraps>

80105ca5 <vector87>:
.globl vector87
vector87:
  pushl $0
80105ca5:	6a 00                	push   $0x0
  pushl $87
80105ca7:	6a 57                	push   $0x57
  jmp alltraps
80105ca9:	e9 6f f8 ff ff       	jmp    8010551d <alltraps>

80105cae <vector88>:
.globl vector88
vector88:
  pushl $0
80105cae:	6a 00                	push   $0x0
  pushl $88
80105cb0:	6a 58                	push   $0x58
  jmp alltraps
80105cb2:	e9 66 f8 ff ff       	jmp    8010551d <alltraps>

80105cb7 <vector89>:
.globl vector89
vector89:
  pushl $0
80105cb7:	6a 00                	push   $0x0
  pushl $89
80105cb9:	6a 59                	push   $0x59
  jmp alltraps
80105cbb:	e9 5d f8 ff ff       	jmp    8010551d <alltraps>

80105cc0 <vector90>:
.globl vector90
vector90:
  pushl $0
80105cc0:	6a 00                	push   $0x0
  pushl $90
80105cc2:	6a 5a                	push   $0x5a
  jmp alltraps
80105cc4:	e9 54 f8 ff ff       	jmp    8010551d <alltraps>

80105cc9 <vector91>:
.globl vector91
vector91:
  pushl $0
80105cc9:	6a 00                	push   $0x0
  pushl $91
80105ccb:	6a 5b                	push   $0x5b
  jmp alltraps
80105ccd:	e9 4b f8 ff ff       	jmp    8010551d <alltraps>

80105cd2 <vector92>:
.globl vector92
vector92:
  pushl $0
80105cd2:	6a 00                	push   $0x0
  pushl $92
80105cd4:	6a 5c                	push   $0x5c
  jmp alltraps
80105cd6:	e9 42 f8 ff ff       	jmp    8010551d <alltraps>

80105cdb <vector93>:
.globl vector93
vector93:
  pushl $0
80105cdb:	6a 00                	push   $0x0
  pushl $93
80105cdd:	6a 5d                	push   $0x5d
  jmp alltraps
80105cdf:	e9 39 f8 ff ff       	jmp    8010551d <alltraps>

80105ce4 <vector94>:
.globl vector94
vector94:
  pushl $0
80105ce4:	6a 00                	push   $0x0
  pushl $94
80105ce6:	6a 5e                	push   $0x5e
  jmp alltraps
80105ce8:	e9 30 f8 ff ff       	jmp    8010551d <alltraps>

80105ced <vector95>:
.globl vector95
vector95:
  pushl $0
80105ced:	6a 00                	push   $0x0
  pushl $95
80105cef:	6a 5f                	push   $0x5f
  jmp alltraps
80105cf1:	e9 27 f8 ff ff       	jmp    8010551d <alltraps>

80105cf6 <vector96>:
.globl vector96
vector96:
  pushl $0
80105cf6:	6a 00                	push   $0x0
  pushl $96
80105cf8:	6a 60                	push   $0x60
  jmp alltraps
80105cfa:	e9 1e f8 ff ff       	jmp    8010551d <alltraps>

80105cff <vector97>:
.globl vector97
vector97:
  pushl $0
80105cff:	6a 00                	push   $0x0
  pushl $97
80105d01:	6a 61                	push   $0x61
  jmp alltraps
80105d03:	e9 15 f8 ff ff       	jmp    8010551d <alltraps>

80105d08 <vector98>:
.globl vector98
vector98:
  pushl $0
80105d08:	6a 00                	push   $0x0
  pushl $98
80105d0a:	6a 62                	push   $0x62
  jmp alltraps
80105d0c:	e9 0c f8 ff ff       	jmp    8010551d <alltraps>

80105d11 <vector99>:
.globl vector99
vector99:
  pushl $0
80105d11:	6a 00                	push   $0x0
  pushl $99
80105d13:	6a 63                	push   $0x63
  jmp alltraps
80105d15:	e9 03 f8 ff ff       	jmp    8010551d <alltraps>

80105d1a <vector100>:
.globl vector100
vector100:
  pushl $0
80105d1a:	6a 00                	push   $0x0
  pushl $100
80105d1c:	6a 64                	push   $0x64
  jmp alltraps
80105d1e:	e9 fa f7 ff ff       	jmp    8010551d <alltraps>

80105d23 <vector101>:
.globl vector101
vector101:
  pushl $0
80105d23:	6a 00                	push   $0x0
  pushl $101
80105d25:	6a 65                	push   $0x65
  jmp alltraps
80105d27:	e9 f1 f7 ff ff       	jmp    8010551d <alltraps>

80105d2c <vector102>:
.globl vector102
vector102:
  pushl $0
80105d2c:	6a 00                	push   $0x0
  pushl $102
80105d2e:	6a 66                	push   $0x66
  jmp alltraps
80105d30:	e9 e8 f7 ff ff       	jmp    8010551d <alltraps>

80105d35 <vector103>:
.globl vector103
vector103:
  pushl $0
80105d35:	6a 00                	push   $0x0
  pushl $103
80105d37:	6a 67                	push   $0x67
  jmp alltraps
80105d39:	e9 df f7 ff ff       	jmp    8010551d <alltraps>

80105d3e <vector104>:
.globl vector104
vector104:
  pushl $0
80105d3e:	6a 00                	push   $0x0
  pushl $104
80105d40:	6a 68                	push   $0x68
  jmp alltraps
80105d42:	e9 d6 f7 ff ff       	jmp    8010551d <alltraps>

80105d47 <vector105>:
.globl vector105
vector105:
  pushl $0
80105d47:	6a 00                	push   $0x0
  pushl $105
80105d49:	6a 69                	push   $0x69
  jmp alltraps
80105d4b:	e9 cd f7 ff ff       	jmp    8010551d <alltraps>

80105d50 <vector106>:
.globl vector106
vector106:
  pushl $0
80105d50:	6a 00                	push   $0x0
  pushl $106
80105d52:	6a 6a                	push   $0x6a
  jmp alltraps
80105d54:	e9 c4 f7 ff ff       	jmp    8010551d <alltraps>

80105d59 <vector107>:
.globl vector107
vector107:
  pushl $0
80105d59:	6a 00                	push   $0x0
  pushl $107
80105d5b:	6a 6b                	push   $0x6b
  jmp alltraps
80105d5d:	e9 bb f7 ff ff       	jmp    8010551d <alltraps>

80105d62 <vector108>:
.globl vector108
vector108:
  pushl $0
80105d62:	6a 00                	push   $0x0
  pushl $108
80105d64:	6a 6c                	push   $0x6c
  jmp alltraps
80105d66:	e9 b2 f7 ff ff       	jmp    8010551d <alltraps>

80105d6b <vector109>:
.globl vector109
vector109:
  pushl $0
80105d6b:	6a 00                	push   $0x0
  pushl $109
80105d6d:	6a 6d                	push   $0x6d
  jmp alltraps
80105d6f:	e9 a9 f7 ff ff       	jmp    8010551d <alltraps>

80105d74 <vector110>:
.globl vector110
vector110:
  pushl $0
80105d74:	6a 00                	push   $0x0
  pushl $110
80105d76:	6a 6e                	push   $0x6e
  jmp alltraps
80105d78:	e9 a0 f7 ff ff       	jmp    8010551d <alltraps>

80105d7d <vector111>:
.globl vector111
vector111:
  pushl $0
80105d7d:	6a 00                	push   $0x0
  pushl $111
80105d7f:	6a 6f                	push   $0x6f
  jmp alltraps
80105d81:	e9 97 f7 ff ff       	jmp    8010551d <alltraps>

80105d86 <vector112>:
.globl vector112
vector112:
  pushl $0
80105d86:	6a 00                	push   $0x0
  pushl $112
80105d88:	6a 70                	push   $0x70
  jmp alltraps
80105d8a:	e9 8e f7 ff ff       	jmp    8010551d <alltraps>

80105d8f <vector113>:
.globl vector113
vector113:
  pushl $0
80105d8f:	6a 00                	push   $0x0
  pushl $113
80105d91:	6a 71                	push   $0x71
  jmp alltraps
80105d93:	e9 85 f7 ff ff       	jmp    8010551d <alltraps>

80105d98 <vector114>:
.globl vector114
vector114:
  pushl $0
80105d98:	6a 00                	push   $0x0
  pushl $114
80105d9a:	6a 72                	push   $0x72
  jmp alltraps
80105d9c:	e9 7c f7 ff ff       	jmp    8010551d <alltraps>

80105da1 <vector115>:
.globl vector115
vector115:
  pushl $0
80105da1:	6a 00                	push   $0x0
  pushl $115
80105da3:	6a 73                	push   $0x73
  jmp alltraps
80105da5:	e9 73 f7 ff ff       	jmp    8010551d <alltraps>

80105daa <vector116>:
.globl vector116
vector116:
  pushl $0
80105daa:	6a 00                	push   $0x0
  pushl $116
80105dac:	6a 74                	push   $0x74
  jmp alltraps
80105dae:	e9 6a f7 ff ff       	jmp    8010551d <alltraps>

80105db3 <vector117>:
.globl vector117
vector117:
  pushl $0
80105db3:	6a 00                	push   $0x0
  pushl $117
80105db5:	6a 75                	push   $0x75
  jmp alltraps
80105db7:	e9 61 f7 ff ff       	jmp    8010551d <alltraps>

80105dbc <vector118>:
.globl vector118
vector118:
  pushl $0
80105dbc:	6a 00                	push   $0x0
  pushl $118
80105dbe:	6a 76                	push   $0x76
  jmp alltraps
80105dc0:	e9 58 f7 ff ff       	jmp    8010551d <alltraps>

80105dc5 <vector119>:
.globl vector119
vector119:
  pushl $0
80105dc5:	6a 00                	push   $0x0
  pushl $119
80105dc7:	6a 77                	push   $0x77
  jmp alltraps
80105dc9:	e9 4f f7 ff ff       	jmp    8010551d <alltraps>

80105dce <vector120>:
.globl vector120
vector120:
  pushl $0
80105dce:	6a 00                	push   $0x0
  pushl $120
80105dd0:	6a 78                	push   $0x78
  jmp alltraps
80105dd2:	e9 46 f7 ff ff       	jmp    8010551d <alltraps>

80105dd7 <vector121>:
.globl vector121
vector121:
  pushl $0
80105dd7:	6a 00                	push   $0x0
  pushl $121
80105dd9:	6a 79                	push   $0x79
  jmp alltraps
80105ddb:	e9 3d f7 ff ff       	jmp    8010551d <alltraps>

80105de0 <vector122>:
.globl vector122
vector122:
  pushl $0
80105de0:	6a 00                	push   $0x0
  pushl $122
80105de2:	6a 7a                	push   $0x7a
  jmp alltraps
80105de4:	e9 34 f7 ff ff       	jmp    8010551d <alltraps>

80105de9 <vector123>:
.globl vector123
vector123:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $123
80105deb:	6a 7b                	push   $0x7b
  jmp alltraps
80105ded:	e9 2b f7 ff ff       	jmp    8010551d <alltraps>

80105df2 <vector124>:
.globl vector124
vector124:
  pushl $0
80105df2:	6a 00                	push   $0x0
  pushl $124
80105df4:	6a 7c                	push   $0x7c
  jmp alltraps
80105df6:	e9 22 f7 ff ff       	jmp    8010551d <alltraps>

80105dfb <vector125>:
.globl vector125
vector125:
  pushl $0
80105dfb:	6a 00                	push   $0x0
  pushl $125
80105dfd:	6a 7d                	push   $0x7d
  jmp alltraps
80105dff:	e9 19 f7 ff ff       	jmp    8010551d <alltraps>

80105e04 <vector126>:
.globl vector126
vector126:
  pushl $0
80105e04:	6a 00                	push   $0x0
  pushl $126
80105e06:	6a 7e                	push   $0x7e
  jmp alltraps
80105e08:	e9 10 f7 ff ff       	jmp    8010551d <alltraps>

80105e0d <vector127>:
.globl vector127
vector127:
  pushl $0
80105e0d:	6a 00                	push   $0x0
  pushl $127
80105e0f:	6a 7f                	push   $0x7f
  jmp alltraps
80105e11:	e9 07 f7 ff ff       	jmp    8010551d <alltraps>

80105e16 <vector128>:
.globl vector128
vector128:
  pushl $0
80105e16:	6a 00                	push   $0x0
  pushl $128
80105e18:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105e1d:	e9 fb f6 ff ff       	jmp    8010551d <alltraps>

80105e22 <vector129>:
.globl vector129
vector129:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $129
80105e24:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105e29:	e9 ef f6 ff ff       	jmp    8010551d <alltraps>

80105e2e <vector130>:
.globl vector130
vector130:
  pushl $0
80105e2e:	6a 00                	push   $0x0
  pushl $130
80105e30:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80105e35:	e9 e3 f6 ff ff       	jmp    8010551d <alltraps>

80105e3a <vector131>:
.globl vector131
vector131:
  pushl $0
80105e3a:	6a 00                	push   $0x0
  pushl $131
80105e3c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105e41:	e9 d7 f6 ff ff       	jmp    8010551d <alltraps>

80105e46 <vector132>:
.globl vector132
vector132:
  pushl $0
80105e46:	6a 00                	push   $0x0
  pushl $132
80105e48:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105e4d:	e9 cb f6 ff ff       	jmp    8010551d <alltraps>

80105e52 <vector133>:
.globl vector133
vector133:
  pushl $0
80105e52:	6a 00                	push   $0x0
  pushl $133
80105e54:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105e59:	e9 bf f6 ff ff       	jmp    8010551d <alltraps>

80105e5e <vector134>:
.globl vector134
vector134:
  pushl $0
80105e5e:	6a 00                	push   $0x0
  pushl $134
80105e60:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80105e65:	e9 b3 f6 ff ff       	jmp    8010551d <alltraps>

80105e6a <vector135>:
.globl vector135
vector135:
  pushl $0
80105e6a:	6a 00                	push   $0x0
  pushl $135
80105e6c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105e71:	e9 a7 f6 ff ff       	jmp    8010551d <alltraps>

80105e76 <vector136>:
.globl vector136
vector136:
  pushl $0
80105e76:	6a 00                	push   $0x0
  pushl $136
80105e78:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105e7d:	e9 9b f6 ff ff       	jmp    8010551d <alltraps>

80105e82 <vector137>:
.globl vector137
vector137:
  pushl $0
80105e82:	6a 00                	push   $0x0
  pushl $137
80105e84:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105e89:	e9 8f f6 ff ff       	jmp    8010551d <alltraps>

80105e8e <vector138>:
.globl vector138
vector138:
  pushl $0
80105e8e:	6a 00                	push   $0x0
  pushl $138
80105e90:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105e95:	e9 83 f6 ff ff       	jmp    8010551d <alltraps>

80105e9a <vector139>:
.globl vector139
vector139:
  pushl $0
80105e9a:	6a 00                	push   $0x0
  pushl $139
80105e9c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105ea1:	e9 77 f6 ff ff       	jmp    8010551d <alltraps>

80105ea6 <vector140>:
.globl vector140
vector140:
  pushl $0
80105ea6:	6a 00                	push   $0x0
  pushl $140
80105ea8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105ead:	e9 6b f6 ff ff       	jmp    8010551d <alltraps>

80105eb2 <vector141>:
.globl vector141
vector141:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $141
80105eb4:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105eb9:	e9 5f f6 ff ff       	jmp    8010551d <alltraps>

80105ebe <vector142>:
.globl vector142
vector142:
  pushl $0
80105ebe:	6a 00                	push   $0x0
  pushl $142
80105ec0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105ec5:	e9 53 f6 ff ff       	jmp    8010551d <alltraps>

80105eca <vector143>:
.globl vector143
vector143:
  pushl $0
80105eca:	6a 00                	push   $0x0
  pushl $143
80105ecc:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105ed1:	e9 47 f6 ff ff       	jmp    8010551d <alltraps>

80105ed6 <vector144>:
.globl vector144
vector144:
  pushl $0
80105ed6:	6a 00                	push   $0x0
  pushl $144
80105ed8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80105edd:	e9 3b f6 ff ff       	jmp    8010551d <alltraps>

80105ee2 <vector145>:
.globl vector145
vector145:
  pushl $0
80105ee2:	6a 00                	push   $0x0
  pushl $145
80105ee4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105ee9:	e9 2f f6 ff ff       	jmp    8010551d <alltraps>

80105eee <vector146>:
.globl vector146
vector146:
  pushl $0
80105eee:	6a 00                	push   $0x0
  pushl $146
80105ef0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80105ef5:	e9 23 f6 ff ff       	jmp    8010551d <alltraps>

80105efa <vector147>:
.globl vector147
vector147:
  pushl $0
80105efa:	6a 00                	push   $0x0
  pushl $147
80105efc:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105f01:	e9 17 f6 ff ff       	jmp    8010551d <alltraps>

80105f06 <vector148>:
.globl vector148
vector148:
  pushl $0
80105f06:	6a 00                	push   $0x0
  pushl $148
80105f08:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105f0d:	e9 0b f6 ff ff       	jmp    8010551d <alltraps>

80105f12 <vector149>:
.globl vector149
vector149:
  pushl $0
80105f12:	6a 00                	push   $0x0
  pushl $149
80105f14:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105f19:	e9 ff f5 ff ff       	jmp    8010551d <alltraps>

80105f1e <vector150>:
.globl vector150
vector150:
  pushl $0
80105f1e:	6a 00                	push   $0x0
  pushl $150
80105f20:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80105f25:	e9 f3 f5 ff ff       	jmp    8010551d <alltraps>

80105f2a <vector151>:
.globl vector151
vector151:
  pushl $0
80105f2a:	6a 00                	push   $0x0
  pushl $151
80105f2c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105f31:	e9 e7 f5 ff ff       	jmp    8010551d <alltraps>

80105f36 <vector152>:
.globl vector152
vector152:
  pushl $0
80105f36:	6a 00                	push   $0x0
  pushl $152
80105f38:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105f3d:	e9 db f5 ff ff       	jmp    8010551d <alltraps>

80105f42 <vector153>:
.globl vector153
vector153:
  pushl $0
80105f42:	6a 00                	push   $0x0
  pushl $153
80105f44:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105f49:	e9 cf f5 ff ff       	jmp    8010551d <alltraps>

80105f4e <vector154>:
.globl vector154
vector154:
  pushl $0
80105f4e:	6a 00                	push   $0x0
  pushl $154
80105f50:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80105f55:	e9 c3 f5 ff ff       	jmp    8010551d <alltraps>

80105f5a <vector155>:
.globl vector155
vector155:
  pushl $0
80105f5a:	6a 00                	push   $0x0
  pushl $155
80105f5c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105f61:	e9 b7 f5 ff ff       	jmp    8010551d <alltraps>

80105f66 <vector156>:
.globl vector156
vector156:
  pushl $0
80105f66:	6a 00                	push   $0x0
  pushl $156
80105f68:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105f6d:	e9 ab f5 ff ff       	jmp    8010551d <alltraps>

80105f72 <vector157>:
.globl vector157
vector157:
  pushl $0
80105f72:	6a 00                	push   $0x0
  pushl $157
80105f74:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105f79:	e9 9f f5 ff ff       	jmp    8010551d <alltraps>

80105f7e <vector158>:
.globl vector158
vector158:
  pushl $0
80105f7e:	6a 00                	push   $0x0
  pushl $158
80105f80:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80105f85:	e9 93 f5 ff ff       	jmp    8010551d <alltraps>

80105f8a <vector159>:
.globl vector159
vector159:
  pushl $0
80105f8a:	6a 00                	push   $0x0
  pushl $159
80105f8c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80105f91:	e9 87 f5 ff ff       	jmp    8010551d <alltraps>

80105f96 <vector160>:
.globl vector160
vector160:
  pushl $0
80105f96:	6a 00                	push   $0x0
  pushl $160
80105f98:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80105f9d:	e9 7b f5 ff ff       	jmp    8010551d <alltraps>

80105fa2 <vector161>:
.globl vector161
vector161:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $161
80105fa4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80105fa9:	e9 6f f5 ff ff       	jmp    8010551d <alltraps>

80105fae <vector162>:
.globl vector162
vector162:
  pushl $0
80105fae:	6a 00                	push   $0x0
  pushl $162
80105fb0:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80105fb5:	e9 63 f5 ff ff       	jmp    8010551d <alltraps>

80105fba <vector163>:
.globl vector163
vector163:
  pushl $0
80105fba:	6a 00                	push   $0x0
  pushl $163
80105fbc:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105fc1:	e9 57 f5 ff ff       	jmp    8010551d <alltraps>

80105fc6 <vector164>:
.globl vector164
vector164:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $164
80105fc8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80105fcd:	e9 4b f5 ff ff       	jmp    8010551d <alltraps>

80105fd2 <vector165>:
.globl vector165
vector165:
  pushl $0
80105fd2:	6a 00                	push   $0x0
  pushl $165
80105fd4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80105fd9:	e9 3f f5 ff ff       	jmp    8010551d <alltraps>

80105fde <vector166>:
.globl vector166
vector166:
  pushl $0
80105fde:	6a 00                	push   $0x0
  pushl $166
80105fe0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80105fe5:	e9 33 f5 ff ff       	jmp    8010551d <alltraps>

80105fea <vector167>:
.globl vector167
vector167:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $167
80105fec:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105ff1:	e9 27 f5 ff ff       	jmp    8010551d <alltraps>

80105ff6 <vector168>:
.globl vector168
vector168:
  pushl $0
80105ff6:	6a 00                	push   $0x0
  pushl $168
80105ff8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80105ffd:	e9 1b f5 ff ff       	jmp    8010551d <alltraps>

80106002 <vector169>:
.globl vector169
vector169:
  pushl $0
80106002:	6a 00                	push   $0x0
  pushl $169
80106004:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106009:	e9 0f f5 ff ff       	jmp    8010551d <alltraps>

8010600e <vector170>:
.globl vector170
vector170:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $170
80106010:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106015:	e9 03 f5 ff ff       	jmp    8010551d <alltraps>

8010601a <vector171>:
.globl vector171
vector171:
  pushl $0
8010601a:	6a 00                	push   $0x0
  pushl $171
8010601c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106021:	e9 f7 f4 ff ff       	jmp    8010551d <alltraps>

80106026 <vector172>:
.globl vector172
vector172:
  pushl $0
80106026:	6a 00                	push   $0x0
  pushl $172
80106028:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010602d:	e9 eb f4 ff ff       	jmp    8010551d <alltraps>

80106032 <vector173>:
.globl vector173
vector173:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $173
80106034:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106039:	e9 df f4 ff ff       	jmp    8010551d <alltraps>

8010603e <vector174>:
.globl vector174
vector174:
  pushl $0
8010603e:	6a 00                	push   $0x0
  pushl $174
80106040:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106045:	e9 d3 f4 ff ff       	jmp    8010551d <alltraps>

8010604a <vector175>:
.globl vector175
vector175:
  pushl $0
8010604a:	6a 00                	push   $0x0
  pushl $175
8010604c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106051:	e9 c7 f4 ff ff       	jmp    8010551d <alltraps>

80106056 <vector176>:
.globl vector176
vector176:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $176
80106058:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010605d:	e9 bb f4 ff ff       	jmp    8010551d <alltraps>

80106062 <vector177>:
.globl vector177
vector177:
  pushl $0
80106062:	6a 00                	push   $0x0
  pushl $177
80106064:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106069:	e9 af f4 ff ff       	jmp    8010551d <alltraps>

8010606e <vector178>:
.globl vector178
vector178:
  pushl $0
8010606e:	6a 00                	push   $0x0
  pushl $178
80106070:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106075:	e9 a3 f4 ff ff       	jmp    8010551d <alltraps>

8010607a <vector179>:
.globl vector179
vector179:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $179
8010607c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106081:	e9 97 f4 ff ff       	jmp    8010551d <alltraps>

80106086 <vector180>:
.globl vector180
vector180:
  pushl $0
80106086:	6a 00                	push   $0x0
  pushl $180
80106088:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010608d:	e9 8b f4 ff ff       	jmp    8010551d <alltraps>

80106092 <vector181>:
.globl vector181
vector181:
  pushl $0
80106092:	6a 00                	push   $0x0
  pushl $181
80106094:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106099:	e9 7f f4 ff ff       	jmp    8010551d <alltraps>

8010609e <vector182>:
.globl vector182
vector182:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $182
801060a0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801060a5:	e9 73 f4 ff ff       	jmp    8010551d <alltraps>

801060aa <vector183>:
.globl vector183
vector183:
  pushl $0
801060aa:	6a 00                	push   $0x0
  pushl $183
801060ac:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801060b1:	e9 67 f4 ff ff       	jmp    8010551d <alltraps>

801060b6 <vector184>:
.globl vector184
vector184:
  pushl $0
801060b6:	6a 00                	push   $0x0
  pushl $184
801060b8:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801060bd:	e9 5b f4 ff ff       	jmp    8010551d <alltraps>

801060c2 <vector185>:
.globl vector185
vector185:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $185
801060c4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801060c9:	e9 4f f4 ff ff       	jmp    8010551d <alltraps>

801060ce <vector186>:
.globl vector186
vector186:
  pushl $0
801060ce:	6a 00                	push   $0x0
  pushl $186
801060d0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801060d5:	e9 43 f4 ff ff       	jmp    8010551d <alltraps>

801060da <vector187>:
.globl vector187
vector187:
  pushl $0
801060da:	6a 00                	push   $0x0
  pushl $187
801060dc:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801060e1:	e9 37 f4 ff ff       	jmp    8010551d <alltraps>

801060e6 <vector188>:
.globl vector188
vector188:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $188
801060e8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801060ed:	e9 2b f4 ff ff       	jmp    8010551d <alltraps>

801060f2 <vector189>:
.globl vector189
vector189:
  pushl $0
801060f2:	6a 00                	push   $0x0
  pushl $189
801060f4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801060f9:	e9 1f f4 ff ff       	jmp    8010551d <alltraps>

801060fe <vector190>:
.globl vector190
vector190:
  pushl $0
801060fe:	6a 00                	push   $0x0
  pushl $190
80106100:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106105:	e9 13 f4 ff ff       	jmp    8010551d <alltraps>

8010610a <vector191>:
.globl vector191
vector191:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $191
8010610c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106111:	e9 07 f4 ff ff       	jmp    8010551d <alltraps>

80106116 <vector192>:
.globl vector192
vector192:
  pushl $0
80106116:	6a 00                	push   $0x0
  pushl $192
80106118:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010611d:	e9 fb f3 ff ff       	jmp    8010551d <alltraps>

80106122 <vector193>:
.globl vector193
vector193:
  pushl $0
80106122:	6a 00                	push   $0x0
  pushl $193
80106124:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106129:	e9 ef f3 ff ff       	jmp    8010551d <alltraps>

8010612e <vector194>:
.globl vector194
vector194:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $194
80106130:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106135:	e9 e3 f3 ff ff       	jmp    8010551d <alltraps>

8010613a <vector195>:
.globl vector195
vector195:
  pushl $0
8010613a:	6a 00                	push   $0x0
  pushl $195
8010613c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106141:	e9 d7 f3 ff ff       	jmp    8010551d <alltraps>

80106146 <vector196>:
.globl vector196
vector196:
  pushl $0
80106146:	6a 00                	push   $0x0
  pushl $196
80106148:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010614d:	e9 cb f3 ff ff       	jmp    8010551d <alltraps>

80106152 <vector197>:
.globl vector197
vector197:
  pushl $0
80106152:	6a 00                	push   $0x0
  pushl $197
80106154:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106159:	e9 bf f3 ff ff       	jmp    8010551d <alltraps>

8010615e <vector198>:
.globl vector198
vector198:
  pushl $0
8010615e:	6a 00                	push   $0x0
  pushl $198
80106160:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106165:	e9 b3 f3 ff ff       	jmp    8010551d <alltraps>

8010616a <vector199>:
.globl vector199
vector199:
  pushl $0
8010616a:	6a 00                	push   $0x0
  pushl $199
8010616c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106171:	e9 a7 f3 ff ff       	jmp    8010551d <alltraps>

80106176 <vector200>:
.globl vector200
vector200:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $200
80106178:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010617d:	e9 9b f3 ff ff       	jmp    8010551d <alltraps>

80106182 <vector201>:
.globl vector201
vector201:
  pushl $0
80106182:	6a 00                	push   $0x0
  pushl $201
80106184:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106189:	e9 8f f3 ff ff       	jmp    8010551d <alltraps>

8010618e <vector202>:
.globl vector202
vector202:
  pushl $0
8010618e:	6a 00                	push   $0x0
  pushl $202
80106190:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106195:	e9 83 f3 ff ff       	jmp    8010551d <alltraps>

8010619a <vector203>:
.globl vector203
vector203:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $203
8010619c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801061a1:	e9 77 f3 ff ff       	jmp    8010551d <alltraps>

801061a6 <vector204>:
.globl vector204
vector204:
  pushl $0
801061a6:	6a 00                	push   $0x0
  pushl $204
801061a8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801061ad:	e9 6b f3 ff ff       	jmp    8010551d <alltraps>

801061b2 <vector205>:
.globl vector205
vector205:
  pushl $0
801061b2:	6a 00                	push   $0x0
  pushl $205
801061b4:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801061b9:	e9 5f f3 ff ff       	jmp    8010551d <alltraps>

801061be <vector206>:
.globl vector206
vector206:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $206
801061c0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801061c5:	e9 53 f3 ff ff       	jmp    8010551d <alltraps>

801061ca <vector207>:
.globl vector207
vector207:
  pushl $0
801061ca:	6a 00                	push   $0x0
  pushl $207
801061cc:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801061d1:	e9 47 f3 ff ff       	jmp    8010551d <alltraps>

801061d6 <vector208>:
.globl vector208
vector208:
  pushl $0
801061d6:	6a 00                	push   $0x0
  pushl $208
801061d8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801061dd:	e9 3b f3 ff ff       	jmp    8010551d <alltraps>

801061e2 <vector209>:
.globl vector209
vector209:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $209
801061e4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801061e9:	e9 2f f3 ff ff       	jmp    8010551d <alltraps>

801061ee <vector210>:
.globl vector210
vector210:
  pushl $0
801061ee:	6a 00                	push   $0x0
  pushl $210
801061f0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801061f5:	e9 23 f3 ff ff       	jmp    8010551d <alltraps>

801061fa <vector211>:
.globl vector211
vector211:
  pushl $0
801061fa:	6a 00                	push   $0x0
  pushl $211
801061fc:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106201:	e9 17 f3 ff ff       	jmp    8010551d <alltraps>

80106206 <vector212>:
.globl vector212
vector212:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $212
80106208:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010620d:	e9 0b f3 ff ff       	jmp    8010551d <alltraps>

80106212 <vector213>:
.globl vector213
vector213:
  pushl $0
80106212:	6a 00                	push   $0x0
  pushl $213
80106214:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106219:	e9 ff f2 ff ff       	jmp    8010551d <alltraps>

8010621e <vector214>:
.globl vector214
vector214:
  pushl $0
8010621e:	6a 00                	push   $0x0
  pushl $214
80106220:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106225:	e9 f3 f2 ff ff       	jmp    8010551d <alltraps>

8010622a <vector215>:
.globl vector215
vector215:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $215
8010622c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106231:	e9 e7 f2 ff ff       	jmp    8010551d <alltraps>

80106236 <vector216>:
.globl vector216
vector216:
  pushl $0
80106236:	6a 00                	push   $0x0
  pushl $216
80106238:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010623d:	e9 db f2 ff ff       	jmp    8010551d <alltraps>

80106242 <vector217>:
.globl vector217
vector217:
  pushl $0
80106242:	6a 00                	push   $0x0
  pushl $217
80106244:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106249:	e9 cf f2 ff ff       	jmp    8010551d <alltraps>

8010624e <vector218>:
.globl vector218
vector218:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $218
80106250:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106255:	e9 c3 f2 ff ff       	jmp    8010551d <alltraps>

8010625a <vector219>:
.globl vector219
vector219:
  pushl $0
8010625a:	6a 00                	push   $0x0
  pushl $219
8010625c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106261:	e9 b7 f2 ff ff       	jmp    8010551d <alltraps>

80106266 <vector220>:
.globl vector220
vector220:
  pushl $0
80106266:	6a 00                	push   $0x0
  pushl $220
80106268:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010626d:	e9 ab f2 ff ff       	jmp    8010551d <alltraps>

80106272 <vector221>:
.globl vector221
vector221:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $221
80106274:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106279:	e9 9f f2 ff ff       	jmp    8010551d <alltraps>

8010627e <vector222>:
.globl vector222
vector222:
  pushl $0
8010627e:	6a 00                	push   $0x0
  pushl $222
80106280:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106285:	e9 93 f2 ff ff       	jmp    8010551d <alltraps>

8010628a <vector223>:
.globl vector223
vector223:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $223
8010628c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106291:	e9 87 f2 ff ff       	jmp    8010551d <alltraps>

80106296 <vector224>:
.globl vector224
vector224:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $224
80106298:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010629d:	e9 7b f2 ff ff       	jmp    8010551d <alltraps>

801062a2 <vector225>:
.globl vector225
vector225:
  pushl $0
801062a2:	6a 00                	push   $0x0
  pushl $225
801062a4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801062a9:	e9 6f f2 ff ff       	jmp    8010551d <alltraps>

801062ae <vector226>:
.globl vector226
vector226:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $226
801062b0:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801062b5:	e9 63 f2 ff ff       	jmp    8010551d <alltraps>

801062ba <vector227>:
.globl vector227
vector227:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $227
801062bc:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801062c1:	e9 57 f2 ff ff       	jmp    8010551d <alltraps>

801062c6 <vector228>:
.globl vector228
vector228:
  pushl $0
801062c6:	6a 00                	push   $0x0
  pushl $228
801062c8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801062cd:	e9 4b f2 ff ff       	jmp    8010551d <alltraps>

801062d2 <vector229>:
.globl vector229
vector229:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $229
801062d4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801062d9:	e9 3f f2 ff ff       	jmp    8010551d <alltraps>

801062de <vector230>:
.globl vector230
vector230:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $230
801062e0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801062e5:	e9 33 f2 ff ff       	jmp    8010551d <alltraps>

801062ea <vector231>:
.globl vector231
vector231:
  pushl $0
801062ea:	6a 00                	push   $0x0
  pushl $231
801062ec:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801062f1:	e9 27 f2 ff ff       	jmp    8010551d <alltraps>

801062f6 <vector232>:
.globl vector232
vector232:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $232
801062f8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801062fd:	e9 1b f2 ff ff       	jmp    8010551d <alltraps>

80106302 <vector233>:
.globl vector233
vector233:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $233
80106304:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106309:	e9 0f f2 ff ff       	jmp    8010551d <alltraps>

8010630e <vector234>:
.globl vector234
vector234:
  pushl $0
8010630e:	6a 00                	push   $0x0
  pushl $234
80106310:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106315:	e9 03 f2 ff ff       	jmp    8010551d <alltraps>

8010631a <vector235>:
.globl vector235
vector235:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $235
8010631c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106321:	e9 f7 f1 ff ff       	jmp    8010551d <alltraps>

80106326 <vector236>:
.globl vector236
vector236:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $236
80106328:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010632d:	e9 eb f1 ff ff       	jmp    8010551d <alltraps>

80106332 <vector237>:
.globl vector237
vector237:
  pushl $0
80106332:	6a 00                	push   $0x0
  pushl $237
80106334:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106339:	e9 df f1 ff ff       	jmp    8010551d <alltraps>

8010633e <vector238>:
.globl vector238
vector238:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $238
80106340:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106345:	e9 d3 f1 ff ff       	jmp    8010551d <alltraps>

8010634a <vector239>:
.globl vector239
vector239:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $239
8010634c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106351:	e9 c7 f1 ff ff       	jmp    8010551d <alltraps>

80106356 <vector240>:
.globl vector240
vector240:
  pushl $0
80106356:	6a 00                	push   $0x0
  pushl $240
80106358:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010635d:	e9 bb f1 ff ff       	jmp    8010551d <alltraps>

80106362 <vector241>:
.globl vector241
vector241:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $241
80106364:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106369:	e9 af f1 ff ff       	jmp    8010551d <alltraps>

8010636e <vector242>:
.globl vector242
vector242:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $242
80106370:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106375:	e9 a3 f1 ff ff       	jmp    8010551d <alltraps>

8010637a <vector243>:
.globl vector243
vector243:
  pushl $0
8010637a:	6a 00                	push   $0x0
  pushl $243
8010637c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106381:	e9 97 f1 ff ff       	jmp    8010551d <alltraps>

80106386 <vector244>:
.globl vector244
vector244:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $244
80106388:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010638d:	e9 8b f1 ff ff       	jmp    8010551d <alltraps>

80106392 <vector245>:
.globl vector245
vector245:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $245
80106394:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106399:	e9 7f f1 ff ff       	jmp    8010551d <alltraps>

8010639e <vector246>:
.globl vector246
vector246:
  pushl $0
8010639e:	6a 00                	push   $0x0
  pushl $246
801063a0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801063a5:	e9 73 f1 ff ff       	jmp    8010551d <alltraps>

801063aa <vector247>:
.globl vector247
vector247:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $247
801063ac:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801063b1:	e9 67 f1 ff ff       	jmp    8010551d <alltraps>

801063b6 <vector248>:
.globl vector248
vector248:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $248
801063b8:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801063bd:	e9 5b f1 ff ff       	jmp    8010551d <alltraps>

801063c2 <vector249>:
.globl vector249
vector249:
  pushl $0
801063c2:	6a 00                	push   $0x0
  pushl $249
801063c4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801063c9:	e9 4f f1 ff ff       	jmp    8010551d <alltraps>

801063ce <vector250>:
.globl vector250
vector250:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $250
801063d0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801063d5:	e9 43 f1 ff ff       	jmp    8010551d <alltraps>

801063da <vector251>:
.globl vector251
vector251:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $251
801063dc:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801063e1:	e9 37 f1 ff ff       	jmp    8010551d <alltraps>

801063e6 <vector252>:
.globl vector252
vector252:
  pushl $0
801063e6:	6a 00                	push   $0x0
  pushl $252
801063e8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801063ed:	e9 2b f1 ff ff       	jmp    8010551d <alltraps>

801063f2 <vector253>:
.globl vector253
vector253:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $253
801063f4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801063f9:	e9 1f f1 ff ff       	jmp    8010551d <alltraps>

801063fe <vector254>:
.globl vector254
vector254:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $254
80106400:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106405:	e9 13 f1 ff ff       	jmp    8010551d <alltraps>

8010640a <vector255>:
.globl vector255
vector255:
  pushl $0
8010640a:	6a 00                	push   $0x0
  pushl $255
8010640c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106411:	e9 07 f1 ff ff       	jmp    8010551d <alltraps>
80106416:	66 90                	xchg   %ax,%ax
80106418:	66 90                	xchg   %ax,%ax
8010641a:	66 90                	xchg   %ax,%ax
8010641c:	66 90                	xchg   %ax,%ax
8010641e:	66 90                	xchg   %ax,%ax

80106420 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	57                   	push   %edi
80106424:	56                   	push   %esi
80106425:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106427:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010642a:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010642b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010642e:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106431:	8b 1f                	mov    (%edi),%ebx
80106433:	f6 c3 01             	test   $0x1,%bl
80106436:	74 28                	je     80106460 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106438:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010643e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106444:	c1 ee 0a             	shr    $0xa,%esi
}
80106447:	83 c4 1c             	add    $0x1c,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
8010644a:	89 f2                	mov    %esi,%edx
8010644c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106452:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106455:	5b                   	pop    %ebx
80106456:	5e                   	pop    %esi
80106457:	5f                   	pop    %edi
80106458:	5d                   	pop    %ebp
80106459:	c3                   	ret    
8010645a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106460:	85 c9                	test   %ecx,%ecx
80106462:	74 34                	je     80106498 <walkpgdir+0x78>
80106464:	e8 a7 c1 ff ff       	call   80102610 <kalloc>
80106469:	85 c0                	test   %eax,%eax
8010646b:	89 c3                	mov    %eax,%ebx
8010646d:	74 29                	je     80106498 <walkpgdir+0x78>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010646f:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106476:	00 
80106477:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010647e:	00 
8010647f:	89 04 24             	mov    %eax,(%esp)
80106482:	e8 79 df ff ff       	call   80104400 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106487:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010648d:	83 c8 07             	or     $0x7,%eax
80106490:	89 07                	mov    %eax,(%edi)
80106492:	eb b0                	jmp    80106444 <walkpgdir+0x24>
80106494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
80106498:	83 c4 1c             	add    $0x1c,%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
8010649b:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
8010649d:	5b                   	pop    %ebx
8010649e:	5e                   	pop    %esi
8010649f:	5f                   	pop    %edi
801064a0:	5d                   	pop    %ebp
801064a1:	c3                   	ret    
801064a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064b0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	57                   	push   %edi
801064b4:	56                   	push   %esi
801064b5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801064b6:	89 d3                	mov    %edx,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064b8:	83 ec 1c             	sub    $0x1c,%esp
801064bb:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801064be:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801064c7:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801064cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801064ce:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801064d2:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
801064d9:	29 df                	sub    %ebx,%edi
801064db:	eb 18                	jmp    801064f5 <mappages+0x45>
801064dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801064e0:	f6 00 01             	testb  $0x1,(%eax)
801064e3:	75 3d                	jne    80106522 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
801064e5:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
801064e8:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801064eb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801064ed:	74 29                	je     80106518 <mappages+0x68>
      break;
    a += PGSIZE;
801064ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801064f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801064f8:	b9 01 00 00 00       	mov    $0x1,%ecx
801064fd:	89 da                	mov    %ebx,%edx
801064ff:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106502:	e8 19 ff ff ff       	call   80106420 <walkpgdir>
80106507:	85 c0                	test   %eax,%eax
80106509:	75 d5                	jne    801064e0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010650b:	83 c4 1c             	add    $0x1c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010650e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106513:	5b                   	pop    %ebx
80106514:	5e                   	pop    %esi
80106515:	5f                   	pop    %edi
80106516:	5d                   	pop    %ebp
80106517:	c3                   	ret    
80106518:	83 c4 1c             	add    $0x1c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
8010651b:	31 c0                	xor    %eax,%eax
}
8010651d:	5b                   	pop    %ebx
8010651e:	5e                   	pop    %esi
8010651f:	5f                   	pop    %edi
80106520:	5d                   	pop    %ebp
80106521:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106522:	c7 04 24 08 76 10 80 	movl   $0x80107608,(%esp)
80106529:	e8 32 9e ff ff       	call   80100360 <panic>
8010652e:	66 90                	xchg   %ax,%ax

80106530 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106530:	55                   	push   %ebp
80106531:	89 e5                	mov    %esp,%ebp
80106533:	57                   	push   %edi
80106534:	89 c7                	mov    %eax,%edi
80106536:	56                   	push   %esi
80106537:	89 d6                	mov    %edx,%esi
80106539:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010653a:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106540:	83 ec 1c             	sub    $0x1c,%esp
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106543:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106549:	39 d3                	cmp    %edx,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010654b:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010654e:	72 3b                	jb     8010658b <deallocuvm.part.0+0x5b>
80106550:	eb 5e                	jmp    801065b0 <deallocuvm.part.0+0x80>
80106552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106558:	8b 10                	mov    (%eax),%edx
8010655a:	f6 c2 01             	test   $0x1,%dl
8010655d:	74 22                	je     80106581 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010655f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106565:	74 54                	je     801065bb <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80106567:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
8010656d:	89 14 24             	mov    %edx,(%esp)
80106570:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106573:	e8 e8 be ff ff       	call   80102460 <kfree>
      *pte = 0;
80106578:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010657b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106581:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106587:	39 f3                	cmp    %esi,%ebx
80106589:	73 25                	jae    801065b0 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010658b:	31 c9                	xor    %ecx,%ecx
8010658d:	89 da                	mov    %ebx,%edx
8010658f:	89 f8                	mov    %edi,%eax
80106591:	e8 8a fe ff ff       	call   80106420 <walkpgdir>
    if(!pte)
80106596:	85 c0                	test   %eax,%eax
80106598:	75 be                	jne    80106558 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010659a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801065a0:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801065a6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801065ac:	39 f3                	cmp    %esi,%ebx
801065ae:	72 db                	jb     8010658b <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801065b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801065b3:	83 c4 1c             	add    $0x1c,%esp
801065b6:	5b                   	pop    %ebx
801065b7:	5e                   	pop    %esi
801065b8:	5f                   	pop    %edi
801065b9:	5d                   	pop    %ebp
801065ba:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
801065bb:	c7 04 24 a6 6f 10 80 	movl   $0x80106fa6,(%esp)
801065c2:	e8 99 9d ff ff       	call   80100360 <panic>
801065c7:	89 f6                	mov    %esi,%esi
801065c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065d0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801065d0:	55                   	push   %ebp
801065d1:	89 e5                	mov    %esp,%ebp
801065d3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
801065d6:	e8 05 d2 ff ff       	call   801037e0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065db:	31 c9                	xor    %ecx,%ecx
801065dd:	ba ff ff ff ff       	mov    $0xffffffff,%edx

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
801065e2:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801065e8:	05 a0 27 11 80       	add    $0x801127a0,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065ed:	66 89 50 78          	mov    %dx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065f1:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  lgdt(c->gdt, sizeof(c->gdt));
801065f6:	83 c0 70             	add    $0x70,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065f9:	66 89 48 0a          	mov    %cx,0xa(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065fd:	31 c9                	xor    %ecx,%ecx
801065ff:	66 89 50 10          	mov    %dx,0x10(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106603:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106608:	66 89 48 12          	mov    %cx,0x12(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010660c:	31 c9                	xor    %ecx,%ecx
8010660e:	66 89 50 18          	mov    %dx,0x18(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106612:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106617:	66 89 48 1a          	mov    %cx,0x1a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010661b:	31 c9                	xor    %ecx,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010661d:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
80106621:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106625:	c6 40 15 92          	movb   $0x92,0x15(%eax)
80106629:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010662d:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
80106631:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106635:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
80106639:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
8010663d:	66 89 50 20          	mov    %dx,0x20(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106641:	ba 2f 00 00 00       	mov    $0x2f,%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106646:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
8010664a:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010664e:	c6 40 14 00          	movb   $0x0,0x14(%eax)
80106652:	c6 40 17 00          	movb   $0x0,0x17(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106656:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
8010665a:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010665e:	66 89 48 22          	mov    %cx,0x22(%eax)
80106662:	c6 40 24 00          	movb   $0x0,0x24(%eax)
80106666:	c6 40 27 00          	movb   $0x0,0x27(%eax)
8010666a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
8010666e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106672:	c1 e8 10             	shr    $0x10,%eax
80106675:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106679:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010667c:	0f 01 10             	lgdtl  (%eax)
  lgdt(c->gdt, sizeof(c->gdt));
}
8010667f:	c9                   	leave  
80106680:	c3                   	ret    
80106681:	eb 0d                	jmp    80106690 <switchkvm>
80106683:	90                   	nop
80106684:	90                   	nop
80106685:	90                   	nop
80106686:	90                   	nop
80106687:	90                   	nop
80106688:	90                   	nop
80106689:	90                   	nop
8010668a:	90                   	nop
8010668b:	90                   	nop
8010668c:	90                   	nop
8010668d:	90                   	nop
8010668e:	90                   	nop
8010668f:	90                   	nop

80106690 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106690:	a1 c4 54 11 80       	mov    0x801154c4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106695:	55                   	push   %ebp
80106696:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106698:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010669d:	0f 22 d8             	mov    %eax,%cr3
}
801066a0:	5d                   	pop    %ebp
801066a1:	c3                   	ret    
801066a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066b0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801066b0:	55                   	push   %ebp
801066b1:	89 e5                	mov    %esp,%ebp
801066b3:	57                   	push   %edi
801066b4:	56                   	push   %esi
801066b5:	53                   	push   %ebx
801066b6:	83 ec 1c             	sub    $0x1c,%esp
801066b9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801066bc:	85 f6                	test   %esi,%esi
801066be:	0f 84 cd 00 00 00    	je     80106791 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
801066c4:	8b 46 08             	mov    0x8(%esi),%eax
801066c7:	85 c0                	test   %eax,%eax
801066c9:	0f 84 da 00 00 00    	je     801067a9 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
801066cf:	8b 7e 04             	mov    0x4(%esi),%edi
801066d2:	85 ff                	test   %edi,%edi
801066d4:	0f 84 c3 00 00 00    	je     8010679d <switchuvm+0xed>
    panic("switchuvm: no pgdir");

  pushcli();
801066da:	e8 71 db ff ff       	call   80104250 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801066df:	e8 7c d0 ff ff       	call   80103760 <mycpu>
801066e4:	89 c3                	mov    %eax,%ebx
801066e6:	e8 75 d0 ff ff       	call   80103760 <mycpu>
801066eb:	89 c7                	mov    %eax,%edi
801066ed:	e8 6e d0 ff ff       	call   80103760 <mycpu>
801066f2:	83 c7 08             	add    $0x8,%edi
801066f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801066f8:	e8 63 d0 ff ff       	call   80103760 <mycpu>
801066fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106700:	ba 67 00 00 00       	mov    $0x67,%edx
80106705:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
8010670c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106713:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
8010671a:	83 c1 08             	add    $0x8,%ecx
8010671d:	c1 e9 10             	shr    $0x10,%ecx
80106720:	83 c0 08             	add    $0x8,%eax
80106723:	c1 e8 18             	shr    $0x18,%eax
80106726:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010672c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106733:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106739:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
8010673e:	e8 1d d0 ff ff       	call   80103760 <mycpu>
80106743:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010674a:	e8 11 d0 ff ff       	call   80103760 <mycpu>
8010674f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106754:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106758:	e8 03 d0 ff ff       	call   80103760 <mycpu>
8010675d:	8b 56 08             	mov    0x8(%esi),%edx
80106760:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106766:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106769:	e8 f2 cf ff ff       	call   80103760 <mycpu>
8010676e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106772:	b8 28 00 00 00       	mov    $0x28,%eax
80106777:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010677a:	8b 46 04             	mov    0x4(%esi),%eax
8010677d:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106782:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80106785:	83 c4 1c             	add    $0x1c,%esp
80106788:	5b                   	pop    %ebx
80106789:	5e                   	pop    %esi
8010678a:	5f                   	pop    %edi
8010678b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
8010678c:	e9 ff da ff ff       	jmp    80104290 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106791:	c7 04 24 0e 76 10 80 	movl   $0x8010760e,(%esp)
80106798:	e8 c3 9b ff ff       	call   80100360 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
8010679d:	c7 04 24 39 76 10 80 	movl   $0x80107639,(%esp)
801067a4:	e8 b7 9b ff ff       	call   80100360 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
801067a9:	c7 04 24 24 76 10 80 	movl   $0x80107624,(%esp)
801067b0:	e8 ab 9b ff ff       	call   80100360 <panic>
801067b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067c0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801067c0:	55                   	push   %ebp
801067c1:	89 e5                	mov    %esp,%ebp
801067c3:	57                   	push   %edi
801067c4:	56                   	push   %esi
801067c5:	53                   	push   %ebx
801067c6:	83 ec 1c             	sub    $0x1c,%esp
801067c9:	8b 75 10             	mov    0x10(%ebp),%esi
801067cc:	8b 45 08             	mov    0x8(%ebp),%eax
801067cf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
801067d2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801067d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
801067db:	77 54                	ja     80106831 <inituvm+0x71>
    panic("inituvm: more than a page");
  mem = kalloc();
801067dd:	e8 2e be ff ff       	call   80102610 <kalloc>
  memset(mem, 0, PGSIZE);
801067e2:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801067e9:	00 
801067ea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801067f1:	00 
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
801067f2:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801067f4:	89 04 24             	mov    %eax,(%esp)
801067f7:	e8 04 dc ff ff       	call   80104400 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801067fc:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106802:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106807:	89 04 24             	mov    %eax,(%esp)
8010680a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010680d:	31 d2                	xor    %edx,%edx
8010680f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106816:	00 
80106817:	e8 94 fc ff ff       	call   801064b0 <mappages>
  memmove(mem, init, sz);
8010681c:	89 75 10             	mov    %esi,0x10(%ebp)
8010681f:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106822:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106825:	83 c4 1c             	add    $0x1c,%esp
80106828:	5b                   	pop    %ebx
80106829:	5e                   	pop    %esi
8010682a:	5f                   	pop    %edi
8010682b:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
8010682c:	e9 6f dc ff ff       	jmp    801044a0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106831:	c7 04 24 4d 76 10 80 	movl   $0x8010764d,(%esp)
80106838:	e8 23 9b ff ff       	call   80100360 <panic>
8010683d:	8d 76 00             	lea    0x0(%esi),%esi

80106840 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106840:	55                   	push   %ebp
80106841:	89 e5                	mov    %esp,%ebp
80106843:	57                   	push   %edi
80106844:	56                   	push   %esi
80106845:	53                   	push   %ebx
80106846:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106849:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106850:	0f 85 98 00 00 00    	jne    801068ee <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106856:	8b 75 18             	mov    0x18(%ebp),%esi
80106859:	31 db                	xor    %ebx,%ebx
8010685b:	85 f6                	test   %esi,%esi
8010685d:	75 1a                	jne    80106879 <loaduvm+0x39>
8010685f:	eb 77                	jmp    801068d8 <loaduvm+0x98>
80106861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106868:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010686e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106874:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106877:	76 5f                	jbe    801068d8 <loaduvm+0x98>
80106879:	8b 55 0c             	mov    0xc(%ebp),%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010687c:	31 c9                	xor    %ecx,%ecx
8010687e:	8b 45 08             	mov    0x8(%ebp),%eax
80106881:	01 da                	add    %ebx,%edx
80106883:	e8 98 fb ff ff       	call   80106420 <walkpgdir>
80106888:	85 c0                	test   %eax,%eax
8010688a:	74 56                	je     801068e2 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010688c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
8010688e:	bf 00 10 00 00       	mov    $0x1000,%edi
80106893:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106896:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
8010689b:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
801068a1:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801068a4:	05 00 00 00 80       	add    $0x80000000,%eax
801068a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801068ad:	8b 45 10             	mov    0x10(%ebp),%eax
801068b0:	01 d9                	add    %ebx,%ecx
801068b2:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801068b6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801068ba:	89 04 24             	mov    %eax,(%esp)
801068bd:	e8 0e b2 ff ff       	call   80101ad0 <readi>
801068c2:	39 f8                	cmp    %edi,%eax
801068c4:	74 a2                	je     80106868 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801068c6:	83 c4 1c             	add    $0x1c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
801068c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801068ce:	5b                   	pop    %ebx
801068cf:	5e                   	pop    %esi
801068d0:	5f                   	pop    %edi
801068d1:	5d                   	pop    %ebp
801068d2:	c3                   	ret    
801068d3:	90                   	nop
801068d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801068d8:	83 c4 1c             	add    $0x1c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801068db:	31 c0                	xor    %eax,%eax
}
801068dd:	5b                   	pop    %ebx
801068de:	5e                   	pop    %esi
801068df:	5f                   	pop    %edi
801068e0:	5d                   	pop    %ebp
801068e1:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801068e2:	c7 04 24 67 76 10 80 	movl   $0x80107667,(%esp)
801068e9:	e8 72 9a ff ff       	call   80100360 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
801068ee:	c7 04 24 08 77 10 80 	movl   $0x80107708,(%esp)
801068f5:	e8 66 9a ff ff       	call   80100360 <panic>
801068fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106900 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	57                   	push   %edi
80106904:	56                   	push   %esi
80106905:	53                   	push   %ebx
80106906:	83 ec 1c             	sub    $0x1c,%esp
80106909:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010690c:	85 ff                	test   %edi,%edi
8010690e:	0f 88 7e 00 00 00    	js     80106992 <allocuvm+0x92>
    return 0;
  if(newsz < oldsz)
80106914:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106917:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010691a:	72 78                	jb     80106994 <allocuvm+0x94>
    return oldsz;

  a = PGROUNDUP(oldsz);
8010691c:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106922:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106928:	39 df                	cmp    %ebx,%edi
8010692a:	77 4a                	ja     80106976 <allocuvm+0x76>
8010692c:	eb 72                	jmp    801069a0 <allocuvm+0xa0>
8010692e:	66 90                	xchg   %ax,%ax
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106930:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106937:	00 
80106938:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010693f:	00 
80106940:	89 04 24             	mov    %eax,(%esp)
80106943:	e8 b8 da ff ff       	call   80104400 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106948:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010694e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106953:	89 04 24             	mov    %eax,(%esp)
80106956:	8b 45 08             	mov    0x8(%ebp),%eax
80106959:	89 da                	mov    %ebx,%edx
8010695b:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106962:	00 
80106963:	e8 48 fb ff ff       	call   801064b0 <mappages>
80106968:	85 c0                	test   %eax,%eax
8010696a:	78 44                	js     801069b0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
8010696c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106972:	39 df                	cmp    %ebx,%edi
80106974:	76 2a                	jbe    801069a0 <allocuvm+0xa0>
    mem = kalloc();
80106976:	e8 95 bc ff ff       	call   80102610 <kalloc>
    if(mem == 0){
8010697b:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
8010697d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010697f:	75 af                	jne    80106930 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106981:	c7 04 24 85 76 10 80 	movl   $0x80107685,(%esp)
80106988:	e8 93 9d ff ff       	call   80100720 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010698d:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106990:	77 48                	ja     801069da <allocuvm+0xda>
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106992:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106994:	83 c4 1c             	add    $0x1c,%esp
80106997:	5b                   	pop    %ebx
80106998:	5e                   	pop    %esi
80106999:	5f                   	pop    %edi
8010699a:	5d                   	pop    %ebp
8010699b:	c3                   	ret    
8010699c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801069a0:	83 c4 1c             	add    $0x1c,%esp
801069a3:	89 f8                	mov    %edi,%eax
801069a5:	5b                   	pop    %ebx
801069a6:	5e                   	pop    %esi
801069a7:	5f                   	pop    %edi
801069a8:	5d                   	pop    %ebp
801069a9:	c3                   	ret    
801069aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
801069b0:	c7 04 24 9d 76 10 80 	movl   $0x8010769d,(%esp)
801069b7:	e8 64 9d ff ff       	call   80100720 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069bc:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801069bf:	76 0d                	jbe    801069ce <allocuvm+0xce>
801069c1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801069c4:	89 fa                	mov    %edi,%edx
801069c6:	8b 45 08             	mov    0x8(%ebp),%eax
801069c9:	e8 62 fb ff ff       	call   80106530 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
801069ce:	89 34 24             	mov    %esi,(%esp)
801069d1:	e8 8a ba ff ff       	call   80102460 <kfree>
      return 0;
801069d6:	31 c0                	xor    %eax,%eax
801069d8:	eb ba                	jmp    80106994 <allocuvm+0x94>
801069da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801069dd:	89 fa                	mov    %edi,%edx
801069df:	8b 45 08             	mov    0x8(%ebp),%eax
801069e2:	e8 49 fb ff ff       	call   80106530 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
801069e7:	31 c0                	xor    %eax,%eax
801069e9:	eb a9                	jmp    80106994 <allocuvm+0x94>
801069eb:	90                   	nop
801069ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069f0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801069f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801069f9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069fc:	39 d1                	cmp    %edx,%ecx
801069fe:	73 08                	jae    80106a08 <deallocuvm+0x18>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a00:	5d                   	pop    %ebp
80106a01:	e9 2a fb ff ff       	jmp    80106530 <deallocuvm.part.0>
80106a06:	66 90                	xchg   %ax,%ax
80106a08:	89 d0                	mov    %edx,%eax
80106a0a:	5d                   	pop    %ebp
80106a0b:	c3                   	ret    
80106a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a10 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	56                   	push   %esi
80106a14:	53                   	push   %ebx
80106a15:	83 ec 10             	sub    $0x10,%esp
80106a18:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106a1b:	85 f6                	test   %esi,%esi
80106a1d:	74 59                	je     80106a78 <freevm+0x68>
80106a1f:	31 c9                	xor    %ecx,%ecx
80106a21:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106a26:	89 f0                	mov    %esi,%eax
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106a28:	31 db                	xor    %ebx,%ebx
80106a2a:	e8 01 fb ff ff       	call   80106530 <deallocuvm.part.0>
80106a2f:	eb 12                	jmp    80106a43 <freevm+0x33>
80106a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a38:	83 c3 01             	add    $0x1,%ebx
80106a3b:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106a41:	74 27                	je     80106a6a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106a43:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
80106a46:	f6 c2 01             	test   $0x1,%dl
80106a49:	74 ed                	je     80106a38 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106a4b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106a51:	83 c3 01             	add    $0x1,%ebx
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106a54:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106a5a:	89 14 24             	mov    %edx,(%esp)
80106a5d:	e8 fe b9 ff ff       	call   80102460 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106a62:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106a68:	75 d9                	jne    80106a43 <freevm+0x33>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106a6a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106a6d:	83 c4 10             	add    $0x10,%esp
80106a70:	5b                   	pop    %ebx
80106a71:	5e                   	pop    %esi
80106a72:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106a73:	e9 e8 b9 ff ff       	jmp    80102460 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106a78:	c7 04 24 b9 76 10 80 	movl   $0x801076b9,(%esp)
80106a7f:	e8 dc 98 ff ff       	call   80100360 <panic>
80106a84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106a90 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	56                   	push   %esi
80106a94:	53                   	push   %ebx
80106a95:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106a98:	e8 73 bb ff ff       	call   80102610 <kalloc>
80106a9d:	85 c0                	test   %eax,%eax
80106a9f:	89 c6                	mov    %eax,%esi
80106aa1:	74 6d                	je     80106b10 <setupkvm+0x80>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106aa3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106aaa:	00 
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106aab:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106ab0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106ab7:	00 
80106ab8:	89 04 24             	mov    %eax,(%esp)
80106abb:	e8 40 d9 ff ff       	call   80104400 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ac0:	8b 53 0c             	mov    0xc(%ebx),%edx
80106ac3:	8b 43 04             	mov    0x4(%ebx),%eax
80106ac6:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ac9:	89 54 24 04          	mov    %edx,0x4(%esp)
80106acd:	8b 13                	mov    (%ebx),%edx
80106acf:	89 04 24             	mov    %eax,(%esp)
80106ad2:	29 c1                	sub    %eax,%ecx
80106ad4:	89 f0                	mov    %esi,%eax
80106ad6:	e8 d5 f9 ff ff       	call   801064b0 <mappages>
80106adb:	85 c0                	test   %eax,%eax
80106add:	78 19                	js     80106af8 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106adf:	83 c3 10             	add    $0x10,%ebx
80106ae2:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106ae8:	72 d6                	jb     80106ac0 <setupkvm+0x30>
80106aea:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106aec:	83 c4 10             	add    $0x10,%esp
80106aef:	5b                   	pop    %ebx
80106af0:	5e                   	pop    %esi
80106af1:	5d                   	pop    %ebp
80106af2:	c3                   	ret    
80106af3:	90                   	nop
80106af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106af8:	89 34 24             	mov    %esi,(%esp)
80106afb:	e8 10 ff ff ff       	call   80106a10 <freevm>
      return 0;
    }
  return pgdir;
}
80106b00:	83 c4 10             	add    $0x10,%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106b03:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106b05:	5b                   	pop    %ebx
80106b06:	5e                   	pop    %esi
80106b07:	5d                   	pop    %ebp
80106b08:	c3                   	ret    
80106b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106b10:	31 c0                	xor    %eax,%eax
80106b12:	eb d8                	jmp    80106aec <setupkvm+0x5c>
80106b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106b20 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106b26:	e8 65 ff ff ff       	call   80106a90 <setupkvm>
80106b2b:	a3 c4 54 11 80       	mov    %eax,0x801154c4
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b30:	05 00 00 00 80       	add    $0x80000000,%eax
80106b35:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
80106b38:	c9                   	leave  
80106b39:	c3                   	ret    
80106b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b40 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b40:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b41:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b43:	89 e5                	mov    %esp,%ebp
80106b45:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b48:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b4b:	8b 45 08             	mov    0x8(%ebp),%eax
80106b4e:	e8 cd f8 ff ff       	call   80106420 <walkpgdir>
  if(pte == 0)
80106b53:	85 c0                	test   %eax,%eax
80106b55:	74 05                	je     80106b5c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106b57:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106b5a:	c9                   	leave  
80106b5b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106b5c:	c7 04 24 ca 76 10 80 	movl   $0x801076ca,(%esp)
80106b63:	e8 f8 97 ff ff       	call   80100360 <panic>
80106b68:	90                   	nop
80106b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b70 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	57                   	push   %edi
80106b74:	56                   	push   %esi
80106b75:	53                   	push   %ebx
80106b76:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106b79:	e8 12 ff ff ff       	call   80106a90 <setupkvm>
80106b7e:	85 c0                	test   %eax,%eax
80106b80:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106b83:	0f 84 b9 00 00 00    	je     80106c42 <copyuvm+0xd2>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106b89:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b8c:	85 c0                	test   %eax,%eax
80106b8e:	0f 84 94 00 00 00    	je     80106c28 <copyuvm+0xb8>
80106b94:	31 ff                	xor    %edi,%edi
80106b96:	eb 48                	jmp    80106be0 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106b98:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106b9e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106ba5:	00 
80106ba6:	89 74 24 04          	mov    %esi,0x4(%esp)
80106baa:	89 04 24             	mov    %eax,(%esp)
80106bad:	e8 ee d8 ff ff       	call   801044a0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106bb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bb5:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106bba:	89 fa                	mov    %edi,%edx
80106bbc:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bc0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106bc6:	89 04 24             	mov    %eax,(%esp)
80106bc9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106bcc:	e8 df f8 ff ff       	call   801064b0 <mappages>
80106bd1:	85 c0                	test   %eax,%eax
80106bd3:	78 63                	js     80106c38 <copyuvm+0xc8>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106bd5:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106bdb:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106bde:	76 48                	jbe    80106c28 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106be0:	8b 45 08             	mov    0x8(%ebp),%eax
80106be3:	31 c9                	xor    %ecx,%ecx
80106be5:	89 fa                	mov    %edi,%edx
80106be7:	e8 34 f8 ff ff       	call   80106420 <walkpgdir>
80106bec:	85 c0                	test   %eax,%eax
80106bee:	74 62                	je     80106c52 <copyuvm+0xe2>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106bf0:	8b 00                	mov    (%eax),%eax
80106bf2:	a8 01                	test   $0x1,%al
80106bf4:	74 50                	je     80106c46 <copyuvm+0xd6>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106bf6:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80106bf8:	25 ff 0f 00 00       	and    $0xfff,%eax
80106bfd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106c00:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106c06:	e8 05 ba ff ff       	call   80102610 <kalloc>
80106c0b:	85 c0                	test   %eax,%eax
80106c0d:	89 c3                	mov    %eax,%ebx
80106c0f:	75 87                	jne    80106b98 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80106c11:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c14:	89 04 24             	mov    %eax,(%esp)
80106c17:	e8 f4 fd ff ff       	call   80106a10 <freevm>
  return 0;
80106c1c:	31 c0                	xor    %eax,%eax
}
80106c1e:	83 c4 2c             	add    $0x2c,%esp
80106c21:	5b                   	pop    %ebx
80106c22:	5e                   	pop    %esi
80106c23:	5f                   	pop    %edi
80106c24:	5d                   	pop    %ebp
80106c25:	c3                   	ret    
80106c26:	66 90                	xchg   %ax,%ax
80106c28:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c2b:	83 c4 2c             	add    $0x2c,%esp
80106c2e:	5b                   	pop    %ebx
80106c2f:	5e                   	pop    %esi
80106c30:	5f                   	pop    %edi
80106c31:	5d                   	pop    %ebp
80106c32:	c3                   	ret    
80106c33:	90                   	nop
80106c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80106c38:	89 1c 24             	mov    %ebx,(%esp)
80106c3b:	e8 20 b8 ff ff       	call   80102460 <kfree>
      goto bad;
80106c40:	eb cf                	jmp    80106c11 <copyuvm+0xa1>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80106c42:	31 c0                	xor    %eax,%eax
80106c44:	eb d8                	jmp    80106c1e <copyuvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106c46:	c7 04 24 ee 76 10 80 	movl   $0x801076ee,(%esp)
80106c4d:	e8 0e 97 ff ff       	call   80100360 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106c52:	c7 04 24 d4 76 10 80 	movl   $0x801076d4,(%esp)
80106c59:	e8 02 97 ff ff       	call   80100360 <panic>
80106c5e:	66 90                	xchg   %ax,%ax

80106c60 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106c60:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106c61:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106c63:	89 e5                	mov    %esp,%ebp
80106c65:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106c68:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c6b:	8b 45 08             	mov    0x8(%ebp),%eax
80106c6e:	e8 ad f7 ff ff       	call   80106420 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106c73:	8b 00                	mov    (%eax),%eax
80106c75:	89 c2                	mov    %eax,%edx
80106c77:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
80106c7a:	83 fa 05             	cmp    $0x5,%edx
80106c7d:	75 11                	jne    80106c90 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106c7f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c84:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106c89:	c9                   	leave  
80106c8a:	c3                   	ret    
80106c8b:	90                   	nop
80106c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80106c90:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80106c92:	c9                   	leave  
80106c93:	c3                   	ret    
80106c94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ca0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	57                   	push   %edi
80106ca4:	56                   	push   %esi
80106ca5:	53                   	push   %ebx
80106ca6:	83 ec 1c             	sub    $0x1c,%esp
80106ca9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106cac:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106caf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106cb2:	85 db                	test   %ebx,%ebx
80106cb4:	75 3a                	jne    80106cf0 <copyout+0x50>
80106cb6:	eb 68                	jmp    80106d20 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106cb8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106cbb:	89 f2                	mov    %esi,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106cbd:	89 7c 24 04          	mov    %edi,0x4(%esp)
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106cc1:	29 ca                	sub    %ecx,%edx
80106cc3:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106cc9:	39 da                	cmp    %ebx,%edx
80106ccb:	0f 47 d3             	cmova  %ebx,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106cce:	29 f1                	sub    %esi,%ecx
80106cd0:	01 c8                	add    %ecx,%eax
80106cd2:	89 54 24 08          	mov    %edx,0x8(%esp)
80106cd6:	89 04 24             	mov    %eax,(%esp)
80106cd9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106cdc:	e8 bf d7 ff ff       	call   801044a0 <memmove>
    len -= n;
    buf += n;
80106ce1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80106ce4:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106cea:	01 d7                	add    %edx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106cec:	29 d3                	sub    %edx,%ebx
80106cee:	74 30                	je     80106d20 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
80106cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106cf3:	89 ce                	mov    %ecx,%esi
80106cf5:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106cfb:	89 74 24 04          	mov    %esi,0x4(%esp)
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106cff:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80106d02:	89 04 24             	mov    %eax,(%esp)
80106d05:	e8 56 ff ff ff       	call   80106c60 <uva2ka>
    if(pa0 == 0)
80106d0a:	85 c0                	test   %eax,%eax
80106d0c:	75 aa                	jne    80106cb8 <copyout+0x18>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106d0e:	83 c4 1c             	add    $0x1c,%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80106d11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106d16:	5b                   	pop    %ebx
80106d17:	5e                   	pop    %esi
80106d18:	5f                   	pop    %edi
80106d19:	5d                   	pop    %ebp
80106d1a:	c3                   	ret    
80106d1b:	90                   	nop
80106d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d20:	83 c4 1c             	add    $0x1c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106d23:	31 c0                	xor    %eax,%eax
}
80106d25:	5b                   	pop    %ebx
80106d26:	5e                   	pop    %esi
80106d27:	5f                   	pop    %edi
80106d28:	5d                   	pop    %ebp
80106d29:	c3                   	ret    
