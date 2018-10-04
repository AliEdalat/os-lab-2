
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
8010002d:	b8 b0 2e 10 80       	mov    $0x80102eb0,%eax
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
8010004c:	c7 44 24 04 a0 6c 10 	movl   $0x80106ca0,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010005b:	e8 d0 40 00 00       	call   80104130 <initlock>

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
80100094:	c7 44 24 04 a7 6c 10 	movl   $0x80106ca7,0x4(%esp)
8010009b:	80 
8010009c:	e8 5f 3f 00 00       	call   80104000 <initsleeplock>
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
801000e6:	e8 b5 41 00 00       	call   801042a0 <acquire>

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
80100161:	e8 aa 41 00 00       	call   80104310 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 cf 3e 00 00       	call   80104040 <acquiresleep>
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 72 20 00 00       	call   801021f0 <iderw>
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
80100188:	c7 04 24 ae 6c 10 80 	movl   $0x80106cae,(%esp)
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
801001b0:	e8 2b 3f 00 00       	call   801040e0 <holdingsleep>
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
801001c4:	e9 27 20 00 00       	jmp    801021f0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	c7 04 24 bf 6c 10 80 	movl   $0x80106cbf,(%esp)
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
801001f1:	e8 ea 3e 00 00       	call   801040e0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 9e 3e 00 00       	call   801040a0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100209:	e8 92 40 00 00       	call   801042a0 <acquire>
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
80100250:	e9 bb 40 00 00       	jmp    80104310 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100255:	c7 04 24 c6 6c 10 80 	movl   $0x80106cc6,(%esp)
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
80100282:	e8 d9 15 00 00       	call   80101860 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010028e:	e8 0d 40 00 00       	call   801042a0 <acquire>
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
801002a8:	e8 b3 34 00 00       	call   80103760 <myproc>
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
801002c3:	e8 f8 39 00 00       	call   80103cc0 <sleep>

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
80100311:	e8 fa 3f 00 00       	call   80104310 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 62 14 00 00       	call   80101780 <ilock>
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
8010032f:	e8 dc 3f 00 00       	call   80104310 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 44 14 00 00       	call   80101780 <ilock>
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
80100376:	e8 a5 24 00 00       	call   80102820 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 cd 6c 10 80 	movl   $0x80106ccd,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 72 03 00 00       	call   80100700 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 67 03 00 00       	call   80100700 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 17 76 10 80 	movl   $0x80107617,(%esp)
801003a0:	e8 5b 03 00 00       	call   80100700 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 9c 3d 00 00       	call   80104150 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 e1 6c 10 80 	movl   $0x80106ce1,(%esp)
801003c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c8:	e8 33 03 00 00       	call   80100700 <cprintf>
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
80100400:	0f 84 01 01 00 00    	je     80100507 <consputc+0x127>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
80100406:	8d 80 1e ff ff ff    	lea    -0xe2(%eax),%eax
8010040c:	83 f8 03             	cmp    $0x3,%eax
8010040f:	0f 87 fc 01 00 00    	ja     80100611 <consputc+0x231>
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
  if(c == '\n')
80100448:	83 fe 0a             	cmp    $0xa,%esi
8010044b:	0f 84 9f 01 00 00    	je     801005f0 <consputc+0x210>
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
80100451:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100457:	0f 84 52 01 00 00    	je     801005af <consputc+0x1cf>
      //backspace_hit = 1;
      if (pos > 0){
 	--pos;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
8010045d:	81 fe e4 00 00 00    	cmp    $0xe4,%esi
80100463:	0f 84 38 01 00 00    	je     801005a1 <consputc+0x1c1>
      if (pos > 0)
	--pos;
  } else if(c == RIGHT){
80100469:	81 fe e5 00 00 00    	cmp    $0xe5,%esi
8010046f:	0f 84 bb 00 00 00    	je     80100530 <consputc+0x150>
      if (pos < maximum_pos) ++pos;
  } else if(c == UP){
80100475:	8d 86 1e ff ff ff    	lea    -0xe2(%esi),%eax
8010047b:	83 f8 01             	cmp    $0x1,%eax
8010047e:	76 4a                	jbe    801004ca <consputc+0xea>
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
80100480:	b8 80 07 00 00       	mov    $0x780,%eax
80100485:	29 d8                	sub    %ebx,%eax
80100487:	8d 3c 1b             	lea    (%ebx,%ebx,1),%edi
8010048a:	01 c0                	add    %eax,%eax
8010048c:	8d 97 00 80 0b 80    	lea    -0x7ff48000(%edi),%edx
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
80100492:	83 c3 01             	add    $0x1,%ebx
  } else if(c == UP){
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
80100495:	89 44 24 08          	mov    %eax,0x8(%esp)
80100499:	8d 87 02 80 0b 80    	lea    -0x7ff47ffe(%edi),%eax
8010049f:	89 54 24 04          	mov    %edx,0x4(%esp)
801004a3:	89 04 24             	mov    %eax,(%esp)
801004a6:	e8 55 3f 00 00       	call   80104400 <memmove>
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	0f b6 f0             	movzbl %al,%esi
801004b0:	66 81 ce 00 07       	or     $0x700,%si
    if(pos > maximum_pos)
801004b5:	3b 1d 20 a5 10 80    	cmp    0x8010a520,%ebx
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
801004bb:	66 89 b7 00 80 0b 80 	mov    %si,-0x7ff48000(%edi)
    if(pos > maximum_pos)
801004c2:	7e 06                	jle    801004ca <consputc+0xea>
      maximum_pos = pos;
801004c4:	89 1d 20 a5 10 80    	mov    %ebx,0x8010a520
801004ca:	89 d8                	mov    %ebx,%eax
  }

  if(pos < 0 || pos > 25*80)
801004cc:	3d d0 07 00 00       	cmp    $0x7d0,%eax
801004d1:	77 71                	ja     80100544 <consputc+0x164>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
801004d3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004d9:	7f 75                	jg     80100550 <consputc+0x170>
801004db:	89 d8                	mov    %ebx,%eax
801004dd:	c1 e8 08             	shr    $0x8,%eax
801004e0:	89 c1                	mov    %eax,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004e2:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004e7:	b8 0e 00 00 00       	mov    $0xe,%eax
801004ec:	ee                   	out    %al,(%dx)
801004ed:	b2 d5                	mov    $0xd5,%dl
801004ef:	89 c8                	mov    %ecx,%eax
801004f1:	ee                   	out    %al,(%dx)
801004f2:	b8 0f 00 00 00       	mov    $0xf,%eax
801004f7:	b2 d4                	mov    $0xd4,%dl
801004f9:	ee                   	out    %al,(%dx)
801004fa:	b2 d5                	mov    $0xd5,%dl
801004fc:	89 d8                	mov    %ebx,%eax
801004fe:	ee                   	out    %al,(%dx)
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
    uartputc(c);
  }
  cgaputc(c);
}
801004ff:	83 c4 1c             	add    $0x1c,%esp
80100502:	5b                   	pop    %ebx
80100503:	5e                   	pop    %esi
80100504:	5f                   	pop    %edi
80100505:	5d                   	pop    %ebp
80100506:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100507:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010050e:	e8 fd 52 00 00       	call   80105810 <uartputc>
80100513:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010051a:	e8 f1 52 00 00       	call   80105810 <uartputc>
8010051f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100526:	e8 e5 52 00 00       	call   80105810 <uartputc>
8010052b:	e9 e5 fe ff ff       	jmp    80100415 <consputc+0x35>
      }
  } else if(c == LEFT){
      if (pos > 0)
	--pos;
  } else if(c == RIGHT){
      if (pos < maximum_pos) ++pos;
80100530:	3b 1d 20 a5 10 80    	cmp    0x8010a520,%ebx
80100536:	7d 92                	jge    801004ca <consputc+0xea>
80100538:	83 c3 01             	add    $0x1,%ebx
8010053b:	89 d8                	mov    %ebx,%eax
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
    if(pos > maximum_pos)
      maximum_pos = pos;
  }

  if(pos < 0 || pos > 25*80)
8010053d:	3d d0 07 00 00       	cmp    $0x7d0,%eax
80100542:	76 8f                	jbe    801004d3 <consputc+0xf3>
    panic("pos under/overflow");
80100544:	c7 04 24 e5 6c 10 80 	movl   $0x80106ce5,(%esp)
8010054b:	e8 10 fe ff ff       	call   80100360 <panic>

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100550:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
80100557:	00 
    pos -= 80;
80100558:	8d 73 b0             	lea    -0x50(%ebx),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010055b:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
80100562:	80 
80100563:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
8010056a:	e8 91 3e 00 00       	call   80104400 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010056f:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100574:	29 d8                	sub    %ebx,%eax
80100576:	89 f3                	mov    %esi,%ebx
80100578:	01 c0                	add    %eax,%eax
8010057a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010057e:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
80100585:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010058c:	00 
8010058d:	89 04 24             	mov    %eax,(%esp)
80100590:	e8 cb 3d 00 00       	call   80104360 <memset>
80100595:	89 f0                	mov    %esi,%eax
80100597:	c1 e8 08             	shr    $0x8,%eax
8010059a:	89 c1                	mov    %eax,%ecx
8010059c:	e9 41 ff ff ff       	jmp    801004e2 <consputc+0x102>
      if (pos > 0){
 	--pos;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
      if (pos > 0)
801005a1:	85 db                	test   %ebx,%ebx
801005a3:	74 42                	je     801005e7 <consputc+0x207>
	--pos;
801005a5:	83 eb 01             	sub    $0x1,%ebx
801005a8:	89 d8                	mov    %ebx,%eax
801005aa:	e9 1d ff ff ff       	jmp    801004cc <consputc+0xec>
    maximum_pos = pos;
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos > 0){
801005af:	85 db                	test   %ebx,%ebx
801005b1:	74 34                	je     801005e7 <consputc+0x207>
 	--pos;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005b3:	b8 81 07 00 00       	mov    $0x781,%eax
801005b8:	29 d8                	sub    %ebx,%eax
801005ba:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
801005bd:	01 c0                	add    %eax,%eax
801005bf:	89 44 24 08          	mov    %eax,0x8(%esp)
801005c3:	8d 82 00 80 0b 80    	lea    -0x7ff48000(%edx),%eax
801005c9:	81 ea 02 80 f4 7f    	sub    $0x7ff48002,%edx
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos > 0){
 	--pos;
801005cf:	8d 73 ff             	lea    -0x1(%ebx),%esi
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801005d6:	89 f3                	mov    %esi,%ebx
801005d8:	89 14 24             	mov    %edx,(%esp)
801005db:	e8 20 3e 00 00       	call   80104400 <memmove>
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos > 0){
 	--pos;
801005e0:	89 f0                	mov    %esi,%eax
801005e2:	e9 e5 fe ff ff       	jmp    801004cc <consputc+0xec>
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
      if (pos > 0)
801005e7:	31 db                	xor    %ebx,%ebx
801005e9:	31 c9                	xor    %ecx,%ecx
801005eb:	e9 f2 fe ff ff       	jmp    801004e2 <consputc+0x102>
  pos |= inb(CRTPORT+1);

  if(pos > maximum_pos)
    maximum_pos = pos;
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
801005f0:	89 d8                	mov    %ebx,%eax
801005f2:	ba 67 66 66 66       	mov    $0x66666667,%edx
801005f7:	f7 ea                	imul   %edx
801005f9:	c1 fb 1f             	sar    $0x1f,%ebx
801005fc:	c1 fa 05             	sar    $0x5,%edx
801005ff:	29 da                	sub    %ebx,%edx
80100601:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100604:	c1 e0 04             	shl    $0x4,%eax
80100607:	8d 58 50             	lea    0x50(%eax),%ebx
8010060a:	89 d8                	mov    %ebx,%eax
8010060c:	e9 bb fe ff ff       	jmp    801004cc <consputc+0xec>
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
    uartputc(c);
80100611:	89 34 24             	mov    %esi,(%esp)
80100614:	e8 f7 51 00 00       	call   80105810 <uartputc>
80100619:	e9 f7 fd ff ff       	jmp    80100415 <consputc+0x35>
8010061e:	66 90                	xchg   %ax,%ax

80100620 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	89 d6                	mov    %edx,%esi
80100627:	53                   	push   %ebx
80100628:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010062b:	85 c9                	test   %ecx,%ecx
8010062d:	74 61                	je     80100690 <printint+0x70>
8010062f:	85 c0                	test   %eax,%eax
80100631:	79 5d                	jns    80100690 <printint+0x70>
    x = -xx;
80100633:	f7 d8                	neg    %eax
80100635:	bf 01 00 00 00       	mov    $0x1,%edi
  else
    x = xx;

  i = 0;
8010063a:	31 c9                	xor    %ecx,%ecx
8010063c:	eb 04                	jmp    80100642 <printint+0x22>
8010063e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
80100640:	89 d9                	mov    %ebx,%ecx
80100642:	31 d2                	xor    %edx,%edx
80100644:	f7 f6                	div    %esi
80100646:	8d 59 01             	lea    0x1(%ecx),%ebx
80100649:	0f b6 92 10 6d 10 80 	movzbl -0x7fef92f0(%edx),%edx
  }while((x /= base) != 0);
80100650:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
80100652:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100656:	75 e8                	jne    80100640 <printint+0x20>

  if(sign)
80100658:	85 ff                	test   %edi,%edi
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
8010065a:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);

  if(sign)
8010065c:	74 08                	je     80100666 <printint+0x46>
    buf[i++] = '-';
8010065e:	8d 59 02             	lea    0x2(%ecx),%ebx
80100661:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
80100666:	83 eb 01             	sub    $0x1,%ebx
80100669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
80100670:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100675:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
80100678:	e8 63 fd ff ff       	call   801003e0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010067d:	83 fb ff             	cmp    $0xffffffff,%ebx
80100680:	75 ee                	jne    80100670 <printint+0x50>
    consputc(buf[i]);
}
80100682:	83 c4 1c             	add    $0x1c,%esp
80100685:	5b                   	pop    %ebx
80100686:	5e                   	pop    %esi
80100687:	5f                   	pop    %edi
80100688:	5d                   	pop    %ebp
80100689:	c3                   	ret    
8010068a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;
80100690:	31 ff                	xor    %edi,%edi
80100692:	eb a6                	jmp    8010063a <printint+0x1a>
80100694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010069a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801006a0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801006a9:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006ac:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801006af:	89 04 24             	mov    %eax,(%esp)
801006b2:	e8 a9 11 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
801006b7:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801006be:	e8 dd 3b 00 00       	call   801042a0 <acquire>
801006c3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
801006c6:	85 f6                	test   %esi,%esi
801006c8:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801006cb:	7e 12                	jle    801006df <consolewrite+0x3f>
801006cd:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801006d0:	0f b6 07             	movzbl (%edi),%eax
801006d3:	83 c7 01             	add    $0x1,%edi
801006d6:	e8 05 fd ff ff       	call   801003e0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
801006db:	39 df                	cmp    %ebx,%edi
801006dd:	75 f1                	jne    801006d0 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
801006df:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801006e6:	e8 25 3c 00 00       	call   80104310 <release>
  ilock(ip);
801006eb:	8b 45 08             	mov    0x8(%ebp),%eax
801006ee:	89 04 24             	mov    %eax,(%esp)
801006f1:	e8 8a 10 00 00       	call   80101780 <ilock>

  return n;
}
801006f6:	83 c4 1c             	add    $0x1c,%esp
801006f9:	89 f0                	mov    %esi,%eax
801006fb:	5b                   	pop    %ebx
801006fc:	5e                   	pop    %esi
801006fd:	5f                   	pop    %edi
801006fe:	5d                   	pop    %ebp
801006ff:	c3                   	ret    

80100700 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100700:	55                   	push   %ebp
80100701:	89 e5                	mov    %esp,%ebp
80100703:	57                   	push   %edi
80100704:	56                   	push   %esi
80100705:	53                   	push   %ebx
80100706:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100709:	a1 74 a5 10 80       	mov    0x8010a574,%eax
  if(locking)
8010070e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100710:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100713:	0f 85 27 01 00 00    	jne    80100840 <cprintf+0x140>
    acquire(&cons.lock);

  if (fmt == 0)
80100719:	8b 45 08             	mov    0x8(%ebp),%eax
8010071c:	85 c0                	test   %eax,%eax
8010071e:	89 c1                	mov    %eax,%ecx
80100720:	0f 84 2b 01 00 00    	je     80100851 <cprintf+0x151>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100726:	0f b6 00             	movzbl (%eax),%eax
80100729:	31 db                	xor    %ebx,%ebx
8010072b:	89 cf                	mov    %ecx,%edi
8010072d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100730:	85 c0                	test   %eax,%eax
80100732:	75 4c                	jne    80100780 <cprintf+0x80>
80100734:	eb 5f                	jmp    80100795 <cprintf+0x95>
80100736:	66 90                	xchg   %ax,%ax
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100738:	83 c3 01             	add    $0x1,%ebx
8010073b:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
8010073f:	85 d2                	test   %edx,%edx
80100741:	74 52                	je     80100795 <cprintf+0x95>
      break;
    switch(c){
80100743:	83 fa 70             	cmp    $0x70,%edx
80100746:	74 72                	je     801007ba <cprintf+0xba>
80100748:	7f 66                	jg     801007b0 <cprintf+0xb0>
8010074a:	83 fa 25             	cmp    $0x25,%edx
8010074d:	8d 76 00             	lea    0x0(%esi),%esi
80100750:	0f 84 a2 00 00 00    	je     801007f8 <cprintf+0xf8>
80100756:	83 fa 64             	cmp    $0x64,%edx
80100759:	75 7d                	jne    801007d8 <cprintf+0xd8>
    case 'd':
      printint(*argp++, 10, 1);
8010075b:	8d 46 04             	lea    0x4(%esi),%eax
8010075e:	b9 01 00 00 00       	mov    $0x1,%ecx
80100763:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100766:	8b 06                	mov    (%esi),%eax
80100768:	ba 0a 00 00 00       	mov    $0xa,%edx
8010076d:	e8 ae fe ff ff       	call   80100620 <printint>
80100772:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100775:	83 c3 01             	add    $0x1,%ebx
80100778:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
8010077c:	85 c0                	test   %eax,%eax
8010077e:	74 15                	je     80100795 <cprintf+0x95>
    if(c != '%'){
80100780:	83 f8 25             	cmp    $0x25,%eax
80100783:	74 b3                	je     80100738 <cprintf+0x38>
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
80100785:	e8 56 fc ff ff       	call   801003e0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010078a:	83 c3 01             	add    $0x1,%ebx
8010078d:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
80100791:	85 c0                	test   %eax,%eax
80100793:	75 eb                	jne    80100780 <cprintf+0x80>
      consputc(c);
      break;
    }
  }

  if(locking)
80100795:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100798:	85 c0                	test   %eax,%eax
8010079a:	74 0c                	je     801007a8 <cprintf+0xa8>
    release(&cons.lock);
8010079c:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801007a3:	e8 68 3b 00 00       	call   80104310 <release>
}
801007a8:	83 c4 1c             	add    $0x1c,%esp
801007ab:	5b                   	pop    %ebx
801007ac:	5e                   	pop    %esi
801007ad:	5f                   	pop    %edi
801007ae:	5d                   	pop    %ebp
801007af:	c3                   	ret    
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801007b0:	83 fa 73             	cmp    $0x73,%edx
801007b3:	74 53                	je     80100808 <cprintf+0x108>
801007b5:	83 fa 78             	cmp    $0x78,%edx
801007b8:	75 1e                	jne    801007d8 <cprintf+0xd8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801007ba:	8d 46 04             	lea    0x4(%esi),%eax
801007bd:	31 c9                	xor    %ecx,%ecx
801007bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007c2:	8b 06                	mov    (%esi),%eax
801007c4:	ba 10 00 00 00       	mov    $0x10,%edx
801007c9:	e8 52 fe ff ff       	call   80100620 <printint>
801007ce:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
801007d1:	eb a2                	jmp    80100775 <cprintf+0x75>
801007d3:	90                   	nop
801007d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801007d8:	b8 25 00 00 00       	mov    $0x25,%eax
801007dd:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801007e0:	e8 fb fb ff ff       	call   801003e0 <consputc>
      consputc(c);
801007e5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801007e8:	89 d0                	mov    %edx,%eax
801007ea:	e8 f1 fb ff ff       	call   801003e0 <consputc>
801007ef:	eb 99                	jmp    8010078a <cprintf+0x8a>
801007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801007f8:	b8 25 00 00 00       	mov    $0x25,%eax
801007fd:	e8 de fb ff ff       	call   801003e0 <consputc>
      break;
80100802:	e9 6e ff ff ff       	jmp    80100775 <cprintf+0x75>
80100807:	90                   	nop
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100808:	8d 46 04             	lea    0x4(%esi),%eax
8010080b:	8b 36                	mov    (%esi),%esi
8010080d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100810:	b8 f8 6c 10 80       	mov    $0x80106cf8,%eax
80100815:	85 f6                	test   %esi,%esi
80100817:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
8010081a:	0f be 06             	movsbl (%esi),%eax
8010081d:	84 c0                	test   %al,%al
8010081f:	74 16                	je     80100837 <cprintf+0x137>
80100821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100828:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
8010082b:	e8 b0 fb ff ff       	call   801003e0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100830:	0f be 06             	movsbl (%esi),%eax
80100833:	84 c0                	test   %al,%al
80100835:	75 f1                	jne    80100828 <cprintf+0x128>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100837:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010083a:	e9 36 ff ff ff       	jmp    80100775 <cprintf+0x75>
8010083f:	90                   	nop
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100840:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100847:	e8 54 3a 00 00       	call   801042a0 <acquire>
8010084c:	e9 c8 fe ff ff       	jmp    80100719 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
80100851:	c7 04 24 ff 6c 10 80 	movl   $0x80106cff,(%esp)
80100858:	e8 03 fb ff ff       	call   80100360 <panic>
8010085d:	8d 76 00             	lea    0x0(%esi),%esi

80100860 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100860:	55                   	push   %ebp
80100861:	89 e5                	mov    %esp,%ebp
80100863:	57                   	push   %edi
80100864:	56                   	push   %esi
  int c, doprocdump = 0;
80100865:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100867:	53                   	push   %ebx
80100868:	83 ec 1c             	sub    $0x1c,%esp
8010086b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
8010086e:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100875:	e8 26 3a 00 00       	call   801042a0 <acquire>
8010087a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
80100880:	ff d3                	call   *%ebx
80100882:	85 c0                	test   %eax,%eax
80100884:	89 c7                	mov    %eax,%edi
80100886:	78 30                	js     801008b8 <consoleintr+0x58>
    switch(c){
80100888:	83 ff 15             	cmp    $0x15,%edi
8010088b:	74 6b                	je     801008f8 <consoleintr+0x98>
8010088d:	8d 76 00             	lea    0x0(%esi),%esi
80100890:	7f 46                	jg     801008d8 <consoleintr+0x78>
80100892:	83 ff 08             	cmp    $0x8,%edi
80100895:	0f 84 25 01 00 00    	je     801009c0 <consoleintr+0x160>
8010089b:	83 ff 10             	cmp    $0x10,%edi
8010089e:	66 90                	xchg   %ax,%ax
801008a0:	0f 85 a2 00 00 00    	jne    80100948 <consoleintr+0xe8>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801008a6:	ff d3                	call   *%ebx
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801008a8:	be 01 00 00 00       	mov    $0x1,%esi
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801008ad:	85 c0                	test   %eax,%eax
801008af:	89 c7                	mov    %eax,%edi
801008b1:	79 d5                	jns    80100888 <consoleintr+0x28>
801008b3:	90                   	nop
801008b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
801008b8:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801008bf:	e8 4c 3a 00 00       	call   80104310 <release>
  if(doprocdump) {
801008c4:	85 f6                	test   %esi,%esi
801008c6:	0f 85 1c 01 00 00    	jne    801009e8 <consoleintr+0x188>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801008cc:	83 c4 1c             	add    $0x1c,%esp
801008cf:	5b                   	pop    %ebx
801008d0:	5e                   	pop    %esi
801008d1:	5f                   	pop    %edi
801008d2:	5d                   	pop    %ebp
801008d3:	c3                   	ret    
801008d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
801008d8:	83 ff 7f             	cmp    $0x7f,%edi
801008db:	0f 84 df 00 00 00    	je     801009c0 <consoleintr+0x160>
801008e1:	7c 65                	jl     80100948 <consoleintr+0xe8>
801008e3:	8d 87 1e ff ff ff    	lea    -0xe2(%edi),%eax
801008e9:	83 f8 03             	cmp    $0x3,%eax
801008ec:	77 5a                	ja     80100948 <consoleintr+0xe8>
      break;
    case UP:
    case DOWN:
    case LEFT:
    case RIGHT:
      consputc(c);
801008ee:	89 f8                	mov    %edi,%eax
801008f0:	e8 eb fa ff ff       	call   801003e0 <consputc>
      break;
801008f5:	eb 89                	jmp    80100880 <consoleintr+0x20>
801008f7:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008f8:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801008fd:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100903:	75 2b                	jne    80100930 <consoleintr+0xd0>
80100905:	e9 76 ff ff ff       	jmp    80100880 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100910:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 c1 fa ff ff       	call   801003e0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010091f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100924:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010092a:	0f 84 50 ff ff ff    	je     80100880 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	83 e8 01             	sub    $0x1,%eax
80100933:	89 c2                	mov    %eax,%edx
80100935:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100938:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010093f:	75 cf                	jne    80100910 <consoleintr+0xb0>
80100941:	e9 3a ff ff ff       	jmp    80100880 <consoleintr+0x20>
80100946:	66 90                	xchg   %ax,%ax
    case LEFT:
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100948:	85 ff                	test   %edi,%edi
8010094a:	0f 84 30 ff ff ff    	je     80100880 <consoleintr+0x20>
80100950:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100955:	89 c2                	mov    %eax,%edx
80100957:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
8010095d:	83 fa 7f             	cmp    $0x7f,%edx
80100960:	0f 87 1a ff ff ff    	ja     80100880 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100966:	8d 50 01             	lea    0x1(%eax),%edx
80100969:	83 e0 7f             	and    $0x7f,%eax
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
8010096c:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
8010096f:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100975:	74 7d                	je     801009f4 <consoleintr+0x194>
        input.buf[input.e++ % INPUT_BUF] = c;
80100977:	89 f9                	mov    %edi,%ecx
80100979:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
8010097f:	89 f8                	mov    %edi,%eax
80100981:	e8 5a fa ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100986:	83 ff 04             	cmp    $0x4,%edi
80100989:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010098e:	74 19                	je     801009a9 <consoleintr+0x149>
80100990:	83 ff 0a             	cmp    $0xa,%edi
80100993:	74 14                	je     801009a9 <consoleintr+0x149>
80100995:	8b 0d c0 ff 10 80    	mov    0x8010ffc0,%ecx
8010099b:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
801009a1:	39 d0                	cmp    %edx,%eax
801009a3:	0f 85 d7 fe ff ff    	jne    80100880 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801009a9:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801009b0:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801009b5:	e8 96 34 00 00       	call   80103e50 <wakeup>
801009ba:	e9 c1 fe ff ff       	jmp    80100880 <consoleintr+0x20>
801009bf:	90                   	nop
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801009c0:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801009c5:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801009cb:	0f 84 af fe ff ff    	je     80100880 <consoleintr+0x20>
        input.e--;
801009d1:	83 e8 01             	sub    $0x1,%eax
801009d4:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
801009d9:	b8 00 01 00 00       	mov    $0x100,%eax
801009de:	e8 fd f9 ff ff       	call   801003e0 <consputc>
801009e3:	e9 98 fe ff ff       	jmp    80100880 <consoleintr+0x20>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801009e8:	83 c4 1c             	add    $0x1c,%esp
801009eb:	5b                   	pop    %ebx
801009ec:	5e                   	pop    %esi
801009ed:	5f                   	pop    %edi
801009ee:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
801009ef:	e9 3c 35 00 00       	jmp    80103f30 <procdump>
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801009f4:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
801009fb:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a00:	e8 db f9 ff ff       	call   801003e0 <consputc>
80100a05:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100a0a:	eb 9d                	jmp    801009a9 <consoleintr+0x149>
80100a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100a10 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a16:	c7 44 24 04 08 6d 10 	movl   $0x80106d08,0x4(%esp)
80100a1d:	80 
80100a1e:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100a25:	e8 06 37 00 00       	call   80104130 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a2a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100a31:	00 
80100a32:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100a39:	c7 05 8c 09 11 80 a0 	movl   $0x801006a0,0x8011098c
80100a40:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a43:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
80100a4a:	02 10 80 
  cons.locking = 1;
80100a4d:	c7 05 74 a5 10 80 01 	movl   $0x1,0x8010a574
80100a54:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100a57:	e8 24 19 00 00       	call   80102380 <ioapicenable>
}
80100a5c:	c9                   	leave  
80100a5d:	c3                   	ret    
80100a5e:	66 90                	xchg   %ax,%ax

80100a60 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	57                   	push   %edi
80100a64:	56                   	push   %esi
80100a65:	53                   	push   %ebx
80100a66:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a6c:	e8 ef 2c 00 00       	call   80103760 <myproc>
80100a71:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a77:	e8 54 21 00 00       	call   80102bd0 <begin_op>

  if((ip = namei(path)) == 0){
80100a7c:	8b 45 08             	mov    0x8(%ebp),%eax
80100a7f:	89 04 24             	mov    %eax,(%esp)
80100a82:	e8 49 15 00 00       	call   80101fd0 <namei>
80100a87:	85 c0                	test   %eax,%eax
80100a89:	89 c3                	mov    %eax,%ebx
80100a8b:	0f 84 c2 01 00 00    	je     80100c53 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a91:	89 04 24             	mov    %eax,(%esp)
80100a94:	e8 e7 0c 00 00       	call   80101780 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a99:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a9f:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100aa6:	00 
80100aa7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100aae:	00 
80100aaf:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ab3:	89 1c 24             	mov    %ebx,(%esp)
80100ab6:	e8 75 0f 00 00       	call   80101a30 <readi>
80100abb:	83 f8 34             	cmp    $0x34,%eax
80100abe:	74 20                	je     80100ae0 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ac0:	89 1c 24             	mov    %ebx,(%esp)
80100ac3:	e8 18 0f 00 00       	call   801019e0 <iunlockput>
    end_op();
80100ac8:	e8 73 21 00 00       	call   80102c40 <end_op>
  }
  return -1;
80100acd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ad2:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100ad8:	5b                   	pop    %ebx
80100ad9:	5e                   	pop    %esi
80100ada:	5f                   	pop    %edi
80100adb:	5d                   	pop    %ebp
80100adc:	c3                   	ret    
80100add:	8d 76 00             	lea    0x0(%esi),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100ae0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ae7:	45 4c 46 
80100aea:	75 d4                	jne    80100ac0 <exec+0x60>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100aec:	e8 ff 5e 00 00       	call   801069f0 <setupkvm>
80100af1:	85 c0                	test   %eax,%eax
80100af3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100af9:	74 c5                	je     80100ac0 <exec+0x60>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100afb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b02:	00 
80100b03:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
80100b09:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100b10:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b13:	0f 84 da 00 00 00    	je     80100bf3 <exec+0x193>
80100b19:	31 ff                	xor    %edi,%edi
80100b1b:	eb 18                	jmp    80100b35 <exec+0xd5>
80100b1d:	8d 76 00             	lea    0x0(%esi),%esi
80100b20:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b27:	83 c7 01             	add    $0x1,%edi
80100b2a:	83 c6 20             	add    $0x20,%esi
80100b2d:	39 f8                	cmp    %edi,%eax
80100b2f:	0f 8e be 00 00 00    	jle    80100bf3 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b35:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b3b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100b42:	00 
80100b43:	89 74 24 08          	mov    %esi,0x8(%esp)
80100b47:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b4b:	89 1c 24             	mov    %ebx,(%esp)
80100b4e:	e8 dd 0e 00 00       	call   80101a30 <readi>
80100b53:	83 f8 20             	cmp    $0x20,%eax
80100b56:	0f 85 84 00 00 00    	jne    80100be0 <exec+0x180>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b5c:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b63:	75 bb                	jne    80100b20 <exec+0xc0>
      continue;
    if(ph.memsz < ph.filesz)
80100b65:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b6b:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b71:	72 6d                	jb     80100be0 <exec+0x180>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b73:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b79:	72 65                	jb     80100be0 <exec+0x180>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b7b:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b7f:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b85:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b89:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b8f:	89 04 24             	mov    %eax,(%esp)
80100b92:	e8 c9 5c 00 00       	call   80106860 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b9f:	74 3f                	je     80100be0 <exec+0x180>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100ba1:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ba7:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bac:	75 32                	jne    80100be0 <exec+0x180>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bae:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100bb4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bb8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bbe:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100bc2:	89 54 24 10          	mov    %edx,0x10(%esp)
80100bc6:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100bcc:	89 04 24             	mov    %eax,(%esp)
80100bcf:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100bd3:	e8 c8 5b 00 00       	call   801067a0 <loaduvm>
80100bd8:	85 c0                	test   %eax,%eax
80100bda:	0f 89 40 ff ff ff    	jns    80100b20 <exec+0xc0>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100be0:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100be6:	89 04 24             	mov    %eax,(%esp)
80100be9:	e8 82 5d 00 00       	call   80106970 <freevm>
80100bee:	e9 cd fe ff ff       	jmp    80100ac0 <exec+0x60>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100bf3:	89 1c 24             	mov    %ebx,(%esp)
80100bf6:	e8 e5 0d 00 00       	call   801019e0 <iunlockput>
80100bfb:	90                   	nop
80100bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100c00:	e8 3b 20 00 00       	call   80102c40 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100c05:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c0b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c10:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c15:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100c1b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c1f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c25:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c29:	89 04 24             	mov    %eax,(%esp)
80100c2c:	e8 2f 5c 00 00       	call   80106860 <allocuvm>
80100c31:	85 c0                	test   %eax,%eax
80100c33:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100c39:	75 33                	jne    80100c6e <exec+0x20e>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c3b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c41:	89 04 24             	mov    %eax,(%esp)
80100c44:	e8 27 5d 00 00       	call   80106970 <freevm>
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100c49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c4e:	e9 7f fe ff ff       	jmp    80100ad2 <exec+0x72>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100c53:	e8 e8 1f 00 00       	call   80102c40 <end_op>
    cprintf("exec: fail\n");
80100c58:	c7 04 24 21 6d 10 80 	movl   $0x80106d21,(%esp)
80100c5f:	e8 9c fa ff ff       	call   80100700 <cprintf>
    return -1;
80100c64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c69:	e9 64 fe ff ff       	jmp    80100ad2 <exec+0x72>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c6e:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100c74:	89 d8                	mov    %ebx,%eax
80100c76:	2d 00 20 00 00       	sub    $0x2000,%eax
80100c7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c7f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c85:	89 04 24             	mov    %eax,(%esp)
80100c88:	e8 13 5e 00 00       	call   80106aa0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c8d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c90:	8b 00                	mov    (%eax),%eax
80100c92:	85 c0                	test   %eax,%eax
80100c94:	0f 84 59 01 00 00    	je     80100df3 <exec+0x393>
80100c9a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100c9d:	31 d2                	xor    %edx,%edx
80100c9f:	8d 71 04             	lea    0x4(%ecx),%esi
80100ca2:	89 cf                	mov    %ecx,%edi
80100ca4:	89 d1                	mov    %edx,%ecx
80100ca6:	89 f2                	mov    %esi,%edx
80100ca8:	89 fe                	mov    %edi,%esi
80100caa:	89 cf                	mov    %ecx,%edi
80100cac:	eb 0a                	jmp    80100cb8 <exec+0x258>
80100cae:	66 90                	xchg   %ax,%ax
80100cb0:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100cb3:	83 ff 20             	cmp    $0x20,%edi
80100cb6:	74 83                	je     80100c3b <exec+0x1db>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb8:	89 04 24             	mov    %eax,(%esp)
80100cbb:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100cc1:	e8 ba 38 00 00       	call   80104580 <strlen>
80100cc6:	f7 d0                	not    %eax
80100cc8:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cca:	8b 06                	mov    (%esi),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ccc:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ccf:	89 04 24             	mov    %eax,(%esp)
80100cd2:	e8 a9 38 00 00       	call   80104580 <strlen>
80100cd7:	83 c0 01             	add    $0x1,%eax
80100cda:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100cde:	8b 06                	mov    (%esi),%eax
80100ce0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100ce4:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ce8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100cee:	89 04 24             	mov    %eax,(%esp)
80100cf1:	e8 0a 5f 00 00       	call   80106c00 <copyout>
80100cf6:	85 c0                	test   %eax,%eax
80100cf8:	0f 88 3d ff ff ff    	js     80100c3b <exec+0x1db>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100cfe:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100d04:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d0a:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d11:	83 c7 01             	add    $0x1,%edi
80100d14:	8b 02                	mov    (%edx),%eax
80100d16:	89 d6                	mov    %edx,%esi
80100d18:	85 c0                	test   %eax,%eax
80100d1a:	75 94                	jne    80100cb0 <exec+0x250>
80100d1c:	89 fa                	mov    %edi,%edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100d1e:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100d25:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d29:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
80100d30:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d36:	89 da                	mov    %ebx,%edx
80100d38:	29 c2                	sub    %eax,%edx

  sp -= (3+argc+1) * 4;
80100d3a:	83 c0 0c             	add    $0xc,%eax
80100d3d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100d43:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d49:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100d4d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100d51:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d58:	ff ff ff 
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d5b:	89 04 24             	mov    %eax,(%esp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5e:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d64:	e8 97 5e 00 00       	call   80106c00 <copyout>
80100d69:	85 c0                	test   %eax,%eax
80100d6b:	0f 88 ca fe ff ff    	js     80100c3b <exec+0x1db>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d71:	8b 45 08             	mov    0x8(%ebp),%eax
80100d74:	0f b6 10             	movzbl (%eax),%edx
80100d77:	84 d2                	test   %dl,%dl
80100d79:	74 19                	je     80100d94 <exec+0x334>
80100d7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100d7e:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100d81:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d84:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100d87:	0f 44 c8             	cmove  %eax,%ecx
80100d8a:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d8d:	84 d2                	test   %dl,%dl
80100d8f:	75 f0                	jne    80100d81 <exec+0x321>
80100d91:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d94:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100d9a:	8b 45 08             	mov    0x8(%ebp),%eax
80100d9d:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100da4:	00 
80100da5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100da9:	89 f8                	mov    %edi,%eax
80100dab:	83 c0 6c             	add    $0x6c,%eax
80100dae:	89 04 24             	mov    %eax,(%esp)
80100db1:	e8 8a 37 00 00       	call   80104540 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100db6:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100dbc:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100dbf:	8b 47 18             	mov    0x18(%edi),%eax
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100dc2:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100dc5:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100dcb:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100dcd:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dd3:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dd6:	8b 47 18             	mov    0x18(%edi),%eax
80100dd9:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100ddc:	89 3c 24             	mov    %edi,(%esp)
80100ddf:	e8 2c 58 00 00       	call   80106610 <switchuvm>
  freevm(oldpgdir);
80100de4:	89 34 24             	mov    %esi,(%esp)
80100de7:	e8 84 5b 00 00       	call   80106970 <freevm>
  return 0;
80100dec:	31 c0                	xor    %eax,%eax
80100dee:	e9 df fc ff ff       	jmp    80100ad2 <exec+0x72>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100df3:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100df9:	31 d2                	xor    %edx,%edx
80100dfb:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e01:	e9 18 ff ff ff       	jmp    80100d1e <exec+0x2be>
80100e06:	66 90                	xchg   %ax,%ax
80100e08:	66 90                	xchg   %ax,%ax
80100e0a:	66 90                	xchg   %ax,%ax
80100e0c:	66 90                	xchg   %ax,%ax
80100e0e:	66 90                	xchg   %ax,%ax

80100e10 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100e16:	c7 44 24 04 2d 6d 10 	movl   $0x80106d2d,0x4(%esp)
80100e1d:	80 
80100e1e:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100e25:	e8 06 33 00 00       	call   80104130 <initlock>
}
80100e2a:	c9                   	leave  
80100e2b:	c3                   	ret    
80100e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100e30 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e34:	bb 14 00 11 80       	mov    $0x80110014,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e39:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100e3c:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100e43:	e8 58 34 00 00       	call   801042a0 <acquire>
80100e48:	eb 11                	jmp    80100e5b <filealloc+0x2b>
80100e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e50:	83 c3 18             	add    $0x18,%ebx
80100e53:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100e59:	74 25                	je     80100e80 <filealloc+0x50>
    if(f->ref == 0){
80100e5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e5e:	85 c0                	test   %eax,%eax
80100e60:	75 ee                	jne    80100e50 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e62:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100e69:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e70:	e8 9b 34 00 00       	call   80104310 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e75:	83 c4 14             	add    $0x14,%esp
  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      release(&ftable.lock);
      return f;
80100e78:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e7a:	5b                   	pop    %ebx
80100e7b:	5d                   	pop    %ebp
80100e7c:	c3                   	ret    
80100e7d:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100e80:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100e87:	e8 84 34 00 00       	call   80104310 <release>
  return 0;
}
80100e8c:	83 c4 14             	add    $0x14,%esp
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
80100e8f:	31 c0                	xor    %eax,%eax
}
80100e91:	5b                   	pop    %ebx
80100e92:	5d                   	pop    %ebp
80100e93:	c3                   	ret    
80100e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100ea0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	53                   	push   %ebx
80100ea4:	83 ec 14             	sub    $0x14,%esp
80100ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eaa:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100eb1:	e8 ea 33 00 00       	call   801042a0 <acquire>
  if(f->ref < 1)
80100eb6:	8b 43 04             	mov    0x4(%ebx),%eax
80100eb9:	85 c0                	test   %eax,%eax
80100ebb:	7e 1a                	jle    80100ed7 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100ebd:	83 c0 01             	add    $0x1,%eax
80100ec0:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ec3:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100eca:	e8 41 34 00 00       	call   80104310 <release>
  return f;
}
80100ecf:	83 c4 14             	add    $0x14,%esp
80100ed2:	89 d8                	mov    %ebx,%eax
80100ed4:	5b                   	pop    %ebx
80100ed5:	5d                   	pop    %ebp
80100ed6:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100ed7:	c7 04 24 34 6d 10 80 	movl   $0x80106d34,(%esp)
80100ede:	e8 7d f4 ff ff       	call   80100360 <panic>
80100ee3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ef0 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	57                   	push   %edi
80100ef4:	56                   	push   %esi
80100ef5:	53                   	push   %ebx
80100ef6:	83 ec 1c             	sub    $0x1c,%esp
80100ef9:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100efc:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100f03:	e8 98 33 00 00       	call   801042a0 <acquire>
  if(f->ref < 1)
80100f08:	8b 57 04             	mov    0x4(%edi),%edx
80100f0b:	85 d2                	test   %edx,%edx
80100f0d:	0f 8e 89 00 00 00    	jle    80100f9c <fileclose+0xac>
    panic("fileclose");
  if(--f->ref > 0){
80100f13:	83 ea 01             	sub    $0x1,%edx
80100f16:	85 d2                	test   %edx,%edx
80100f18:	89 57 04             	mov    %edx,0x4(%edi)
80100f1b:	74 13                	je     80100f30 <fileclose+0x40>
    release(&ftable.lock);
80100f1d:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f24:	83 c4 1c             	add    $0x1c,%esp
80100f27:	5b                   	pop    %ebx
80100f28:	5e                   	pop    %esi
80100f29:	5f                   	pop    %edi
80100f2a:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100f2b:	e9 e0 33 00 00       	jmp    80104310 <release>
    return;
  }
  ff = *f;
80100f30:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100f34:	8b 37                	mov    (%edi),%esi
80100f36:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
80100f39:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f3f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f42:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f45:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f4c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f4f:	e8 bc 33 00 00       	call   80104310 <release>

  if(ff.type == FD_PIPE)
80100f54:	83 fe 01             	cmp    $0x1,%esi
80100f57:	74 0f                	je     80100f68 <fileclose+0x78>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f59:	83 fe 02             	cmp    $0x2,%esi
80100f5c:	74 22                	je     80100f80 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f5e:	83 c4 1c             	add    $0x1c,%esp
80100f61:	5b                   	pop    %ebx
80100f62:	5e                   	pop    %esi
80100f63:	5f                   	pop    %edi
80100f64:	5d                   	pop    %ebp
80100f65:	c3                   	ret    
80100f66:	66 90                	xchg   %ax,%ax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100f68:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100f6c:	89 1c 24             	mov    %ebx,(%esp)
80100f6f:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f73:	e8 a8 23 00 00       	call   80103320 <pipeclose>
80100f78:	eb e4                	jmp    80100f5e <fileclose+0x6e>
80100f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100f80:	e8 4b 1c 00 00       	call   80102bd0 <begin_op>
    iput(ff.ip);
80100f85:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f88:	89 04 24             	mov    %eax,(%esp)
80100f8b:	e8 10 09 00 00       	call   801018a0 <iput>
    end_op();
  }
}
80100f90:	83 c4 1c             	add    $0x1c,%esp
80100f93:	5b                   	pop    %ebx
80100f94:	5e                   	pop    %esi
80100f95:	5f                   	pop    %edi
80100f96:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100f97:	e9 a4 1c 00 00       	jmp    80102c40 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100f9c:	c7 04 24 3c 6d 10 80 	movl   $0x80106d3c,(%esp)
80100fa3:	e8 b8 f3 ff ff       	call   80100360 <panic>
80100fa8:	90                   	nop
80100fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fb0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	53                   	push   %ebx
80100fb4:	83 ec 14             	sub    $0x14,%esp
80100fb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fba:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fbd:	75 31                	jne    80100ff0 <filestat+0x40>
    ilock(f->ip);
80100fbf:	8b 43 10             	mov    0x10(%ebx),%eax
80100fc2:	89 04 24             	mov    %eax,(%esp)
80100fc5:	e8 b6 07 00 00       	call   80101780 <ilock>
    stati(f->ip, st);
80100fca:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fcd:	89 44 24 04          	mov    %eax,0x4(%esp)
80100fd1:	8b 43 10             	mov    0x10(%ebx),%eax
80100fd4:	89 04 24             	mov    %eax,(%esp)
80100fd7:	e8 24 0a 00 00       	call   80101a00 <stati>
    iunlock(f->ip);
80100fdc:	8b 43 10             	mov    0x10(%ebx),%eax
80100fdf:	89 04 24             	mov    %eax,(%esp)
80100fe2:	e8 79 08 00 00       	call   80101860 <iunlock>
    return 0;
  }
  return -1;
}
80100fe7:	83 c4 14             	add    $0x14,%esp
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
80100fea:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100fec:	5b                   	pop    %ebx
80100fed:	5d                   	pop    %ebp
80100fee:	c3                   	ret    
80100fef:	90                   	nop
80100ff0:	83 c4 14             	add    $0x14,%esp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100ff3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ff8:	5b                   	pop    %ebx
80100ff9:	5d                   	pop    %ebp
80100ffa:	c3                   	ret    
80100ffb:	90                   	nop
80100ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101000 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 1c             	sub    $0x1c,%esp
80101009:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010100c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010100f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101012:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101016:	74 68                	je     80101080 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80101018:	8b 03                	mov    (%ebx),%eax
8010101a:	83 f8 01             	cmp    $0x1,%eax
8010101d:	74 49                	je     80101068 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101f:	83 f8 02             	cmp    $0x2,%eax
80101022:	75 63                	jne    80101087 <fileread+0x87>
    ilock(f->ip);
80101024:	8b 43 10             	mov    0x10(%ebx),%eax
80101027:	89 04 24             	mov    %eax,(%esp)
8010102a:	e8 51 07 00 00       	call   80101780 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010102f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80101033:	8b 43 14             	mov    0x14(%ebx),%eax
80101036:	89 74 24 04          	mov    %esi,0x4(%esp)
8010103a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010103e:	8b 43 10             	mov    0x10(%ebx),%eax
80101041:	89 04 24             	mov    %eax,(%esp)
80101044:	e8 e7 09 00 00       	call   80101a30 <readi>
80101049:	85 c0                	test   %eax,%eax
8010104b:	89 c6                	mov    %eax,%esi
8010104d:	7e 03                	jle    80101052 <fileread+0x52>
      f->off += r;
8010104f:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101052:	8b 43 10             	mov    0x10(%ebx),%eax
80101055:	89 04 24             	mov    %eax,(%esp)
80101058:	e8 03 08 00 00       	call   80101860 <iunlock>
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010105d:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
8010105f:	83 c4 1c             	add    $0x1c,%esp
80101062:	5b                   	pop    %ebx
80101063:	5e                   	pop    %esi
80101064:	5f                   	pop    %edi
80101065:	5d                   	pop    %ebp
80101066:	c3                   	ret    
80101067:	90                   	nop
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101068:	8b 43 0c             	mov    0xc(%ebx),%eax
8010106b:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
8010106e:	83 c4 1c             	add    $0x1c,%esp
80101071:	5b                   	pop    %ebx
80101072:	5e                   	pop    %esi
80101073:	5f                   	pop    %edi
80101074:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101075:	e9 26 24 00 00       	jmp    801034a0 <piperead>
8010107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101085:	eb d8                	jmp    8010105f <fileread+0x5f>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80101087:	c7 04 24 46 6d 10 80 	movl   $0x80106d46,(%esp)
8010108e:	e8 cd f2 ff ff       	call   80100360 <panic>
80101093:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801010a0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	57                   	push   %edi
801010a4:	56                   	push   %esi
801010a5:	53                   	push   %ebx
801010a6:	83 ec 2c             	sub    $0x2c,%esp
801010a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010ac:	8b 7d 08             	mov    0x8(%ebp),%edi
801010af:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010b2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010b5:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
801010bc:	0f 84 ae 00 00 00    	je     80101170 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
801010c2:	8b 07                	mov    (%edi),%eax
801010c4:	83 f8 01             	cmp    $0x1,%eax
801010c7:	0f 84 c2 00 00 00    	je     8010118f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010cd:	83 f8 02             	cmp    $0x2,%eax
801010d0:	0f 85 d7 00 00 00    	jne    801011ad <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010d9:	31 db                	xor    %ebx,%ebx
801010db:	85 c0                	test   %eax,%eax
801010dd:	7f 31                	jg     80101110 <filewrite+0x70>
801010df:	e9 9c 00 00 00       	jmp    80101180 <filewrite+0xe0>
801010e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
801010e8:	8b 4f 10             	mov    0x10(%edi),%ecx
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010eb:	01 47 14             	add    %eax,0x14(%edi)
801010ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010f1:	89 0c 24             	mov    %ecx,(%esp)
801010f4:	e8 67 07 00 00       	call   80101860 <iunlock>
      end_op();
801010f9:	e8 42 1b 00 00       	call   80102c40 <end_op>
801010fe:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101101:	39 f0                	cmp    %esi,%eax
80101103:	0f 85 98 00 00 00    	jne    801011a1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101109:	01 c3                	add    %eax,%ebx
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010110b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010110e:	7e 70                	jle    80101180 <filewrite+0xe0>
      int n1 = n - i;
80101110:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101113:	b8 00 06 00 00       	mov    $0x600,%eax
80101118:	29 de                	sub    %ebx,%esi
8010111a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101120:	0f 4f f0             	cmovg  %eax,%esi
      if(n1 > max)
        n1 = max;

      begin_op();
80101123:	e8 a8 1a 00 00       	call   80102bd0 <begin_op>
      ilock(f->ip);
80101128:	8b 47 10             	mov    0x10(%edi),%eax
8010112b:	89 04 24             	mov    %eax,(%esp)
8010112e:	e8 4d 06 00 00       	call   80101780 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101133:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101137:	8b 47 14             	mov    0x14(%edi),%eax
8010113a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010113e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101141:	01 d8                	add    %ebx,%eax
80101143:	89 44 24 04          	mov    %eax,0x4(%esp)
80101147:	8b 47 10             	mov    0x10(%edi),%eax
8010114a:	89 04 24             	mov    %eax,(%esp)
8010114d:	e8 de 09 00 00       	call   80101b30 <writei>
80101152:	85 c0                	test   %eax,%eax
80101154:	7f 92                	jg     801010e8 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
80101156:	8b 4f 10             	mov    0x10(%edi),%ecx
80101159:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010115c:	89 0c 24             	mov    %ecx,(%esp)
8010115f:	e8 fc 06 00 00       	call   80101860 <iunlock>
      end_op();
80101164:	e8 d7 1a 00 00       	call   80102c40 <end_op>

      if(r < 0)
80101169:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010116c:	85 c0                	test   %eax,%eax
8010116e:	74 91                	je     80101101 <filewrite+0x61>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101170:	83 c4 2c             	add    $0x2c,%esp
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
80101173:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101178:	5b                   	pop    %ebx
80101179:	5e                   	pop    %esi
8010117a:	5f                   	pop    %edi
8010117b:	5d                   	pop    %ebp
8010117c:	c3                   	ret    
8010117d:	8d 76 00             	lea    0x0(%esi),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101180:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80101183:	89 d8                	mov    %ebx,%eax
80101185:	75 e9                	jne    80101170 <filewrite+0xd0>
  }
  panic("filewrite");
}
80101187:	83 c4 2c             	add    $0x2c,%esp
8010118a:	5b                   	pop    %ebx
8010118b:	5e                   	pop    %esi
8010118c:	5f                   	pop    %edi
8010118d:	5d                   	pop    %ebp
8010118e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010118f:	8b 47 0c             	mov    0xc(%edi),%eax
80101192:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101195:	83 c4 2c             	add    $0x2c,%esp
80101198:	5b                   	pop    %ebx
80101199:	5e                   	pop    %esi
8010119a:	5f                   	pop    %edi
8010119b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010119c:	e9 0f 22 00 00       	jmp    801033b0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801011a1:	c7 04 24 4f 6d 10 80 	movl   $0x80106d4f,(%esp)
801011a8:	e8 b3 f1 ff ff       	call   80100360 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801011ad:	c7 04 24 55 6d 10 80 	movl   $0x80106d55,(%esp)
801011b4:	e8 a7 f1 ff ff       	call   80100360 <panic>
801011b9:	66 90                	xchg   %ax,%ax
801011bb:	66 90                	xchg   %ax,%ax
801011bd:	66 90                	xchg   %ax,%ax
801011bf:	90                   	nop

801011c0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011c0:	55                   	push   %ebp
801011c1:	89 e5                	mov    %esp,%ebp
801011c3:	57                   	push   %edi
801011c4:	56                   	push   %esi
801011c5:	53                   	push   %ebx
801011c6:	83 ec 2c             	sub    $0x2c,%esp
801011c9:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011cc:	a1 e0 09 11 80       	mov    0x801109e0,%eax
801011d1:	85 c0                	test   %eax,%eax
801011d3:	0f 84 8c 00 00 00    	je     80101265 <balloc+0xa5>
801011d9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011e0:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011e3:	89 f0                	mov    %esi,%eax
801011e5:	c1 f8 0c             	sar    $0xc,%eax
801011e8:	03 05 f8 09 11 80    	add    0x801109f8,%eax
801011ee:	89 44 24 04          	mov    %eax,0x4(%esp)
801011f2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011f5:	89 04 24             	mov    %eax,(%esp)
801011f8:	e8 d3 ee ff ff       	call   801000d0 <bread>
801011fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101200:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101205:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101208:	31 c0                	xor    %eax,%eax
8010120a:	eb 33                	jmp    8010123f <balloc+0x7f>
8010120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101210:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101213:	89 c2                	mov    %eax,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101215:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101217:	c1 fa 03             	sar    $0x3,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010121a:	83 e1 07             	and    $0x7,%ecx
8010121d:	bf 01 00 00 00       	mov    $0x1,%edi
80101222:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101224:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101229:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010122b:	0f b6 fb             	movzbl %bl,%edi
8010122e:	85 cf                	test   %ecx,%edi
80101230:	74 46                	je     80101278 <balloc+0xb8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101232:	83 c0 01             	add    $0x1,%eax
80101235:	83 c6 01             	add    $0x1,%esi
80101238:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010123d:	74 05                	je     80101244 <balloc+0x84>
8010123f:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101242:	72 cc                	jb     80101210 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101244:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101247:	89 04 24             	mov    %eax,(%esp)
8010124a:	e8 91 ef ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010124f:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101256:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101259:	3b 05 e0 09 11 80    	cmp    0x801109e0,%eax
8010125f:	0f 82 7b ff ff ff    	jb     801011e0 <balloc+0x20>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101265:	c7 04 24 5f 6d 10 80 	movl   $0x80106d5f,(%esp)
8010126c:	e8 ef f0 ff ff       	call   80100360 <panic>
80101271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101278:	09 d9                	or     %ebx,%ecx
8010127a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010127d:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
80101281:	89 1c 24             	mov    %ebx,(%esp)
80101284:	e8 e7 1a 00 00       	call   80102d70 <log_write>
        brelse(bp);
80101289:	89 1c 24             	mov    %ebx,(%esp)
8010128c:	e8 4f ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101291:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101294:	89 74 24 04          	mov    %esi,0x4(%esp)
80101298:	89 04 24             	mov    %eax,(%esp)
8010129b:	e8 30 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012a0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801012a7:	00 
801012a8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801012af:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801012b0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012b2:	8d 40 5c             	lea    0x5c(%eax),%eax
801012b5:	89 04 24             	mov    %eax,(%esp)
801012b8:	e8 a3 30 00 00       	call   80104360 <memset>
  log_write(bp);
801012bd:	89 1c 24             	mov    %ebx,(%esp)
801012c0:	e8 ab 1a 00 00       	call   80102d70 <log_write>
  brelse(bp);
801012c5:	89 1c 24             	mov    %ebx,(%esp)
801012c8:	e8 13 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801012cd:	83 c4 2c             	add    $0x2c,%esp
801012d0:	89 f0                	mov    %esi,%eax
801012d2:	5b                   	pop    %ebx
801012d3:	5e                   	pop    %esi
801012d4:	5f                   	pop    %edi
801012d5:	5d                   	pop    %ebp
801012d6:	c3                   	ret    
801012d7:	89 f6                	mov    %esi,%esi
801012d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	89 c7                	mov    %eax,%edi
801012e6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012e7:	31 f6                	xor    %esi,%esi
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012e9:	53                   	push   %ebx

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ea:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012ef:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801012f2:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012f9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
801012fc:	e8 9f 2f 00 00       	call   801042a0 <acquire>

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101301:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101304:	eb 14                	jmp    8010131a <iget+0x3a>
80101306:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101308:	85 f6                	test   %esi,%esi
8010130a:	74 3c                	je     80101348 <iget+0x68>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130c:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101312:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101318:	74 46                	je     80101360 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010131a:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010131d:	85 c9                	test   %ecx,%ecx
8010131f:	7e e7                	jle    80101308 <iget+0x28>
80101321:	39 3b                	cmp    %edi,(%ebx)
80101323:	75 e3                	jne    80101308 <iget+0x28>
80101325:	39 53 04             	cmp    %edx,0x4(%ebx)
80101328:	75 de                	jne    80101308 <iget+0x28>
      ip->ref++;
8010132a:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
8010132d:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010132f:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101336:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101339:	e8 d2 2f 00 00       	call   80104310 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010133e:	83 c4 1c             	add    $0x1c,%esp
80101341:	89 f0                	mov    %esi,%eax
80101343:	5b                   	pop    %ebx
80101344:	5e                   	pop    %esi
80101345:	5f                   	pop    %edi
80101346:	5d                   	pop    %ebp
80101347:	c3                   	ret    
80101348:	85 c9                	test   %ecx,%ecx
8010134a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010134d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101353:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101359:	75 bf                	jne    8010131a <iget+0x3a>
8010135b:	90                   	nop
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101360:	85 f6                	test   %esi,%esi
80101362:	74 29                	je     8010138d <iget+0xad>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101364:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101366:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101369:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101370:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101377:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010137e:	e8 8d 2f 00 00       	call   80104310 <release>

  return ip;
}
80101383:	83 c4 1c             	add    $0x1c,%esp
80101386:	89 f0                	mov    %esi,%eax
80101388:	5b                   	pop    %ebx
80101389:	5e                   	pop    %esi
8010138a:	5f                   	pop    %edi
8010138b:	5d                   	pop    %ebp
8010138c:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
8010138d:	c7 04 24 75 6d 10 80 	movl   $0x80106d75,(%esp)
80101394:	e8 c7 ef ff ff       	call   80100360 <panic>
80101399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801013a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	57                   	push   %edi
801013a4:	56                   	push   %esi
801013a5:	53                   	push   %ebx
801013a6:	89 c3                	mov    %eax,%ebx
801013a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013ab:	83 fa 0b             	cmp    $0xb,%edx
801013ae:	77 18                	ja     801013c8 <bmap+0x28>
801013b0:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
801013b3:	8b 46 5c             	mov    0x5c(%esi),%eax
801013b6:	85 c0                	test   %eax,%eax
801013b8:	74 66                	je     80101420 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ba:	83 c4 1c             	add    $0x1c,%esp
801013bd:	5b                   	pop    %ebx
801013be:	5e                   	pop    %esi
801013bf:	5f                   	pop    %edi
801013c0:	5d                   	pop    %ebp
801013c1:	c3                   	ret    
801013c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013c8:	8d 72 f4             	lea    -0xc(%edx),%esi

  if(bn < NINDIRECT){
801013cb:	83 fe 7f             	cmp    $0x7f,%esi
801013ce:	77 77                	ja     80101447 <bmap+0xa7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013d0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801013d6:	85 c0                	test   %eax,%eax
801013d8:	74 5e                	je     80101438 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013da:	89 44 24 04          	mov    %eax,0x4(%esp)
801013de:	8b 03                	mov    (%ebx),%eax
801013e0:	89 04 24             	mov    %eax,(%esp)
801013e3:	e8 e8 ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013e8:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013ec:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013ee:	8b 32                	mov    (%edx),%esi
801013f0:	85 f6                	test   %esi,%esi
801013f2:	75 19                	jne    8010140d <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
801013f4:	8b 03                	mov    (%ebx),%eax
801013f6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013f9:	e8 c2 fd ff ff       	call   801011c0 <balloc>
801013fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101401:	89 02                	mov    %eax,(%edx)
80101403:	89 c6                	mov    %eax,%esi
      log_write(bp);
80101405:	89 3c 24             	mov    %edi,(%esp)
80101408:	e8 63 19 00 00       	call   80102d70 <log_write>
    }
    brelse(bp);
8010140d:	89 3c 24             	mov    %edi,(%esp)
80101410:	e8 cb ed ff ff       	call   801001e0 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
80101415:	83 c4 1c             	add    $0x1c,%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101418:	89 f0                	mov    %esi,%eax
    return addr;
  }

  panic("bmap: out of range");
}
8010141a:	5b                   	pop    %ebx
8010141b:	5e                   	pop    %esi
8010141c:	5f                   	pop    %edi
8010141d:	5d                   	pop    %ebp
8010141e:	c3                   	ret    
8010141f:	90                   	nop
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101420:	8b 03                	mov    (%ebx),%eax
80101422:	e8 99 fd ff ff       	call   801011c0 <balloc>
80101427:	89 46 5c             	mov    %eax,0x5c(%esi)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010142a:	83 c4 1c             	add    $0x1c,%esp
8010142d:	5b                   	pop    %ebx
8010142e:	5e                   	pop    %esi
8010142f:	5f                   	pop    %edi
80101430:	5d                   	pop    %ebp
80101431:	c3                   	ret    
80101432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101438:	8b 03                	mov    (%ebx),%eax
8010143a:	e8 81 fd ff ff       	call   801011c0 <balloc>
8010143f:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101445:	eb 93                	jmp    801013da <bmap+0x3a>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101447:	c7 04 24 85 6d 10 80 	movl   $0x80106d85,(%esp)
8010144e:	e8 0d ef ff ff       	call   80100360 <panic>
80101453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101460 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	56                   	push   %esi
80101464:	53                   	push   %ebx
80101465:	83 ec 10             	sub    $0x10,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101468:	8b 45 08             	mov    0x8(%ebp),%eax
8010146b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101472:	00 
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101473:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101476:	89 04 24             	mov    %eax,(%esp)
80101479:	e8 52 ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010147e:	89 34 24             	mov    %esi,(%esp)
80101481:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101488:	00 
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
80101489:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010148b:	8d 40 5c             	lea    0x5c(%eax),%eax
8010148e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101492:	e8 69 2f 00 00       	call   80104400 <memmove>
  brelse(bp);
80101497:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010149a:	83 c4 10             	add    $0x10,%esp
8010149d:	5b                   	pop    %ebx
8010149e:	5e                   	pop    %esi
8010149f:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801014a0:	e9 3b ed ff ff       	jmp    801001e0 <brelse>
801014a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	57                   	push   %edi
801014b4:	89 d7                	mov    %edx,%edi
801014b6:	56                   	push   %esi
801014b7:	53                   	push   %ebx
801014b8:	89 c3                	mov    %eax,%ebx
801014ba:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801014bd:	89 04 24             	mov    %eax,(%esp)
801014c0:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
801014c7:	80 
801014c8:	e8 93 ff ff ff       	call   80101460 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014cd:	89 fa                	mov    %edi,%edx
801014cf:	c1 ea 0c             	shr    $0xc,%edx
801014d2:	03 15 f8 09 11 80    	add    0x801109f8,%edx
801014d8:	89 1c 24             	mov    %ebx,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
801014db:	bb 01 00 00 00       	mov    $0x1,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801014e0:	89 54 24 04          	mov    %edx,0x4(%esp)
801014e4:	e8 e7 eb ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801014e9:	89 f9                	mov    %edi,%ecx
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
801014eb:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
801014f1:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
801014f3:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014f6:	c1 fa 03             	sar    $0x3,%edx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801014f9:	d3 e3                	shl    %cl,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801014fb:	89 c6                	mov    %eax,%esi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
801014fd:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101502:	0f b6 c8             	movzbl %al,%ecx
80101505:	85 d9                	test   %ebx,%ecx
80101507:	74 20                	je     80101529 <bfree+0x79>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101509:	f7 d3                	not    %ebx
8010150b:	21 c3                	and    %eax,%ebx
8010150d:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
80101511:	89 34 24             	mov    %esi,(%esp)
80101514:	e8 57 18 00 00       	call   80102d70 <log_write>
  brelse(bp);
80101519:	89 34 24             	mov    %esi,(%esp)
8010151c:	e8 bf ec ff ff       	call   801001e0 <brelse>
}
80101521:	83 c4 1c             	add    $0x1c,%esp
80101524:	5b                   	pop    %ebx
80101525:	5e                   	pop    %esi
80101526:	5f                   	pop    %edi
80101527:	5d                   	pop    %ebp
80101528:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101529:	c7 04 24 98 6d 10 80 	movl   $0x80106d98,(%esp)
80101530:	e8 2b ee ff ff       	call   80100360 <panic>
80101535:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101540 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	53                   	push   %ebx
80101544:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101549:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010154c:	c7 44 24 04 ab 6d 10 	movl   $0x80106dab,0x4(%esp)
80101553:	80 
80101554:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010155b:	e8 d0 2b 00 00       	call   80104130 <initlock>
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101560:	89 1c 24             	mov    %ebx,(%esp)
80101563:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101569:	c7 44 24 04 b2 6d 10 	movl   $0x80106db2,0x4(%esp)
80101570:	80 
80101571:	e8 8a 2a 00 00       	call   80104000 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101576:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
8010157c:	75 e2                	jne    80101560 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010157e:	8b 45 08             	mov    0x8(%ebp),%eax
80101581:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
80101588:	80 
80101589:	89 04 24             	mov    %eax,(%esp)
8010158c:	e8 cf fe ff ff       	call   80101460 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101591:	a1 f8 09 11 80       	mov    0x801109f8,%eax
80101596:	c7 04 24 18 6e 10 80 	movl   $0x80106e18,(%esp)
8010159d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801015a1:	a1 f4 09 11 80       	mov    0x801109f4,%eax
801015a6:	89 44 24 18          	mov    %eax,0x18(%esp)
801015aa:	a1 f0 09 11 80       	mov    0x801109f0,%eax
801015af:	89 44 24 14          	mov    %eax,0x14(%esp)
801015b3:	a1 ec 09 11 80       	mov    0x801109ec,%eax
801015b8:	89 44 24 10          	mov    %eax,0x10(%esp)
801015bc:	a1 e8 09 11 80       	mov    0x801109e8,%eax
801015c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
801015c5:	a1 e4 09 11 80       	mov    0x801109e4,%eax
801015ca:	89 44 24 08          	mov    %eax,0x8(%esp)
801015ce:	a1 e0 09 11 80       	mov    0x801109e0,%eax
801015d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801015d7:	e8 24 f1 ff ff       	call   80100700 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801015dc:	83 c4 24             	add    $0x24,%esp
801015df:	5b                   	pop    %ebx
801015e0:	5d                   	pop    %ebp
801015e1:	c3                   	ret    
801015e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015f0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	57                   	push   %edi
801015f4:	56                   	push   %esi
801015f5:	53                   	push   %ebx
801015f6:	83 ec 2c             	sub    $0x2c,%esp
801015f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801015fc:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101603:	8b 7d 08             	mov    0x8(%ebp),%edi
80101606:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101609:	0f 86 a2 00 00 00    	jbe    801016b1 <ialloc+0xc1>
8010160f:	be 01 00 00 00       	mov    $0x1,%esi
80101614:	bb 01 00 00 00       	mov    $0x1,%ebx
80101619:	eb 1a                	jmp    80101635 <ialloc+0x45>
8010161b:	90                   	nop
8010161c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101620:	89 14 24             	mov    %edx,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101623:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101626:	e8 b5 eb ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010162b:	89 de                	mov    %ebx,%esi
8010162d:	3b 1d e8 09 11 80    	cmp    0x801109e8,%ebx
80101633:	73 7c                	jae    801016b1 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
80101635:	89 f0                	mov    %esi,%eax
80101637:	c1 e8 03             	shr    $0x3,%eax
8010163a:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101640:	89 3c 24             	mov    %edi,(%esp)
80101643:	89 44 24 04          	mov    %eax,0x4(%esp)
80101647:	e8 84 ea ff ff       	call   801000d0 <bread>
8010164c:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
8010164e:	89 f0                	mov    %esi,%eax
80101650:	83 e0 07             	and    $0x7,%eax
80101653:	c1 e0 06             	shl    $0x6,%eax
80101656:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010165a:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010165e:	75 c0                	jne    80101620 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101660:	89 0c 24             	mov    %ecx,(%esp)
80101663:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010166a:	00 
8010166b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101672:	00 
80101673:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101676:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101679:	e8 e2 2c 00 00       	call   80104360 <memset>
      dip->type = type;
8010167e:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
80101682:	8b 55 dc             	mov    -0x24(%ebp),%edx
  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
80101685:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
80101688:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
8010168b:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010168e:	89 14 24             	mov    %edx,(%esp)
80101691:	e8 da 16 00 00       	call   80102d70 <log_write>
      brelse(bp);
80101696:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101699:	89 14 24             	mov    %edx,(%esp)
8010169c:	e8 3f eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801016a1:	83 c4 2c             	add    $0x2c,%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801016a4:	89 f2                	mov    %esi,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801016a6:	5b                   	pop    %ebx
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801016a7:	89 f8                	mov    %edi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801016a9:	5e                   	pop    %esi
801016aa:	5f                   	pop    %edi
801016ab:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801016ac:	e9 2f fc ff ff       	jmp    801012e0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801016b1:	c7 04 24 b8 6d 10 80 	movl   $0x80106db8,(%esp)
801016b8:	e8 a3 ec ff ff       	call   80100360 <panic>
801016bd:	8d 76 00             	lea    0x0(%esi),%esi

801016c0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	56                   	push   %esi
801016c4:	53                   	push   %ebx
801016c5:	83 ec 10             	sub    $0x10,%esp
801016c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016cb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ce:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d1:	c1 e8 03             	shr    $0x3,%eax
801016d4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016da:	89 44 24 04          	mov    %eax,0x4(%esp)
801016de:	8b 43 a4             	mov    -0x5c(%ebx),%eax
801016e1:	89 04 24             	mov    %eax,(%esp)
801016e4:	e8 e7 e9 ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e9:	8b 53 a8             	mov    -0x58(%ebx),%edx
801016ec:	83 e2 07             	and    $0x7,%edx
801016ef:	c1 e2 06             	shl    $0x6,%edx
801016f2:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016f6:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
801016f8:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016fc:	83 c2 0c             	add    $0xc,%edx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
801016ff:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
80101703:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
80101707:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
8010170b:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
8010170f:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
80101713:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
80101717:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
8010171b:	8b 43 fc             	mov    -0x4(%ebx),%eax
8010171e:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101721:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101725:	89 14 24             	mov    %edx,(%esp)
80101728:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010172f:	00 
80101730:	e8 cb 2c 00 00       	call   80104400 <memmove>
  log_write(bp);
80101735:	89 34 24             	mov    %esi,(%esp)
80101738:	e8 33 16 00 00       	call   80102d70 <log_write>
  brelse(bp);
8010173d:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101740:	83 c4 10             	add    $0x10,%esp
80101743:	5b                   	pop    %ebx
80101744:	5e                   	pop    %esi
80101745:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
80101746:	e9 95 ea ff ff       	jmp    801001e0 <brelse>
8010174b:	90                   	nop
8010174c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101750 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	53                   	push   %ebx
80101754:	83 ec 14             	sub    $0x14,%esp
80101757:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010175a:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101761:	e8 3a 2b 00 00       	call   801042a0 <acquire>
  ip->ref++;
80101766:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010176a:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101771:	e8 9a 2b 00 00       	call   80104310 <release>
  return ip;
}
80101776:	83 c4 14             	add    $0x14,%esp
80101779:	89 d8                	mov    %ebx,%eax
8010177b:	5b                   	pop    %ebx
8010177c:	5d                   	pop    %ebp
8010177d:	c3                   	ret    
8010177e:	66 90                	xchg   %ax,%ax

80101780 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	83 ec 10             	sub    $0x10,%esp
80101788:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010178b:	85 db                	test   %ebx,%ebx
8010178d:	0f 84 b3 00 00 00    	je     80101846 <ilock+0xc6>
80101793:	8b 53 08             	mov    0x8(%ebx),%edx
80101796:	85 d2                	test   %edx,%edx
80101798:	0f 8e a8 00 00 00    	jle    80101846 <ilock+0xc6>
    panic("ilock");

  acquiresleep(&ip->lock);
8010179e:	8d 43 0c             	lea    0xc(%ebx),%eax
801017a1:	89 04 24             	mov    %eax,(%esp)
801017a4:	e8 97 28 00 00       	call   80104040 <acquiresleep>

  if(ip->valid == 0){
801017a9:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017ac:	85 c0                	test   %eax,%eax
801017ae:	74 08                	je     801017b8 <ilock+0x38>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801017b0:	83 c4 10             	add    $0x10,%esp
801017b3:	5b                   	pop    %ebx
801017b4:	5e                   	pop    %esi
801017b5:	5d                   	pop    %ebp
801017b6:	c3                   	ret    
801017b7:	90                   	nop
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017b8:	8b 43 04             	mov    0x4(%ebx),%eax
801017bb:	c1 e8 03             	shr    $0x3,%eax
801017be:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801017c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801017c8:	8b 03                	mov    (%ebx),%eax
801017ca:	89 04 24             	mov    %eax,(%esp)
801017cd:	e8 fe e8 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017d2:	8b 53 04             	mov    0x4(%ebx),%edx
801017d5:	83 e2 07             	and    $0x7,%edx
801017d8:	c1 e2 06             	shl    $0x6,%edx
801017db:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017df:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801017e1:	0f b7 02             	movzwl (%edx),%eax
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017e4:	83 c2 0c             	add    $0xc,%edx
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801017e7:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
801017eb:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
801017ef:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
801017f3:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
801017f7:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
801017fb:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
801017ff:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
80101803:	8b 42 fc             	mov    -0x4(%edx),%eax
80101806:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101809:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010180c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101810:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101817:	00 
80101818:	89 04 24             	mov    %eax,(%esp)
8010181b:	e8 e0 2b 00 00       	call   80104400 <memmove>
    brelse(bp);
80101820:	89 34 24             	mov    %esi,(%esp)
80101823:	e8 b8 e9 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101828:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010182d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101834:	0f 85 76 ff ff ff    	jne    801017b0 <ilock+0x30>
      panic("ilock: no type");
8010183a:	c7 04 24 d0 6d 10 80 	movl   $0x80106dd0,(%esp)
80101841:	e8 1a eb ff ff       	call   80100360 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101846:	c7 04 24 ca 6d 10 80 	movl   $0x80106dca,(%esp)
8010184d:	e8 0e eb ff ff       	call   80100360 <panic>
80101852:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101860 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	56                   	push   %esi
80101864:	53                   	push   %ebx
80101865:	83 ec 10             	sub    $0x10,%esp
80101868:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010186b:	85 db                	test   %ebx,%ebx
8010186d:	74 24                	je     80101893 <iunlock+0x33>
8010186f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101872:	89 34 24             	mov    %esi,(%esp)
80101875:	e8 66 28 00 00       	call   801040e0 <holdingsleep>
8010187a:	85 c0                	test   %eax,%eax
8010187c:	74 15                	je     80101893 <iunlock+0x33>
8010187e:	8b 43 08             	mov    0x8(%ebx),%eax
80101881:	85 c0                	test   %eax,%eax
80101883:	7e 0e                	jle    80101893 <iunlock+0x33>
    panic("iunlock");

  releasesleep(&ip->lock);
80101885:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101888:	83 c4 10             	add    $0x10,%esp
8010188b:	5b                   	pop    %ebx
8010188c:	5e                   	pop    %esi
8010188d:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010188e:	e9 0d 28 00 00       	jmp    801040a0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101893:	c7 04 24 df 6d 10 80 	movl   $0x80106ddf,(%esp)
8010189a:	e8 c1 ea ff ff       	call   80100360 <panic>
8010189f:	90                   	nop

801018a0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	57                   	push   %edi
801018a4:	56                   	push   %esi
801018a5:	53                   	push   %ebx
801018a6:	83 ec 1c             	sub    $0x1c,%esp
801018a9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801018ac:	8d 7e 0c             	lea    0xc(%esi),%edi
801018af:	89 3c 24             	mov    %edi,(%esp)
801018b2:	e8 89 27 00 00       	call   80104040 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018b7:	8b 56 4c             	mov    0x4c(%esi),%edx
801018ba:	85 d2                	test   %edx,%edx
801018bc:	74 07                	je     801018c5 <iput+0x25>
801018be:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801018c3:	74 2b                	je     801018f0 <iput+0x50>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801018c5:	89 3c 24             	mov    %edi,(%esp)
801018c8:	e8 d3 27 00 00       	call   801040a0 <releasesleep>

  acquire(&icache.lock);
801018cd:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801018d4:	e8 c7 29 00 00       	call   801042a0 <acquire>
  ip->ref--;
801018d9:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801018dd:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
801018e4:	83 c4 1c             	add    $0x1c,%esp
801018e7:	5b                   	pop    %ebx
801018e8:	5e                   	pop    %esi
801018e9:	5f                   	pop    %edi
801018ea:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801018eb:	e9 20 2a 00 00       	jmp    80104310 <release>
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801018f0:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801018f7:	e8 a4 29 00 00       	call   801042a0 <acquire>
    int r = ip->ref;
801018fc:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801018ff:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101906:	e8 05 2a 00 00       	call   80104310 <release>
    if(r == 1){
8010190b:	83 fb 01             	cmp    $0x1,%ebx
8010190e:	75 b5                	jne    801018c5 <iput+0x25>
80101910:	8d 4e 30             	lea    0x30(%esi),%ecx
80101913:	89 f3                	mov    %esi,%ebx
80101915:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101918:	89 cf                	mov    %ecx,%edi
8010191a:	eb 0b                	jmp    80101927 <iput+0x87>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101920:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101923:	39 fb                	cmp    %edi,%ebx
80101925:	74 19                	je     80101940 <iput+0xa0>
    if(ip->addrs[i]){
80101927:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010192a:	85 d2                	test   %edx,%edx
8010192c:	74 f2                	je     80101920 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
8010192e:	8b 06                	mov    (%esi),%eax
80101930:	e8 7b fb ff ff       	call   801014b0 <bfree>
      ip->addrs[i] = 0;
80101935:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
8010193c:	eb e2                	jmp    80101920 <iput+0x80>
8010193e:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
80101940:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101946:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101949:	85 c0                	test   %eax,%eax
8010194b:	75 2b                	jne    80101978 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010194d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101954:	89 34 24             	mov    %esi,(%esp)
80101957:	e8 64 fd ff ff       	call   801016c0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010195c:	31 c0                	xor    %eax,%eax
8010195e:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101962:	89 34 24             	mov    %esi,(%esp)
80101965:	e8 56 fd ff ff       	call   801016c0 <iupdate>
      ip->valid = 0;
8010196a:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101971:	e9 4f ff ff ff       	jmp    801018c5 <iput+0x25>
80101976:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101978:	89 44 24 04          	mov    %eax,0x4(%esp)
8010197c:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
8010197e:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101980:	89 04 24             	mov    %eax,(%esp)
80101983:	e8 48 e7 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101988:	89 7d e0             	mov    %edi,-0x20(%ebp)
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
8010198b:	8d 48 5c             	lea    0x5c(%eax),%ecx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010198e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101991:	89 cf                	mov    %ecx,%edi
80101993:	31 c0                	xor    %eax,%eax
80101995:	eb 0e                	jmp    801019a5 <iput+0x105>
80101997:	90                   	nop
80101998:	83 c3 01             	add    $0x1,%ebx
8010199b:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
801019a1:	89 d8                	mov    %ebx,%eax
801019a3:	74 10                	je     801019b5 <iput+0x115>
      if(a[j])
801019a5:	8b 14 87             	mov    (%edi,%eax,4),%edx
801019a8:	85 d2                	test   %edx,%edx
801019aa:	74 ec                	je     80101998 <iput+0xf8>
        bfree(ip->dev, a[j]);
801019ac:	8b 06                	mov    (%esi),%eax
801019ae:	e8 fd fa ff ff       	call   801014b0 <bfree>
801019b3:	eb e3                	jmp    80101998 <iput+0xf8>
    }
    brelse(bp);
801019b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019b8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019bb:	89 04 24             	mov    %eax,(%esp)
801019be:	e8 1d e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019c3:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801019c9:	8b 06                	mov    (%esi),%eax
801019cb:	e8 e0 fa ff ff       	call   801014b0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019d0:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801019d7:	00 00 00 
801019da:	e9 6e ff ff ff       	jmp    8010194d <iput+0xad>
801019df:	90                   	nop

801019e0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	53                   	push   %ebx
801019e4:	83 ec 14             	sub    $0x14,%esp
801019e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019ea:	89 1c 24             	mov    %ebx,(%esp)
801019ed:	e8 6e fe ff ff       	call   80101860 <iunlock>
  iput(ip);
801019f2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801019f5:	83 c4 14             	add    $0x14,%esp
801019f8:	5b                   	pop    %ebx
801019f9:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801019fa:	e9 a1 fe ff ff       	jmp    801018a0 <iput>
801019ff:	90                   	nop

80101a00 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	8b 55 08             	mov    0x8(%ebp),%edx
80101a06:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a09:	8b 0a                	mov    (%edx),%ecx
80101a0b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a0e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a11:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a14:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a18:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a1b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a1f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a23:	8b 52 58             	mov    0x58(%edx),%edx
80101a26:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a29:	5d                   	pop    %ebp
80101a2a:	c3                   	ret    
80101a2b:	90                   	nop
80101a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a30 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a30:	55                   	push   %ebp
80101a31:	89 e5                	mov    %esp,%ebp
80101a33:	57                   	push   %edi
80101a34:	56                   	push   %esi
80101a35:	53                   	push   %ebx
80101a36:	83 ec 2c             	sub    $0x2c,%esp
80101a39:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a3c:	8b 7d 08             	mov    0x8(%ebp),%edi
80101a3f:	8b 75 10             	mov    0x10(%ebp),%esi
80101a42:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a45:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a48:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a50:	0f 84 aa 00 00 00    	je     80101b00 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a56:	8b 47 58             	mov    0x58(%edi),%eax
80101a59:	39 f0                	cmp    %esi,%eax
80101a5b:	0f 82 c7 00 00 00    	jb     80101b28 <readi+0xf8>
80101a61:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a64:	89 da                	mov    %ebx,%edx
80101a66:	01 f2                	add    %esi,%edx
80101a68:	0f 82 ba 00 00 00    	jb     80101b28 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a6e:	89 c1                	mov    %eax,%ecx
80101a70:	29 f1                	sub    %esi,%ecx
80101a72:	39 d0                	cmp    %edx,%eax
80101a74:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a77:	31 c0                	xor    %eax,%eax
80101a79:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a7b:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a7e:	74 70                	je     80101af0 <readi+0xc0>
80101a80:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101a83:	89 c7                	mov    %eax,%edi
80101a85:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a88:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a8b:	89 f2                	mov    %esi,%edx
80101a8d:	c1 ea 09             	shr    $0x9,%edx
80101a90:	89 d8                	mov    %ebx,%eax
80101a92:	e8 09 f9 ff ff       	call   801013a0 <bmap>
80101a97:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a9b:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a9d:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa2:	89 04 24             	mov    %eax,(%esp)
80101aa5:	e8 26 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aaa:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101aad:	29 f9                	sub    %edi,%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aaf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101ab1:	89 f0                	mov    %esi,%eax
80101ab3:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ab8:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101aba:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101abe:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ac0:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ac4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac7:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101aca:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ace:	01 df                	add    %ebx,%edi
80101ad0:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101ad2:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ad5:	89 04 24             	mov    %eax,(%esp)
80101ad8:	e8 23 29 00 00       	call   80104400 <memmove>
    brelse(bp);
80101add:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ae0:	89 14 24             	mov    %edx,(%esp)
80101ae3:	e8 f8 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae8:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aeb:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101aee:	77 98                	ja     80101a88 <readi+0x58>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101af0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101af3:	83 c4 2c             	add    $0x2c,%esp
80101af6:	5b                   	pop    %ebx
80101af7:	5e                   	pop    %esi
80101af8:	5f                   	pop    %edi
80101af9:	5d                   	pop    %ebp
80101afa:	c3                   	ret    
80101afb:	90                   	nop
80101afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b00:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101b04:	66 83 f8 09          	cmp    $0x9,%ax
80101b08:	77 1e                	ja     80101b28 <readi+0xf8>
80101b0a:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101b11:	85 c0                	test   %eax,%eax
80101b13:	74 13                	je     80101b28 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101b15:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101b18:	89 75 10             	mov    %esi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101b1b:	83 c4 2c             	add    $0x2c,%esp
80101b1e:	5b                   	pop    %ebx
80101b1f:	5e                   	pop    %esi
80101b20:	5f                   	pop    %edi
80101b21:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101b22:	ff e0                	jmp    *%eax
80101b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101b28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b2d:	eb c4                	jmp    80101af3 <readi+0xc3>
80101b2f:	90                   	nop

80101b30 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	57                   	push   %edi
80101b34:	56                   	push   %esi
80101b35:	53                   	push   %ebx
80101b36:	83 ec 2c             	sub    $0x2c,%esp
80101b39:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b3f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b42:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b47:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b4a:	8b 75 10             	mov    0x10(%ebp),%esi
80101b4d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b50:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b53:	0f 84 b7 00 00 00    	je     80101c10 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b5f:	0f 82 e3 00 00 00    	jb     80101c48 <writei+0x118>
80101b65:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b68:	89 c8                	mov    %ecx,%eax
80101b6a:	01 f0                	add    %esi,%eax
80101b6c:	0f 82 d6 00 00 00    	jb     80101c48 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b72:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b77:	0f 87 cb 00 00 00    	ja     80101c48 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b7d:	85 c9                	test   %ecx,%ecx
80101b7f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b86:	74 77                	je     80101bff <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b88:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b8b:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b8d:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b92:	c1 ea 09             	shr    $0x9,%edx
80101b95:	89 f8                	mov    %edi,%eax
80101b97:	e8 04 f8 ff ff       	call   801013a0 <bmap>
80101b9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ba0:	8b 07                	mov    (%edi),%eax
80101ba2:	89 04 24             	mov    %eax,(%esp)
80101ba5:	e8 26 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101baa:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101bad:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101bb0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bb3:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bb5:	89 f0                	mov    %esi,%eax
80101bb7:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bbc:	29 c3                	sub    %eax,%ebx
80101bbe:	39 cb                	cmp    %ecx,%ebx
80101bc0:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bc3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bc7:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101bc9:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bcd:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101bd1:	89 04 24             	mov    %eax,(%esp)
80101bd4:	e8 27 28 00 00       	call   80104400 <memmove>
    log_write(bp);
80101bd9:	89 3c 24             	mov    %edi,(%esp)
80101bdc:	e8 8f 11 00 00       	call   80102d70 <log_write>
    brelse(bp);
80101be1:	89 3c 24             	mov    %edi,(%esp)
80101be4:	e8 f7 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bef:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bf2:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bf5:	77 91                	ja     80101b88 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101bf7:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bfa:	39 70 58             	cmp    %esi,0x58(%eax)
80101bfd:	72 39                	jb     80101c38 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bff:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c02:	83 c4 2c             	add    $0x2c,%esp
80101c05:	5b                   	pop    %ebx
80101c06:	5e                   	pop    %esi
80101c07:	5f                   	pop    %edi
80101c08:	5d                   	pop    %ebp
80101c09:	c3                   	ret    
80101c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c14:	66 83 f8 09          	cmp    $0x9,%ax
80101c18:	77 2e                	ja     80101c48 <writei+0x118>
80101c1a:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101c21:	85 c0                	test   %eax,%eax
80101c23:	74 23                	je     80101c48 <writei+0x118>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101c25:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101c28:	83 c4 2c             	add    $0x2c,%esp
80101c2b:	5b                   	pop    %ebx
80101c2c:	5e                   	pop    %esi
80101c2d:	5f                   	pop    %edi
80101c2e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101c2f:	ff e0                	jmp    *%eax
80101c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101c38:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c3b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c3e:	89 04 24             	mov    %eax,(%esp)
80101c41:	e8 7a fa ff ff       	call   801016c0 <iupdate>
80101c46:	eb b7                	jmp    80101bff <writei+0xcf>
  }
  return n;
}
80101c48:	83 c4 2c             	add    $0x2c,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101c4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101c50:	5b                   	pop    %ebx
80101c51:	5e                   	pop    %esi
80101c52:	5f                   	pop    %edi
80101c53:	5d                   	pop    %ebp
80101c54:	c3                   	ret    
80101c55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c60 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101c66:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c69:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101c70:	00 
80101c71:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c75:	8b 45 08             	mov    0x8(%ebp),%eax
80101c78:	89 04 24             	mov    %eax,(%esp)
80101c7b:	e8 00 28 00 00       	call   80104480 <strncmp>
}
80101c80:	c9                   	leave  
80101c81:	c3                   	ret    
80101c82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c90 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c90:	55                   	push   %ebp
80101c91:	89 e5                	mov    %esp,%ebp
80101c93:	57                   	push   %edi
80101c94:	56                   	push   %esi
80101c95:	53                   	push   %ebx
80101c96:	83 ec 2c             	sub    $0x2c,%esp
80101c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ca1:	0f 85 97 00 00 00    	jne    80101d3e <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ca7:	8b 53 58             	mov    0x58(%ebx),%edx
80101caa:	31 ff                	xor    %edi,%edi
80101cac:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101caf:	85 d2                	test   %edx,%edx
80101cb1:	75 0d                	jne    80101cc0 <dirlookup+0x30>
80101cb3:	eb 73                	jmp    80101d28 <dirlookup+0x98>
80101cb5:	8d 76 00             	lea    0x0(%esi),%esi
80101cb8:	83 c7 10             	add    $0x10,%edi
80101cbb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101cbe:	76 68                	jbe    80101d28 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101cc0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101cc7:	00 
80101cc8:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ccc:	89 74 24 04          	mov    %esi,0x4(%esp)
80101cd0:	89 1c 24             	mov    %ebx,(%esp)
80101cd3:	e8 58 fd ff ff       	call   80101a30 <readi>
80101cd8:	83 f8 10             	cmp    $0x10,%eax
80101cdb:	75 55                	jne    80101d32 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101cdd:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ce2:	74 d4                	je     80101cb8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101ce4:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ce7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ceb:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cee:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101cf5:	00 
80101cf6:	89 04 24             	mov    %eax,(%esp)
80101cf9:	e8 82 27 00 00       	call   80104480 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101cfe:	85 c0                	test   %eax,%eax
80101d00:	75 b6                	jne    80101cb8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101d02:	8b 45 10             	mov    0x10(%ebp),%eax
80101d05:	85 c0                	test   %eax,%eax
80101d07:	74 05                	je     80101d0e <dirlookup+0x7e>
        *poff = off;
80101d09:	8b 45 10             	mov    0x10(%ebp),%eax
80101d0c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d0e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d12:	8b 03                	mov    (%ebx),%eax
80101d14:	e8 c7 f5 ff ff       	call   801012e0 <iget>
    }
  }

  return 0;
}
80101d19:	83 c4 2c             	add    $0x2c,%esp
80101d1c:	5b                   	pop    %ebx
80101d1d:	5e                   	pop    %esi
80101d1e:	5f                   	pop    %edi
80101d1f:	5d                   	pop    %ebp
80101d20:	c3                   	ret    
80101d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d28:	83 c4 2c             	add    $0x2c,%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101d2b:	31 c0                	xor    %eax,%eax
}
80101d2d:	5b                   	pop    %ebx
80101d2e:	5e                   	pop    %esi
80101d2f:	5f                   	pop    %edi
80101d30:	5d                   	pop    %ebp
80101d31:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101d32:	c7 04 24 f9 6d 10 80 	movl   $0x80106df9,(%esp)
80101d39:	e8 22 e6 ff ff       	call   80100360 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101d3e:	c7 04 24 e7 6d 10 80 	movl   $0x80106de7,(%esp)
80101d45:	e8 16 e6 ff ff       	call   80100360 <panic>
80101d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d50 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d50:	55                   	push   %ebp
80101d51:	89 e5                	mov    %esp,%ebp
80101d53:	57                   	push   %edi
80101d54:	89 cf                	mov    %ecx,%edi
80101d56:	56                   	push   %esi
80101d57:	53                   	push   %ebx
80101d58:	89 c3                	mov    %eax,%ebx
80101d5a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d5d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d60:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101d63:	0f 84 51 01 00 00    	je     80101eba <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d69:	e8 f2 19 00 00       	call   80103760 <myproc>
80101d6e:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101d71:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101d78:	e8 23 25 00 00       	call   801042a0 <acquire>
  ip->ref++;
80101d7d:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d81:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101d88:	e8 83 25 00 00       	call   80104310 <release>
80101d8d:	eb 04                	jmp    80101d93 <namex+0x43>
80101d8f:	90                   	nop
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101d90:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101d93:	0f b6 03             	movzbl (%ebx),%eax
80101d96:	3c 2f                	cmp    $0x2f,%al
80101d98:	74 f6                	je     80101d90 <namex+0x40>
    path++;
  if(*path == 0)
80101d9a:	84 c0                	test   %al,%al
80101d9c:	0f 84 ed 00 00 00    	je     80101e8f <namex+0x13f>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101da2:	0f b6 03             	movzbl (%ebx),%eax
80101da5:	89 da                	mov    %ebx,%edx
80101da7:	84 c0                	test   %al,%al
80101da9:	0f 84 b1 00 00 00    	je     80101e60 <namex+0x110>
80101daf:	3c 2f                	cmp    $0x2f,%al
80101db1:	75 0f                	jne    80101dc2 <namex+0x72>
80101db3:	e9 a8 00 00 00       	jmp    80101e60 <namex+0x110>
80101db8:	3c 2f                	cmp    $0x2f,%al
80101dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101dc0:	74 0a                	je     80101dcc <namex+0x7c>
    path++;
80101dc2:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101dc5:	0f b6 02             	movzbl (%edx),%eax
80101dc8:	84 c0                	test   %al,%al
80101dca:	75 ec                	jne    80101db8 <namex+0x68>
80101dcc:	89 d1                	mov    %edx,%ecx
80101dce:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101dd0:	83 f9 0d             	cmp    $0xd,%ecx
80101dd3:	0f 8e 8f 00 00 00    	jle    80101e68 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101dd9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101ddd:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101de4:	00 
80101de5:	89 3c 24             	mov    %edi,(%esp)
80101de8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101deb:	e8 10 26 00 00       	call   80104400 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101df0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101df3:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101df5:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101df8:	75 0e                	jne    80101e08 <namex+0xb8>
80101dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101e00:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e03:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e06:	74 f8                	je     80101e00 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e08:	89 34 24             	mov    %esi,(%esp)
80101e0b:	e8 70 f9 ff ff       	call   80101780 <ilock>
    if(ip->type != T_DIR){
80101e10:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e15:	0f 85 85 00 00 00    	jne    80101ea0 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e1b:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e1e:	85 d2                	test   %edx,%edx
80101e20:	74 09                	je     80101e2b <namex+0xdb>
80101e22:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e25:	0f 84 a5 00 00 00    	je     80101ed0 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e2b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e32:	00 
80101e33:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101e37:	89 34 24             	mov    %esi,(%esp)
80101e3a:	e8 51 fe ff ff       	call   80101c90 <dirlookup>
80101e3f:	85 c0                	test   %eax,%eax
80101e41:	74 5d                	je     80101ea0 <namex+0x150>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101e43:	89 34 24             	mov    %esi,(%esp)
80101e46:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e49:	e8 12 fa ff ff       	call   80101860 <iunlock>
  iput(ip);
80101e4e:	89 34 24             	mov    %esi,(%esp)
80101e51:	e8 4a fa ff ff       	call   801018a0 <iput>
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101e56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e59:	89 c6                	mov    %eax,%esi
80101e5b:	e9 33 ff ff ff       	jmp    80101d93 <namex+0x43>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e60:	31 c9                	xor    %ecx,%ecx
80101e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101e68:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e6c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e70:	89 3c 24             	mov    %edi,(%esp)
80101e73:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e76:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e79:	e8 82 25 00 00       	call   80104400 <memmove>
    name[len] = 0;
80101e7e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e81:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e84:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e88:	89 d3                	mov    %edx,%ebx
80101e8a:	e9 66 ff ff ff       	jmp    80101df5 <namex+0xa5>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e92:	85 c0                	test   %eax,%eax
80101e94:	75 4c                	jne    80101ee2 <namex+0x192>
80101e96:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101e98:	83 c4 2c             	add    $0x2c,%esp
80101e9b:	5b                   	pop    %ebx
80101e9c:	5e                   	pop    %esi
80101e9d:	5f                   	pop    %edi
80101e9e:	5d                   	pop    %ebp
80101e9f:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101ea0:	89 34 24             	mov    %esi,(%esp)
80101ea3:	e8 b8 f9 ff ff       	call   80101860 <iunlock>
  iput(ip);
80101ea8:	89 34 24             	mov    %esi,(%esp)
80101eab:	e8 f0 f9 ff ff       	call   801018a0 <iput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101eb0:	83 c4 2c             	add    $0x2c,%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101eb3:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101eb5:	5b                   	pop    %ebx
80101eb6:	5e                   	pop    %esi
80101eb7:	5f                   	pop    %edi
80101eb8:	5d                   	pop    %ebp
80101eb9:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101eba:	ba 01 00 00 00       	mov    $0x1,%edx
80101ebf:	b8 01 00 00 00       	mov    $0x1,%eax
80101ec4:	e8 17 f4 ff ff       	call   801012e0 <iget>
80101ec9:	89 c6                	mov    %eax,%esi
80101ecb:	e9 c3 fe ff ff       	jmp    80101d93 <namex+0x43>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101ed0:	89 34 24             	mov    %esi,(%esp)
80101ed3:	e8 88 f9 ff ff       	call   80101860 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101ed8:	83 c4 2c             	add    $0x2c,%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101edb:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101edd:	5b                   	pop    %ebx
80101ede:	5e                   	pop    %esi
80101edf:	5f                   	pop    %edi
80101ee0:	5d                   	pop    %ebp
80101ee1:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101ee2:	89 34 24             	mov    %esi,(%esp)
80101ee5:	e8 b6 f9 ff ff       	call   801018a0 <iput>
    return 0;
80101eea:	31 c0                	xor    %eax,%eax
80101eec:	eb aa                	jmp    80101e98 <namex+0x148>
80101eee:	66 90                	xchg   %ax,%ax

80101ef0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
80101ef6:	83 ec 2c             	sub    $0x2c,%esp
80101ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101efc:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eff:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101f06:	00 
80101f07:	89 1c 24             	mov    %ebx,(%esp)
80101f0a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f0e:	e8 7d fd ff ff       	call   80101c90 <dirlookup>
80101f13:	85 c0                	test   %eax,%eax
80101f15:	0f 85 8b 00 00 00    	jne    80101fa6 <dirlink+0xb6>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f1b:	8b 43 58             	mov    0x58(%ebx),%eax
80101f1e:	31 ff                	xor    %edi,%edi
80101f20:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f23:	85 c0                	test   %eax,%eax
80101f25:	75 13                	jne    80101f3a <dirlink+0x4a>
80101f27:	eb 35                	jmp    80101f5e <dirlink+0x6e>
80101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f30:	8d 57 10             	lea    0x10(%edi),%edx
80101f33:	39 53 58             	cmp    %edx,0x58(%ebx)
80101f36:	89 d7                	mov    %edx,%edi
80101f38:	76 24                	jbe    80101f5e <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f3a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101f41:	00 
80101f42:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101f46:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f4a:	89 1c 24             	mov    %ebx,(%esp)
80101f4d:	e8 de fa ff ff       	call   80101a30 <readi>
80101f52:	83 f8 10             	cmp    $0x10,%eax
80101f55:	75 5e                	jne    80101fb5 <dirlink+0xc5>
      panic("dirlink read");
    if(de.inum == 0)
80101f57:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f5c:	75 d2                	jne    80101f30 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101f5e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f61:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101f68:	00 
80101f69:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f6d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f70:	89 04 24             	mov    %eax,(%esp)
80101f73:	e8 78 25 00 00       	call   801044f0 <strncpy>
  de.inum = inum;
80101f78:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f7b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101f82:	00 
80101f83:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101f87:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f8b:	89 1c 24             	mov    %ebx,(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101f8e:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f92:	e8 99 fb ff ff       	call   80101b30 <writei>
80101f97:	83 f8 10             	cmp    $0x10,%eax
80101f9a:	75 25                	jne    80101fc1 <dirlink+0xd1>
    panic("dirlink");

  return 0;
80101f9c:	31 c0                	xor    %eax,%eax
}
80101f9e:	83 c4 2c             	add    $0x2c,%esp
80101fa1:	5b                   	pop    %ebx
80101fa2:	5e                   	pop    %esi
80101fa3:	5f                   	pop    %edi
80101fa4:	5d                   	pop    %ebp
80101fa5:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101fa6:	89 04 24             	mov    %eax,(%esp)
80101fa9:	e8 f2 f8 ff ff       	call   801018a0 <iput>
    return -1;
80101fae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fb3:	eb e9                	jmp    80101f9e <dirlink+0xae>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101fb5:	c7 04 24 08 6e 10 80 	movl   $0x80106e08,(%esp)
80101fbc:	e8 9f e3 ff ff       	call   80100360 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101fc1:	c7 04 24 fe 73 10 80 	movl   $0x801073fe,(%esp)
80101fc8:	e8 93 e3 ff ff       	call   80100360 <panic>
80101fcd:	8d 76 00             	lea    0x0(%esi),%esi

80101fd0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101fd0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fd1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101fd3:	89 e5                	mov    %esp,%ebp
80101fd5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fdb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fde:	e8 6d fd ff ff       	call   80101d50 <namex>
}
80101fe3:	c9                   	leave  
80101fe4:	c3                   	ret    
80101fe5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ff0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ff0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ff1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ff6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ff8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ffb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ffe:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101fff:	e9 4c fd ff ff       	jmp    80101d50 <namex>
80102004:	66 90                	xchg   %ax,%ax
80102006:	66 90                	xchg   %ax,%ax
80102008:	66 90                	xchg   %ax,%ax
8010200a:	66 90                	xchg   %ax,%ax
8010200c:	66 90                	xchg   %ax,%ax
8010200e:	66 90                	xchg   %ax,%ax

80102010 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	56                   	push   %esi
80102014:	89 c6                	mov    %eax,%esi
80102016:	83 ec 14             	sub    $0x14,%esp
  if(b == 0)
80102019:	85 c0                	test   %eax,%eax
8010201b:	0f 84 99 00 00 00    	je     801020ba <idestart+0xaa>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102021:	8b 48 08             	mov    0x8(%eax),%ecx
80102024:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
8010202a:	0f 87 7e 00 00 00    	ja     801020ae <idestart+0x9e>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102030:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102035:	8d 76 00             	lea    0x0(%esi),%esi
80102038:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102039:	83 e0 c0             	and    $0xffffffc0,%eax
8010203c:	3c 40                	cmp    $0x40,%al
8010203e:	75 f8                	jne    80102038 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102040:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102045:	31 c0                	xor    %eax,%eax
80102047:	ee                   	out    %al,(%dx)
80102048:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010204d:	b8 01 00 00 00       	mov    $0x1,%eax
80102052:	ee                   	out    %al,(%dx)
80102053:	0f b6 c1             	movzbl %cl,%eax
80102056:	b2 f3                	mov    $0xf3,%dl
80102058:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102059:	89 c8                	mov    %ecx,%eax
8010205b:	b2 f4                	mov    $0xf4,%dl
8010205d:	c1 f8 08             	sar    $0x8,%eax
80102060:	ee                   	out    %al,(%dx)
80102061:	31 c0                	xor    %eax,%eax
80102063:	b2 f5                	mov    $0xf5,%dl
80102065:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102066:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010206a:	b2 f6                	mov    $0xf6,%dl
8010206c:	83 e0 01             	and    $0x1,%eax
8010206f:	c1 e0 04             	shl    $0x4,%eax
80102072:	83 c8 e0             	or     $0xffffffe0,%eax
80102075:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102076:	f6 06 04             	testb  $0x4,(%esi)
80102079:	75 15                	jne    80102090 <idestart+0x80>
8010207b:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102080:	b8 20 00 00 00       	mov    $0x20,%eax
80102085:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102086:	83 c4 14             	add    $0x14,%esp
80102089:	5e                   	pop    %esi
8010208a:	5d                   	pop    %ebp
8010208b:	c3                   	ret    
8010208c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102090:	b2 f7                	mov    $0xf7,%dl
80102092:	b8 30 00 00 00       	mov    $0x30,%eax
80102097:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102098:	b9 80 00 00 00       	mov    $0x80,%ecx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
8010209d:	83 c6 5c             	add    $0x5c,%esi
801020a0:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020a5:	fc                   	cld    
801020a6:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020a8:	83 c4 14             	add    $0x14,%esp
801020ab:	5e                   	pop    %esi
801020ac:	5d                   	pop    %ebp
801020ad:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
801020ae:	c7 04 24 74 6e 10 80 	movl   $0x80106e74,(%esp)
801020b5:	e8 a6 e2 ff ff       	call   80100360 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
801020ba:	c7 04 24 6b 6e 10 80 	movl   $0x80106e6b,(%esp)
801020c1:	e8 9a e2 ff ff       	call   80100360 <panic>
801020c6:	8d 76 00             	lea    0x0(%esi),%esi
801020c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020d0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801020d6:	c7 44 24 04 86 6e 10 	movl   $0x80106e86,0x4(%esp)
801020dd:	80 
801020de:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
801020e5:	e8 46 20 00 00       	call   80104130 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020ea:	a1 20 2d 11 80       	mov    0x80112d20,%eax
801020ef:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801020f6:	83 e8 01             	sub    $0x1,%eax
801020f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801020fd:	e8 7e 02 00 00       	call   80102380 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102102:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102107:	90                   	nop
80102108:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102109:	83 e0 c0             	and    $0xffffffc0,%eax
8010210c:	3c 40                	cmp    $0x40,%al
8010210e:	75 f8                	jne    80102108 <ideinit+0x38>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102110:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102115:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010211a:	ee                   	out    %al,(%dx)
8010211b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102120:	b2 f7                	mov    $0xf7,%dl
80102122:	eb 09                	jmp    8010212d <ideinit+0x5d>
80102124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102128:	83 e9 01             	sub    $0x1,%ecx
8010212b:	74 0f                	je     8010213c <ideinit+0x6c>
8010212d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010212e:	84 c0                	test   %al,%al
80102130:	74 f6                	je     80102128 <ideinit+0x58>
      havedisk1 = 1;
80102132:	c7 05 80 a5 10 80 01 	movl   $0x1,0x8010a580
80102139:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010213c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102141:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102146:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80102147:	c9                   	leave  
80102148:	c3                   	ret    
80102149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102150 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	57                   	push   %edi
80102154:	56                   	push   %esi
80102155:	53                   	push   %ebx
80102156:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102159:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
80102160:	e8 3b 21 00 00       	call   801042a0 <acquire>

  if((b = idequeue) == 0){
80102165:	8b 1d 84 a5 10 80    	mov    0x8010a584,%ebx
8010216b:	85 db                	test   %ebx,%ebx
8010216d:	74 30                	je     8010219f <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010216f:	8b 43 58             	mov    0x58(%ebx),%eax
80102172:	a3 84 a5 10 80       	mov    %eax,0x8010a584

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102177:	8b 33                	mov    (%ebx),%esi
80102179:	f7 c6 04 00 00 00    	test   $0x4,%esi
8010217f:	74 37                	je     801021b8 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102181:	83 e6 fb             	and    $0xfffffffb,%esi
80102184:	83 ce 02             	or     $0x2,%esi
80102187:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102189:	89 1c 24             	mov    %ebx,(%esp)
8010218c:	e8 bf 1c 00 00       	call   80103e50 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102191:	a1 84 a5 10 80       	mov    0x8010a584,%eax
80102196:	85 c0                	test   %eax,%eax
80102198:	74 05                	je     8010219f <ideintr+0x4f>
    idestart(idequeue);
8010219a:	e8 71 fe ff ff       	call   80102010 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
8010219f:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
801021a6:	e8 65 21 00 00       	call   80104310 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801021ab:	83 c4 1c             	add    $0x1c,%esp
801021ae:	5b                   	pop    %ebx
801021af:	5e                   	pop    %esi
801021b0:	5f                   	pop    %edi
801021b1:	5d                   	pop    %ebp
801021b2:	c3                   	ret    
801021b3:	90                   	nop
801021b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021b8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021bd:	8d 76 00             	lea    0x0(%esi),%esi
801021c0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021c1:	89 c1                	mov    %eax,%ecx
801021c3:	83 e1 c0             	and    $0xffffffc0,%ecx
801021c6:	80 f9 40             	cmp    $0x40,%cl
801021c9:	75 f5                	jne    801021c0 <ideintr+0x70>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021cb:	a8 21                	test   $0x21,%al
801021cd:	75 b2                	jne    80102181 <ideintr+0x31>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801021cf:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801021d2:	b9 80 00 00 00       	mov    $0x80,%ecx
801021d7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021dc:	fc                   	cld    
801021dd:	f3 6d                	rep insl (%dx),%es:(%edi)
801021df:	8b 33                	mov    (%ebx),%esi
801021e1:	eb 9e                	jmp    80102181 <ideintr+0x31>
801021e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	53                   	push   %ebx
801021f4:	83 ec 14             	sub    $0x14,%esp
801021f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801021fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801021fd:	89 04 24             	mov    %eax,(%esp)
80102200:	e8 db 1e 00 00       	call   801040e0 <holdingsleep>
80102205:	85 c0                	test   %eax,%eax
80102207:	0f 84 9e 00 00 00    	je     801022ab <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010220d:	8b 03                	mov    (%ebx),%eax
8010220f:	83 e0 06             	and    $0x6,%eax
80102212:	83 f8 02             	cmp    $0x2,%eax
80102215:	0f 84 a8 00 00 00    	je     801022c3 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010221b:	8b 53 04             	mov    0x4(%ebx),%edx
8010221e:	85 d2                	test   %edx,%edx
80102220:	74 0d                	je     8010222f <iderw+0x3f>
80102222:	a1 80 a5 10 80       	mov    0x8010a580,%eax
80102227:	85 c0                	test   %eax,%eax
80102229:	0f 84 88 00 00 00    	je     801022b7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010222f:	c7 04 24 a0 a5 10 80 	movl   $0x8010a5a0,(%esp)
80102236:	e8 65 20 00 00       	call   801042a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010223b:	a1 84 a5 10 80       	mov    0x8010a584,%eax
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102240:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102247:	85 c0                	test   %eax,%eax
80102249:	75 07                	jne    80102252 <iderw+0x62>
8010224b:	eb 4e                	jmp    8010229b <iderw+0xab>
8010224d:	8d 76 00             	lea    0x0(%esi),%esi
80102250:	89 d0                	mov    %edx,%eax
80102252:	8b 50 58             	mov    0x58(%eax),%edx
80102255:	85 d2                	test   %edx,%edx
80102257:	75 f7                	jne    80102250 <iderw+0x60>
80102259:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
8010225c:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
8010225e:	39 1d 84 a5 10 80    	cmp    %ebx,0x8010a584
80102264:	74 3c                	je     801022a2 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102266:	8b 03                	mov    (%ebx),%eax
80102268:	83 e0 06             	and    $0x6,%eax
8010226b:	83 f8 02             	cmp    $0x2,%eax
8010226e:	74 1a                	je     8010228a <iderw+0x9a>
    sleep(b, &idelock);
80102270:	c7 44 24 04 a0 a5 10 	movl   $0x8010a5a0,0x4(%esp)
80102277:	80 
80102278:	89 1c 24             	mov    %ebx,(%esp)
8010227b:	e8 40 1a 00 00       	call   80103cc0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102280:	8b 13                	mov    (%ebx),%edx
80102282:	83 e2 06             	and    $0x6,%edx
80102285:	83 fa 02             	cmp    $0x2,%edx
80102288:	75 e6                	jne    80102270 <iderw+0x80>
    sleep(b, &idelock);
  }


  release(&idelock);
8010228a:	c7 45 08 a0 a5 10 80 	movl   $0x8010a5a0,0x8(%ebp)
}
80102291:	83 c4 14             	add    $0x14,%esp
80102294:	5b                   	pop    %ebx
80102295:	5d                   	pop    %ebp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102296:	e9 75 20 00 00       	jmp    80104310 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010229b:	b8 84 a5 10 80       	mov    $0x8010a584,%eax
801022a0:	eb ba                	jmp    8010225c <iderw+0x6c>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801022a2:	89 d8                	mov    %ebx,%eax
801022a4:	e8 67 fd ff ff       	call   80102010 <idestart>
801022a9:	eb bb                	jmp    80102266 <iderw+0x76>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801022ab:	c7 04 24 8a 6e 10 80 	movl   $0x80106e8a,(%esp)
801022b2:	e8 a9 e0 ff ff       	call   80100360 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801022b7:	c7 04 24 b5 6e 10 80 	movl   $0x80106eb5,(%esp)
801022be:	e8 9d e0 ff ff       	call   80100360 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801022c3:	c7 04 24 a0 6e 10 80 	movl   $0x80106ea0,(%esp)
801022ca:	e8 91 e0 ff ff       	call   80100360 <panic>
801022cf:	90                   	nop

801022d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	56                   	push   %esi
801022d4:	53                   	push   %ebx
801022d5:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022d8:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801022df:	00 c0 fe 
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022e2:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801022e9:	00 00 00 
  return ioapic->data;
801022ec:	8b 15 54 26 11 80    	mov    0x80112654,%edx
801022f2:	8b 42 10             	mov    0x10(%edx),%eax
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022f5:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801022fb:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102301:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102308:	c1 e8 10             	shr    $0x10,%eax
8010230b:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010230e:	8b 43 10             	mov    0x10(%ebx),%eax
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
80102311:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102314:	39 c2                	cmp    %eax,%edx
80102316:	74 12                	je     8010232a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102318:	c7 04 24 d4 6e 10 80 	movl   $0x80106ed4,(%esp)
8010231f:	e8 dc e3 ff ff       	call   80100700 <cprintf>
80102324:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010232a:	ba 10 00 00 00       	mov    $0x10,%edx
8010232f:	31 c0                	xor    %eax,%eax
80102331:	eb 07                	jmp    8010233a <ioapicinit+0x6a>
80102333:	90                   	nop
80102334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102338:	89 cb                	mov    %ecx,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010233a:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010233c:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
80102342:	8d 48 20             	lea    0x20(%eax),%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102345:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010234b:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010234e:	89 4b 10             	mov    %ecx,0x10(%ebx)
80102351:	8d 4a 01             	lea    0x1(%edx),%ecx
80102354:	83 c2 02             	add    $0x2,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102357:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102359:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010235f:	39 c6                	cmp    %eax,%esi

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102361:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102368:	7d ce                	jge    80102338 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010236a:	83 c4 10             	add    $0x10,%esp
8010236d:	5b                   	pop    %ebx
8010236e:	5e                   	pop    %esi
8010236f:	5d                   	pop    %ebp
80102370:	c3                   	ret    
80102371:	eb 0d                	jmp    80102380 <ioapicenable>
80102373:	90                   	nop
80102374:	90                   	nop
80102375:	90                   	nop
80102376:	90                   	nop
80102377:	90                   	nop
80102378:	90                   	nop
80102379:	90                   	nop
8010237a:	90                   	nop
8010237b:	90                   	nop
8010237c:	90                   	nop
8010237d:	90                   	nop
8010237e:	90                   	nop
8010237f:	90                   	nop

80102380 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102380:	55                   	push   %ebp
80102381:	89 e5                	mov    %esp,%ebp
80102383:	8b 55 08             	mov    0x8(%ebp),%edx
80102386:	53                   	push   %ebx
80102387:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010238a:	8d 5a 20             	lea    0x20(%edx),%ebx
8010238d:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102391:	8b 15 54 26 11 80    	mov    0x80112654,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102397:	c1 e0 18             	shl    $0x18,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010239a:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
8010239c:	8b 15 54 26 11 80    	mov    0x80112654,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023a2:	83 c1 01             	add    $0x1,%ecx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801023a5:	89 5a 10             	mov    %ebx,0x10(%edx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023a8:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801023aa:	8b 15 54 26 11 80    	mov    0x80112654,%edx
801023b0:	89 42 10             	mov    %eax,0x10(%edx)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801023b3:	5b                   	pop    %ebx
801023b4:	5d                   	pop    %ebp
801023b5:	c3                   	ret    
801023b6:	66 90                	xchg   %ax,%ax
801023b8:	66 90                	xchg   %ax,%ax
801023ba:	66 90                	xchg   %ax,%ax
801023bc:	66 90                	xchg   %ax,%ax
801023be:	66 90                	xchg   %ax,%ax

801023c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	53                   	push   %ebx
801023c4:	83 ec 14             	sub    $0x14,%esp
801023c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023d0:	75 7c                	jne    8010244e <kfree+0x8e>
801023d2:	81 fb c8 54 11 80    	cmp    $0x801154c8,%ebx
801023d8:	72 74                	jb     8010244e <kfree+0x8e>
801023da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801023e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801023e5:	77 67                	ja     8010244e <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801023e7:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801023ee:	00 
801023ef:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801023f6:	00 
801023f7:	89 1c 24             	mov    %ebx,(%esp)
801023fa:	e8 61 1f 00 00       	call   80104360 <memset>

  if(kmem.use_lock)
801023ff:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102405:	85 d2                	test   %edx,%edx
80102407:	75 37                	jne    80102440 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102409:	a1 98 26 11 80       	mov    0x80112698,%eax
8010240e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102410:	a1 94 26 11 80       	mov    0x80112694,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102415:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
8010241b:	85 c0                	test   %eax,%eax
8010241d:	75 09                	jne    80102428 <kfree+0x68>
    release(&kmem.lock);
}
8010241f:	83 c4 14             	add    $0x14,%esp
80102422:	5b                   	pop    %ebx
80102423:	5d                   	pop    %ebp
80102424:	c3                   	ret    
80102425:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102428:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
8010242f:	83 c4 14             	add    $0x14,%esp
80102432:	5b                   	pop    %ebx
80102433:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102434:	e9 d7 1e 00 00       	jmp    80104310 <release>
80102439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102440:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
80102447:	e8 54 1e 00 00       	call   801042a0 <acquire>
8010244c:	eb bb                	jmp    80102409 <kfree+0x49>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
8010244e:	c7 04 24 06 6f 10 80 	movl   $0x80106f06,(%esp)
80102455:	e8 06 df ff ff       	call   80100360 <panic>
8010245a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102460 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
80102465:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102468:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
8010246b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010246e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102474:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010247a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102480:	39 de                	cmp    %ebx,%esi
80102482:	73 08                	jae    8010248c <freerange+0x2c>
80102484:	eb 18                	jmp    8010249e <freerange+0x3e>
80102486:	66 90                	xchg   %ax,%ax
80102488:	89 da                	mov    %ebx,%edx
8010248a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010248c:	89 14 24             	mov    %edx,(%esp)
8010248f:	e8 2c ff ff ff       	call   801023c0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102494:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010249a:	39 f0                	cmp    %esi,%eax
8010249c:	76 ea                	jbe    80102488 <freerange+0x28>
    kfree(p);
}
8010249e:	83 c4 10             	add    $0x10,%esp
801024a1:	5b                   	pop    %ebx
801024a2:	5e                   	pop    %esi
801024a3:	5d                   	pop    %ebp
801024a4:	c3                   	ret    
801024a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024b0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	56                   	push   %esi
801024b4:	53                   	push   %ebx
801024b5:	83 ec 10             	sub    $0x10,%esp
801024b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024bb:	c7 44 24 04 0c 6f 10 	movl   $0x80106f0c,0x4(%esp)
801024c2:	80 
801024c3:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801024ca:	e8 61 1c 00 00       	call   80104130 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024cf:	8b 45 08             	mov    0x8(%ebp),%eax
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801024d2:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
801024d9:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024dc:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801024e2:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024e8:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801024ee:	39 de                	cmp    %ebx,%esi
801024f0:	73 0a                	jae    801024fc <kinit1+0x4c>
801024f2:	eb 1a                	jmp    8010250e <kinit1+0x5e>
801024f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024f8:	89 da                	mov    %ebx,%edx
801024fa:	89 c3                	mov    %eax,%ebx
    kfree(p);
801024fc:	89 14 24             	mov    %edx,(%esp)
801024ff:	e8 bc fe ff ff       	call   801023c0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102504:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010250a:	39 c6                	cmp    %eax,%esi
8010250c:	73 ea                	jae    801024f8 <kinit1+0x48>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010250e:	83 c4 10             	add    $0x10,%esp
80102511:	5b                   	pop    %ebx
80102512:	5e                   	pop    %esi
80102513:	5d                   	pop    %ebp
80102514:	c3                   	ret    
80102515:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102520 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	56                   	push   %esi
80102524:	53                   	push   %ebx
80102525:	83 ec 10             	sub    $0x10,%esp

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102528:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
8010252b:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010252e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102534:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010253a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102540:	39 de                	cmp    %ebx,%esi
80102542:	73 08                	jae    8010254c <kinit2+0x2c>
80102544:	eb 18                	jmp    8010255e <kinit2+0x3e>
80102546:	66 90                	xchg   %ax,%ax
80102548:	89 da                	mov    %ebx,%edx
8010254a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010254c:	89 14 24             	mov    %edx,(%esp)
8010254f:	e8 6c fe ff ff       	call   801023c0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102554:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010255a:	39 c6                	cmp    %eax,%esi
8010255c:	73 ea                	jae    80102548 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
8010255e:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
80102565:	00 00 00 
}
80102568:	83 c4 10             	add    $0x10,%esp
8010256b:	5b                   	pop    %ebx
8010256c:	5e                   	pop    %esi
8010256d:	5d                   	pop    %ebp
8010256e:	c3                   	ret    
8010256f:	90                   	nop

80102570 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	53                   	push   %ebx
80102574:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
80102577:	a1 94 26 11 80       	mov    0x80112694,%eax
8010257c:	85 c0                	test   %eax,%eax
8010257e:	75 30                	jne    801025b0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102580:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102586:	85 db                	test   %ebx,%ebx
80102588:	74 08                	je     80102592 <kalloc+0x22>
    kmem.freelist = r->next;
8010258a:	8b 13                	mov    (%ebx),%edx
8010258c:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
80102592:	85 c0                	test   %eax,%eax
80102594:	74 0c                	je     801025a2 <kalloc+0x32>
    release(&kmem.lock);
80102596:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
8010259d:	e8 6e 1d 00 00       	call   80104310 <release>
  return (char*)r;
}
801025a2:	83 c4 14             	add    $0x14,%esp
801025a5:	89 d8                	mov    %ebx,%eax
801025a7:	5b                   	pop    %ebx
801025a8:	5d                   	pop    %ebp
801025a9:	c3                   	ret    
801025aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801025b0:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801025b7:	e8 e4 1c 00 00       	call   801042a0 <acquire>
801025bc:	a1 94 26 11 80       	mov    0x80112694,%eax
801025c1:	eb bd                	jmp    80102580 <kalloc+0x10>
801025c3:	66 90                	xchg   %ax,%ax
801025c5:	66 90                	xchg   %ax,%ax
801025c7:	66 90                	xchg   %ax,%ax
801025c9:	66 90                	xchg   %ax,%ax
801025cb:	66 90                	xchg   %ax,%ax
801025cd:	66 90                	xchg   %ax,%ax
801025cf:	90                   	nop

801025d0 <kbdgetc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025d0:	ba 64 00 00 00       	mov    $0x64,%edx
801025d5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801025d6:	a8 01                	test   $0x1,%al
801025d8:	0f 84 ba 00 00 00    	je     80102698 <kbdgetc+0xc8>
801025de:	b2 60                	mov    $0x60,%dl
801025e0:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801025e1:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
801025e4:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
801025ea:	0f 84 88 00 00 00    	je     80102678 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801025f0:	84 c0                	test   %al,%al
801025f2:	79 2c                	jns    80102620 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801025f4:	8b 15 d4 a5 10 80    	mov    0x8010a5d4,%edx
801025fa:	f6 c2 40             	test   $0x40,%dl
801025fd:	75 05                	jne    80102604 <kbdgetc+0x34>
801025ff:	89 c1                	mov    %eax,%ecx
80102601:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102604:	0f b6 81 40 70 10 80 	movzbl -0x7fef8fc0(%ecx),%eax
8010260b:	83 c8 40             	or     $0x40,%eax
8010260e:	0f b6 c0             	movzbl %al,%eax
80102611:	f7 d0                	not    %eax
80102613:	21 d0                	and    %edx,%eax
80102615:	a3 d4 a5 10 80       	mov    %eax,0x8010a5d4
    return 0;
8010261a:	31 c0                	xor    %eax,%eax
8010261c:	c3                   	ret    
8010261d:	8d 76 00             	lea    0x0(%esi),%esi
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	53                   	push   %ebx
80102624:	8b 1d d4 a5 10 80    	mov    0x8010a5d4,%ebx
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010262a:	f6 c3 40             	test   $0x40,%bl
8010262d:	74 09                	je     80102638 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010262f:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102632:	83 e3 bf             	and    $0xffffffbf,%ebx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102635:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
80102638:	0f b6 91 40 70 10 80 	movzbl -0x7fef8fc0(%ecx),%edx
  shift ^= togglecode[data];
8010263f:	0f b6 81 40 6f 10 80 	movzbl -0x7fef90c0(%ecx),%eax
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
80102646:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102648:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010264a:	89 d0                	mov    %edx,%eax
8010264c:	83 e0 03             	and    $0x3,%eax
8010264f:	8b 04 85 20 6f 10 80 	mov    -0x7fef90e0(,%eax,4),%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102656:	89 15 d4 a5 10 80    	mov    %edx,0x8010a5d4
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
8010265c:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010265f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102663:	74 0b                	je     80102670 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
80102665:	8d 50 9f             	lea    -0x61(%eax),%edx
80102668:	83 fa 19             	cmp    $0x19,%edx
8010266b:	77 1b                	ja     80102688 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010266d:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102670:	5b                   	pop    %ebx
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret    
80102673:	90                   	nop
80102674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102678:	83 0d d4 a5 10 80 40 	orl    $0x40,0x8010a5d4
    return 0;
8010267f:	31 c0                	xor    %eax,%eax
80102681:	c3                   	ret    
80102682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102688:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010268b:	8d 50 20             	lea    0x20(%eax),%edx
8010268e:	83 f9 19             	cmp    $0x19,%ecx
80102691:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
80102694:	eb da                	jmp    80102670 <kbdgetc+0xa0>
80102696:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102698:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010269d:	c3                   	ret    
8010269e:	66 90                	xchg   %ax,%ax

801026a0 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801026a6:	c7 04 24 d0 25 10 80 	movl   $0x801025d0,(%esp)
801026ad:	e8 ae e1 ff ff       	call   80100860 <consoleintr>
}
801026b2:	c9                   	leave  
801026b3:	c3                   	ret    
801026b4:	66 90                	xchg   %ax,%ax
801026b6:	66 90                	xchg   %ax,%ax
801026b8:	66 90                	xchg   %ax,%ax
801026ba:	66 90                	xchg   %ax,%ax
801026bc:	66 90                	xchg   %ax,%ax
801026be:	66 90                	xchg   %ax,%ax

801026c0 <fill_rtcdate>:
  return inb(CMOS_RETURN);
}

static void
fill_rtcdate(struct rtcdate *r)
{
801026c0:	55                   	push   %ebp
801026c1:	89 c1                	mov    %eax,%ecx
801026c3:	89 e5                	mov    %esp,%ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026c5:	ba 70 00 00 00       	mov    $0x70,%edx
801026ca:	31 c0                	xor    %eax,%eax
801026cc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026cd:	b2 71                	mov    $0x71,%dl
801026cf:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
801026d0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026d3:	b2 70                	mov    $0x70,%dl
801026d5:	89 01                	mov    %eax,(%ecx)
801026d7:	b8 02 00 00 00       	mov    $0x2,%eax
801026dc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026dd:	b2 71                	mov    $0x71,%dl
801026df:	ec                   	in     (%dx),%al
801026e0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026e3:	b2 70                	mov    $0x70,%dl
801026e5:	89 41 04             	mov    %eax,0x4(%ecx)
801026e8:	b8 04 00 00 00       	mov    $0x4,%eax
801026ed:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026ee:	b2 71                	mov    $0x71,%dl
801026f0:	ec                   	in     (%dx),%al
801026f1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026f4:	b2 70                	mov    $0x70,%dl
801026f6:	89 41 08             	mov    %eax,0x8(%ecx)
801026f9:	b8 07 00 00 00       	mov    $0x7,%eax
801026fe:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026ff:	b2 71                	mov    $0x71,%dl
80102701:	ec                   	in     (%dx),%al
80102702:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102705:	b2 70                	mov    $0x70,%dl
80102707:	89 41 0c             	mov    %eax,0xc(%ecx)
8010270a:	b8 08 00 00 00       	mov    $0x8,%eax
8010270f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102710:	b2 71                	mov    $0x71,%dl
80102712:	ec                   	in     (%dx),%al
80102713:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102716:	b2 70                	mov    $0x70,%dl
80102718:	89 41 10             	mov    %eax,0x10(%ecx)
8010271b:	b8 09 00 00 00       	mov    $0x9,%eax
80102720:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102721:	b2 71                	mov    $0x71,%dl
80102723:	ec                   	in     (%dx),%al
80102724:	0f b6 c0             	movzbl %al,%eax
80102727:	89 41 14             	mov    %eax,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
8010272a:	5d                   	pop    %ebp
8010272b:	c3                   	ret    
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102730 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102730:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102735:	55                   	push   %ebp
80102736:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102738:	85 c0                	test   %eax,%eax
8010273a:	0f 84 c0 00 00 00    	je     80102800 <lapicinit+0xd0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102740:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102747:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010274a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010274d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102754:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102757:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010275a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102761:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102764:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102767:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010276e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102771:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102774:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010277b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010277e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102781:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102788:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010278b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010278e:	8b 50 30             	mov    0x30(%eax),%edx
80102791:	c1 ea 10             	shr    $0x10,%edx
80102794:	80 fa 03             	cmp    $0x3,%dl
80102797:	77 6f                	ja     80102808 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102799:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801027a0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a3:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b0:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027bd:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ca:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027cd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027da:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027e1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027e4:	8b 50 20             	mov    0x20(%eax),%edx
801027e7:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027e8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027ee:	80 e6 10             	and    $0x10,%dh
801027f1:	75 f5                	jne    801027e8 <lapicinit+0xb8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027fa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027fd:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102800:	5d                   	pop    %ebp
80102801:	c3                   	ret    
80102802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102808:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010280f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102812:	8b 50 20             	mov    0x20(%eax),%edx
80102815:	eb 82                	jmp    80102799 <lapicinit+0x69>
80102817:	89 f6                	mov    %esi,%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102820 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102820:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102825:	55                   	push   %ebp
80102826:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102828:	85 c0                	test   %eax,%eax
8010282a:	74 0c                	je     80102838 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010282c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010282f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102830:	c1 e8 18             	shr    $0x18,%eax
}
80102833:	c3                   	ret    
80102834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102838:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010283a:	5d                   	pop    %ebp
8010283b:	c3                   	ret    
8010283c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102840 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102840:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102845:	55                   	push   %ebp
80102846:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102848:	85 c0                	test   %eax,%eax
8010284a:	74 0d                	je     80102859 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010284c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102853:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102856:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102859:	5d                   	pop    %ebp
8010285a:	c3                   	ret    
8010285b:	90                   	nop
8010285c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102860 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102860:	55                   	push   %ebp
80102861:	89 e5                	mov    %esp,%ebp
}
80102863:	5d                   	pop    %ebp
80102864:	c3                   	ret    
80102865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102870 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102870:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102871:	ba 70 00 00 00       	mov    $0x70,%edx
80102876:	89 e5                	mov    %esp,%ebp
80102878:	b8 0f 00 00 00       	mov    $0xf,%eax
8010287d:	53                   	push   %ebx
8010287e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102881:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102884:	ee                   	out    %al,(%dx)
80102885:	b8 0a 00 00 00       	mov    $0xa,%eax
8010288a:	b2 71                	mov    $0x71,%dl
8010288c:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010288d:	31 c0                	xor    %eax,%eax
8010288f:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102895:	89 d8                	mov    %ebx,%eax
80102897:	c1 e8 04             	shr    $0x4,%eax
8010289a:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801028a5:	c1 e1 18             	shl    $0x18,%ecx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028a8:	c1 eb 0c             	shr    $0xc,%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ab:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b1:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028b4:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028bb:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028be:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028c1:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028c8:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028cb:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ce:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d4:	8b 50 20             	mov    0x20(%eax),%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028d7:	89 da                	mov    %ebx,%edx
801028d9:	80 ce 06             	or     $0x6,%dh

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028dc:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e2:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028e5:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028eb:	8b 48 20             	mov    0x20(%eax),%ecx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ee:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f4:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801028f7:	5b                   	pop    %ebx
801028f8:	5d                   	pop    %ebp
801028f9:	c3                   	ret    
801028fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102900 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102900:	55                   	push   %ebp
80102901:	ba 70 00 00 00       	mov    $0x70,%edx
80102906:	89 e5                	mov    %esp,%ebp
80102908:	b8 0b 00 00 00       	mov    $0xb,%eax
8010290d:	57                   	push   %edi
8010290e:	56                   	push   %esi
8010290f:	53                   	push   %ebx
80102910:	83 ec 4c             	sub    $0x4c,%esp
80102913:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102914:	b2 71                	mov    $0x71,%dl
80102916:	ec                   	in     (%dx),%al
80102917:	88 45 b7             	mov    %al,-0x49(%ebp)
8010291a:	8d 5d b8             	lea    -0x48(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010291d:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102921:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102928:	be 70 00 00 00       	mov    $0x70,%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010292d:	89 d8                	mov    %ebx,%eax
8010292f:	e8 8c fd ff ff       	call   801026c0 <fill_rtcdate>
80102934:	b8 0a 00 00 00       	mov    $0xa,%eax
80102939:	89 f2                	mov    %esi,%edx
8010293b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293c:	ba 71 00 00 00       	mov    $0x71,%edx
80102941:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102942:	84 c0                	test   %al,%al
80102944:	78 e7                	js     8010292d <cmostime+0x2d>
        continue;
    fill_rtcdate(&t2);
80102946:	89 f8                	mov    %edi,%eax
80102948:	e8 73 fd ff ff       	call   801026c0 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010294d:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
80102954:	00 
80102955:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102959:	89 1c 24             	mov    %ebx,(%esp)
8010295c:	e8 4f 1a 00 00       	call   801043b0 <memcmp>
80102961:	85 c0                	test   %eax,%eax
80102963:	75 c3                	jne    80102928 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102965:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102969:	75 78                	jne    801029e3 <cmostime+0xe3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010296b:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010296e:	89 c2                	mov    %eax,%edx
80102970:	83 e0 0f             	and    $0xf,%eax
80102973:	c1 ea 04             	shr    $0x4,%edx
80102976:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102979:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297c:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010297f:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102982:	89 c2                	mov    %eax,%edx
80102984:	83 e0 0f             	and    $0xf,%eax
80102987:	c1 ea 04             	shr    $0x4,%edx
8010298a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102990:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102993:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102996:	89 c2                	mov    %eax,%edx
80102998:	83 e0 0f             	and    $0xf,%eax
8010299b:	c1 ea 04             	shr    $0x4,%edx
8010299e:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a4:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029a7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029aa:	89 c2                	mov    %eax,%edx
801029ac:	83 e0 0f             	and    $0xf,%eax
801029af:	c1 ea 04             	shr    $0x4,%edx
801029b2:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029bb:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029be:	89 c2                	mov    %eax,%edx
801029c0:	83 e0 0f             	and    $0xf,%eax
801029c3:	c1 ea 04             	shr    $0x4,%edx
801029c6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029cc:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029cf:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029d2:	89 c2                	mov    %eax,%edx
801029d4:	83 e0 0f             	and    $0xf,%eax
801029d7:	c1 ea 04             	shr    $0x4,%edx
801029da:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029dd:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029e0:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
801029e6:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029e9:	89 01                	mov    %eax,(%ecx)
801029eb:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029ee:	89 41 04             	mov    %eax,0x4(%ecx)
801029f1:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029f4:	89 41 08             	mov    %eax,0x8(%ecx)
801029f7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029fa:	89 41 0c             	mov    %eax,0xc(%ecx)
801029fd:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a00:	89 41 10             	mov    %eax,0x10(%ecx)
80102a03:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a06:	89 41 14             	mov    %eax,0x14(%ecx)
  r->year += 2000;
80102a09:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
}
80102a10:	83 c4 4c             	add    $0x4c,%esp
80102a13:	5b                   	pop    %ebx
80102a14:	5e                   	pop    %esi
80102a15:	5f                   	pop    %edi
80102a16:	5d                   	pop    %ebp
80102a17:	c3                   	ret    
80102a18:	66 90                	xchg   %ax,%ax
80102a1a:	66 90                	xchg   %ax,%ax
80102a1c:	66 90                	xchg   %ax,%ax
80102a1e:	66 90                	xchg   %ax,%ax

80102a20 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a20:	55                   	push   %ebp
80102a21:	89 e5                	mov    %esp,%ebp
80102a23:	57                   	push   %edi
80102a24:	56                   	push   %esi
80102a25:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a26:	31 db                	xor    %ebx,%ebx
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a28:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a2b:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102a30:	85 c0                	test   %eax,%eax
80102a32:	7e 78                	jle    80102aac <install_trans+0x8c>
80102a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a38:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102a3d:	01 d8                	add    %ebx,%eax
80102a3f:	83 c0 01             	add    $0x1,%eax
80102a42:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a46:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102a4b:	89 04 24             	mov    %eax,(%esp)
80102a4e:	e8 7d d6 ff ff       	call   801000d0 <bread>
80102a53:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a55:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a5c:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a63:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102a68:	89 04 24             	mov    %eax,(%esp)
80102a6b:	e8 60 d6 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a70:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102a77:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a78:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a7a:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a7d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a81:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a84:	89 04 24             	mov    %eax,(%esp)
80102a87:	e8 74 19 00 00       	call   80104400 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a8c:	89 34 24             	mov    %esi,(%esp)
80102a8f:	e8 0c d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a94:	89 3c 24             	mov    %edi,(%esp)
80102a97:	e8 44 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a9c:	89 34 24             	mov    %esi,(%esp)
80102a9f:	e8 3c d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102aa4:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102aaa:	7f 8c                	jg     80102a38 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102aac:	83 c4 1c             	add    $0x1c,%esp
80102aaf:	5b                   	pop    %ebx
80102ab0:	5e                   	pop    %esi
80102ab1:	5f                   	pop    %edi
80102ab2:	5d                   	pop    %ebp
80102ab3:	c3                   	ret    
80102ab4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102aba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102ac0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	57                   	push   %edi
80102ac4:	56                   	push   %esi
80102ac5:	53                   	push   %ebx
80102ac6:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ac9:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102ace:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ad2:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102ad7:	89 04 24             	mov    %eax,(%esp)
80102ada:	e8 f1 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102adf:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102ae5:	31 d2                	xor    %edx,%edx
80102ae7:	85 db                	test   %ebx,%ebx
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102ae9:	89 c7                	mov    %eax,%edi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102aeb:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102aee:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102af1:	7e 17                	jle    80102b0a <write_head+0x4a>
80102af3:	90                   	nop
80102af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102af8:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102aff:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b03:	83 c2 01             	add    $0x1,%edx
80102b06:	39 da                	cmp    %ebx,%edx
80102b08:	75 ee                	jne    80102af8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b0a:	89 3c 24             	mov    %edi,(%esp)
80102b0d:	e8 8e d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b12:	89 3c 24             	mov    %edi,(%esp)
80102b15:	e8 c6 d6 ff ff       	call   801001e0 <brelse>
}
80102b1a:	83 c4 1c             	add    $0x1c,%esp
80102b1d:	5b                   	pop    %ebx
80102b1e:	5e                   	pop    %esi
80102b1f:	5f                   	pop    %edi
80102b20:	5d                   	pop    %ebp
80102b21:	c3                   	ret    
80102b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b30 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	56                   	push   %esi
80102b34:	53                   	push   %ebx
80102b35:	83 ec 30             	sub    $0x30,%esp
80102b38:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b3b:	c7 44 24 04 40 71 10 	movl   $0x80107140,0x4(%esp)
80102b42:	80 
80102b43:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102b4a:	e8 e1 15 00 00       	call   80104130 <initlock>
  readsb(dev, &sb);
80102b4f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b52:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b56:	89 1c 24             	mov    %ebx,(%esp)
80102b59:	e8 02 e9 ff ff       	call   80101460 <readsb>
  log.start = sb.logstart;
80102b5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102b61:	8b 55 e8             	mov    -0x18(%ebp),%edx

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b64:	89 1c 24             	mov    %ebx,(%esp)
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102b67:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b6d:	89 44 24 04          	mov    %eax,0x4(%esp)

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b71:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b77:	a3 d4 26 11 80       	mov    %eax,0x801126d4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b7c:	e8 4f d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b81:	31 d2                	xor    %edx,%edx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b83:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102b86:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102b89:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b8b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102b91:	7e 17                	jle    80102baa <initlog+0x7a>
80102b93:	90                   	nop
80102b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102b98:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102b9c:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102ba3:	83 c2 01             	add    $0x1,%edx
80102ba6:	39 da                	cmp    %ebx,%edx
80102ba8:	75 ee                	jne    80102b98 <initlog+0x68>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102baa:	89 04 24             	mov    %eax,(%esp)
80102bad:	e8 2e d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102bb2:	e8 69 fe ff ff       	call   80102a20 <install_trans>
  log.lh.n = 0;
80102bb7:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102bbe:	00 00 00 
  write_head(); // clear the log
80102bc1:	e8 fa fe ff ff       	call   80102ac0 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102bc6:	83 c4 30             	add    $0x30,%esp
80102bc9:	5b                   	pop    %ebx
80102bca:	5e                   	pop    %esi
80102bcb:	5d                   	pop    %ebp
80102bcc:	c3                   	ret    
80102bcd:	8d 76 00             	lea    0x0(%esi),%esi

80102bd0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102bd6:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102bdd:	e8 be 16 00 00       	call   801042a0 <acquire>
80102be2:	eb 18                	jmp    80102bfc <begin_op+0x2c>
80102be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102be8:	c7 44 24 04 a0 26 11 	movl   $0x801126a0,0x4(%esp)
80102bef:	80 
80102bf0:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102bf7:	e8 c4 10 00 00       	call   80103cc0 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102bfc:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102c01:	85 c0                	test   %eax,%eax
80102c03:	75 e3                	jne    80102be8 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c05:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102c0a:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102c10:	83 c0 01             	add    $0x1,%eax
80102c13:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c16:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c19:	83 fa 1e             	cmp    $0x1e,%edx
80102c1c:	7f ca                	jg     80102be8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c1e:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102c25:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102c2a:	e8 e1 16 00 00       	call   80104310 <release>
      break;
    }
  }
}
80102c2f:	c9                   	leave  
80102c30:	c3                   	ret    
80102c31:	eb 0d                	jmp    80102c40 <end_op>
80102c33:	90                   	nop
80102c34:	90                   	nop
80102c35:	90                   	nop
80102c36:	90                   	nop
80102c37:	90                   	nop
80102c38:	90                   	nop
80102c39:	90                   	nop
80102c3a:	90                   	nop
80102c3b:	90                   	nop
80102c3c:	90                   	nop
80102c3d:	90                   	nop
80102c3e:	90                   	nop
80102c3f:	90                   	nop

80102c40 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	57                   	push   %edi
80102c44:	56                   	push   %esi
80102c45:	53                   	push   %ebx
80102c46:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c49:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102c50:	e8 4b 16 00 00       	call   801042a0 <acquire>
  log.outstanding -= 1;
80102c55:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102c5a:	8b 15 e0 26 11 80    	mov    0x801126e0,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c60:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102c63:	85 d2                	test   %edx,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c65:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102c6a:	0f 85 f3 00 00 00    	jne    80102d63 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102c70:	85 c0                	test   %eax,%eax
80102c72:	0f 85 cb 00 00 00    	jne    80102d43 <end_op+0x103>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c78:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c7f:	31 db                	xor    %ebx,%ebx
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c81:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102c88:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c8b:	e8 80 16 00 00       	call   80104310 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c90:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c95:	85 c0                	test   %eax,%eax
80102c97:	0f 8e 90 00 00 00    	jle    80102d2d <end_op+0xed>
80102c9d:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102ca0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102ca5:	01 d8                	add    %ebx,%eax
80102ca7:	83 c0 01             	add    $0x1,%eax
80102caa:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cae:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102cb3:	89 04 24             	mov    %eax,(%esp)
80102cb6:	e8 15 d4 ff ff       	call   801000d0 <bread>
80102cbb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbd:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cc4:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cc7:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ccb:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102cd0:	89 04 24             	mov    %eax,(%esp)
80102cd3:	e8 f8 d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102cd8:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102cdf:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ce0:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ce2:	8d 40 5c             	lea    0x5c(%eax),%eax
80102ce5:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ce9:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cec:	89 04 24             	mov    %eax,(%esp)
80102cef:	e8 0c 17 00 00       	call   80104400 <memmove>
    bwrite(to);  // write the log
80102cf4:	89 34 24             	mov    %esi,(%esp)
80102cf7:	e8 a4 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cfc:	89 3c 24             	mov    %edi,(%esp)
80102cff:	e8 dc d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d04:	89 34 24             	mov    %esi,(%esp)
80102d07:	e8 d4 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d0c:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d12:	7c 8c                	jl     80102ca0 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d14:	e8 a7 fd ff ff       	call   80102ac0 <write_head>
    install_trans(); // Now install writes to home locations
80102d19:	e8 02 fd ff ff       	call   80102a20 <install_trans>
    log.lh.n = 0;
80102d1e:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d25:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d28:	e8 93 fd ff ff       	call   80102ac0 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d2d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d34:	e8 67 15 00 00       	call   801042a0 <acquire>
    log.committing = 0;
80102d39:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102d40:	00 00 00 
    wakeup(&log);
80102d43:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d4a:	e8 01 11 00 00       	call   80103e50 <wakeup>
    release(&log.lock);
80102d4f:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d56:	e8 b5 15 00 00       	call   80104310 <release>
  }
}
80102d5b:	83 c4 1c             	add    $0x1c,%esp
80102d5e:	5b                   	pop    %ebx
80102d5f:	5e                   	pop    %esi
80102d60:	5f                   	pop    %edi
80102d61:	5d                   	pop    %ebp
80102d62:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d63:	c7 04 24 44 71 10 80 	movl   $0x80107144,(%esp)
80102d6a:	e8 f1 d5 ff ff       	call   80100360 <panic>
80102d6f:	90                   	nop

80102d70 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	53                   	push   %ebx
80102d74:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d77:	a1 e8 26 11 80       	mov    0x801126e8,%eax
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d7c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d7f:	83 f8 1d             	cmp    $0x1d,%eax
80102d82:	0f 8f 98 00 00 00    	jg     80102e20 <log_write+0xb0>
80102d88:	8b 0d d8 26 11 80    	mov    0x801126d8,%ecx
80102d8e:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102d91:	39 d0                	cmp    %edx,%eax
80102d93:	0f 8d 87 00 00 00    	jge    80102e20 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d99:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d9e:	85 c0                	test   %eax,%eax
80102da0:	0f 8e 86 00 00 00    	jle    80102e2c <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102da6:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dad:	e8 ee 14 00 00       	call   801042a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102db2:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102db8:	83 fa 00             	cmp    $0x0,%edx
80102dbb:	7e 54                	jle    80102e11 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dbd:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102dc0:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dc2:	39 0d ec 26 11 80    	cmp    %ecx,0x801126ec
80102dc8:	75 0f                	jne    80102dd9 <log_write+0x69>
80102dca:	eb 3c                	jmp    80102e08 <log_write+0x98>
80102dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102dd0:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102dd7:	74 2f                	je     80102e08 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102dd9:	83 c0 01             	add    $0x1,%eax
80102ddc:	39 d0                	cmp    %edx,%eax
80102dde:	75 f0                	jne    80102dd0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102de0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102de7:	83 c2 01             	add    $0x1,%edx
80102dea:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102df0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102df3:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102dfa:	83 c4 14             	add    $0x14,%esp
80102dfd:	5b                   	pop    %ebx
80102dfe:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102dff:	e9 0c 15 00 00       	jmp    80104310 <release>
80102e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e08:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102e0f:	eb df                	jmp    80102df0 <log_write+0x80>
80102e11:	8b 43 08             	mov    0x8(%ebx),%eax
80102e14:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102e19:	75 d5                	jne    80102df0 <log_write+0x80>
80102e1b:	eb ca                	jmp    80102de7 <log_write+0x77>
80102e1d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e20:	c7 04 24 53 71 10 80 	movl   $0x80107153,(%esp)
80102e27:	e8 34 d5 ff ff       	call   80100360 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e2c:	c7 04 24 69 71 10 80 	movl   $0x80107169,(%esp)
80102e33:	e8 28 d5 ff ff       	call   80100360 <panic>
80102e38:	66 90                	xchg   %ax,%ax
80102e3a:	66 90                	xchg   %ax,%ax
80102e3c:	66 90                	xchg   %ax,%ax
80102e3e:	66 90                	xchg   %ax,%ax

80102e40 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	53                   	push   %ebx
80102e44:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e47:	e8 f4 08 00 00       	call   80103740 <cpuid>
80102e4c:	89 c3                	mov    %eax,%ebx
80102e4e:	e8 ed 08 00 00       	call   80103740 <cpuid>
80102e53:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102e57:	c7 04 24 84 71 10 80 	movl   $0x80107184,(%esp)
80102e5e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e62:	e8 99 d8 ff ff       	call   80100700 <cprintf>
  idtinit();       // load idt register
80102e67:	e8 d4 26 00 00       	call   80105540 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e6c:	e8 4f 08 00 00       	call   801036c0 <mycpu>
80102e71:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e73:	b8 01 00 00 00       	mov    $0x1,%eax
80102e78:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e7f:	e8 9c 0b 00 00       	call   80103a20 <scheduler>
80102e84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102e90 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e96:	e8 55 37 00 00       	call   801065f0 <switchkvm>
  seginit();
80102e9b:	e8 90 36 00 00       	call   80106530 <seginit>
  lapicinit();
80102ea0:	e8 8b f8 ff ff       	call   80102730 <lapicinit>
  mpmain();
80102ea5:	e8 96 ff ff ff       	call   80102e40 <mpmain>
80102eaa:	66 90                	xchg   %ax,%ax
80102eac:	66 90                	xchg   %ax,%ax
80102eae:	66 90                	xchg   %ax,%ax

80102eb0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102eb4:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102eb9:	83 e4 f0             	and    $0xfffffff0,%esp
80102ebc:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ebf:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102ec6:	80 
80102ec7:	c7 04 24 c8 54 11 80 	movl   $0x801154c8,(%esp)
80102ece:	e8 dd f5 ff ff       	call   801024b0 <kinit1>
  kvmalloc();      // kernel page table
80102ed3:	e8 a8 3b 00 00       	call   80106a80 <kvmalloc>
  mpinit();        // detect other processors
80102ed8:	e8 73 01 00 00       	call   80103050 <mpinit>
80102edd:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102ee0:	e8 4b f8 ff ff       	call   80102730 <lapicinit>
  seginit();       // segment descriptors
80102ee5:	e8 46 36 00 00       	call   80106530 <seginit>
  picinit();       // disable pic
80102eea:	e8 21 03 00 00       	call   80103210 <picinit>
80102eef:	90                   	nop
  ioapicinit();    // another interrupt controller
80102ef0:	e8 db f3 ff ff       	call   801022d0 <ioapicinit>
  consoleinit();   // console hardware
80102ef5:	e8 16 db ff ff       	call   80100a10 <consoleinit>
  uartinit();      // serial port
80102efa:	e8 61 29 00 00       	call   80105860 <uartinit>
80102eff:	90                   	nop
  pinit();         // process table
80102f00:	e8 9b 07 00 00       	call   801036a0 <pinit>
  tvinit();        // trap vectors
80102f05:	e8 96 25 00 00       	call   801054a0 <tvinit>
  binit();         // buffer cache
80102f0a:	e8 31 d1 ff ff       	call   80100040 <binit>
80102f0f:	90                   	nop
  fileinit();      // file table
80102f10:	e8 fb de ff ff       	call   80100e10 <fileinit>
  ideinit();       // disk 
80102f15:	e8 b6 f1 ff ff       	call   801020d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f1a:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102f21:	00 
80102f22:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102f29:	80 
80102f2a:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102f31:	e8 ca 14 00 00       	call   80104400 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f36:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80102f3d:	00 00 00 
80102f40:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f45:	39 d8                	cmp    %ebx,%eax
80102f47:	76 6a                	jbe    80102fb3 <main+0x103>
80102f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102f50:	e8 6b 07 00 00       	call   801036c0 <mycpu>
80102f55:	39 d8                	cmp    %ebx,%eax
80102f57:	74 41                	je     80102f9a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f59:	e8 12 f6 ff ff       	call   80102570 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102f5e:	c7 05 f8 6f 00 80 90 	movl   $0x80102e90,0x80006ff8
80102f65:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f68:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f6f:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f72:	05 00 10 00 00       	add    $0x1000,%eax
80102f77:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f7c:	0f b6 03             	movzbl (%ebx),%eax
80102f7f:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102f86:	00 
80102f87:	89 04 24             	mov    %eax,(%esp)
80102f8a:	e8 e1 f8 ff ff       	call   80102870 <lapicstartap>
80102f8f:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f90:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f96:	85 c0                	test   %eax,%eax
80102f98:	74 f6                	je     80102f90 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f9a:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80102fa1:	00 00 00 
80102fa4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102faa:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102faf:	39 c3                	cmp    %eax,%ebx
80102fb1:	72 9d                	jb     80102f50 <main+0xa0>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fb3:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102fba:	8e 
80102fbb:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102fc2:	e8 59 f5 ff ff       	call   80102520 <kinit2>
  userinit();      // first user process
80102fc7:	e8 c4 07 00 00       	call   80103790 <userinit>
  mpmain();        // finish this processor's setup
80102fcc:	e8 6f fe ff ff       	call   80102e40 <mpmain>
80102fd1:	66 90                	xchg   %ax,%ax
80102fd3:	66 90                	xchg   %ax,%ax
80102fd5:	66 90                	xchg   %ax,%ax
80102fd7:	66 90                	xchg   %ax,%ax
80102fd9:	66 90                	xchg   %ax,%ax
80102fdb:	66 90                	xchg   %ax,%ax
80102fdd:	66 90                	xchg   %ax,%ax
80102fdf:	90                   	nop

80102fe0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fe4:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fea:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102feb:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fee:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102ff1:	39 de                	cmp    %ebx,%esi
80102ff3:	73 3c                	jae    80103031 <mpsearch1+0x51>
80102ff5:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102fff:	00 
80103000:	c7 44 24 04 98 71 10 	movl   $0x80107198,0x4(%esp)
80103007:	80 
80103008:	89 34 24             	mov    %esi,(%esp)
8010300b:	e8 a0 13 00 00       	call   801043b0 <memcmp>
80103010:	85 c0                	test   %eax,%eax
80103012:	75 16                	jne    8010302a <mpsearch1+0x4a>
80103014:	31 c9                	xor    %ecx,%ecx
80103016:	31 d2                	xor    %edx,%edx
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103018:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010301c:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010301f:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103021:	83 fa 10             	cmp    $0x10,%edx
80103024:	75 f2                	jne    80103018 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103026:	84 c9                	test   %cl,%cl
80103028:	74 10                	je     8010303a <mpsearch1+0x5a>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
8010302a:	83 c6 10             	add    $0x10,%esi
8010302d:	39 f3                	cmp    %esi,%ebx
8010302f:	77 c7                	ja     80102ff8 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80103031:	83 c4 10             	add    $0x10,%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103034:	31 c0                	xor    %eax,%eax
}
80103036:	5b                   	pop    %ebx
80103037:	5e                   	pop    %esi
80103038:	5d                   	pop    %ebp
80103039:	c3                   	ret    
8010303a:	83 c4 10             	add    $0x10,%esp
8010303d:	89 f0                	mov    %esi,%eax
8010303f:	5b                   	pop    %ebx
80103040:	5e                   	pop    %esi
80103041:	5d                   	pop    %ebp
80103042:	c3                   	ret    
80103043:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103050 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103059:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103060:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103067:	c1 e0 08             	shl    $0x8,%eax
8010306a:	09 d0                	or     %edx,%eax
8010306c:	c1 e0 04             	shl    $0x4,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	75 1b                	jne    8010308e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103073:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010307a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103081:	c1 e0 08             	shl    $0x8,%eax
80103084:	09 d0                	or     %edx,%eax
80103086:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103089:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010308e:	ba 00 04 00 00       	mov    $0x400,%edx
80103093:	e8 48 ff ff ff       	call   80102fe0 <mpsearch1>
80103098:	85 c0                	test   %eax,%eax
8010309a:	89 c7                	mov    %eax,%edi
8010309c:	0f 84 22 01 00 00    	je     801031c4 <mpinit+0x174>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030a2:	8b 77 04             	mov    0x4(%edi),%esi
801030a5:	85 f6                	test   %esi,%esi
801030a7:	0f 84 30 01 00 00    	je     801031dd <mpinit+0x18d>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030ad:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801030b3:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801030ba:	00 
801030bb:	c7 44 24 04 9d 71 10 	movl   $0x8010719d,0x4(%esp)
801030c2:	80 
801030c3:	89 04 24             	mov    %eax,(%esp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801030c9:	e8 e2 12 00 00       	call   801043b0 <memcmp>
801030ce:	85 c0                	test   %eax,%eax
801030d0:	0f 85 07 01 00 00    	jne    801031dd <mpinit+0x18d>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801030d6:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801030dd:	3c 04                	cmp    $0x4,%al
801030df:	0f 85 0b 01 00 00    	jne    801031f0 <mpinit+0x1a0>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030e5:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030ec:	85 c0                	test   %eax,%eax
801030ee:	74 21                	je     80103111 <mpinit+0xc1>
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
801030f0:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
801030f2:	31 d2                	xor    %edx,%edx
801030f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030f8:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
801030ff:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103100:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103103:	01 d9                	add    %ebx,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103105:	39 d0                	cmp    %edx,%eax
80103107:	7f ef                	jg     801030f8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103109:	84 c9                	test   %cl,%cl
8010310b:	0f 85 cc 00 00 00    	jne    801031dd <mpinit+0x18d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103111:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103114:	85 c0                	test   %eax,%eax
80103116:	0f 84 c1 00 00 00    	je     801031dd <mpinit+0x18d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010311c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103122:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
80103127:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103133:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103139:	03 55 e4             	add    -0x1c(%ebp),%edx
8010313c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103140:	39 c2                	cmp    %eax,%edx
80103142:	76 1b                	jbe    8010315f <mpinit+0x10f>
80103144:	0f b6 08             	movzbl (%eax),%ecx
    switch(*p){
80103147:	80 f9 04             	cmp    $0x4,%cl
8010314a:	77 74                	ja     801031c0 <mpinit+0x170>
8010314c:	ff 24 8d dc 71 10 80 	jmp    *-0x7fef8e24(,%ecx,4)
80103153:	90                   	nop
80103154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103158:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010315b:	39 c2                	cmp    %eax,%edx
8010315d:	77 e5                	ja     80103144 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010315f:	85 db                	test   %ebx,%ebx
80103161:	0f 84 93 00 00 00    	je     801031fa <mpinit+0x1aa>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103167:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
8010316b:	74 12                	je     8010317f <mpinit+0x12f>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010316d:	ba 22 00 00 00       	mov    $0x22,%edx
80103172:	b8 70 00 00 00       	mov    $0x70,%eax
80103177:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103178:	b2 23                	mov    $0x23,%dl
8010317a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010317b:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010317e:	ee                   	out    %al,(%dx)
  }
}
8010317f:	83 c4 1c             	add    $0x1c,%esp
80103182:	5b                   	pop    %ebx
80103183:	5e                   	pop    %esi
80103184:	5f                   	pop    %edi
80103185:	5d                   	pop    %ebp
80103186:	c3                   	ret    
80103187:	90                   	nop
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103188:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
8010318e:	83 fe 07             	cmp    $0x7,%esi
80103191:	7f 17                	jg     801031aa <mpinit+0x15a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103193:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80103197:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
        ncpu++;
8010319d:	83 05 20 2d 11 80 01 	addl   $0x1,0x80112d20
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a4:	88 8e a0 27 11 80    	mov    %cl,-0x7feed860(%esi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
801031aa:	83 c0 14             	add    $0x14,%eax
      continue;
801031ad:	eb 91                	jmp    80103140 <mpinit+0xf0>
801031af:	90                   	nop
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031b0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801031b4:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031b7:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
801031bd:	eb 81                	jmp    80103140 <mpinit+0xf0>
801031bf:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031c0:	31 db                	xor    %ebx,%ebx
801031c2:	eb 83                	jmp    80103147 <mpinit+0xf7>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031c4:	ba 00 00 01 00       	mov    $0x10000,%edx
801031c9:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031ce:	e8 0d fe ff ff       	call   80102fe0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031d3:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031d5:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031d7:	0f 85 c5 fe ff ff    	jne    801030a2 <mpinit+0x52>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801031dd:	c7 04 24 a2 71 10 80 	movl   $0x801071a2,(%esp)
801031e4:	e8 77 d1 ff ff       	call   80100360 <panic>
801031e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
801031f0:	3c 01                	cmp    $0x1,%al
801031f2:	0f 84 ed fe ff ff    	je     801030e5 <mpinit+0x95>
801031f8:	eb e3                	jmp    801031dd <mpinit+0x18d>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801031fa:	c7 04 24 bc 71 10 80 	movl   $0x801071bc,(%esp)
80103201:	e8 5a d1 ff ff       	call   80100360 <panic>
80103206:	66 90                	xchg   %ax,%ax
80103208:	66 90                	xchg   %ax,%ax
8010320a:	66 90                	xchg   %ax,%ax
8010320c:	66 90                	xchg   %ax,%ax
8010320e:	66 90                	xchg   %ax,%ax

80103210 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103210:	55                   	push   %ebp
80103211:	ba 21 00 00 00       	mov    $0x21,%edx
80103216:	89 e5                	mov    %esp,%ebp
80103218:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010321d:	ee                   	out    %al,(%dx)
8010321e:	b2 a1                	mov    $0xa1,%dl
80103220:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103221:	5d                   	pop    %ebp
80103222:	c3                   	ret    
80103223:	66 90                	xchg   %ax,%ax
80103225:	66 90                	xchg   %ax,%ax
80103227:	66 90                	xchg   %ax,%ax
80103229:	66 90                	xchg   %ax,%ax
8010322b:	66 90                	xchg   %ax,%ax
8010322d:	66 90                	xchg   %ax,%ax
8010322f:	90                   	nop

80103230 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	57                   	push   %edi
80103234:	56                   	push   %esi
80103235:	53                   	push   %ebx
80103236:	83 ec 1c             	sub    $0x1c,%esp
80103239:	8b 75 08             	mov    0x8(%ebp),%esi
8010323c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010323f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103245:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010324b:	e8 e0 db ff ff       	call   80100e30 <filealloc>
80103250:	85 c0                	test   %eax,%eax
80103252:	89 06                	mov    %eax,(%esi)
80103254:	0f 84 a4 00 00 00    	je     801032fe <pipealloc+0xce>
8010325a:	e8 d1 db ff ff       	call   80100e30 <filealloc>
8010325f:	85 c0                	test   %eax,%eax
80103261:	89 03                	mov    %eax,(%ebx)
80103263:	0f 84 87 00 00 00    	je     801032f0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103269:	e8 02 f3 ff ff       	call   80102570 <kalloc>
8010326e:	85 c0                	test   %eax,%eax
80103270:	89 c7                	mov    %eax,%edi
80103272:	74 7c                	je     801032f0 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
80103274:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010327b:	00 00 00 
  p->writeopen = 1;
8010327e:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103285:	00 00 00 
  p->nwrite = 0;
80103288:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010328f:	00 00 00 
  p->nread = 0;
80103292:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103299:	00 00 00 
  initlock(&p->lock, "pipe");
8010329c:	89 04 24             	mov    %eax,(%esp)
8010329f:	c7 44 24 04 f0 71 10 	movl   $0x801071f0,0x4(%esp)
801032a6:	80 
801032a7:	e8 84 0e 00 00       	call   80104130 <initlock>
  (*f0)->type = FD_PIPE;
801032ac:	8b 06                	mov    (%esi),%eax
801032ae:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801032b4:	8b 06                	mov    (%esi),%eax
801032b6:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801032ba:	8b 06                	mov    (%esi),%eax
801032bc:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801032c0:	8b 06                	mov    (%esi),%eax
801032c2:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801032c5:	8b 03                	mov    (%ebx),%eax
801032c7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801032cd:	8b 03                	mov    (%ebx),%eax
801032cf:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801032d3:	8b 03                	mov    (%ebx),%eax
801032d5:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801032d9:	8b 03                	mov    (%ebx),%eax
  return 0;
801032db:	31 db                	xor    %ebx,%ebx
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
801032dd:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801032e0:	83 c4 1c             	add    $0x1c,%esp
801032e3:	89 d8                	mov    %ebx,%eax
801032e5:	5b                   	pop    %ebx
801032e6:	5e                   	pop    %esi
801032e7:	5f                   	pop    %edi
801032e8:	5d                   	pop    %ebp
801032e9:	c3                   	ret    
801032ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032f0:	8b 06                	mov    (%esi),%eax
801032f2:	85 c0                	test   %eax,%eax
801032f4:	74 08                	je     801032fe <pipealloc+0xce>
    fileclose(*f0);
801032f6:	89 04 24             	mov    %eax,(%esp)
801032f9:	e8 f2 db ff ff       	call   80100ef0 <fileclose>
  if(*f1)
801032fe:	8b 03                	mov    (%ebx),%eax
    fileclose(*f1);
  return -1;
80103300:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
80103305:	85 c0                	test   %eax,%eax
80103307:	74 d7                	je     801032e0 <pipealloc+0xb0>
    fileclose(*f1);
80103309:	89 04 24             	mov    %eax,(%esp)
8010330c:	e8 df db ff ff       	call   80100ef0 <fileclose>
  return -1;
}
80103311:	83 c4 1c             	add    $0x1c,%esp
80103314:	89 d8                	mov    %ebx,%eax
80103316:	5b                   	pop    %ebx
80103317:	5e                   	pop    %esi
80103318:	5f                   	pop    %edi
80103319:	5d                   	pop    %ebp
8010331a:	c3                   	ret    
8010331b:	90                   	nop
8010331c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103320 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	56                   	push   %esi
80103324:	53                   	push   %ebx
80103325:	83 ec 10             	sub    $0x10,%esp
80103328:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010332b:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010332e:	89 1c 24             	mov    %ebx,(%esp)
80103331:	e8 6a 0f 00 00       	call   801042a0 <acquire>
  if(writable){
80103336:	85 f6                	test   %esi,%esi
80103338:	74 3e                	je     80103378 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->nread);
8010333a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103340:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103347:	00 00 00 
    wakeup(&p->nread);
8010334a:	89 04 24             	mov    %eax,(%esp)
8010334d:	e8 fe 0a 00 00       	call   80103e50 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103352:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103358:	85 d2                	test   %edx,%edx
8010335a:	75 0a                	jne    80103366 <pipeclose+0x46>
8010335c:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103362:	85 c0                	test   %eax,%eax
80103364:	74 32                	je     80103398 <pipeclose+0x78>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103366:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103369:	83 c4 10             	add    $0x10,%esp
8010336c:	5b                   	pop    %ebx
8010336d:	5e                   	pop    %esi
8010336e:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010336f:	e9 9c 0f 00 00       	jmp    80104310 <release>
80103374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103378:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
8010337e:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103385:	00 00 00 
    wakeup(&p->nwrite);
80103388:	89 04 24             	mov    %eax,(%esp)
8010338b:	e8 c0 0a 00 00       	call   80103e50 <wakeup>
80103390:	eb c0                	jmp    80103352 <pipeclose+0x32>
80103392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103398:	89 1c 24             	mov    %ebx,(%esp)
8010339b:	e8 70 0f 00 00       	call   80104310 <release>
    kfree((char*)p);
801033a0:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
801033a3:	83 c4 10             	add    $0x10,%esp
801033a6:	5b                   	pop    %ebx
801033a7:	5e                   	pop    %esi
801033a8:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801033a9:	e9 12 f0 ff ff       	jmp    801023c0 <kfree>
801033ae:	66 90                	xchg   %ax,%ax

801033b0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
801033b5:	53                   	push   %ebx
801033b6:	83 ec 1c             	sub    $0x1c,%esp
801033b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033bc:	89 1c 24             	mov    %ebx,(%esp)
801033bf:	e8 dc 0e 00 00       	call   801042a0 <acquire>
  for(i = 0; i < n; i++){
801033c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
801033c7:	85 c9                	test   %ecx,%ecx
801033c9:	0f 8e b2 00 00 00    	jle    80103481 <pipewrite+0xd1>
801033cf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033d2:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801033d8:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033de:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801033e4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801033e7:	03 4d 10             	add    0x10(%ebp),%ecx
801033ea:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033ed:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801033f3:	81 c1 00 02 00 00    	add    $0x200,%ecx
801033f9:	39 c8                	cmp    %ecx,%eax
801033fb:	74 38                	je     80103435 <pipewrite+0x85>
801033fd:	eb 55                	jmp    80103454 <pipewrite+0xa4>
801033ff:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103400:	e8 5b 03 00 00       	call   80103760 <myproc>
80103405:	8b 40 24             	mov    0x24(%eax),%eax
80103408:	85 c0                	test   %eax,%eax
8010340a:	75 33                	jne    8010343f <pipewrite+0x8f>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010340c:	89 3c 24             	mov    %edi,(%esp)
8010340f:	e8 3c 0a 00 00       	call   80103e50 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103414:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103418:	89 34 24             	mov    %esi,(%esp)
8010341b:	e8 a0 08 00 00       	call   80103cc0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103420:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103426:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010342c:	05 00 02 00 00       	add    $0x200,%eax
80103431:	39 c2                	cmp    %eax,%edx
80103433:	75 23                	jne    80103458 <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
80103435:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010343b:	85 d2                	test   %edx,%edx
8010343d:	75 c1                	jne    80103400 <pipewrite+0x50>
        release(&p->lock);
8010343f:	89 1c 24             	mov    %ebx,(%esp)
80103442:	e8 c9 0e 00 00       	call   80104310 <release>
        return -1;
80103447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010344c:	83 c4 1c             	add    $0x1c,%esp
8010344f:	5b                   	pop    %ebx
80103450:	5e                   	pop    %esi
80103451:	5f                   	pop    %edi
80103452:	5d                   	pop    %ebp
80103453:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103454:	89 c2                	mov    %eax,%edx
80103456:	66 90                	xchg   %ax,%ax
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103458:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010345b:	8d 42 01             	lea    0x1(%edx),%eax
8010345e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103464:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
8010346a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010346e:	0f b6 09             	movzbl (%ecx),%ecx
80103471:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103475:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103478:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
8010347b:	0f 85 6c ff ff ff    	jne    801033ed <pipewrite+0x3d>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103481:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103487:	89 04 24             	mov    %eax,(%esp)
8010348a:	e8 c1 09 00 00       	call   80103e50 <wakeup>
  release(&p->lock);
8010348f:	89 1c 24             	mov    %ebx,(%esp)
80103492:	e8 79 0e 00 00       	call   80104310 <release>
  return n;
80103497:	8b 45 10             	mov    0x10(%ebp),%eax
8010349a:	eb b0                	jmp    8010344c <pipewrite+0x9c>
8010349c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801034a0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	57                   	push   %edi
801034a4:	56                   	push   %esi
801034a5:	53                   	push   %ebx
801034a6:	83 ec 1c             	sub    $0x1c,%esp
801034a9:	8b 75 08             	mov    0x8(%ebp),%esi
801034ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801034af:	89 34 24             	mov    %esi,(%esp)
801034b2:	e8 e9 0d 00 00       	call   801042a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034b7:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801034bd:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801034c3:	75 5b                	jne    80103520 <piperead+0x80>
801034c5:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801034cb:	85 db                	test   %ebx,%ebx
801034cd:	74 51                	je     80103520 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801034cf:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801034d5:	eb 25                	jmp    801034fc <piperead+0x5c>
801034d7:	90                   	nop
801034d8:	89 74 24 04          	mov    %esi,0x4(%esp)
801034dc:	89 1c 24             	mov    %ebx,(%esp)
801034df:	e8 dc 07 00 00       	call   80103cc0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034e4:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801034ea:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801034f0:	75 2e                	jne    80103520 <piperead+0x80>
801034f2:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801034f8:	85 d2                	test   %edx,%edx
801034fa:	74 24                	je     80103520 <piperead+0x80>
    if(myproc()->killed){
801034fc:	e8 5f 02 00 00       	call   80103760 <myproc>
80103501:	8b 48 24             	mov    0x24(%eax),%ecx
80103504:	85 c9                	test   %ecx,%ecx
80103506:	74 d0                	je     801034d8 <piperead+0x38>
      release(&p->lock);
80103508:	89 34 24             	mov    %esi,(%esp)
8010350b:	e8 00 0e 00 00       	call   80104310 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103510:	83 c4 1c             	add    $0x1c,%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103518:	5b                   	pop    %ebx
80103519:	5e                   	pop    %esi
8010351a:	5f                   	pop    %edi
8010351b:	5d                   	pop    %ebp
8010351c:	c3                   	ret    
8010351d:	8d 76 00             	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103520:	8b 55 10             	mov    0x10(%ebp),%edx
    if(p->nread == p->nwrite)
80103523:	31 db                	xor    %ebx,%ebx
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103525:	85 d2                	test   %edx,%edx
80103527:	7f 2b                	jg     80103554 <piperead+0xb4>
80103529:	eb 31                	jmp    8010355c <piperead+0xbc>
8010352b:	90                   	nop
8010352c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103530:	8d 48 01             	lea    0x1(%eax),%ecx
80103533:	25 ff 01 00 00       	and    $0x1ff,%eax
80103538:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010353e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103543:	88 04 1f             	mov    %al,(%edi,%ebx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103546:	83 c3 01             	add    $0x1,%ebx
80103549:	3b 5d 10             	cmp    0x10(%ebp),%ebx
8010354c:	74 0e                	je     8010355c <piperead+0xbc>
    if(p->nread == p->nwrite)
8010354e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103554:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010355a:	75 d4                	jne    80103530 <piperead+0x90>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010355c:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103562:	89 04 24             	mov    %eax,(%esp)
80103565:	e8 e6 08 00 00       	call   80103e50 <wakeup>
  release(&p->lock);
8010356a:	89 34 24             	mov    %esi,(%esp)
8010356d:	e8 9e 0d 00 00       	call   80104310 <release>
  return i;
}
80103572:	83 c4 1c             	add    $0x1c,%esp
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
80103575:	89 d8                	mov    %ebx,%eax
}
80103577:	5b                   	pop    %ebx
80103578:	5e                   	pop    %esi
80103579:	5f                   	pop    %edi
8010357a:	5d                   	pop    %ebp
8010357b:	c3                   	ret    
8010357c:	66 90                	xchg   %ax,%ax
8010357e:	66 90                	xchg   %ax,%ax

80103580 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103584:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103589:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010358c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103593:	e8 08 0d 00 00       	call   801042a0 <acquire>
80103598:	eb 11                	jmp    801035ab <allocproc+0x2b>
8010359a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035a0:	83 c3 7c             	add    $0x7c,%ebx
801035a3:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
801035a9:	74 7d                	je     80103628 <allocproc+0xa8>
    if(p->state == UNUSED)
801035ab:	8b 43 0c             	mov    0xc(%ebx),%eax
801035ae:	85 c0                	test   %eax,%eax
801035b0:	75 ee                	jne    801035a0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035b2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801035b7:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801035be:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801035c5:	8d 50 01             	lea    0x1(%eax),%edx
801035c8:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
801035ce:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801035d1:	e8 3a 0d 00 00       	call   80104310 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801035d6:	e8 95 ef ff ff       	call   80102570 <kalloc>
801035db:	85 c0                	test   %eax,%eax
801035dd:	89 43 08             	mov    %eax,0x8(%ebx)
801035e0:	74 5a                	je     8010363c <allocproc+0xbc>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801035e2:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
801035e8:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801035ed:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801035f0:	c7 40 14 95 54 10 80 	movl   $0x80105495,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801035f7:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
801035fe:	00 
801035ff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103606:	00 
80103607:	89 04 24             	mov    %eax,(%esp)
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
8010360a:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010360d:	e8 4e 0d 00 00       	call   80104360 <memset>
  p->context->eip = (uint)forkret;
80103612:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103615:	c7 40 10 50 36 10 80 	movl   $0x80103650,0x10(%eax)

  return p;
8010361c:	89 d8                	mov    %ebx,%eax
}
8010361e:	83 c4 14             	add    $0x14,%esp
80103621:	5b                   	pop    %ebx
80103622:	5d                   	pop    %ebp
80103623:	c3                   	ret    
80103624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103628:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010362f:	e8 dc 0c 00 00       	call   80104310 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103634:	83 c4 14             	add    $0x14,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;
80103637:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103639:	5b                   	pop    %ebx
8010363a:	5d                   	pop    %ebp
8010363b:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
8010363c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103643:	eb d9                	jmp    8010361e <allocproc+0x9e>
80103645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103650 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103656:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010365d:	e8 ae 0c 00 00       	call   80104310 <release>

  if (first) {
80103662:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103667:	85 c0                	test   %eax,%eax
80103669:	75 05                	jne    80103670 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010366b:	c9                   	leave  
8010366c:	c3                   	ret    
8010366d:	8d 76 00             	lea    0x0(%esi),%esi
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103670:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103677:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010367e:	00 00 00 
    iinit(ROOTDEV);
80103681:	e8 ba de ff ff       	call   80101540 <iinit>
    initlog(ROOTDEV);
80103686:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010368d:	e8 9e f4 ff ff       	call   80102b30 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103692:	c9                   	leave  
80103693:	c3                   	ret    
80103694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010369a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036a0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801036a6:	c7 44 24 04 f5 71 10 	movl   $0x801071f5,0x4(%esp)
801036ad:	80 
801036ae:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801036b5:	e8 76 0a 00 00       	call   80104130 <initlock>
}
801036ba:	c9                   	leave  
801036bb:	c3                   	ret    
801036bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036c0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	56                   	push   %esi
801036c4:	53                   	push   %ebx
801036c5:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801036c8:	9c                   	pushf  
801036c9:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801036ca:	f6 c4 02             	test   $0x2,%ah
801036cd:	75 57                	jne    80103726 <mycpu+0x66>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801036cf:	e8 4c f1 ff ff       	call   80102820 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801036d4:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
801036da:	85 f6                	test   %esi,%esi
801036dc:	7e 3c                	jle    8010371a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801036de:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
801036e5:	39 c2                	cmp    %eax,%edx
801036e7:	74 2d                	je     80103716 <mycpu+0x56>
801036e9:	b9 50 28 11 80       	mov    $0x80112850,%ecx
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801036ee:	31 d2                	xor    %edx,%edx
801036f0:	83 c2 01             	add    $0x1,%edx
801036f3:	39 f2                	cmp    %esi,%edx
801036f5:	74 23                	je     8010371a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801036f7:	0f b6 19             	movzbl (%ecx),%ebx
801036fa:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103700:	39 c3                	cmp    %eax,%ebx
80103702:	75 ec                	jne    801036f0 <mycpu+0x30>
      return &cpus[i];
80103704:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010370a:	83 c4 10             	add    $0x10,%esp
8010370d:	5b                   	pop    %ebx
8010370e:	5e                   	pop    %esi
8010370f:	5d                   	pop    %ebp
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
80103710:	05 a0 27 11 80       	add    $0x801127a0,%eax
  }
  panic("unknown apicid\n");
}
80103715:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103716:	31 d2                	xor    %edx,%edx
80103718:	eb ea                	jmp    80103704 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010371a:	c7 04 24 fc 71 10 80 	movl   $0x801071fc,(%esp)
80103721:	e8 3a cc ff ff       	call   80100360 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103726:	c7 04 24 d8 72 10 80 	movl   $0x801072d8,(%esp)
8010372d:	e8 2e cc ff ff       	call   80100360 <panic>
80103732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103740 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103746:	e8 75 ff ff ff       	call   801036c0 <mycpu>
}
8010374b:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
8010374c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103751:	c1 f8 04             	sar    $0x4,%eax
80103754:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010375a:	c3                   	ret    
8010375b:	90                   	nop
8010375c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103760 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	53                   	push   %ebx
80103764:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103767:	e8 44 0a 00 00       	call   801041b0 <pushcli>
  c = mycpu();
8010376c:	e8 4f ff ff ff       	call   801036c0 <mycpu>
  p = c->proc;
80103771:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103777:	e8 74 0a 00 00       	call   801041f0 <popcli>
  return p;
}
8010377c:	83 c4 04             	add    $0x4,%esp
8010377f:	89 d8                	mov    %ebx,%eax
80103781:	5b                   	pop    %ebx
80103782:	5d                   	pop    %ebp
80103783:	c3                   	ret    
80103784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010378a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103790 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	53                   	push   %ebx
80103794:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103797:	e8 e4 fd ff ff       	call   80103580 <allocproc>
8010379c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010379e:	a3 d8 a5 10 80       	mov    %eax,0x8010a5d8
  if((p->pgdir = setupkvm()) == 0)
801037a3:	e8 48 32 00 00       	call   801069f0 <setupkvm>
801037a8:	85 c0                	test   %eax,%eax
801037aa:	89 43 04             	mov    %eax,0x4(%ebx)
801037ad:	0f 84 d4 00 00 00    	je     80103887 <userinit+0xf7>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801037b3:	89 04 24             	mov    %eax,(%esp)
801037b6:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
801037bd:	00 
801037be:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
801037c5:	80 
801037c6:	e8 55 2f 00 00       	call   80106720 <inituvm>
  p->sz = PGSIZE;
801037cb:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801037d1:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801037d8:	00 
801037d9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801037e0:	00 
801037e1:	8b 43 18             	mov    0x18(%ebx),%eax
801037e4:	89 04 24             	mov    %eax,(%esp)
801037e7:	e8 74 0b 00 00       	call   80104360 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801037ec:	8b 43 18             	mov    0x18(%ebx),%eax
801037ef:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801037f4:	b9 23 00 00 00       	mov    $0x23,%ecx
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801037f9:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801037fd:	8b 43 18             	mov    0x18(%ebx),%eax
80103800:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103804:	8b 43 18             	mov    0x18(%ebx),%eax
80103807:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010380b:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010380f:	8b 43 18             	mov    0x18(%ebx),%eax
80103812:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103816:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010381a:	8b 43 18             	mov    0x18(%ebx),%eax
8010381d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103824:	8b 43 18             	mov    0x18(%ebx),%eax
80103827:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010382e:	8b 43 18             	mov    0x18(%ebx),%eax
80103831:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103838:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010383b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103842:	00 
80103843:	c7 44 24 04 25 72 10 	movl   $0x80107225,0x4(%esp)
8010384a:	80 
8010384b:	89 04 24             	mov    %eax,(%esp)
8010384e:	e8 ed 0c 00 00       	call   80104540 <safestrcpy>
  p->cwd = namei("/");
80103853:	c7 04 24 2e 72 10 80 	movl   $0x8010722e,(%esp)
8010385a:	e8 71 e7 ff ff       	call   80101fd0 <namei>
8010385f:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103862:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103869:	e8 32 0a 00 00       	call   801042a0 <acquire>

  p->state = RUNNABLE;
8010386e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103875:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010387c:	e8 8f 0a 00 00       	call   80104310 <release>
}
80103881:	83 c4 14             	add    $0x14,%esp
80103884:	5b                   	pop    %ebx
80103885:	5d                   	pop    %ebp
80103886:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103887:	c7 04 24 0c 72 10 80 	movl   $0x8010720c,(%esp)
8010388e:	e8 cd ca ff ff       	call   80100360 <panic>
80103893:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038a0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	56                   	push   %esi
801038a4:	53                   	push   %ebx
801038a5:	83 ec 10             	sub    $0x10,%esp
801038a8:	8b 75 08             	mov    0x8(%ebp),%esi
  uint sz;
  struct proc *curproc = myproc();
801038ab:	e8 b0 fe ff ff       	call   80103760 <myproc>

  sz = curproc->sz;
  if(n > 0){
801038b0:	83 fe 00             	cmp    $0x0,%esi
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();
801038b3:	89 c3                	mov    %eax,%ebx

  sz = curproc->sz;
801038b5:	8b 00                	mov    (%eax),%eax
  if(n > 0){
801038b7:	7e 2f                	jle    801038e8 <growproc+0x48>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801038b9:	01 c6                	add    %eax,%esi
801038bb:	89 74 24 08          	mov    %esi,0x8(%esp)
801038bf:	89 44 24 04          	mov    %eax,0x4(%esp)
801038c3:	8b 43 04             	mov    0x4(%ebx),%eax
801038c6:	89 04 24             	mov    %eax,(%esp)
801038c9:	e8 92 2f 00 00       	call   80106860 <allocuvm>
801038ce:	85 c0                	test   %eax,%eax
801038d0:	74 36                	je     80103908 <growproc+0x68>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801038d2:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801038d4:	89 1c 24             	mov    %ebx,(%esp)
801038d7:	e8 34 2d 00 00       	call   80106610 <switchuvm>
  return 0;
801038dc:	31 c0                	xor    %eax,%eax
}
801038de:	83 c4 10             	add    $0x10,%esp
801038e1:	5b                   	pop    %ebx
801038e2:	5e                   	pop    %esi
801038e3:	5d                   	pop    %ebp
801038e4:	c3                   	ret    
801038e5:	8d 76 00             	lea    0x0(%esi),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
801038e8:	74 e8                	je     801038d2 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801038ea:	01 c6                	add    %eax,%esi
801038ec:	89 74 24 08          	mov    %esi,0x8(%esp)
801038f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801038f4:	8b 43 04             	mov    0x4(%ebx),%eax
801038f7:	89 04 24             	mov    %eax,(%esp)
801038fa:	e8 51 30 00 00       	call   80106950 <deallocuvm>
801038ff:	85 c0                	test   %eax,%eax
80103901:	75 cf                	jne    801038d2 <growproc+0x32>
80103903:	90                   	nop
80103904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103908:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010390d:	eb cf                	jmp    801038de <growproc+0x3e>
8010390f:	90                   	nop

80103910 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	57                   	push   %edi
80103914:	56                   	push   %esi
80103915:	53                   	push   %ebx
80103916:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
80103919:	e8 42 fe ff ff       	call   80103760 <myproc>
8010391e:	89 c3                	mov    %eax,%ebx

  // Allocate process.
  if((np = allocproc()) == 0){
80103920:	e8 5b fc ff ff       	call   80103580 <allocproc>
80103925:	85 c0                	test   %eax,%eax
80103927:	89 c7                	mov    %eax,%edi
80103929:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010392c:	0f 84 bc 00 00 00    	je     801039ee <fork+0xde>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103932:	8b 03                	mov    (%ebx),%eax
80103934:	89 44 24 04          	mov    %eax,0x4(%esp)
80103938:	8b 43 04             	mov    0x4(%ebx),%eax
8010393b:	89 04 24             	mov    %eax,(%esp)
8010393e:	e8 8d 31 00 00       	call   80106ad0 <copyuvm>
80103943:	85 c0                	test   %eax,%eax
80103945:	89 47 04             	mov    %eax,0x4(%edi)
80103948:	0f 84 a7 00 00 00    	je     801039f5 <fork+0xe5>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
8010394e:	8b 03                	mov    (%ebx),%eax
80103950:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103953:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
  *np->tf = *curproc->tf;
80103955:	8b 79 18             	mov    0x18(%ecx),%edi
80103958:	89 c8                	mov    %ecx,%eax
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
8010395a:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010395d:	8b 73 18             	mov    0x18(%ebx),%esi
80103960:	b9 13 00 00 00       	mov    $0x13,%ecx
80103965:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103967:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103969:	8b 40 18             	mov    0x18(%eax),%eax
8010396c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103973:	90                   	nop
80103974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103978:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010397c:	85 c0                	test   %eax,%eax
8010397e:	74 0f                	je     8010398f <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103980:	89 04 24             	mov    %eax,(%esp)
80103983:	e8 18 d5 ff ff       	call   80100ea0 <filedup>
80103988:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010398b:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
8010398f:	83 c6 01             	add    $0x1,%esi
80103992:	83 fe 10             	cmp    $0x10,%esi
80103995:	75 e1                	jne    80103978 <fork+0x68>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103997:	8b 43 68             	mov    0x68(%ebx),%eax

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010399a:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
8010399d:	89 04 24             	mov    %eax,(%esp)
801039a0:	e8 ab dd ff ff       	call   80101750 <idup>
801039a5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801039a8:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039ab:	8d 47 6c             	lea    0x6c(%edi),%eax
801039ae:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801039b2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801039b9:	00 
801039ba:	89 04 24             	mov    %eax,(%esp)
801039bd:	e8 7e 0b 00 00       	call   80104540 <safestrcpy>

  pid = np->pid;
801039c2:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801039c5:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801039cc:	e8 cf 08 00 00       	call   801042a0 <acquire>

  np->state = RUNNABLE;
801039d1:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801039d8:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801039df:	e8 2c 09 00 00       	call   80104310 <release>

  return pid;
801039e4:	89 d8                	mov    %ebx,%eax
}
801039e6:	83 c4 1c             	add    $0x1c,%esp
801039e9:	5b                   	pop    %ebx
801039ea:	5e                   	pop    %esi
801039eb:	5f                   	pop    %edi
801039ec:	5d                   	pop    %ebp
801039ed:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
801039ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039f3:	eb f1                	jmp    801039e6 <fork+0xd6>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
801039f5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801039f8:	8b 47 08             	mov    0x8(%edi),%eax
801039fb:	89 04 24             	mov    %eax,(%esp)
801039fe:	e8 bd e9 ff ff       	call   801023c0 <kfree>
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
80103a03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
80103a08:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103a0f:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103a16:	eb ce                	jmp    801039e6 <fork+0xd6>
80103a18:	90                   	nop
80103a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a20 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	57                   	push   %edi
80103a24:	56                   	push   %esi
80103a25:	53                   	push   %ebx
80103a26:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103a29:	e8 92 fc ff ff       	call   801036c0 <mycpu>
80103a2e:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103a30:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103a37:	00 00 00 
80103a3a:	8d 78 04             	lea    0x4(%eax),%edi
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103a40:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a41:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a48:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a4d:	e8 4e 08 00 00       	call   801042a0 <acquire>
80103a52:	eb 0f                	jmp    80103a63 <scheduler+0x43>
80103a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a58:	83 c3 7c             	add    $0x7c,%ebx
80103a5b:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103a61:	74 45                	je     80103aa8 <scheduler+0x88>
      if(p->state != RUNNABLE)
80103a63:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103a67:	75 ef                	jne    80103a58 <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103a69:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103a6f:	89 1c 24             	mov    %ebx,(%esp)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a72:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103a75:	e8 96 2b 00 00       	call   80106610 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103a7a:	8b 43 a0             	mov    -0x60(%ebx),%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103a7d:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103a84:	89 3c 24             	mov    %edi,(%esp)
80103a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a8b:	e8 0b 0b 00 00       	call   8010459b <swtch>
      switchkvm();
80103a90:	e8 5b 2b 00 00       	call   801065f0 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a95:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103a9b:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103aa2:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103aa5:	75 bc                	jne    80103a63 <scheduler+0x43>
80103aa7:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103aa8:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103aaf:	e8 5c 08 00 00       	call   80104310 <release>

  }
80103ab4:	eb 8a                	jmp    80103a40 <scheduler+0x20>
80103ab6:	8d 76 00             	lea    0x0(%esi),%esi
80103ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ac0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	56                   	push   %esi
80103ac4:	53                   	push   %ebx
80103ac5:	83 ec 10             	sub    $0x10,%esp
  int intena;
  struct proc *p = myproc();
80103ac8:	e8 93 fc ff ff       	call   80103760 <myproc>

  if(!holding(&ptable.lock))
80103acd:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();
80103ad4:	89 c3                	mov    %eax,%ebx

  if(!holding(&ptable.lock))
80103ad6:	e8 85 07 00 00       	call   80104260 <holding>
80103adb:	85 c0                	test   %eax,%eax
80103add:	74 4f                	je     80103b2e <sched+0x6e>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103adf:	e8 dc fb ff ff       	call   801036c0 <mycpu>
80103ae4:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103aeb:	75 65                	jne    80103b52 <sched+0x92>
    panic("sched locks");
  if(p->state == RUNNING)
80103aed:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103af1:	74 53                	je     80103b46 <sched+0x86>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103af3:	9c                   	pushf  
80103af4:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103af5:	f6 c4 02             	test   $0x2,%ah
80103af8:	75 40                	jne    80103b3a <sched+0x7a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103afa:	e8 c1 fb ff ff       	call   801036c0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103aff:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b02:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b08:	e8 b3 fb ff ff       	call   801036c0 <mycpu>
80103b0d:	8b 40 04             	mov    0x4(%eax),%eax
80103b10:	89 1c 24             	mov    %ebx,(%esp)
80103b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b17:	e8 7f 0a 00 00       	call   8010459b <swtch>
  mycpu()->intena = intena;
80103b1c:	e8 9f fb ff ff       	call   801036c0 <mycpu>
80103b21:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103b27:	83 c4 10             	add    $0x10,%esp
80103b2a:	5b                   	pop    %ebx
80103b2b:	5e                   	pop    %esi
80103b2c:	5d                   	pop    %ebp
80103b2d:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103b2e:	c7 04 24 30 72 10 80 	movl   $0x80107230,(%esp)
80103b35:	e8 26 c8 ff ff       	call   80100360 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103b3a:	c7 04 24 5c 72 10 80 	movl   $0x8010725c,(%esp)
80103b41:	e8 1a c8 ff ff       	call   80100360 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103b46:	c7 04 24 4e 72 10 80 	movl   $0x8010724e,(%esp)
80103b4d:	e8 0e c8 ff ff       	call   80100360 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103b52:	c7 04 24 42 72 10 80 	movl   $0x80107242,(%esp)
80103b59:	e8 02 c8 ff ff       	call   80100360 <panic>
80103b5e:	66 90                	xchg   %ax,%ax

80103b60 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	56                   	push   %esi
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103b64:	31 f6                	xor    %esi,%esi
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103b66:	53                   	push   %ebx
80103b67:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103b6a:	e8 f1 fb ff ff       	call   80103760 <myproc>
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103b6f:	3b 05 d8 a5 10 80    	cmp    0x8010a5d8,%eax
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
80103b75:	89 c3                	mov    %eax,%ebx
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103b77:	0f 84 ea 00 00 00    	je     80103c67 <exit+0x107>
80103b7d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103b80:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b84:	85 c0                	test   %eax,%eax
80103b86:	74 10                	je     80103b98 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103b88:	89 04 24             	mov    %eax,(%esp)
80103b8b:	e8 60 d3 ff ff       	call   80100ef0 <fileclose>
      curproc->ofile[fd] = 0;
80103b90:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103b97:	00 

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103b98:	83 c6 01             	add    $0x1,%esi
80103b9b:	83 fe 10             	cmp    $0x10,%esi
80103b9e:	75 e0                	jne    80103b80 <exit+0x20>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103ba0:	e8 2b f0 ff ff       	call   80102bd0 <begin_op>
  iput(curproc->cwd);
80103ba5:	8b 43 68             	mov    0x68(%ebx),%eax
80103ba8:	89 04 24             	mov    %eax,(%esp)
80103bab:	e8 f0 dc ff ff       	call   801018a0 <iput>
  end_op();
80103bb0:	e8 8b f0 ff ff       	call   80102c40 <end_op>
  curproc->cwd = 0;
80103bb5:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)

  acquire(&ptable.lock);
80103bbc:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103bc3:	e8 d8 06 00 00       	call   801042a0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103bc8:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bcb:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103bd0:	eb 11                	jmp    80103be3 <exit+0x83>
80103bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bd8:	83 c2 7c             	add    $0x7c,%edx
80103bdb:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80103be1:	74 1d                	je     80103c00 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
80103be3:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103be7:	75 ef                	jne    80103bd8 <exit+0x78>
80103be9:	3b 42 20             	cmp    0x20(%edx),%eax
80103bec:	75 ea                	jne    80103bd8 <exit+0x78>
      p->state = RUNNABLE;
80103bee:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bf5:	83 c2 7c             	add    $0x7c,%edx
80103bf8:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80103bfe:	75 e3                	jne    80103be3 <exit+0x83>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103c00:	a1 d8 a5 10 80       	mov    0x8010a5d8,%eax
80103c05:	b9 74 2d 11 80       	mov    $0x80112d74,%ecx
80103c0a:	eb 0f                	jmp    80103c1b <exit+0xbb>
80103c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c10:	83 c1 7c             	add    $0x7c,%ecx
80103c13:	81 f9 74 4c 11 80    	cmp    $0x80114c74,%ecx
80103c19:	74 34                	je     80103c4f <exit+0xef>
    if(p->parent == curproc){
80103c1b:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103c1e:	75 f0                	jne    80103c10 <exit+0xb0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103c20:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103c24:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103c27:	75 e7                	jne    80103c10 <exit+0xb0>
80103c29:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103c2e:	eb 0b                	jmp    80103c3b <exit+0xdb>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c30:	83 c2 7c             	add    $0x7c,%edx
80103c33:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80103c39:	74 d5                	je     80103c10 <exit+0xb0>
    if(p->state == SLEEPING && p->chan == chan)
80103c3b:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c3f:	75 ef                	jne    80103c30 <exit+0xd0>
80103c41:	3b 42 20             	cmp    0x20(%edx),%eax
80103c44:	75 ea                	jne    80103c30 <exit+0xd0>
      p->state = RUNNABLE;
80103c46:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103c4d:	eb e1                	jmp    80103c30 <exit+0xd0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103c4f:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103c56:	e8 65 fe ff ff       	call   80103ac0 <sched>
  panic("zombie exit");
80103c5b:	c7 04 24 7d 72 10 80 	movl   $0x8010727d,(%esp)
80103c62:	e8 f9 c6 ff ff       	call   80100360 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103c67:	c7 04 24 70 72 10 80 	movl   $0x80107270,(%esp)
80103c6e:	e8 ed c6 ff ff       	call   80100360 <panic>
80103c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c80 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103c86:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103c8d:	e8 0e 06 00 00       	call   801042a0 <acquire>
  myproc()->state = RUNNABLE;
80103c92:	e8 c9 fa ff ff       	call   80103760 <myproc>
80103c97:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103c9e:	e8 1d fe ff ff       	call   80103ac0 <sched>
  release(&ptable.lock);
80103ca3:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103caa:	e8 61 06 00 00       	call   80104310 <release>
}
80103caf:	c9                   	leave  
80103cb0:	c3                   	ret    
80103cb1:	eb 0d                	jmp    80103cc0 <sleep>
80103cb3:	90                   	nop
80103cb4:	90                   	nop
80103cb5:	90                   	nop
80103cb6:	90                   	nop
80103cb7:	90                   	nop
80103cb8:	90                   	nop
80103cb9:	90                   	nop
80103cba:	90                   	nop
80103cbb:	90                   	nop
80103cbc:	90                   	nop
80103cbd:	90                   	nop
80103cbe:	90                   	nop
80103cbf:	90                   	nop

80103cc0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	57                   	push   %edi
80103cc4:	56                   	push   %esi
80103cc5:	53                   	push   %ebx
80103cc6:	83 ec 1c             	sub    $0x1c,%esp
80103cc9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103ccc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103ccf:	e8 8c fa ff ff       	call   80103760 <myproc>
  
  if(p == 0)
80103cd4:	85 c0                	test   %eax,%eax
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
80103cd6:	89 c3                	mov    %eax,%ebx
  
  if(p == 0)
80103cd8:	0f 84 7c 00 00 00    	je     80103d5a <sleep+0x9a>
    panic("sleep");

  if(lk == 0)
80103cde:	85 f6                	test   %esi,%esi
80103ce0:	74 6c                	je     80103d4e <sleep+0x8e>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ce2:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80103ce8:	74 46                	je     80103d30 <sleep+0x70>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103cea:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103cf1:	e8 aa 05 00 00       	call   801042a0 <acquire>
    release(lk);
80103cf6:	89 34 24             	mov    %esi,(%esp)
80103cf9:	e8 12 06 00 00       	call   80104310 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103cfe:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103d01:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103d08:	e8 b3 fd ff ff       	call   80103ac0 <sched>

  // Tidy up.
  p->chan = 0;
80103d0d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103d14:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103d1b:	e8 f0 05 00 00       	call   80104310 <release>
    acquire(lk);
80103d20:	89 75 08             	mov    %esi,0x8(%ebp)
  }
}
80103d23:	83 c4 1c             	add    $0x1c,%esp
80103d26:	5b                   	pop    %ebx
80103d27:	5e                   	pop    %esi
80103d28:	5f                   	pop    %edi
80103d29:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103d2a:	e9 71 05 00 00       	jmp    801042a0 <acquire>
80103d2f:	90                   	nop
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103d30:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103d33:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
80103d3a:	e8 81 fd ff ff       	call   80103ac0 <sched>

  // Tidy up.
  p->chan = 0;
80103d3f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103d46:	83 c4 1c             	add    $0x1c,%esp
80103d49:	5b                   	pop    %ebx
80103d4a:	5e                   	pop    %esi
80103d4b:	5f                   	pop    %edi
80103d4c:	5d                   	pop    %ebp
80103d4d:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103d4e:	c7 04 24 8f 72 10 80 	movl   $0x8010728f,(%esp)
80103d55:	e8 06 c6 ff ff       	call   80100360 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103d5a:	c7 04 24 89 72 10 80 	movl   $0x80107289,(%esp)
80103d61:	e8 fa c5 ff ff       	call   80100360 <panic>
80103d66:	8d 76 00             	lea    0x0(%esi),%esi
80103d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d70 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	56                   	push   %esi
80103d74:	53                   	push   %ebx
80103d75:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103d78:	e8 e3 f9 ff ff       	call   80103760 <myproc>
  
  acquire(&ptable.lock);
80103d7d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103d84:	89 c6                	mov    %eax,%esi
  
  acquire(&ptable.lock);
80103d86:	e8 15 05 00 00       	call   801042a0 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103d8b:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d8d:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80103d92:	eb 0f                	jmp    80103da3 <wait+0x33>
80103d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d98:	83 c3 7c             	add    $0x7c,%ebx
80103d9b:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103da1:	74 1d                	je     80103dc0 <wait+0x50>
      if(p->parent != curproc)
80103da3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103da6:	75 f0                	jne    80103d98 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103da8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103dac:	74 2f                	je     80103ddd <wait+0x6d>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dae:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103db1:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103db6:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103dbc:	75 e5                	jne    80103da3 <wait+0x33>
80103dbe:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103dc0:	85 c0                	test   %eax,%eax
80103dc2:	74 6e                	je     80103e32 <wait+0xc2>
80103dc4:	8b 46 24             	mov    0x24(%esi),%eax
80103dc7:	85 c0                	test   %eax,%eax
80103dc9:	75 67                	jne    80103e32 <wait+0xc2>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103dcb:	c7 44 24 04 40 2d 11 	movl   $0x80112d40,0x4(%esp)
80103dd2:	80 
80103dd3:	89 34 24             	mov    %esi,(%esp)
80103dd6:	e8 e5 fe ff ff       	call   80103cc0 <sleep>
  }
80103ddb:	eb ae                	jmp    80103d8b <wait+0x1b>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103ddd:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103de0:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103de3:	89 04 24             	mov    %eax,(%esp)
80103de6:	e8 d5 e5 ff ff       	call   801023c0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103deb:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103dee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103df5:	89 04 24             	mov    %eax,(%esp)
80103df8:	e8 73 2b 00 00       	call   80106970 <freevm>
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
80103dfd:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103e04:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103e0b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103e12:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103e16:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103e1d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103e24:	e8 e7 04 00 00       	call   80104310 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e29:	83 c4 10             	add    $0x10,%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103e2c:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e2e:	5b                   	pop    %ebx
80103e2f:	5e                   	pop    %esi
80103e30:	5d                   	pop    %ebp
80103e31:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103e32:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103e39:	e8 d2 04 00 00       	call   80104310 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e3e:	83 c4 10             	add    $0x10,%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80103e41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e46:	5b                   	pop    %ebx
80103e47:	5e                   	pop    %esi
80103e48:	5d                   	pop    %ebp
80103e49:	c3                   	ret    
80103e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e50 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	53                   	push   %ebx
80103e54:	83 ec 14             	sub    $0x14,%esp
80103e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103e5a:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103e61:	e8 3a 04 00 00       	call   801042a0 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e66:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103e6b:	eb 0d                	jmp    80103e7a <wakeup+0x2a>
80103e6d:	8d 76 00             	lea    0x0(%esi),%esi
80103e70:	83 c0 7c             	add    $0x7c,%eax
80103e73:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103e78:	74 1e                	je     80103e98 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103e7a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e7e:	75 f0                	jne    80103e70 <wakeup+0x20>
80103e80:	3b 58 20             	cmp    0x20(%eax),%ebx
80103e83:	75 eb                	jne    80103e70 <wakeup+0x20>
      p->state = RUNNABLE;
80103e85:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e8c:	83 c0 7c             	add    $0x7c,%eax
80103e8f:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103e94:	75 e4                	jne    80103e7a <wakeup+0x2a>
80103e96:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103e98:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
80103e9f:	83 c4 14             	add    $0x14,%esp
80103ea2:	5b                   	pop    %ebx
80103ea3:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103ea4:	e9 67 04 00 00       	jmp    80104310 <release>
80103ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103eb0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	53                   	push   %ebx
80103eb4:	83 ec 14             	sub    $0x14,%esp
80103eb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103eba:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ec1:	e8 da 03 00 00       	call   801042a0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ec6:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103ecb:	eb 0d                	jmp    80103eda <kill+0x2a>
80103ecd:	8d 76 00             	lea    0x0(%esi),%esi
80103ed0:	83 c0 7c             	add    $0x7c,%eax
80103ed3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103ed8:	74 36                	je     80103f10 <kill+0x60>
    if(p->pid == pid){
80103eda:	39 58 10             	cmp    %ebx,0x10(%eax)
80103edd:	75 f1                	jne    80103ed0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103edf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80103ee3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103eea:	74 14                	je     80103f00 <kill+0x50>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103eec:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ef3:	e8 18 04 00 00       	call   80104310 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103ef8:	83 c4 14             	add    $0x14,%esp
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
80103efb:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103efd:	5b                   	pop    %ebx
80103efe:	5d                   	pop    %ebp
80103eff:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103f00:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f07:	eb e3                	jmp    80103eec <kill+0x3c>
80103f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103f10:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f17:	e8 f4 03 00 00       	call   80104310 <release>
  return -1;
}
80103f1c:	83 c4 14             	add    $0x14,%esp
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
80103f1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103f24:	5b                   	pop    %ebx
80103f25:	5d                   	pop    %ebp
80103f26:	c3                   	ret    
80103f27:	89 f6                	mov    %esi,%esi
80103f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f30 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	57                   	push   %edi
80103f34:	56                   	push   %esi
80103f35:	53                   	push   %ebx
80103f36:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80103f3b:	83 ec 4c             	sub    $0x4c,%esp
80103f3e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103f41:	eb 20                	jmp    80103f63 <procdump+0x33>
80103f43:	90                   	nop
80103f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103f48:	c7 04 24 17 76 10 80 	movl   $0x80107617,(%esp)
80103f4f:	e8 ac c7 ff ff       	call   80100700 <cprintf>
80103f54:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f57:	81 fb e0 4c 11 80    	cmp    $0x80114ce0,%ebx
80103f5d:	0f 84 8d 00 00 00    	je     80103ff0 <procdump+0xc0>
    if(p->state == UNUSED)
80103f63:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103f66:	85 c0                	test   %eax,%eax
80103f68:	74 ea                	je     80103f54 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103f6a:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80103f6d:	ba a0 72 10 80       	mov    $0x801072a0,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103f72:	77 11                	ja     80103f85 <procdump+0x55>
80103f74:	8b 14 85 00 73 10 80 	mov    -0x7fef8d00(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
80103f7b:	b8 a0 72 10 80       	mov    $0x801072a0,%eax
80103f80:	85 d2                	test   %edx,%edx
80103f82:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80103f85:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103f88:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103f8c:	89 54 24 08          	mov    %edx,0x8(%esp)
80103f90:	c7 04 24 a4 72 10 80 	movl   $0x801072a4,(%esp)
80103f97:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f9b:	e8 60 c7 ff ff       	call   80100700 <cprintf>
    if(p->state == SLEEPING){
80103fa0:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103fa4:	75 a2                	jne    80103f48 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103fa6:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103fa9:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fad:	8b 43 b0             	mov    -0x50(%ebx),%eax
80103fb0:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103fb3:	8b 40 0c             	mov    0xc(%eax),%eax
80103fb6:	83 c0 08             	add    $0x8,%eax
80103fb9:	89 04 24             	mov    %eax,(%esp)
80103fbc:	e8 8f 01 00 00       	call   80104150 <getcallerpcs>
80103fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80103fc8:	8b 17                	mov    (%edi),%edx
80103fca:	85 d2                	test   %edx,%edx
80103fcc:	0f 84 76 ff ff ff    	je     80103f48 <procdump+0x18>
        cprintf(" %p", pc[i]);
80103fd2:	89 54 24 04          	mov    %edx,0x4(%esp)
80103fd6:	83 c7 04             	add    $0x4,%edi
80103fd9:	c7 04 24 e1 6c 10 80 	movl   $0x80106ce1,(%esp)
80103fe0:	e8 1b c7 ff ff       	call   80100700 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80103fe5:	39 f7                	cmp    %esi,%edi
80103fe7:	75 df                	jne    80103fc8 <procdump+0x98>
80103fe9:	e9 5a ff ff ff       	jmp    80103f48 <procdump+0x18>
80103fee:	66 90                	xchg   %ax,%ax
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80103ff0:	83 c4 4c             	add    $0x4c,%esp
80103ff3:	5b                   	pop    %ebx
80103ff4:	5e                   	pop    %esi
80103ff5:	5f                   	pop    %edi
80103ff6:	5d                   	pop    %ebp
80103ff7:	c3                   	ret    
80103ff8:	66 90                	xchg   %ax,%ax
80103ffa:	66 90                	xchg   %ax,%ax
80103ffc:	66 90                	xchg   %ax,%ax
80103ffe:	66 90                	xchg   %ax,%ax

80104000 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	53                   	push   %ebx
80104004:	83 ec 14             	sub    $0x14,%esp
80104007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010400a:	c7 44 24 04 18 73 10 	movl   $0x80107318,0x4(%esp)
80104011:	80 
80104012:	8d 43 04             	lea    0x4(%ebx),%eax
80104015:	89 04 24             	mov    %eax,(%esp)
80104018:	e8 13 01 00 00       	call   80104130 <initlock>
  lk->name = name;
8010401d:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104020:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104026:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010402d:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80104030:	83 c4 14             	add    $0x14,%esp
80104033:	5b                   	pop    %ebx
80104034:	5d                   	pop    %ebp
80104035:	c3                   	ret    
80104036:	8d 76 00             	lea    0x0(%esi),%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	56                   	push   %esi
80104044:	53                   	push   %ebx
80104045:	83 ec 10             	sub    $0x10,%esp
80104048:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010404b:	8d 73 04             	lea    0x4(%ebx),%esi
8010404e:	89 34 24             	mov    %esi,(%esp)
80104051:	e8 4a 02 00 00       	call   801042a0 <acquire>
  while (lk->locked) {
80104056:	8b 13                	mov    (%ebx),%edx
80104058:	85 d2                	test   %edx,%edx
8010405a:	74 16                	je     80104072 <acquiresleep+0x32>
8010405c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104060:	89 74 24 04          	mov    %esi,0x4(%esp)
80104064:	89 1c 24             	mov    %ebx,(%esp)
80104067:	e8 54 fc ff ff       	call   80103cc0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010406c:	8b 03                	mov    (%ebx),%eax
8010406e:	85 c0                	test   %eax,%eax
80104070:	75 ee                	jne    80104060 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104072:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104078:	e8 e3 f6 ff ff       	call   80103760 <myproc>
8010407d:	8b 40 10             	mov    0x10(%eax),%eax
80104080:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104083:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104086:	83 c4 10             	add    $0x10,%esp
80104089:	5b                   	pop    %ebx
8010408a:	5e                   	pop    %esi
8010408b:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010408c:	e9 7f 02 00 00       	jmp    80104310 <release>
80104091:	eb 0d                	jmp    801040a0 <releasesleep>
80104093:	90                   	nop
80104094:	90                   	nop
80104095:	90                   	nop
80104096:	90                   	nop
80104097:	90                   	nop
80104098:	90                   	nop
80104099:	90                   	nop
8010409a:	90                   	nop
8010409b:	90                   	nop
8010409c:	90                   	nop
8010409d:	90                   	nop
8010409e:	90                   	nop
8010409f:	90                   	nop

801040a0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	56                   	push   %esi
801040a4:	53                   	push   %ebx
801040a5:	83 ec 10             	sub    $0x10,%esp
801040a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801040ab:	8d 73 04             	lea    0x4(%ebx),%esi
801040ae:	89 34 24             	mov    %esi,(%esp)
801040b1:	e8 ea 01 00 00       	call   801042a0 <acquire>
  lk->locked = 0;
801040b6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801040bc:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801040c3:	89 1c 24             	mov    %ebx,(%esp)
801040c6:	e8 85 fd ff ff       	call   80103e50 <wakeup>
  release(&lk->lk);
801040cb:	89 75 08             	mov    %esi,0x8(%ebp)
}
801040ce:	83 c4 10             	add    $0x10,%esp
801040d1:	5b                   	pop    %ebx
801040d2:	5e                   	pop    %esi
801040d3:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801040d4:	e9 37 02 00 00       	jmp    80104310 <release>
801040d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040e0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	57                   	push   %edi
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
801040e4:	31 ff                	xor    %edi,%edi
  release(&lk->lk);
}

int
holdingsleep(struct sleeplock *lk)
{
801040e6:	56                   	push   %esi
801040e7:	53                   	push   %ebx
801040e8:	83 ec 1c             	sub    $0x1c,%esp
801040eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801040ee:	8d 73 04             	lea    0x4(%ebx),%esi
801040f1:	89 34 24             	mov    %esi,(%esp)
801040f4:	e8 a7 01 00 00       	call   801042a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801040f9:	8b 03                	mov    (%ebx),%eax
801040fb:	85 c0                	test   %eax,%eax
801040fd:	74 13                	je     80104112 <holdingsleep+0x32>
801040ff:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104102:	e8 59 f6 ff ff       	call   80103760 <myproc>
80104107:	3b 58 10             	cmp    0x10(%eax),%ebx
8010410a:	0f 94 c0             	sete   %al
8010410d:	0f b6 c0             	movzbl %al,%eax
80104110:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104112:	89 34 24             	mov    %esi,(%esp)
80104115:	e8 f6 01 00 00       	call   80104310 <release>
  return r;
}
8010411a:	83 c4 1c             	add    $0x1c,%esp
8010411d:	89 f8                	mov    %edi,%eax
8010411f:	5b                   	pop    %ebx
80104120:	5e                   	pop    %esi
80104121:	5f                   	pop    %edi
80104122:	5d                   	pop    %ebp
80104123:	c3                   	ret    
80104124:	66 90                	xchg   %ax,%ax
80104126:	66 90                	xchg   %ax,%ax
80104128:	66 90                	xchg   %ax,%ax
8010412a:	66 90                	xchg   %ax,%ax
8010412c:	66 90                	xchg   %ax,%ax
8010412e:	66 90                	xchg   %ax,%ax

80104130 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104136:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104139:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010413f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104142:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104149:	5d                   	pop    %ebp
8010414a:	c3                   	ret    
8010414b:	90                   	nop
8010414c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104150 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104153:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104156:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104159:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010415a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010415d:	31 c0                	xor    %eax,%eax
8010415f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104160:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104166:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010416c:	77 1a                	ja     80104188 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010416e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104171:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104174:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104177:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104179:	83 f8 0a             	cmp    $0xa,%eax
8010417c:	75 e2                	jne    80104160 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010417e:	5b                   	pop    %ebx
8010417f:	5d                   	pop    %ebp
80104180:	c3                   	ret    
80104181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104188:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010418f:	83 c0 01             	add    $0x1,%eax
80104192:	83 f8 0a             	cmp    $0xa,%eax
80104195:	74 e7                	je     8010417e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104197:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010419e:	83 c0 01             	add    $0x1,%eax
801041a1:	83 f8 0a             	cmp    $0xa,%eax
801041a4:	75 e2                	jne    80104188 <getcallerpcs+0x38>
801041a6:	eb d6                	jmp    8010417e <getcallerpcs+0x2e>
801041a8:	90                   	nop
801041a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 04             	sub    $0x4,%esp
801041b7:	9c                   	pushf  
801041b8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801041b9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801041ba:	e8 01 f5 ff ff       	call   801036c0 <mycpu>
801041bf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801041c5:	85 c0                	test   %eax,%eax
801041c7:	75 11                	jne    801041da <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801041c9:	e8 f2 f4 ff ff       	call   801036c0 <mycpu>
801041ce:	81 e3 00 02 00 00    	and    $0x200,%ebx
801041d4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801041da:	e8 e1 f4 ff ff       	call   801036c0 <mycpu>
801041df:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801041e6:	83 c4 04             	add    $0x4,%esp
801041e9:	5b                   	pop    %ebx
801041ea:	5d                   	pop    %ebp
801041eb:	c3                   	ret    
801041ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801041f0 <popcli>:

void
popcli(void)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801041f6:	9c                   	pushf  
801041f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801041f8:	f6 c4 02             	test   $0x2,%ah
801041fb:	75 49                	jne    80104246 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801041fd:	e8 be f4 ff ff       	call   801036c0 <mycpu>
80104202:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104208:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010420b:	85 d2                	test   %edx,%edx
8010420d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104213:	78 25                	js     8010423a <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104215:	e8 a6 f4 ff ff       	call   801036c0 <mycpu>
8010421a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104220:	85 d2                	test   %edx,%edx
80104222:	74 04                	je     80104228 <popcli+0x38>
    sti();
}
80104224:	c9                   	leave  
80104225:	c3                   	ret    
80104226:	66 90                	xchg   %ax,%ax
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104228:	e8 93 f4 ff ff       	call   801036c0 <mycpu>
8010422d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104233:	85 c0                	test   %eax,%eax
80104235:	74 ed                	je     80104224 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104237:	fb                   	sti    
    sti();
}
80104238:	c9                   	leave  
80104239:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
8010423a:	c7 04 24 3a 73 10 80 	movl   $0x8010733a,(%esp)
80104241:	e8 1a c1 ff ff       	call   80100360 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104246:	c7 04 24 23 73 10 80 	movl   $0x80107323,(%esp)
8010424d:	e8 0e c1 ff ff       	call   80100360 <panic>
80104252:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104260 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	56                   	push   %esi
  int r;
  pushcli();
  r = lock->locked && lock->cpu == mycpu();
80104264:	31 f6                	xor    %esi,%esi
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104266:	53                   	push   %ebx
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  pushcli();
8010426a:	e8 41 ff ff ff       	call   801041b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010426f:	8b 03                	mov    (%ebx),%eax
80104271:	85 c0                	test   %eax,%eax
80104273:	74 12                	je     80104287 <holding+0x27>
80104275:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104278:	e8 43 f4 ff ff       	call   801036c0 <mycpu>
8010427d:	39 c3                	cmp    %eax,%ebx
8010427f:	0f 94 c0             	sete   %al
80104282:	0f b6 c0             	movzbl %al,%eax
80104285:	89 c6                	mov    %eax,%esi
  popcli();
80104287:	e8 64 ff ff ff       	call   801041f0 <popcli>
  return r;
}
8010428c:	89 f0                	mov    %esi,%eax
8010428e:	5b                   	pop    %ebx
8010428f:	5e                   	pop    %esi
80104290:	5d                   	pop    %ebp
80104291:	c3                   	ret    
80104292:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042a0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801042a7:	e8 04 ff ff ff       	call   801041b0 <pushcli>
  if(holding(lk))
801042ac:	8b 45 08             	mov    0x8(%ebp),%eax
801042af:	89 04 24             	mov    %eax,(%esp)
801042b2:	e8 a9 ff ff ff       	call   80104260 <holding>
801042b7:	85 c0                	test   %eax,%eax
801042b9:	75 3c                	jne    801042f7 <acquire+0x57>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801042bb:	b9 01 00 00 00       	mov    $0x1,%ecx
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801042c0:	8b 55 08             	mov    0x8(%ebp),%edx
801042c3:	89 c8                	mov    %ecx,%eax
801042c5:	f0 87 02             	lock xchg %eax,(%edx)
801042c8:	85 c0                	test   %eax,%eax
801042ca:	75 f4                	jne    801042c0 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801042cc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801042d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042d4:	e8 e7 f3 ff ff       	call   801036c0 <mycpu>
801042d9:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
801042dc:	8b 45 08             	mov    0x8(%ebp),%eax
801042df:	83 c0 0c             	add    $0xc,%eax
801042e2:	89 44 24 04          	mov    %eax,0x4(%esp)
801042e6:	8d 45 08             	lea    0x8(%ebp),%eax
801042e9:	89 04 24             	mov    %eax,(%esp)
801042ec:	e8 5f fe ff ff       	call   80104150 <getcallerpcs>
}
801042f1:	83 c4 14             	add    $0x14,%esp
801042f4:	5b                   	pop    %ebx
801042f5:	5d                   	pop    %ebp
801042f6:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801042f7:	c7 04 24 41 73 10 80 	movl   $0x80107341,(%esp)
801042fe:	e8 5d c0 ff ff       	call   80100360 <panic>
80104303:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104310 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	53                   	push   %ebx
80104314:	83 ec 14             	sub    $0x14,%esp
80104317:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010431a:	89 1c 24             	mov    %ebx,(%esp)
8010431d:	e8 3e ff ff ff       	call   80104260 <holding>
80104322:	85 c0                	test   %eax,%eax
80104324:	74 23                	je     80104349 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80104326:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010432d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104334:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104339:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
8010433f:	83 c4 14             	add    $0x14,%esp
80104342:	5b                   	pop    %ebx
80104343:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104344:	e9 a7 fe ff ff       	jmp    801041f0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104349:	c7 04 24 49 73 10 80 	movl   $0x80107349,(%esp)
80104350:	e8 0b c0 ff ff       	call   80100360 <panic>
80104355:	66 90                	xchg   %ax,%ax
80104357:	66 90                	xchg   %ax,%ax
80104359:	66 90                	xchg   %ax,%ax
8010435b:	66 90                	xchg   %ax,%ax
8010435d:	66 90                	xchg   %ax,%ax
8010435f:	90                   	nop

80104360 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	8b 55 08             	mov    0x8(%ebp),%edx
80104366:	57                   	push   %edi
80104367:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010436a:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
8010436b:	f6 c2 03             	test   $0x3,%dl
8010436e:	75 05                	jne    80104375 <memset+0x15>
80104370:	f6 c1 03             	test   $0x3,%cl
80104373:	74 13                	je     80104388 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104375:	89 d7                	mov    %edx,%edi
80104377:	8b 45 0c             	mov    0xc(%ebp),%eax
8010437a:	fc                   	cld    
8010437b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010437d:	5b                   	pop    %ebx
8010437e:	89 d0                	mov    %edx,%eax
80104380:	5f                   	pop    %edi
80104381:	5d                   	pop    %ebp
80104382:	c3                   	ret    
80104383:	90                   	nop
80104384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104388:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010438c:	c1 e9 02             	shr    $0x2,%ecx
8010438f:	89 f8                	mov    %edi,%eax
80104391:	89 fb                	mov    %edi,%ebx
80104393:	c1 e0 18             	shl    $0x18,%eax
80104396:	c1 e3 10             	shl    $0x10,%ebx
80104399:	09 d8                	or     %ebx,%eax
8010439b:	09 f8                	or     %edi,%eax
8010439d:	c1 e7 08             	shl    $0x8,%edi
801043a0:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801043a2:	89 d7                	mov    %edx,%edi
801043a4:	fc                   	cld    
801043a5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801043a7:	5b                   	pop    %ebx
801043a8:	89 d0                	mov    %edx,%eax
801043aa:	5f                   	pop    %edi
801043ab:	5d                   	pop    %ebp
801043ac:	c3                   	ret    
801043ad:	8d 76 00             	lea    0x0(%esi),%esi

801043b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	8b 45 10             	mov    0x10(%ebp),%eax
801043b6:	57                   	push   %edi
801043b7:	56                   	push   %esi
801043b8:	8b 75 0c             	mov    0xc(%ebp),%esi
801043bb:	53                   	push   %ebx
801043bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801043bf:	85 c0                	test   %eax,%eax
801043c1:	8d 78 ff             	lea    -0x1(%eax),%edi
801043c4:	74 26                	je     801043ec <memcmp+0x3c>
    if(*s1 != *s2)
801043c6:	0f b6 03             	movzbl (%ebx),%eax
801043c9:	31 d2                	xor    %edx,%edx
801043cb:	0f b6 0e             	movzbl (%esi),%ecx
801043ce:	38 c8                	cmp    %cl,%al
801043d0:	74 16                	je     801043e8 <memcmp+0x38>
801043d2:	eb 24                	jmp    801043f8 <memcmp+0x48>
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043d8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
801043dd:	83 c2 01             	add    $0x1,%edx
801043e0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801043e4:	38 c8                	cmp    %cl,%al
801043e6:	75 10                	jne    801043f8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801043e8:	39 fa                	cmp    %edi,%edx
801043ea:	75 ec                	jne    801043d8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801043ec:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
801043ed:	31 c0                	xor    %eax,%eax
}
801043ef:	5e                   	pop    %esi
801043f0:	5f                   	pop    %edi
801043f1:	5d                   	pop    %ebp
801043f2:	c3                   	ret    
801043f3:	90                   	nop
801043f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043f8:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801043f9:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801043fb:	5e                   	pop    %esi
801043fc:	5f                   	pop    %edi
801043fd:	5d                   	pop    %ebp
801043fe:	c3                   	ret    
801043ff:	90                   	nop

80104400 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	57                   	push   %edi
80104404:	8b 45 08             	mov    0x8(%ebp),%eax
80104407:	56                   	push   %esi
80104408:	8b 75 0c             	mov    0xc(%ebp),%esi
8010440b:	53                   	push   %ebx
8010440c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010440f:	39 c6                	cmp    %eax,%esi
80104411:	73 35                	jae    80104448 <memmove+0x48>
80104413:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104416:	39 c8                	cmp    %ecx,%eax
80104418:	73 2e                	jae    80104448 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
8010441a:	85 db                	test   %ebx,%ebx

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
8010441c:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
    while(n-- > 0)
8010441f:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104422:	74 1b                	je     8010443f <memmove+0x3f>
80104424:	f7 db                	neg    %ebx
80104426:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80104429:	01 fb                	add    %edi,%ebx
8010442b:	90                   	nop
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104430:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104434:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104437:	83 ea 01             	sub    $0x1,%edx
8010443a:	83 fa ff             	cmp    $0xffffffff,%edx
8010443d:	75 f1                	jne    80104430 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010443f:	5b                   	pop    %ebx
80104440:	5e                   	pop    %esi
80104441:	5f                   	pop    %edi
80104442:	5d                   	pop    %ebp
80104443:	c3                   	ret    
80104444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104448:	31 d2                	xor    %edx,%edx
8010444a:	85 db                	test   %ebx,%ebx
8010444c:	74 f1                	je     8010443f <memmove+0x3f>
8010444e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104450:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104454:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104457:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010445a:	39 da                	cmp    %ebx,%edx
8010445c:	75 f2                	jne    80104450 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010445e:	5b                   	pop    %ebx
8010445f:	5e                   	pop    %esi
80104460:	5f                   	pop    %edi
80104461:	5d                   	pop    %ebp
80104462:	c3                   	ret    
80104463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104470 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104473:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104474:	e9 87 ff ff ff       	jmp    80104400 <memmove>
80104479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104480 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	56                   	push   %esi
80104484:	8b 75 10             	mov    0x10(%ebp),%esi
80104487:	53                   	push   %ebx
80104488:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010448b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010448e:	85 f6                	test   %esi,%esi
80104490:	74 30                	je     801044c2 <strncmp+0x42>
80104492:	0f b6 01             	movzbl (%ecx),%eax
80104495:	84 c0                	test   %al,%al
80104497:	74 2f                	je     801044c8 <strncmp+0x48>
80104499:	0f b6 13             	movzbl (%ebx),%edx
8010449c:	38 d0                	cmp    %dl,%al
8010449e:	75 46                	jne    801044e6 <strncmp+0x66>
801044a0:	8d 51 01             	lea    0x1(%ecx),%edx
801044a3:	01 ce                	add    %ecx,%esi
801044a5:	eb 14                	jmp    801044bb <strncmp+0x3b>
801044a7:	90                   	nop
801044a8:	0f b6 02             	movzbl (%edx),%eax
801044ab:	84 c0                	test   %al,%al
801044ad:	74 31                	je     801044e0 <strncmp+0x60>
801044af:	0f b6 19             	movzbl (%ecx),%ebx
801044b2:	83 c2 01             	add    $0x1,%edx
801044b5:	38 d8                	cmp    %bl,%al
801044b7:	75 17                	jne    801044d0 <strncmp+0x50>
    n--, p++, q++;
801044b9:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801044bb:	39 f2                	cmp    %esi,%edx
    n--, p++, q++;
801044bd:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801044c0:	75 e6                	jne    801044a8 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801044c2:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
801044c3:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
801044c5:	5e                   	pop    %esi
801044c6:	5d                   	pop    %ebp
801044c7:	c3                   	ret    
801044c8:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801044cb:	31 c0                	xor    %eax,%eax
801044cd:	8d 76 00             	lea    0x0(%esi),%esi
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801044d0:	0f b6 d3             	movzbl %bl,%edx
801044d3:	29 d0                	sub    %edx,%eax
}
801044d5:	5b                   	pop    %ebx
801044d6:	5e                   	pop    %esi
801044d7:	5d                   	pop    %ebp
801044d8:	c3                   	ret    
801044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044e0:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
801044e4:	eb ea                	jmp    801044d0 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801044e6:	89 d3                	mov    %edx,%ebx
801044e8:	eb e6                	jmp    801044d0 <strncmp+0x50>
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044f0 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	8b 45 08             	mov    0x8(%ebp),%eax
801044f6:	56                   	push   %esi
801044f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801044fa:	53                   	push   %ebx
801044fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801044fe:	89 c2                	mov    %eax,%edx
80104500:	eb 19                	jmp    8010451b <strncpy+0x2b>
80104502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104508:	83 c3 01             	add    $0x1,%ebx
8010450b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010450f:	83 c2 01             	add    $0x1,%edx
80104512:	84 c9                	test   %cl,%cl
80104514:	88 4a ff             	mov    %cl,-0x1(%edx)
80104517:	74 09                	je     80104522 <strncpy+0x32>
80104519:	89 f1                	mov    %esi,%ecx
8010451b:	85 c9                	test   %ecx,%ecx
8010451d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104520:	7f e6                	jg     80104508 <strncpy+0x18>
    ;
  while(n-- > 0)
80104522:	31 c9                	xor    %ecx,%ecx
80104524:	85 f6                	test   %esi,%esi
80104526:	7e 0f                	jle    80104537 <strncpy+0x47>
    *s++ = 0;
80104528:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
8010452c:	89 f3                	mov    %esi,%ebx
8010452e:	83 c1 01             	add    $0x1,%ecx
80104531:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104533:	85 db                	test   %ebx,%ebx
80104535:	7f f1                	jg     80104528 <strncpy+0x38>
    *s++ = 0;
  return os;
}
80104537:	5b                   	pop    %ebx
80104538:	5e                   	pop    %esi
80104539:	5d                   	pop    %ebp
8010453a:	c3                   	ret    
8010453b:	90                   	nop
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104540 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104546:	56                   	push   %esi
80104547:	8b 45 08             	mov    0x8(%ebp),%eax
8010454a:	53                   	push   %ebx
8010454b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010454e:	85 c9                	test   %ecx,%ecx
80104550:	7e 26                	jle    80104578 <safestrcpy+0x38>
80104552:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104556:	89 c1                	mov    %eax,%ecx
80104558:	eb 17                	jmp    80104571 <safestrcpy+0x31>
8010455a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104560:	83 c2 01             	add    $0x1,%edx
80104563:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104567:	83 c1 01             	add    $0x1,%ecx
8010456a:	84 db                	test   %bl,%bl
8010456c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010456f:	74 04                	je     80104575 <safestrcpy+0x35>
80104571:	39 f2                	cmp    %esi,%edx
80104573:	75 eb                	jne    80104560 <safestrcpy+0x20>
    ;
  *s = 0;
80104575:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104578:	5b                   	pop    %ebx
80104579:	5e                   	pop    %esi
8010457a:	5d                   	pop    %ebp
8010457b:	c3                   	ret    
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104580 <strlen>:

int
strlen(const char *s)
{
80104580:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104581:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104583:	89 e5                	mov    %esp,%ebp
80104585:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104588:	80 3a 00             	cmpb   $0x0,(%edx)
8010458b:	74 0c                	je     80104599 <strlen+0x19>
8010458d:	8d 76 00             	lea    0x0(%esi),%esi
80104590:	83 c0 01             	add    $0x1,%eax
80104593:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104597:	75 f7                	jne    80104590 <strlen+0x10>
    ;
  return n;
}
80104599:	5d                   	pop    %ebp
8010459a:	c3                   	ret    

8010459b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010459b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010459f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801045a3:	55                   	push   %ebp
  pushl %ebx
801045a4:	53                   	push   %ebx
  pushl %esi
801045a5:	56                   	push   %esi
  pushl %edi
801045a6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801045a7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801045a9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801045ab:	5f                   	pop    %edi
  popl %esi
801045ac:	5e                   	pop    %esi
  popl %ebx
801045ad:	5b                   	pop    %ebx
  popl %ebp
801045ae:	5d                   	pop    %ebp
  ret
801045af:	c3                   	ret    

801045b0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	83 ec 04             	sub    $0x4,%esp
801045b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801045ba:	e8 a1 f1 ff ff       	call   80103760 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801045bf:	8b 00                	mov    (%eax),%eax
801045c1:	39 d8                	cmp    %ebx,%eax
801045c3:	76 1b                	jbe    801045e0 <fetchint+0x30>
801045c5:	8d 53 04             	lea    0x4(%ebx),%edx
801045c8:	39 d0                	cmp    %edx,%eax
801045ca:	72 14                	jb     801045e0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801045cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801045cf:	8b 13                	mov    (%ebx),%edx
801045d1:	89 10                	mov    %edx,(%eax)
  return 0;
801045d3:	31 c0                	xor    %eax,%eax
}
801045d5:	83 c4 04             	add    $0x4,%esp
801045d8:	5b                   	pop    %ebx
801045d9:	5d                   	pop    %ebp
801045da:	c3                   	ret    
801045db:	90                   	nop
801045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801045e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045e5:	eb ee                	jmp    801045d5 <fetchint+0x25>
801045e7:	89 f6                	mov    %esi,%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045f0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	53                   	push   %ebx
801045f4:	83 ec 04             	sub    $0x4,%esp
801045f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801045fa:	e8 61 f1 ff ff       	call   80103760 <myproc>

  if(addr >= curproc->sz)
801045ff:	39 18                	cmp    %ebx,(%eax)
80104601:	76 26                	jbe    80104629 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
80104603:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104606:	89 da                	mov    %ebx,%edx
80104608:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010460a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010460c:	39 c3                	cmp    %eax,%ebx
8010460e:	73 19                	jae    80104629 <fetchstr+0x39>
    if(*s == 0)
80104610:	80 3b 00             	cmpb   $0x0,(%ebx)
80104613:	75 0d                	jne    80104622 <fetchstr+0x32>
80104615:	eb 21                	jmp    80104638 <fetchstr+0x48>
80104617:	90                   	nop
80104618:	80 3a 00             	cmpb   $0x0,(%edx)
8010461b:	90                   	nop
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104620:	74 16                	je     80104638 <fetchstr+0x48>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104622:	83 c2 01             	add    $0x1,%edx
80104625:	39 d0                	cmp    %edx,%eax
80104627:	77 ef                	ja     80104618 <fetchstr+0x28>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104629:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010462c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104631:	5b                   	pop    %ebx
80104632:	5d                   	pop    %ebp
80104633:	c3                   	ret    
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104638:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
8010463b:	89 d0                	mov    %edx,%eax
8010463d:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
8010463f:	5b                   	pop    %ebx
80104640:	5d                   	pop    %ebp
80104641:	c3                   	ret    
80104642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	8b 75 0c             	mov    0xc(%ebp),%esi
80104657:	53                   	push   %ebx
80104658:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010465b:	e8 00 f1 ff ff       	call   80103760 <myproc>
80104660:	89 75 0c             	mov    %esi,0xc(%ebp)
80104663:	8b 40 18             	mov    0x18(%eax),%eax
80104666:	8b 40 44             	mov    0x44(%eax),%eax
80104669:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
8010466d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80104670:	5b                   	pop    %ebx
80104671:	5e                   	pop    %esi
80104672:	5d                   	pop    %ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104673:	e9 38 ff ff ff       	jmp    801045b0 <fetchint>
80104678:	90                   	nop
80104679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104680 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
80104685:	83 ec 20             	sub    $0x20,%esp
80104688:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010468b:	e8 d0 f0 ff ff       	call   80103760 <myproc>
80104690:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104692:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104695:	89 44 24 04          	mov    %eax,0x4(%esp)
80104699:	8b 45 08             	mov    0x8(%ebp),%eax
8010469c:	89 04 24             	mov    %eax,(%esp)
8010469f:	e8 ac ff ff ff       	call   80104650 <argint>
801046a4:	85 c0                	test   %eax,%eax
801046a6:	78 28                	js     801046d0 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801046a8:	85 db                	test   %ebx,%ebx
801046aa:	78 24                	js     801046d0 <argptr+0x50>
801046ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046af:	8b 06                	mov    (%esi),%eax
801046b1:	39 c2                	cmp    %eax,%edx
801046b3:	73 1b                	jae    801046d0 <argptr+0x50>
801046b5:	01 d3                	add    %edx,%ebx
801046b7:	39 d8                	cmp    %ebx,%eax
801046b9:	72 15                	jb     801046d0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801046bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801046be:	89 10                	mov    %edx,(%eax)
  return 0;
}
801046c0:	83 c4 20             	add    $0x20,%esp
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
801046c3:	31 c0                	xor    %eax,%eax
}
801046c5:	5b                   	pop    %ebx
801046c6:	5e                   	pop    %esi
801046c7:	5d                   	pop    %ebp
801046c8:	c3                   	ret    
801046c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046d0:	83 c4 20             	add    $0x20,%esp
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
801046d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}
801046d8:	5b                   	pop    %ebx
801046d9:	5e                   	pop    %esi
801046da:	5d                   	pop    %ebp
801046db:	c3                   	ret    
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
801046e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801046e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801046ed:	8b 45 08             	mov    0x8(%ebp),%eax
801046f0:	89 04 24             	mov    %eax,(%esp)
801046f3:	e8 58 ff ff ff       	call   80104650 <argint>
801046f8:	85 c0                	test   %eax,%eax
801046fa:	78 14                	js     80104710 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801046fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80104703:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104706:	89 04 24             	mov    %eax,(%esp)
80104709:	e8 e2 fe ff ff       	call   801045f0 <fetchstr>
}
8010470e:	c9                   	leave  
8010470f:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104715:	c9                   	leave  
80104716:	c3                   	ret    
80104717:	89 f6                	mov    %esi,%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104728:	e8 33 f0 ff ff       	call   80103760 <myproc>

  num = curproc->tf->eax;
8010472d:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104730:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104732:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104735:	8d 50 ff             	lea    -0x1(%eax),%edx
80104738:	83 fa 14             	cmp    $0x14,%edx
8010473b:	77 1b                	ja     80104758 <syscall+0x38>
8010473d:	8b 14 85 80 73 10 80 	mov    -0x7fef8c80(,%eax,4),%edx
80104744:	85 d2                	test   %edx,%edx
80104746:	74 10                	je     80104758 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104748:	ff d2                	call   *%edx
8010474a:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010474d:	83 c4 10             	add    $0x10,%esp
80104750:	5b                   	pop    %ebx
80104751:	5e                   	pop    %esi
80104752:	5d                   	pop    %ebp
80104753:	c3                   	ret    
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104758:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010475c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010475f:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104763:	8b 43 10             	mov    0x10(%ebx),%eax
80104766:	c7 04 24 51 73 10 80 	movl   $0x80107351,(%esp)
8010476d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104771:	e8 8a bf ff ff       	call   80100700 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104776:	8b 43 18             	mov    0x18(%ebx),%eax
80104779:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104780:	83 c4 10             	add    $0x10,%esp
80104783:	5b                   	pop    %ebx
80104784:	5e                   	pop    %esi
80104785:	5d                   	pop    %ebp
80104786:	c3                   	ret    
80104787:	66 90                	xchg   %ax,%ax
80104789:	66 90                	xchg   %ax,%ax
8010478b:	66 90                	xchg   %ax,%ax
8010478d:	66 90                	xchg   %ax,%ax
8010478f:	90                   	nop

80104790 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	53                   	push   %ebx
80104794:	89 c3                	mov    %eax,%ebx
80104796:	83 ec 04             	sub    $0x4,%esp
  int fd;
  struct proc *curproc = myproc();
80104799:	e8 c2 ef ff ff       	call   80103760 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
8010479e:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
801047a0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801047a4:	85 c9                	test   %ecx,%ecx
801047a6:	74 18                	je     801047c0 <fdalloc+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801047a8:	83 c2 01             	add    $0x1,%edx
801047ab:	83 fa 10             	cmp    $0x10,%edx
801047ae:	75 f0                	jne    801047a0 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
801047b0:	83 c4 04             	add    $0x4,%esp
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801047b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047b8:	5b                   	pop    %ebx
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801047c0:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
      return fd;
    }
  }
  return -1;
}
801047c4:	83 c4 04             	add    $0x4,%esp
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
801047c7:	89 d0                	mov    %edx,%eax
    }
  }
  return -1;
}
801047c9:	5b                   	pop    %ebx
801047ca:	5d                   	pop    %ebp
801047cb:	c3                   	ret    
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047d0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	57                   	push   %edi
801047d4:	56                   	push   %esi
801047d5:	53                   	push   %ebx
801047d6:	83 ec 4c             	sub    $0x4c,%esp
801047d9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801047dc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801047df:	8d 5d da             	lea    -0x26(%ebp),%ebx
801047e2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801047e6:	89 04 24             	mov    %eax,(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801047e9:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801047ec:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801047ef:	e8 fc d7 ff ff       	call   80101ff0 <nameiparent>
801047f4:	85 c0                	test   %eax,%eax
801047f6:	89 c7                	mov    %eax,%edi
801047f8:	0f 84 da 00 00 00    	je     801048d8 <create+0x108>
    return 0;
  ilock(dp);
801047fe:	89 04 24             	mov    %eax,(%esp)
80104801:	e8 7a cf ff ff       	call   80101780 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104806:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104809:	89 44 24 08          	mov    %eax,0x8(%esp)
8010480d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104811:	89 3c 24             	mov    %edi,(%esp)
80104814:	e8 77 d4 ff ff       	call   80101c90 <dirlookup>
80104819:	85 c0                	test   %eax,%eax
8010481b:	89 c6                	mov    %eax,%esi
8010481d:	74 41                	je     80104860 <create+0x90>
    iunlockput(dp);
8010481f:	89 3c 24             	mov    %edi,(%esp)
80104822:	e8 b9 d1 ff ff       	call   801019e0 <iunlockput>
    ilock(ip);
80104827:	89 34 24             	mov    %esi,(%esp)
8010482a:	e8 51 cf ff ff       	call   80101780 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010482f:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104834:	75 12                	jne    80104848 <create+0x78>
80104836:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010483b:	89 f0                	mov    %esi,%eax
8010483d:	75 09                	jne    80104848 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010483f:	83 c4 4c             	add    $0x4c,%esp
80104842:	5b                   	pop    %ebx
80104843:	5e                   	pop    %esi
80104844:	5f                   	pop    %edi
80104845:	5d                   	pop    %ebp
80104846:	c3                   	ret    
80104847:	90                   	nop
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104848:	89 34 24             	mov    %esi,(%esp)
8010484b:	e8 90 d1 ff ff       	call   801019e0 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104850:	83 c4 4c             	add    $0x4c,%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104853:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104855:	5b                   	pop    %ebx
80104856:	5e                   	pop    %esi
80104857:	5f                   	pop    %edi
80104858:	5d                   	pop    %ebp
80104859:	c3                   	ret    
8010485a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104860:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104863:	89 44 24 04          	mov    %eax,0x4(%esp)
80104867:	8b 07                	mov    (%edi),%eax
80104869:	89 04 24             	mov    %eax,(%esp)
8010486c:	e8 7f cd ff ff       	call   801015f0 <ialloc>
80104871:	85 c0                	test   %eax,%eax
80104873:	89 c6                	mov    %eax,%esi
80104875:	0f 84 c0 00 00 00    	je     8010493b <create+0x16b>
    panic("create: ialloc");

  ilock(ip);
8010487b:	89 04 24             	mov    %eax,(%esp)
8010487e:	e8 fd ce ff ff       	call   80101780 <ilock>
  ip->major = major;
80104883:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104887:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010488b:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
8010488f:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104893:	b8 01 00 00 00       	mov    $0x1,%eax
80104898:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010489c:	89 34 24             	mov    %esi,(%esp)
8010489f:	e8 1c ce ff ff       	call   801016c0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
801048a4:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801048a9:	74 35                	je     801048e0 <create+0x110>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
801048ab:	8b 46 04             	mov    0x4(%esi),%eax
801048ae:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801048b2:	89 3c 24             	mov    %edi,(%esp)
801048b5:	89 44 24 08          	mov    %eax,0x8(%esp)
801048b9:	e8 32 d6 ff ff       	call   80101ef0 <dirlink>
801048be:	85 c0                	test   %eax,%eax
801048c0:	78 6d                	js     8010492f <create+0x15f>
    panic("create: dirlink");

  iunlockput(dp);
801048c2:	89 3c 24             	mov    %edi,(%esp)
801048c5:	e8 16 d1 ff ff       	call   801019e0 <iunlockput>

  return ip;
}
801048ca:	83 c4 4c             	add    $0x4c,%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
801048cd:	89 f0                	mov    %esi,%eax
}
801048cf:	5b                   	pop    %ebx
801048d0:	5e                   	pop    %esi
801048d1:	5f                   	pop    %edi
801048d2:	5d                   	pop    %ebp
801048d3:	c3                   	ret    
801048d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
801048d8:	31 c0                	xor    %eax,%eax
801048da:	e9 60 ff ff ff       	jmp    8010483f <create+0x6f>
801048df:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
801048e0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
801048e5:	89 3c 24             	mov    %edi,(%esp)
801048e8:	e8 d3 cd ff ff       	call   801016c0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801048ed:	8b 46 04             	mov    0x4(%esi),%eax
801048f0:	c7 44 24 04 f4 73 10 	movl   $0x801073f4,0x4(%esp)
801048f7:	80 
801048f8:	89 34 24             	mov    %esi,(%esp)
801048fb:	89 44 24 08          	mov    %eax,0x8(%esp)
801048ff:	e8 ec d5 ff ff       	call   80101ef0 <dirlink>
80104904:	85 c0                	test   %eax,%eax
80104906:	78 1b                	js     80104923 <create+0x153>
80104908:	8b 47 04             	mov    0x4(%edi),%eax
8010490b:	c7 44 24 04 f3 73 10 	movl   $0x801073f3,0x4(%esp)
80104912:	80 
80104913:	89 34 24             	mov    %esi,(%esp)
80104916:	89 44 24 08          	mov    %eax,0x8(%esp)
8010491a:	e8 d1 d5 ff ff       	call   80101ef0 <dirlink>
8010491f:	85 c0                	test   %eax,%eax
80104921:	79 88                	jns    801048ab <create+0xdb>
      panic("create dots");
80104923:	c7 04 24 e7 73 10 80 	movl   $0x801073e7,(%esp)
8010492a:	e8 31 ba ff ff       	call   80100360 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
8010492f:	c7 04 24 f6 73 10 80 	movl   $0x801073f6,(%esp)
80104936:	e8 25 ba ff ff       	call   80100360 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
8010493b:	c7 04 24 d8 73 10 80 	movl   $0x801073d8,(%esp)
80104942:	e8 19 ba ff ff       	call   80100360 <panic>
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	89 c6                	mov    %eax,%esi
80104956:	53                   	push   %ebx
80104957:	89 d3                	mov    %edx,%ebx
80104959:	83 ec 20             	sub    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010495c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010495f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104963:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010496a:	e8 e1 fc ff ff       	call   80104650 <argint>
8010496f:	85 c0                	test   %eax,%eax
80104971:	78 2d                	js     801049a0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104973:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104977:	77 27                	ja     801049a0 <argfd.constprop.0+0x50>
80104979:	e8 e2 ed ff ff       	call   80103760 <myproc>
8010497e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104981:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104985:	85 c0                	test   %eax,%eax
80104987:	74 17                	je     801049a0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104989:	85 f6                	test   %esi,%esi
8010498b:	74 02                	je     8010498f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010498d:	89 16                	mov    %edx,(%esi)
  if(pf)
8010498f:	85 db                	test   %ebx,%ebx
80104991:	74 1d                	je     801049b0 <argfd.constprop.0+0x60>
    *pf = f;
80104993:	89 03                	mov    %eax,(%ebx)
  return 0;
80104995:	31 c0                	xor    %eax,%eax
}
80104997:	83 c4 20             	add    $0x20,%esp
8010499a:	5b                   	pop    %ebx
8010499b:	5e                   	pop    %esi
8010499c:	5d                   	pop    %ebp
8010499d:	c3                   	ret    
8010499e:	66 90                	xchg   %ax,%ax
801049a0:	83 c4 20             	add    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801049a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
801049a8:	5b                   	pop    %ebx
801049a9:	5e                   	pop    %esi
801049aa:	5d                   	pop    %ebp
801049ab:	c3                   	ret    
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801049b0:	31 c0                	xor    %eax,%eax
801049b2:	eb e3                	jmp    80104997 <argfd.constprop.0+0x47>
801049b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801049c0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801049c0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801049c1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
801049c3:	89 e5                	mov    %esp,%ebp
801049c5:	53                   	push   %ebx
801049c6:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801049c9:	8d 55 f4             	lea    -0xc(%ebp),%edx
801049cc:	e8 7f ff ff ff       	call   80104950 <argfd.constprop.0>
801049d1:	85 c0                	test   %eax,%eax
801049d3:	78 23                	js     801049f8 <sys_dup+0x38>
    return -1;
  if((fd=fdalloc(f)) < 0)
801049d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049d8:	e8 b3 fd ff ff       	call   80104790 <fdalloc>
801049dd:	85 c0                	test   %eax,%eax
801049df:	89 c3                	mov    %eax,%ebx
801049e1:	78 15                	js     801049f8 <sys_dup+0x38>
    return -1;
  filedup(f);
801049e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e6:	89 04 24             	mov    %eax,(%esp)
801049e9:	e8 b2 c4 ff ff       	call   80100ea0 <filedup>
  return fd;
801049ee:	89 d8                	mov    %ebx,%eax
}
801049f0:	83 c4 24             	add    $0x24,%esp
801049f3:	5b                   	pop    %ebx
801049f4:	5d                   	pop    %ebp
801049f5:	c3                   	ret    
801049f6:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
801049f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049fd:	eb f1                	jmp    801049f0 <sys_dup+0x30>
801049ff:	90                   	nop

80104a00 <sys_read>:
  return fd;
}

int
sys_read(void)
{
80104a00:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a01:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104a03:	89 e5                	mov    %esp,%ebp
80104a05:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a0b:	e8 40 ff ff ff       	call   80104950 <argfd.constprop.0>
80104a10:	85 c0                	test   %eax,%eax
80104a12:	78 54                	js     80104a68 <sys_read+0x68>
80104a14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a17:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104a22:	e8 29 fc ff ff       	call   80104650 <argint>
80104a27:	85 c0                	test   %eax,%eax
80104a29:	78 3d                	js     80104a68 <sys_read+0x68>
80104a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a2e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104a35:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a40:	e8 3b fc ff ff       	call   80104680 <argptr>
80104a45:	85 c0                	test   %eax,%eax
80104a47:	78 1f                	js     80104a68 <sys_read+0x68>
    return -1;
  return fileread(f, p, n);
80104a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a4c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a53:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a57:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a5a:	89 04 24             	mov    %eax,(%esp)
80104a5d:	e8 9e c5 ff ff       	call   80101000 <fileread>
}
80104a62:	c9                   	leave  
80104a63:	c3                   	ret    
80104a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104a68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104a6d:	c9                   	leave  
80104a6e:	c3                   	ret    
80104a6f:	90                   	nop

80104a70 <sys_write>:

int
sys_write(void)
{
80104a70:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a71:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104a73:	89 e5                	mov    %esp,%ebp
80104a75:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a7b:	e8 d0 fe ff ff       	call   80104950 <argfd.constprop.0>
80104a80:	85 c0                	test   %eax,%eax
80104a82:	78 54                	js     80104ad8 <sys_write+0x68>
80104a84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a8b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104a92:	e8 b9 fb ff ff       	call   80104650 <argint>
80104a97:	85 c0                	test   %eax,%eax
80104a99:	78 3d                	js     80104ad8 <sys_write+0x68>
80104a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104aa5:	89 44 24 08          	mov    %eax,0x8(%esp)
80104aa9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104aac:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ab0:	e8 cb fb ff ff       	call   80104680 <argptr>
80104ab5:	85 c0                	test   %eax,%eax
80104ab7:	78 1f                	js     80104ad8 <sys_write+0x68>
    return -1;
  return filewrite(f, p, n);
80104ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104abc:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ac7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104aca:	89 04 24             	mov    %eax,(%esp)
80104acd:	e8 ce c5 ff ff       	call   801010a0 <filewrite>
}
80104ad2:	c9                   	leave  
80104ad3:	c3                   	ret    
80104ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104ad8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104add:	c9                   	leave  
80104ade:	c3                   	ret    
80104adf:	90                   	nop

80104ae0 <sys_close>:

int
sys_close(void)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104ae6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ae9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104aec:	e8 5f fe ff ff       	call   80104950 <argfd.constprop.0>
80104af1:	85 c0                	test   %eax,%eax
80104af3:	78 23                	js     80104b18 <sys_close+0x38>
    return -1;
  myproc()->ofile[fd] = 0;
80104af5:	e8 66 ec ff ff       	call   80103760 <myproc>
80104afa:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104afd:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104b04:	00 
  fileclose(f);
80104b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b08:	89 04 24             	mov    %eax,(%esp)
80104b0b:	e8 e0 c3 ff ff       	call   80100ef0 <fileclose>
  return 0;
80104b10:	31 c0                	xor    %eax,%eax
}
80104b12:	c9                   	leave  
80104b13:	c3                   	ret    
80104b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104b18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104b1d:	c9                   	leave  
80104b1e:	c3                   	ret    
80104b1f:	90                   	nop

80104b20 <sys_fstat>:

int
sys_fstat(void)
{
80104b20:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104b21:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104b23:	89 e5                	mov    %esp,%ebp
80104b25:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104b28:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104b2b:	e8 20 fe ff ff       	call   80104950 <argfd.constprop.0>
80104b30:	85 c0                	test   %eax,%eax
80104b32:	78 34                	js     80104b68 <sys_fstat+0x48>
80104b34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b37:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104b3e:	00 
80104b3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b4a:	e8 31 fb ff ff       	call   80104680 <argptr>
80104b4f:	85 c0                	test   %eax,%eax
80104b51:	78 15                	js     80104b68 <sys_fstat+0x48>
    return -1;
  return filestat(f, st);
80104b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b56:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b5d:	89 04 24             	mov    %eax,(%esp)
80104b60:	e8 4b c4 ff ff       	call   80100fb0 <filestat>
}
80104b65:	c9                   	leave  
80104b66:	c3                   	ret    
80104b67:	90                   	nop
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104b6d:	c9                   	leave  
80104b6e:	c3                   	ret    
80104b6f:	90                   	nop

80104b70 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	57                   	push   %edi
80104b74:	56                   	push   %esi
80104b75:	53                   	push   %ebx
80104b76:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104b79:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b7c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104b87:	e8 54 fb ff ff       	call   801046e0 <argstr>
80104b8c:	85 c0                	test   %eax,%eax
80104b8e:	0f 88 e6 00 00 00    	js     80104c7a <sys_link+0x10a>
80104b94:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104b97:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104ba2:	e8 39 fb ff ff       	call   801046e0 <argstr>
80104ba7:	85 c0                	test   %eax,%eax
80104ba9:	0f 88 cb 00 00 00    	js     80104c7a <sys_link+0x10a>
    return -1;

  begin_op();
80104baf:	e8 1c e0 ff ff       	call   80102bd0 <begin_op>
  if((ip = namei(old)) == 0){
80104bb4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104bb7:	89 04 24             	mov    %eax,(%esp)
80104bba:	e8 11 d4 ff ff       	call   80101fd0 <namei>
80104bbf:	85 c0                	test   %eax,%eax
80104bc1:	89 c3                	mov    %eax,%ebx
80104bc3:	0f 84 ac 00 00 00    	je     80104c75 <sys_link+0x105>
    end_op();
    return -1;
  }

  ilock(ip);
80104bc9:	89 04 24             	mov    %eax,(%esp)
80104bcc:	e8 af cb ff ff       	call   80101780 <ilock>
  if(ip->type == T_DIR){
80104bd1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104bd6:	0f 84 91 00 00 00    	je     80104c6d <sys_link+0xfd>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104bdc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104be1:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104be4:	89 1c 24             	mov    %ebx,(%esp)
80104be7:	e8 d4 ca ff ff       	call   801016c0 <iupdate>
  iunlock(ip);
80104bec:	89 1c 24             	mov    %ebx,(%esp)
80104bef:	e8 6c cc ff ff       	call   80101860 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104bf4:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104bf7:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104bfb:	89 04 24             	mov    %eax,(%esp)
80104bfe:	e8 ed d3 ff ff       	call   80101ff0 <nameiparent>
80104c03:	85 c0                	test   %eax,%eax
80104c05:	89 c6                	mov    %eax,%esi
80104c07:	74 4f                	je     80104c58 <sys_link+0xe8>
    goto bad;
  ilock(dp);
80104c09:	89 04 24             	mov    %eax,(%esp)
80104c0c:	e8 6f cb ff ff       	call   80101780 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104c11:	8b 03                	mov    (%ebx),%eax
80104c13:	39 06                	cmp    %eax,(%esi)
80104c15:	75 39                	jne    80104c50 <sys_link+0xe0>
80104c17:	8b 43 04             	mov    0x4(%ebx),%eax
80104c1a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c1e:	89 34 24             	mov    %esi,(%esp)
80104c21:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c25:	e8 c6 d2 ff ff       	call   80101ef0 <dirlink>
80104c2a:	85 c0                	test   %eax,%eax
80104c2c:	78 22                	js     80104c50 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104c2e:	89 34 24             	mov    %esi,(%esp)
80104c31:	e8 aa cd ff ff       	call   801019e0 <iunlockput>
  iput(ip);
80104c36:	89 1c 24             	mov    %ebx,(%esp)
80104c39:	e8 62 cc ff ff       	call   801018a0 <iput>

  end_op();
80104c3e:	e8 fd df ff ff       	call   80102c40 <end_op>
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104c43:	83 c4 3c             	add    $0x3c,%esp
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;
80104c46:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104c48:	5b                   	pop    %ebx
80104c49:	5e                   	pop    %esi
80104c4a:	5f                   	pop    %edi
80104c4b:	5d                   	pop    %ebp
80104c4c:	c3                   	ret    
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104c50:	89 34 24             	mov    %esi,(%esp)
80104c53:	e8 88 cd ff ff       	call   801019e0 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
80104c58:	89 1c 24             	mov    %ebx,(%esp)
80104c5b:	e8 20 cb ff ff       	call   80101780 <ilock>
  ip->nlink--;
80104c60:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104c65:	89 1c 24             	mov    %ebx,(%esp)
80104c68:	e8 53 ca ff ff       	call   801016c0 <iupdate>
  iunlockput(ip);
80104c6d:	89 1c 24             	mov    %ebx,(%esp)
80104c70:	e8 6b cd ff ff       	call   801019e0 <iunlockput>
  end_op();
80104c75:	e8 c6 df ff ff       	call   80102c40 <end_op>
  return -1;
}
80104c7a:	83 c4 3c             	add    $0x3c,%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104c7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c82:	5b                   	pop    %ebx
80104c83:	5e                   	pop    %esi
80104c84:	5f                   	pop    %edi
80104c85:	5d                   	pop    %ebp
80104c86:	c3                   	ret    
80104c87:	89 f6                	mov    %esi,%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	57                   	push   %edi
80104c94:	56                   	push   %esi
80104c95:	53                   	push   %ebx
80104c96:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104c99:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104c9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ca0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ca7:	e8 34 fa ff ff       	call   801046e0 <argstr>
80104cac:	85 c0                	test   %eax,%eax
80104cae:	0f 88 76 01 00 00    	js     80104e2a <sys_unlink+0x19a>
    return -1;

  begin_op();
80104cb4:	e8 17 df ff ff       	call   80102bd0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104cb9:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104cbc:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104cbf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104cc3:	89 04 24             	mov    %eax,(%esp)
80104cc6:	e8 25 d3 ff ff       	call   80101ff0 <nameiparent>
80104ccb:	85 c0                	test   %eax,%eax
80104ccd:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104cd0:	0f 84 4f 01 00 00    	je     80104e25 <sys_unlink+0x195>
    end_op();
    return -1;
  }

  ilock(dp);
80104cd6:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104cd9:	89 34 24             	mov    %esi,(%esp)
80104cdc:	e8 9f ca ff ff       	call   80101780 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104ce1:	c7 44 24 04 f4 73 10 	movl   $0x801073f4,0x4(%esp)
80104ce8:	80 
80104ce9:	89 1c 24             	mov    %ebx,(%esp)
80104cec:	e8 6f cf ff ff       	call   80101c60 <namecmp>
80104cf1:	85 c0                	test   %eax,%eax
80104cf3:	0f 84 21 01 00 00    	je     80104e1a <sys_unlink+0x18a>
80104cf9:	c7 44 24 04 f3 73 10 	movl   $0x801073f3,0x4(%esp)
80104d00:	80 
80104d01:	89 1c 24             	mov    %ebx,(%esp)
80104d04:	e8 57 cf ff ff       	call   80101c60 <namecmp>
80104d09:	85 c0                	test   %eax,%eax
80104d0b:	0f 84 09 01 00 00    	je     80104e1a <sys_unlink+0x18a>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104d11:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104d14:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d18:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d1c:	89 34 24             	mov    %esi,(%esp)
80104d1f:	e8 6c cf ff ff       	call   80101c90 <dirlookup>
80104d24:	85 c0                	test   %eax,%eax
80104d26:	89 c3                	mov    %eax,%ebx
80104d28:	0f 84 ec 00 00 00    	je     80104e1a <sys_unlink+0x18a>
    goto bad;
  ilock(ip);
80104d2e:	89 04 24             	mov    %eax,(%esp)
80104d31:	e8 4a ca ff ff       	call   80101780 <ilock>

  if(ip->nlink < 1)
80104d36:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104d3b:	0f 8e 24 01 00 00    	jle    80104e65 <sys_unlink+0x1d5>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104d41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d46:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104d49:	74 7d                	je     80104dc8 <sys_unlink+0x138>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104d4b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104d52:	00 
80104d53:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104d5a:	00 
80104d5b:	89 34 24             	mov    %esi,(%esp)
80104d5e:	e8 fd f5 ff ff       	call   80104360 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104d63:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104d66:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104d6d:	00 
80104d6e:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d72:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d76:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104d79:	89 04 24             	mov    %eax,(%esp)
80104d7c:	e8 af cd ff ff       	call   80101b30 <writei>
80104d81:	83 f8 10             	cmp    $0x10,%eax
80104d84:	0f 85 cf 00 00 00    	jne    80104e59 <sys_unlink+0x1c9>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104d8a:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d8f:	0f 84 a3 00 00 00    	je     80104e38 <sys_unlink+0x1a8>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104d95:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104d98:	89 04 24             	mov    %eax,(%esp)
80104d9b:	e8 40 cc ff ff       	call   801019e0 <iunlockput>

  ip->nlink--;
80104da0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104da5:	89 1c 24             	mov    %ebx,(%esp)
80104da8:	e8 13 c9 ff ff       	call   801016c0 <iupdate>
  iunlockput(ip);
80104dad:	89 1c 24             	mov    %ebx,(%esp)
80104db0:	e8 2b cc ff ff       	call   801019e0 <iunlockput>

  end_op();
80104db5:	e8 86 de ff ff       	call   80102c40 <end_op>

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104dba:	83 c4 5c             	add    $0x5c,%esp
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;
80104dbd:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104dbf:	5b                   	pop    %ebx
80104dc0:	5e                   	pop    %esi
80104dc1:	5f                   	pop    %edi
80104dc2:	5d                   	pop    %ebp
80104dc3:	c3                   	ret    
80104dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104dc8:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104dcc:	0f 86 79 ff ff ff    	jbe    80104d4b <sys_unlink+0xbb>
80104dd2:	bf 20 00 00 00       	mov    $0x20,%edi
80104dd7:	eb 15                	jmp    80104dee <sys_unlink+0x15e>
80104dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104de0:	8d 57 10             	lea    0x10(%edi),%edx
80104de3:	3b 53 58             	cmp    0x58(%ebx),%edx
80104de6:	0f 83 5f ff ff ff    	jae    80104d4b <sys_unlink+0xbb>
80104dec:	89 d7                	mov    %edx,%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104dee:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104df5:	00 
80104df6:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104dfa:	89 74 24 04          	mov    %esi,0x4(%esp)
80104dfe:	89 1c 24             	mov    %ebx,(%esp)
80104e01:	e8 2a cc ff ff       	call   80101a30 <readi>
80104e06:	83 f8 10             	cmp    $0x10,%eax
80104e09:	75 42                	jne    80104e4d <sys_unlink+0x1bd>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104e0b:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104e10:	74 ce                	je     80104de0 <sys_unlink+0x150>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104e12:	89 1c 24             	mov    %ebx,(%esp)
80104e15:	e8 c6 cb ff ff       	call   801019e0 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104e1a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e1d:	89 04 24             	mov    %eax,(%esp)
80104e20:	e8 bb cb ff ff       	call   801019e0 <iunlockput>
  end_op();
80104e25:	e8 16 de ff ff       	call   80102c40 <end_op>
  return -1;
}
80104e2a:	83 c4 5c             	add    $0x5c,%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80104e2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e32:	5b                   	pop    %ebx
80104e33:	5e                   	pop    %esi
80104e34:	5f                   	pop    %edi
80104e35:	5d                   	pop    %ebp
80104e36:	c3                   	ret    
80104e37:	90                   	nop

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104e38:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e3b:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80104e40:	89 04 24             	mov    %eax,(%esp)
80104e43:	e8 78 c8 ff ff       	call   801016c0 <iupdate>
80104e48:	e9 48 ff ff ff       	jmp    80104d95 <sys_unlink+0x105>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104e4d:	c7 04 24 18 74 10 80 	movl   $0x80107418,(%esp)
80104e54:	e8 07 b5 ff ff       	call   80100360 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104e59:	c7 04 24 2a 74 10 80 	movl   $0x8010742a,(%esp)
80104e60:	e8 fb b4 ff ff       	call   80100360 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80104e65:	c7 04 24 06 74 10 80 	movl   $0x80107406,(%esp)
80104e6c:	e8 ef b4 ff ff       	call   80100360 <panic>
80104e71:	eb 0d                	jmp    80104e80 <sys_open>
80104e73:	90                   	nop
80104e74:	90                   	nop
80104e75:	90                   	nop
80104e76:	90                   	nop
80104e77:	90                   	nop
80104e78:	90                   	nop
80104e79:	90                   	nop
80104e7a:	90                   	nop
80104e7b:	90                   	nop
80104e7c:	90                   	nop
80104e7d:	90                   	nop
80104e7e:	90                   	nop
80104e7f:	90                   	nop

80104e80 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	57                   	push   %edi
80104e84:	56                   	push   %esi
80104e85:	53                   	push   %ebx
80104e86:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104e89:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104e8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e97:	e8 44 f8 ff ff       	call   801046e0 <argstr>
80104e9c:	85 c0                	test   %eax,%eax
80104e9e:	0f 88 d1 00 00 00    	js     80104f75 <sys_open+0xf5>
80104ea4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104ea7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104eab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104eb2:	e8 99 f7 ff ff       	call   80104650 <argint>
80104eb7:	85 c0                	test   %eax,%eax
80104eb9:	0f 88 b6 00 00 00    	js     80104f75 <sys_open+0xf5>
    return -1;

  begin_op();
80104ebf:	e8 0c dd ff ff       	call   80102bd0 <begin_op>

  if(omode & O_CREATE){
80104ec4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104ec8:	0f 85 82 00 00 00    	jne    80104f50 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104ece:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ed1:	89 04 24             	mov    %eax,(%esp)
80104ed4:	e8 f7 d0 ff ff       	call   80101fd0 <namei>
80104ed9:	85 c0                	test   %eax,%eax
80104edb:	89 c6                	mov    %eax,%esi
80104edd:	0f 84 8d 00 00 00    	je     80104f70 <sys_open+0xf0>
      end_op();
      return -1;
    }
    ilock(ip);
80104ee3:	89 04 24             	mov    %eax,(%esp)
80104ee6:	e8 95 c8 ff ff       	call   80101780 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104eeb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104ef0:	0f 84 92 00 00 00    	je     80104f88 <sys_open+0x108>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104ef6:	e8 35 bf ff ff       	call   80100e30 <filealloc>
80104efb:	85 c0                	test   %eax,%eax
80104efd:	89 c3                	mov    %eax,%ebx
80104eff:	0f 84 93 00 00 00    	je     80104f98 <sys_open+0x118>
80104f05:	e8 86 f8 ff ff       	call   80104790 <fdalloc>
80104f0a:	85 c0                	test   %eax,%eax
80104f0c:	89 c7                	mov    %eax,%edi
80104f0e:	0f 88 94 00 00 00    	js     80104fa8 <sys_open+0x128>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104f14:	89 34 24             	mov    %esi,(%esp)
80104f17:	e8 44 c9 ff ff       	call   80101860 <iunlock>
  end_op();
80104f1c:	e8 1f dd ff ff       	call   80102c40 <end_op>

  f->type = FD_INODE;
80104f21:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104f27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
80104f2a:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80104f2d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80104f34:	89 c2                	mov    %eax,%edx
80104f36:	83 e2 01             	and    $0x1,%edx
80104f39:	83 f2 01             	xor    $0x1,%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f3c:	a8 03                	test   $0x3,%al
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104f3e:	88 53 08             	mov    %dl,0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
80104f41:	89 f8                	mov    %edi,%eax

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f43:	0f 95 43 09          	setne  0x9(%ebx)
  return fd;
}
80104f47:	83 c4 2c             	add    $0x2c,%esp
80104f4a:	5b                   	pop    %ebx
80104f4b:	5e                   	pop    %esi
80104f4c:	5f                   	pop    %edi
80104f4d:	5d                   	pop    %ebp
80104f4e:	c3                   	ret    
80104f4f:	90                   	nop
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104f50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f53:	31 c9                	xor    %ecx,%ecx
80104f55:	ba 02 00 00 00       	mov    $0x2,%edx
80104f5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f61:	e8 6a f8 ff ff       	call   801047d0 <create>
    if(ip == 0){
80104f66:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104f68:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80104f6a:	75 8a                	jne    80104ef6 <sys_open+0x76>
80104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
80104f70:	e8 cb dc ff ff       	call   80102c40 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104f75:	83 c4 2c             	add    $0x2c,%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80104f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104f7d:	5b                   	pop    %ebx
80104f7e:	5e                   	pop    %esi
80104f7f:	5f                   	pop    %edi
80104f80:	5d                   	pop    %ebp
80104f81:	c3                   	ret    
80104f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80104f88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104f8b:	85 c0                	test   %eax,%eax
80104f8d:	0f 84 63 ff ff ff    	je     80104ef6 <sys_open+0x76>
80104f93:	90                   	nop
80104f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
80104f98:	89 34 24             	mov    %esi,(%esp)
80104f9b:	e8 40 ca ff ff       	call   801019e0 <iunlockput>
80104fa0:	eb ce                	jmp    80104f70 <sys_open+0xf0>
80104fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80104fa8:	89 1c 24             	mov    %ebx,(%esp)
80104fab:	e8 40 bf ff ff       	call   80100ef0 <fileclose>
80104fb0:	eb e6                	jmp    80104f98 <sys_open+0x118>
80104fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fc0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104fc6:	e8 05 dc ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104fcb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fce:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fd2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fd9:	e8 02 f7 ff ff       	call   801046e0 <argstr>
80104fde:	85 c0                	test   %eax,%eax
80104fe0:	78 2e                	js     80105010 <sys_mkdir+0x50>
80104fe2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fe5:	31 c9                	xor    %ecx,%ecx
80104fe7:	ba 01 00 00 00       	mov    $0x1,%edx
80104fec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ff3:	e8 d8 f7 ff ff       	call   801047d0 <create>
80104ff8:	85 c0                	test   %eax,%eax
80104ffa:	74 14                	je     80105010 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104ffc:	89 04 24             	mov    %eax,(%esp)
80104fff:	e8 dc c9 ff ff       	call   801019e0 <iunlockput>
  end_op();
80105004:	e8 37 dc ff ff       	call   80102c40 <end_op>
  return 0;
80105009:	31 c0                	xor    %eax,%eax
}
8010500b:	c9                   	leave  
8010500c:	c3                   	ret    
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105010:	e8 2b dc ff ff       	call   80102c40 <end_op>
    return -1;
80105015:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010501a:	c9                   	leave  
8010501b:	c3                   	ret    
8010501c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105020 <sys_mknod>:

int
sys_mknod(void)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105026:	e8 a5 db ff ff       	call   80102bd0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010502b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010502e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105032:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105039:	e8 a2 f6 ff ff       	call   801046e0 <argstr>
8010503e:	85 c0                	test   %eax,%eax
80105040:	78 5e                	js     801050a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105042:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105045:	89 44 24 04          	mov    %eax,0x4(%esp)
80105049:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105050:	e8 fb f5 ff ff       	call   80104650 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80105055:	85 c0                	test   %eax,%eax
80105057:	78 47                	js     801050a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105059:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010505c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105060:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105067:	e8 e4 f5 ff ff       	call   80104650 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
8010506c:	85 c0                	test   %eax,%eax
8010506e:	78 30                	js     801050a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105070:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105074:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80105079:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010507d:	89 04 24             	mov    %eax,(%esp)
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105080:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105083:	e8 48 f7 ff ff       	call   801047d0 <create>
80105088:	85 c0                	test   %eax,%eax
8010508a:	74 14                	je     801050a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010508c:	89 04 24             	mov    %eax,(%esp)
8010508f:	e8 4c c9 ff ff       	call   801019e0 <iunlockput>
  end_op();
80105094:	e8 a7 db ff ff       	call   80102c40 <end_op>
  return 0;
80105099:	31 c0                	xor    %eax,%eax
}
8010509b:	c9                   	leave  
8010509c:	c3                   	ret    
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801050a0:	e8 9b db ff ff       	call   80102c40 <end_op>
    return -1;
801050a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801050aa:	c9                   	leave  
801050ab:	c3                   	ret    
801050ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050b0 <sys_chdir>:

int
sys_chdir(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	53                   	push   %ebx
801050b5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801050b8:	e8 a3 e6 ff ff       	call   80103760 <myproc>
801050bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801050bf:	e8 0c db ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801050c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801050cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801050d2:	e8 09 f6 ff ff       	call   801046e0 <argstr>
801050d7:	85 c0                	test   %eax,%eax
801050d9:	78 4a                	js     80105125 <sys_chdir+0x75>
801050db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050de:	89 04 24             	mov    %eax,(%esp)
801050e1:	e8 ea ce ff ff       	call   80101fd0 <namei>
801050e6:	85 c0                	test   %eax,%eax
801050e8:	89 c3                	mov    %eax,%ebx
801050ea:	74 39                	je     80105125 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
801050ec:	89 04 24             	mov    %eax,(%esp)
801050ef:	e8 8c c6 ff ff       	call   80101780 <ilock>
  if(ip->type != T_DIR){
801050f4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
801050f9:	89 1c 24             	mov    %ebx,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
801050fc:	75 22                	jne    80105120 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801050fe:	e8 5d c7 ff ff       	call   80101860 <iunlock>
  iput(curproc->cwd);
80105103:	8b 46 68             	mov    0x68(%esi),%eax
80105106:	89 04 24             	mov    %eax,(%esp)
80105109:	e8 92 c7 ff ff       	call   801018a0 <iput>
  end_op();
8010510e:	e8 2d db ff ff       	call   80102c40 <end_op>
  curproc->cwd = ip;
  return 0;
80105113:	31 c0                	xor    %eax,%eax
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
80105115:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
}
80105118:	83 c4 20             	add    $0x20,%esp
8010511b:	5b                   	pop    %ebx
8010511c:	5e                   	pop    %esi
8010511d:	5d                   	pop    %ebp
8010511e:	c3                   	ret    
8010511f:	90                   	nop
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105120:	e8 bb c8 ff ff       	call   801019e0 <iunlockput>
    end_op();
80105125:	e8 16 db ff ff       	call   80102c40 <end_op>
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
8010512a:	83 c4 20             	add    $0x20,%esp
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
8010512d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
80105132:	5b                   	pop    %ebx
80105133:	5e                   	pop    %esi
80105134:	5d                   	pop    %ebp
80105135:	c3                   	ret    
80105136:	8d 76 00             	lea    0x0(%esi),%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <sys_exec>:

int
sys_exec(void)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	57                   	push   %edi
80105144:	56                   	push   %esi
80105145:	53                   	push   %ebx
80105146:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010514c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105152:	89 44 24 04          	mov    %eax,0x4(%esp)
80105156:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010515d:	e8 7e f5 ff ff       	call   801046e0 <argstr>
80105162:	85 c0                	test   %eax,%eax
80105164:	0f 88 84 00 00 00    	js     801051ee <sys_exec+0xae>
8010516a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105170:	89 44 24 04          	mov    %eax,0x4(%esp)
80105174:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010517b:	e8 d0 f4 ff ff       	call   80104650 <argint>
80105180:	85 c0                	test   %eax,%eax
80105182:	78 6a                	js     801051ee <sys_exec+0xae>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105184:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010518a:	31 db                	xor    %ebx,%ebx
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010518c:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80105193:	00 
80105194:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
8010519a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801051a1:	00 
801051a2:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801051a8:	89 04 24             	mov    %eax,(%esp)
801051ab:	e8 b0 f1 ff ff       	call   80104360 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801051b0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801051b6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801051ba:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801051bd:	89 04 24             	mov    %eax,(%esp)
801051c0:	e8 eb f3 ff ff       	call   801045b0 <fetchint>
801051c5:	85 c0                	test   %eax,%eax
801051c7:	78 25                	js     801051ee <sys_exec+0xae>
      return -1;
    if(uarg == 0){
801051c9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801051cf:	85 c0                	test   %eax,%eax
801051d1:	74 2d                	je     80105200 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801051d3:	89 74 24 04          	mov    %esi,0x4(%esp)
801051d7:	89 04 24             	mov    %eax,(%esp)
801051da:	e8 11 f4 ff ff       	call   801045f0 <fetchstr>
801051df:	85 c0                	test   %eax,%eax
801051e1:	78 0b                	js     801051ee <sys_exec+0xae>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801051e3:	83 c3 01             	add    $0x1,%ebx
801051e6:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801051e9:	83 fb 20             	cmp    $0x20,%ebx
801051ec:	75 c2                	jne    801051b0 <sys_exec+0x70>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801051ee:	81 c4 ac 00 00 00    	add    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801051f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801051f9:	5b                   	pop    %ebx
801051fa:	5e                   	pop    %esi
801051fb:	5f                   	pop    %edi
801051fc:	5d                   	pop    %ebp
801051fd:	c3                   	ret    
801051fe:	66 90                	xchg   %ax,%ax
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105200:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105206:	89 44 24 04          	mov    %eax,0x4(%esp)
8010520a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105210:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105217:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010521b:	89 04 24             	mov    %eax,(%esp)
8010521e:	e8 3d b8 ff ff       	call   80100a60 <exec>
}
80105223:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105229:	5b                   	pop    %ebx
8010522a:	5e                   	pop    %esi
8010522b:	5f                   	pop    %edi
8010522c:	5d                   	pop    %ebp
8010522d:	c3                   	ret    
8010522e:	66 90                	xchg   %ax,%ax

80105230 <sys_pipe>:

int
sys_pipe(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	53                   	push   %ebx
80105234:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105237:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010523a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105241:	00 
80105242:	89 44 24 04          	mov    %eax,0x4(%esp)
80105246:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010524d:	e8 2e f4 ff ff       	call   80104680 <argptr>
80105252:	85 c0                	test   %eax,%eax
80105254:	78 6d                	js     801052c3 <sys_pipe+0x93>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105256:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105259:	89 44 24 04          	mov    %eax,0x4(%esp)
8010525d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105260:	89 04 24             	mov    %eax,(%esp)
80105263:	e8 c8 df ff ff       	call   80103230 <pipealloc>
80105268:	85 c0                	test   %eax,%eax
8010526a:	78 57                	js     801052c3 <sys_pipe+0x93>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010526c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010526f:	e8 1c f5 ff ff       	call   80104790 <fdalloc>
80105274:	85 c0                	test   %eax,%eax
80105276:	89 c3                	mov    %eax,%ebx
80105278:	78 33                	js     801052ad <sys_pipe+0x7d>
8010527a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010527d:	e8 0e f5 ff ff       	call   80104790 <fdalloc>
80105282:	85 c0                	test   %eax,%eax
80105284:	78 1a                	js     801052a0 <sys_pipe+0x70>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105286:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105289:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
8010528b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010528e:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
80105291:	83 c4 24             	add    $0x24,%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105294:	31 c0                	xor    %eax,%eax
}
80105296:	5b                   	pop    %ebx
80105297:	5d                   	pop    %ebp
80105298:	c3                   	ret    
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801052a0:	e8 bb e4 ff ff       	call   80103760 <myproc>
801052a5:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
801052ac:	00 
    fileclose(rf);
801052ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052b0:	89 04 24             	mov    %eax,(%esp)
801052b3:	e8 38 bc ff ff       	call   80100ef0 <fileclose>
    fileclose(wf);
801052b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052bb:	89 04 24             	mov    %eax,(%esp)
801052be:	e8 2d bc ff ff       	call   80100ef0 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801052c3:	83 c4 24             	add    $0x24,%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801052c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801052cb:	5b                   	pop    %ebx
801052cc:	5d                   	pop    %ebp
801052cd:	c3                   	ret    
801052ce:	66 90                	xchg   %ax,%ax

801052d0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801052d3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801052d4:	e9 37 e6 ff ff       	jmp    80103910 <fork>
801052d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801052e0 <sys_exit>:
}

int
sys_exit(void)
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	83 ec 08             	sub    $0x8,%esp
  exit();
801052e6:	e8 75 e8 ff ff       	call   80103b60 <exit>
  return 0;  // not reached
}
801052eb:	31 c0                	xor    %eax,%eax
801052ed:	c9                   	leave  
801052ee:	c3                   	ret    
801052ef:	90                   	nop

801052f0 <sys_wait>:

int
sys_wait(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801052f3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801052f4:	e9 77 ea ff ff       	jmp    80103d70 <wait>
801052f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105300 <sys_kill>:
}

int
sys_kill(void)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105306:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105309:	89 44 24 04          	mov    %eax,0x4(%esp)
8010530d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105314:	e8 37 f3 ff ff       	call   80104650 <argint>
80105319:	85 c0                	test   %eax,%eax
8010531b:	78 13                	js     80105330 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010531d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105320:	89 04 24             	mov    %eax,(%esp)
80105323:	e8 88 eb ff ff       	call   80103eb0 <kill>
}
80105328:	c9                   	leave  
80105329:	c3                   	ret    
8010532a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105335:	c9                   	leave  
80105336:	c3                   	ret    
80105337:	89 f6                	mov    %esi,%esi
80105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105340 <sys_getpid>:

int
sys_getpid(void)
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105346:	e8 15 e4 ff ff       	call   80103760 <myproc>
8010534b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010534e:	c9                   	leave  
8010534f:	c3                   	ret    

80105350 <sys_sbrk>:

int
sys_sbrk(void)
{
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	53                   	push   %ebx
80105354:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105357:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010535a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010535e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105365:	e8 e6 f2 ff ff       	call   80104650 <argint>
8010536a:	85 c0                	test   %eax,%eax
8010536c:	78 22                	js     80105390 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010536e:	e8 ed e3 ff ff       	call   80103760 <myproc>
  if(growproc(n) < 0)
80105373:	8b 55 f4             	mov    -0xc(%ebp),%edx
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105376:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105378:	89 14 24             	mov    %edx,(%esp)
8010537b:	e8 20 e5 ff ff       	call   801038a0 <growproc>
80105380:	85 c0                	test   %eax,%eax
80105382:	78 0c                	js     80105390 <sys_sbrk+0x40>
    return -1;
  return addr;
80105384:	89 d8                	mov    %ebx,%eax
}
80105386:	83 c4 24             	add    $0x24,%esp
80105389:	5b                   	pop    %ebx
8010538a:	5d                   	pop    %ebp
8010538b:	c3                   	ret    
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105395:	eb ef                	jmp    80105386 <sys_sbrk+0x36>
80105397:	89 f6                	mov    %esi,%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053a0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	53                   	push   %ebx
801053a4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801053a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053b5:	e8 96 f2 ff ff       	call   80104650 <argint>
801053ba:	85 c0                	test   %eax,%eax
801053bc:	78 7e                	js     8010543c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
801053be:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801053c5:	e8 d6 ee ff ff       	call   801042a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801053ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801053cd:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
  while(ticks - ticks0 < n){
801053d3:	85 d2                	test   %edx,%edx
801053d5:	75 29                	jne    80105400 <sys_sleep+0x60>
801053d7:	eb 4f                	jmp    80105428 <sys_sleep+0x88>
801053d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801053e0:	c7 44 24 04 80 4c 11 	movl   $0x80114c80,0x4(%esp)
801053e7:	80 
801053e8:	c7 04 24 c0 54 11 80 	movl   $0x801154c0,(%esp)
801053ef:	e8 cc e8 ff ff       	call   80103cc0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801053f4:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801053f9:	29 d8                	sub    %ebx,%eax
801053fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801053fe:	73 28                	jae    80105428 <sys_sleep+0x88>
    if(myproc()->killed){
80105400:	e8 5b e3 ff ff       	call   80103760 <myproc>
80105405:	8b 40 24             	mov    0x24(%eax),%eax
80105408:	85 c0                	test   %eax,%eax
8010540a:	74 d4                	je     801053e0 <sys_sleep+0x40>
      release(&tickslock);
8010540c:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105413:	e8 f8 ee ff ff       	call   80104310 <release>
      return -1;
80105418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
8010541d:	83 c4 24             	add    $0x24,%esp
80105420:	5b                   	pop    %ebx
80105421:	5d                   	pop    %ebp
80105422:	c3                   	ret    
80105423:	90                   	nop
80105424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105428:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
8010542f:	e8 dc ee ff ff       	call   80104310 <release>
  return 0;
}
80105434:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
80105437:	31 c0                	xor    %eax,%eax
}
80105439:	5b                   	pop    %ebx
8010543a:	5d                   	pop    %ebp
8010543b:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
8010543c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105441:	eb da                	jmp    8010541d <sys_sleep+0x7d>
80105443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	53                   	push   %ebx
80105454:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105457:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
8010545e:	e8 3d ee ff ff       	call   801042a0 <acquire>
  xticks = ticks;
80105463:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
  release(&tickslock);
80105469:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105470:	e8 9b ee ff ff       	call   80104310 <release>
  return xticks;
}
80105475:	83 c4 14             	add    $0x14,%esp
80105478:	89 d8                	mov    %ebx,%eax
8010547a:	5b                   	pop    %ebx
8010547b:	5d                   	pop    %ebp
8010547c:	c3                   	ret    

8010547d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010547d:	1e                   	push   %ds
  pushl %es
8010547e:	06                   	push   %es
  pushl %fs
8010547f:	0f a0                	push   %fs
  pushl %gs
80105481:	0f a8                	push   %gs
  pushal
80105483:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105484:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105488:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010548a:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010548c:	54                   	push   %esp
  call trap
8010548d:	e8 de 00 00 00       	call   80105570 <trap>
  addl $4, %esp
80105492:	83 c4 04             	add    $0x4,%esp

80105495 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105495:	61                   	popa   
  popl %gs
80105496:	0f a9                	pop    %gs
  popl %fs
80105498:	0f a1                	pop    %fs
  popl %es
8010549a:	07                   	pop    %es
  popl %ds
8010549b:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010549c:	83 c4 08             	add    $0x8,%esp
  iret
8010549f:	cf                   	iret   

801054a0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801054a0:	31 c0                	xor    %eax,%eax
801054a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801054a8:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801054af:	b9 08 00 00 00       	mov    $0x8,%ecx
801054b4:	66 89 0c c5 c2 4c 11 	mov    %cx,-0x7feeb33e(,%eax,8)
801054bb:	80 
801054bc:	c6 04 c5 c4 4c 11 80 	movb   $0x0,-0x7feeb33c(,%eax,8)
801054c3:	00 
801054c4:	c6 04 c5 c5 4c 11 80 	movb   $0x8e,-0x7feeb33b(,%eax,8)
801054cb:	8e 
801054cc:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
801054d3:	80 
801054d4:	c1 ea 10             	shr    $0x10,%edx
801054d7:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
801054de:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801054df:	83 c0 01             	add    $0x1,%eax
801054e2:	3d 00 01 00 00       	cmp    $0x100,%eax
801054e7:	75 bf                	jne    801054a8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801054e9:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801054ea:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801054ef:	89 e5                	mov    %esp,%ebp
801054f1:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801054f4:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
801054f9:	c7 44 24 04 39 74 10 	movl   $0x80107439,0x4(%esp)
80105500:	80 
80105501:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105508:	66 89 15 c2 4e 11 80 	mov    %dx,0x80114ec2
8010550f:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
80105515:	c1 e8 10             	shr    $0x10,%eax
80105518:	c6 05 c4 4e 11 80 00 	movb   $0x0,0x80114ec4
8010551f:	c6 05 c5 4e 11 80 ef 	movb   $0xef,0x80114ec5
80105526:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6

  initlock(&tickslock, "time");
8010552c:	e8 ff eb ff ff       	call   80104130 <initlock>
}
80105531:	c9                   	leave  
80105532:	c3                   	ret    
80105533:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105540 <idtinit>:

void
idtinit(void)
{
80105540:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105541:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105546:	89 e5                	mov    %esp,%ebp
80105548:	83 ec 10             	sub    $0x10,%esp
8010554b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010554f:	b8 c0 4c 11 80       	mov    $0x80114cc0,%eax
80105554:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105558:	c1 e8 10             	shr    $0x10,%eax
8010555b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010555f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105562:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105565:	c9                   	leave  
80105566:	c3                   	ret    
80105567:	89 f6                	mov    %esi,%esi
80105569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105570 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	56                   	push   %esi
80105575:	53                   	push   %ebx
80105576:	83 ec 3c             	sub    $0x3c,%esp
80105579:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010557c:	8b 43 30             	mov    0x30(%ebx),%eax
8010557f:	83 f8 40             	cmp    $0x40,%eax
80105582:	0f 84 a0 01 00 00    	je     80105728 <trap+0x1b8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105588:	83 e8 20             	sub    $0x20,%eax
8010558b:	83 f8 1f             	cmp    $0x1f,%eax
8010558e:	77 08                	ja     80105598 <trap+0x28>
80105590:	ff 24 85 e0 74 10 80 	jmp    *-0x7fef8b20(,%eax,4)
80105597:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105598:	e8 c3 e1 ff ff       	call   80103760 <myproc>
8010559d:	85 c0                	test   %eax,%eax
8010559f:	90                   	nop
801055a0:	0f 84 fa 01 00 00    	je     801057a0 <trap+0x230>
801055a6:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801055aa:	0f 84 f0 01 00 00    	je     801057a0 <trap+0x230>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801055b0:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055b3:	8b 53 38             	mov    0x38(%ebx),%edx
801055b6:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801055b9:	89 55 dc             	mov    %edx,-0x24(%ebp)
801055bc:	e8 7f e1 ff ff       	call   80103740 <cpuid>
801055c1:	8b 73 30             	mov    0x30(%ebx),%esi
801055c4:	89 c7                	mov    %eax,%edi
801055c6:	8b 43 34             	mov    0x34(%ebx),%eax
801055c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801055cc:	e8 8f e1 ff ff       	call   80103760 <myproc>
801055d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
801055d4:	e8 87 e1 ff ff       	call   80103760 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055d9:	8b 55 dc             	mov    -0x24(%ebp),%edx
801055dc:	89 74 24 0c          	mov    %esi,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801055e0:	8b 75 e0             	mov    -0x20(%ebp),%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055e3:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801055e6:	89 7c 24 14          	mov    %edi,0x14(%esp)
801055ea:	89 54 24 18          	mov    %edx,0x18(%esp)
801055ee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801055f1:	83 c6 6c             	add    $0x6c,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055f4:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801055f8:	89 74 24 08          	mov    %esi,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055fc:	89 54 24 10          	mov    %edx,0x10(%esp)
80105600:	8b 40 10             	mov    0x10(%eax),%eax
80105603:	c7 04 24 9c 74 10 80 	movl   $0x8010749c,(%esp)
8010560a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010560e:	e8 ed b0 ff ff       	call   80100700 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105613:	e8 48 e1 ff ff       	call   80103760 <myproc>
80105618:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010561f:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105620:	e8 3b e1 ff ff       	call   80103760 <myproc>
80105625:	85 c0                	test   %eax,%eax
80105627:	74 0c                	je     80105635 <trap+0xc5>
80105629:	e8 32 e1 ff ff       	call   80103760 <myproc>
8010562e:	8b 50 24             	mov    0x24(%eax),%edx
80105631:	85 d2                	test   %edx,%edx
80105633:	75 4b                	jne    80105680 <trap+0x110>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105635:	e8 26 e1 ff ff       	call   80103760 <myproc>
8010563a:	85 c0                	test   %eax,%eax
8010563c:	74 0d                	je     8010564b <trap+0xdb>
8010563e:	66 90                	xchg   %ax,%ax
80105640:	e8 1b e1 ff ff       	call   80103760 <myproc>
80105645:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105649:	74 4d                	je     80105698 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010564b:	e8 10 e1 ff ff       	call   80103760 <myproc>
80105650:	85 c0                	test   %eax,%eax
80105652:	74 1d                	je     80105671 <trap+0x101>
80105654:	e8 07 e1 ff ff       	call   80103760 <myproc>
80105659:	8b 40 24             	mov    0x24(%eax),%eax
8010565c:	85 c0                	test   %eax,%eax
8010565e:	74 11                	je     80105671 <trap+0x101>
80105660:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105664:	83 e0 03             	and    $0x3,%eax
80105667:	66 83 f8 03          	cmp    $0x3,%ax
8010566b:	0f 84 e8 00 00 00    	je     80105759 <trap+0x1e9>
    exit();
}
80105671:	83 c4 3c             	add    $0x3c,%esp
80105674:	5b                   	pop    %ebx
80105675:	5e                   	pop    %esi
80105676:	5f                   	pop    %edi
80105677:	5d                   	pop    %ebp
80105678:	c3                   	ret    
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105680:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105684:	83 e0 03             	and    $0x3,%eax
80105687:	66 83 f8 03          	cmp    $0x3,%ax
8010568b:	75 a8                	jne    80105635 <trap+0xc5>
    exit();
8010568d:	e8 ce e4 ff ff       	call   80103b60 <exit>
80105692:	eb a1                	jmp    80105635 <trap+0xc5>
80105694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105698:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010569c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056a0:	75 a9                	jne    8010564b <trap+0xdb>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
801056a2:	e8 d9 e5 ff ff       	call   80103c80 <yield>
801056a7:	eb a2                	jmp    8010564b <trap+0xdb>
801056a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
801056b0:	e8 8b e0 ff ff       	call   80103740 <cpuid>
801056b5:	85 c0                	test   %eax,%eax
801056b7:	0f 84 b3 00 00 00    	je     80105770 <trap+0x200>
801056bd:	8d 76 00             	lea    0x0(%esi),%esi
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
801056c0:	e8 7b d1 ff ff       	call   80102840 <lapiceoi>
    break;
801056c5:	e9 56 ff ff ff       	jmp    80105620 <trap+0xb0>
801056ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801056d0:	e8 cb cf ff ff       	call   801026a0 <kbdintr>
    lapiceoi();
801056d5:	e8 66 d1 ff ff       	call   80102840 <lapiceoi>
    break;
801056da:	e9 41 ff ff ff       	jmp    80105620 <trap+0xb0>
801056df:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801056e0:	e8 0b 02 00 00       	call   801058f0 <uartintr>
    lapiceoi();
801056e5:	e8 56 d1 ff ff       	call   80102840 <lapiceoi>
    break;
801056ea:	e9 31 ff ff ff       	jmp    80105620 <trap+0xb0>
801056ef:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801056f0:	8b 7b 38             	mov    0x38(%ebx),%edi
801056f3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801056f7:	e8 44 e0 ff ff       	call   80103740 <cpuid>
801056fc:	c7 04 24 44 74 10 80 	movl   $0x80107444,(%esp)
80105703:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105707:	89 74 24 08          	mov    %esi,0x8(%esp)
8010570b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010570f:	e8 ec af ff ff       	call   80100700 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105714:	e8 27 d1 ff ff       	call   80102840 <lapiceoi>
    break;
80105719:	e9 02 ff ff ff       	jmp    80105620 <trap+0xb0>
8010571e:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105720:	e8 2b ca ff ff       	call   80102150 <ideintr>
80105725:	eb 96                	jmp    801056bd <trap+0x14d>
80105727:	90                   	nop
80105728:	90                   	nop
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105730:	e8 2b e0 ff ff       	call   80103760 <myproc>
80105735:	8b 70 24             	mov    0x24(%eax),%esi
80105738:	85 f6                	test   %esi,%esi
8010573a:	75 2c                	jne    80105768 <trap+0x1f8>
      exit();
    myproc()->tf = tf;
8010573c:	e8 1f e0 ff ff       	call   80103760 <myproc>
80105741:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105744:	e8 d7 ef ff ff       	call   80104720 <syscall>
    if(myproc()->killed)
80105749:	e8 12 e0 ff ff       	call   80103760 <myproc>
8010574e:	8b 48 24             	mov    0x24(%eax),%ecx
80105751:	85 c9                	test   %ecx,%ecx
80105753:	0f 84 18 ff ff ff    	je     80105671 <trap+0x101>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105759:	83 c4 3c             	add    $0x3c,%esp
8010575c:	5b                   	pop    %ebx
8010575d:	5e                   	pop    %esi
8010575e:	5f                   	pop    %edi
8010575f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105760:	e9 fb e3 ff ff       	jmp    80103b60 <exit>
80105765:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105768:	e8 f3 e3 ff ff       	call   80103b60 <exit>
8010576d:	eb cd                	jmp    8010573c <trap+0x1cc>
8010576f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105770:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105777:	e8 24 eb ff ff       	call   801042a0 <acquire>
      ticks++;
      wakeup(&ticks);
8010577c:	c7 04 24 c0 54 11 80 	movl   $0x801154c0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105783:	83 05 c0 54 11 80 01 	addl   $0x1,0x801154c0
      wakeup(&ticks);
8010578a:	e8 c1 e6 ff ff       	call   80103e50 <wakeup>
      release(&tickslock);
8010578f:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105796:	e8 75 eb ff ff       	call   80104310 <release>
8010579b:	e9 1d ff ff ff       	jmp    801056bd <trap+0x14d>
801057a0:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801057a3:	8b 73 38             	mov    0x38(%ebx),%esi
801057a6:	e8 95 df ff ff       	call   80103740 <cpuid>
801057ab:	89 7c 24 10          	mov    %edi,0x10(%esp)
801057af:	89 74 24 0c          	mov    %esi,0xc(%esp)
801057b3:	89 44 24 08          	mov    %eax,0x8(%esp)
801057b7:	8b 43 30             	mov    0x30(%ebx),%eax
801057ba:	c7 04 24 68 74 10 80 	movl   $0x80107468,(%esp)
801057c1:	89 44 24 04          	mov    %eax,0x4(%esp)
801057c5:	e8 36 af ff ff       	call   80100700 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
801057ca:	c7 04 24 3e 74 10 80 	movl   $0x8010743e,(%esp)
801057d1:	e8 8a ab ff ff       	call   80100360 <panic>
801057d6:	66 90                	xchg   %ax,%ax
801057d8:	66 90                	xchg   %ax,%ax
801057da:	66 90                	xchg   %ax,%ax
801057dc:	66 90                	xchg   %ax,%ax
801057de:	66 90                	xchg   %ax,%ax

801057e0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801057e0:	a1 dc a5 10 80       	mov    0x8010a5dc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801057e5:	55                   	push   %ebp
801057e6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801057e8:	85 c0                	test   %eax,%eax
801057ea:	74 14                	je     80105800 <uartgetc+0x20>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801057ec:	ba fd 03 00 00       	mov    $0x3fd,%edx
801057f1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801057f2:	a8 01                	test   $0x1,%al
801057f4:	74 0a                	je     80105800 <uartgetc+0x20>
801057f6:	b2 f8                	mov    $0xf8,%dl
801057f8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801057f9:	0f b6 c0             	movzbl %al,%eax
}
801057fc:	5d                   	pop    %ebp
801057fd:	c3                   	ret    
801057fe:	66 90                	xchg   %ax,%ax

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105805:	5d                   	pop    %ebp
80105806:	c3                   	ret    
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105810 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105810:	a1 dc a5 10 80       	mov    0x8010a5dc,%eax
80105815:	85 c0                	test   %eax,%eax
80105817:	74 3f                	je     80105858 <uartputc+0x48>
    uartputc(*p);
}

void
uartputc(int c)
{
80105819:	55                   	push   %ebp
8010581a:	89 e5                	mov    %esp,%ebp
8010581c:	56                   	push   %esi
8010581d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105822:	53                   	push   %ebx
  int i;

  if(!uart)
80105823:	bb 80 00 00 00       	mov    $0x80,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
80105828:	83 ec 10             	sub    $0x10,%esp
8010582b:	eb 14                	jmp    80105841 <uartputc+0x31>
8010582d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105830:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105837:	e8 24 d0 ff ff       	call   80102860 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010583c:	83 eb 01             	sub    $0x1,%ebx
8010583f:	74 07                	je     80105848 <uartputc+0x38>
80105841:	89 f2                	mov    %esi,%edx
80105843:	ec                   	in     (%dx),%al
80105844:	a8 20                	test   $0x20,%al
80105846:	74 e8                	je     80105830 <uartputc+0x20>
    microdelay(10);
  outb(COM1+0, c);
80105848:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010584c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105851:	ee                   	out    %al,(%dx)
}
80105852:	83 c4 10             	add    $0x10,%esp
80105855:	5b                   	pop    %ebx
80105856:	5e                   	pop    %esi
80105857:	5d                   	pop    %ebp
80105858:	f3 c3                	repz ret 
8010585a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105860 <uartinit>:
80105860:	ba fa 03 00 00       	mov    $0x3fa,%edx
80105865:	31 c0                	xor    %eax,%eax
80105867:	ee                   	out    %al,(%dx)
80105868:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010586d:	b2 fb                	mov    $0xfb,%dl
8010586f:	ee                   	out    %al,(%dx)
80105870:	b8 0c 00 00 00       	mov    $0xc,%eax
80105875:	b2 f8                	mov    $0xf8,%dl
80105877:	ee                   	out    %al,(%dx)
80105878:	31 c0                	xor    %eax,%eax
8010587a:	b2 f9                	mov    $0xf9,%dl
8010587c:	ee                   	out    %al,(%dx)
8010587d:	b8 03 00 00 00       	mov    $0x3,%eax
80105882:	b2 fb                	mov    $0xfb,%dl
80105884:	ee                   	out    %al,(%dx)
80105885:	31 c0                	xor    %eax,%eax
80105887:	b2 fc                	mov    $0xfc,%dl
80105889:	ee                   	out    %al,(%dx)
8010588a:	b8 01 00 00 00       	mov    $0x1,%eax
8010588f:	b2 f9                	mov    $0xf9,%dl
80105891:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105892:	b2 fd                	mov    $0xfd,%dl
80105894:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105895:	3c ff                	cmp    $0xff,%al
80105897:	74 4e                	je     801058e7 <uartinit+0x87>

static int uart;    // is there a uart?

void
uartinit(void)
{
80105899:	55                   	push   %ebp
8010589a:	b2 fa                	mov    $0xfa,%dl
8010589c:	89 e5                	mov    %esp,%ebp
8010589e:	53                   	push   %ebx
8010589f:	83 ec 14             	sub    $0x14,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
  uart = 1;
801058a2:	c7 05 dc a5 10 80 01 	movl   $0x1,0x8010a5dc
801058a9:	00 00 00 
801058ac:	ec                   	in     (%dx),%al
801058ad:	b2 f8                	mov    $0xf8,%dl
801058af:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801058b0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801058b7:	00 

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801058b8:	bb 60 75 10 80       	mov    $0x80107560,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801058bd:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801058c4:	e8 b7 ca ff ff       	call   80102380 <ioapicenable>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801058c9:	b8 78 00 00 00       	mov    $0x78,%eax
801058ce:	66 90                	xchg   %ax,%ax
    uartputc(*p);
801058d0:	89 04 24             	mov    %eax,(%esp)
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801058d3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
801058d6:	e8 35 ff ff ff       	call   80105810 <uartputc>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801058db:	0f be 03             	movsbl (%ebx),%eax
801058de:	84 c0                	test   %al,%al
801058e0:	75 ee                	jne    801058d0 <uartinit+0x70>
    uartputc(*p);
}
801058e2:	83 c4 14             	add    $0x14,%esp
801058e5:	5b                   	pop    %ebx
801058e6:	5d                   	pop    %ebp
801058e7:	f3 c3                	repz ret 
801058e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058f0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801058f6:	c7 04 24 e0 57 10 80 	movl   $0x801057e0,(%esp)
801058fd:	e8 5e af ff ff       	call   80100860 <consoleintr>
}
80105902:	c9                   	leave  
80105903:	c3                   	ret    

80105904 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105904:	6a 00                	push   $0x0
  pushl $0
80105906:	6a 00                	push   $0x0
  jmp alltraps
80105908:	e9 70 fb ff ff       	jmp    8010547d <alltraps>

8010590d <vector1>:
.globl vector1
vector1:
  pushl $0
8010590d:	6a 00                	push   $0x0
  pushl $1
8010590f:	6a 01                	push   $0x1
  jmp alltraps
80105911:	e9 67 fb ff ff       	jmp    8010547d <alltraps>

80105916 <vector2>:
.globl vector2
vector2:
  pushl $0
80105916:	6a 00                	push   $0x0
  pushl $2
80105918:	6a 02                	push   $0x2
  jmp alltraps
8010591a:	e9 5e fb ff ff       	jmp    8010547d <alltraps>

8010591f <vector3>:
.globl vector3
vector3:
  pushl $0
8010591f:	6a 00                	push   $0x0
  pushl $3
80105921:	6a 03                	push   $0x3
  jmp alltraps
80105923:	e9 55 fb ff ff       	jmp    8010547d <alltraps>

80105928 <vector4>:
.globl vector4
vector4:
  pushl $0
80105928:	6a 00                	push   $0x0
  pushl $4
8010592a:	6a 04                	push   $0x4
  jmp alltraps
8010592c:	e9 4c fb ff ff       	jmp    8010547d <alltraps>

80105931 <vector5>:
.globl vector5
vector5:
  pushl $0
80105931:	6a 00                	push   $0x0
  pushl $5
80105933:	6a 05                	push   $0x5
  jmp alltraps
80105935:	e9 43 fb ff ff       	jmp    8010547d <alltraps>

8010593a <vector6>:
.globl vector6
vector6:
  pushl $0
8010593a:	6a 00                	push   $0x0
  pushl $6
8010593c:	6a 06                	push   $0x6
  jmp alltraps
8010593e:	e9 3a fb ff ff       	jmp    8010547d <alltraps>

80105943 <vector7>:
.globl vector7
vector7:
  pushl $0
80105943:	6a 00                	push   $0x0
  pushl $7
80105945:	6a 07                	push   $0x7
  jmp alltraps
80105947:	e9 31 fb ff ff       	jmp    8010547d <alltraps>

8010594c <vector8>:
.globl vector8
vector8:
  pushl $8
8010594c:	6a 08                	push   $0x8
  jmp alltraps
8010594e:	e9 2a fb ff ff       	jmp    8010547d <alltraps>

80105953 <vector9>:
.globl vector9
vector9:
  pushl $0
80105953:	6a 00                	push   $0x0
  pushl $9
80105955:	6a 09                	push   $0x9
  jmp alltraps
80105957:	e9 21 fb ff ff       	jmp    8010547d <alltraps>

8010595c <vector10>:
.globl vector10
vector10:
  pushl $10
8010595c:	6a 0a                	push   $0xa
  jmp alltraps
8010595e:	e9 1a fb ff ff       	jmp    8010547d <alltraps>

80105963 <vector11>:
.globl vector11
vector11:
  pushl $11
80105963:	6a 0b                	push   $0xb
  jmp alltraps
80105965:	e9 13 fb ff ff       	jmp    8010547d <alltraps>

8010596a <vector12>:
.globl vector12
vector12:
  pushl $12
8010596a:	6a 0c                	push   $0xc
  jmp alltraps
8010596c:	e9 0c fb ff ff       	jmp    8010547d <alltraps>

80105971 <vector13>:
.globl vector13
vector13:
  pushl $13
80105971:	6a 0d                	push   $0xd
  jmp alltraps
80105973:	e9 05 fb ff ff       	jmp    8010547d <alltraps>

80105978 <vector14>:
.globl vector14
vector14:
  pushl $14
80105978:	6a 0e                	push   $0xe
  jmp alltraps
8010597a:	e9 fe fa ff ff       	jmp    8010547d <alltraps>

8010597f <vector15>:
.globl vector15
vector15:
  pushl $0
8010597f:	6a 00                	push   $0x0
  pushl $15
80105981:	6a 0f                	push   $0xf
  jmp alltraps
80105983:	e9 f5 fa ff ff       	jmp    8010547d <alltraps>

80105988 <vector16>:
.globl vector16
vector16:
  pushl $0
80105988:	6a 00                	push   $0x0
  pushl $16
8010598a:	6a 10                	push   $0x10
  jmp alltraps
8010598c:	e9 ec fa ff ff       	jmp    8010547d <alltraps>

80105991 <vector17>:
.globl vector17
vector17:
  pushl $17
80105991:	6a 11                	push   $0x11
  jmp alltraps
80105993:	e9 e5 fa ff ff       	jmp    8010547d <alltraps>

80105998 <vector18>:
.globl vector18
vector18:
  pushl $0
80105998:	6a 00                	push   $0x0
  pushl $18
8010599a:	6a 12                	push   $0x12
  jmp alltraps
8010599c:	e9 dc fa ff ff       	jmp    8010547d <alltraps>

801059a1 <vector19>:
.globl vector19
vector19:
  pushl $0
801059a1:	6a 00                	push   $0x0
  pushl $19
801059a3:	6a 13                	push   $0x13
  jmp alltraps
801059a5:	e9 d3 fa ff ff       	jmp    8010547d <alltraps>

801059aa <vector20>:
.globl vector20
vector20:
  pushl $0
801059aa:	6a 00                	push   $0x0
  pushl $20
801059ac:	6a 14                	push   $0x14
  jmp alltraps
801059ae:	e9 ca fa ff ff       	jmp    8010547d <alltraps>

801059b3 <vector21>:
.globl vector21
vector21:
  pushl $0
801059b3:	6a 00                	push   $0x0
  pushl $21
801059b5:	6a 15                	push   $0x15
  jmp alltraps
801059b7:	e9 c1 fa ff ff       	jmp    8010547d <alltraps>

801059bc <vector22>:
.globl vector22
vector22:
  pushl $0
801059bc:	6a 00                	push   $0x0
  pushl $22
801059be:	6a 16                	push   $0x16
  jmp alltraps
801059c0:	e9 b8 fa ff ff       	jmp    8010547d <alltraps>

801059c5 <vector23>:
.globl vector23
vector23:
  pushl $0
801059c5:	6a 00                	push   $0x0
  pushl $23
801059c7:	6a 17                	push   $0x17
  jmp alltraps
801059c9:	e9 af fa ff ff       	jmp    8010547d <alltraps>

801059ce <vector24>:
.globl vector24
vector24:
  pushl $0
801059ce:	6a 00                	push   $0x0
  pushl $24
801059d0:	6a 18                	push   $0x18
  jmp alltraps
801059d2:	e9 a6 fa ff ff       	jmp    8010547d <alltraps>

801059d7 <vector25>:
.globl vector25
vector25:
  pushl $0
801059d7:	6a 00                	push   $0x0
  pushl $25
801059d9:	6a 19                	push   $0x19
  jmp alltraps
801059db:	e9 9d fa ff ff       	jmp    8010547d <alltraps>

801059e0 <vector26>:
.globl vector26
vector26:
  pushl $0
801059e0:	6a 00                	push   $0x0
  pushl $26
801059e2:	6a 1a                	push   $0x1a
  jmp alltraps
801059e4:	e9 94 fa ff ff       	jmp    8010547d <alltraps>

801059e9 <vector27>:
.globl vector27
vector27:
  pushl $0
801059e9:	6a 00                	push   $0x0
  pushl $27
801059eb:	6a 1b                	push   $0x1b
  jmp alltraps
801059ed:	e9 8b fa ff ff       	jmp    8010547d <alltraps>

801059f2 <vector28>:
.globl vector28
vector28:
  pushl $0
801059f2:	6a 00                	push   $0x0
  pushl $28
801059f4:	6a 1c                	push   $0x1c
  jmp alltraps
801059f6:	e9 82 fa ff ff       	jmp    8010547d <alltraps>

801059fb <vector29>:
.globl vector29
vector29:
  pushl $0
801059fb:	6a 00                	push   $0x0
  pushl $29
801059fd:	6a 1d                	push   $0x1d
  jmp alltraps
801059ff:	e9 79 fa ff ff       	jmp    8010547d <alltraps>

80105a04 <vector30>:
.globl vector30
vector30:
  pushl $0
80105a04:	6a 00                	push   $0x0
  pushl $30
80105a06:	6a 1e                	push   $0x1e
  jmp alltraps
80105a08:	e9 70 fa ff ff       	jmp    8010547d <alltraps>

80105a0d <vector31>:
.globl vector31
vector31:
  pushl $0
80105a0d:	6a 00                	push   $0x0
  pushl $31
80105a0f:	6a 1f                	push   $0x1f
  jmp alltraps
80105a11:	e9 67 fa ff ff       	jmp    8010547d <alltraps>

80105a16 <vector32>:
.globl vector32
vector32:
  pushl $0
80105a16:	6a 00                	push   $0x0
  pushl $32
80105a18:	6a 20                	push   $0x20
  jmp alltraps
80105a1a:	e9 5e fa ff ff       	jmp    8010547d <alltraps>

80105a1f <vector33>:
.globl vector33
vector33:
  pushl $0
80105a1f:	6a 00                	push   $0x0
  pushl $33
80105a21:	6a 21                	push   $0x21
  jmp alltraps
80105a23:	e9 55 fa ff ff       	jmp    8010547d <alltraps>

80105a28 <vector34>:
.globl vector34
vector34:
  pushl $0
80105a28:	6a 00                	push   $0x0
  pushl $34
80105a2a:	6a 22                	push   $0x22
  jmp alltraps
80105a2c:	e9 4c fa ff ff       	jmp    8010547d <alltraps>

80105a31 <vector35>:
.globl vector35
vector35:
  pushl $0
80105a31:	6a 00                	push   $0x0
  pushl $35
80105a33:	6a 23                	push   $0x23
  jmp alltraps
80105a35:	e9 43 fa ff ff       	jmp    8010547d <alltraps>

80105a3a <vector36>:
.globl vector36
vector36:
  pushl $0
80105a3a:	6a 00                	push   $0x0
  pushl $36
80105a3c:	6a 24                	push   $0x24
  jmp alltraps
80105a3e:	e9 3a fa ff ff       	jmp    8010547d <alltraps>

80105a43 <vector37>:
.globl vector37
vector37:
  pushl $0
80105a43:	6a 00                	push   $0x0
  pushl $37
80105a45:	6a 25                	push   $0x25
  jmp alltraps
80105a47:	e9 31 fa ff ff       	jmp    8010547d <alltraps>

80105a4c <vector38>:
.globl vector38
vector38:
  pushl $0
80105a4c:	6a 00                	push   $0x0
  pushl $38
80105a4e:	6a 26                	push   $0x26
  jmp alltraps
80105a50:	e9 28 fa ff ff       	jmp    8010547d <alltraps>

80105a55 <vector39>:
.globl vector39
vector39:
  pushl $0
80105a55:	6a 00                	push   $0x0
  pushl $39
80105a57:	6a 27                	push   $0x27
  jmp alltraps
80105a59:	e9 1f fa ff ff       	jmp    8010547d <alltraps>

80105a5e <vector40>:
.globl vector40
vector40:
  pushl $0
80105a5e:	6a 00                	push   $0x0
  pushl $40
80105a60:	6a 28                	push   $0x28
  jmp alltraps
80105a62:	e9 16 fa ff ff       	jmp    8010547d <alltraps>

80105a67 <vector41>:
.globl vector41
vector41:
  pushl $0
80105a67:	6a 00                	push   $0x0
  pushl $41
80105a69:	6a 29                	push   $0x29
  jmp alltraps
80105a6b:	e9 0d fa ff ff       	jmp    8010547d <alltraps>

80105a70 <vector42>:
.globl vector42
vector42:
  pushl $0
80105a70:	6a 00                	push   $0x0
  pushl $42
80105a72:	6a 2a                	push   $0x2a
  jmp alltraps
80105a74:	e9 04 fa ff ff       	jmp    8010547d <alltraps>

80105a79 <vector43>:
.globl vector43
vector43:
  pushl $0
80105a79:	6a 00                	push   $0x0
  pushl $43
80105a7b:	6a 2b                	push   $0x2b
  jmp alltraps
80105a7d:	e9 fb f9 ff ff       	jmp    8010547d <alltraps>

80105a82 <vector44>:
.globl vector44
vector44:
  pushl $0
80105a82:	6a 00                	push   $0x0
  pushl $44
80105a84:	6a 2c                	push   $0x2c
  jmp alltraps
80105a86:	e9 f2 f9 ff ff       	jmp    8010547d <alltraps>

80105a8b <vector45>:
.globl vector45
vector45:
  pushl $0
80105a8b:	6a 00                	push   $0x0
  pushl $45
80105a8d:	6a 2d                	push   $0x2d
  jmp alltraps
80105a8f:	e9 e9 f9 ff ff       	jmp    8010547d <alltraps>

80105a94 <vector46>:
.globl vector46
vector46:
  pushl $0
80105a94:	6a 00                	push   $0x0
  pushl $46
80105a96:	6a 2e                	push   $0x2e
  jmp alltraps
80105a98:	e9 e0 f9 ff ff       	jmp    8010547d <alltraps>

80105a9d <vector47>:
.globl vector47
vector47:
  pushl $0
80105a9d:	6a 00                	push   $0x0
  pushl $47
80105a9f:	6a 2f                	push   $0x2f
  jmp alltraps
80105aa1:	e9 d7 f9 ff ff       	jmp    8010547d <alltraps>

80105aa6 <vector48>:
.globl vector48
vector48:
  pushl $0
80105aa6:	6a 00                	push   $0x0
  pushl $48
80105aa8:	6a 30                	push   $0x30
  jmp alltraps
80105aaa:	e9 ce f9 ff ff       	jmp    8010547d <alltraps>

80105aaf <vector49>:
.globl vector49
vector49:
  pushl $0
80105aaf:	6a 00                	push   $0x0
  pushl $49
80105ab1:	6a 31                	push   $0x31
  jmp alltraps
80105ab3:	e9 c5 f9 ff ff       	jmp    8010547d <alltraps>

80105ab8 <vector50>:
.globl vector50
vector50:
  pushl $0
80105ab8:	6a 00                	push   $0x0
  pushl $50
80105aba:	6a 32                	push   $0x32
  jmp alltraps
80105abc:	e9 bc f9 ff ff       	jmp    8010547d <alltraps>

80105ac1 <vector51>:
.globl vector51
vector51:
  pushl $0
80105ac1:	6a 00                	push   $0x0
  pushl $51
80105ac3:	6a 33                	push   $0x33
  jmp alltraps
80105ac5:	e9 b3 f9 ff ff       	jmp    8010547d <alltraps>

80105aca <vector52>:
.globl vector52
vector52:
  pushl $0
80105aca:	6a 00                	push   $0x0
  pushl $52
80105acc:	6a 34                	push   $0x34
  jmp alltraps
80105ace:	e9 aa f9 ff ff       	jmp    8010547d <alltraps>

80105ad3 <vector53>:
.globl vector53
vector53:
  pushl $0
80105ad3:	6a 00                	push   $0x0
  pushl $53
80105ad5:	6a 35                	push   $0x35
  jmp alltraps
80105ad7:	e9 a1 f9 ff ff       	jmp    8010547d <alltraps>

80105adc <vector54>:
.globl vector54
vector54:
  pushl $0
80105adc:	6a 00                	push   $0x0
  pushl $54
80105ade:	6a 36                	push   $0x36
  jmp alltraps
80105ae0:	e9 98 f9 ff ff       	jmp    8010547d <alltraps>

80105ae5 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ae5:	6a 00                	push   $0x0
  pushl $55
80105ae7:	6a 37                	push   $0x37
  jmp alltraps
80105ae9:	e9 8f f9 ff ff       	jmp    8010547d <alltraps>

80105aee <vector56>:
.globl vector56
vector56:
  pushl $0
80105aee:	6a 00                	push   $0x0
  pushl $56
80105af0:	6a 38                	push   $0x38
  jmp alltraps
80105af2:	e9 86 f9 ff ff       	jmp    8010547d <alltraps>

80105af7 <vector57>:
.globl vector57
vector57:
  pushl $0
80105af7:	6a 00                	push   $0x0
  pushl $57
80105af9:	6a 39                	push   $0x39
  jmp alltraps
80105afb:	e9 7d f9 ff ff       	jmp    8010547d <alltraps>

80105b00 <vector58>:
.globl vector58
vector58:
  pushl $0
80105b00:	6a 00                	push   $0x0
  pushl $58
80105b02:	6a 3a                	push   $0x3a
  jmp alltraps
80105b04:	e9 74 f9 ff ff       	jmp    8010547d <alltraps>

80105b09 <vector59>:
.globl vector59
vector59:
  pushl $0
80105b09:	6a 00                	push   $0x0
  pushl $59
80105b0b:	6a 3b                	push   $0x3b
  jmp alltraps
80105b0d:	e9 6b f9 ff ff       	jmp    8010547d <alltraps>

80105b12 <vector60>:
.globl vector60
vector60:
  pushl $0
80105b12:	6a 00                	push   $0x0
  pushl $60
80105b14:	6a 3c                	push   $0x3c
  jmp alltraps
80105b16:	e9 62 f9 ff ff       	jmp    8010547d <alltraps>

80105b1b <vector61>:
.globl vector61
vector61:
  pushl $0
80105b1b:	6a 00                	push   $0x0
  pushl $61
80105b1d:	6a 3d                	push   $0x3d
  jmp alltraps
80105b1f:	e9 59 f9 ff ff       	jmp    8010547d <alltraps>

80105b24 <vector62>:
.globl vector62
vector62:
  pushl $0
80105b24:	6a 00                	push   $0x0
  pushl $62
80105b26:	6a 3e                	push   $0x3e
  jmp alltraps
80105b28:	e9 50 f9 ff ff       	jmp    8010547d <alltraps>

80105b2d <vector63>:
.globl vector63
vector63:
  pushl $0
80105b2d:	6a 00                	push   $0x0
  pushl $63
80105b2f:	6a 3f                	push   $0x3f
  jmp alltraps
80105b31:	e9 47 f9 ff ff       	jmp    8010547d <alltraps>

80105b36 <vector64>:
.globl vector64
vector64:
  pushl $0
80105b36:	6a 00                	push   $0x0
  pushl $64
80105b38:	6a 40                	push   $0x40
  jmp alltraps
80105b3a:	e9 3e f9 ff ff       	jmp    8010547d <alltraps>

80105b3f <vector65>:
.globl vector65
vector65:
  pushl $0
80105b3f:	6a 00                	push   $0x0
  pushl $65
80105b41:	6a 41                	push   $0x41
  jmp alltraps
80105b43:	e9 35 f9 ff ff       	jmp    8010547d <alltraps>

80105b48 <vector66>:
.globl vector66
vector66:
  pushl $0
80105b48:	6a 00                	push   $0x0
  pushl $66
80105b4a:	6a 42                	push   $0x42
  jmp alltraps
80105b4c:	e9 2c f9 ff ff       	jmp    8010547d <alltraps>

80105b51 <vector67>:
.globl vector67
vector67:
  pushl $0
80105b51:	6a 00                	push   $0x0
  pushl $67
80105b53:	6a 43                	push   $0x43
  jmp alltraps
80105b55:	e9 23 f9 ff ff       	jmp    8010547d <alltraps>

80105b5a <vector68>:
.globl vector68
vector68:
  pushl $0
80105b5a:	6a 00                	push   $0x0
  pushl $68
80105b5c:	6a 44                	push   $0x44
  jmp alltraps
80105b5e:	e9 1a f9 ff ff       	jmp    8010547d <alltraps>

80105b63 <vector69>:
.globl vector69
vector69:
  pushl $0
80105b63:	6a 00                	push   $0x0
  pushl $69
80105b65:	6a 45                	push   $0x45
  jmp alltraps
80105b67:	e9 11 f9 ff ff       	jmp    8010547d <alltraps>

80105b6c <vector70>:
.globl vector70
vector70:
  pushl $0
80105b6c:	6a 00                	push   $0x0
  pushl $70
80105b6e:	6a 46                	push   $0x46
  jmp alltraps
80105b70:	e9 08 f9 ff ff       	jmp    8010547d <alltraps>

80105b75 <vector71>:
.globl vector71
vector71:
  pushl $0
80105b75:	6a 00                	push   $0x0
  pushl $71
80105b77:	6a 47                	push   $0x47
  jmp alltraps
80105b79:	e9 ff f8 ff ff       	jmp    8010547d <alltraps>

80105b7e <vector72>:
.globl vector72
vector72:
  pushl $0
80105b7e:	6a 00                	push   $0x0
  pushl $72
80105b80:	6a 48                	push   $0x48
  jmp alltraps
80105b82:	e9 f6 f8 ff ff       	jmp    8010547d <alltraps>

80105b87 <vector73>:
.globl vector73
vector73:
  pushl $0
80105b87:	6a 00                	push   $0x0
  pushl $73
80105b89:	6a 49                	push   $0x49
  jmp alltraps
80105b8b:	e9 ed f8 ff ff       	jmp    8010547d <alltraps>

80105b90 <vector74>:
.globl vector74
vector74:
  pushl $0
80105b90:	6a 00                	push   $0x0
  pushl $74
80105b92:	6a 4a                	push   $0x4a
  jmp alltraps
80105b94:	e9 e4 f8 ff ff       	jmp    8010547d <alltraps>

80105b99 <vector75>:
.globl vector75
vector75:
  pushl $0
80105b99:	6a 00                	push   $0x0
  pushl $75
80105b9b:	6a 4b                	push   $0x4b
  jmp alltraps
80105b9d:	e9 db f8 ff ff       	jmp    8010547d <alltraps>

80105ba2 <vector76>:
.globl vector76
vector76:
  pushl $0
80105ba2:	6a 00                	push   $0x0
  pushl $76
80105ba4:	6a 4c                	push   $0x4c
  jmp alltraps
80105ba6:	e9 d2 f8 ff ff       	jmp    8010547d <alltraps>

80105bab <vector77>:
.globl vector77
vector77:
  pushl $0
80105bab:	6a 00                	push   $0x0
  pushl $77
80105bad:	6a 4d                	push   $0x4d
  jmp alltraps
80105baf:	e9 c9 f8 ff ff       	jmp    8010547d <alltraps>

80105bb4 <vector78>:
.globl vector78
vector78:
  pushl $0
80105bb4:	6a 00                	push   $0x0
  pushl $78
80105bb6:	6a 4e                	push   $0x4e
  jmp alltraps
80105bb8:	e9 c0 f8 ff ff       	jmp    8010547d <alltraps>

80105bbd <vector79>:
.globl vector79
vector79:
  pushl $0
80105bbd:	6a 00                	push   $0x0
  pushl $79
80105bbf:	6a 4f                	push   $0x4f
  jmp alltraps
80105bc1:	e9 b7 f8 ff ff       	jmp    8010547d <alltraps>

80105bc6 <vector80>:
.globl vector80
vector80:
  pushl $0
80105bc6:	6a 00                	push   $0x0
  pushl $80
80105bc8:	6a 50                	push   $0x50
  jmp alltraps
80105bca:	e9 ae f8 ff ff       	jmp    8010547d <alltraps>

80105bcf <vector81>:
.globl vector81
vector81:
  pushl $0
80105bcf:	6a 00                	push   $0x0
  pushl $81
80105bd1:	6a 51                	push   $0x51
  jmp alltraps
80105bd3:	e9 a5 f8 ff ff       	jmp    8010547d <alltraps>

80105bd8 <vector82>:
.globl vector82
vector82:
  pushl $0
80105bd8:	6a 00                	push   $0x0
  pushl $82
80105bda:	6a 52                	push   $0x52
  jmp alltraps
80105bdc:	e9 9c f8 ff ff       	jmp    8010547d <alltraps>

80105be1 <vector83>:
.globl vector83
vector83:
  pushl $0
80105be1:	6a 00                	push   $0x0
  pushl $83
80105be3:	6a 53                	push   $0x53
  jmp alltraps
80105be5:	e9 93 f8 ff ff       	jmp    8010547d <alltraps>

80105bea <vector84>:
.globl vector84
vector84:
  pushl $0
80105bea:	6a 00                	push   $0x0
  pushl $84
80105bec:	6a 54                	push   $0x54
  jmp alltraps
80105bee:	e9 8a f8 ff ff       	jmp    8010547d <alltraps>

80105bf3 <vector85>:
.globl vector85
vector85:
  pushl $0
80105bf3:	6a 00                	push   $0x0
  pushl $85
80105bf5:	6a 55                	push   $0x55
  jmp alltraps
80105bf7:	e9 81 f8 ff ff       	jmp    8010547d <alltraps>

80105bfc <vector86>:
.globl vector86
vector86:
  pushl $0
80105bfc:	6a 00                	push   $0x0
  pushl $86
80105bfe:	6a 56                	push   $0x56
  jmp alltraps
80105c00:	e9 78 f8 ff ff       	jmp    8010547d <alltraps>

80105c05 <vector87>:
.globl vector87
vector87:
  pushl $0
80105c05:	6a 00                	push   $0x0
  pushl $87
80105c07:	6a 57                	push   $0x57
  jmp alltraps
80105c09:	e9 6f f8 ff ff       	jmp    8010547d <alltraps>

80105c0e <vector88>:
.globl vector88
vector88:
  pushl $0
80105c0e:	6a 00                	push   $0x0
  pushl $88
80105c10:	6a 58                	push   $0x58
  jmp alltraps
80105c12:	e9 66 f8 ff ff       	jmp    8010547d <alltraps>

80105c17 <vector89>:
.globl vector89
vector89:
  pushl $0
80105c17:	6a 00                	push   $0x0
  pushl $89
80105c19:	6a 59                	push   $0x59
  jmp alltraps
80105c1b:	e9 5d f8 ff ff       	jmp    8010547d <alltraps>

80105c20 <vector90>:
.globl vector90
vector90:
  pushl $0
80105c20:	6a 00                	push   $0x0
  pushl $90
80105c22:	6a 5a                	push   $0x5a
  jmp alltraps
80105c24:	e9 54 f8 ff ff       	jmp    8010547d <alltraps>

80105c29 <vector91>:
.globl vector91
vector91:
  pushl $0
80105c29:	6a 00                	push   $0x0
  pushl $91
80105c2b:	6a 5b                	push   $0x5b
  jmp alltraps
80105c2d:	e9 4b f8 ff ff       	jmp    8010547d <alltraps>

80105c32 <vector92>:
.globl vector92
vector92:
  pushl $0
80105c32:	6a 00                	push   $0x0
  pushl $92
80105c34:	6a 5c                	push   $0x5c
  jmp alltraps
80105c36:	e9 42 f8 ff ff       	jmp    8010547d <alltraps>

80105c3b <vector93>:
.globl vector93
vector93:
  pushl $0
80105c3b:	6a 00                	push   $0x0
  pushl $93
80105c3d:	6a 5d                	push   $0x5d
  jmp alltraps
80105c3f:	e9 39 f8 ff ff       	jmp    8010547d <alltraps>

80105c44 <vector94>:
.globl vector94
vector94:
  pushl $0
80105c44:	6a 00                	push   $0x0
  pushl $94
80105c46:	6a 5e                	push   $0x5e
  jmp alltraps
80105c48:	e9 30 f8 ff ff       	jmp    8010547d <alltraps>

80105c4d <vector95>:
.globl vector95
vector95:
  pushl $0
80105c4d:	6a 00                	push   $0x0
  pushl $95
80105c4f:	6a 5f                	push   $0x5f
  jmp alltraps
80105c51:	e9 27 f8 ff ff       	jmp    8010547d <alltraps>

80105c56 <vector96>:
.globl vector96
vector96:
  pushl $0
80105c56:	6a 00                	push   $0x0
  pushl $96
80105c58:	6a 60                	push   $0x60
  jmp alltraps
80105c5a:	e9 1e f8 ff ff       	jmp    8010547d <alltraps>

80105c5f <vector97>:
.globl vector97
vector97:
  pushl $0
80105c5f:	6a 00                	push   $0x0
  pushl $97
80105c61:	6a 61                	push   $0x61
  jmp alltraps
80105c63:	e9 15 f8 ff ff       	jmp    8010547d <alltraps>

80105c68 <vector98>:
.globl vector98
vector98:
  pushl $0
80105c68:	6a 00                	push   $0x0
  pushl $98
80105c6a:	6a 62                	push   $0x62
  jmp alltraps
80105c6c:	e9 0c f8 ff ff       	jmp    8010547d <alltraps>

80105c71 <vector99>:
.globl vector99
vector99:
  pushl $0
80105c71:	6a 00                	push   $0x0
  pushl $99
80105c73:	6a 63                	push   $0x63
  jmp alltraps
80105c75:	e9 03 f8 ff ff       	jmp    8010547d <alltraps>

80105c7a <vector100>:
.globl vector100
vector100:
  pushl $0
80105c7a:	6a 00                	push   $0x0
  pushl $100
80105c7c:	6a 64                	push   $0x64
  jmp alltraps
80105c7e:	e9 fa f7 ff ff       	jmp    8010547d <alltraps>

80105c83 <vector101>:
.globl vector101
vector101:
  pushl $0
80105c83:	6a 00                	push   $0x0
  pushl $101
80105c85:	6a 65                	push   $0x65
  jmp alltraps
80105c87:	e9 f1 f7 ff ff       	jmp    8010547d <alltraps>

80105c8c <vector102>:
.globl vector102
vector102:
  pushl $0
80105c8c:	6a 00                	push   $0x0
  pushl $102
80105c8e:	6a 66                	push   $0x66
  jmp alltraps
80105c90:	e9 e8 f7 ff ff       	jmp    8010547d <alltraps>

80105c95 <vector103>:
.globl vector103
vector103:
  pushl $0
80105c95:	6a 00                	push   $0x0
  pushl $103
80105c97:	6a 67                	push   $0x67
  jmp alltraps
80105c99:	e9 df f7 ff ff       	jmp    8010547d <alltraps>

80105c9e <vector104>:
.globl vector104
vector104:
  pushl $0
80105c9e:	6a 00                	push   $0x0
  pushl $104
80105ca0:	6a 68                	push   $0x68
  jmp alltraps
80105ca2:	e9 d6 f7 ff ff       	jmp    8010547d <alltraps>

80105ca7 <vector105>:
.globl vector105
vector105:
  pushl $0
80105ca7:	6a 00                	push   $0x0
  pushl $105
80105ca9:	6a 69                	push   $0x69
  jmp alltraps
80105cab:	e9 cd f7 ff ff       	jmp    8010547d <alltraps>

80105cb0 <vector106>:
.globl vector106
vector106:
  pushl $0
80105cb0:	6a 00                	push   $0x0
  pushl $106
80105cb2:	6a 6a                	push   $0x6a
  jmp alltraps
80105cb4:	e9 c4 f7 ff ff       	jmp    8010547d <alltraps>

80105cb9 <vector107>:
.globl vector107
vector107:
  pushl $0
80105cb9:	6a 00                	push   $0x0
  pushl $107
80105cbb:	6a 6b                	push   $0x6b
  jmp alltraps
80105cbd:	e9 bb f7 ff ff       	jmp    8010547d <alltraps>

80105cc2 <vector108>:
.globl vector108
vector108:
  pushl $0
80105cc2:	6a 00                	push   $0x0
  pushl $108
80105cc4:	6a 6c                	push   $0x6c
  jmp alltraps
80105cc6:	e9 b2 f7 ff ff       	jmp    8010547d <alltraps>

80105ccb <vector109>:
.globl vector109
vector109:
  pushl $0
80105ccb:	6a 00                	push   $0x0
  pushl $109
80105ccd:	6a 6d                	push   $0x6d
  jmp alltraps
80105ccf:	e9 a9 f7 ff ff       	jmp    8010547d <alltraps>

80105cd4 <vector110>:
.globl vector110
vector110:
  pushl $0
80105cd4:	6a 00                	push   $0x0
  pushl $110
80105cd6:	6a 6e                	push   $0x6e
  jmp alltraps
80105cd8:	e9 a0 f7 ff ff       	jmp    8010547d <alltraps>

80105cdd <vector111>:
.globl vector111
vector111:
  pushl $0
80105cdd:	6a 00                	push   $0x0
  pushl $111
80105cdf:	6a 6f                	push   $0x6f
  jmp alltraps
80105ce1:	e9 97 f7 ff ff       	jmp    8010547d <alltraps>

80105ce6 <vector112>:
.globl vector112
vector112:
  pushl $0
80105ce6:	6a 00                	push   $0x0
  pushl $112
80105ce8:	6a 70                	push   $0x70
  jmp alltraps
80105cea:	e9 8e f7 ff ff       	jmp    8010547d <alltraps>

80105cef <vector113>:
.globl vector113
vector113:
  pushl $0
80105cef:	6a 00                	push   $0x0
  pushl $113
80105cf1:	6a 71                	push   $0x71
  jmp alltraps
80105cf3:	e9 85 f7 ff ff       	jmp    8010547d <alltraps>

80105cf8 <vector114>:
.globl vector114
vector114:
  pushl $0
80105cf8:	6a 00                	push   $0x0
  pushl $114
80105cfa:	6a 72                	push   $0x72
  jmp alltraps
80105cfc:	e9 7c f7 ff ff       	jmp    8010547d <alltraps>

80105d01 <vector115>:
.globl vector115
vector115:
  pushl $0
80105d01:	6a 00                	push   $0x0
  pushl $115
80105d03:	6a 73                	push   $0x73
  jmp alltraps
80105d05:	e9 73 f7 ff ff       	jmp    8010547d <alltraps>

80105d0a <vector116>:
.globl vector116
vector116:
  pushl $0
80105d0a:	6a 00                	push   $0x0
  pushl $116
80105d0c:	6a 74                	push   $0x74
  jmp alltraps
80105d0e:	e9 6a f7 ff ff       	jmp    8010547d <alltraps>

80105d13 <vector117>:
.globl vector117
vector117:
  pushl $0
80105d13:	6a 00                	push   $0x0
  pushl $117
80105d15:	6a 75                	push   $0x75
  jmp alltraps
80105d17:	e9 61 f7 ff ff       	jmp    8010547d <alltraps>

80105d1c <vector118>:
.globl vector118
vector118:
  pushl $0
80105d1c:	6a 00                	push   $0x0
  pushl $118
80105d1e:	6a 76                	push   $0x76
  jmp alltraps
80105d20:	e9 58 f7 ff ff       	jmp    8010547d <alltraps>

80105d25 <vector119>:
.globl vector119
vector119:
  pushl $0
80105d25:	6a 00                	push   $0x0
  pushl $119
80105d27:	6a 77                	push   $0x77
  jmp alltraps
80105d29:	e9 4f f7 ff ff       	jmp    8010547d <alltraps>

80105d2e <vector120>:
.globl vector120
vector120:
  pushl $0
80105d2e:	6a 00                	push   $0x0
  pushl $120
80105d30:	6a 78                	push   $0x78
  jmp alltraps
80105d32:	e9 46 f7 ff ff       	jmp    8010547d <alltraps>

80105d37 <vector121>:
.globl vector121
vector121:
  pushl $0
80105d37:	6a 00                	push   $0x0
  pushl $121
80105d39:	6a 79                	push   $0x79
  jmp alltraps
80105d3b:	e9 3d f7 ff ff       	jmp    8010547d <alltraps>

80105d40 <vector122>:
.globl vector122
vector122:
  pushl $0
80105d40:	6a 00                	push   $0x0
  pushl $122
80105d42:	6a 7a                	push   $0x7a
  jmp alltraps
80105d44:	e9 34 f7 ff ff       	jmp    8010547d <alltraps>

80105d49 <vector123>:
.globl vector123
vector123:
  pushl $0
80105d49:	6a 00                	push   $0x0
  pushl $123
80105d4b:	6a 7b                	push   $0x7b
  jmp alltraps
80105d4d:	e9 2b f7 ff ff       	jmp    8010547d <alltraps>

80105d52 <vector124>:
.globl vector124
vector124:
  pushl $0
80105d52:	6a 00                	push   $0x0
  pushl $124
80105d54:	6a 7c                	push   $0x7c
  jmp alltraps
80105d56:	e9 22 f7 ff ff       	jmp    8010547d <alltraps>

80105d5b <vector125>:
.globl vector125
vector125:
  pushl $0
80105d5b:	6a 00                	push   $0x0
  pushl $125
80105d5d:	6a 7d                	push   $0x7d
  jmp alltraps
80105d5f:	e9 19 f7 ff ff       	jmp    8010547d <alltraps>

80105d64 <vector126>:
.globl vector126
vector126:
  pushl $0
80105d64:	6a 00                	push   $0x0
  pushl $126
80105d66:	6a 7e                	push   $0x7e
  jmp alltraps
80105d68:	e9 10 f7 ff ff       	jmp    8010547d <alltraps>

80105d6d <vector127>:
.globl vector127
vector127:
  pushl $0
80105d6d:	6a 00                	push   $0x0
  pushl $127
80105d6f:	6a 7f                	push   $0x7f
  jmp alltraps
80105d71:	e9 07 f7 ff ff       	jmp    8010547d <alltraps>

80105d76 <vector128>:
.globl vector128
vector128:
  pushl $0
80105d76:	6a 00                	push   $0x0
  pushl $128
80105d78:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105d7d:	e9 fb f6 ff ff       	jmp    8010547d <alltraps>

80105d82 <vector129>:
.globl vector129
vector129:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $129
80105d84:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105d89:	e9 ef f6 ff ff       	jmp    8010547d <alltraps>

80105d8e <vector130>:
.globl vector130
vector130:
  pushl $0
80105d8e:	6a 00                	push   $0x0
  pushl $130
80105d90:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80105d95:	e9 e3 f6 ff ff       	jmp    8010547d <alltraps>

80105d9a <vector131>:
.globl vector131
vector131:
  pushl $0
80105d9a:	6a 00                	push   $0x0
  pushl $131
80105d9c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105da1:	e9 d7 f6 ff ff       	jmp    8010547d <alltraps>

80105da6 <vector132>:
.globl vector132
vector132:
  pushl $0
80105da6:	6a 00                	push   $0x0
  pushl $132
80105da8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105dad:	e9 cb f6 ff ff       	jmp    8010547d <alltraps>

80105db2 <vector133>:
.globl vector133
vector133:
  pushl $0
80105db2:	6a 00                	push   $0x0
  pushl $133
80105db4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105db9:	e9 bf f6 ff ff       	jmp    8010547d <alltraps>

80105dbe <vector134>:
.globl vector134
vector134:
  pushl $0
80105dbe:	6a 00                	push   $0x0
  pushl $134
80105dc0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80105dc5:	e9 b3 f6 ff ff       	jmp    8010547d <alltraps>

80105dca <vector135>:
.globl vector135
vector135:
  pushl $0
80105dca:	6a 00                	push   $0x0
  pushl $135
80105dcc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105dd1:	e9 a7 f6 ff ff       	jmp    8010547d <alltraps>

80105dd6 <vector136>:
.globl vector136
vector136:
  pushl $0
80105dd6:	6a 00                	push   $0x0
  pushl $136
80105dd8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105ddd:	e9 9b f6 ff ff       	jmp    8010547d <alltraps>

80105de2 <vector137>:
.globl vector137
vector137:
  pushl $0
80105de2:	6a 00                	push   $0x0
  pushl $137
80105de4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105de9:	e9 8f f6 ff ff       	jmp    8010547d <alltraps>

80105dee <vector138>:
.globl vector138
vector138:
  pushl $0
80105dee:	6a 00                	push   $0x0
  pushl $138
80105df0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105df5:	e9 83 f6 ff ff       	jmp    8010547d <alltraps>

80105dfa <vector139>:
.globl vector139
vector139:
  pushl $0
80105dfa:	6a 00                	push   $0x0
  pushl $139
80105dfc:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105e01:	e9 77 f6 ff ff       	jmp    8010547d <alltraps>

80105e06 <vector140>:
.globl vector140
vector140:
  pushl $0
80105e06:	6a 00                	push   $0x0
  pushl $140
80105e08:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105e0d:	e9 6b f6 ff ff       	jmp    8010547d <alltraps>

80105e12 <vector141>:
.globl vector141
vector141:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $141
80105e14:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105e19:	e9 5f f6 ff ff       	jmp    8010547d <alltraps>

80105e1e <vector142>:
.globl vector142
vector142:
  pushl $0
80105e1e:	6a 00                	push   $0x0
  pushl $142
80105e20:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105e25:	e9 53 f6 ff ff       	jmp    8010547d <alltraps>

80105e2a <vector143>:
.globl vector143
vector143:
  pushl $0
80105e2a:	6a 00                	push   $0x0
  pushl $143
80105e2c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105e31:	e9 47 f6 ff ff       	jmp    8010547d <alltraps>

80105e36 <vector144>:
.globl vector144
vector144:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $144
80105e38:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80105e3d:	e9 3b f6 ff ff       	jmp    8010547d <alltraps>

80105e42 <vector145>:
.globl vector145
vector145:
  pushl $0
80105e42:	6a 00                	push   $0x0
  pushl $145
80105e44:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105e49:	e9 2f f6 ff ff       	jmp    8010547d <alltraps>

80105e4e <vector146>:
.globl vector146
vector146:
  pushl $0
80105e4e:	6a 00                	push   $0x0
  pushl $146
80105e50:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80105e55:	e9 23 f6 ff ff       	jmp    8010547d <alltraps>

80105e5a <vector147>:
.globl vector147
vector147:
  pushl $0
80105e5a:	6a 00                	push   $0x0
  pushl $147
80105e5c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105e61:	e9 17 f6 ff ff       	jmp    8010547d <alltraps>

80105e66 <vector148>:
.globl vector148
vector148:
  pushl $0
80105e66:	6a 00                	push   $0x0
  pushl $148
80105e68:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105e6d:	e9 0b f6 ff ff       	jmp    8010547d <alltraps>

80105e72 <vector149>:
.globl vector149
vector149:
  pushl $0
80105e72:	6a 00                	push   $0x0
  pushl $149
80105e74:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105e79:	e9 ff f5 ff ff       	jmp    8010547d <alltraps>

80105e7e <vector150>:
.globl vector150
vector150:
  pushl $0
80105e7e:	6a 00                	push   $0x0
  pushl $150
80105e80:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80105e85:	e9 f3 f5 ff ff       	jmp    8010547d <alltraps>

80105e8a <vector151>:
.globl vector151
vector151:
  pushl $0
80105e8a:	6a 00                	push   $0x0
  pushl $151
80105e8c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105e91:	e9 e7 f5 ff ff       	jmp    8010547d <alltraps>

80105e96 <vector152>:
.globl vector152
vector152:
  pushl $0
80105e96:	6a 00                	push   $0x0
  pushl $152
80105e98:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105e9d:	e9 db f5 ff ff       	jmp    8010547d <alltraps>

80105ea2 <vector153>:
.globl vector153
vector153:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $153
80105ea4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105ea9:	e9 cf f5 ff ff       	jmp    8010547d <alltraps>

80105eae <vector154>:
.globl vector154
vector154:
  pushl $0
80105eae:	6a 00                	push   $0x0
  pushl $154
80105eb0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80105eb5:	e9 c3 f5 ff ff       	jmp    8010547d <alltraps>

80105eba <vector155>:
.globl vector155
vector155:
  pushl $0
80105eba:	6a 00                	push   $0x0
  pushl $155
80105ebc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105ec1:	e9 b7 f5 ff ff       	jmp    8010547d <alltraps>

80105ec6 <vector156>:
.globl vector156
vector156:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $156
80105ec8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105ecd:	e9 ab f5 ff ff       	jmp    8010547d <alltraps>

80105ed2 <vector157>:
.globl vector157
vector157:
  pushl $0
80105ed2:	6a 00                	push   $0x0
  pushl $157
80105ed4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105ed9:	e9 9f f5 ff ff       	jmp    8010547d <alltraps>

80105ede <vector158>:
.globl vector158
vector158:
  pushl $0
80105ede:	6a 00                	push   $0x0
  pushl $158
80105ee0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80105ee5:	e9 93 f5 ff ff       	jmp    8010547d <alltraps>

80105eea <vector159>:
.globl vector159
vector159:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $159
80105eec:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80105ef1:	e9 87 f5 ff ff       	jmp    8010547d <alltraps>

80105ef6 <vector160>:
.globl vector160
vector160:
  pushl $0
80105ef6:	6a 00                	push   $0x0
  pushl $160
80105ef8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80105efd:	e9 7b f5 ff ff       	jmp    8010547d <alltraps>

80105f02 <vector161>:
.globl vector161
vector161:
  pushl $0
80105f02:	6a 00                	push   $0x0
  pushl $161
80105f04:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80105f09:	e9 6f f5 ff ff       	jmp    8010547d <alltraps>

80105f0e <vector162>:
.globl vector162
vector162:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $162
80105f10:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80105f15:	e9 63 f5 ff ff       	jmp    8010547d <alltraps>

80105f1a <vector163>:
.globl vector163
vector163:
  pushl $0
80105f1a:	6a 00                	push   $0x0
  pushl $163
80105f1c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105f21:	e9 57 f5 ff ff       	jmp    8010547d <alltraps>

80105f26 <vector164>:
.globl vector164
vector164:
  pushl $0
80105f26:	6a 00                	push   $0x0
  pushl $164
80105f28:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80105f2d:	e9 4b f5 ff ff       	jmp    8010547d <alltraps>

80105f32 <vector165>:
.globl vector165
vector165:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $165
80105f34:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80105f39:	e9 3f f5 ff ff       	jmp    8010547d <alltraps>

80105f3e <vector166>:
.globl vector166
vector166:
  pushl $0
80105f3e:	6a 00                	push   $0x0
  pushl $166
80105f40:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80105f45:	e9 33 f5 ff ff       	jmp    8010547d <alltraps>

80105f4a <vector167>:
.globl vector167
vector167:
  pushl $0
80105f4a:	6a 00                	push   $0x0
  pushl $167
80105f4c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105f51:	e9 27 f5 ff ff       	jmp    8010547d <alltraps>

80105f56 <vector168>:
.globl vector168
vector168:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $168
80105f58:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80105f5d:	e9 1b f5 ff ff       	jmp    8010547d <alltraps>

80105f62 <vector169>:
.globl vector169
vector169:
  pushl $0
80105f62:	6a 00                	push   $0x0
  pushl $169
80105f64:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80105f69:	e9 0f f5 ff ff       	jmp    8010547d <alltraps>

80105f6e <vector170>:
.globl vector170
vector170:
  pushl $0
80105f6e:	6a 00                	push   $0x0
  pushl $170
80105f70:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80105f75:	e9 03 f5 ff ff       	jmp    8010547d <alltraps>

80105f7a <vector171>:
.globl vector171
vector171:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $171
80105f7c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80105f81:	e9 f7 f4 ff ff       	jmp    8010547d <alltraps>

80105f86 <vector172>:
.globl vector172
vector172:
  pushl $0
80105f86:	6a 00                	push   $0x0
  pushl $172
80105f88:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80105f8d:	e9 eb f4 ff ff       	jmp    8010547d <alltraps>

80105f92 <vector173>:
.globl vector173
vector173:
  pushl $0
80105f92:	6a 00                	push   $0x0
  pushl $173
80105f94:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80105f99:	e9 df f4 ff ff       	jmp    8010547d <alltraps>

80105f9e <vector174>:
.globl vector174
vector174:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $174
80105fa0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80105fa5:	e9 d3 f4 ff ff       	jmp    8010547d <alltraps>

80105faa <vector175>:
.globl vector175
vector175:
  pushl $0
80105faa:	6a 00                	push   $0x0
  pushl $175
80105fac:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80105fb1:	e9 c7 f4 ff ff       	jmp    8010547d <alltraps>

80105fb6 <vector176>:
.globl vector176
vector176:
  pushl $0
80105fb6:	6a 00                	push   $0x0
  pushl $176
80105fb8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80105fbd:	e9 bb f4 ff ff       	jmp    8010547d <alltraps>

80105fc2 <vector177>:
.globl vector177
vector177:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $177
80105fc4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80105fc9:	e9 af f4 ff ff       	jmp    8010547d <alltraps>

80105fce <vector178>:
.globl vector178
vector178:
  pushl $0
80105fce:	6a 00                	push   $0x0
  pushl $178
80105fd0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80105fd5:	e9 a3 f4 ff ff       	jmp    8010547d <alltraps>

80105fda <vector179>:
.globl vector179
vector179:
  pushl $0
80105fda:	6a 00                	push   $0x0
  pushl $179
80105fdc:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80105fe1:	e9 97 f4 ff ff       	jmp    8010547d <alltraps>

80105fe6 <vector180>:
.globl vector180
vector180:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $180
80105fe8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80105fed:	e9 8b f4 ff ff       	jmp    8010547d <alltraps>

80105ff2 <vector181>:
.globl vector181
vector181:
  pushl $0
80105ff2:	6a 00                	push   $0x0
  pushl $181
80105ff4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80105ff9:	e9 7f f4 ff ff       	jmp    8010547d <alltraps>

80105ffe <vector182>:
.globl vector182
vector182:
  pushl $0
80105ffe:	6a 00                	push   $0x0
  pushl $182
80106000:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106005:	e9 73 f4 ff ff       	jmp    8010547d <alltraps>

8010600a <vector183>:
.globl vector183
vector183:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $183
8010600c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106011:	e9 67 f4 ff ff       	jmp    8010547d <alltraps>

80106016 <vector184>:
.globl vector184
vector184:
  pushl $0
80106016:	6a 00                	push   $0x0
  pushl $184
80106018:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010601d:	e9 5b f4 ff ff       	jmp    8010547d <alltraps>

80106022 <vector185>:
.globl vector185
vector185:
  pushl $0
80106022:	6a 00                	push   $0x0
  pushl $185
80106024:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106029:	e9 4f f4 ff ff       	jmp    8010547d <alltraps>

8010602e <vector186>:
.globl vector186
vector186:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $186
80106030:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106035:	e9 43 f4 ff ff       	jmp    8010547d <alltraps>

8010603a <vector187>:
.globl vector187
vector187:
  pushl $0
8010603a:	6a 00                	push   $0x0
  pushl $187
8010603c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106041:	e9 37 f4 ff ff       	jmp    8010547d <alltraps>

80106046 <vector188>:
.globl vector188
vector188:
  pushl $0
80106046:	6a 00                	push   $0x0
  pushl $188
80106048:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010604d:	e9 2b f4 ff ff       	jmp    8010547d <alltraps>

80106052 <vector189>:
.globl vector189
vector189:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $189
80106054:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106059:	e9 1f f4 ff ff       	jmp    8010547d <alltraps>

8010605e <vector190>:
.globl vector190
vector190:
  pushl $0
8010605e:	6a 00                	push   $0x0
  pushl $190
80106060:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106065:	e9 13 f4 ff ff       	jmp    8010547d <alltraps>

8010606a <vector191>:
.globl vector191
vector191:
  pushl $0
8010606a:	6a 00                	push   $0x0
  pushl $191
8010606c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106071:	e9 07 f4 ff ff       	jmp    8010547d <alltraps>

80106076 <vector192>:
.globl vector192
vector192:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $192
80106078:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010607d:	e9 fb f3 ff ff       	jmp    8010547d <alltraps>

80106082 <vector193>:
.globl vector193
vector193:
  pushl $0
80106082:	6a 00                	push   $0x0
  pushl $193
80106084:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106089:	e9 ef f3 ff ff       	jmp    8010547d <alltraps>

8010608e <vector194>:
.globl vector194
vector194:
  pushl $0
8010608e:	6a 00                	push   $0x0
  pushl $194
80106090:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106095:	e9 e3 f3 ff ff       	jmp    8010547d <alltraps>

8010609a <vector195>:
.globl vector195
vector195:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $195
8010609c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801060a1:	e9 d7 f3 ff ff       	jmp    8010547d <alltraps>

801060a6 <vector196>:
.globl vector196
vector196:
  pushl $0
801060a6:	6a 00                	push   $0x0
  pushl $196
801060a8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801060ad:	e9 cb f3 ff ff       	jmp    8010547d <alltraps>

801060b2 <vector197>:
.globl vector197
vector197:
  pushl $0
801060b2:	6a 00                	push   $0x0
  pushl $197
801060b4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801060b9:	e9 bf f3 ff ff       	jmp    8010547d <alltraps>

801060be <vector198>:
.globl vector198
vector198:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $198
801060c0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801060c5:	e9 b3 f3 ff ff       	jmp    8010547d <alltraps>

801060ca <vector199>:
.globl vector199
vector199:
  pushl $0
801060ca:	6a 00                	push   $0x0
  pushl $199
801060cc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801060d1:	e9 a7 f3 ff ff       	jmp    8010547d <alltraps>

801060d6 <vector200>:
.globl vector200
vector200:
  pushl $0
801060d6:	6a 00                	push   $0x0
  pushl $200
801060d8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801060dd:	e9 9b f3 ff ff       	jmp    8010547d <alltraps>

801060e2 <vector201>:
.globl vector201
vector201:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $201
801060e4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801060e9:	e9 8f f3 ff ff       	jmp    8010547d <alltraps>

801060ee <vector202>:
.globl vector202
vector202:
  pushl $0
801060ee:	6a 00                	push   $0x0
  pushl $202
801060f0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801060f5:	e9 83 f3 ff ff       	jmp    8010547d <alltraps>

801060fa <vector203>:
.globl vector203
vector203:
  pushl $0
801060fa:	6a 00                	push   $0x0
  pushl $203
801060fc:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106101:	e9 77 f3 ff ff       	jmp    8010547d <alltraps>

80106106 <vector204>:
.globl vector204
vector204:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $204
80106108:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010610d:	e9 6b f3 ff ff       	jmp    8010547d <alltraps>

80106112 <vector205>:
.globl vector205
vector205:
  pushl $0
80106112:	6a 00                	push   $0x0
  pushl $205
80106114:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106119:	e9 5f f3 ff ff       	jmp    8010547d <alltraps>

8010611e <vector206>:
.globl vector206
vector206:
  pushl $0
8010611e:	6a 00                	push   $0x0
  pushl $206
80106120:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106125:	e9 53 f3 ff ff       	jmp    8010547d <alltraps>

8010612a <vector207>:
.globl vector207
vector207:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $207
8010612c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106131:	e9 47 f3 ff ff       	jmp    8010547d <alltraps>

80106136 <vector208>:
.globl vector208
vector208:
  pushl $0
80106136:	6a 00                	push   $0x0
  pushl $208
80106138:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010613d:	e9 3b f3 ff ff       	jmp    8010547d <alltraps>

80106142 <vector209>:
.globl vector209
vector209:
  pushl $0
80106142:	6a 00                	push   $0x0
  pushl $209
80106144:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106149:	e9 2f f3 ff ff       	jmp    8010547d <alltraps>

8010614e <vector210>:
.globl vector210
vector210:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $210
80106150:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106155:	e9 23 f3 ff ff       	jmp    8010547d <alltraps>

8010615a <vector211>:
.globl vector211
vector211:
  pushl $0
8010615a:	6a 00                	push   $0x0
  pushl $211
8010615c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106161:	e9 17 f3 ff ff       	jmp    8010547d <alltraps>

80106166 <vector212>:
.globl vector212
vector212:
  pushl $0
80106166:	6a 00                	push   $0x0
  pushl $212
80106168:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010616d:	e9 0b f3 ff ff       	jmp    8010547d <alltraps>

80106172 <vector213>:
.globl vector213
vector213:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $213
80106174:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106179:	e9 ff f2 ff ff       	jmp    8010547d <alltraps>

8010617e <vector214>:
.globl vector214
vector214:
  pushl $0
8010617e:	6a 00                	push   $0x0
  pushl $214
80106180:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106185:	e9 f3 f2 ff ff       	jmp    8010547d <alltraps>

8010618a <vector215>:
.globl vector215
vector215:
  pushl $0
8010618a:	6a 00                	push   $0x0
  pushl $215
8010618c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106191:	e9 e7 f2 ff ff       	jmp    8010547d <alltraps>

80106196 <vector216>:
.globl vector216
vector216:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $216
80106198:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010619d:	e9 db f2 ff ff       	jmp    8010547d <alltraps>

801061a2 <vector217>:
.globl vector217
vector217:
  pushl $0
801061a2:	6a 00                	push   $0x0
  pushl $217
801061a4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801061a9:	e9 cf f2 ff ff       	jmp    8010547d <alltraps>

801061ae <vector218>:
.globl vector218
vector218:
  pushl $0
801061ae:	6a 00                	push   $0x0
  pushl $218
801061b0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801061b5:	e9 c3 f2 ff ff       	jmp    8010547d <alltraps>

801061ba <vector219>:
.globl vector219
vector219:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $219
801061bc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801061c1:	e9 b7 f2 ff ff       	jmp    8010547d <alltraps>

801061c6 <vector220>:
.globl vector220
vector220:
  pushl $0
801061c6:	6a 00                	push   $0x0
  pushl $220
801061c8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801061cd:	e9 ab f2 ff ff       	jmp    8010547d <alltraps>

801061d2 <vector221>:
.globl vector221
vector221:
  pushl $0
801061d2:	6a 00                	push   $0x0
  pushl $221
801061d4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801061d9:	e9 9f f2 ff ff       	jmp    8010547d <alltraps>

801061de <vector222>:
.globl vector222
vector222:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $222
801061e0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801061e5:	e9 93 f2 ff ff       	jmp    8010547d <alltraps>

801061ea <vector223>:
.globl vector223
vector223:
  pushl $0
801061ea:	6a 00                	push   $0x0
  pushl $223
801061ec:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801061f1:	e9 87 f2 ff ff       	jmp    8010547d <alltraps>

801061f6 <vector224>:
.globl vector224
vector224:
  pushl $0
801061f6:	6a 00                	push   $0x0
  pushl $224
801061f8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801061fd:	e9 7b f2 ff ff       	jmp    8010547d <alltraps>

80106202 <vector225>:
.globl vector225
vector225:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $225
80106204:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106209:	e9 6f f2 ff ff       	jmp    8010547d <alltraps>

8010620e <vector226>:
.globl vector226
vector226:
  pushl $0
8010620e:	6a 00                	push   $0x0
  pushl $226
80106210:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106215:	e9 63 f2 ff ff       	jmp    8010547d <alltraps>

8010621a <vector227>:
.globl vector227
vector227:
  pushl $0
8010621a:	6a 00                	push   $0x0
  pushl $227
8010621c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106221:	e9 57 f2 ff ff       	jmp    8010547d <alltraps>

80106226 <vector228>:
.globl vector228
vector228:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $228
80106228:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010622d:	e9 4b f2 ff ff       	jmp    8010547d <alltraps>

80106232 <vector229>:
.globl vector229
vector229:
  pushl $0
80106232:	6a 00                	push   $0x0
  pushl $229
80106234:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106239:	e9 3f f2 ff ff       	jmp    8010547d <alltraps>

8010623e <vector230>:
.globl vector230
vector230:
  pushl $0
8010623e:	6a 00                	push   $0x0
  pushl $230
80106240:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106245:	e9 33 f2 ff ff       	jmp    8010547d <alltraps>

8010624a <vector231>:
.globl vector231
vector231:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $231
8010624c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106251:	e9 27 f2 ff ff       	jmp    8010547d <alltraps>

80106256 <vector232>:
.globl vector232
vector232:
  pushl $0
80106256:	6a 00                	push   $0x0
  pushl $232
80106258:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010625d:	e9 1b f2 ff ff       	jmp    8010547d <alltraps>

80106262 <vector233>:
.globl vector233
vector233:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $233
80106264:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106269:	e9 0f f2 ff ff       	jmp    8010547d <alltraps>

8010626e <vector234>:
.globl vector234
vector234:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $234
80106270:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106275:	e9 03 f2 ff ff       	jmp    8010547d <alltraps>

8010627a <vector235>:
.globl vector235
vector235:
  pushl $0
8010627a:	6a 00                	push   $0x0
  pushl $235
8010627c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106281:	e9 f7 f1 ff ff       	jmp    8010547d <alltraps>

80106286 <vector236>:
.globl vector236
vector236:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $236
80106288:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010628d:	e9 eb f1 ff ff       	jmp    8010547d <alltraps>

80106292 <vector237>:
.globl vector237
vector237:
  pushl $0
80106292:	6a 00                	push   $0x0
  pushl $237
80106294:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106299:	e9 df f1 ff ff       	jmp    8010547d <alltraps>

8010629e <vector238>:
.globl vector238
vector238:
  pushl $0
8010629e:	6a 00                	push   $0x0
  pushl $238
801062a0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801062a5:	e9 d3 f1 ff ff       	jmp    8010547d <alltraps>

801062aa <vector239>:
.globl vector239
vector239:
  pushl $0
801062aa:	6a 00                	push   $0x0
  pushl $239
801062ac:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801062b1:	e9 c7 f1 ff ff       	jmp    8010547d <alltraps>

801062b6 <vector240>:
.globl vector240
vector240:
  pushl $0
801062b6:	6a 00                	push   $0x0
  pushl $240
801062b8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801062bd:	e9 bb f1 ff ff       	jmp    8010547d <alltraps>

801062c2 <vector241>:
.globl vector241
vector241:
  pushl $0
801062c2:	6a 00                	push   $0x0
  pushl $241
801062c4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801062c9:	e9 af f1 ff ff       	jmp    8010547d <alltraps>

801062ce <vector242>:
.globl vector242
vector242:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $242
801062d0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801062d5:	e9 a3 f1 ff ff       	jmp    8010547d <alltraps>

801062da <vector243>:
.globl vector243
vector243:
  pushl $0
801062da:	6a 00                	push   $0x0
  pushl $243
801062dc:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801062e1:	e9 97 f1 ff ff       	jmp    8010547d <alltraps>

801062e6 <vector244>:
.globl vector244
vector244:
  pushl $0
801062e6:	6a 00                	push   $0x0
  pushl $244
801062e8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801062ed:	e9 8b f1 ff ff       	jmp    8010547d <alltraps>

801062f2 <vector245>:
.globl vector245
vector245:
  pushl $0
801062f2:	6a 00                	push   $0x0
  pushl $245
801062f4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801062f9:	e9 7f f1 ff ff       	jmp    8010547d <alltraps>

801062fe <vector246>:
.globl vector246
vector246:
  pushl $0
801062fe:	6a 00                	push   $0x0
  pushl $246
80106300:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106305:	e9 73 f1 ff ff       	jmp    8010547d <alltraps>

8010630a <vector247>:
.globl vector247
vector247:
  pushl $0
8010630a:	6a 00                	push   $0x0
  pushl $247
8010630c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106311:	e9 67 f1 ff ff       	jmp    8010547d <alltraps>

80106316 <vector248>:
.globl vector248
vector248:
  pushl $0
80106316:	6a 00                	push   $0x0
  pushl $248
80106318:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010631d:	e9 5b f1 ff ff       	jmp    8010547d <alltraps>

80106322 <vector249>:
.globl vector249
vector249:
  pushl $0
80106322:	6a 00                	push   $0x0
  pushl $249
80106324:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106329:	e9 4f f1 ff ff       	jmp    8010547d <alltraps>

8010632e <vector250>:
.globl vector250
vector250:
  pushl $0
8010632e:	6a 00                	push   $0x0
  pushl $250
80106330:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106335:	e9 43 f1 ff ff       	jmp    8010547d <alltraps>

8010633a <vector251>:
.globl vector251
vector251:
  pushl $0
8010633a:	6a 00                	push   $0x0
  pushl $251
8010633c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106341:	e9 37 f1 ff ff       	jmp    8010547d <alltraps>

80106346 <vector252>:
.globl vector252
vector252:
  pushl $0
80106346:	6a 00                	push   $0x0
  pushl $252
80106348:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010634d:	e9 2b f1 ff ff       	jmp    8010547d <alltraps>

80106352 <vector253>:
.globl vector253
vector253:
  pushl $0
80106352:	6a 00                	push   $0x0
  pushl $253
80106354:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106359:	e9 1f f1 ff ff       	jmp    8010547d <alltraps>

8010635e <vector254>:
.globl vector254
vector254:
  pushl $0
8010635e:	6a 00                	push   $0x0
  pushl $254
80106360:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106365:	e9 13 f1 ff ff       	jmp    8010547d <alltraps>

8010636a <vector255>:
.globl vector255
vector255:
  pushl $0
8010636a:	6a 00                	push   $0x0
  pushl $255
8010636c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106371:	e9 07 f1 ff ff       	jmp    8010547d <alltraps>
80106376:	66 90                	xchg   %ax,%ax
80106378:	66 90                	xchg   %ax,%ax
8010637a:	66 90                	xchg   %ax,%ax
8010637c:	66 90                	xchg   %ax,%ax
8010637e:	66 90                	xchg   %ax,%ax

80106380 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106380:	55                   	push   %ebp
80106381:	89 e5                	mov    %esp,%ebp
80106383:	57                   	push   %edi
80106384:	56                   	push   %esi
80106385:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106387:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010638a:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010638b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010638e:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106391:	8b 1f                	mov    (%edi),%ebx
80106393:	f6 c3 01             	test   $0x1,%bl
80106396:	74 28                	je     801063c0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106398:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010639e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801063a4:	c1 ee 0a             	shr    $0xa,%esi
}
801063a7:	83 c4 1c             	add    $0x1c,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801063aa:	89 f2                	mov    %esi,%edx
801063ac:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801063b2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801063b5:	5b                   	pop    %ebx
801063b6:	5e                   	pop    %esi
801063b7:	5f                   	pop    %edi
801063b8:	5d                   	pop    %ebp
801063b9:	c3                   	ret    
801063ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801063c0:	85 c9                	test   %ecx,%ecx
801063c2:	74 34                	je     801063f8 <walkpgdir+0x78>
801063c4:	e8 a7 c1 ff ff       	call   80102570 <kalloc>
801063c9:	85 c0                	test   %eax,%eax
801063cb:	89 c3                	mov    %eax,%ebx
801063cd:	74 29                	je     801063f8 <walkpgdir+0x78>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801063cf:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801063d6:	00 
801063d7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801063de:	00 
801063df:	89 04 24             	mov    %eax,(%esp)
801063e2:	e8 79 df ff ff       	call   80104360 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801063e7:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801063ed:	83 c8 07             	or     $0x7,%eax
801063f0:	89 07                	mov    %eax,(%edi)
801063f2:	eb b0                	jmp    801063a4 <walkpgdir+0x24>
801063f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
801063f8:	83 c4 1c             	add    $0x1c,%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801063fb:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801063fd:	5b                   	pop    %ebx
801063fe:	5e                   	pop    %esi
801063ff:	5f                   	pop    %edi
80106400:	5d                   	pop    %ebp
80106401:	c3                   	ret    
80106402:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106410 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106410:	55                   	push   %ebp
80106411:	89 e5                	mov    %esp,%ebp
80106413:	57                   	push   %edi
80106414:	56                   	push   %esi
80106415:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106416:	89 d3                	mov    %edx,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106418:	83 ec 1c             	sub    $0x1c,%esp
8010641b:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
8010641e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106424:	89 45 e0             	mov    %eax,-0x20(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106427:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
8010642b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010642e:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106432:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
80106439:	29 df                	sub    %ebx,%edi
8010643b:	eb 18                	jmp    80106455 <mappages+0x45>
8010643d:	8d 76 00             	lea    0x0(%esi),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106440:	f6 00 01             	testb  $0x1,(%eax)
80106443:	75 3d                	jne    80106482 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106445:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
80106448:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010644b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010644d:	74 29                	je     80106478 <mappages+0x68>
      break;
    a += PGSIZE;
8010644f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106455:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106458:	b9 01 00 00 00       	mov    $0x1,%ecx
8010645d:	89 da                	mov    %ebx,%edx
8010645f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106462:	e8 19 ff ff ff       	call   80106380 <walkpgdir>
80106467:	85 c0                	test   %eax,%eax
80106469:	75 d5                	jne    80106440 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010646b:	83 c4 1c             	add    $0x1c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010646e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106473:	5b                   	pop    %ebx
80106474:	5e                   	pop    %esi
80106475:	5f                   	pop    %edi
80106476:	5d                   	pop    %ebp
80106477:	c3                   	ret    
80106478:	83 c4 1c             	add    $0x1c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
8010647b:	31 c0                	xor    %eax,%eax
}
8010647d:	5b                   	pop    %ebx
8010647e:	5e                   	pop    %esi
8010647f:	5f                   	pop    %edi
80106480:	5d                   	pop    %ebp
80106481:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106482:	c7 04 24 68 75 10 80 	movl   $0x80107568,(%esp)
80106489:	e8 d2 9e ff ff       	call   80100360 <panic>
8010648e:	66 90                	xchg   %ax,%ax

80106490 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106490:	55                   	push   %ebp
80106491:	89 e5                	mov    %esp,%ebp
80106493:	57                   	push   %edi
80106494:	89 c7                	mov    %eax,%edi
80106496:	56                   	push   %esi
80106497:	89 d6                	mov    %edx,%esi
80106499:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010649a:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801064a0:	83 ec 1c             	sub    $0x1c,%esp
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801064a3:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801064a9:	39 d3                	cmp    %edx,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801064ab:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801064ae:	72 3b                	jb     801064eb <deallocuvm.part.0+0x5b>
801064b0:	eb 5e                	jmp    80106510 <deallocuvm.part.0+0x80>
801064b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801064b8:	8b 10                	mov    (%eax),%edx
801064ba:	f6 c2 01             	test   $0x1,%dl
801064bd:	74 22                	je     801064e1 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801064bf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801064c5:	74 54                	je     8010651b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
801064c7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801064cd:	89 14 24             	mov    %edx,(%esp)
801064d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801064d3:	e8 e8 be ff ff       	call   801023c0 <kfree>
      *pte = 0;
801064d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801064e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801064e7:	39 f3                	cmp    %esi,%ebx
801064e9:	73 25                	jae    80106510 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
801064eb:	31 c9                	xor    %ecx,%ecx
801064ed:	89 da                	mov    %ebx,%edx
801064ef:	89 f8                	mov    %edi,%eax
801064f1:	e8 8a fe ff ff       	call   80106380 <walkpgdir>
    if(!pte)
801064f6:	85 c0                	test   %eax,%eax
801064f8:	75 be                	jne    801064b8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801064fa:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106500:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106506:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010650c:	39 f3                	cmp    %esi,%ebx
8010650e:	72 db                	jb     801064eb <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106510:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106513:	83 c4 1c             	add    $0x1c,%esp
80106516:	5b                   	pop    %ebx
80106517:	5e                   	pop    %esi
80106518:	5f                   	pop    %edi
80106519:	5d                   	pop    %ebp
8010651a:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
8010651b:	c7 04 24 06 6f 10 80 	movl   $0x80106f06,(%esp)
80106522:	e8 39 9e ff ff       	call   80100360 <panic>
80106527:	89 f6                	mov    %esi,%esi
80106529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106530 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106530:	55                   	push   %ebp
80106531:	89 e5                	mov    %esp,%ebp
80106533:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106536:	e8 05 d2 ff ff       	call   80103740 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010653b:	31 c9                	xor    %ecx,%ecx
8010653d:	ba ff ff ff ff       	mov    $0xffffffff,%edx

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106542:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106548:	05 a0 27 11 80       	add    $0x801127a0,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010654d:	66 89 50 78          	mov    %dx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106551:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  lgdt(c->gdt, sizeof(c->gdt));
80106556:	83 c0 70             	add    $0x70,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106559:	66 89 48 0a          	mov    %cx,0xa(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010655d:	31 c9                	xor    %ecx,%ecx
8010655f:	66 89 50 10          	mov    %dx,0x10(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106563:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106568:	66 89 48 12          	mov    %cx,0x12(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010656c:	31 c9                	xor    %ecx,%ecx
8010656e:	66 89 50 18          	mov    %dx,0x18(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106572:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106577:	66 89 48 1a          	mov    %cx,0x1a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010657b:	31 c9                	xor    %ecx,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010657d:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
80106581:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106585:	c6 40 15 92          	movb   $0x92,0x15(%eax)
80106589:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010658d:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
80106591:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106595:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
80106599:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
8010659d:	66 89 50 20          	mov    %dx,0x20(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801065a1:	ba 2f 00 00 00       	mov    $0x2f,%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065a6:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
801065aa:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065ae:	c6 40 14 00          	movb   $0x0,0x14(%eax)
801065b2:	c6 40 17 00          	movb   $0x0,0x17(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801065b6:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
801065ba:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801065be:	66 89 48 22          	mov    %cx,0x22(%eax)
801065c2:	c6 40 24 00          	movb   $0x0,0x24(%eax)
801065c6:	c6 40 27 00          	movb   $0x0,0x27(%eax)
801065ca:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801065ce:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801065d2:	c1 e8 10             	shr    $0x10,%eax
801065d5:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801065d9:	8d 45 f2             	lea    -0xe(%ebp),%eax
801065dc:	0f 01 10             	lgdtl  (%eax)
  lgdt(c->gdt, sizeof(c->gdt));
}
801065df:	c9                   	leave  
801065e0:	c3                   	ret    
801065e1:	eb 0d                	jmp    801065f0 <switchkvm>
801065e3:	90                   	nop
801065e4:	90                   	nop
801065e5:	90                   	nop
801065e6:	90                   	nop
801065e7:	90                   	nop
801065e8:	90                   	nop
801065e9:	90                   	nop
801065ea:	90                   	nop
801065eb:	90                   	nop
801065ec:	90                   	nop
801065ed:	90                   	nop
801065ee:	90                   	nop
801065ef:	90                   	nop

801065f0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801065f0:	a1 c4 54 11 80       	mov    0x801154c4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801065f5:	55                   	push   %ebp
801065f6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801065f8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801065fd:	0f 22 d8             	mov    %eax,%cr3
}
80106600:	5d                   	pop    %ebp
80106601:	c3                   	ret    
80106602:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106610 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106610:	55                   	push   %ebp
80106611:	89 e5                	mov    %esp,%ebp
80106613:	57                   	push   %edi
80106614:	56                   	push   %esi
80106615:	53                   	push   %ebx
80106616:	83 ec 1c             	sub    $0x1c,%esp
80106619:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010661c:	85 f6                	test   %esi,%esi
8010661e:	0f 84 cd 00 00 00    	je     801066f1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106624:	8b 46 08             	mov    0x8(%esi),%eax
80106627:	85 c0                	test   %eax,%eax
80106629:	0f 84 da 00 00 00    	je     80106709 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010662f:	8b 7e 04             	mov    0x4(%esi),%edi
80106632:	85 ff                	test   %edi,%edi
80106634:	0f 84 c3 00 00 00    	je     801066fd <switchuvm+0xed>
    panic("switchuvm: no pgdir");

  pushcli();
8010663a:	e8 71 db ff ff       	call   801041b0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010663f:	e8 7c d0 ff ff       	call   801036c0 <mycpu>
80106644:	89 c3                	mov    %eax,%ebx
80106646:	e8 75 d0 ff ff       	call   801036c0 <mycpu>
8010664b:	89 c7                	mov    %eax,%edi
8010664d:	e8 6e d0 ff ff       	call   801036c0 <mycpu>
80106652:	83 c7 08             	add    $0x8,%edi
80106655:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106658:	e8 63 d0 ff ff       	call   801036c0 <mycpu>
8010665d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106660:	ba 67 00 00 00       	mov    $0x67,%edx
80106665:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
8010666c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106673:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
8010667a:	83 c1 08             	add    $0x8,%ecx
8010667d:	c1 e9 10             	shr    $0x10,%ecx
80106680:	83 c0 08             	add    $0x8,%eax
80106683:	c1 e8 18             	shr    $0x18,%eax
80106686:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010668c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106693:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106699:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
8010669e:	e8 1d d0 ff ff       	call   801036c0 <mycpu>
801066a3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801066aa:	e8 11 d0 ff ff       	call   801036c0 <mycpu>
801066af:	b9 10 00 00 00       	mov    $0x10,%ecx
801066b4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801066b8:	e8 03 d0 ff ff       	call   801036c0 <mycpu>
801066bd:	8b 56 08             	mov    0x8(%esi),%edx
801066c0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801066c6:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801066c9:	e8 f2 cf ff ff       	call   801036c0 <mycpu>
801066ce:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801066d2:	b8 28 00 00 00       	mov    $0x28,%eax
801066d7:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
801066da:	8b 46 04             	mov    0x4(%esi),%eax
801066dd:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801066e2:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
801066e5:	83 c4 1c             	add    $0x1c,%esp
801066e8:	5b                   	pop    %ebx
801066e9:	5e                   	pop    %esi
801066ea:	5f                   	pop    %edi
801066eb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801066ec:	e9 ff da ff ff       	jmp    801041f0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
801066f1:	c7 04 24 6e 75 10 80 	movl   $0x8010756e,(%esp)
801066f8:	e8 63 9c ff ff       	call   80100360 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
801066fd:	c7 04 24 99 75 10 80 	movl   $0x80107599,(%esp)
80106704:	e8 57 9c ff ff       	call   80100360 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106709:	c7 04 24 84 75 10 80 	movl   $0x80107584,(%esp)
80106710:	e8 4b 9c ff ff       	call   80100360 <panic>
80106715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106720 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106720:	55                   	push   %ebp
80106721:	89 e5                	mov    %esp,%ebp
80106723:	57                   	push   %edi
80106724:	56                   	push   %esi
80106725:	53                   	push   %ebx
80106726:	83 ec 1c             	sub    $0x1c,%esp
80106729:	8b 75 10             	mov    0x10(%ebp),%esi
8010672c:	8b 45 08             	mov    0x8(%ebp),%eax
8010672f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106732:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106738:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
8010673b:	77 54                	ja     80106791 <inituvm+0x71>
    panic("inituvm: more than a page");
  mem = kalloc();
8010673d:	e8 2e be ff ff       	call   80102570 <kalloc>
  memset(mem, 0, PGSIZE);
80106742:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106749:	00 
8010674a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106751:	00 
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106752:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106754:	89 04 24             	mov    %eax,(%esp)
80106757:	e8 04 dc ff ff       	call   80104360 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
8010675c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106762:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106767:	89 04 24             	mov    %eax,(%esp)
8010676a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010676d:	31 d2                	xor    %edx,%edx
8010676f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106776:	00 
80106777:	e8 94 fc ff ff       	call   80106410 <mappages>
  memmove(mem, init, sz);
8010677c:	89 75 10             	mov    %esi,0x10(%ebp)
8010677f:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106782:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106785:	83 c4 1c             	add    $0x1c,%esp
80106788:	5b                   	pop    %ebx
80106789:	5e                   	pop    %esi
8010678a:	5f                   	pop    %edi
8010678b:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
8010678c:	e9 6f dc ff ff       	jmp    80104400 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106791:	c7 04 24 ad 75 10 80 	movl   $0x801075ad,(%esp)
80106798:	e8 c3 9b ff ff       	call   80100360 <panic>
8010679d:	8d 76 00             	lea    0x0(%esi),%esi

801067a0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801067a0:	55                   	push   %ebp
801067a1:	89 e5                	mov    %esp,%ebp
801067a3:	57                   	push   %edi
801067a4:	56                   	push   %esi
801067a5:	53                   	push   %ebx
801067a6:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801067a9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801067b0:	0f 85 98 00 00 00    	jne    8010684e <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801067b6:	8b 75 18             	mov    0x18(%ebp),%esi
801067b9:	31 db                	xor    %ebx,%ebx
801067bb:	85 f6                	test   %esi,%esi
801067bd:	75 1a                	jne    801067d9 <loaduvm+0x39>
801067bf:	eb 77                	jmp    80106838 <loaduvm+0x98>
801067c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067c8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067ce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801067d4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801067d7:	76 5f                	jbe    80106838 <loaduvm+0x98>
801067d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801067dc:	31 c9                	xor    %ecx,%ecx
801067de:	8b 45 08             	mov    0x8(%ebp),%eax
801067e1:	01 da                	add    %ebx,%edx
801067e3:	e8 98 fb ff ff       	call   80106380 <walkpgdir>
801067e8:	85 c0                	test   %eax,%eax
801067ea:	74 56                	je     80106842 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801067ec:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
801067ee:	bf 00 10 00 00       	mov    $0x1000,%edi
801067f3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801067f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
801067fb:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106801:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106804:	05 00 00 00 80       	add    $0x80000000,%eax
80106809:	89 44 24 04          	mov    %eax,0x4(%esp)
8010680d:	8b 45 10             	mov    0x10(%ebp),%eax
80106810:	01 d9                	add    %ebx,%ecx
80106812:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106816:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010681a:	89 04 24             	mov    %eax,(%esp)
8010681d:	e8 0e b2 ff ff       	call   80101a30 <readi>
80106822:	39 f8                	cmp    %edi,%eax
80106824:	74 a2                	je     801067c8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106826:	83 c4 1c             	add    $0x1c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106829:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
8010682e:	5b                   	pop    %ebx
8010682f:	5e                   	pop    %esi
80106830:	5f                   	pop    %edi
80106831:	5d                   	pop    %ebp
80106832:	c3                   	ret    
80106833:	90                   	nop
80106834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106838:	83 c4 1c             	add    $0x1c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010683b:	31 c0                	xor    %eax,%eax
}
8010683d:	5b                   	pop    %ebx
8010683e:	5e                   	pop    %esi
8010683f:	5f                   	pop    %edi
80106840:	5d                   	pop    %ebp
80106841:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106842:	c7 04 24 c7 75 10 80 	movl   $0x801075c7,(%esp)
80106849:	e8 12 9b ff ff       	call   80100360 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
8010684e:	c7 04 24 68 76 10 80 	movl   $0x80107668,(%esp)
80106855:	e8 06 9b ff ff       	call   80100360 <panic>
8010685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106860 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	57                   	push   %edi
80106864:	56                   	push   %esi
80106865:	53                   	push   %ebx
80106866:	83 ec 1c             	sub    $0x1c,%esp
80106869:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010686c:	85 ff                	test   %edi,%edi
8010686e:	0f 88 7e 00 00 00    	js     801068f2 <allocuvm+0x92>
    return 0;
  if(newsz < oldsz)
80106874:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106877:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010687a:	72 78                	jb     801068f4 <allocuvm+0x94>
    return oldsz;

  a = PGROUNDUP(oldsz);
8010687c:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106882:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106888:	39 df                	cmp    %ebx,%edi
8010688a:	77 4a                	ja     801068d6 <allocuvm+0x76>
8010688c:	eb 72                	jmp    80106900 <allocuvm+0xa0>
8010688e:	66 90                	xchg   %ax,%ax
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106890:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106897:	00 
80106898:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010689f:	00 
801068a0:	89 04 24             	mov    %eax,(%esp)
801068a3:	e8 b8 da ff ff       	call   80104360 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801068a8:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801068ae:	b9 00 10 00 00       	mov    $0x1000,%ecx
801068b3:	89 04 24             	mov    %eax,(%esp)
801068b6:	8b 45 08             	mov    0x8(%ebp),%eax
801068b9:	89 da                	mov    %ebx,%edx
801068bb:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
801068c2:	00 
801068c3:	e8 48 fb ff ff       	call   80106410 <mappages>
801068c8:	85 c0                	test   %eax,%eax
801068ca:	78 44                	js     80106910 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801068cc:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068d2:	39 df                	cmp    %ebx,%edi
801068d4:	76 2a                	jbe    80106900 <allocuvm+0xa0>
    mem = kalloc();
801068d6:	e8 95 bc ff ff       	call   80102570 <kalloc>
    if(mem == 0){
801068db:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
801068dd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801068df:	75 af                	jne    80106890 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
801068e1:	c7 04 24 e5 75 10 80 	movl   $0x801075e5,(%esp)
801068e8:	e8 13 9e ff ff       	call   80100700 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801068ed:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801068f0:	77 48                	ja     8010693a <allocuvm+0xda>
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
801068f2:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
801068f4:	83 c4 1c             	add    $0x1c,%esp
801068f7:	5b                   	pop    %ebx
801068f8:	5e                   	pop    %esi
801068f9:	5f                   	pop    %edi
801068fa:	5d                   	pop    %ebp
801068fb:	c3                   	ret    
801068fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106900:	83 c4 1c             	add    $0x1c,%esp
80106903:	89 f8                	mov    %edi,%eax
80106905:	5b                   	pop    %ebx
80106906:	5e                   	pop    %esi
80106907:	5f                   	pop    %edi
80106908:	5d                   	pop    %ebp
80106909:	c3                   	ret    
8010690a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106910:	c7 04 24 fd 75 10 80 	movl   $0x801075fd,(%esp)
80106917:	e8 e4 9d ff ff       	call   80100700 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010691c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010691f:	76 0d                	jbe    8010692e <allocuvm+0xce>
80106921:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106924:	89 fa                	mov    %edi,%edx
80106926:	8b 45 08             	mov    0x8(%ebp),%eax
80106929:	e8 62 fb ff ff       	call   80106490 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
8010692e:	89 34 24             	mov    %esi,(%esp)
80106931:	e8 8a ba ff ff       	call   801023c0 <kfree>
      return 0;
80106936:	31 c0                	xor    %eax,%eax
80106938:	eb ba                	jmp    801068f4 <allocuvm+0x94>
8010693a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010693d:	89 fa                	mov    %edi,%edx
8010693f:	8b 45 08             	mov    0x8(%ebp),%eax
80106942:	e8 49 fb ff ff       	call   80106490 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106947:	31 c0                	xor    %eax,%eax
80106949:	eb a9                	jmp    801068f4 <allocuvm+0x94>
8010694b:	90                   	nop
8010694c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106950 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	8b 55 0c             	mov    0xc(%ebp),%edx
80106956:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106959:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010695c:	39 d1                	cmp    %edx,%ecx
8010695e:	73 08                	jae    80106968 <deallocuvm+0x18>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106960:	5d                   	pop    %ebp
80106961:	e9 2a fb ff ff       	jmp    80106490 <deallocuvm.part.0>
80106966:	66 90                	xchg   %ax,%ax
80106968:	89 d0                	mov    %edx,%eax
8010696a:	5d                   	pop    %ebp
8010696b:	c3                   	ret    
8010696c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106970 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	56                   	push   %esi
80106974:	53                   	push   %ebx
80106975:	83 ec 10             	sub    $0x10,%esp
80106978:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010697b:	85 f6                	test   %esi,%esi
8010697d:	74 59                	je     801069d8 <freevm+0x68>
8010697f:	31 c9                	xor    %ecx,%ecx
80106981:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106986:	89 f0                	mov    %esi,%eax
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106988:	31 db                	xor    %ebx,%ebx
8010698a:	e8 01 fb ff ff       	call   80106490 <deallocuvm.part.0>
8010698f:	eb 12                	jmp    801069a3 <freevm+0x33>
80106991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106998:	83 c3 01             	add    $0x1,%ebx
8010699b:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
801069a1:	74 27                	je     801069ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801069a3:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
801069a6:	f6 c2 01             	test   $0x1,%dl
801069a9:	74 ed                	je     80106998 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801069ab:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801069b1:	83 c3 01             	add    $0x1,%ebx
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
801069b4:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801069ba:	89 14 24             	mov    %edx,(%esp)
801069bd:	e8 fe b9 ff ff       	call   801023c0 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801069c2:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
801069c8:	75 d9                	jne    801069a3 <freevm+0x33>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801069ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801069cd:	83 c4 10             	add    $0x10,%esp
801069d0:	5b                   	pop    %ebx
801069d1:	5e                   	pop    %esi
801069d2:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801069d3:	e9 e8 b9 ff ff       	jmp    801023c0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801069d8:	c7 04 24 19 76 10 80 	movl   $0x80107619,(%esp)
801069df:	e8 7c 99 ff ff       	call   80100360 <panic>
801069e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801069ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801069f0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	56                   	push   %esi
801069f4:	53                   	push   %ebx
801069f5:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801069f8:	e8 73 bb ff ff       	call   80102570 <kalloc>
801069fd:	85 c0                	test   %eax,%eax
801069ff:	89 c6                	mov    %eax,%esi
80106a01:	74 6d                	je     80106a70 <setupkvm+0x80>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106a03:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106a0a:	00 
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106a0b:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106a10:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a17:	00 
80106a18:	89 04 24             	mov    %eax,(%esp)
80106a1b:	e8 40 d9 ff ff       	call   80104360 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106a20:	8b 53 0c             	mov    0xc(%ebx),%edx
80106a23:	8b 43 04             	mov    0x4(%ebx),%eax
80106a26:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106a29:	89 54 24 04          	mov    %edx,0x4(%esp)
80106a2d:	8b 13                	mov    (%ebx),%edx
80106a2f:	89 04 24             	mov    %eax,(%esp)
80106a32:	29 c1                	sub    %eax,%ecx
80106a34:	89 f0                	mov    %esi,%eax
80106a36:	e8 d5 f9 ff ff       	call   80106410 <mappages>
80106a3b:	85 c0                	test   %eax,%eax
80106a3d:	78 19                	js     80106a58 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106a3f:	83 c3 10             	add    $0x10,%ebx
80106a42:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106a48:	72 d6                	jb     80106a20 <setupkvm+0x30>
80106a4a:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106a4c:	83 c4 10             	add    $0x10,%esp
80106a4f:	5b                   	pop    %ebx
80106a50:	5e                   	pop    %esi
80106a51:	5d                   	pop    %ebp
80106a52:	c3                   	ret    
80106a53:	90                   	nop
80106a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106a58:	89 34 24             	mov    %esi,(%esp)
80106a5b:	e8 10 ff ff ff       	call   80106970 <freevm>
      return 0;
    }
  return pgdir;
}
80106a60:	83 c4 10             	add    $0x10,%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106a63:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106a65:	5b                   	pop    %ebx
80106a66:	5e                   	pop    %esi
80106a67:	5d                   	pop    %ebp
80106a68:	c3                   	ret    
80106a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106a70:	31 c0                	xor    %eax,%eax
80106a72:	eb d8                	jmp    80106a4c <setupkvm+0x5c>
80106a74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106a80 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106a86:	e8 65 ff ff ff       	call   801069f0 <setupkvm>
80106a8b:	a3 c4 54 11 80       	mov    %eax,0x801154c4
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106a90:	05 00 00 00 80       	add    $0x80000000,%eax
80106a95:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
80106a98:	c9                   	leave  
80106a99:	c3                   	ret    
80106a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106aa0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106aa0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106aa1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106aa3:	89 e5                	mov    %esp,%ebp
80106aa5:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106aa8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106aab:	8b 45 08             	mov    0x8(%ebp),%eax
80106aae:	e8 cd f8 ff ff       	call   80106380 <walkpgdir>
  if(pte == 0)
80106ab3:	85 c0                	test   %eax,%eax
80106ab5:	74 05                	je     80106abc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ab7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106aba:	c9                   	leave  
80106abb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106abc:	c7 04 24 2a 76 10 80 	movl   $0x8010762a,(%esp)
80106ac3:	e8 98 98 ff ff       	call   80100360 <panic>
80106ac8:	90                   	nop
80106ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ad0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ad9:	e8 12 ff ff ff       	call   801069f0 <setupkvm>
80106ade:	85 c0                	test   %eax,%eax
80106ae0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ae3:	0f 84 b9 00 00 00    	je     80106ba2 <copyuvm+0xd2>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
80106aec:	85 c0                	test   %eax,%eax
80106aee:	0f 84 94 00 00 00    	je     80106b88 <copyuvm+0xb8>
80106af4:	31 ff                	xor    %edi,%edi
80106af6:	eb 48                	jmp    80106b40 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106af8:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106afe:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106b05:	00 
80106b06:	89 74 24 04          	mov    %esi,0x4(%esp)
80106b0a:	89 04 24             	mov    %eax,(%esp)
80106b0d:	e8 ee d8 ff ff       	call   80104400 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106b12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b15:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b1a:	89 fa                	mov    %edi,%edx
80106b1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b20:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b26:	89 04 24             	mov    %eax,(%esp)
80106b29:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b2c:	e8 df f8 ff ff       	call   80106410 <mappages>
80106b31:	85 c0                	test   %eax,%eax
80106b33:	78 63                	js     80106b98 <copyuvm+0xc8>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106b35:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106b3b:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106b3e:	76 48                	jbe    80106b88 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106b40:	8b 45 08             	mov    0x8(%ebp),%eax
80106b43:	31 c9                	xor    %ecx,%ecx
80106b45:	89 fa                	mov    %edi,%edx
80106b47:	e8 34 f8 ff ff       	call   80106380 <walkpgdir>
80106b4c:	85 c0                	test   %eax,%eax
80106b4e:	74 62                	je     80106bb2 <copyuvm+0xe2>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106b50:	8b 00                	mov    (%eax),%eax
80106b52:	a8 01                	test   $0x1,%al
80106b54:	74 50                	je     80106ba6 <copyuvm+0xd6>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106b56:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80106b58:	25 ff 0f 00 00       	and    $0xfff,%eax
80106b5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106b60:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106b66:	e8 05 ba ff ff       	call   80102570 <kalloc>
80106b6b:	85 c0                	test   %eax,%eax
80106b6d:	89 c3                	mov    %eax,%ebx
80106b6f:	75 87                	jne    80106af8 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80106b71:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b74:	89 04 24             	mov    %eax,(%esp)
80106b77:	e8 f4 fd ff ff       	call   80106970 <freevm>
  return 0;
80106b7c:	31 c0                	xor    %eax,%eax
}
80106b7e:	83 c4 2c             	add    $0x2c,%esp
80106b81:	5b                   	pop    %ebx
80106b82:	5e                   	pop    %esi
80106b83:	5f                   	pop    %edi
80106b84:	5d                   	pop    %ebp
80106b85:	c3                   	ret    
80106b86:	66 90                	xchg   %ax,%ax
80106b88:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b8b:	83 c4 2c             	add    $0x2c,%esp
80106b8e:	5b                   	pop    %ebx
80106b8f:	5e                   	pop    %esi
80106b90:	5f                   	pop    %edi
80106b91:	5d                   	pop    %ebp
80106b92:	c3                   	ret    
80106b93:	90                   	nop
80106b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80106b98:	89 1c 24             	mov    %ebx,(%esp)
80106b9b:	e8 20 b8 ff ff       	call   801023c0 <kfree>
      goto bad;
80106ba0:	eb cf                	jmp    80106b71 <copyuvm+0xa1>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80106ba2:	31 c0                	xor    %eax,%eax
80106ba4:	eb d8                	jmp    80106b7e <copyuvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106ba6:	c7 04 24 4e 76 10 80 	movl   $0x8010764e,(%esp)
80106bad:	e8 ae 97 ff ff       	call   80100360 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106bb2:	c7 04 24 34 76 10 80 	movl   $0x80107634,(%esp)
80106bb9:	e8 a2 97 ff ff       	call   80100360 <panic>
80106bbe:	66 90                	xchg   %ax,%ax

80106bc0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106bc0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106bc1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106bc3:	89 e5                	mov    %esp,%ebp
80106bc5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106bc8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bcb:	8b 45 08             	mov    0x8(%ebp),%eax
80106bce:	e8 ad f7 ff ff       	call   80106380 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106bd3:	8b 00                	mov    (%eax),%eax
80106bd5:	89 c2                	mov    %eax,%edx
80106bd7:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
80106bda:	83 fa 05             	cmp    $0x5,%edx
80106bdd:	75 11                	jne    80106bf0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106bdf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106be4:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106be9:	c9                   	leave  
80106bea:	c3                   	ret    
80106beb:	90                   	nop
80106bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80106bf0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80106bf2:	c9                   	leave  
80106bf3:	c3                   	ret    
80106bf4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106bfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c00 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106c00:	55                   	push   %ebp
80106c01:	89 e5                	mov    %esp,%ebp
80106c03:	57                   	push   %edi
80106c04:	56                   	push   %esi
80106c05:	53                   	push   %ebx
80106c06:	83 ec 1c             	sub    $0x1c,%esp
80106c09:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106c0c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c0f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106c12:	85 db                	test   %ebx,%ebx
80106c14:	75 3a                	jne    80106c50 <copyout+0x50>
80106c16:	eb 68                	jmp    80106c80 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106c18:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c1b:	89 f2                	mov    %esi,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106c1d:	89 7c 24 04          	mov    %edi,0x4(%esp)
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106c21:	29 ca                	sub    %ecx,%edx
80106c23:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106c29:	39 da                	cmp    %ebx,%edx
80106c2b:	0f 47 d3             	cmova  %ebx,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106c2e:	29 f1                	sub    %esi,%ecx
80106c30:	01 c8                	add    %ecx,%eax
80106c32:	89 54 24 08          	mov    %edx,0x8(%esp)
80106c36:	89 04 24             	mov    %eax,(%esp)
80106c39:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106c3c:	e8 bf d7 ff ff       	call   80104400 <memmove>
    len -= n;
    buf += n;
80106c41:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80106c44:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106c4a:	01 d7                	add    %edx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106c4c:	29 d3                	sub    %edx,%ebx
80106c4e:	74 30                	je     80106c80 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
80106c50:	8b 45 08             	mov    0x8(%ebp),%eax
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106c53:	89 ce                	mov    %ecx,%esi
80106c55:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106c5b:	89 74 24 04          	mov    %esi,0x4(%esp)
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106c5f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80106c62:	89 04 24             	mov    %eax,(%esp)
80106c65:	e8 56 ff ff ff       	call   80106bc0 <uva2ka>
    if(pa0 == 0)
80106c6a:	85 c0                	test   %eax,%eax
80106c6c:	75 aa                	jne    80106c18 <copyout+0x18>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106c6e:	83 c4 1c             	add    $0x1c,%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80106c71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106c76:	5b                   	pop    %ebx
80106c77:	5e                   	pop    %esi
80106c78:	5f                   	pop    %edi
80106c79:	5d                   	pop    %ebp
80106c7a:	c3                   	ret    
80106c7b:	90                   	nop
80106c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c80:	83 c4 1c             	add    $0x1c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106c83:	31 c0                	xor    %eax,%eax
}
80106c85:	5b                   	pop    %ebx
80106c86:	5e                   	pop    %esi
80106c87:	5f                   	pop    %edi
80106c88:	5d                   	pop    %ebp
80106c89:	c3                   	ret    
