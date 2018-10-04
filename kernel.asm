
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 d0 2e 10 80       	mov    $0x80102ed0,%eax
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
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	c7 44 24 04 60 6d 10 	movl   $0x80106d60,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010005b:	e8 f0 40 00 00       	call   80104150 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100060:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx

  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100065:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006f:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
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
8010008a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 67 6d 10 	movl   $0x80106d67,0x4(%esp)
8010009b:	80 
8010009c:	e8 7f 3f 00 00       	call   80104020 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b4:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

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
801000dc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
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
801000e6:	e8 d5 41 00 00       	call   801042c0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000f1:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
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
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
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
8010015a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100161:	e8 ca 41 00 00       	call   80104330 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 ef 3e 00 00       	call   80104060 <acquiresleep>
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 92 20 00 00       	call   80102210 <iderw>
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
80100188:	c7 04 24 6e 6d 10 80 	movl   $0x80106d6e,(%esp)
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
801001b0:	e8 4b 3f 00 00       	call   80104100 <holdingsleep>
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
801001c4:	e9 47 20 00 00       	jmp    80102210 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	c7 04 24 7f 6d 10 80 	movl   $0x80106d7f,(%esp)
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
801001f1:	e8 0a 3f 00 00       	call   80104100 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 be 3e 00 00       	call   801040c0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100209:	e8 b2 40 00 00       	call   801042c0 <acquire>
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
80100226:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
8010022b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
80100232:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100235:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
8010023a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023d:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
80100243:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
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
80100250:	e9 db 40 00 00       	jmp    80104330 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100255:	c7 04 24 86 6d 10 80 	movl   $0x80106d86,(%esp)
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
80100282:	e8 f9 15 00 00       	call   80101880 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028e:	e8 2d 40 00 00       	call   801042c0 <acquire>
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
801002a8:	e8 d3 34 00 00       	call   80103780 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 74                	jne    80100328 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801002c3:	e8 18 3a 00 00       	call   80103ce0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c8:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002cd:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	8d 50 01             	lea    0x1(%eax),%edx
801002d8:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
801002de:	89 c2                	mov    %eax,%edx
801002e0:	83 e2 7f             	and    $0x7f,%edx
801002e3:	0f b6 8a 20 ff 10 80 	movzbl -0x7fef00e0(%edx),%ecx
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
80100307:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010030e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100311:	e8 1a 40 00 00       	call   80104330 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 82 14 00 00       	call   801017a0 <ilock>
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
80100328:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010032f:	e8 fc 3f 00 00       	call   80104330 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 64 14 00 00       	call   801017a0 <ilock>
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
8010034e:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
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
80100369:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
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
80100376:	e8 c5 24 00 00       	call   80102840 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 8d 6d 10 80 	movl   $0x80106d8d,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 92 03 00 00       	call   80100720 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 87 03 00 00       	call   80100720 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 d7 76 10 80 	movl   $0x801076d7,(%esp)
801003a0:	e8 7b 03 00 00       	call   80100720 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 bc 3d 00 00       	call   80104170 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 a1 6d 10 80 	movl   $0x80106da1,(%esp)
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
801003d1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003d8:	00 00 00 
801003db:	eb fe                	jmp    801003db <panic+0x7b>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi

801003e0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003e0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
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
80100400:	0f 84 e1 00 00 00    	je     801004e7 <consputc+0x107>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
80100406:	8d 80 1e ff ff ff    	lea    -0xe2(%eax),%eax
8010040c:	83 f8 03             	cmp    $0x3,%eax
8010040f:	0f 87 10 02 00 00    	ja     80100625 <consputc+0x245>
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
  int pos;
  //int backspace_hit = 0;

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

  if(c == '\n')
80100439:	83 fe 0a             	cmp    $0xa,%esi
8010043c:	0f 84 c7 01 00 00    	je     80100609 <consputc+0x229>
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
80100442:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100448:	0f 84 62 01 00 00    	je     801005b0 <consputc+0x1d0>
      //backspace_hit = 1;
      if (pos % BUFF_SIZE > 2){
 	--pos;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
8010044e:	81 fe e4 00 00 00    	cmp    $0xe4,%esi
80100454:	0f 84 26 01 00 00    	je     80100580 <consputc+0x1a0>
    if (pos % BUFF_SIZE > 2) --pos;
  } else if(c == RIGHT){
8010045a:	81 fe e5 00 00 00    	cmp    $0xe5,%esi
80100460:	0f 84 aa 00 00 00    	je     80100510 <consputc+0x130>
    if (crt[pos] != (' ' | 0x0700)) ++pos;
  } else if(c == UP){
80100466:	8d 86 1e ff ff ff    	lea    -0xe2(%esi),%eax
8010046c:	83 f8 01             	cmp    $0x1,%eax
8010046f:	76 3c                	jbe    801004ad <consputc+0xcd>
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
80100471:	b8 80 07 00 00       	mov    $0x780,%eax
80100476:	29 d8                	sub    %ebx,%eax
80100478:	8d 3c 1b             	lea    (%ebx,%ebx,1),%edi
8010047b:	01 c0                	add    %eax,%eax
8010047d:	8d 97 00 80 0b 80    	lea    -0x7ff48000(%edi),%edx
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
80100483:	83 c3 01             	add    $0x1,%ebx
  } else if(c == UP){
    // Up
  } else if(c == DOWN){
    // Down
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
80100486:	89 44 24 08          	mov    %eax,0x8(%esp)
8010048a:	8d 87 02 80 0b 80    	lea    -0x7ff47ffe(%edi),%eax
80100490:	89 54 24 04          	mov    %edx,0x4(%esp)
80100494:	89 04 24             	mov    %eax,(%esp)
80100497:	e8 84 3f 00 00       	call   80104420 <memmove>
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
8010049c:	89 f0                	mov    %esi,%eax
8010049e:	0f b6 f0             	movzbl %al,%esi
801004a1:	66 81 ce 00 07       	or     $0x700,%si
801004a6:	66 89 b7 00 80 0b 80 	mov    %si,-0x7ff48000(%edi)
801004ad:	89 d8                	mov    %ebx,%eax
  }

  if(pos < 0 || pos > 25*80)
801004af:	3d d0 07 00 00       	cmp    $0x7d0,%eax
801004b4:	77 74                	ja     8010052a <consputc+0x14a>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
801004b6:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004bc:	7f 78                	jg     80100536 <consputc+0x156>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004be:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004c3:	b8 0e 00 00 00       	mov    $0xe,%eax
801004c8:	ee                   	out    %al,(%dx)
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
801004c9:	89 d8                	mov    %ebx,%eax
801004cb:	b2 d5                	mov    $0xd5,%dl
801004cd:	c1 f8 08             	sar    $0x8,%eax
801004d0:	ee                   	out    %al,(%dx)
801004d1:	b8 0f 00 00 00       	mov    $0xf,%eax
801004d6:	b2 d4                	mov    $0xd4,%dl
801004d8:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
801004d9:	0f b6 c3             	movzbl %bl,%eax
801004dc:	b2 d5                	mov    $0xd5,%dl
801004de:	ee                   	out    %al,(%dx)
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
    uartputc(c);
  }
  cgaputc(c);
}
801004df:	83 c4 1c             	add    $0x1c,%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004ee:	e8 ed 53 00 00       	call   801058e0 <uartputc>
801004f3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004fa:	e8 e1 53 00 00       	call   801058e0 <uartputc>
801004ff:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100506:	e8 d5 53 00 00       	call   801058e0 <uartputc>
8010050b:	e9 05 ff ff ff       	jmp    80100415 <consputc+0x35>
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
    if (pos % BUFF_SIZE > 2) --pos;
  } else if(c == RIGHT){
    if (crt[pos] != (' ' | 0x0700)) ++pos;
80100510:	66 81 bc 1b 00 80 0b 	cmpw   $0x720,-0x7ff48000(%ebx,%ebx,1)
80100517:	80 20 07 
8010051a:	89 d8                	mov    %ebx,%eax
8010051c:	74 91                	je     801004af <consputc+0xcf>
8010051e:	83 c3 01             	add    $0x1,%ebx
80100521:	89 d8                	mov    %ebx,%eax
  } else{
    memmove(crt + pos + 1, crt + pos, sizeof(crt[0])*(24*80 - pos));
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
  }

  if(pos < 0 || pos > 25*80)
80100523:	3d d0 07 00 00       	cmp    $0x7d0,%eax
80100528:	76 8c                	jbe    801004b6 <consputc+0xd6>
    panic("pos under/overflow");
8010052a:	c7 04 24 a5 6d 10 80 	movl   $0x80106da5,(%esp)
80100531:	e8 2a fe ff ff       	call   80100360 <panic>

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100536:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
8010053d:	00 
    pos -= 80;
8010053e:	8d 73 b0             	lea    -0x50(%ebx),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100541:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
80100548:	80 
80100549:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100550:	e8 cb 3e 00 00       	call   80104420 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100555:	b8 d0 07 00 00       	mov    $0x7d0,%eax
8010055a:	29 d8                	sub    %ebx,%eax
  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
8010055c:	89 f3                	mov    %esi,%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010055e:	01 c0                	add    %eax,%eax
80100560:	89 44 24 08          	mov    %eax,0x8(%esp)
80100564:	8d 84 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%eax
8010056b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100572:	00 
80100573:	89 04 24             	mov    %eax,(%esp)
80100576:	e8 05 3e 00 00       	call   80104380 <memset>
8010057b:	e9 3e ff ff ff       	jmp    801004be <consputc+0xde>
      if (pos % BUFF_SIZE > 2){
 	--pos;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
      }
  } else if(c == LEFT){
    if (pos % BUFF_SIZE > 2) --pos;
80100580:	89 d8                	mov    %ebx,%eax
80100582:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100587:	f7 ea                	imul   %edx
80100589:	89 d8                	mov    %ebx,%eax
8010058b:	c1 f8 1f             	sar    $0x1f,%eax
8010058e:	89 d9                	mov    %ebx,%ecx
80100590:	c1 fa 05             	sar    $0x5,%edx
80100593:	29 c2                	sub    %eax,%edx
80100595:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100598:	c1 e0 04             	shl    $0x4,%eax
8010059b:	29 c1                	sub    %eax,%ecx
8010059d:	83 f9 02             	cmp    $0x2,%ecx
801005a0:	0f 8e 07 ff ff ff    	jle    801004ad <consputc+0xcd>
801005a6:	83 eb 01             	sub    $0x1,%ebx
801005a9:	89 d8                	mov    %ebx,%eax
801005ab:	e9 ff fe ff ff       	jmp    801004af <consputc+0xcf>

  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos % BUFF_SIZE > 2){
801005b0:	89 d8                	mov    %ebx,%eax
801005b2:	ba 67 66 66 66       	mov    $0x66666667,%edx
801005b7:	f7 ea                	imul   %edx
801005b9:	89 d8                	mov    %ebx,%eax
801005bb:	c1 f8 1f             	sar    $0x1f,%eax
801005be:	89 d9                	mov    %ebx,%ecx
801005c0:	c1 fa 05             	sar    $0x5,%edx
801005c3:	29 c2                	sub    %eax,%edx
801005c5:	8d 04 92             	lea    (%edx,%edx,4),%eax
801005c8:	c1 e0 04             	shl    $0x4,%eax
801005cb:	29 c1                	sub    %eax,%ecx
801005cd:	83 f9 02             	cmp    $0x2,%ecx
801005d0:	0f 8e d7 fe ff ff    	jle    801004ad <consputc+0xcd>
 	--pos;
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005d6:	ba 81 07 00 00       	mov    $0x781,%edx
801005db:	29 da                	sub    %ebx,%edx
801005dd:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
801005e0:	01 d2                	add    %edx,%edx
801005e2:	89 54 24 08          	mov    %edx,0x8(%esp)
801005e6:	8d 90 00 80 0b 80    	lea    -0x7ff48000(%eax),%edx
801005ec:	2d 02 80 f4 7f       	sub    $0x7ff48002,%eax
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos % BUFF_SIZE > 2){
 	--pos;
801005f1:	8d 73 ff             	lea    -0x1(%ebx),%esi
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005f4:	89 54 24 04          	mov    %edx,0x4(%esp)
  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
  else if(c == BACKSPACE) {
      //backspace_hit = 1;
      if (pos % BUFF_SIZE > 2){
 	--pos;
801005f8:	89 f3                	mov    %esi,%ebx
	memmove(crt + pos, crt + pos + 1, sizeof(crt[0])*(24*80 - pos));
801005fa:	89 04 24             	mov    %eax,(%esp)
801005fd:	e8 1e 3e 00 00       	call   80104420 <memmove>
80100602:	89 f0                	mov    %esi,%eax
80100604:	e9 a6 fe ff ff       	jmp    801004af <consputc+0xcf>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += BUFF_SIZE - pos % BUFF_SIZE;
80100609:	89 d8                	mov    %ebx,%eax
8010060b:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100610:	f7 ea                	imul   %edx
80100612:	c1 ea 05             	shr    $0x5,%edx
80100615:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100618:	c1 e0 04             	shl    $0x4,%eax
8010061b:	8d 58 50             	lea    0x50(%eax),%ebx
8010061e:	89 d8                	mov    %ebx,%eax
80100620:	e9 8a fe ff ff       	jmp    801004af <consputc+0xcf>
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
    uartputc(c);
80100625:	89 34 24             	mov    %esi,(%esp)
80100628:	e8 b3 52 00 00       	call   801058e0 <uartputc>
8010062d:	e9 e3 fd ff ff       	jmp    80100415 <consputc+0x35>
80100632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
80100669:	0f b6 92 d0 6d 10 80 	movzbl -0x7fef9230(%edx),%edx
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
801006d2:	e8 a9 11 00 00       	call   80101880 <iunlock>
  acquire(&cons.lock);
801006d7:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006de:	e8 dd 3b 00 00       	call   801042c0 <acquire>
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
801006ff:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100706:	e8 25 3c 00 00       	call   80104330 <release>
  ilock(ip);
8010070b:	8b 45 08             	mov    0x8(%ebp),%eax
8010070e:	89 04 24             	mov    %eax,(%esp)
80100711:	e8 8a 10 00 00       	call   801017a0 <ilock>

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
80100729:	a1 54 a5 10 80       	mov    0x8010a554,%eax
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
801007bc:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007c3:	e8 68 3b 00 00       	call   80104330 <release>
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
80100830:	b8 b8 6d 10 80       	mov    $0x80106db8,%eax
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
80100860:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100867:	e8 54 3a 00 00       	call   801042c0 <acquire>
8010086c:	e9 c8 fe ff ff       	jmp    80100739 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
80100871:	c7 04 24 bf 6d 10 80 	movl   $0x80106dbf,(%esp)
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
80100884:	56                   	push   %esi
  int c, doprocdump = 0;
80100885:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100887:	53                   	push   %ebx
80100888:	83 ec 1c             	sub    $0x1c,%esp
8010088b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
8010088e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100895:	e8 26 3a 00 00       	call   801042c0 <acquire>
8010089a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801008a0:	ff d3                	call   *%ebx
801008a2:	85 c0                	test   %eax,%eax
801008a4:	89 c7                	mov    %eax,%edi
801008a6:	78 30                	js     801008d8 <consoleintr+0x58>
    switch(c){
801008a8:	83 ff 15             	cmp    $0x15,%edi
801008ab:	74 6b                	je     80100918 <consoleintr+0x98>
801008ad:	8d 76 00             	lea    0x0(%esi),%esi
801008b0:	7f 46                	jg     801008f8 <consoleintr+0x78>
801008b2:	83 ff 08             	cmp    $0x8,%edi
801008b5:	0f 84 25 01 00 00    	je     801009e0 <consoleintr+0x160>
801008bb:	83 ff 10             	cmp    $0x10,%edi
801008be:	66 90                	xchg   %ax,%ax
801008c0:	0f 85 a2 00 00 00    	jne    80100968 <consoleintr+0xe8>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801008c6:	ff d3                	call   *%ebx
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801008c8:	be 01 00 00 00       	mov    $0x1,%esi
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801008cd:	85 c0                	test   %eax,%eax
801008cf:	89 c7                	mov    %eax,%edi
801008d1:	79 d5                	jns    801008a8 <consoleintr+0x28>
801008d3:	90                   	nop
801008d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
801008d8:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801008df:	e8 4c 3a 00 00       	call   80104330 <release>
  if(doprocdump) {
801008e4:	85 f6                	test   %esi,%esi
801008e6:	0f 85 1c 01 00 00    	jne    80100a08 <consoleintr+0x188>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801008ec:	83 c4 1c             	add    $0x1c,%esp
801008ef:	5b                   	pop    %ebx
801008f0:	5e                   	pop    %esi
801008f1:	5f                   	pop    %edi
801008f2:	5d                   	pop    %ebp
801008f3:	c3                   	ret    
801008f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
801008f8:	83 ff 7f             	cmp    $0x7f,%edi
801008fb:	0f 84 df 00 00 00    	je     801009e0 <consoleintr+0x160>
80100901:	7c 65                	jl     80100968 <consoleintr+0xe8>
80100903:	8d 87 1e ff ff ff    	lea    -0xe2(%edi),%eax
80100909:	83 f8 03             	cmp    $0x3,%eax
8010090c:	77 5a                	ja     80100968 <consoleintr+0xe8>
      break;
    case UP:
    case DOWN:
    case LEFT:
    case RIGHT:
      consputc(c);
8010090e:	89 f8                	mov    %edi,%eax
80100910:	e8 cb fa ff ff       	call   801003e0 <consputc>
      break;
80100915:	eb 89                	jmp    801008a0 <consoleintr+0x20>
80100917:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100918:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010091d:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100923:	75 2b                	jne    80100950 <consoleintr+0xd0>
80100925:	e9 76 ff ff ff       	jmp    801008a0 <consoleintr+0x20>
8010092a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100930:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100935:	b8 00 01 00 00       	mov    $0x100,%eax
8010093a:	e8 a1 fa ff ff       	call   801003e0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010093f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100944:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010094a:	0f 84 50 ff ff ff    	je     801008a0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100950:	83 e8 01             	sub    $0x1,%eax
80100953:	89 c2                	mov    %eax,%edx
80100955:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100958:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010095f:	75 cf                	jne    80100930 <consoleintr+0xb0>
80100961:	e9 3a ff ff ff       	jmp    801008a0 <consoleintr+0x20>
80100966:	66 90                	xchg   %ax,%ax
    case LEFT:
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100968:	85 ff                	test   %edi,%edi
8010096a:	0f 84 30 ff ff ff    	je     801008a0 <consoleintr+0x20>
80100970:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100975:	89 c2                	mov    %eax,%edx
80100977:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
8010097d:	83 fa 7f             	cmp    $0x7f,%edx
80100980:	0f 87 1a ff ff ff    	ja     801008a0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100986:	8d 50 01             	lea    0x1(%eax),%edx
80100989:	83 e0 7f             	and    $0x7f,%eax
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
8010098c:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
8010098f:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
    case RIGHT:
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100995:	74 7d                	je     80100a14 <consoleintr+0x194>
        input.buf[input.e++ % INPUT_BUF] = c;
80100997:	89 f9                	mov    %edi,%ecx
80100999:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010099f:	89 f8                	mov    %edi,%eax
801009a1:	e8 3a fa ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009a6:	83 ff 04             	cmp    $0x4,%edi
801009a9:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009ae:	74 19                	je     801009c9 <consoleintr+0x149>
801009b0:	83 ff 0a             	cmp    $0xa,%edi
801009b3:	74 14                	je     801009c9 <consoleintr+0x149>
801009b5:	8b 0d a0 ff 10 80    	mov    0x8010ffa0,%ecx
801009bb:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
801009c1:	39 d0                	cmp    %edx,%eax
801009c3:	0f 85 d7 fe ff ff    	jne    801008a0 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801009c9:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801009d0:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801009d5:	e8 96 34 00 00       	call   80103e70 <wakeup>
801009da:	e9 c1 fe ff ff       	jmp    801008a0 <consoleintr+0x20>
801009df:	90                   	nop
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801009e0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009e5:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801009eb:	0f 84 af fe ff ff    	je     801008a0 <consoleintr+0x20>
        input.e--;
801009f1:	83 e8 01             	sub    $0x1,%eax
801009f4:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801009f9:	b8 00 01 00 00       	mov    $0x100,%eax
801009fe:	e8 dd f9 ff ff       	call   801003e0 <consputc>
80100a03:	e9 98 fe ff ff       	jmp    801008a0 <consoleintr+0x20>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100a08:	83 c4 1c             	add    $0x1c,%esp
80100a0b:	5b                   	pop    %ebx
80100a0c:	5e                   	pop    %esi
80100a0d:	5f                   	pop    %edi
80100a0e:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100a0f:	e9 3c 35 00 00       	jmp    80103f50 <procdump>
      consputc(c);
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100a14:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100a1b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a20:	e8 bb f9 ff ff       	call   801003e0 <consputc>
80100a25:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a2a:	eb 9d                	jmp    801009c9 <consoleintr+0x149>
80100a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100a30 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100a30:	55                   	push   %ebp
80100a31:	89 e5                	mov    %esp,%ebp
80100a33:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a36:	c7 44 24 04 c8 6d 10 	movl   $0x80106dc8,0x4(%esp)
80100a3d:	80 
80100a3e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100a45:	e8 06 37 00 00       	call   80104150 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a4a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100a51:	00 
80100a52:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100a59:	c7 05 6c 09 11 80 c0 	movl   $0x801006c0,0x8011096c
80100a60:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a63:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
80100a6a:	02 10 80 
  cons.locking = 1;
80100a6d:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100a74:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100a77:	e8 24 19 00 00       	call   801023a0 <ioapicenable>
}
80100a7c:	c9                   	leave  
80100a7d:	c3                   	ret    
80100a7e:	66 90                	xchg   %ax,%ax

80100a80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	57                   	push   %edi
80100a84:	56                   	push   %esi
80100a85:	53                   	push   %ebx
80100a86:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a8c:	e8 ef 2c 00 00       	call   80103780 <myproc>
80100a91:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a97:	e8 54 21 00 00       	call   80102bf0 <begin_op>

  if((ip = namei(path)) == 0){
80100a9c:	8b 45 08             	mov    0x8(%ebp),%eax
80100a9f:	89 04 24             	mov    %eax,(%esp)
80100aa2:	e8 49 15 00 00       	call   80101ff0 <namei>
80100aa7:	85 c0                	test   %eax,%eax
80100aa9:	89 c3                	mov    %eax,%ebx
80100aab:	0f 84 c2 01 00 00    	je     80100c73 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ab1:	89 04 24             	mov    %eax,(%esp)
80100ab4:	e8 e7 0c 00 00       	call   801017a0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100ab9:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100abf:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100ac6:	00 
80100ac7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100ace:	00 
80100acf:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ad3:	89 1c 24             	mov    %ebx,(%esp)
80100ad6:	e8 75 0f 00 00       	call   80101a50 <readi>
80100adb:	83 f8 34             	cmp    $0x34,%eax
80100ade:	74 20                	je     80100b00 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ae0:	89 1c 24             	mov    %ebx,(%esp)
80100ae3:	e8 18 0f 00 00       	call   80101a00 <iunlockput>
    end_op();
80100ae8:	e8 73 21 00 00       	call   80102c60 <end_op>
  }
  return -1;
80100aed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100af2:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100af8:	5b                   	pop    %ebx
80100af9:	5e                   	pop    %esi
80100afa:	5f                   	pop    %edi
80100afb:	5d                   	pop    %ebp
80100afc:	c3                   	ret    
80100afd:	8d 76 00             	lea    0x0(%esi),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b00:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b07:	45 4c 46 
80100b0a:	75 d4                	jne    80100ae0 <exec+0x60>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b0c:	e8 af 5f 00 00       	call   80106ac0 <setupkvm>
80100b11:	85 c0                	test   %eax,%eax
80100b13:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b19:	74 c5                	je     80100ae0 <exec+0x60>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b1b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b22:	00 
80100b23:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
80100b29:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100b30:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b33:	0f 84 da 00 00 00    	je     80100c13 <exec+0x193>
80100b39:	31 ff                	xor    %edi,%edi
80100b3b:	eb 18                	jmp    80100b55 <exec+0xd5>
80100b3d:	8d 76 00             	lea    0x0(%esi),%esi
80100b40:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b47:	83 c7 01             	add    $0x1,%edi
80100b4a:	83 c6 20             	add    $0x20,%esi
80100b4d:	39 f8                	cmp    %edi,%eax
80100b4f:	0f 8e be 00 00 00    	jle    80100c13 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b55:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b5b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100b62:	00 
80100b63:	89 74 24 08          	mov    %esi,0x8(%esp)
80100b67:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b6b:	89 1c 24             	mov    %ebx,(%esp)
80100b6e:	e8 dd 0e 00 00       	call   80101a50 <readi>
80100b73:	83 f8 20             	cmp    $0x20,%eax
80100b76:	0f 85 84 00 00 00    	jne    80100c00 <exec+0x180>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b7c:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b83:	75 bb                	jne    80100b40 <exec+0xc0>
      continue;
    if(ph.memsz < ph.filesz)
80100b85:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b8b:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b91:	72 6d                	jb     80100c00 <exec+0x180>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b93:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b99:	72 65                	jb     80100c00 <exec+0x180>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b9b:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b9f:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ba5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ba9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100baf:	89 04 24             	mov    %eax,(%esp)
80100bb2:	e8 79 5d 00 00       	call   80106930 <allocuvm>
80100bb7:	85 c0                	test   %eax,%eax
80100bb9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100bbf:	74 3f                	je     80100c00 <exec+0x180>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100bc1:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bc7:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bcc:	75 32                	jne    80100c00 <exec+0x180>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bce:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100bd4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bd8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bde:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100be2:	89 54 24 10          	mov    %edx,0x10(%esp)
80100be6:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100bec:	89 04 24             	mov    %eax,(%esp)
80100bef:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100bf3:	e8 78 5c 00 00       	call   80106870 <loaduvm>
80100bf8:	85 c0                	test   %eax,%eax
80100bfa:	0f 89 40 ff ff ff    	jns    80100b40 <exec+0xc0>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c00:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c06:	89 04 24             	mov    %eax,(%esp)
80100c09:	e8 32 5e 00 00       	call   80106a40 <freevm>
80100c0e:	e9 cd fe ff ff       	jmp    80100ae0 <exec+0x60>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100c13:	89 1c 24             	mov    %ebx,(%esp)
80100c16:	e8 e5 0d 00 00       	call   80101a00 <iunlockput>
80100c1b:	90                   	nop
80100c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100c20:	e8 3b 20 00 00       	call   80102c60 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100c25:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c2b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c30:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c35:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100c3b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c3f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c45:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c49:	89 04 24             	mov    %eax,(%esp)
80100c4c:	e8 df 5c 00 00       	call   80106930 <allocuvm>
80100c51:	85 c0                	test   %eax,%eax
80100c53:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100c59:	75 33                	jne    80100c8e <exec+0x20e>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c5b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c61:	89 04 24             	mov    %eax,(%esp)
80100c64:	e8 d7 5d 00 00       	call   80106a40 <freevm>
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100c69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c6e:	e9 7f fe ff ff       	jmp    80100af2 <exec+0x72>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100c73:	e8 e8 1f 00 00       	call   80102c60 <end_op>
    cprintf("exec: fail\n");
80100c78:	c7 04 24 e1 6d 10 80 	movl   $0x80106de1,(%esp)
80100c7f:	e8 9c fa ff ff       	call   80100720 <cprintf>
    return -1;
80100c84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c89:	e9 64 fe ff ff       	jmp    80100af2 <exec+0x72>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c8e:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100c94:	89 d8                	mov    %ebx,%eax
80100c96:	2d 00 20 00 00       	sub    $0x2000,%eax
80100c9b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c9f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ca5:	89 04 24             	mov    %eax,(%esp)
80100ca8:	e8 c3 5e 00 00       	call   80106b70 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100cad:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb0:	8b 00                	mov    (%eax),%eax
80100cb2:	85 c0                	test   %eax,%eax
80100cb4:	0f 84 59 01 00 00    	je     80100e13 <exec+0x393>
80100cba:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100cbd:	31 d2                	xor    %edx,%edx
80100cbf:	8d 71 04             	lea    0x4(%ecx),%esi
80100cc2:	89 cf                	mov    %ecx,%edi
80100cc4:	89 d1                	mov    %edx,%ecx
80100cc6:	89 f2                	mov    %esi,%edx
80100cc8:	89 fe                	mov    %edi,%esi
80100cca:	89 cf                	mov    %ecx,%edi
80100ccc:	eb 0a                	jmp    80100cd8 <exec+0x258>
80100cce:	66 90                	xchg   %ax,%ax
80100cd0:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100cd3:	83 ff 20             	cmp    $0x20,%edi
80100cd6:	74 83                	je     80100c5b <exec+0x1db>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cd8:	89 04 24             	mov    %eax,(%esp)
80100cdb:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100ce1:	e8 ba 38 00 00       	call   801045a0 <strlen>
80100ce6:	f7 d0                	not    %eax
80100ce8:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cea:	8b 06                	mov    (%esi),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cec:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cef:	89 04 24             	mov    %eax,(%esp)
80100cf2:	e8 a9 38 00 00       	call   801045a0 <strlen>
80100cf7:	83 c0 01             	add    $0x1,%eax
80100cfa:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100cfe:	8b 06                	mov    (%esi),%eax
80100d00:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100d04:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d08:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d0e:	89 04 24             	mov    %eax,(%esp)
80100d11:	e8 ba 5f 00 00       	call   80106cd0 <copyout>
80100d16:	85 c0                	test   %eax,%eax
80100d18:	0f 88 3d ff ff ff    	js     80100c5b <exec+0x1db>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d1e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100d24:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d2a:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d31:	83 c7 01             	add    $0x1,%edi
80100d34:	8b 02                	mov    (%edx),%eax
80100d36:	89 d6                	mov    %edx,%esi
80100d38:	85 c0                	test   %eax,%eax
80100d3a:	75 94                	jne    80100cd0 <exec+0x250>
80100d3c:	89 fa                	mov    %edi,%edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100d3e:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100d45:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d49:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
80100d50:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d56:	89 da                	mov    %ebx,%edx
80100d58:	29 c2                	sub    %eax,%edx

  sp -= (3+argc+1) * 4;
80100d5a:	83 c0 0c             	add    $0xc,%eax
80100d5d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d5f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100d63:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d69:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100d6d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100d71:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d78:	ff ff ff 
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d7b:	89 04 24             	mov    %eax,(%esp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d7e:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d84:	e8 47 5f 00 00       	call   80106cd0 <copyout>
80100d89:	85 c0                	test   %eax,%eax
80100d8b:	0f 88 ca fe ff ff    	js     80100c5b <exec+0x1db>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d91:	8b 45 08             	mov    0x8(%ebp),%eax
80100d94:	0f b6 10             	movzbl (%eax),%edx
80100d97:	84 d2                	test   %dl,%dl
80100d99:	74 19                	je     80100db4 <exec+0x334>
80100d9b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100d9e:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100da1:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100da4:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100da7:	0f 44 c8             	cmove  %eax,%ecx
80100daa:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100dad:	84 d2                	test   %dl,%dl
80100daf:	75 f0                	jne    80100da1 <exec+0x321>
80100db1:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100db4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100dba:	8b 45 08             	mov    0x8(%ebp),%eax
80100dbd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100dc4:	00 
80100dc5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100dc9:	89 f8                	mov    %edi,%eax
80100dcb:	83 c0 6c             	add    $0x6c,%eax
80100dce:	89 04 24             	mov    %eax,(%esp)
80100dd1:	e8 8a 37 00 00       	call   80104560 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100dd6:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100ddc:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100ddf:	8b 47 18             	mov    0x18(%edi),%eax
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100de2:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100de5:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100deb:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100ded:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100df3:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100df6:	8b 47 18             	mov    0x18(%edi),%eax
80100df9:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100dfc:	89 3c 24             	mov    %edi,(%esp)
80100dff:	e8 dc 58 00 00       	call   801066e0 <switchuvm>
  freevm(oldpgdir);
80100e04:	89 34 24             	mov    %esi,(%esp)
80100e07:	e8 34 5c 00 00       	call   80106a40 <freevm>
  return 0;
80100e0c:	31 c0                	xor    %eax,%eax
80100e0e:	e9 df fc ff ff       	jmp    80100af2 <exec+0x72>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e13:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100e19:	31 d2                	xor    %edx,%edx
80100e1b:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e21:	e9 18 ff ff ff       	jmp    80100d3e <exec+0x2be>
80100e26:	66 90                	xchg   %ax,%ax
80100e28:	66 90                	xchg   %ax,%ax
80100e2a:	66 90                	xchg   %ax,%ax
80100e2c:	66 90                	xchg   %ax,%ax
80100e2e:	66 90                	xchg   %ax,%ax

80100e30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100e36:	c7 44 24 04 ed 6d 10 	movl   $0x80106ded,0x4(%esp)
80100e3d:	80 
80100e3e:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e45:	e8 06 33 00 00       	call   80104150 <initlock>
}
80100e4a:	c9                   	leave  
80100e4b:	c3                   	ret    
80100e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100e50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e54:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e59:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100e5c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e63:	e8 58 34 00 00       	call   801042c0 <acquire>
80100e68:	eb 11                	jmp    80100e7b <filealloc+0x2b>
80100e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e70:	83 c3 18             	add    $0x18,%ebx
80100e73:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e79:	74 25                	je     80100ea0 <filealloc+0x50>
    if(f->ref == 0){
80100e7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e7e:	85 c0                	test   %eax,%eax
80100e80:	75 ee                	jne    80100e70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e82:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100e89:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e90:	e8 9b 34 00 00       	call   80104330 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e95:	83 c4 14             	add    $0x14,%esp
  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      release(&ftable.lock);
      return f;
80100e98:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e9a:	5b                   	pop    %ebx
80100e9b:	5d                   	pop    %ebp
80100e9c:	c3                   	ret    
80100e9d:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100ea0:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100ea7:	e8 84 34 00 00       	call   80104330 <release>
  return 0;
}
80100eac:	83 c4 14             	add    $0x14,%esp
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
80100eaf:	31 c0                	xor    %eax,%eax
}
80100eb1:	5b                   	pop    %ebx
80100eb2:	5d                   	pop    %ebp
80100eb3:	c3                   	ret    
80100eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100ec0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	53                   	push   %ebx
80100ec4:	83 ec 14             	sub    $0x14,%esp
80100ec7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eca:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100ed1:	e8 ea 33 00 00       	call   801042c0 <acquire>
  if(f->ref < 1)
80100ed6:	8b 43 04             	mov    0x4(%ebx),%eax
80100ed9:	85 c0                	test   %eax,%eax
80100edb:	7e 1a                	jle    80100ef7 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100edd:	83 c0 01             	add    $0x1,%eax
80100ee0:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ee3:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100eea:	e8 41 34 00 00       	call   80104330 <release>
  return f;
}
80100eef:	83 c4 14             	add    $0x14,%esp
80100ef2:	89 d8                	mov    %ebx,%eax
80100ef4:	5b                   	pop    %ebx
80100ef5:	5d                   	pop    %ebp
80100ef6:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100ef7:	c7 04 24 f4 6d 10 80 	movl   $0x80106df4,(%esp)
80100efe:	e8 5d f4 ff ff       	call   80100360 <panic>
80100f03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f10 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	57                   	push   %edi
80100f14:	56                   	push   %esi
80100f15:	53                   	push   %ebx
80100f16:	83 ec 1c             	sub    $0x1c,%esp
80100f19:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100f1c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100f23:	e8 98 33 00 00       	call   801042c0 <acquire>
  if(f->ref < 1)
80100f28:	8b 57 04             	mov    0x4(%edi),%edx
80100f2b:	85 d2                	test   %edx,%edx
80100f2d:	0f 8e 89 00 00 00    	jle    80100fbc <fileclose+0xac>
    panic("fileclose");
  if(--f->ref > 0){
80100f33:	83 ea 01             	sub    $0x1,%edx
80100f36:	85 d2                	test   %edx,%edx
80100f38:	89 57 04             	mov    %edx,0x4(%edi)
80100f3b:	74 13                	je     80100f50 <fileclose+0x40>
    release(&ftable.lock);
80100f3d:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f44:	83 c4 1c             	add    $0x1c,%esp
80100f47:	5b                   	pop    %ebx
80100f48:	5e                   	pop    %esi
80100f49:	5f                   	pop    %edi
80100f4a:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100f4b:	e9 e0 33 00 00       	jmp    80104330 <release>
    return;
  }
  ff = *f;
80100f50:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100f54:	8b 37                	mov    (%edi),%esi
80100f56:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
80100f59:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f5f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f62:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f65:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f6c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f6f:	e8 bc 33 00 00       	call   80104330 <release>

  if(ff.type == FD_PIPE)
80100f74:	83 fe 01             	cmp    $0x1,%esi
80100f77:	74 0f                	je     80100f88 <fileclose+0x78>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f79:	83 fe 02             	cmp    $0x2,%esi
80100f7c:	74 22                	je     80100fa0 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f7e:	83 c4 1c             	add    $0x1c,%esp
80100f81:	5b                   	pop    %ebx
80100f82:	5e                   	pop    %esi
80100f83:	5f                   	pop    %edi
80100f84:	5d                   	pop    %ebp
80100f85:	c3                   	ret    
80100f86:	66 90                	xchg   %ax,%ax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100f88:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100f8c:	89 1c 24             	mov    %ebx,(%esp)
80100f8f:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f93:	e8 a8 23 00 00       	call   80103340 <pipeclose>
80100f98:	eb e4                	jmp    80100f7e <fileclose+0x6e>
80100f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100fa0:	e8 4b 1c 00 00       	call   80102bf0 <begin_op>
    iput(ff.ip);
80100fa5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100fa8:	89 04 24             	mov    %eax,(%esp)
80100fab:	e8 10 09 00 00       	call   801018c0 <iput>
    end_op();
  }
}
80100fb0:	83 c4 1c             	add    $0x1c,%esp
80100fb3:	5b                   	pop    %ebx
80100fb4:	5e                   	pop    %esi
80100fb5:	5f                   	pop    %edi
80100fb6:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100fb7:	e9 a4 1c 00 00       	jmp    80102c60 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100fbc:	c7 04 24 fc 6d 10 80 	movl   $0x80106dfc,(%esp)
80100fc3:	e8 98 f3 ff ff       	call   80100360 <panic>
80100fc8:	90                   	nop
80100fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 14             	sub    $0x14,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
    ilock(f->ip);
80100fdf:	8b 43 10             	mov    0x10(%ebx),%eax
80100fe2:	89 04 24             	mov    %eax,(%esp)
80100fe5:	e8 b6 07 00 00       	call   801017a0 <ilock>
    stati(f->ip, st);
80100fea:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fed:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ff1:	8b 43 10             	mov    0x10(%ebx),%eax
80100ff4:	89 04 24             	mov    %eax,(%esp)
80100ff7:	e8 24 0a 00 00       	call   80101a20 <stati>
    iunlock(f->ip);
80100ffc:	8b 43 10             	mov    0x10(%ebx),%eax
80100fff:	89 04 24             	mov    %eax,(%esp)
80101002:	e8 79 08 00 00       	call   80101880 <iunlock>
    return 0;
  }
  return -1;
}
80101007:	83 c4 14             	add    $0x14,%esp
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
8010100a:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
8010100c:	5b                   	pop    %ebx
8010100d:	5d                   	pop    %ebp
8010100e:	c3                   	ret    
8010100f:	90                   	nop
80101010:	83 c4 14             	add    $0x14,%esp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101013:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101018:	5b                   	pop    %ebx
80101019:	5d                   	pop    %ebp
8010101a:	c3                   	ret    
8010101b:	90                   	nop
8010101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101020 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 1c             	sub    $0x1c,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 68                	je     801010a0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 49                	je     80101088 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 63                	jne    801010a7 <fileread+0x87>
    ilock(f->ip);
80101044:	8b 43 10             	mov    0x10(%ebx),%eax
80101047:	89 04 24             	mov    %eax,(%esp)
8010104a:	e8 51 07 00 00       	call   801017a0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010104f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80101053:	8b 43 14             	mov    0x14(%ebx),%eax
80101056:	89 74 24 04          	mov    %esi,0x4(%esp)
8010105a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010105e:	8b 43 10             	mov    0x10(%ebx),%eax
80101061:	89 04 24             	mov    %eax,(%esp)
80101064:	e8 e7 09 00 00       	call   80101a50 <readi>
80101069:	85 c0                	test   %eax,%eax
8010106b:	89 c6                	mov    %eax,%esi
8010106d:	7e 03                	jle    80101072 <fileread+0x52>
      f->off += r;
8010106f:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101072:	8b 43 10             	mov    0x10(%ebx),%eax
80101075:	89 04 24             	mov    %eax,(%esp)
80101078:	e8 03 08 00 00       	call   80101880 <iunlock>
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010107d:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
8010107f:	83 c4 1c             	add    $0x1c,%esp
80101082:	5b                   	pop    %ebx
80101083:	5e                   	pop    %esi
80101084:	5f                   	pop    %edi
80101085:	5d                   	pop    %ebp
80101086:	c3                   	ret    
80101087:	90                   	nop
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101088:	8b 43 0c             	mov    0xc(%ebx),%eax
8010108b:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
8010108e:	83 c4 1c             	add    $0x1c,%esp
80101091:	5b                   	pop    %ebx
80101092:	5e                   	pop    %esi
80101093:	5f                   	pop    %edi
80101094:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101095:	e9 26 24 00 00       	jmp    801034c0 <piperead>
8010109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
801010a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010a5:	eb d8                	jmp    8010107f <fileread+0x5f>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
801010a7:	c7 04 24 06 6e 10 80 	movl   $0x80106e06,(%esp)
801010ae:	e8 ad f2 ff ff       	call   80100360 <panic>
801010b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801010b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801010c0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	57                   	push   %edi
801010c4:	56                   	push   %esi
801010c5:	53                   	push   %ebx
801010c6:	83 ec 2c             	sub    $0x2c,%esp
801010c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010cc:	8b 7d 08             	mov    0x8(%ebp),%edi
801010cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010d2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010d5:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
801010dc:	0f 84 ae 00 00 00    	je     80101190 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
801010e2:	8b 07                	mov    (%edi),%eax
801010e4:	83 f8 01             	cmp    $0x1,%eax
801010e7:	0f 84 c2 00 00 00    	je     801011af <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ed:	83 f8 02             	cmp    $0x2,%eax
801010f0:	0f 85 d7 00 00 00    	jne    801011cd <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010f9:	31 db                	xor    %ebx,%ebx
801010fb:	85 c0                	test   %eax,%eax
801010fd:	7f 31                	jg     80101130 <filewrite+0x70>
801010ff:	e9 9c 00 00 00       	jmp    801011a0 <filewrite+0xe0>
80101104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101108:	8b 4f 10             	mov    0x10(%edi),%ecx
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
8010110b:	01 47 14             	add    %eax,0x14(%edi)
8010110e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101111:	89 0c 24             	mov    %ecx,(%esp)
80101114:	e8 67 07 00 00       	call   80101880 <iunlock>
      end_op();
80101119:	e8 42 1b 00 00       	call   80102c60 <end_op>
8010111e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101121:	39 f0                	cmp    %esi,%eax
80101123:	0f 85 98 00 00 00    	jne    801011c1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101129:	01 c3                	add    %eax,%ebx
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010112b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010112e:	7e 70                	jle    801011a0 <filewrite+0xe0>
      int n1 = n - i;
80101130:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101133:	b8 00 06 00 00       	mov    $0x600,%eax
80101138:	29 de                	sub    %ebx,%esi
8010113a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101140:	0f 4f f0             	cmovg  %eax,%esi
      if(n1 > max)
        n1 = max;

      begin_op();
80101143:	e8 a8 1a 00 00       	call   80102bf0 <begin_op>
      ilock(f->ip);
80101148:	8b 47 10             	mov    0x10(%edi),%eax
8010114b:	89 04 24             	mov    %eax,(%esp)
8010114e:	e8 4d 06 00 00       	call   801017a0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101153:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101157:	8b 47 14             	mov    0x14(%edi),%eax
8010115a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010115e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101161:	01 d8                	add    %ebx,%eax
80101163:	89 44 24 04          	mov    %eax,0x4(%esp)
80101167:	8b 47 10             	mov    0x10(%edi),%eax
8010116a:	89 04 24             	mov    %eax,(%esp)
8010116d:	e8 de 09 00 00       	call   80101b50 <writei>
80101172:	85 c0                	test   %eax,%eax
80101174:	7f 92                	jg     80101108 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
80101176:	8b 4f 10             	mov    0x10(%edi),%ecx
80101179:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010117c:	89 0c 24             	mov    %ecx,(%esp)
8010117f:	e8 fc 06 00 00       	call   80101880 <iunlock>
      end_op();
80101184:	e8 d7 1a 00 00       	call   80102c60 <end_op>

      if(r < 0)
80101189:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010118c:	85 c0                	test   %eax,%eax
8010118e:	74 91                	je     80101121 <filewrite+0x61>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101190:	83 c4 2c             	add    $0x2c,%esp
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
80101193:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101198:	5b                   	pop    %ebx
80101199:	5e                   	pop    %esi
8010119a:	5f                   	pop    %edi
8010119b:	5d                   	pop    %ebp
8010119c:	c3                   	ret    
8010119d:	8d 76 00             	lea    0x0(%esi),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801011a0:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
801011a3:	89 d8                	mov    %ebx,%eax
801011a5:	75 e9                	jne    80101190 <filewrite+0xd0>
  }
  panic("filewrite");
}
801011a7:	83 c4 2c             	add    $0x2c,%esp
801011aa:	5b                   	pop    %ebx
801011ab:	5e                   	pop    %esi
801011ac:	5f                   	pop    %edi
801011ad:	5d                   	pop    %ebp
801011ae:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801011af:	8b 47 0c             	mov    0xc(%edi),%eax
801011b2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801011b5:	83 c4 2c             	add    $0x2c,%esp
801011b8:	5b                   	pop    %ebx
801011b9:	5e                   	pop    %esi
801011ba:	5f                   	pop    %edi
801011bb:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801011bc:	e9 0f 22 00 00       	jmp    801033d0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801011c1:	c7 04 24 0f 6e 10 80 	movl   $0x80106e0f,(%esp)
801011c8:	e8 93 f1 ff ff       	call   80100360 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801011cd:	c7 04 24 15 6e 10 80 	movl   $0x80106e15,(%esp)
801011d4:	e8 87 f1 ff ff       	call   80100360 <panic>
801011d9:	66 90                	xchg   %ax,%ax
801011db:	66 90                	xchg   %ax,%ax
801011dd:	66 90                	xchg   %ax,%ax
801011df:	90                   	nop

801011e0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011e0:	55                   	push   %ebp
801011e1:	89 e5                	mov    %esp,%ebp
801011e3:	57                   	push   %edi
801011e4:	56                   	push   %esi
801011e5:	53                   	push   %ebx
801011e6:	83 ec 2c             	sub    $0x2c,%esp
801011e9:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011ec:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011f1:	85 c0                	test   %eax,%eax
801011f3:	0f 84 8c 00 00 00    	je     80101285 <balloc+0xa5>
801011f9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101200:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101203:	89 f0                	mov    %esi,%eax
80101205:	c1 f8 0c             	sar    $0xc,%eax
80101208:	03 05 d8 09 11 80    	add    0x801109d8,%eax
8010120e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101212:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101215:	89 04 24             	mov    %eax,(%esp)
80101218:	e8 b3 ee ff ff       	call   801000d0 <bread>
8010121d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101220:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101225:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101228:	31 c0                	xor    %eax,%eax
8010122a:	eb 33                	jmp    8010125f <balloc+0x7f>
8010122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101230:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101233:	89 c2                	mov    %eax,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101235:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101237:	c1 fa 03             	sar    $0x3,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010123a:	83 e1 07             	and    $0x7,%ecx
8010123d:	bf 01 00 00 00       	mov    $0x1,%edi
80101242:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101244:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101249:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010124b:	0f b6 fb             	movzbl %bl,%edi
8010124e:	85 cf                	test   %ecx,%edi
80101250:	74 46                	je     80101298 <balloc+0xb8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101252:	83 c0 01             	add    $0x1,%eax
80101255:	83 c6 01             	add    $0x1,%esi
80101258:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010125d:	74 05                	je     80101264 <balloc+0x84>
8010125f:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101262:	72 cc                	jb     80101230 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101264:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101267:	89 04 24             	mov    %eax,(%esp)
8010126a:	e8 71 ef ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010126f:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101276:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101279:	3b 05 c0 09 11 80    	cmp    0x801109c0,%eax
8010127f:	0f 82 7b ff ff ff    	jb     80101200 <balloc+0x20>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101285:	c7 04 24 1f 6e 10 80 	movl   $0x80106e1f,(%esp)
8010128c:	e8 cf f0 ff ff       	call   80100360 <panic>
80101291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101298:	09 d9                	or     %ebx,%ecx
8010129a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010129d:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
801012a1:	89 1c 24             	mov    %ebx,(%esp)
801012a4:	e8 e7 1a 00 00       	call   80102d90 <log_write>
        brelse(bp);
801012a9:	89 1c 24             	mov    %ebx,(%esp)
801012ac:	e8 2f ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801012b1:	8b 45 d8             	mov    -0x28(%ebp),%eax
801012b4:	89 74 24 04          	mov    %esi,0x4(%esp)
801012b8:	89 04 24             	mov    %eax,(%esp)
801012bb:	e8 10 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012c0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801012c7:	00 
801012c8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801012cf:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801012d0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012d2:	8d 40 5c             	lea    0x5c(%eax),%eax
801012d5:	89 04 24             	mov    %eax,(%esp)
801012d8:	e8 a3 30 00 00       	call   80104380 <memset>
  log_write(bp);
801012dd:	89 1c 24             	mov    %ebx,(%esp)
801012e0:	e8 ab 1a 00 00       	call   80102d90 <log_write>
  brelse(bp);
801012e5:	89 1c 24             	mov    %ebx,(%esp)
801012e8:	e8 f3 ee ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801012ed:	83 c4 2c             	add    $0x2c,%esp
801012f0:	89 f0                	mov    %esi,%eax
801012f2:	5b                   	pop    %ebx
801012f3:	5e                   	pop    %esi
801012f4:	5f                   	pop    %edi
801012f5:	5d                   	pop    %ebp
801012f6:	c3                   	ret    
801012f7:	89 f6                	mov    %esi,%esi
801012f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101300 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
80101304:	89 c7                	mov    %eax,%edi
80101306:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101307:	31 f6                	xor    %esi,%esi
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101309:	53                   	push   %ebx

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010130f:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101312:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101319:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010131c:	e8 9f 2f 00 00       	call   801042c0 <acquire>

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101321:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101324:	eb 14                	jmp    8010133a <iget+0x3a>
80101326:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101328:	85 f6                	test   %esi,%esi
8010132a:	74 3c                	je     80101368 <iget+0x68>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010132c:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101332:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101338:	74 46                	je     80101380 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010133a:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010133d:	85 c9                	test   %ecx,%ecx
8010133f:	7e e7                	jle    80101328 <iget+0x28>
80101341:	39 3b                	cmp    %edi,(%ebx)
80101343:	75 e3                	jne    80101328 <iget+0x28>
80101345:	39 53 04             	cmp    %edx,0x4(%ebx)
80101348:	75 de                	jne    80101328 <iget+0x28>
      ip->ref++;
8010134a:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
8010134d:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010134f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101356:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101359:	e8 d2 2f 00 00       	call   80104330 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010135e:	83 c4 1c             	add    $0x1c,%esp
80101361:	89 f0                	mov    %esi,%eax
80101363:	5b                   	pop    %ebx
80101364:	5e                   	pop    %esi
80101365:	5f                   	pop    %edi
80101366:	5d                   	pop    %ebp
80101367:	c3                   	ret    
80101368:	85 c9                	test   %ecx,%ecx
8010136a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101373:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101379:	75 bf                	jne    8010133a <iget+0x3a>
8010137b:	90                   	nop
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101380:	85 f6                	test   %esi,%esi
80101382:	74 29                	je     801013ad <iget+0xad>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101384:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101386:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101389:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101390:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101397:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010139e:	e8 8d 2f 00 00       	call   80104330 <release>

  return ip;
}
801013a3:	83 c4 1c             	add    $0x1c,%esp
801013a6:	89 f0                	mov    %esi,%eax
801013a8:	5b                   	pop    %ebx
801013a9:	5e                   	pop    %esi
801013aa:	5f                   	pop    %edi
801013ab:	5d                   	pop    %ebp
801013ac:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801013ad:	c7 04 24 35 6e 10 80 	movl   $0x80106e35,(%esp)
801013b4:	e8 a7 ef ff ff       	call   80100360 <panic>
801013b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801013c0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	57                   	push   %edi
801013c4:	56                   	push   %esi
801013c5:	53                   	push   %ebx
801013c6:	89 c3                	mov    %eax,%ebx
801013c8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013cb:	83 fa 0b             	cmp    $0xb,%edx
801013ce:	77 18                	ja     801013e8 <bmap+0x28>
801013d0:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
801013d3:	8b 46 5c             	mov    0x5c(%esi),%eax
801013d6:	85 c0                	test   %eax,%eax
801013d8:	74 66                	je     80101440 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013da:	83 c4 1c             	add    $0x1c,%esp
801013dd:	5b                   	pop    %ebx
801013de:	5e                   	pop    %esi
801013df:	5f                   	pop    %edi
801013e0:	5d                   	pop    %ebp
801013e1:	c3                   	ret    
801013e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013e8:	8d 72 f4             	lea    -0xc(%edx),%esi

  if(bn < NINDIRECT){
801013eb:	83 fe 7f             	cmp    $0x7f,%esi
801013ee:	77 77                	ja     80101467 <bmap+0xa7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013f0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801013f6:	85 c0                	test   %eax,%eax
801013f8:	74 5e                	je     80101458 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801013fe:	8b 03                	mov    (%ebx),%eax
80101400:	89 04 24             	mov    %eax,(%esp)
80101403:	e8 c8 ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101408:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010140c:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
8010140e:	8b 32                	mov    (%edx),%esi
80101410:	85 f6                	test   %esi,%esi
80101412:	75 19                	jne    8010142d <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
80101414:	8b 03                	mov    (%ebx),%eax
80101416:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101419:	e8 c2 fd ff ff       	call   801011e0 <balloc>
8010141e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101421:	89 02                	mov    %eax,(%edx)
80101423:	89 c6                	mov    %eax,%esi
      log_write(bp);
80101425:	89 3c 24             	mov    %edi,(%esp)
80101428:	e8 63 19 00 00       	call   80102d90 <log_write>
    }
    brelse(bp);
8010142d:	89 3c 24             	mov    %edi,(%esp)
80101430:	e8 ab ed ff ff       	call   801001e0 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
80101435:	83 c4 1c             	add    $0x1c,%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101438:	89 f0                	mov    %esi,%eax
    return addr;
  }

  panic("bmap: out of range");
}
8010143a:	5b                   	pop    %ebx
8010143b:	5e                   	pop    %esi
8010143c:	5f                   	pop    %edi
8010143d:	5d                   	pop    %ebp
8010143e:	c3                   	ret    
8010143f:	90                   	nop
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101440:	8b 03                	mov    (%ebx),%eax
80101442:	e8 99 fd ff ff       	call   801011e0 <balloc>
80101447:	89 46 5c             	mov    %eax,0x5c(%esi)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010144a:	83 c4 1c             	add    $0x1c,%esp
8010144d:	5b                   	pop    %ebx
8010144e:	5e                   	pop    %esi
8010144f:	5f                   	pop    %edi
80101450:	5d                   	pop    %ebp
80101451:	c3                   	ret    
80101452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101458:	8b 03                	mov    (%ebx),%eax
8010145a:	e8 81 fd ff ff       	call   801011e0 <balloc>
8010145f:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101465:	eb 93                	jmp    801013fa <bmap+0x3a>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101467:	c7 04 24 45 6e 10 80 	movl   $0x80106e45,(%esp)
8010146e:	e8 ed ee ff ff       	call   80100360 <panic>
80101473:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101480 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	56                   	push   %esi
80101484:	53                   	push   %ebx
80101485:	83 ec 10             	sub    $0x10,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101488:	8b 45 08             	mov    0x8(%ebp),%eax
8010148b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101492:	00 
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101493:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101496:	89 04 24             	mov    %eax,(%esp)
80101499:	e8 32 ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010149e:	89 34 24             	mov    %esi,(%esp)
801014a1:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
801014a8:	00 
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
801014a9:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801014ab:	8d 40 5c             	lea    0x5c(%eax),%eax
801014ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801014b2:	e8 69 2f 00 00       	call   80104420 <memmove>
  brelse(bp);
801014b7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801014ba:	83 c4 10             	add    $0x10,%esp
801014bd:	5b                   	pop    %ebx
801014be:	5e                   	pop    %esi
801014bf:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801014c0:	e9 1b ed ff ff       	jmp    801001e0 <brelse>
801014c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801014c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014d0:	55                   	push   %ebp
801014d1:	89 e5                	mov    %esp,%ebp
801014d3:	57                   	push   %edi
801014d4:	89 d7                	mov    %edx,%edi
801014d6:	56                   	push   %esi
801014d7:	53                   	push   %ebx
801014d8:	89 c3                	mov    %eax,%ebx
801014da:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801014dd:	89 04 24             	mov    %eax,(%esp)
801014e0:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801014e7:	80 
801014e8:	e8 93 ff ff ff       	call   80101480 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014ed:	89 fa                	mov    %edi,%edx
801014ef:	c1 ea 0c             	shr    $0xc,%edx
801014f2:	03 15 d8 09 11 80    	add    0x801109d8,%edx
801014f8:	89 1c 24             	mov    %ebx,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
801014fb:	bb 01 00 00 00       	mov    $0x1,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
80101500:	89 54 24 04          	mov    %edx,0x4(%esp)
80101504:	e8 c7 eb ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101509:	89 f9                	mov    %edi,%ecx
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
8010150b:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80101511:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
80101513:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101516:	c1 fa 03             	sar    $0x3,%edx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101519:	d3 e3                	shl    %cl,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
8010151b:	89 c6                	mov    %eax,%esi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
8010151d:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101522:	0f b6 c8             	movzbl %al,%ecx
80101525:	85 d9                	test   %ebx,%ecx
80101527:	74 20                	je     80101549 <bfree+0x79>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101529:	f7 d3                	not    %ebx
8010152b:	21 c3                	and    %eax,%ebx
8010152d:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
80101531:	89 34 24             	mov    %esi,(%esp)
80101534:	e8 57 18 00 00       	call   80102d90 <log_write>
  brelse(bp);
80101539:	89 34 24             	mov    %esi,(%esp)
8010153c:	e8 9f ec ff ff       	call   801001e0 <brelse>
}
80101541:	83 c4 1c             	add    $0x1c,%esp
80101544:	5b                   	pop    %ebx
80101545:	5e                   	pop    %esi
80101546:	5f                   	pop    %edi
80101547:	5d                   	pop    %ebp
80101548:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101549:	c7 04 24 58 6e 10 80 	movl   $0x80106e58,(%esp)
80101550:	e8 0b ee ff ff       	call   80100360 <panic>
80101555:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101560 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	53                   	push   %ebx
80101564:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101569:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010156c:	c7 44 24 04 6b 6e 10 	movl   $0x80106e6b,0x4(%esp)
80101573:	80 
80101574:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010157b:	e8 d0 2b 00 00       	call   80104150 <initlock>
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	89 1c 24             	mov    %ebx,(%esp)
80101583:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101589:	c7 44 24 04 72 6e 10 	movl   $0x80106e72,0x4(%esp)
80101590:	80 
80101591:	e8 8a 2a 00 00       	call   80104020 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101596:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010159c:	75 e2                	jne    80101580 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010159e:	8b 45 08             	mov    0x8(%ebp),%eax
801015a1:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801015a8:	80 
801015a9:	89 04 24             	mov    %eax,(%esp)
801015ac:	e8 cf fe ff ff       	call   80101480 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015b1:	a1 d8 09 11 80       	mov    0x801109d8,%eax
801015b6:	c7 04 24 d8 6e 10 80 	movl   $0x80106ed8,(%esp)
801015bd:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801015c1:	a1 d4 09 11 80       	mov    0x801109d4,%eax
801015c6:	89 44 24 18          	mov    %eax,0x18(%esp)
801015ca:	a1 d0 09 11 80       	mov    0x801109d0,%eax
801015cf:	89 44 24 14          	mov    %eax,0x14(%esp)
801015d3:	a1 cc 09 11 80       	mov    0x801109cc,%eax
801015d8:	89 44 24 10          	mov    %eax,0x10(%esp)
801015dc:	a1 c8 09 11 80       	mov    0x801109c8,%eax
801015e1:	89 44 24 0c          	mov    %eax,0xc(%esp)
801015e5:	a1 c4 09 11 80       	mov    0x801109c4,%eax
801015ea:	89 44 24 08          	mov    %eax,0x8(%esp)
801015ee:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801015f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801015f7:	e8 24 f1 ff ff       	call   80100720 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801015fc:	83 c4 24             	add    $0x24,%esp
801015ff:	5b                   	pop    %ebx
80101600:	5d                   	pop    %ebp
80101601:	c3                   	ret    
80101602:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101610 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
80101614:	56                   	push   %esi
80101615:	53                   	push   %ebx
80101616:	83 ec 2c             	sub    $0x2c,%esp
80101619:	8b 45 0c             	mov    0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010161c:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101623:	8b 7d 08             	mov    0x8(%ebp),%edi
80101626:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101629:	0f 86 a2 00 00 00    	jbe    801016d1 <ialloc+0xc1>
8010162f:	be 01 00 00 00       	mov    $0x1,%esi
80101634:	bb 01 00 00 00       	mov    $0x1,%ebx
80101639:	eb 1a                	jmp    80101655 <ialloc+0x45>
8010163b:	90                   	nop
8010163c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101640:	89 14 24             	mov    %edx,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101643:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101646:	e8 95 eb ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010164b:	89 de                	mov    %ebx,%esi
8010164d:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101653:	73 7c                	jae    801016d1 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
80101655:	89 f0                	mov    %esi,%eax
80101657:	c1 e8 03             	shr    $0x3,%eax
8010165a:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101660:	89 3c 24             	mov    %edi,(%esp)
80101663:	89 44 24 04          	mov    %eax,0x4(%esp)
80101667:	e8 64 ea ff ff       	call   801000d0 <bread>
8010166c:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
8010166e:	89 f0                	mov    %esi,%eax
80101670:	83 e0 07             	and    $0x7,%eax
80101673:	c1 e0 06             	shl    $0x6,%eax
80101676:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010167a:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010167e:	75 c0                	jne    80101640 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101680:	89 0c 24             	mov    %ecx,(%esp)
80101683:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010168a:	00 
8010168b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101692:	00 
80101693:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101696:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101699:	e8 e2 2c 00 00       	call   80104380 <memset>
      dip->type = type;
8010169e:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
801016a2:	8b 55 dc             	mov    -0x24(%ebp),%edx
  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
801016a5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
801016a8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
801016ab:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016ae:	89 14 24             	mov    %edx,(%esp)
801016b1:	e8 da 16 00 00       	call   80102d90 <log_write>
      brelse(bp);
801016b6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801016b9:	89 14 24             	mov    %edx,(%esp)
801016bc:	e8 1f eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801016c1:	83 c4 2c             	add    $0x2c,%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801016c4:	89 f2                	mov    %esi,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801016c6:	5b                   	pop    %ebx
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801016c7:	89 f8                	mov    %edi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801016c9:	5e                   	pop    %esi
801016ca:	5f                   	pop    %edi
801016cb:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801016cc:	e9 2f fc ff ff       	jmp    80101300 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801016d1:	c7 04 24 78 6e 10 80 	movl   $0x80106e78,(%esp)
801016d8:	e8 83 ec ff ff       	call   80100360 <panic>
801016dd:	8d 76 00             	lea    0x0(%esi),%esi

801016e0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	56                   	push   %esi
801016e4:	53                   	push   %ebx
801016e5:	83 ec 10             	sub    $0x10,%esp
801016e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016eb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ee:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016f1:	c1 e8 03             	shr    $0x3,%eax
801016f4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801016fe:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101701:	89 04 24             	mov    %eax,(%esp)
80101704:	e8 c7 e9 ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101709:	8b 53 a8             	mov    -0x58(%ebx),%edx
8010170c:	83 e2 07             	and    $0x7,%edx
8010170f:	c1 e2 06             	shl    $0x6,%edx
80101712:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101716:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
80101718:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010171c:	83 c2 0c             	add    $0xc,%edx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
8010171f:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
80101723:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
80101727:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
8010172b:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
8010172f:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
80101733:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
80101737:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
8010173b:	8b 43 fc             	mov    -0x4(%ebx),%eax
8010173e:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101741:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101745:	89 14 24             	mov    %edx,(%esp)
80101748:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010174f:	00 
80101750:	e8 cb 2c 00 00       	call   80104420 <memmove>
  log_write(bp);
80101755:	89 34 24             	mov    %esi,(%esp)
80101758:	e8 33 16 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010175d:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101760:	83 c4 10             	add    $0x10,%esp
80101763:	5b                   	pop    %ebx
80101764:	5e                   	pop    %esi
80101765:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
80101766:	e9 75 ea ff ff       	jmp    801001e0 <brelse>
8010176b:	90                   	nop
8010176c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101770 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	53                   	push   %ebx
80101774:	83 ec 14             	sub    $0x14,%esp
80101777:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010177a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101781:	e8 3a 2b 00 00       	call   801042c0 <acquire>
  ip->ref++;
80101786:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010178a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101791:	e8 9a 2b 00 00       	call   80104330 <release>
  return ip;
}
80101796:	83 c4 14             	add    $0x14,%esp
80101799:	89 d8                	mov    %ebx,%eax
8010179b:	5b                   	pop    %ebx
8010179c:	5d                   	pop    %ebp
8010179d:	c3                   	ret    
8010179e:	66 90                	xchg   %ax,%ax

801017a0 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	56                   	push   %esi
801017a4:	53                   	push   %ebx
801017a5:	83 ec 10             	sub    $0x10,%esp
801017a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801017ab:	85 db                	test   %ebx,%ebx
801017ad:	0f 84 b3 00 00 00    	je     80101866 <ilock+0xc6>
801017b3:	8b 53 08             	mov    0x8(%ebx),%edx
801017b6:	85 d2                	test   %edx,%edx
801017b8:	0f 8e a8 00 00 00    	jle    80101866 <ilock+0xc6>
    panic("ilock");

  acquiresleep(&ip->lock);
801017be:	8d 43 0c             	lea    0xc(%ebx),%eax
801017c1:	89 04 24             	mov    %eax,(%esp)
801017c4:	e8 97 28 00 00       	call   80104060 <acquiresleep>

  if(ip->valid == 0){
801017c9:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017cc:	85 c0                	test   %eax,%eax
801017ce:	74 08                	je     801017d8 <ilock+0x38>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801017d0:	83 c4 10             	add    $0x10,%esp
801017d3:	5b                   	pop    %ebx
801017d4:	5e                   	pop    %esi
801017d5:	5d                   	pop    %ebp
801017d6:	c3                   	ret    
801017d7:	90                   	nop
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017d8:	8b 43 04             	mov    0x4(%ebx),%eax
801017db:	c1 e8 03             	shr    $0x3,%eax
801017de:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801017e4:	89 44 24 04          	mov    %eax,0x4(%esp)
801017e8:	8b 03                	mov    (%ebx),%eax
801017ea:	89 04 24             	mov    %eax,(%esp)
801017ed:	e8 de e8 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017f2:	8b 53 04             	mov    0x4(%ebx),%edx
801017f5:	83 e2 07             	and    $0x7,%edx
801017f8:	c1 e2 06             	shl    $0x6,%edx
801017fb:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ff:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
80101801:	0f b7 02             	movzwl (%edx),%eax
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101804:	83 c2 0c             	add    $0xc,%edx
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
80101807:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010180b:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
8010180f:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101813:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
80101817:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
8010181b:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
8010181f:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
80101823:	8b 42 fc             	mov    -0x4(%edx),%eax
80101826:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101829:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010182c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101830:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101837:	00 
80101838:	89 04 24             	mov    %eax,(%esp)
8010183b:	e8 e0 2b 00 00       	call   80104420 <memmove>
    brelse(bp);
80101840:	89 34 24             	mov    %esi,(%esp)
80101843:	e8 98 e9 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101848:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010184d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101854:	0f 85 76 ff ff ff    	jne    801017d0 <ilock+0x30>
      panic("ilock: no type");
8010185a:	c7 04 24 90 6e 10 80 	movl   $0x80106e90,(%esp)
80101861:	e8 fa ea ff ff       	call   80100360 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101866:	c7 04 24 8a 6e 10 80 	movl   $0x80106e8a,(%esp)
8010186d:	e8 ee ea ff ff       	call   80100360 <panic>
80101872:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101880 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	56                   	push   %esi
80101884:	53                   	push   %ebx
80101885:	83 ec 10             	sub    $0x10,%esp
80101888:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010188b:	85 db                	test   %ebx,%ebx
8010188d:	74 24                	je     801018b3 <iunlock+0x33>
8010188f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101892:	89 34 24             	mov    %esi,(%esp)
80101895:	e8 66 28 00 00       	call   80104100 <holdingsleep>
8010189a:	85 c0                	test   %eax,%eax
8010189c:	74 15                	je     801018b3 <iunlock+0x33>
8010189e:	8b 43 08             	mov    0x8(%ebx),%eax
801018a1:	85 c0                	test   %eax,%eax
801018a3:	7e 0e                	jle    801018b3 <iunlock+0x33>
    panic("iunlock");

  releasesleep(&ip->lock);
801018a5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018a8:	83 c4 10             	add    $0x10,%esp
801018ab:	5b                   	pop    %ebx
801018ac:	5e                   	pop    %esi
801018ad:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
801018ae:	e9 0d 28 00 00       	jmp    801040c0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
801018b3:	c7 04 24 9f 6e 10 80 	movl   $0x80106e9f,(%esp)
801018ba:	e8 a1 ea ff ff       	call   80100360 <panic>
801018bf:	90                   	nop

801018c0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	83 ec 1c             	sub    $0x1c,%esp
801018c9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801018cc:	8d 7e 0c             	lea    0xc(%esi),%edi
801018cf:	89 3c 24             	mov    %edi,(%esp)
801018d2:	e8 89 27 00 00       	call   80104060 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018d7:	8b 56 4c             	mov    0x4c(%esi),%edx
801018da:	85 d2                	test   %edx,%edx
801018dc:	74 07                	je     801018e5 <iput+0x25>
801018de:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801018e3:	74 2b                	je     80101910 <iput+0x50>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801018e5:	89 3c 24             	mov    %edi,(%esp)
801018e8:	e8 d3 27 00 00       	call   801040c0 <releasesleep>

  acquire(&icache.lock);
801018ed:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018f4:	e8 c7 29 00 00       	call   801042c0 <acquire>
  ip->ref--;
801018f9:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801018fd:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101904:	83 c4 1c             	add    $0x1c,%esp
80101907:	5b                   	pop    %ebx
80101908:	5e                   	pop    %esi
80101909:	5f                   	pop    %edi
8010190a:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
8010190b:	e9 20 2a 00 00       	jmp    80104330 <release>
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101910:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101917:	e8 a4 29 00 00       	call   801042c0 <acquire>
    int r = ip->ref;
8010191c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010191f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101926:	e8 05 2a 00 00       	call   80104330 <release>
    if(r == 1){
8010192b:	83 fb 01             	cmp    $0x1,%ebx
8010192e:	75 b5                	jne    801018e5 <iput+0x25>
80101930:	8d 4e 30             	lea    0x30(%esi),%ecx
80101933:	89 f3                	mov    %esi,%ebx
80101935:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101938:	89 cf                	mov    %ecx,%edi
8010193a:	eb 0b                	jmp    80101947 <iput+0x87>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101940:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101943:	39 fb                	cmp    %edi,%ebx
80101945:	74 19                	je     80101960 <iput+0xa0>
    if(ip->addrs[i]){
80101947:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010194a:	85 d2                	test   %edx,%edx
8010194c:	74 f2                	je     80101940 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
8010194e:	8b 06                	mov    (%esi),%eax
80101950:	e8 7b fb ff ff       	call   801014d0 <bfree>
      ip->addrs[i] = 0;
80101955:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
8010195c:	eb e2                	jmp    80101940 <iput+0x80>
8010195e:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
80101960:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101966:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101969:	85 c0                	test   %eax,%eax
8010196b:	75 2b                	jne    80101998 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010196d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101974:	89 34 24             	mov    %esi,(%esp)
80101977:	e8 64 fd ff ff       	call   801016e0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010197c:	31 c0                	xor    %eax,%eax
8010197e:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101982:	89 34 24             	mov    %esi,(%esp)
80101985:	e8 56 fd ff ff       	call   801016e0 <iupdate>
      ip->valid = 0;
8010198a:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101991:	e9 4f ff ff ff       	jmp    801018e5 <iput+0x25>
80101996:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101998:	89 44 24 04          	mov    %eax,0x4(%esp)
8010199c:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
8010199e:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019a0:	89 04 24             	mov    %eax,(%esp)
801019a3:	e8 28 e7 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
801019a8:	89 7d e0             	mov    %edi,-0x20(%ebp)
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
801019ab:	8d 48 5c             	lea    0x5c(%eax),%ecx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
801019b1:	89 cf                	mov    %ecx,%edi
801019b3:	31 c0                	xor    %eax,%eax
801019b5:	eb 0e                	jmp    801019c5 <iput+0x105>
801019b7:	90                   	nop
801019b8:	83 c3 01             	add    $0x1,%ebx
801019bb:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
801019c1:	89 d8                	mov    %ebx,%eax
801019c3:	74 10                	je     801019d5 <iput+0x115>
      if(a[j])
801019c5:	8b 14 87             	mov    (%edi,%eax,4),%edx
801019c8:	85 d2                	test   %edx,%edx
801019ca:	74 ec                	je     801019b8 <iput+0xf8>
        bfree(ip->dev, a[j]);
801019cc:	8b 06                	mov    (%esi),%eax
801019ce:	e8 fd fa ff ff       	call   801014d0 <bfree>
801019d3:	eb e3                	jmp    801019b8 <iput+0xf8>
    }
    brelse(bp);
801019d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019d8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019db:	89 04 24             	mov    %eax,(%esp)
801019de:	e8 fd e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019e3:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801019e9:	8b 06                	mov    (%esi),%eax
801019eb:	e8 e0 fa ff ff       	call   801014d0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019f0:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801019f7:	00 00 00 
801019fa:	e9 6e ff ff ff       	jmp    8010196d <iput+0xad>
801019ff:	90                   	nop

80101a00 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	53                   	push   %ebx
80101a04:	83 ec 14             	sub    $0x14,%esp
80101a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a0a:	89 1c 24             	mov    %ebx,(%esp)
80101a0d:	e8 6e fe ff ff       	call   80101880 <iunlock>
  iput(ip);
80101a12:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101a15:	83 c4 14             	add    $0x14,%esp
80101a18:	5b                   	pop    %ebx
80101a19:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101a1a:	e9 a1 fe ff ff       	jmp    801018c0 <iput>
80101a1f:	90                   	nop

80101a20 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	8b 55 08             	mov    0x8(%ebp),%edx
80101a26:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a29:	8b 0a                	mov    (%edx),%ecx
80101a2b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a2e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a31:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a34:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a38:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a3b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a3f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a43:	8b 52 58             	mov    0x58(%edx),%edx
80101a46:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a49:	5d                   	pop    %ebp
80101a4a:	c3                   	ret    
80101a4b:	90                   	nop
80101a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a50 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	57                   	push   %edi
80101a54:	56                   	push   %esi
80101a55:	53                   	push   %ebx
80101a56:	83 ec 2c             	sub    $0x2c,%esp
80101a59:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a5c:	8b 7d 08             	mov    0x8(%ebp),%edi
80101a5f:	8b 75 10             	mov    0x10(%ebp),%esi
80101a62:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a65:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a68:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a70:	0f 84 aa 00 00 00    	je     80101b20 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a76:	8b 47 58             	mov    0x58(%edi),%eax
80101a79:	39 f0                	cmp    %esi,%eax
80101a7b:	0f 82 c7 00 00 00    	jb     80101b48 <readi+0xf8>
80101a81:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a84:	89 da                	mov    %ebx,%edx
80101a86:	01 f2                	add    %esi,%edx
80101a88:	0f 82 ba 00 00 00    	jb     80101b48 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a8e:	89 c1                	mov    %eax,%ecx
80101a90:	29 f1                	sub    %esi,%ecx
80101a92:	39 d0                	cmp    %edx,%eax
80101a94:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a97:	31 c0                	xor    %eax,%eax
80101a99:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a9b:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a9e:	74 70                	je     80101b10 <readi+0xc0>
80101aa0:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101aa3:	89 c7                	mov    %eax,%edi
80101aa5:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa8:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101aab:	89 f2                	mov    %esi,%edx
80101aad:	c1 ea 09             	shr    $0x9,%edx
80101ab0:	89 d8                	mov    %ebx,%eax
80101ab2:	e8 09 f9 ff ff       	call   801013c0 <bmap>
80101ab7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101abb:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101abd:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac2:	89 04 24             	mov    %eax,(%esp)
80101ac5:	e8 06 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aca:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101acd:	29 f9                	sub    %edi,%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101acf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101ad1:	89 f0                	mov    %esi,%eax
80101ad3:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ad8:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ada:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101ade:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ae0:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ae4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae7:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101aea:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101aee:	01 df                	add    %ebx,%edi
80101af0:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101af2:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101af5:	89 04 24             	mov    %eax,(%esp)
80101af8:	e8 23 29 00 00       	call   80104420 <memmove>
    brelse(bp);
80101afd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b00:	89 14 24             	mov    %edx,(%esp)
80101b03:	e8 d8 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b08:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b0b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b0e:	77 98                	ja     80101aa8 <readi+0x58>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101b10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b13:	83 c4 2c             	add    $0x2c,%esp
80101b16:	5b                   	pop    %ebx
80101b17:	5e                   	pop    %esi
80101b18:	5f                   	pop    %edi
80101b19:	5d                   	pop    %ebp
80101b1a:	c3                   	ret    
80101b1b:	90                   	nop
80101b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b20:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101b24:	66 83 f8 09          	cmp    $0x9,%ax
80101b28:	77 1e                	ja     80101b48 <readi+0xf8>
80101b2a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101b31:	85 c0                	test   %eax,%eax
80101b33:	74 13                	je     80101b48 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101b35:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101b38:	89 75 10             	mov    %esi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101b3b:	83 c4 2c             	add    $0x2c,%esp
80101b3e:	5b                   	pop    %ebx
80101b3f:	5e                   	pop    %esi
80101b40:	5f                   	pop    %edi
80101b41:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101b42:	ff e0                	jmp    *%eax
80101b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101b48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b4d:	eb c4                	jmp    80101b13 <readi+0xc3>
80101b4f:	90                   	nop

80101b50 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	57                   	push   %edi
80101b54:	56                   	push   %esi
80101b55:	53                   	push   %ebx
80101b56:	83 ec 2c             	sub    $0x2c,%esp
80101b59:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b5f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b62:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b67:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b6a:	8b 75 10             	mov    0x10(%ebp),%esi
80101b6d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b70:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b73:	0f 84 b7 00 00 00    	je     80101c30 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b7c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b7f:	0f 82 e3 00 00 00    	jb     80101c68 <writei+0x118>
80101b85:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b88:	89 c8                	mov    %ecx,%eax
80101b8a:	01 f0                	add    %esi,%eax
80101b8c:	0f 82 d6 00 00 00    	jb     80101c68 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b92:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b97:	0f 87 cb 00 00 00    	ja     80101c68 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b9d:	85 c9                	test   %ecx,%ecx
80101b9f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ba6:	74 77                	je     80101c1f <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ba8:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bab:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bad:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bb2:	c1 ea 09             	shr    $0x9,%edx
80101bb5:	89 f8                	mov    %edi,%eax
80101bb7:	e8 04 f8 ff ff       	call   801013c0 <bmap>
80101bbc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101bc0:	8b 07                	mov    (%edi),%eax
80101bc2:	89 04 24             	mov    %eax,(%esp)
80101bc5:	e8 06 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bca:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101bcd:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101bd0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bd3:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd5:	89 f0                	mov    %esi,%eax
80101bd7:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bdc:	29 c3                	sub    %eax,%ebx
80101bde:	39 cb                	cmp    %ecx,%ebx
80101be0:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101be3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be7:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101be9:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bed:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101bf1:	89 04 24             	mov    %eax,(%esp)
80101bf4:	e8 27 28 00 00       	call   80104420 <memmove>
    log_write(bp);
80101bf9:	89 3c 24             	mov    %edi,(%esp)
80101bfc:	e8 8f 11 00 00       	call   80102d90 <log_write>
    brelse(bp);
80101c01:	89 3c 24             	mov    %edi,(%esp)
80101c04:	e8 d7 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c09:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c0f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c12:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c15:	77 91                	ja     80101ba8 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101c17:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c1a:	39 70 58             	cmp    %esi,0x58(%eax)
80101c1d:	72 39                	jb     80101c58 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c22:	83 c4 2c             	add    $0x2c,%esp
80101c25:	5b                   	pop    %ebx
80101c26:	5e                   	pop    %esi
80101c27:	5f                   	pop    %edi
80101c28:	5d                   	pop    %ebp
80101c29:	c3                   	ret    
80101c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c34:	66 83 f8 09          	cmp    $0x9,%ax
80101c38:	77 2e                	ja     80101c68 <writei+0x118>
80101c3a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101c41:	85 c0                	test   %eax,%eax
80101c43:	74 23                	je     80101c68 <writei+0x118>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101c45:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101c48:	83 c4 2c             	add    $0x2c,%esp
80101c4b:	5b                   	pop    %ebx
80101c4c:	5e                   	pop    %esi
80101c4d:	5f                   	pop    %edi
80101c4e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101c4f:	ff e0                	jmp    *%eax
80101c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101c58:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c5b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c5e:	89 04 24             	mov    %eax,(%esp)
80101c61:	e8 7a fa ff ff       	call   801016e0 <iupdate>
80101c66:	eb b7                	jmp    80101c1f <writei+0xcf>
  }
  return n;
}
80101c68:	83 c4 2c             	add    $0x2c,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101c6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101c70:	5b                   	pop    %ebx
80101c71:	5e                   	pop    %esi
80101c72:	5f                   	pop    %edi
80101c73:	5d                   	pop    %ebp
80101c74:	c3                   	ret    
80101c75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c80 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101c86:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c89:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101c90:	00 
80101c91:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c95:	8b 45 08             	mov    0x8(%ebp),%eax
80101c98:	89 04 24             	mov    %eax,(%esp)
80101c9b:	e8 00 28 00 00       	call   801044a0 <strncmp>
}
80101ca0:	c9                   	leave  
80101ca1:	c3                   	ret    
80101ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101cb0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	57                   	push   %edi
80101cb4:	56                   	push   %esi
80101cb5:	53                   	push   %ebx
80101cb6:	83 ec 2c             	sub    $0x2c,%esp
80101cb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cc1:	0f 85 97 00 00 00    	jne    80101d5e <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101cc7:	8b 53 58             	mov    0x58(%ebx),%edx
80101cca:	31 ff                	xor    %edi,%edi
80101ccc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ccf:	85 d2                	test   %edx,%edx
80101cd1:	75 0d                	jne    80101ce0 <dirlookup+0x30>
80101cd3:	eb 73                	jmp    80101d48 <dirlookup+0x98>
80101cd5:	8d 76 00             	lea    0x0(%esi),%esi
80101cd8:	83 c7 10             	add    $0x10,%edi
80101cdb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101cde:	76 68                	jbe    80101d48 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ce0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ce7:	00 
80101ce8:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101cec:	89 74 24 04          	mov    %esi,0x4(%esp)
80101cf0:	89 1c 24             	mov    %ebx,(%esp)
80101cf3:	e8 58 fd ff ff       	call   80101a50 <readi>
80101cf8:	83 f8 10             	cmp    $0x10,%eax
80101cfb:	75 55                	jne    80101d52 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101cfd:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d02:	74 d4                	je     80101cd8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101d04:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d07:	89 44 24 04          	mov    %eax,0x4(%esp)
80101d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d0e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d15:	00 
80101d16:	89 04 24             	mov    %eax,(%esp)
80101d19:	e8 82 27 00 00       	call   801044a0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101d1e:	85 c0                	test   %eax,%eax
80101d20:	75 b6                	jne    80101cd8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101d22:	8b 45 10             	mov    0x10(%ebp),%eax
80101d25:	85 c0                	test   %eax,%eax
80101d27:	74 05                	je     80101d2e <dirlookup+0x7e>
        *poff = off;
80101d29:	8b 45 10             	mov    0x10(%ebp),%eax
80101d2c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d2e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d32:	8b 03                	mov    (%ebx),%eax
80101d34:	e8 c7 f5 ff ff       	call   80101300 <iget>
    }
  }

  return 0;
}
80101d39:	83 c4 2c             	add    $0x2c,%esp
80101d3c:	5b                   	pop    %ebx
80101d3d:	5e                   	pop    %esi
80101d3e:	5f                   	pop    %edi
80101d3f:	5d                   	pop    %ebp
80101d40:	c3                   	ret    
80101d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d48:	83 c4 2c             	add    $0x2c,%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101d4b:	31 c0                	xor    %eax,%eax
}
80101d4d:	5b                   	pop    %ebx
80101d4e:	5e                   	pop    %esi
80101d4f:	5f                   	pop    %edi
80101d50:	5d                   	pop    %ebp
80101d51:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101d52:	c7 04 24 b9 6e 10 80 	movl   $0x80106eb9,(%esp)
80101d59:	e8 02 e6 ff ff       	call   80100360 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101d5e:	c7 04 24 a7 6e 10 80 	movl   $0x80106ea7,(%esp)
80101d65:	e8 f6 e5 ff ff       	call   80100360 <panic>
80101d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d70:	55                   	push   %ebp
80101d71:	89 e5                	mov    %esp,%ebp
80101d73:	57                   	push   %edi
80101d74:	89 cf                	mov    %ecx,%edi
80101d76:	56                   	push   %esi
80101d77:	53                   	push   %ebx
80101d78:	89 c3                	mov    %eax,%ebx
80101d7a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d7d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101d83:	0f 84 51 01 00 00    	je     80101eda <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d89:	e8 f2 19 00 00       	call   80103780 <myproc>
80101d8e:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101d91:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d98:	e8 23 25 00 00       	call   801042c0 <acquire>
  ip->ref++;
80101d9d:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101da1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101da8:	e8 83 25 00 00       	call   80104330 <release>
80101dad:	eb 04                	jmp    80101db3 <namex+0x43>
80101daf:	90                   	nop
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101db0:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101db3:	0f b6 03             	movzbl (%ebx),%eax
80101db6:	3c 2f                	cmp    $0x2f,%al
80101db8:	74 f6                	je     80101db0 <namex+0x40>
    path++;
  if(*path == 0)
80101dba:	84 c0                	test   %al,%al
80101dbc:	0f 84 ed 00 00 00    	je     80101eaf <namex+0x13f>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101dc2:	0f b6 03             	movzbl (%ebx),%eax
80101dc5:	89 da                	mov    %ebx,%edx
80101dc7:	84 c0                	test   %al,%al
80101dc9:	0f 84 b1 00 00 00    	je     80101e80 <namex+0x110>
80101dcf:	3c 2f                	cmp    $0x2f,%al
80101dd1:	75 0f                	jne    80101de2 <namex+0x72>
80101dd3:	e9 a8 00 00 00       	jmp    80101e80 <namex+0x110>
80101dd8:	3c 2f                	cmp    $0x2f,%al
80101dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101de0:	74 0a                	je     80101dec <namex+0x7c>
    path++;
80101de2:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101de5:	0f b6 02             	movzbl (%edx),%eax
80101de8:	84 c0                	test   %al,%al
80101dea:	75 ec                	jne    80101dd8 <namex+0x68>
80101dec:	89 d1                	mov    %edx,%ecx
80101dee:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101df0:	83 f9 0d             	cmp    $0xd,%ecx
80101df3:	0f 8e 8f 00 00 00    	jle    80101e88 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101df9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dfd:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101e04:	00 
80101e05:	89 3c 24             	mov    %edi,(%esp)
80101e08:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e0b:	e8 10 26 00 00       	call   80104420 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101e10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e13:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e15:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e18:	75 0e                	jne    80101e28 <namex+0xb8>
80101e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101e20:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e23:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e26:	74 f8                	je     80101e20 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e28:	89 34 24             	mov    %esi,(%esp)
80101e2b:	e8 70 f9 ff ff       	call   801017a0 <ilock>
    if(ip->type != T_DIR){
80101e30:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e35:	0f 85 85 00 00 00    	jne    80101ec0 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e3b:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e3e:	85 d2                	test   %edx,%edx
80101e40:	74 09                	je     80101e4b <namex+0xdb>
80101e42:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e45:	0f 84 a5 00 00 00    	je     80101ef0 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e4b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e52:	00 
80101e53:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101e57:	89 34 24             	mov    %esi,(%esp)
80101e5a:	e8 51 fe ff ff       	call   80101cb0 <dirlookup>
80101e5f:	85 c0                	test   %eax,%eax
80101e61:	74 5d                	je     80101ec0 <namex+0x150>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101e63:	89 34 24             	mov    %esi,(%esp)
80101e66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e69:	e8 12 fa ff ff       	call   80101880 <iunlock>
  iput(ip);
80101e6e:	89 34 24             	mov    %esi,(%esp)
80101e71:	e8 4a fa ff ff       	call   801018c0 <iput>
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101e76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e79:	89 c6                	mov    %eax,%esi
80101e7b:	e9 33 ff ff ff       	jmp    80101db3 <namex+0x43>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e80:	31 c9                	xor    %ecx,%ecx
80101e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101e88:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e8c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e90:	89 3c 24             	mov    %edi,(%esp)
80101e93:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e96:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e99:	e8 82 25 00 00       	call   80104420 <memmove>
    name[len] = 0;
80101e9e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ea1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ea4:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101ea8:	89 d3                	mov    %edx,%ebx
80101eaa:	e9 66 ff ff ff       	jmp    80101e15 <namex+0xa5>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101eaf:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101eb2:	85 c0                	test   %eax,%eax
80101eb4:	75 4c                	jne    80101f02 <namex+0x192>
80101eb6:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101eb8:	83 c4 2c             	add    $0x2c,%esp
80101ebb:	5b                   	pop    %ebx
80101ebc:	5e                   	pop    %esi
80101ebd:	5f                   	pop    %edi
80101ebe:	5d                   	pop    %ebp
80101ebf:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101ec0:	89 34 24             	mov    %esi,(%esp)
80101ec3:	e8 b8 f9 ff ff       	call   80101880 <iunlock>
  iput(ip);
80101ec8:	89 34 24             	mov    %esi,(%esp)
80101ecb:	e8 f0 f9 ff ff       	call   801018c0 <iput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101ed0:	83 c4 2c             	add    $0x2c,%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101ed3:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101ed5:	5b                   	pop    %ebx
80101ed6:	5e                   	pop    %esi
80101ed7:	5f                   	pop    %edi
80101ed8:	5d                   	pop    %ebp
80101ed9:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101eda:	ba 01 00 00 00       	mov    $0x1,%edx
80101edf:	b8 01 00 00 00       	mov    $0x1,%eax
80101ee4:	e8 17 f4 ff ff       	call   80101300 <iget>
80101ee9:	89 c6                	mov    %eax,%esi
80101eeb:	e9 c3 fe ff ff       	jmp    80101db3 <namex+0x43>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101ef0:	89 34 24             	mov    %esi,(%esp)
80101ef3:	e8 88 f9 ff ff       	call   80101880 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101ef8:	83 c4 2c             	add    $0x2c,%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101efb:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101efd:	5b                   	pop    %ebx
80101efe:	5e                   	pop    %esi
80101eff:	5f                   	pop    %edi
80101f00:	5d                   	pop    %ebp
80101f01:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101f02:	89 34 24             	mov    %esi,(%esp)
80101f05:	e8 b6 f9 ff ff       	call   801018c0 <iput>
    return 0;
80101f0a:	31 c0                	xor    %eax,%eax
80101f0c:	eb aa                	jmp    80101eb8 <namex+0x148>
80101f0e:	66 90                	xchg   %ax,%ax

80101f10 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	57                   	push   %edi
80101f14:	56                   	push   %esi
80101f15:	53                   	push   %ebx
80101f16:	83 ec 2c             	sub    $0x2c,%esp
80101f19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f1f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101f26:	00 
80101f27:	89 1c 24             	mov    %ebx,(%esp)
80101f2a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f2e:	e8 7d fd ff ff       	call   80101cb0 <dirlookup>
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 85 8b 00 00 00    	jne    80101fc6 <dirlink+0xb6>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f3b:	8b 43 58             	mov    0x58(%ebx),%eax
80101f3e:	31 ff                	xor    %edi,%edi
80101f40:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f43:	85 c0                	test   %eax,%eax
80101f45:	75 13                	jne    80101f5a <dirlink+0x4a>
80101f47:	eb 35                	jmp    80101f7e <dirlink+0x6e>
80101f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f50:	8d 57 10             	lea    0x10(%edi),%edx
80101f53:	39 53 58             	cmp    %edx,0x58(%ebx)
80101f56:	89 d7                	mov    %edx,%edi
80101f58:	76 24                	jbe    80101f7e <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f5a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101f61:	00 
80101f62:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101f66:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f6a:	89 1c 24             	mov    %ebx,(%esp)
80101f6d:	e8 de fa ff ff       	call   80101a50 <readi>
80101f72:	83 f8 10             	cmp    $0x10,%eax
80101f75:	75 5e                	jne    80101fd5 <dirlink+0xc5>
      panic("dirlink read");
    if(de.inum == 0)
80101f77:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f7c:	75 d2                	jne    80101f50 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101f7e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f81:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101f88:	00 
80101f89:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f8d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f90:	89 04 24             	mov    %eax,(%esp)
80101f93:	e8 78 25 00 00       	call   80104510 <strncpy>
  de.inum = inum;
80101f98:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f9b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101fa2:	00 
80101fa3:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101fa7:	89 74 24 04          	mov    %esi,0x4(%esp)
80101fab:	89 1c 24             	mov    %ebx,(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101fae:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fb2:	e8 99 fb ff ff       	call   80101b50 <writei>
80101fb7:	83 f8 10             	cmp    $0x10,%eax
80101fba:	75 25                	jne    80101fe1 <dirlink+0xd1>
    panic("dirlink");

  return 0;
80101fbc:	31 c0                	xor    %eax,%eax
}
80101fbe:	83 c4 2c             	add    $0x2c,%esp
80101fc1:	5b                   	pop    %ebx
80101fc2:	5e                   	pop    %esi
80101fc3:	5f                   	pop    %edi
80101fc4:	5d                   	pop    %ebp
80101fc5:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101fc6:	89 04 24             	mov    %eax,(%esp)
80101fc9:	e8 f2 f8 ff ff       	call   801018c0 <iput>
    return -1;
80101fce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fd3:	eb e9                	jmp    80101fbe <dirlink+0xae>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101fd5:	c7 04 24 c8 6e 10 80 	movl   $0x80106ec8,(%esp)
80101fdc:	e8 7f e3 ff ff       	call   80100360 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101fe1:	c7 04 24 be 74 10 80 	movl   $0x801074be,(%esp)
80101fe8:	e8 73 e3 ff ff       	call   80100360 <panic>
80101fed:	8d 76 00             	lea    0x0(%esi),%esi

80101ff0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ff0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ff1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ff3:	89 e5                	mov    %esp,%ebp
80101ff5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ffe:	e8 6d fd ff ff       	call   80101d70 <namex>
}
80102003:	c9                   	leave  
80102004:	c3                   	ret    
80102005:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102010 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102010:	55                   	push   %ebp
  return namex(path, 1, name);
80102011:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102016:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102018:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010201b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010201e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
8010201f:	e9 4c fd ff ff       	jmp    80101d70 <namex>
80102024:	66 90                	xchg   %ax,%ax
80102026:	66 90                	xchg   %ax,%ax
80102028:	66 90                	xchg   %ax,%ax
8010202a:	66 90                	xchg   %ax,%ax
8010202c:	66 90                	xchg   %ax,%ax
8010202e:	66 90                	xchg   %ax,%ax

80102030 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	56                   	push   %esi
80102034:	89 c6                	mov    %eax,%esi
80102036:	83 ec 14             	sub    $0x14,%esp
  if(b == 0)
80102039:	85 c0                	test   %eax,%eax
8010203b:	0f 84 99 00 00 00    	je     801020da <idestart+0xaa>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102041:	8b 48 08             	mov    0x8(%eax),%ecx
80102044:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
8010204a:	0f 87 7e 00 00 00    	ja     801020ce <idestart+0x9e>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102050:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102055:	8d 76 00             	lea    0x0(%esi),%esi
80102058:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102059:	83 e0 c0             	and    $0xffffffc0,%eax
8010205c:	3c 40                	cmp    $0x40,%al
8010205e:	75 f8                	jne    80102058 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102060:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102065:	31 c0                	xor    %eax,%eax
80102067:	ee                   	out    %al,(%dx)
80102068:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010206d:	b8 01 00 00 00       	mov    $0x1,%eax
80102072:	ee                   	out    %al,(%dx)
80102073:	0f b6 c1             	movzbl %cl,%eax
80102076:	b2 f3                	mov    $0xf3,%dl
80102078:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102079:	89 c8                	mov    %ecx,%eax
8010207b:	b2 f4                	mov    $0xf4,%dl
8010207d:	c1 f8 08             	sar    $0x8,%eax
80102080:	ee                   	out    %al,(%dx)
80102081:	31 c0                	xor    %eax,%eax
80102083:	b2 f5                	mov    $0xf5,%dl
80102085:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102086:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010208a:	b2 f6                	mov    $0xf6,%dl
8010208c:	83 e0 01             	and    $0x1,%eax
8010208f:	c1 e0 04             	shl    $0x4,%eax
80102092:	83 c8 e0             	or     $0xffffffe0,%eax
80102095:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102096:	f6 06 04             	testb  $0x4,(%esi)
80102099:	75 15                	jne    801020b0 <idestart+0x80>
8010209b:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020a0:	b8 20 00 00 00       	mov    $0x20,%eax
801020a5:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020a6:	83 c4 14             	add    $0x14,%esp
801020a9:	5e                   	pop    %esi
801020aa:	5d                   	pop    %ebp
801020ab:	c3                   	ret    
801020ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020b0:	b2 f7                	mov    $0xf7,%dl
801020b2:	b8 30 00 00 00       	mov    $0x30,%eax
801020b7:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
801020b8:	b9 80 00 00 00       	mov    $0x80,%ecx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
801020bd:	83 c6 5c             	add    $0x5c,%esi
801020c0:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020c5:	fc                   	cld    
801020c6:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020c8:	83 c4 14             	add    $0x14,%esp
801020cb:	5e                   	pop    %esi
801020cc:	5d                   	pop    %ebp
801020cd:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
801020ce:	c7 04 24 34 6f 10 80 	movl   $0x80106f34,(%esp)
801020d5:	e8 86 e2 ff ff       	call   80100360 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
801020da:	c7 04 24 2b 6f 10 80 	movl   $0x80106f2b,(%esp)
801020e1:	e8 7a e2 ff ff       	call   80100360 <panic>
801020e6:	8d 76 00             	lea    0x0(%esi),%esi
801020e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020f0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801020f6:	c7 44 24 04 46 6f 10 	movl   $0x80106f46,0x4(%esp)
801020fd:	80 
801020fe:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102105:	e8 46 20 00 00       	call   80104150 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010210a:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010210f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102116:	83 e8 01             	sub    $0x1,%eax
80102119:	89 44 24 04          	mov    %eax,0x4(%esp)
8010211d:	e8 7e 02 00 00       	call   801023a0 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102122:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102127:	90                   	nop
80102128:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102129:	83 e0 c0             	and    $0xffffffc0,%eax
8010212c:	3c 40                	cmp    $0x40,%al
8010212e:	75 f8                	jne    80102128 <ideinit+0x38>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102130:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102135:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010213a:	ee                   	out    %al,(%dx)
8010213b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102140:	b2 f7                	mov    $0xf7,%dl
80102142:	eb 09                	jmp    8010214d <ideinit+0x5d>
80102144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102148:	83 e9 01             	sub    $0x1,%ecx
8010214b:	74 0f                	je     8010215c <ideinit+0x6c>
8010214d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010214e:	84 c0                	test   %al,%al
80102150:	74 f6                	je     80102148 <ideinit+0x58>
      havedisk1 = 1;
80102152:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102159:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010215c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102161:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102166:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80102167:	c9                   	leave  
80102168:	c3                   	ret    
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102170 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	57                   	push   %edi
80102174:	56                   	push   %esi
80102175:	53                   	push   %ebx
80102176:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102179:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102180:	e8 3b 21 00 00       	call   801042c0 <acquire>

  if((b = idequeue) == 0){
80102185:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
8010218b:	85 db                	test   %ebx,%ebx
8010218d:	74 30                	je     801021bf <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010218f:	8b 43 58             	mov    0x58(%ebx),%eax
80102192:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102197:	8b 33                	mov    (%ebx),%esi
80102199:	f7 c6 04 00 00 00    	test   $0x4,%esi
8010219f:	74 37                	je     801021d8 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021a1:	83 e6 fb             	and    $0xfffffffb,%esi
801021a4:	83 ce 02             	or     $0x2,%esi
801021a7:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801021a9:	89 1c 24             	mov    %ebx,(%esp)
801021ac:	e8 bf 1c 00 00       	call   80103e70 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021b1:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801021b6:	85 c0                	test   %eax,%eax
801021b8:	74 05                	je     801021bf <ideintr+0x4f>
    idestart(idequeue);
801021ba:	e8 71 fe ff ff       	call   80102030 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801021bf:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801021c6:	e8 65 21 00 00       	call   80104330 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801021cb:	83 c4 1c             	add    $0x1c,%esp
801021ce:	5b                   	pop    %ebx
801021cf:	5e                   	pop    %esi
801021d0:	5f                   	pop    %edi
801021d1:	5d                   	pop    %ebp
801021d2:	c3                   	ret    
801021d3:	90                   	nop
801021d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021dd:	8d 76 00             	lea    0x0(%esi),%esi
801021e0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021e1:	89 c1                	mov    %eax,%ecx
801021e3:	83 e1 c0             	and    $0xffffffc0,%ecx
801021e6:	80 f9 40             	cmp    $0x40,%cl
801021e9:	75 f5                	jne    801021e0 <ideintr+0x70>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021eb:	a8 21                	test   $0x21,%al
801021ed:	75 b2                	jne    801021a1 <ideintr+0x31>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801021ef:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801021f2:	b9 80 00 00 00       	mov    $0x80,%ecx
801021f7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021fc:	fc                   	cld    
801021fd:	f3 6d                	rep insl (%dx),%es:(%edi)
801021ff:	8b 33                	mov    (%ebx),%esi
80102201:	eb 9e                	jmp    801021a1 <ideintr+0x31>
80102203:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102210 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102210:	55                   	push   %ebp
80102211:	89 e5                	mov    %esp,%ebp
80102213:	53                   	push   %ebx
80102214:	83 ec 14             	sub    $0x14,%esp
80102217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010221a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010221d:	89 04 24             	mov    %eax,(%esp)
80102220:	e8 db 1e 00 00       	call   80104100 <holdingsleep>
80102225:	85 c0                	test   %eax,%eax
80102227:	0f 84 9e 00 00 00    	je     801022cb <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010222d:	8b 03                	mov    (%ebx),%eax
8010222f:	83 e0 06             	and    $0x6,%eax
80102232:	83 f8 02             	cmp    $0x2,%eax
80102235:	0f 84 a8 00 00 00    	je     801022e3 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010223b:	8b 53 04             	mov    0x4(%ebx),%edx
8010223e:	85 d2                	test   %edx,%edx
80102240:	74 0d                	je     8010224f <iderw+0x3f>
80102242:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102247:	85 c0                	test   %eax,%eax
80102249:	0f 84 88 00 00 00    	je     801022d7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010224f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102256:	e8 65 20 00 00       	call   801042c0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010225b:	a1 64 a5 10 80       	mov    0x8010a564,%eax
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102260:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102267:	85 c0                	test   %eax,%eax
80102269:	75 07                	jne    80102272 <iderw+0x62>
8010226b:	eb 4e                	jmp    801022bb <iderw+0xab>
8010226d:	8d 76 00             	lea    0x0(%esi),%esi
80102270:	89 d0                	mov    %edx,%eax
80102272:	8b 50 58             	mov    0x58(%eax),%edx
80102275:	85 d2                	test   %edx,%edx
80102277:	75 f7                	jne    80102270 <iderw+0x60>
80102279:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
8010227c:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
8010227e:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
80102284:	74 3c                	je     801022c2 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102286:	8b 03                	mov    (%ebx),%eax
80102288:	83 e0 06             	and    $0x6,%eax
8010228b:	83 f8 02             	cmp    $0x2,%eax
8010228e:	74 1a                	je     801022aa <iderw+0x9a>
    sleep(b, &idelock);
80102290:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
80102297:	80 
80102298:	89 1c 24             	mov    %ebx,(%esp)
8010229b:	e8 40 1a 00 00       	call   80103ce0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801022a0:	8b 13                	mov    (%ebx),%edx
801022a2:	83 e2 06             	and    $0x6,%edx
801022a5:	83 fa 02             	cmp    $0x2,%edx
801022a8:	75 e6                	jne    80102290 <iderw+0x80>
    sleep(b, &idelock);
  }


  release(&idelock);
801022aa:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801022b1:	83 c4 14             	add    $0x14,%esp
801022b4:	5b                   	pop    %ebx
801022b5:	5d                   	pop    %ebp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801022b6:	e9 75 20 00 00       	jmp    80104330 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022bb:	b8 64 a5 10 80       	mov    $0x8010a564,%eax
801022c0:	eb ba                	jmp    8010227c <iderw+0x6c>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801022c2:	89 d8                	mov    %ebx,%eax
801022c4:	e8 67 fd ff ff       	call   80102030 <idestart>
801022c9:	eb bb                	jmp    80102286 <iderw+0x76>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801022cb:	c7 04 24 4a 6f 10 80 	movl   $0x80106f4a,(%esp)
801022d2:	e8 89 e0 ff ff       	call   80100360 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801022d7:	c7 04 24 75 6f 10 80 	movl   $0x80106f75,(%esp)
801022de:	e8 7d e0 ff ff       	call   80100360 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801022e3:	c7 04 24 60 6f 10 80 	movl   $0x80106f60,(%esp)
801022ea:	e8 71 e0 ff ff       	call   80100360 <panic>
801022ef:	90                   	nop

801022f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	56                   	push   %esi
801022f4:	53                   	push   %ebx
801022f5:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022f8:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801022ff:	00 c0 fe 
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102302:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102309:	00 00 00 
  return ioapic->data;
8010230c:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102312:	8b 42 10             	mov    0x10(%edx),%eax
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102315:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010231b:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102321:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102328:	c1 e8 10             	shr    $0x10,%eax
8010232b:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010232e:	8b 43 10             	mov    0x10(%ebx),%eax
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
80102331:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102334:	39 c2                	cmp    %eax,%edx
80102336:	74 12                	je     8010234a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102338:	c7 04 24 94 6f 10 80 	movl   $0x80106f94,(%esp)
8010233f:	e8 dc e3 ff ff       	call   80100720 <cprintf>
80102344:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010234a:	ba 10 00 00 00       	mov    $0x10,%edx
8010234f:	31 c0                	xor    %eax,%eax
80102351:	eb 07                	jmp    8010235a <ioapicinit+0x6a>
80102353:	90                   	nop
80102354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102358:	89 cb                	mov    %ecx,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010235a:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010235c:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102362:	8d 48 20             	lea    0x20(%eax),%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102365:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010236b:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010236e:	89 4b 10             	mov    %ecx,0x10(%ebx)
80102371:	8d 4a 01             	lea    0x1(%edx),%ecx
80102374:	83 c2 02             	add    $0x2,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102377:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102379:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010237f:	39 c6                	cmp    %eax,%esi

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102381:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102388:	7d ce                	jge    80102358 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010238a:	83 c4 10             	add    $0x10,%esp
8010238d:	5b                   	pop    %ebx
8010238e:	5e                   	pop    %esi
8010238f:	5d                   	pop    %ebp
80102390:	c3                   	ret    
80102391:	eb 0d                	jmp    801023a0 <ioapicenable>
80102393:	90                   	nop
80102394:	90                   	nop
80102395:	90                   	nop
80102396:	90                   	nop
80102397:	90                   	nop
80102398:	90                   	nop
80102399:	90                   	nop
8010239a:	90                   	nop
8010239b:	90                   	nop
8010239c:	90                   	nop
8010239d:	90                   	nop
8010239e:	90                   	nop
8010239f:	90                   	nop

801023a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	8b 55 08             	mov    0x8(%ebp),%edx
801023a6:	53                   	push   %ebx
801023a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023aa:	8d 5a 20             	lea    0x20(%edx),%ebx
801023ad:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023b1:	8b 15 34 26 11 80    	mov    0x80112634,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023b7:	c1 e0 18             	shl    $0x18,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023ba:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801023bc:	8b 15 34 26 11 80    	mov    0x80112634,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023c2:	83 c1 01             	add    $0x1,%ecx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801023c5:	89 5a 10             	mov    %ebx,0x10(%edx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023c8:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801023ca:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023d0:	89 42 10             	mov    %eax,0x10(%edx)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801023d3:	5b                   	pop    %ebx
801023d4:	5d                   	pop    %ebp
801023d5:	c3                   	ret    
801023d6:	66 90                	xchg   %ax,%ax
801023d8:	66 90                	xchg   %ax,%ax
801023da:	66 90                	xchg   %ax,%ax
801023dc:	66 90                	xchg   %ax,%ax
801023de:	66 90                	xchg   %ax,%ax

801023e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	53                   	push   %ebx
801023e4:	83 ec 14             	sub    $0x14,%esp
801023e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023f0:	75 7c                	jne    8010246e <kfree+0x8e>
801023f2:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
801023f8:	72 74                	jb     8010246e <kfree+0x8e>
801023fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102400:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102405:	77 67                	ja     8010246e <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102407:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010240e:	00 
8010240f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102416:	00 
80102417:	89 1c 24             	mov    %ebx,(%esp)
8010241a:	e8 61 1f 00 00       	call   80104380 <memset>

  if(kmem.use_lock)
8010241f:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102425:	85 d2                	test   %edx,%edx
80102427:	75 37                	jne    80102460 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102429:	a1 78 26 11 80       	mov    0x80112678,%eax
8010242e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102430:	a1 74 26 11 80       	mov    0x80112674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102435:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
8010243b:	85 c0                	test   %eax,%eax
8010243d:	75 09                	jne    80102448 <kfree+0x68>
    release(&kmem.lock);
}
8010243f:	83 c4 14             	add    $0x14,%esp
80102442:	5b                   	pop    %ebx
80102443:	5d                   	pop    %ebp
80102444:	c3                   	ret    
80102445:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102448:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010244f:	83 c4 14             	add    $0x14,%esp
80102452:	5b                   	pop    %ebx
80102453:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102454:	e9 d7 1e 00 00       	jmp    80104330 <release>
80102459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102460:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102467:	e8 54 1e 00 00       	call   801042c0 <acquire>
8010246c:	eb bb                	jmp    80102429 <kfree+0x49>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
8010246e:	c7 04 24 c6 6f 10 80 	movl   $0x80106fc6,(%esp)
80102475:	e8 e6 de ff ff       	call   80100360 <panic>
8010247a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102480 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
80102485:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102488:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
8010248b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010248e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102494:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801024a0:	39 de                	cmp    %ebx,%esi
801024a2:	73 08                	jae    801024ac <freerange+0x2c>
801024a4:	eb 18                	jmp    801024be <freerange+0x3e>
801024a6:	66 90                	xchg   %ax,%ax
801024a8:	89 da                	mov    %ebx,%edx
801024aa:	89 c3                	mov    %eax,%ebx
    kfree(p);
801024ac:	89 14 24             	mov    %edx,(%esp)
801024af:	e8 2c ff ff ff       	call   801023e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801024ba:	39 f0                	cmp    %esi,%eax
801024bc:	76 ea                	jbe    801024a8 <freerange+0x28>
    kfree(p);
}
801024be:	83 c4 10             	add    $0x10,%esp
801024c1:	5b                   	pop    %ebx
801024c2:	5e                   	pop    %esi
801024c3:	5d                   	pop    %ebp
801024c4:	c3                   	ret    
801024c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024d0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	56                   	push   %esi
801024d4:	53                   	push   %ebx
801024d5:	83 ec 10             	sub    $0x10,%esp
801024d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024db:	c7 44 24 04 cc 6f 10 	movl   $0x80106fcc,0x4(%esp)
801024e2:	80 
801024e3:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024ea:	e8 61 1c 00 00       	call   80104150 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024ef:	8b 45 08             	mov    0x8(%ebp),%eax
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801024f2:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801024f9:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024fc:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102502:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102508:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010250e:	39 de                	cmp    %ebx,%esi
80102510:	73 0a                	jae    8010251c <kinit1+0x4c>
80102512:	eb 1a                	jmp    8010252e <kinit1+0x5e>
80102514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102518:	89 da                	mov    %ebx,%edx
8010251a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010251c:	89 14 24             	mov    %edx,(%esp)
8010251f:	e8 bc fe ff ff       	call   801023e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102524:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010252a:	39 c6                	cmp    %eax,%esi
8010252c:	73 ea                	jae    80102518 <kinit1+0x48>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010252e:	83 c4 10             	add    $0x10,%esp
80102531:	5b                   	pop    %ebx
80102532:	5e                   	pop    %esi
80102533:	5d                   	pop    %ebp
80102534:	c3                   	ret    
80102535:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102540 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	56                   	push   %esi
80102544:	53                   	push   %ebx
80102545:	83 ec 10             	sub    $0x10,%esp

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102548:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
8010254b:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010254e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102554:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010255a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102560:	39 de                	cmp    %ebx,%esi
80102562:	73 08                	jae    8010256c <kinit2+0x2c>
80102564:	eb 18                	jmp    8010257e <kinit2+0x3e>
80102566:	66 90                	xchg   %ax,%ax
80102568:	89 da                	mov    %ebx,%edx
8010256a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010256c:	89 14 24             	mov    %edx,(%esp)
8010256f:	e8 6c fe ff ff       	call   801023e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102574:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010257a:	39 c6                	cmp    %eax,%esi
8010257c:	73 ea                	jae    80102568 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
8010257e:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
80102585:	00 00 00 
}
80102588:	83 c4 10             	add    $0x10,%esp
8010258b:	5b                   	pop    %ebx
8010258c:	5e                   	pop    %esi
8010258d:	5d                   	pop    %ebp
8010258e:	c3                   	ret    
8010258f:	90                   	nop

80102590 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	53                   	push   %ebx
80102594:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
80102597:	a1 74 26 11 80       	mov    0x80112674,%eax
8010259c:	85 c0                	test   %eax,%eax
8010259e:	75 30                	jne    801025d0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025a0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801025a6:	85 db                	test   %ebx,%ebx
801025a8:	74 08                	je     801025b2 <kalloc+0x22>
    kmem.freelist = r->next;
801025aa:	8b 13                	mov    (%ebx),%edx
801025ac:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801025b2:	85 c0                	test   %eax,%eax
801025b4:	74 0c                	je     801025c2 <kalloc+0x32>
    release(&kmem.lock);
801025b6:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801025bd:	e8 6e 1d 00 00       	call   80104330 <release>
  return (char*)r;
}
801025c2:	83 c4 14             	add    $0x14,%esp
801025c5:	89 d8                	mov    %ebx,%eax
801025c7:	5b                   	pop    %ebx
801025c8:	5d                   	pop    %ebp
801025c9:	c3                   	ret    
801025ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801025d0:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801025d7:	e8 e4 1c 00 00       	call   801042c0 <acquire>
801025dc:	a1 74 26 11 80       	mov    0x80112674,%eax
801025e1:	eb bd                	jmp    801025a0 <kalloc+0x10>
801025e3:	66 90                	xchg   %ax,%ax
801025e5:	66 90                	xchg   %ax,%ax
801025e7:	66 90                	xchg   %ax,%ax
801025e9:	66 90                	xchg   %ax,%ax
801025eb:	66 90                	xchg   %ax,%ax
801025ed:	66 90                	xchg   %ax,%ax
801025ef:	90                   	nop

801025f0 <kbdgetc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025f0:	ba 64 00 00 00       	mov    $0x64,%edx
801025f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801025f6:	a8 01                	test   $0x1,%al
801025f8:	0f 84 ba 00 00 00    	je     801026b8 <kbdgetc+0xc8>
801025fe:	b2 60                	mov    $0x60,%dl
80102600:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102601:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102604:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010260a:	0f 84 88 00 00 00    	je     80102698 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102610:	84 c0                	test   %al,%al
80102612:	79 2c                	jns    80102640 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102614:	8b 15 b4 a5 10 80    	mov    0x8010a5b4,%edx
8010261a:	f6 c2 40             	test   $0x40,%dl
8010261d:	75 05                	jne    80102624 <kbdgetc+0x34>
8010261f:	89 c1                	mov    %eax,%ecx
80102621:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102624:	0f b6 81 00 71 10 80 	movzbl -0x7fef8f00(%ecx),%eax
8010262b:	83 c8 40             	or     $0x40,%eax
8010262e:	0f b6 c0             	movzbl %al,%eax
80102631:	f7 d0                	not    %eax
80102633:	21 d0                	and    %edx,%eax
80102635:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010263a:	31 c0                	xor    %eax,%eax
8010263c:	c3                   	ret    
8010263d:	8d 76 00             	lea    0x0(%esi),%esi
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	53                   	push   %ebx
80102644:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010264a:	f6 c3 40             	test   $0x40,%bl
8010264d:	74 09                	je     80102658 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010264f:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102652:	83 e3 bf             	and    $0xffffffbf,%ebx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102655:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
80102658:	0f b6 91 00 71 10 80 	movzbl -0x7fef8f00(%ecx),%edx
  shift ^= togglecode[data];
8010265f:	0f b6 81 00 70 10 80 	movzbl -0x7fef9000(%ecx),%eax
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
80102666:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102668:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010266a:	89 d0                	mov    %edx,%eax
8010266c:	83 e0 03             	and    $0x3,%eax
8010266f:	8b 04 85 e0 6f 10 80 	mov    -0x7fef9020(,%eax,4),%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102676:	89 15 b4 a5 10 80    	mov    %edx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
8010267c:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010267f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102683:	74 0b                	je     80102690 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
80102685:	8d 50 9f             	lea    -0x61(%eax),%edx
80102688:	83 fa 19             	cmp    $0x19,%edx
8010268b:	77 1b                	ja     801026a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010268d:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102690:	5b                   	pop    %ebx
80102691:	5d                   	pop    %ebp
80102692:	c3                   	ret    
80102693:	90                   	nop
80102694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102698:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
8010269f:	31 c0                	xor    %eax,%eax
801026a1:	c3                   	ret    
801026a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801026a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026ab:	8d 50 20             	lea    0x20(%eax),%edx
801026ae:	83 f9 19             	cmp    $0x19,%ecx
801026b1:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
801026b4:	eb da                	jmp    80102690 <kbdgetc+0xa0>
801026b6:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801026b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801026bd:	c3                   	ret    
801026be:	66 90                	xchg   %ax,%ax

801026c0 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801026c6:	c7 04 24 f0 25 10 80 	movl   $0x801025f0,(%esp)
801026cd:	e8 ae e1 ff ff       	call   80100880 <consoleintr>
}
801026d2:	c9                   	leave  
801026d3:	c3                   	ret    
801026d4:	66 90                	xchg   %ax,%ax
801026d6:	66 90                	xchg   %ax,%ax
801026d8:	66 90                	xchg   %ax,%ax
801026da:	66 90                	xchg   %ax,%ax
801026dc:	66 90                	xchg   %ax,%ax
801026de:	66 90                	xchg   %ax,%ax

801026e0 <fill_rtcdate>:
  return inb(CMOS_RETURN);
}

static void
fill_rtcdate(struct rtcdate *r)
{
801026e0:	55                   	push   %ebp
801026e1:	89 c1                	mov    %eax,%ecx
801026e3:	89 e5                	mov    %esp,%ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026e5:	ba 70 00 00 00       	mov    $0x70,%edx
801026ea:	31 c0                	xor    %eax,%eax
801026ec:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026ed:	b2 71                	mov    $0x71,%dl
801026ef:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
801026f0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026f3:	b2 70                	mov    $0x70,%dl
801026f5:	89 01                	mov    %eax,(%ecx)
801026f7:	b8 02 00 00 00       	mov    $0x2,%eax
801026fc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026fd:	b2 71                	mov    $0x71,%dl
801026ff:	ec                   	in     (%dx),%al
80102700:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102703:	b2 70                	mov    $0x70,%dl
80102705:	89 41 04             	mov    %eax,0x4(%ecx)
80102708:	b8 04 00 00 00       	mov    $0x4,%eax
8010270d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010270e:	b2 71                	mov    $0x71,%dl
80102710:	ec                   	in     (%dx),%al
80102711:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102714:	b2 70                	mov    $0x70,%dl
80102716:	89 41 08             	mov    %eax,0x8(%ecx)
80102719:	b8 07 00 00 00       	mov    $0x7,%eax
8010271e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010271f:	b2 71                	mov    $0x71,%dl
80102721:	ec                   	in     (%dx),%al
80102722:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102725:	b2 70                	mov    $0x70,%dl
80102727:	89 41 0c             	mov    %eax,0xc(%ecx)
8010272a:	b8 08 00 00 00       	mov    $0x8,%eax
8010272f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102730:	b2 71                	mov    $0x71,%dl
80102732:	ec                   	in     (%dx),%al
80102733:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102736:	b2 70                	mov    $0x70,%dl
80102738:	89 41 10             	mov    %eax,0x10(%ecx)
8010273b:	b8 09 00 00 00       	mov    $0x9,%eax
80102740:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102741:	b2 71                	mov    $0x71,%dl
80102743:	ec                   	in     (%dx),%al
80102744:	0f b6 c0             	movzbl %al,%eax
80102747:	89 41 14             	mov    %eax,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
8010274a:	5d                   	pop    %ebp
8010274b:	c3                   	ret    
8010274c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102750 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102750:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102755:	55                   	push   %ebp
80102756:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102758:	85 c0                	test   %eax,%eax
8010275a:	0f 84 c0 00 00 00    	je     80102820 <lapicinit+0xd0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102760:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102767:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010276a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010276d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102774:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102777:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010277a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102781:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102784:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102787:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010278e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102791:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102794:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010279b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010279e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801027a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801027ae:	8b 50 30             	mov    0x30(%eax),%edx
801027b1:	c1 ea 10             	shr    $0x10,%edx
801027b4:	80 fa 03             	cmp    $0x3,%dl
801027b7:	77 6f                	ja     80102828 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801027c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c3:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d0:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027dd:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ea:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102801:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102804:	8b 50 20             	mov    0x20(%eax),%edx
80102807:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102808:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010280e:	80 e6 10             	and    $0x10,%dh
80102811:	75 f5                	jne    80102808 <lapicinit+0xb8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102813:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010281a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010281d:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102820:	5d                   	pop    %ebp
80102821:	c3                   	ret    
80102822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102828:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010282f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102832:	8b 50 20             	mov    0x20(%eax),%edx
80102835:	eb 82                	jmp    801027b9 <lapicinit+0x69>
80102837:	89 f6                	mov    %esi,%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102840 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102840:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102845:	55                   	push   %ebp
80102846:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102848:	85 c0                	test   %eax,%eax
8010284a:	74 0c                	je     80102858 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010284c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010284f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102850:	c1 e8 18             	shr    $0x18,%eax
}
80102853:	c3                   	ret    
80102854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102858:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010285a:	5d                   	pop    %ebp
8010285b:	c3                   	ret    
8010285c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102860 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102860:	a1 7c 26 11 80       	mov    0x8011267c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102865:	55                   	push   %ebp
80102866:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102868:	85 c0                	test   %eax,%eax
8010286a:	74 0d                	je     80102879 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010286c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102873:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102876:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102879:	5d                   	pop    %ebp
8010287a:	c3                   	ret    
8010287b:	90                   	nop
8010287c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102880 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102880:	55                   	push   %ebp
80102881:	89 e5                	mov    %esp,%ebp
}
80102883:	5d                   	pop    %ebp
80102884:	c3                   	ret    
80102885:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102890 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102890:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102891:	ba 70 00 00 00       	mov    $0x70,%edx
80102896:	89 e5                	mov    %esp,%ebp
80102898:	b8 0f 00 00 00       	mov    $0xf,%eax
8010289d:	53                   	push   %ebx
8010289e:	8b 4d 08             	mov    0x8(%ebp),%ecx
801028a1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801028a4:	ee                   	out    %al,(%dx)
801028a5:	b8 0a 00 00 00       	mov    $0xa,%eax
801028aa:	b2 71                	mov    $0x71,%dl
801028ac:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801028ad:	31 c0                	xor    %eax,%eax
801028af:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801028b5:	89 d8                	mov    %ebx,%eax
801028b7:	c1 e8 04             	shr    $0x4,%eax
801028ba:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028c0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801028c5:	c1 e1 18             	shl    $0x18,%ecx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028c8:	c1 eb 0c             	shr    $0xc,%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028cb:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d1:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028d4:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028db:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028de:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028e1:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028e8:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028eb:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ee:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f4:	8b 50 20             	mov    0x20(%eax),%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028f7:	89 da                	mov    %ebx,%edx
801028f9:	80 ce 06             	or     $0x6,%dh

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028fc:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102902:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102905:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010290b:	8b 48 20             	mov    0x20(%eax),%ecx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010290e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102914:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102917:	5b                   	pop    %ebx
80102918:	5d                   	pop    %ebp
80102919:	c3                   	ret    
8010291a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102920 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102920:	55                   	push   %ebp
80102921:	ba 70 00 00 00       	mov    $0x70,%edx
80102926:	89 e5                	mov    %esp,%ebp
80102928:	b8 0b 00 00 00       	mov    $0xb,%eax
8010292d:	57                   	push   %edi
8010292e:	56                   	push   %esi
8010292f:	53                   	push   %ebx
80102930:	83 ec 4c             	sub    $0x4c,%esp
80102933:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102934:	b2 71                	mov    $0x71,%dl
80102936:	ec                   	in     (%dx),%al
80102937:	88 45 b7             	mov    %al,-0x49(%ebp)
8010293a:	8d 5d b8             	lea    -0x48(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010293d:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102941:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102948:	be 70 00 00 00       	mov    $0x70,%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010294d:	89 d8                	mov    %ebx,%eax
8010294f:	e8 8c fd ff ff       	call   801026e0 <fill_rtcdate>
80102954:	b8 0a 00 00 00       	mov    $0xa,%eax
80102959:	89 f2                	mov    %esi,%edx
8010295b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295c:	ba 71 00 00 00       	mov    $0x71,%edx
80102961:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102962:	84 c0                	test   %al,%al
80102964:	78 e7                	js     8010294d <cmostime+0x2d>
        continue;
    fill_rtcdate(&t2);
80102966:	89 f8                	mov    %edi,%eax
80102968:	e8 73 fd ff ff       	call   801026e0 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010296d:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
80102974:	00 
80102975:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102979:	89 1c 24             	mov    %ebx,(%esp)
8010297c:	e8 4f 1a 00 00       	call   801043d0 <memcmp>
80102981:	85 c0                	test   %eax,%eax
80102983:	75 c3                	jne    80102948 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102985:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102989:	75 78                	jne    80102a03 <cmostime+0xe3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010298b:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010298e:	89 c2                	mov    %eax,%edx
80102990:	83 e0 0f             	and    $0xf,%eax
80102993:	c1 ea 04             	shr    $0x4,%edx
80102996:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102999:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010299c:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010299f:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029a2:	89 c2                	mov    %eax,%edx
801029a4:	83 e0 0f             	and    $0xf,%eax
801029a7:	c1 ea 04             	shr    $0x4,%edx
801029aa:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ad:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b0:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801029b3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029b6:	89 c2                	mov    %eax,%edx
801029b8:	83 e0 0f             	and    $0xf,%eax
801029bb:	c1 ea 04             	shr    $0x4,%edx
801029be:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029c4:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029c7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ca:	89 c2                	mov    %eax,%edx
801029cc:	83 e0 0f             	and    $0xf,%eax
801029cf:	c1 ea 04             	shr    $0x4,%edx
801029d2:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029d5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029d8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029db:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029de:	89 c2                	mov    %eax,%edx
801029e0:	83 e0 0f             	and    $0xf,%eax
801029e3:	c1 ea 04             	shr    $0x4,%edx
801029e6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029e9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ec:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029ef:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029f2:	89 c2                	mov    %eax,%edx
801029f4:	83 e0 0f             	and    $0xf,%eax
801029f7:	c1 ea 04             	shr    $0x4,%edx
801029fa:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029fd:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a00:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a03:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102a06:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a09:	89 01                	mov    %eax,(%ecx)
80102a0b:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a0e:	89 41 04             	mov    %eax,0x4(%ecx)
80102a11:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a14:	89 41 08             	mov    %eax,0x8(%ecx)
80102a17:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a1a:	89 41 0c             	mov    %eax,0xc(%ecx)
80102a1d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a20:	89 41 10             	mov    %eax,0x10(%ecx)
80102a23:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a26:	89 41 14             	mov    %eax,0x14(%ecx)
  r->year += 2000;
80102a29:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
}
80102a30:	83 c4 4c             	add    $0x4c,%esp
80102a33:	5b                   	pop    %ebx
80102a34:	5e                   	pop    %esi
80102a35:	5f                   	pop    %edi
80102a36:	5d                   	pop    %ebp
80102a37:	c3                   	ret    
80102a38:	66 90                	xchg   %ax,%ax
80102a3a:	66 90                	xchg   %ax,%ax
80102a3c:	66 90                	xchg   %ax,%ax
80102a3e:	66 90                	xchg   %ax,%ax

80102a40 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	57                   	push   %edi
80102a44:	56                   	push   %esi
80102a45:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a46:	31 db                	xor    %ebx,%ebx
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a48:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a4b:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102a50:	85 c0                	test   %eax,%eax
80102a52:	7e 78                	jle    80102acc <install_trans+0x8c>
80102a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a58:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a5d:	01 d8                	add    %ebx,%eax
80102a5f:	83 c0 01             	add    $0x1,%eax
80102a62:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a66:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102a6b:	89 04 24             	mov    %eax,(%esp)
80102a6e:	e8 5d d6 ff ff       	call   801000d0 <bread>
80102a73:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a75:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a7c:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a7f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a83:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102a88:	89 04 24             	mov    %eax,(%esp)
80102a8b:	e8 40 d6 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a90:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102a97:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a98:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a9a:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a9d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102aa1:	8d 46 5c             	lea    0x5c(%esi),%eax
80102aa4:	89 04 24             	mov    %eax,(%esp)
80102aa7:	e8 74 19 00 00       	call   80104420 <memmove>
    bwrite(dbuf);  // write dst to disk
80102aac:	89 34 24             	mov    %esi,(%esp)
80102aaf:	e8 ec d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102ab4:	89 3c 24             	mov    %edi,(%esp)
80102ab7:	e8 24 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102abc:	89 34 24             	mov    %esi,(%esp)
80102abf:	e8 1c d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ac4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102aca:	7f 8c                	jg     80102a58 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102acc:	83 c4 1c             	add    $0x1c,%esp
80102acf:	5b                   	pop    %ebx
80102ad0:	5e                   	pop    %esi
80102ad1:	5f                   	pop    %edi
80102ad2:	5d                   	pop    %ebp
80102ad3:	c3                   	ret    
80102ad4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102ada:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102ae0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	57                   	push   %edi
80102ae4:	56                   	push   %esi
80102ae5:	53                   	push   %ebx
80102ae6:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ae9:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102aee:	89 44 24 04          	mov    %eax,0x4(%esp)
80102af2:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102af7:	89 04 24             	mov    %eax,(%esp)
80102afa:	e8 d1 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102aff:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b05:	31 d2                	xor    %edx,%edx
80102b07:	85 db                	test   %ebx,%ebx
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b09:	89 c7                	mov    %eax,%edi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b0b:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102b0e:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102b11:	7e 17                	jle    80102b2a <write_head+0x4a>
80102b13:	90                   	nop
80102b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102b18:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102b1f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b23:	83 c2 01             	add    $0x1,%edx
80102b26:	39 da                	cmp    %ebx,%edx
80102b28:	75 ee                	jne    80102b18 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b2a:	89 3c 24             	mov    %edi,(%esp)
80102b2d:	e8 6e d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b32:	89 3c 24             	mov    %edi,(%esp)
80102b35:	e8 a6 d6 ff ff       	call   801001e0 <brelse>
}
80102b3a:	83 c4 1c             	add    $0x1c,%esp
80102b3d:	5b                   	pop    %ebx
80102b3e:	5e                   	pop    %esi
80102b3f:	5f                   	pop    %edi
80102b40:	5d                   	pop    %ebp
80102b41:	c3                   	ret    
80102b42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b50 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	56                   	push   %esi
80102b54:	53                   	push   %ebx
80102b55:	83 ec 30             	sub    $0x30,%esp
80102b58:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b5b:	c7 44 24 04 00 72 10 	movl   $0x80107200,0x4(%esp)
80102b62:	80 
80102b63:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b6a:	e8 e1 15 00 00       	call   80104150 <initlock>
  readsb(dev, &sb);
80102b6f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b72:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b76:	89 1c 24             	mov    %ebx,(%esp)
80102b79:	e8 02 e9 ff ff       	call   80101480 <readsb>
  log.start = sb.logstart;
80102b7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102b81:	8b 55 e8             	mov    -0x18(%ebp),%edx

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b84:	89 1c 24             	mov    %ebx,(%esp)
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102b87:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b8d:	89 44 24 04          	mov    %eax,0x4(%esp)

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b91:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b97:	a3 b4 26 11 80       	mov    %eax,0x801126b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b9c:	e8 2f d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102ba1:	31 d2                	xor    %edx,%edx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102ba3:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ba6:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102ba9:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bab:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102bb1:	7e 17                	jle    80102bca <initlog+0x7a>
80102bb3:	90                   	nop
80102bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102bb8:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102bbc:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102bc3:	83 c2 01             	add    $0x1,%edx
80102bc6:	39 da                	cmp    %ebx,%edx
80102bc8:	75 ee                	jne    80102bb8 <initlog+0x68>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102bca:	89 04 24             	mov    %eax,(%esp)
80102bcd:	e8 0e d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102bd2:	e8 69 fe ff ff       	call   80102a40 <install_trans>
  log.lh.n = 0;
80102bd7:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102bde:	00 00 00 
  write_head(); // clear the log
80102be1:	e8 fa fe ff ff       	call   80102ae0 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102be6:	83 c4 30             	add    $0x30,%esp
80102be9:	5b                   	pop    %ebx
80102bea:	5e                   	pop    %esi
80102beb:	5d                   	pop    %ebp
80102bec:	c3                   	ret    
80102bed:	8d 76 00             	lea    0x0(%esi),%esi

80102bf0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102bf6:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102bfd:	e8 be 16 00 00       	call   801042c0 <acquire>
80102c02:	eb 18                	jmp    80102c1c <begin_op+0x2c>
80102c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c08:	c7 44 24 04 80 26 11 	movl   $0x80112680,0x4(%esp)
80102c0f:	80 
80102c10:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c17:	e8 c4 10 00 00       	call   80103ce0 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c1c:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102c21:	85 c0                	test   %eax,%eax
80102c23:	75 e3                	jne    80102c08 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c25:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102c2a:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102c30:	83 c0 01             	add    $0x1,%eax
80102c33:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c36:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c39:	83 fa 1e             	cmp    $0x1e,%edx
80102c3c:	7f ca                	jg     80102c08 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c3e:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102c45:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102c4a:	e8 e1 16 00 00       	call   80104330 <release>
      break;
    }
  }
}
80102c4f:	c9                   	leave  
80102c50:	c3                   	ret    
80102c51:	eb 0d                	jmp    80102c60 <end_op>
80102c53:	90                   	nop
80102c54:	90                   	nop
80102c55:	90                   	nop
80102c56:	90                   	nop
80102c57:	90                   	nop
80102c58:	90                   	nop
80102c59:	90                   	nop
80102c5a:	90                   	nop
80102c5b:	90                   	nop
80102c5c:	90                   	nop
80102c5d:	90                   	nop
80102c5e:	90                   	nop
80102c5f:	90                   	nop

80102c60 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	57                   	push   %edi
80102c64:	56                   	push   %esi
80102c65:	53                   	push   %ebx
80102c66:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c69:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c70:	e8 4b 16 00 00       	call   801042c0 <acquire>
  log.outstanding -= 1;
80102c75:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102c7a:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c80:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102c83:	85 d2                	test   %edx,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c85:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102c8a:	0f 85 f3 00 00 00    	jne    80102d83 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102c90:	85 c0                	test   %eax,%eax
80102c92:	0f 85 cb 00 00 00    	jne    80102d63 <end_op+0x103>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c98:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c9f:	31 db                	xor    %ebx,%ebx
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102ca1:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102ca8:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102cab:	e8 80 16 00 00       	call   80104330 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102cb0:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102cb5:	85 c0                	test   %eax,%eax
80102cb7:	0f 8e 90 00 00 00    	jle    80102d4d <end_op+0xed>
80102cbd:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102cc0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102cc5:	01 d8                	add    %ebx,%eax
80102cc7:	83 c0 01             	add    $0x1,%eax
80102cca:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cce:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102cd3:	89 04 24             	mov    %eax,(%esp)
80102cd6:	e8 f5 d3 ff ff       	call   801000d0 <bread>
80102cdb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cdd:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ce4:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ce7:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ceb:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102cf0:	89 04 24             	mov    %eax,(%esp)
80102cf3:	e8 d8 d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102cf8:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102cff:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d00:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d02:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d05:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d09:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d0c:	89 04 24             	mov    %eax,(%esp)
80102d0f:	e8 0c 17 00 00       	call   80104420 <memmove>
    bwrite(to);  // write the log
80102d14:	89 34 24             	mov    %esi,(%esp)
80102d17:	e8 84 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d1c:	89 3c 24             	mov    %edi,(%esp)
80102d1f:	e8 bc d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d24:	89 34 24             	mov    %esi,(%esp)
80102d27:	e8 b4 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d2c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102d32:	7c 8c                	jl     80102cc0 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d34:	e8 a7 fd ff ff       	call   80102ae0 <write_head>
    install_trans(); // Now install writes to home locations
80102d39:	e8 02 fd ff ff       	call   80102a40 <install_trans>
    log.lh.n = 0;
80102d3e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102d45:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d48:	e8 93 fd ff ff       	call   80102ae0 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d4d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d54:	e8 67 15 00 00       	call   801042c0 <acquire>
    log.committing = 0;
80102d59:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d60:	00 00 00 
    wakeup(&log);
80102d63:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d6a:	e8 01 11 00 00       	call   80103e70 <wakeup>
    release(&log.lock);
80102d6f:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d76:	e8 b5 15 00 00       	call   80104330 <release>
  }
}
80102d7b:	83 c4 1c             	add    $0x1c,%esp
80102d7e:	5b                   	pop    %ebx
80102d7f:	5e                   	pop    %esi
80102d80:	5f                   	pop    %edi
80102d81:	5d                   	pop    %ebp
80102d82:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d83:	c7 04 24 04 72 10 80 	movl   $0x80107204,(%esp)
80102d8a:	e8 d1 d5 ff ff       	call   80100360 <panic>
80102d8f:	90                   	nop

80102d90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	53                   	push   %ebx
80102d94:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d97:	a1 c8 26 11 80       	mov    0x801126c8,%eax
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d9c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d9f:	83 f8 1d             	cmp    $0x1d,%eax
80102da2:	0f 8f 98 00 00 00    	jg     80102e40 <log_write+0xb0>
80102da8:	8b 0d b8 26 11 80    	mov    0x801126b8,%ecx
80102dae:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102db1:	39 d0                	cmp    %edx,%eax
80102db3:	0f 8d 87 00 00 00    	jge    80102e40 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102db9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102dbe:	85 c0                	test   %eax,%eax
80102dc0:	0f 8e 86 00 00 00    	jle    80102e4c <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dc6:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102dcd:	e8 ee 14 00 00       	call   801042c0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dd2:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102dd8:	83 fa 00             	cmp    $0x0,%edx
80102ddb:	7e 54                	jle    80102e31 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ddd:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102de0:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de2:	39 0d cc 26 11 80    	cmp    %ecx,0x801126cc
80102de8:	75 0f                	jne    80102df9 <log_write+0x69>
80102dea:	eb 3c                	jmp    80102e28 <log_write+0x98>
80102dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102df0:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102df7:	74 2f                	je     80102e28 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102df9:	83 c0 01             	add    $0x1,%eax
80102dfc:	39 d0                	cmp    %edx,%eax
80102dfe:	75 f0                	jne    80102df0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e00:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e07:	83 c2 01             	add    $0x1,%edx
80102e0a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102e10:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e13:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102e1a:	83 c4 14             	add    $0x14,%esp
80102e1d:	5b                   	pop    %ebx
80102e1e:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e1f:	e9 0c 15 00 00       	jmp    80104330 <release>
80102e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e28:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102e2f:	eb df                	jmp    80102e10 <log_write+0x80>
80102e31:	8b 43 08             	mov    0x8(%ebx),%eax
80102e34:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102e39:	75 d5                	jne    80102e10 <log_write+0x80>
80102e3b:	eb ca                	jmp    80102e07 <log_write+0x77>
80102e3d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e40:	c7 04 24 13 72 10 80 	movl   $0x80107213,(%esp)
80102e47:	e8 14 d5 ff ff       	call   80100360 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e4c:	c7 04 24 29 72 10 80 	movl   $0x80107229,(%esp)
80102e53:	e8 08 d5 ff ff       	call   80100360 <panic>
80102e58:	66 90                	xchg   %ax,%ax
80102e5a:	66 90                	xchg   %ax,%ax
80102e5c:	66 90                	xchg   %ax,%ax
80102e5e:	66 90                	xchg   %ax,%ax

80102e60 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e67:	e8 f4 08 00 00       	call   80103760 <cpuid>
80102e6c:	89 c3                	mov    %eax,%ebx
80102e6e:	e8 ed 08 00 00       	call   80103760 <cpuid>
80102e73:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102e77:	c7 04 24 44 72 10 80 	movl   $0x80107244,(%esp)
80102e7e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e82:	e8 99 d8 ff ff       	call   80100720 <cprintf>
  idtinit();       // load idt register
80102e87:	e8 84 27 00 00       	call   80105610 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e8c:	e8 4f 08 00 00       	call   801036e0 <mycpu>
80102e91:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e93:	b8 01 00 00 00       	mov    $0x1,%eax
80102e98:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e9f:	e8 9c 0b 00 00       	call   80103a40 <scheduler>
80102ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102eb0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 05 38 00 00       	call   801066c0 <switchkvm>
  seginit();
80102ebb:	e8 40 37 00 00       	call   80106600 <seginit>
  lapicinit();
80102ec0:	e8 8b f8 ff ff       	call   80102750 <lapicinit>
  mpmain();
80102ec5:	e8 96 ff ff ff       	call   80102e60 <mpmain>
80102eca:	66 90                	xchg   %ax,%ax
80102ecc:	66 90                	xchg   %ax,%ax
80102ece:	66 90                	xchg   %ax,%ax

80102ed0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102ed0:	55                   	push   %ebp
80102ed1:	89 e5                	mov    %esp,%ebp
80102ed3:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102ed4:	bb 80 27 11 80       	mov    $0x80112780,%ebx
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102ed9:	83 e4 f0             	and    $0xfffffff0,%esp
80102edc:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102edf:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102ee6:	80 
80102ee7:	c7 04 24 a8 54 11 80 	movl   $0x801154a8,(%esp)
80102eee:	e8 dd f5 ff ff       	call   801024d0 <kinit1>
  kvmalloc();      // kernel page table
80102ef3:	e8 58 3c 00 00       	call   80106b50 <kvmalloc>
  mpinit();        // detect other processors
80102ef8:	e8 73 01 00 00       	call   80103070 <mpinit>
80102efd:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102f00:	e8 4b f8 ff ff       	call   80102750 <lapicinit>
  seginit();       // segment descriptors
80102f05:	e8 f6 36 00 00       	call   80106600 <seginit>
  picinit();       // disable pic
80102f0a:	e8 21 03 00 00       	call   80103230 <picinit>
80102f0f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102f10:	e8 db f3 ff ff       	call   801022f0 <ioapicinit>
  consoleinit();   // console hardware
80102f15:	e8 16 db ff ff       	call   80100a30 <consoleinit>
  uartinit();      // serial port
80102f1a:	e8 11 2a 00 00       	call   80105930 <uartinit>
80102f1f:	90                   	nop
  pinit();         // process table
80102f20:	e8 9b 07 00 00       	call   801036c0 <pinit>
  tvinit();        // trap vectors
80102f25:	e8 46 26 00 00       	call   80105570 <tvinit>
  binit();         // buffer cache
80102f2a:	e8 11 d1 ff ff       	call   80100040 <binit>
80102f2f:	90                   	nop
  fileinit();      // file table
80102f30:	e8 fb de ff ff       	call   80100e30 <fileinit>
  ideinit();       // disk 
80102f35:	e8 b6 f1 ff ff       	call   801020f0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f3a:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102f41:	00 
80102f42:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102f49:	80 
80102f4a:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102f51:	e8 ca 14 00 00       	call   80104420 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f56:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f5d:	00 00 00 
80102f60:	05 80 27 11 80       	add    $0x80112780,%eax
80102f65:	39 d8                	cmp    %ebx,%eax
80102f67:	76 6a                	jbe    80102fd3 <main+0x103>
80102f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102f70:	e8 6b 07 00 00       	call   801036e0 <mycpu>
80102f75:	39 d8                	cmp    %ebx,%eax
80102f77:	74 41                	je     80102fba <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f79:	e8 12 f6 ff ff       	call   80102590 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102f7e:	c7 05 f8 6f 00 80 b0 	movl   $0x80102eb0,0x80006ff8
80102f85:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f88:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f8f:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f92:	05 00 10 00 00       	add    $0x1000,%eax
80102f97:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f9c:	0f b6 03             	movzbl (%ebx),%eax
80102f9f:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102fa6:	00 
80102fa7:	89 04 24             	mov    %eax,(%esp)
80102faa:	e8 e1 f8 ff ff       	call   80102890 <lapicstartap>
80102faf:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fb0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fb6:	85 c0                	test   %eax,%eax
80102fb8:	74 f6                	je     80102fb0 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102fba:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102fc1:	00 00 00 
80102fc4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fca:	05 80 27 11 80       	add    $0x80112780,%eax
80102fcf:	39 c3                	cmp    %eax,%ebx
80102fd1:	72 9d                	jb     80102f70 <main+0xa0>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fd3:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102fda:	8e 
80102fdb:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102fe2:	e8 59 f5 ff ff       	call   80102540 <kinit2>
  userinit();      // first user process
80102fe7:	e8 c4 07 00 00       	call   801037b0 <userinit>
  mpmain();        // finish this processor's setup
80102fec:	e8 6f fe ff ff       	call   80102e60 <mpmain>
80102ff1:	66 90                	xchg   %ax,%ax
80102ff3:	66 90                	xchg   %ax,%ax
80102ff5:	66 90                	xchg   %ax,%ax
80102ff7:	66 90                	xchg   %ax,%ax
80102ff9:	66 90                	xchg   %ax,%ax
80102ffb:	66 90                	xchg   %ax,%ax
80102ffd:	66 90                	xchg   %ax,%ax
80102fff:	90                   	nop

80103000 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103004:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010300a:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010300b:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010300e:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103011:	39 de                	cmp    %ebx,%esi
80103013:	73 3c                	jae    80103051 <mpsearch1+0x51>
80103015:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103018:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010301f:	00 
80103020:	c7 44 24 04 58 72 10 	movl   $0x80107258,0x4(%esp)
80103027:	80 
80103028:	89 34 24             	mov    %esi,(%esp)
8010302b:	e8 a0 13 00 00       	call   801043d0 <memcmp>
80103030:	85 c0                	test   %eax,%eax
80103032:	75 16                	jne    8010304a <mpsearch1+0x4a>
80103034:	31 c9                	xor    %ecx,%ecx
80103036:	31 d2                	xor    %edx,%edx
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103038:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010303c:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010303f:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103041:	83 fa 10             	cmp    $0x10,%edx
80103044:	75 f2                	jne    80103038 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103046:	84 c9                	test   %cl,%cl
80103048:	74 10                	je     8010305a <mpsearch1+0x5a>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
8010304a:	83 c6 10             	add    $0x10,%esi
8010304d:	39 f3                	cmp    %esi,%ebx
8010304f:	77 c7                	ja     80103018 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80103051:	83 c4 10             	add    $0x10,%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103054:	31 c0                	xor    %eax,%eax
}
80103056:	5b                   	pop    %ebx
80103057:	5e                   	pop    %esi
80103058:	5d                   	pop    %ebp
80103059:	c3                   	ret    
8010305a:	83 c4 10             	add    $0x10,%esp
8010305d:	89 f0                	mov    %esi,%eax
8010305f:	5b                   	pop    %ebx
80103060:	5e                   	pop    %esi
80103061:	5d                   	pop    %ebp
80103062:	c3                   	ret    
80103063:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103070 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	57                   	push   %edi
80103074:	56                   	push   %esi
80103075:	53                   	push   %ebx
80103076:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103079:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103080:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103087:	c1 e0 08             	shl    $0x8,%eax
8010308a:	09 d0                	or     %edx,%eax
8010308c:	c1 e0 04             	shl    $0x4,%eax
8010308f:	85 c0                	test   %eax,%eax
80103091:	75 1b                	jne    801030ae <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103093:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010309a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801030a1:	c1 e0 08             	shl    $0x8,%eax
801030a4:	09 d0                	or     %edx,%eax
801030a6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801030a9:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
801030ae:	ba 00 04 00 00       	mov    $0x400,%edx
801030b3:	e8 48 ff ff ff       	call   80103000 <mpsearch1>
801030b8:	85 c0                	test   %eax,%eax
801030ba:	89 c7                	mov    %eax,%edi
801030bc:	0f 84 22 01 00 00    	je     801031e4 <mpinit+0x174>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030c2:	8b 77 04             	mov    0x4(%edi),%esi
801030c5:	85 f6                	test   %esi,%esi
801030c7:	0f 84 30 01 00 00    	je     801031fd <mpinit+0x18d>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030cd:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801030d3:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801030da:	00 
801030db:	c7 44 24 04 5d 72 10 	movl   $0x8010725d,0x4(%esp)
801030e2:	80 
801030e3:	89 04 24             	mov    %eax,(%esp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801030e9:	e8 e2 12 00 00       	call   801043d0 <memcmp>
801030ee:	85 c0                	test   %eax,%eax
801030f0:	0f 85 07 01 00 00    	jne    801031fd <mpinit+0x18d>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801030f6:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801030fd:	3c 04                	cmp    $0x4,%al
801030ff:	0f 85 0b 01 00 00    	jne    80103210 <mpinit+0x1a0>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103105:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010310c:	85 c0                	test   %eax,%eax
8010310e:	74 21                	je     80103131 <mpinit+0xc1>
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
80103110:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
80103112:	31 d2                	xor    %edx,%edx
80103114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103118:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
8010311f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103120:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103123:	01 d9                	add    %ebx,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103125:	39 d0                	cmp    %edx,%eax
80103127:	7f ef                	jg     80103118 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103129:	84 c9                	test   %cl,%cl
8010312b:	0f 85 cc 00 00 00    	jne    801031fd <mpinit+0x18d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103131:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103134:	85 c0                	test   %eax,%eax
80103136:	0f 84 c1 00 00 00    	je     801031fd <mpinit+0x18d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010313c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103142:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
80103147:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010314c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103153:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103159:	03 55 e4             	add    -0x1c(%ebp),%edx
8010315c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103160:	39 c2                	cmp    %eax,%edx
80103162:	76 1b                	jbe    8010317f <mpinit+0x10f>
80103164:	0f b6 08             	movzbl (%eax),%ecx
    switch(*p){
80103167:	80 f9 04             	cmp    $0x4,%cl
8010316a:	77 74                	ja     801031e0 <mpinit+0x170>
8010316c:	ff 24 8d 9c 72 10 80 	jmp    *-0x7fef8d64(,%ecx,4)
80103173:	90                   	nop
80103174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103178:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010317b:	39 c2                	cmp    %eax,%edx
8010317d:	77 e5                	ja     80103164 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010317f:	85 db                	test   %ebx,%ebx
80103181:	0f 84 93 00 00 00    	je     8010321a <mpinit+0x1aa>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103187:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
8010318b:	74 12                	je     8010319f <mpinit+0x12f>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010318d:	ba 22 00 00 00       	mov    $0x22,%edx
80103192:	b8 70 00 00 00       	mov    $0x70,%eax
80103197:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103198:	b2 23                	mov    $0x23,%dl
8010319a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010319b:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010319e:	ee                   	out    %al,(%dx)
  }
}
8010319f:	83 c4 1c             	add    $0x1c,%esp
801031a2:	5b                   	pop    %ebx
801031a3:	5e                   	pop    %esi
801031a4:	5f                   	pop    %edi
801031a5:	5d                   	pop    %ebp
801031a6:	c3                   	ret    
801031a7:	90                   	nop
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
801031a8:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801031ae:	83 fe 07             	cmp    $0x7,%esi
801031b1:	7f 17                	jg     801031ca <mpinit+0x15a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b3:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
801031b7:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
        ncpu++;
801031bd:	83 05 00 2d 11 80 01 	addl   $0x1,0x80112d00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c4:	88 8e 80 27 11 80    	mov    %cl,-0x7feed880(%esi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
801031ca:	83 c0 14             	add    $0x14,%eax
      continue;
801031cd:	eb 91                	jmp    80103160 <mpinit+0xf0>
801031cf:	90                   	nop
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031d0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801031d4:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031d7:	88 0d 60 27 11 80    	mov    %cl,0x80112760
      p += sizeof(struct mpioapic);
      continue;
801031dd:	eb 81                	jmp    80103160 <mpinit+0xf0>
801031df:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031e0:	31 db                	xor    %ebx,%ebx
801031e2:	eb 83                	jmp    80103167 <mpinit+0xf7>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031e4:	ba 00 00 01 00       	mov    $0x10000,%edx
801031e9:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031ee:	e8 0d fe ff ff       	call   80103000 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f3:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031f5:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f7:	0f 85 c5 fe ff ff    	jne    801030c2 <mpinit+0x52>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801031fd:	c7 04 24 62 72 10 80 	movl   $0x80107262,(%esp)
80103204:	e8 57 d1 ff ff       	call   80100360 <panic>
80103209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103210:	3c 01                	cmp    $0x1,%al
80103212:	0f 84 ed fe ff ff    	je     80103105 <mpinit+0x95>
80103218:	eb e3                	jmp    801031fd <mpinit+0x18d>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
8010321a:	c7 04 24 7c 72 10 80 	movl   $0x8010727c,(%esp)
80103221:	e8 3a d1 ff ff       	call   80100360 <panic>
80103226:	66 90                	xchg   %ax,%ax
80103228:	66 90                	xchg   %ax,%ax
8010322a:	66 90                	xchg   %ax,%ax
8010322c:	66 90                	xchg   %ax,%ax
8010322e:	66 90                	xchg   %ax,%ax

80103230 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103230:	55                   	push   %ebp
80103231:	ba 21 00 00 00       	mov    $0x21,%edx
80103236:	89 e5                	mov    %esp,%ebp
80103238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010323d:	ee                   	out    %al,(%dx)
8010323e:	b2 a1                	mov    $0xa1,%dl
80103240:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103241:	5d                   	pop    %ebp
80103242:	c3                   	ret    
80103243:	66 90                	xchg   %ax,%ax
80103245:	66 90                	xchg   %ax,%ax
80103247:	66 90                	xchg   %ax,%ax
80103249:	66 90                	xchg   %ax,%ax
8010324b:	66 90                	xchg   %ax,%ax
8010324d:	66 90                	xchg   %ax,%ax
8010324f:	90                   	nop

80103250 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	57                   	push   %edi
80103254:	56                   	push   %esi
80103255:	53                   	push   %ebx
80103256:	83 ec 1c             	sub    $0x1c,%esp
80103259:	8b 75 08             	mov    0x8(%ebp),%esi
8010325c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010325f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103265:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010326b:	e8 e0 db ff ff       	call   80100e50 <filealloc>
80103270:	85 c0                	test   %eax,%eax
80103272:	89 06                	mov    %eax,(%esi)
80103274:	0f 84 a4 00 00 00    	je     8010331e <pipealloc+0xce>
8010327a:	e8 d1 db ff ff       	call   80100e50 <filealloc>
8010327f:	85 c0                	test   %eax,%eax
80103281:	89 03                	mov    %eax,(%ebx)
80103283:	0f 84 87 00 00 00    	je     80103310 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103289:	e8 02 f3 ff ff       	call   80102590 <kalloc>
8010328e:	85 c0                	test   %eax,%eax
80103290:	89 c7                	mov    %eax,%edi
80103292:	74 7c                	je     80103310 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
80103294:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010329b:	00 00 00 
  p->writeopen = 1;
8010329e:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032a5:	00 00 00 
  p->nwrite = 0;
801032a8:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032af:	00 00 00 
  p->nread = 0;
801032b2:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801032b9:	00 00 00 
  initlock(&p->lock, "pipe");
801032bc:	89 04 24             	mov    %eax,(%esp)
801032bf:	c7 44 24 04 b0 72 10 	movl   $0x801072b0,0x4(%esp)
801032c6:	80 
801032c7:	e8 84 0e 00 00       	call   80104150 <initlock>
  (*f0)->type = FD_PIPE;
801032cc:	8b 06                	mov    (%esi),%eax
801032ce:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801032d4:	8b 06                	mov    (%esi),%eax
801032d6:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801032da:	8b 06                	mov    (%esi),%eax
801032dc:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801032e0:	8b 06                	mov    (%esi),%eax
801032e2:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801032e5:	8b 03                	mov    (%ebx),%eax
801032e7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801032ed:	8b 03                	mov    (%ebx),%eax
801032ef:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801032f3:	8b 03                	mov    (%ebx),%eax
801032f5:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801032f9:	8b 03                	mov    (%ebx),%eax
  return 0;
801032fb:	31 db                	xor    %ebx,%ebx
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
801032fd:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103300:	83 c4 1c             	add    $0x1c,%esp
80103303:	89 d8                	mov    %ebx,%eax
80103305:	5b                   	pop    %ebx
80103306:	5e                   	pop    %esi
80103307:	5f                   	pop    %edi
80103308:	5d                   	pop    %ebp
80103309:	c3                   	ret    
8010330a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103310:	8b 06                	mov    (%esi),%eax
80103312:	85 c0                	test   %eax,%eax
80103314:	74 08                	je     8010331e <pipealloc+0xce>
    fileclose(*f0);
80103316:	89 04 24             	mov    %eax,(%esp)
80103319:	e8 f2 db ff ff       	call   80100f10 <fileclose>
  if(*f1)
8010331e:	8b 03                	mov    (%ebx),%eax
    fileclose(*f1);
  return -1;
80103320:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
80103325:	85 c0                	test   %eax,%eax
80103327:	74 d7                	je     80103300 <pipealloc+0xb0>
    fileclose(*f1);
80103329:	89 04 24             	mov    %eax,(%esp)
8010332c:	e8 df db ff ff       	call   80100f10 <fileclose>
  return -1;
}
80103331:	83 c4 1c             	add    $0x1c,%esp
80103334:	89 d8                	mov    %ebx,%eax
80103336:	5b                   	pop    %ebx
80103337:	5e                   	pop    %esi
80103338:	5f                   	pop    %edi
80103339:	5d                   	pop    %ebp
8010333a:	c3                   	ret    
8010333b:	90                   	nop
8010333c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103340 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	56                   	push   %esi
80103344:	53                   	push   %ebx
80103345:	83 ec 10             	sub    $0x10,%esp
80103348:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010334b:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010334e:	89 1c 24             	mov    %ebx,(%esp)
80103351:	e8 6a 0f 00 00       	call   801042c0 <acquire>
  if(writable){
80103356:	85 f6                	test   %esi,%esi
80103358:	74 3e                	je     80103398 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->nread);
8010335a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103360:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103367:	00 00 00 
    wakeup(&p->nread);
8010336a:	89 04 24             	mov    %eax,(%esp)
8010336d:	e8 fe 0a 00 00       	call   80103e70 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103372:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103378:	85 d2                	test   %edx,%edx
8010337a:	75 0a                	jne    80103386 <pipeclose+0x46>
8010337c:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103382:	85 c0                	test   %eax,%eax
80103384:	74 32                	je     801033b8 <pipeclose+0x78>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103386:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103389:	83 c4 10             	add    $0x10,%esp
8010338c:	5b                   	pop    %ebx
8010338d:	5e                   	pop    %esi
8010338e:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010338f:	e9 9c 0f 00 00       	jmp    80104330 <release>
80103394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103398:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
8010339e:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033a5:	00 00 00 
    wakeup(&p->nwrite);
801033a8:	89 04 24             	mov    %eax,(%esp)
801033ab:	e8 c0 0a 00 00       	call   80103e70 <wakeup>
801033b0:	eb c0                	jmp    80103372 <pipeclose+0x32>
801033b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801033b8:	89 1c 24             	mov    %ebx,(%esp)
801033bb:	e8 70 0f 00 00       	call   80104330 <release>
    kfree((char*)p);
801033c0:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
801033c3:	83 c4 10             	add    $0x10,%esp
801033c6:	5b                   	pop    %ebx
801033c7:	5e                   	pop    %esi
801033c8:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801033c9:	e9 12 f0 ff ff       	jmp    801023e0 <kfree>
801033ce:	66 90                	xchg   %ax,%ax

801033d0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033d0:	55                   	push   %ebp
801033d1:	89 e5                	mov    %esp,%ebp
801033d3:	57                   	push   %edi
801033d4:	56                   	push   %esi
801033d5:	53                   	push   %ebx
801033d6:	83 ec 1c             	sub    $0x1c,%esp
801033d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033dc:	89 1c 24             	mov    %ebx,(%esp)
801033df:	e8 dc 0e 00 00       	call   801042c0 <acquire>
  for(i = 0; i < n; i++){
801033e4:	8b 4d 10             	mov    0x10(%ebp),%ecx
801033e7:	85 c9                	test   %ecx,%ecx
801033e9:	0f 8e b2 00 00 00    	jle    801034a1 <pipewrite+0xd1>
801033ef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033f2:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801033f8:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033fe:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103404:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103407:	03 4d 10             	add    0x10(%ebp),%ecx
8010340a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010340d:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103413:	81 c1 00 02 00 00    	add    $0x200,%ecx
80103419:	39 c8                	cmp    %ecx,%eax
8010341b:	74 38                	je     80103455 <pipewrite+0x85>
8010341d:	eb 55                	jmp    80103474 <pipewrite+0xa4>
8010341f:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103420:	e8 5b 03 00 00       	call   80103780 <myproc>
80103425:	8b 40 24             	mov    0x24(%eax),%eax
80103428:	85 c0                	test   %eax,%eax
8010342a:	75 33                	jne    8010345f <pipewrite+0x8f>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010342c:	89 3c 24             	mov    %edi,(%esp)
8010342f:	e8 3c 0a 00 00       	call   80103e70 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103434:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103438:	89 34 24             	mov    %esi,(%esp)
8010343b:	e8 a0 08 00 00       	call   80103ce0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103440:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103446:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010344c:	05 00 02 00 00       	add    $0x200,%eax
80103451:	39 c2                	cmp    %eax,%edx
80103453:	75 23                	jne    80103478 <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
80103455:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010345b:	85 d2                	test   %edx,%edx
8010345d:	75 c1                	jne    80103420 <pipewrite+0x50>
        release(&p->lock);
8010345f:	89 1c 24             	mov    %ebx,(%esp)
80103462:	e8 c9 0e 00 00       	call   80104330 <release>
        return -1;
80103467:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010346c:	83 c4 1c             	add    $0x1c,%esp
8010346f:	5b                   	pop    %ebx
80103470:	5e                   	pop    %esi
80103471:	5f                   	pop    %edi
80103472:	5d                   	pop    %ebp
80103473:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103474:	89 c2                	mov    %eax,%edx
80103476:	66 90                	xchg   %ax,%ax
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103478:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010347b:	8d 42 01             	lea    0x1(%edx),%eax
8010347e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103484:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
8010348a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010348e:	0f b6 09             	movzbl (%ecx),%ecx
80103491:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103495:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103498:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
8010349b:	0f 85 6c ff ff ff    	jne    8010340d <pipewrite+0x3d>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034a1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034a7:	89 04 24             	mov    %eax,(%esp)
801034aa:	e8 c1 09 00 00       	call   80103e70 <wakeup>
  release(&p->lock);
801034af:	89 1c 24             	mov    %ebx,(%esp)
801034b2:	e8 79 0e 00 00       	call   80104330 <release>
  return n;
801034b7:	8b 45 10             	mov    0x10(%ebp),%eax
801034ba:	eb b0                	jmp    8010346c <pipewrite+0x9c>
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801034c0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	57                   	push   %edi
801034c4:	56                   	push   %esi
801034c5:	53                   	push   %ebx
801034c6:	83 ec 1c             	sub    $0x1c,%esp
801034c9:	8b 75 08             	mov    0x8(%ebp),%esi
801034cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801034cf:	89 34 24             	mov    %esi,(%esp)
801034d2:	e8 e9 0d 00 00       	call   801042c0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034d7:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801034dd:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801034e3:	75 5b                	jne    80103540 <piperead+0x80>
801034e5:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801034eb:	85 db                	test   %ebx,%ebx
801034ed:	74 51                	je     80103540 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801034ef:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801034f5:	eb 25                	jmp    8010351c <piperead+0x5c>
801034f7:	90                   	nop
801034f8:	89 74 24 04          	mov    %esi,0x4(%esp)
801034fc:	89 1c 24             	mov    %ebx,(%esp)
801034ff:	e8 dc 07 00 00       	call   80103ce0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103504:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010350a:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103510:	75 2e                	jne    80103540 <piperead+0x80>
80103512:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103518:	85 d2                	test   %edx,%edx
8010351a:	74 24                	je     80103540 <piperead+0x80>
    if(myproc()->killed){
8010351c:	e8 5f 02 00 00       	call   80103780 <myproc>
80103521:	8b 48 24             	mov    0x24(%eax),%ecx
80103524:	85 c9                	test   %ecx,%ecx
80103526:	74 d0                	je     801034f8 <piperead+0x38>
      release(&p->lock);
80103528:	89 34 24             	mov    %esi,(%esp)
8010352b:	e8 00 0e 00 00       	call   80104330 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103530:	83 c4 1c             	add    $0x1c,%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103533:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103538:	5b                   	pop    %ebx
80103539:	5e                   	pop    %esi
8010353a:	5f                   	pop    %edi
8010353b:	5d                   	pop    %ebp
8010353c:	c3                   	ret    
8010353d:	8d 76 00             	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103540:	8b 55 10             	mov    0x10(%ebp),%edx
    if(p->nread == p->nwrite)
80103543:	31 db                	xor    %ebx,%ebx
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103545:	85 d2                	test   %edx,%edx
80103547:	7f 2b                	jg     80103574 <piperead+0xb4>
80103549:	eb 31                	jmp    8010357c <piperead+0xbc>
8010354b:	90                   	nop
8010354c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103550:	8d 48 01             	lea    0x1(%eax),%ecx
80103553:	25 ff 01 00 00       	and    $0x1ff,%eax
80103558:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010355e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103563:	88 04 1f             	mov    %al,(%edi,%ebx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103566:	83 c3 01             	add    $0x1,%ebx
80103569:	3b 5d 10             	cmp    0x10(%ebp),%ebx
8010356c:	74 0e                	je     8010357c <piperead+0xbc>
    if(p->nread == p->nwrite)
8010356e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103574:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010357a:	75 d4                	jne    80103550 <piperead+0x90>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010357c:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103582:	89 04 24             	mov    %eax,(%esp)
80103585:	e8 e6 08 00 00       	call   80103e70 <wakeup>
  release(&p->lock);
8010358a:	89 34 24             	mov    %esi,(%esp)
8010358d:	e8 9e 0d 00 00       	call   80104330 <release>
  return i;
}
80103592:	83 c4 1c             	add    $0x1c,%esp
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
80103595:	89 d8                	mov    %ebx,%eax
}
80103597:	5b                   	pop    %ebx
80103598:	5e                   	pop    %esi
80103599:	5f                   	pop    %edi
8010359a:	5d                   	pop    %ebp
8010359b:	c3                   	ret    
8010359c:	66 90                	xchg   %ax,%ax
8010359e:	66 90                	xchg   %ax,%ax

801035a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035a0:	55                   	push   %ebp
801035a1:	89 e5                	mov    %esp,%ebp
801035a3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035a4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035a9:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801035ac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035b3:	e8 08 0d 00 00       	call   801042c0 <acquire>
801035b8:	eb 11                	jmp    801035cb <allocproc+0x2b>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035c0:	83 c3 7c             	add    $0x7c,%ebx
801035c3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801035c9:	74 7d                	je     80103648 <allocproc+0xa8>
    if(p->state == UNUSED)
801035cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801035ce:	85 c0                	test   %eax,%eax
801035d0:	75 ee                	jne    801035c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035d2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801035d7:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801035de:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801035e5:	8d 50 01             	lea    0x1(%eax),%edx
801035e8:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
801035ee:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801035f1:	e8 3a 0d 00 00       	call   80104330 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801035f6:	e8 95 ef ff ff       	call   80102590 <kalloc>
801035fb:	85 c0                	test   %eax,%eax
801035fd:	89 43 08             	mov    %eax,0x8(%ebx)
80103600:	74 5a                	je     8010365c <allocproc+0xbc>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103602:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103608:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010360d:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103610:	c7 40 14 65 55 10 80 	movl   $0x80105565,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103617:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010361e:	00 
8010361f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103626:	00 
80103627:	89 04 24             	mov    %eax,(%esp)
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
8010362a:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010362d:	e8 4e 0d 00 00       	call   80104380 <memset>
  p->context->eip = (uint)forkret;
80103632:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103635:	c7 40 10 70 36 10 80 	movl   $0x80103670,0x10(%eax)

  return p;
8010363c:	89 d8                	mov    %ebx,%eax
}
8010363e:	83 c4 14             	add    $0x14,%esp
80103641:	5b                   	pop    %ebx
80103642:	5d                   	pop    %ebp
80103643:	c3                   	ret    
80103644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103648:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010364f:	e8 dc 0c 00 00       	call   80104330 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103654:	83 c4 14             	add    $0x14,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;
80103657:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103659:	5b                   	pop    %ebx
8010365a:	5d                   	pop    %ebp
8010365b:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
8010365c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103663:	eb d9                	jmp    8010363e <allocproc+0x9e>
80103665:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103670 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103676:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010367d:	e8 ae 0c 00 00       	call   80104330 <release>

  if (first) {
80103682:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103687:	85 c0                	test   %eax,%eax
80103689:	75 05                	jne    80103690 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010368b:	c9                   	leave  
8010368c:	c3                   	ret    
8010368d:	8d 76 00             	lea    0x0(%esi),%esi
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103690:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103697:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010369e:	00 00 00 
    iinit(ROOTDEV);
801036a1:	e8 ba de ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
801036a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801036ad:	e8 9e f4 ff ff       	call   80102b50 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036b2:	c9                   	leave  
801036b3:	c3                   	ret    
801036b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036c0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801036c6:	c7 44 24 04 b5 72 10 	movl   $0x801072b5,0x4(%esp)
801036cd:	80 
801036ce:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801036d5:	e8 76 0a 00 00       	call   80104150 <initlock>
}
801036da:	c9                   	leave  
801036db:	c3                   	ret    
801036dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036e0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	56                   	push   %esi
801036e4:	53                   	push   %ebx
801036e5:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801036e8:	9c                   	pushf  
801036e9:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801036ea:	f6 c4 02             	test   $0x2,%ah
801036ed:	75 57                	jne    80103746 <mycpu+0x66>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801036ef:	e8 4c f1 ff ff       	call   80102840 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801036f4:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801036fa:	85 f6                	test   %esi,%esi
801036fc:	7e 3c                	jle    8010373a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801036fe:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103705:	39 c2                	cmp    %eax,%edx
80103707:	74 2d                	je     80103736 <mycpu+0x56>
80103709:	b9 30 28 11 80       	mov    $0x80112830,%ecx
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
8010370e:	31 d2                	xor    %edx,%edx
80103710:	83 c2 01             	add    $0x1,%edx
80103713:	39 f2                	cmp    %esi,%edx
80103715:	74 23                	je     8010373a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103717:	0f b6 19             	movzbl (%ecx),%ebx
8010371a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103720:	39 c3                	cmp    %eax,%ebx
80103722:	75 ec                	jne    80103710 <mycpu+0x30>
      return &cpus[i];
80103724:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010372a:	83 c4 10             	add    $0x10,%esp
8010372d:	5b                   	pop    %ebx
8010372e:	5e                   	pop    %esi
8010372f:	5d                   	pop    %ebp
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
80103730:	05 80 27 11 80       	add    $0x80112780,%eax
  }
  panic("unknown apicid\n");
}
80103735:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103736:	31 d2                	xor    %edx,%edx
80103738:	eb ea                	jmp    80103724 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010373a:	c7 04 24 bc 72 10 80 	movl   $0x801072bc,(%esp)
80103741:	e8 1a cc ff ff       	call   80100360 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103746:	c7 04 24 98 73 10 80 	movl   $0x80107398,(%esp)
8010374d:	e8 0e cc ff ff       	call   80100360 <panic>
80103752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103760 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103766:	e8 75 ff ff ff       	call   801036e0 <mycpu>
}
8010376b:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
8010376c:	2d 80 27 11 80       	sub    $0x80112780,%eax
80103771:	c1 f8 04             	sar    $0x4,%eax
80103774:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010377a:	c3                   	ret    
8010377b:	90                   	nop
8010377c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103780 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	53                   	push   %ebx
80103784:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103787:	e8 44 0a 00 00       	call   801041d0 <pushcli>
  c = mycpu();
8010378c:	e8 4f ff ff ff       	call   801036e0 <mycpu>
  p = c->proc;
80103791:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103797:	e8 74 0a 00 00       	call   80104210 <popcli>
  return p;
}
8010379c:	83 c4 04             	add    $0x4,%esp
8010379f:	89 d8                	mov    %ebx,%eax
801037a1:	5b                   	pop    %ebx
801037a2:	5d                   	pop    %ebp
801037a3:	c3                   	ret    
801037a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037b0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
801037b4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801037b7:	e8 e4 fd ff ff       	call   801035a0 <allocproc>
801037bc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801037be:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801037c3:	e8 f8 32 00 00       	call   80106ac0 <setupkvm>
801037c8:	85 c0                	test   %eax,%eax
801037ca:	89 43 04             	mov    %eax,0x4(%ebx)
801037cd:	0f 84 d4 00 00 00    	je     801038a7 <userinit+0xf7>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801037d3:	89 04 24             	mov    %eax,(%esp)
801037d6:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
801037dd:	00 
801037de:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
801037e5:	80 
801037e6:	e8 05 30 00 00       	call   801067f0 <inituvm>
  p->sz = PGSIZE;
801037eb:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801037f1:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801037f8:	00 
801037f9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103800:	00 
80103801:	8b 43 18             	mov    0x18(%ebx),%eax
80103804:	89 04 24             	mov    %eax,(%esp)
80103807:	e8 74 0b 00 00       	call   80104380 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010380c:	8b 43 18             	mov    0x18(%ebx),%eax
8010380f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103814:	b9 23 00 00 00       	mov    $0x23,%ecx
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103819:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010381d:	8b 43 18             	mov    0x18(%ebx),%eax
80103820:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103824:	8b 43 18             	mov    0x18(%ebx),%eax
80103827:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010382b:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010382f:	8b 43 18             	mov    0x18(%ebx),%eax
80103832:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103836:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010383a:	8b 43 18             	mov    0x18(%ebx),%eax
8010383d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103844:	8b 43 18             	mov    0x18(%ebx),%eax
80103847:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010384e:	8b 43 18             	mov    0x18(%ebx),%eax
80103851:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103858:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010385b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103862:	00 
80103863:	c7 44 24 04 e5 72 10 	movl   $0x801072e5,0x4(%esp)
8010386a:	80 
8010386b:	89 04 24             	mov    %eax,(%esp)
8010386e:	e8 ed 0c 00 00       	call   80104560 <safestrcpy>
  p->cwd = namei("/");
80103873:	c7 04 24 ee 72 10 80 	movl   $0x801072ee,(%esp)
8010387a:	e8 71 e7 ff ff       	call   80101ff0 <namei>
8010387f:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103882:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103889:	e8 32 0a 00 00       	call   801042c0 <acquire>

  p->state = RUNNABLE;
8010388e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103895:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010389c:	e8 8f 0a 00 00       	call   80104330 <release>
}
801038a1:	83 c4 14             	add    $0x14,%esp
801038a4:	5b                   	pop    %ebx
801038a5:	5d                   	pop    %ebp
801038a6:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801038a7:	c7 04 24 cc 72 10 80 	movl   $0x801072cc,(%esp)
801038ae:	e8 ad ca ff ff       	call   80100360 <panic>
801038b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038c0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	56                   	push   %esi
801038c4:	53                   	push   %ebx
801038c5:	83 ec 10             	sub    $0x10,%esp
801038c8:	8b 75 08             	mov    0x8(%ebp),%esi
  uint sz;
  struct proc *curproc = myproc();
801038cb:	e8 b0 fe ff ff       	call   80103780 <myproc>

  sz = curproc->sz;
  if(n > 0){
801038d0:	83 fe 00             	cmp    $0x0,%esi
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();
801038d3:	89 c3                	mov    %eax,%ebx

  sz = curproc->sz;
801038d5:	8b 00                	mov    (%eax),%eax
  if(n > 0){
801038d7:	7e 2f                	jle    80103908 <growproc+0x48>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801038d9:	01 c6                	add    %eax,%esi
801038db:	89 74 24 08          	mov    %esi,0x8(%esp)
801038df:	89 44 24 04          	mov    %eax,0x4(%esp)
801038e3:	8b 43 04             	mov    0x4(%ebx),%eax
801038e6:	89 04 24             	mov    %eax,(%esp)
801038e9:	e8 42 30 00 00       	call   80106930 <allocuvm>
801038ee:	85 c0                	test   %eax,%eax
801038f0:	74 36                	je     80103928 <growproc+0x68>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801038f2:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801038f4:	89 1c 24             	mov    %ebx,(%esp)
801038f7:	e8 e4 2d 00 00       	call   801066e0 <switchuvm>
  return 0;
801038fc:	31 c0                	xor    %eax,%eax
}
801038fe:	83 c4 10             	add    $0x10,%esp
80103901:	5b                   	pop    %ebx
80103902:	5e                   	pop    %esi
80103903:	5d                   	pop    %ebp
80103904:	c3                   	ret    
80103905:	8d 76 00             	lea    0x0(%esi),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103908:	74 e8                	je     801038f2 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010390a:	01 c6                	add    %eax,%esi
8010390c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103910:	89 44 24 04          	mov    %eax,0x4(%esp)
80103914:	8b 43 04             	mov    0x4(%ebx),%eax
80103917:	89 04 24             	mov    %eax,(%esp)
8010391a:	e8 01 31 00 00       	call   80106a20 <deallocuvm>
8010391f:	85 c0                	test   %eax,%eax
80103921:	75 cf                	jne    801038f2 <growproc+0x32>
80103923:	90                   	nop
80103924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103928:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010392d:	eb cf                	jmp    801038fe <growproc+0x3e>
8010392f:	90                   	nop

80103930 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	57                   	push   %edi
80103934:	56                   	push   %esi
80103935:	53                   	push   %ebx
80103936:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
80103939:	e8 42 fe ff ff       	call   80103780 <myproc>
8010393e:	89 c3                	mov    %eax,%ebx

  // Allocate process.
  if((np = allocproc()) == 0){
80103940:	e8 5b fc ff ff       	call   801035a0 <allocproc>
80103945:	85 c0                	test   %eax,%eax
80103947:	89 c7                	mov    %eax,%edi
80103949:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010394c:	0f 84 bc 00 00 00    	je     80103a0e <fork+0xde>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103952:	8b 03                	mov    (%ebx),%eax
80103954:	89 44 24 04          	mov    %eax,0x4(%esp)
80103958:	8b 43 04             	mov    0x4(%ebx),%eax
8010395b:	89 04 24             	mov    %eax,(%esp)
8010395e:	e8 3d 32 00 00       	call   80106ba0 <copyuvm>
80103963:	85 c0                	test   %eax,%eax
80103965:	89 47 04             	mov    %eax,0x4(%edi)
80103968:	0f 84 a7 00 00 00    	je     80103a15 <fork+0xe5>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
8010396e:	8b 03                	mov    (%ebx),%eax
80103970:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103973:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
  *np->tf = *curproc->tf;
80103975:	8b 79 18             	mov    0x18(%ecx),%edi
80103978:	89 c8                	mov    %ecx,%eax
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
8010397a:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010397d:	8b 73 18             	mov    0x18(%ebx),%esi
80103980:	b9 13 00 00 00       	mov    $0x13,%ecx
80103985:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103987:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103989:	8b 40 18             	mov    0x18(%eax),%eax
8010398c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103993:	90                   	nop
80103994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103998:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010399c:	85 c0                	test   %eax,%eax
8010399e:	74 0f                	je     801039af <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039a0:	89 04 24             	mov    %eax,(%esp)
801039a3:	e8 18 d5 ff ff       	call   80100ec0 <filedup>
801039a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039ab:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801039af:	83 c6 01             	add    $0x1,%esi
801039b2:	83 fe 10             	cmp    $0x10,%esi
801039b5:	75 e1                	jne    80103998 <fork+0x68>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039b7:	8b 43 68             	mov    0x68(%ebx),%eax

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039ba:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039bd:	89 04 24             	mov    %eax,(%esp)
801039c0:	e8 ab dd ff ff       	call   80101770 <idup>
801039c5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801039c8:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039cb:	8d 47 6c             	lea    0x6c(%edi),%eax
801039ce:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801039d2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801039d9:	00 
801039da:	89 04 24             	mov    %eax,(%esp)
801039dd:	e8 7e 0b 00 00       	call   80104560 <safestrcpy>

  pid = np->pid;
801039e2:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801039e5:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039ec:	e8 cf 08 00 00       	call   801042c0 <acquire>

  np->state = RUNNABLE;
801039f1:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801039f8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039ff:	e8 2c 09 00 00       	call   80104330 <release>

  return pid;
80103a04:	89 d8                	mov    %ebx,%eax
}
80103a06:	83 c4 1c             	add    $0x1c,%esp
80103a09:	5b                   	pop    %ebx
80103a0a:	5e                   	pop    %esi
80103a0b:	5f                   	pop    %edi
80103a0c:	5d                   	pop    %ebp
80103a0d:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103a0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a13:	eb f1                	jmp    80103a06 <fork+0xd6>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103a15:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103a18:	8b 47 08             	mov    0x8(%edi),%eax
80103a1b:	89 04 24             	mov    %eax,(%esp)
80103a1e:	e8 bd e9 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
80103a23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
80103a28:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103a2f:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103a36:	eb ce                	jmp    80103a06 <fork+0xd6>
80103a38:	90                   	nop
80103a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a40 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	57                   	push   %edi
80103a44:	56                   	push   %esi
80103a45:	53                   	push   %ebx
80103a46:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103a49:	e8 92 fc ff ff       	call   801036e0 <mycpu>
80103a4e:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103a50:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103a57:	00 00 00 
80103a5a:	8d 78 04             	lea    0x4(%eax),%edi
80103a5d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103a60:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a61:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a68:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a6d:	e8 4e 08 00 00       	call   801042c0 <acquire>
80103a72:	eb 0f                	jmp    80103a83 <scheduler+0x43>
80103a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a78:	83 c3 7c             	add    $0x7c,%ebx
80103a7b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103a81:	74 45                	je     80103ac8 <scheduler+0x88>
      if(p->state != RUNNABLE)
80103a83:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103a87:	75 ef                	jne    80103a78 <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103a89:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103a8f:	89 1c 24             	mov    %ebx,(%esp)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a92:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103a95:	e8 46 2c 00 00       	call   801066e0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103a9a:	8b 43 a0             	mov    -0x60(%ebx),%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103a9d:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103aa4:	89 3c 24             	mov    %edi,(%esp)
80103aa7:	89 44 24 04          	mov    %eax,0x4(%esp)
80103aab:	e8 0b 0b 00 00       	call   801045bb <swtch>
      switchkvm();
80103ab0:	e8 0b 2c 00 00       	call   801066c0 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ab5:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103abb:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103ac2:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ac5:	75 bc                	jne    80103a83 <scheduler+0x43>
80103ac7:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103ac8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103acf:	e8 5c 08 00 00       	call   80104330 <release>

  }
80103ad4:	eb 8a                	jmp    80103a60 <scheduler+0x20>
80103ad6:	8d 76 00             	lea    0x0(%esi),%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ae0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	56                   	push   %esi
80103ae4:	53                   	push   %ebx
80103ae5:	83 ec 10             	sub    $0x10,%esp
  int intena;
  struct proc *p = myproc();
80103ae8:	e8 93 fc ff ff       	call   80103780 <myproc>

  if(!holding(&ptable.lock))
80103aed:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();
80103af4:	89 c3                	mov    %eax,%ebx

  if(!holding(&ptable.lock))
80103af6:	e8 85 07 00 00       	call   80104280 <holding>
80103afb:	85 c0                	test   %eax,%eax
80103afd:	74 4f                	je     80103b4e <sched+0x6e>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103aff:	e8 dc fb ff ff       	call   801036e0 <mycpu>
80103b04:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b0b:	75 65                	jne    80103b72 <sched+0x92>
    panic("sched locks");
  if(p->state == RUNNING)
80103b0d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b11:	74 53                	je     80103b66 <sched+0x86>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b13:	9c                   	pushf  
80103b14:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103b15:	f6 c4 02             	test   $0x2,%ah
80103b18:	75 40                	jne    80103b5a <sched+0x7a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b1a:	e8 c1 fb ff ff       	call   801036e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b1f:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b22:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b28:	e8 b3 fb ff ff       	call   801036e0 <mycpu>
80103b2d:	8b 40 04             	mov    0x4(%eax),%eax
80103b30:	89 1c 24             	mov    %ebx,(%esp)
80103b33:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b37:	e8 7f 0a 00 00       	call   801045bb <swtch>
  mycpu()->intena = intena;
80103b3c:	e8 9f fb ff ff       	call   801036e0 <mycpu>
80103b41:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103b47:	83 c4 10             	add    $0x10,%esp
80103b4a:	5b                   	pop    %ebx
80103b4b:	5e                   	pop    %esi
80103b4c:	5d                   	pop    %ebp
80103b4d:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103b4e:	c7 04 24 f0 72 10 80 	movl   $0x801072f0,(%esp)
80103b55:	e8 06 c8 ff ff       	call   80100360 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103b5a:	c7 04 24 1c 73 10 80 	movl   $0x8010731c,(%esp)
80103b61:	e8 fa c7 ff ff       	call   80100360 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103b66:	c7 04 24 0e 73 10 80 	movl   $0x8010730e,(%esp)
80103b6d:	e8 ee c7 ff ff       	call   80100360 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103b72:	c7 04 24 02 73 10 80 	movl   $0x80107302,(%esp)
80103b79:	e8 e2 c7 ff ff       	call   80100360 <panic>
80103b7e:	66 90                	xchg   %ax,%ax

80103b80 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	56                   	push   %esi
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103b84:	31 f6                	xor    %esi,%esi
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103b86:	53                   	push   %ebx
80103b87:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103b8a:	e8 f1 fb ff ff       	call   80103780 <myproc>
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103b8f:	3b 05 b8 a5 10 80    	cmp    0x8010a5b8,%eax
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
80103b95:	89 c3                	mov    %eax,%ebx
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103b97:	0f 84 ea 00 00 00    	je     80103c87 <exit+0x107>
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103ba0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ba4:	85 c0                	test   %eax,%eax
80103ba6:	74 10                	je     80103bb8 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103ba8:	89 04 24             	mov    %eax,(%esp)
80103bab:	e8 60 d3 ff ff       	call   80100f10 <fileclose>
      curproc->ofile[fd] = 0;
80103bb0:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103bb7:	00 

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103bb8:	83 c6 01             	add    $0x1,%esi
80103bbb:	83 fe 10             	cmp    $0x10,%esi
80103bbe:	75 e0                	jne    80103ba0 <exit+0x20>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103bc0:	e8 2b f0 ff ff       	call   80102bf0 <begin_op>
  iput(curproc->cwd);
80103bc5:	8b 43 68             	mov    0x68(%ebx),%eax
80103bc8:	89 04 24             	mov    %eax,(%esp)
80103bcb:	e8 f0 dc ff ff       	call   801018c0 <iput>
  end_op();
80103bd0:	e8 8b f0 ff ff       	call   80102c60 <end_op>
  curproc->cwd = 0;
80103bd5:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)

  acquire(&ptable.lock);
80103bdc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103be3:	e8 d8 06 00 00       	call   801042c0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103be8:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103beb:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103bf0:	eb 11                	jmp    80103c03 <exit+0x83>
80103bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bf8:	83 c2 7c             	add    $0x7c,%edx
80103bfb:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103c01:	74 1d                	je     80103c20 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
80103c03:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c07:	75 ef                	jne    80103bf8 <exit+0x78>
80103c09:	3b 42 20             	cmp    0x20(%edx),%eax
80103c0c:	75 ea                	jne    80103bf8 <exit+0x78>
      p->state = RUNNABLE;
80103c0e:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c15:	83 c2 7c             	add    $0x7c,%edx
80103c18:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103c1e:	75 e3                	jne    80103c03 <exit+0x83>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103c20:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80103c25:	b9 54 2d 11 80       	mov    $0x80112d54,%ecx
80103c2a:	eb 0f                	jmp    80103c3b <exit+0xbb>
80103c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c30:	83 c1 7c             	add    $0x7c,%ecx
80103c33:	81 f9 54 4c 11 80    	cmp    $0x80114c54,%ecx
80103c39:	74 34                	je     80103c6f <exit+0xef>
    if(p->parent == curproc){
80103c3b:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103c3e:	75 f0                	jne    80103c30 <exit+0xb0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103c40:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103c44:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103c47:	75 e7                	jne    80103c30 <exit+0xb0>
80103c49:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103c4e:	eb 0b                	jmp    80103c5b <exit+0xdb>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c50:	83 c2 7c             	add    $0x7c,%edx
80103c53:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103c59:	74 d5                	je     80103c30 <exit+0xb0>
    if(p->state == SLEEPING && p->chan == chan)
80103c5b:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c5f:	75 ef                	jne    80103c50 <exit+0xd0>
80103c61:	3b 42 20             	cmp    0x20(%edx),%eax
80103c64:	75 ea                	jne    80103c50 <exit+0xd0>
      p->state = RUNNABLE;
80103c66:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103c6d:	eb e1                	jmp    80103c50 <exit+0xd0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103c6f:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103c76:	e8 65 fe ff ff       	call   80103ae0 <sched>
  panic("zombie exit");
80103c7b:	c7 04 24 3d 73 10 80 	movl   $0x8010733d,(%esp)
80103c82:	e8 d9 c6 ff ff       	call   80100360 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103c87:	c7 04 24 30 73 10 80 	movl   $0x80107330,(%esp)
80103c8e:	e8 cd c6 ff ff       	call   80100360 <panic>
80103c93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ca0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ca6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cad:	e8 0e 06 00 00       	call   801042c0 <acquire>
  myproc()->state = RUNNABLE;
80103cb2:	e8 c9 fa ff ff       	call   80103780 <myproc>
80103cb7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103cbe:	e8 1d fe ff ff       	call   80103ae0 <sched>
  release(&ptable.lock);
80103cc3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cca:	e8 61 06 00 00       	call   80104330 <release>
}
80103ccf:	c9                   	leave  
80103cd0:	c3                   	ret    
80103cd1:	eb 0d                	jmp    80103ce0 <sleep>
80103cd3:	90                   	nop
80103cd4:	90                   	nop
80103cd5:	90                   	nop
80103cd6:	90                   	nop
80103cd7:	90                   	nop
80103cd8:	90                   	nop
80103cd9:	90                   	nop
80103cda:	90                   	nop
80103cdb:	90                   	nop
80103cdc:	90                   	nop
80103cdd:	90                   	nop
80103cde:	90                   	nop
80103cdf:	90                   	nop

80103ce0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 1c             	sub    $0x1c,%esp
80103ce9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103cec:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103cef:	e8 8c fa ff ff       	call   80103780 <myproc>
  
  if(p == 0)
80103cf4:	85 c0                	test   %eax,%eax
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
80103cf6:	89 c3                	mov    %eax,%ebx
  
  if(p == 0)
80103cf8:	0f 84 7c 00 00 00    	je     80103d7a <sleep+0x9a>
    panic("sleep");

  if(lk == 0)
80103cfe:	85 f6                	test   %esi,%esi
80103d00:	74 6c                	je     80103d6e <sleep+0x8e>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103d02:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103d08:	74 46                	je     80103d50 <sleep+0x70>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103d0a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d11:	e8 aa 05 00 00       	call   801042c0 <acquire>
    release(lk);
80103d16:	89 34 24             	mov    %esi,(%esp)
80103d19:	e8 12 06 00 00       	call   80104330 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103d1e:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103d21:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103d28:	e8 b3 fd ff ff       	call   80103ae0 <sched>

  // Tidy up.
  p->chan = 0;
80103d2d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103d34:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d3b:	e8 f0 05 00 00       	call   80104330 <release>
    acquire(lk);
80103d40:	89 75 08             	mov    %esi,0x8(%ebp)
  }
}
80103d43:	83 c4 1c             	add    $0x1c,%esp
80103d46:	5b                   	pop    %ebx
80103d47:	5e                   	pop    %esi
80103d48:	5f                   	pop    %edi
80103d49:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103d4a:	e9 71 05 00 00       	jmp    801042c0 <acquire>
80103d4f:	90                   	nop
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103d50:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103d53:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
80103d5a:	e8 81 fd ff ff       	call   80103ae0 <sched>

  // Tidy up.
  p->chan = 0;
80103d5f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103d66:	83 c4 1c             	add    $0x1c,%esp
80103d69:	5b                   	pop    %ebx
80103d6a:	5e                   	pop    %esi
80103d6b:	5f                   	pop    %edi
80103d6c:	5d                   	pop    %ebp
80103d6d:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103d6e:	c7 04 24 4f 73 10 80 	movl   $0x8010734f,(%esp)
80103d75:	e8 e6 c5 ff ff       	call   80100360 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103d7a:	c7 04 24 49 73 10 80 	movl   $0x80107349,(%esp)
80103d81:	e8 da c5 ff ff       	call   80100360 <panic>
80103d86:	8d 76 00             	lea    0x0(%esi),%esi
80103d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d90 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	56                   	push   %esi
80103d94:	53                   	push   %ebx
80103d95:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103d98:	e8 e3 f9 ff ff       	call   80103780 <myproc>
  
  acquire(&ptable.lock);
80103d9d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103da4:	89 c6                	mov    %eax,%esi
  
  acquire(&ptable.lock);
80103da6:	e8 15 05 00 00       	call   801042c0 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103dab:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dad:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103db2:	eb 0f                	jmp    80103dc3 <wait+0x33>
80103db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103db8:	83 c3 7c             	add    $0x7c,%ebx
80103dbb:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103dc1:	74 1d                	je     80103de0 <wait+0x50>
      if(p->parent != curproc)
80103dc3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103dc6:	75 f0                	jne    80103db8 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103dc8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103dcc:	74 2f                	je     80103dfd <wait+0x6d>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dce:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103dd1:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dd6:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103ddc:	75 e5                	jne    80103dc3 <wait+0x33>
80103dde:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103de0:	85 c0                	test   %eax,%eax
80103de2:	74 6e                	je     80103e52 <wait+0xc2>
80103de4:	8b 46 24             	mov    0x24(%esi),%eax
80103de7:	85 c0                	test   %eax,%eax
80103de9:	75 67                	jne    80103e52 <wait+0xc2>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103deb:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103df2:	80 
80103df3:	89 34 24             	mov    %esi,(%esp)
80103df6:	e8 e5 fe ff ff       	call   80103ce0 <sleep>
  }
80103dfb:	eb ae                	jmp    80103dab <wait+0x1b>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103dfd:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103e00:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103e03:	89 04 24             	mov    %eax,(%esp)
80103e06:	e8 d5 e5 ff ff       	call   801023e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103e0b:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103e0e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103e15:	89 04 24             	mov    %eax,(%esp)
80103e18:	e8 23 2c 00 00       	call   80106a40 <freevm>
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
80103e1d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103e24:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103e2b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103e32:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103e36:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103e3d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103e44:	e8 e7 04 00 00       	call   80104330 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e49:	83 c4 10             	add    $0x10,%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103e4c:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e4e:	5b                   	pop    %ebx
80103e4f:	5e                   	pop    %esi
80103e50:	5d                   	pop    %ebp
80103e51:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103e52:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e59:	e8 d2 04 00 00       	call   80104330 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e5e:	83 c4 10             	add    $0x10,%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80103e61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103e66:	5b                   	pop    %ebx
80103e67:	5e                   	pop    %esi
80103e68:	5d                   	pop    %ebp
80103e69:	c3                   	ret    
80103e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e70 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	53                   	push   %ebx
80103e74:	83 ec 14             	sub    $0x14,%esp
80103e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103e7a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e81:	e8 3a 04 00 00       	call   801042c0 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e86:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e8b:	eb 0d                	jmp    80103e9a <wakeup+0x2a>
80103e8d:	8d 76 00             	lea    0x0(%esi),%esi
80103e90:	83 c0 7c             	add    $0x7c,%eax
80103e93:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103e98:	74 1e                	je     80103eb8 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103e9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e9e:	75 f0                	jne    80103e90 <wakeup+0x20>
80103ea0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103ea3:	75 eb                	jne    80103e90 <wakeup+0x20>
      p->state = RUNNABLE;
80103ea5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eac:	83 c0 7c             	add    $0x7c,%eax
80103eaf:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103eb4:	75 e4                	jne    80103e9a <wakeup+0x2a>
80103eb6:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103eb8:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103ebf:	83 c4 14             	add    $0x14,%esp
80103ec2:	5b                   	pop    %ebx
80103ec3:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103ec4:	e9 67 04 00 00       	jmp    80104330 <release>
80103ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ed0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103ed0:	55                   	push   %ebp
80103ed1:	89 e5                	mov    %esp,%ebp
80103ed3:	53                   	push   %ebx
80103ed4:	83 ec 14             	sub    $0x14,%esp
80103ed7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103eda:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ee1:	e8 da 03 00 00       	call   801042c0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ee6:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103eeb:	eb 0d                	jmp    80103efa <kill+0x2a>
80103eed:	8d 76 00             	lea    0x0(%esi),%esi
80103ef0:	83 c0 7c             	add    $0x7c,%eax
80103ef3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103ef8:	74 36                	je     80103f30 <kill+0x60>
    if(p->pid == pid){
80103efa:	39 58 10             	cmp    %ebx,0x10(%eax)
80103efd:	75 f1                	jne    80103ef0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103eff:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80103f03:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f0a:	74 14                	je     80103f20 <kill+0x50>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103f0c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f13:	e8 18 04 00 00       	call   80104330 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103f18:	83 c4 14             	add    $0x14,%esp
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
80103f1b:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103f1d:	5b                   	pop    %ebx
80103f1e:	5d                   	pop    %ebp
80103f1f:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103f20:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f27:	eb e3                	jmp    80103f0c <kill+0x3c>
80103f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103f30:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f37:	e8 f4 03 00 00       	call   80104330 <release>
  return -1;
}
80103f3c:	83 c4 14             	add    $0x14,%esp
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
80103f3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103f44:	5b                   	pop    %ebx
80103f45:	5d                   	pop    %ebp
80103f46:	c3                   	ret    
80103f47:	89 f6                	mov    %esi,%esi
80103f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f50 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	57                   	push   %edi
80103f54:	56                   	push   %esi
80103f55:	53                   	push   %ebx
80103f56:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80103f5b:	83 ec 4c             	sub    $0x4c,%esp
80103f5e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103f61:	eb 20                	jmp    80103f83 <procdump+0x33>
80103f63:	90                   	nop
80103f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103f68:	c7 04 24 d7 76 10 80 	movl   $0x801076d7,(%esp)
80103f6f:	e8 ac c7 ff ff       	call   80100720 <cprintf>
80103f74:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f77:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80103f7d:	0f 84 8d 00 00 00    	je     80104010 <procdump+0xc0>
    if(p->state == UNUSED)
80103f83:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103f86:	85 c0                	test   %eax,%eax
80103f88:	74 ea                	je     80103f74 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103f8a:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80103f8d:	ba 60 73 10 80       	mov    $0x80107360,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103f92:	77 11                	ja     80103fa5 <procdump+0x55>
80103f94:	8b 14 85 c0 73 10 80 	mov    -0x7fef8c40(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
80103f9b:	b8 60 73 10 80       	mov    $0x80107360,%eax
80103fa0:	85 d2                	test   %edx,%edx
80103fa2:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80103fa5:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103fa8:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103fac:	89 54 24 08          	mov    %edx,0x8(%esp)
80103fb0:	c7 04 24 64 73 10 80 	movl   $0x80107364,(%esp)
80103fb7:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fbb:	e8 60 c7 ff ff       	call   80100720 <cprintf>
    if(p->state == SLEEPING){
80103fc0:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103fc4:	75 a2                	jne    80103f68 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103fc6:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103fc9:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fcd:	8b 43 b0             	mov    -0x50(%ebx),%eax
80103fd0:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103fd3:	8b 40 0c             	mov    0xc(%eax),%eax
80103fd6:	83 c0 08             	add    $0x8,%eax
80103fd9:	89 04 24             	mov    %eax,(%esp)
80103fdc:	e8 8f 01 00 00       	call   80104170 <getcallerpcs>
80103fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80103fe8:	8b 17                	mov    (%edi),%edx
80103fea:	85 d2                	test   %edx,%edx
80103fec:	0f 84 76 ff ff ff    	je     80103f68 <procdump+0x18>
        cprintf(" %p", pc[i]);
80103ff2:	89 54 24 04          	mov    %edx,0x4(%esp)
80103ff6:	83 c7 04             	add    $0x4,%edi
80103ff9:	c7 04 24 a1 6d 10 80 	movl   $0x80106da1,(%esp)
80104000:	e8 1b c7 ff ff       	call   80100720 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104005:	39 f7                	cmp    %esi,%edi
80104007:	75 df                	jne    80103fe8 <procdump+0x98>
80104009:	e9 5a ff ff ff       	jmp    80103f68 <procdump+0x18>
8010400e:	66 90                	xchg   %ax,%ax
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104010:	83 c4 4c             	add    $0x4c,%esp
80104013:	5b                   	pop    %ebx
80104014:	5e                   	pop    %esi
80104015:	5f                   	pop    %edi
80104016:	5d                   	pop    %ebp
80104017:	c3                   	ret    
80104018:	66 90                	xchg   %ax,%ax
8010401a:	66 90                	xchg   %ax,%ax
8010401c:	66 90                	xchg   %ax,%ax
8010401e:	66 90                	xchg   %ax,%ax

80104020 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	53                   	push   %ebx
80104024:	83 ec 14             	sub    $0x14,%esp
80104027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010402a:	c7 44 24 04 d8 73 10 	movl   $0x801073d8,0x4(%esp)
80104031:	80 
80104032:	8d 43 04             	lea    0x4(%ebx),%eax
80104035:	89 04 24             	mov    %eax,(%esp)
80104038:	e8 13 01 00 00       	call   80104150 <initlock>
  lk->name = name;
8010403d:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104040:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104046:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010404d:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80104050:	83 c4 14             	add    $0x14,%esp
80104053:	5b                   	pop    %ebx
80104054:	5d                   	pop    %ebp
80104055:	c3                   	ret    
80104056:	8d 76 00             	lea    0x0(%esi),%esi
80104059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104060 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	56                   	push   %esi
80104064:	53                   	push   %ebx
80104065:	83 ec 10             	sub    $0x10,%esp
80104068:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010406b:	8d 73 04             	lea    0x4(%ebx),%esi
8010406e:	89 34 24             	mov    %esi,(%esp)
80104071:	e8 4a 02 00 00       	call   801042c0 <acquire>
  while (lk->locked) {
80104076:	8b 13                	mov    (%ebx),%edx
80104078:	85 d2                	test   %edx,%edx
8010407a:	74 16                	je     80104092 <acquiresleep+0x32>
8010407c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104080:	89 74 24 04          	mov    %esi,0x4(%esp)
80104084:	89 1c 24             	mov    %ebx,(%esp)
80104087:	e8 54 fc ff ff       	call   80103ce0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010408c:	8b 03                	mov    (%ebx),%eax
8010408e:	85 c0                	test   %eax,%eax
80104090:	75 ee                	jne    80104080 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104092:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104098:	e8 e3 f6 ff ff       	call   80103780 <myproc>
8010409d:	8b 40 10             	mov    0x10(%eax),%eax
801040a0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801040a3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801040a6:	83 c4 10             	add    $0x10,%esp
801040a9:	5b                   	pop    %ebx
801040aa:	5e                   	pop    %esi
801040ab:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
801040ac:	e9 7f 02 00 00       	jmp    80104330 <release>
801040b1:	eb 0d                	jmp    801040c0 <releasesleep>
801040b3:	90                   	nop
801040b4:	90                   	nop
801040b5:	90                   	nop
801040b6:	90                   	nop
801040b7:	90                   	nop
801040b8:	90                   	nop
801040b9:	90                   	nop
801040ba:	90                   	nop
801040bb:	90                   	nop
801040bc:	90                   	nop
801040bd:	90                   	nop
801040be:	90                   	nop
801040bf:	90                   	nop

801040c0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	56                   	push   %esi
801040c4:	53                   	push   %ebx
801040c5:	83 ec 10             	sub    $0x10,%esp
801040c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801040cb:	8d 73 04             	lea    0x4(%ebx),%esi
801040ce:	89 34 24             	mov    %esi,(%esp)
801040d1:	e8 ea 01 00 00       	call   801042c0 <acquire>
  lk->locked = 0;
801040d6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801040dc:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801040e3:	89 1c 24             	mov    %ebx,(%esp)
801040e6:	e8 85 fd ff ff       	call   80103e70 <wakeup>
  release(&lk->lk);
801040eb:	89 75 08             	mov    %esi,0x8(%ebp)
}
801040ee:	83 c4 10             	add    $0x10,%esp
801040f1:	5b                   	pop    %ebx
801040f2:	5e                   	pop    %esi
801040f3:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801040f4:	e9 37 02 00 00       	jmp    80104330 <release>
801040f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104100 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	57                   	push   %edi
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
80104104:	31 ff                	xor    %edi,%edi
  release(&lk->lk);
}

int
holdingsleep(struct sleeplock *lk)
{
80104106:	56                   	push   %esi
80104107:	53                   	push   %ebx
80104108:	83 ec 1c             	sub    $0x1c,%esp
8010410b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010410e:	8d 73 04             	lea    0x4(%ebx),%esi
80104111:	89 34 24             	mov    %esi,(%esp)
80104114:	e8 a7 01 00 00       	call   801042c0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104119:	8b 03                	mov    (%ebx),%eax
8010411b:	85 c0                	test   %eax,%eax
8010411d:	74 13                	je     80104132 <holdingsleep+0x32>
8010411f:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104122:	e8 59 f6 ff ff       	call   80103780 <myproc>
80104127:	3b 58 10             	cmp    0x10(%eax),%ebx
8010412a:	0f 94 c0             	sete   %al
8010412d:	0f b6 c0             	movzbl %al,%eax
80104130:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104132:	89 34 24             	mov    %esi,(%esp)
80104135:	e8 f6 01 00 00       	call   80104330 <release>
  return r;
}
8010413a:	83 c4 1c             	add    $0x1c,%esp
8010413d:	89 f8                	mov    %edi,%eax
8010413f:	5b                   	pop    %ebx
80104140:	5e                   	pop    %esi
80104141:	5f                   	pop    %edi
80104142:	5d                   	pop    %ebp
80104143:	c3                   	ret    
80104144:	66 90                	xchg   %ax,%ax
80104146:	66 90                	xchg   %ax,%ax
80104148:	66 90                	xchg   %ax,%ax
8010414a:	66 90                	xchg   %ax,%ax
8010414c:	66 90                	xchg   %ax,%ax
8010414e:	66 90                	xchg   %ax,%ax

80104150 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104156:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104159:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010415f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104162:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104169:	5d                   	pop    %ebp
8010416a:	c3                   	ret    
8010416b:	90                   	nop
8010416c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104170 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104173:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104176:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104179:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010417a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010417d:	31 c0                	xor    %eax,%eax
8010417f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104180:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104186:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010418c:	77 1a                	ja     801041a8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010418e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104191:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104194:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104197:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104199:	83 f8 0a             	cmp    $0xa,%eax
8010419c:	75 e2                	jne    80104180 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010419e:	5b                   	pop    %ebx
8010419f:	5d                   	pop    %ebp
801041a0:	c3                   	ret    
801041a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801041a8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801041af:	83 c0 01             	add    $0x1,%eax
801041b2:	83 f8 0a             	cmp    $0xa,%eax
801041b5:	74 e7                	je     8010419e <getcallerpcs+0x2e>
    pcs[i] = 0;
801041b7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801041be:	83 c0 01             	add    $0x1,%eax
801041c1:	83 f8 0a             	cmp    $0xa,%eax
801041c4:	75 e2                	jne    801041a8 <getcallerpcs+0x38>
801041c6:	eb d6                	jmp    8010419e <getcallerpcs+0x2e>
801041c8:	90                   	nop
801041c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	53                   	push   %ebx
801041d4:	83 ec 04             	sub    $0x4,%esp
801041d7:	9c                   	pushf  
801041d8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801041d9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801041da:	e8 01 f5 ff ff       	call   801036e0 <mycpu>
801041df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801041e5:	85 c0                	test   %eax,%eax
801041e7:	75 11                	jne    801041fa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801041e9:	e8 f2 f4 ff ff       	call   801036e0 <mycpu>
801041ee:	81 e3 00 02 00 00    	and    $0x200,%ebx
801041f4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801041fa:	e8 e1 f4 ff ff       	call   801036e0 <mycpu>
801041ff:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104206:	83 c4 04             	add    $0x4,%esp
80104209:	5b                   	pop    %ebx
8010420a:	5d                   	pop    %ebp
8010420b:	c3                   	ret    
8010420c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104210 <popcli>:

void
popcli(void)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104216:	9c                   	pushf  
80104217:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104218:	f6 c4 02             	test   $0x2,%ah
8010421b:	75 49                	jne    80104266 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010421d:	e8 be f4 ff ff       	call   801036e0 <mycpu>
80104222:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104228:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010422b:	85 d2                	test   %edx,%edx
8010422d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104233:	78 25                	js     8010425a <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104235:	e8 a6 f4 ff ff       	call   801036e0 <mycpu>
8010423a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104240:	85 d2                	test   %edx,%edx
80104242:	74 04                	je     80104248 <popcli+0x38>
    sti();
}
80104244:	c9                   	leave  
80104245:	c3                   	ret    
80104246:	66 90                	xchg   %ax,%ax
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104248:	e8 93 f4 ff ff       	call   801036e0 <mycpu>
8010424d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104253:	85 c0                	test   %eax,%eax
80104255:	74 ed                	je     80104244 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104257:	fb                   	sti    
    sti();
}
80104258:	c9                   	leave  
80104259:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
8010425a:	c7 04 24 fa 73 10 80 	movl   $0x801073fa,(%esp)
80104261:	e8 fa c0 ff ff       	call   80100360 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104266:	c7 04 24 e3 73 10 80 	movl   $0x801073e3,(%esp)
8010426d:	e8 ee c0 ff ff       	call   80100360 <panic>
80104272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104280 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	56                   	push   %esi
  int r;
  pushcli();
  r = lock->locked && lock->cpu == mycpu();
80104284:	31 f6                	xor    %esi,%esi
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104286:	53                   	push   %ebx
80104287:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  pushcli();
8010428a:	e8 41 ff ff ff       	call   801041d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010428f:	8b 03                	mov    (%ebx),%eax
80104291:	85 c0                	test   %eax,%eax
80104293:	74 12                	je     801042a7 <holding+0x27>
80104295:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104298:	e8 43 f4 ff ff       	call   801036e0 <mycpu>
8010429d:	39 c3                	cmp    %eax,%ebx
8010429f:	0f 94 c0             	sete   %al
801042a2:	0f b6 c0             	movzbl %al,%eax
801042a5:	89 c6                	mov    %eax,%esi
  popcli();
801042a7:	e8 64 ff ff ff       	call   80104210 <popcli>
  return r;
}
801042ac:	89 f0                	mov    %esi,%eax
801042ae:	5b                   	pop    %ebx
801042af:	5e                   	pop    %esi
801042b0:	5d                   	pop    %ebp
801042b1:	c3                   	ret    
801042b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042c0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	53                   	push   %ebx
801042c4:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801042c7:	e8 04 ff ff ff       	call   801041d0 <pushcli>
  if(holding(lk))
801042cc:	8b 45 08             	mov    0x8(%ebp),%eax
801042cf:	89 04 24             	mov    %eax,(%esp)
801042d2:	e8 a9 ff ff ff       	call   80104280 <holding>
801042d7:	85 c0                	test   %eax,%eax
801042d9:	75 3c                	jne    80104317 <acquire+0x57>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801042db:	b9 01 00 00 00       	mov    $0x1,%ecx
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801042e0:	8b 55 08             	mov    0x8(%ebp),%edx
801042e3:	89 c8                	mov    %ecx,%eax
801042e5:	f0 87 02             	lock xchg %eax,(%edx)
801042e8:	85 c0                	test   %eax,%eax
801042ea:	75 f4                	jne    801042e0 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801042ec:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801042f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042f4:	e8 e7 f3 ff ff       	call   801036e0 <mycpu>
801042f9:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
801042fc:	8b 45 08             	mov    0x8(%ebp),%eax
801042ff:	83 c0 0c             	add    $0xc,%eax
80104302:	89 44 24 04          	mov    %eax,0x4(%esp)
80104306:	8d 45 08             	lea    0x8(%ebp),%eax
80104309:	89 04 24             	mov    %eax,(%esp)
8010430c:	e8 5f fe ff ff       	call   80104170 <getcallerpcs>
}
80104311:	83 c4 14             	add    $0x14,%esp
80104314:	5b                   	pop    %ebx
80104315:	5d                   	pop    %ebp
80104316:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104317:	c7 04 24 01 74 10 80 	movl   $0x80107401,(%esp)
8010431e:	e8 3d c0 ff ff       	call   80100360 <panic>
80104323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 14             	sub    $0x14,%esp
80104337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010433a:	89 1c 24             	mov    %ebx,(%esp)
8010433d:	e8 3e ff ff ff       	call   80104280 <holding>
80104342:	85 c0                	test   %eax,%eax
80104344:	74 23                	je     80104369 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80104346:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010434d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104354:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104359:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
8010435f:	83 c4 14             	add    $0x14,%esp
80104362:	5b                   	pop    %ebx
80104363:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104364:	e9 a7 fe ff ff       	jmp    80104210 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104369:	c7 04 24 09 74 10 80 	movl   $0x80107409,(%esp)
80104370:	e8 eb bf ff ff       	call   80100360 <panic>
80104375:	66 90                	xchg   %ax,%ax
80104377:	66 90                	xchg   %ax,%ax
80104379:	66 90                	xchg   %ax,%ax
8010437b:	66 90                	xchg   %ax,%ax
8010437d:	66 90                	xchg   %ax,%ax
8010437f:	90                   	nop

80104380 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	8b 55 08             	mov    0x8(%ebp),%edx
80104386:	57                   	push   %edi
80104387:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010438a:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
8010438b:	f6 c2 03             	test   $0x3,%dl
8010438e:	75 05                	jne    80104395 <memset+0x15>
80104390:	f6 c1 03             	test   $0x3,%cl
80104393:	74 13                	je     801043a8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104395:	89 d7                	mov    %edx,%edi
80104397:	8b 45 0c             	mov    0xc(%ebp),%eax
8010439a:	fc                   	cld    
8010439b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010439d:	5b                   	pop    %ebx
8010439e:	89 d0                	mov    %edx,%eax
801043a0:	5f                   	pop    %edi
801043a1:	5d                   	pop    %ebp
801043a2:	c3                   	ret    
801043a3:	90                   	nop
801043a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801043a8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801043ac:	c1 e9 02             	shr    $0x2,%ecx
801043af:	89 f8                	mov    %edi,%eax
801043b1:	89 fb                	mov    %edi,%ebx
801043b3:	c1 e0 18             	shl    $0x18,%eax
801043b6:	c1 e3 10             	shl    $0x10,%ebx
801043b9:	09 d8                	or     %ebx,%eax
801043bb:	09 f8                	or     %edi,%eax
801043bd:	c1 e7 08             	shl    $0x8,%edi
801043c0:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801043c2:	89 d7                	mov    %edx,%edi
801043c4:	fc                   	cld    
801043c5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801043c7:	5b                   	pop    %ebx
801043c8:	89 d0                	mov    %edx,%eax
801043ca:	5f                   	pop    %edi
801043cb:	5d                   	pop    %ebp
801043cc:	c3                   	ret    
801043cd:	8d 76 00             	lea    0x0(%esi),%esi

801043d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	8b 45 10             	mov    0x10(%ebp),%eax
801043d6:	57                   	push   %edi
801043d7:	56                   	push   %esi
801043d8:	8b 75 0c             	mov    0xc(%ebp),%esi
801043db:	53                   	push   %ebx
801043dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801043df:	85 c0                	test   %eax,%eax
801043e1:	8d 78 ff             	lea    -0x1(%eax),%edi
801043e4:	74 26                	je     8010440c <memcmp+0x3c>
    if(*s1 != *s2)
801043e6:	0f b6 03             	movzbl (%ebx),%eax
801043e9:	31 d2                	xor    %edx,%edx
801043eb:	0f b6 0e             	movzbl (%esi),%ecx
801043ee:	38 c8                	cmp    %cl,%al
801043f0:	74 16                	je     80104408 <memcmp+0x38>
801043f2:	eb 24                	jmp    80104418 <memcmp+0x48>
801043f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043f8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
801043fd:	83 c2 01             	add    $0x1,%edx
80104400:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104404:	38 c8                	cmp    %cl,%al
80104406:	75 10                	jne    80104418 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104408:	39 fa                	cmp    %edi,%edx
8010440a:	75 ec                	jne    801043f8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010440c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010440d:	31 c0                	xor    %eax,%eax
}
8010440f:	5e                   	pop    %esi
80104410:	5f                   	pop    %edi
80104411:	5d                   	pop    %ebp
80104412:	c3                   	ret    
80104413:	90                   	nop
80104414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104418:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104419:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010441b:	5e                   	pop    %esi
8010441c:	5f                   	pop    %edi
8010441d:	5d                   	pop    %ebp
8010441e:	c3                   	ret    
8010441f:	90                   	nop

80104420 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	57                   	push   %edi
80104424:	8b 45 08             	mov    0x8(%ebp),%eax
80104427:	56                   	push   %esi
80104428:	8b 75 0c             	mov    0xc(%ebp),%esi
8010442b:	53                   	push   %ebx
8010442c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010442f:	39 c6                	cmp    %eax,%esi
80104431:	73 35                	jae    80104468 <memmove+0x48>
80104433:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104436:	39 c8                	cmp    %ecx,%eax
80104438:	73 2e                	jae    80104468 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
8010443a:	85 db                	test   %ebx,%ebx

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
8010443c:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
    while(n-- > 0)
8010443f:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104442:	74 1b                	je     8010445f <memmove+0x3f>
80104444:	f7 db                	neg    %ebx
80104446:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80104449:	01 fb                	add    %edi,%ebx
8010444b:	90                   	nop
8010444c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104450:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104454:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104457:	83 ea 01             	sub    $0x1,%edx
8010445a:	83 fa ff             	cmp    $0xffffffff,%edx
8010445d:	75 f1                	jne    80104450 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010445f:	5b                   	pop    %ebx
80104460:	5e                   	pop    %esi
80104461:	5f                   	pop    %edi
80104462:	5d                   	pop    %ebp
80104463:	c3                   	ret    
80104464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104468:	31 d2                	xor    %edx,%edx
8010446a:	85 db                	test   %ebx,%ebx
8010446c:	74 f1                	je     8010445f <memmove+0x3f>
8010446e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104470:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104474:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104477:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010447a:	39 da                	cmp    %ebx,%edx
8010447c:	75 f2                	jne    80104470 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010447e:	5b                   	pop    %ebx
8010447f:	5e                   	pop    %esi
80104480:	5f                   	pop    %edi
80104481:	5d                   	pop    %ebp
80104482:	c3                   	ret    
80104483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104490 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104493:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104494:	e9 87 ff ff ff       	jmp    80104420 <memmove>
80104499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044a0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	8b 75 10             	mov    0x10(%ebp),%esi
801044a7:	53                   	push   %ebx
801044a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
801044ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
801044ae:	85 f6                	test   %esi,%esi
801044b0:	74 30                	je     801044e2 <strncmp+0x42>
801044b2:	0f b6 01             	movzbl (%ecx),%eax
801044b5:	84 c0                	test   %al,%al
801044b7:	74 2f                	je     801044e8 <strncmp+0x48>
801044b9:	0f b6 13             	movzbl (%ebx),%edx
801044bc:	38 d0                	cmp    %dl,%al
801044be:	75 46                	jne    80104506 <strncmp+0x66>
801044c0:	8d 51 01             	lea    0x1(%ecx),%edx
801044c3:	01 ce                	add    %ecx,%esi
801044c5:	eb 14                	jmp    801044db <strncmp+0x3b>
801044c7:	90                   	nop
801044c8:	0f b6 02             	movzbl (%edx),%eax
801044cb:	84 c0                	test   %al,%al
801044cd:	74 31                	je     80104500 <strncmp+0x60>
801044cf:	0f b6 19             	movzbl (%ecx),%ebx
801044d2:	83 c2 01             	add    $0x1,%edx
801044d5:	38 d8                	cmp    %bl,%al
801044d7:	75 17                	jne    801044f0 <strncmp+0x50>
    n--, p++, q++;
801044d9:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801044db:	39 f2                	cmp    %esi,%edx
    n--, p++, q++;
801044dd:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801044e0:	75 e6                	jne    801044c8 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801044e2:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
801044e3:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
801044e5:	5e                   	pop    %esi
801044e6:	5d                   	pop    %ebp
801044e7:	c3                   	ret    
801044e8:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801044eb:	31 c0                	xor    %eax,%eax
801044ed:	8d 76 00             	lea    0x0(%esi),%esi
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801044f0:	0f b6 d3             	movzbl %bl,%edx
801044f3:	29 d0                	sub    %edx,%eax
}
801044f5:	5b                   	pop    %ebx
801044f6:	5e                   	pop    %esi
801044f7:	5d                   	pop    %ebp
801044f8:	c3                   	ret    
801044f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104500:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
80104504:	eb ea                	jmp    801044f0 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104506:	89 d3                	mov    %edx,%ebx
80104508:	eb e6                	jmp    801044f0 <strncmp+0x50>
8010450a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104510 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	8b 45 08             	mov    0x8(%ebp),%eax
80104516:	56                   	push   %esi
80104517:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010451a:	53                   	push   %ebx
8010451b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010451e:	89 c2                	mov    %eax,%edx
80104520:	eb 19                	jmp    8010453b <strncpy+0x2b>
80104522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104528:	83 c3 01             	add    $0x1,%ebx
8010452b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010452f:	83 c2 01             	add    $0x1,%edx
80104532:	84 c9                	test   %cl,%cl
80104534:	88 4a ff             	mov    %cl,-0x1(%edx)
80104537:	74 09                	je     80104542 <strncpy+0x32>
80104539:	89 f1                	mov    %esi,%ecx
8010453b:	85 c9                	test   %ecx,%ecx
8010453d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104540:	7f e6                	jg     80104528 <strncpy+0x18>
    ;
  while(n-- > 0)
80104542:	31 c9                	xor    %ecx,%ecx
80104544:	85 f6                	test   %esi,%esi
80104546:	7e 0f                	jle    80104557 <strncpy+0x47>
    *s++ = 0;
80104548:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
8010454c:	89 f3                	mov    %esi,%ebx
8010454e:	83 c1 01             	add    $0x1,%ecx
80104551:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104553:	85 db                	test   %ebx,%ebx
80104555:	7f f1                	jg     80104548 <strncpy+0x38>
    *s++ = 0;
  return os;
}
80104557:	5b                   	pop    %ebx
80104558:	5e                   	pop    %esi
80104559:	5d                   	pop    %ebp
8010455a:	c3                   	ret    
8010455b:	90                   	nop
8010455c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104560 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104566:	56                   	push   %esi
80104567:	8b 45 08             	mov    0x8(%ebp),%eax
8010456a:	53                   	push   %ebx
8010456b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010456e:	85 c9                	test   %ecx,%ecx
80104570:	7e 26                	jle    80104598 <safestrcpy+0x38>
80104572:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104576:	89 c1                	mov    %eax,%ecx
80104578:	eb 17                	jmp    80104591 <safestrcpy+0x31>
8010457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104580:	83 c2 01             	add    $0x1,%edx
80104583:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104587:	83 c1 01             	add    $0x1,%ecx
8010458a:	84 db                	test   %bl,%bl
8010458c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010458f:	74 04                	je     80104595 <safestrcpy+0x35>
80104591:	39 f2                	cmp    %esi,%edx
80104593:	75 eb                	jne    80104580 <safestrcpy+0x20>
    ;
  *s = 0;
80104595:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104598:	5b                   	pop    %ebx
80104599:	5e                   	pop    %esi
8010459a:	5d                   	pop    %ebp
8010459b:	c3                   	ret    
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045a0 <strlen>:

int
strlen(const char *s)
{
801045a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801045a1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801045a3:	89 e5                	mov    %esp,%ebp
801045a5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801045a8:	80 3a 00             	cmpb   $0x0,(%edx)
801045ab:	74 0c                	je     801045b9 <strlen+0x19>
801045ad:	8d 76 00             	lea    0x0(%esi),%esi
801045b0:	83 c0 01             	add    $0x1,%eax
801045b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801045b7:	75 f7                	jne    801045b0 <strlen+0x10>
    ;
  return n;
}
801045b9:	5d                   	pop    %ebp
801045ba:	c3                   	ret    

801045bb <swtch>:
801045bb:	8b 44 24 04          	mov    0x4(%esp),%eax
801045bf:	8b 54 24 08          	mov    0x8(%esp),%edx
801045c3:	55                   	push   %ebp
801045c4:	53                   	push   %ebx
801045c5:	56                   	push   %esi
801045c6:	57                   	push   %edi
801045c7:	89 20                	mov    %esp,(%eax)
801045c9:	89 d4                	mov    %edx,%esp
801045cb:	5f                   	pop    %edi
801045cc:	5e                   	pop    %esi
801045cd:	5b                   	pop    %ebx
801045ce:	5d                   	pop    %ebp
801045cf:	c3                   	ret    

801045d0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	53                   	push   %ebx
801045d4:	83 ec 04             	sub    $0x4,%esp
801045d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801045da:	e8 a1 f1 ff ff       	call   80103780 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801045df:	8b 00                	mov    (%eax),%eax
801045e1:	39 d8                	cmp    %ebx,%eax
801045e3:	76 1b                	jbe    80104600 <fetchint+0x30>
801045e5:	8d 53 04             	lea    0x4(%ebx),%edx
801045e8:	39 d0                	cmp    %edx,%eax
801045ea:	72 14                	jb     80104600 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801045ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801045ef:	8b 13                	mov    (%ebx),%edx
801045f1:	89 10                	mov    %edx,(%eax)
  return 0;
801045f3:	31 c0                	xor    %eax,%eax
}
801045f5:	83 c4 04             	add    $0x4,%esp
801045f8:	5b                   	pop    %ebx
801045f9:	5d                   	pop    %ebp
801045fa:	c3                   	ret    
801045fb:	90                   	nop
801045fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104605:	eb ee                	jmp    801045f5 <fetchint+0x25>
80104607:	89 f6                	mov    %esi,%esi
80104609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104610 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
80104614:	83 ec 04             	sub    $0x4,%esp
80104617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010461a:	e8 61 f1 ff ff       	call   80103780 <myproc>

  if(addr >= curproc->sz)
8010461f:	39 18                	cmp    %ebx,(%eax)
80104621:	76 26                	jbe    80104649 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
80104623:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104626:	89 da                	mov    %ebx,%edx
80104628:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010462a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010462c:	39 c3                	cmp    %eax,%ebx
8010462e:	73 19                	jae    80104649 <fetchstr+0x39>
    if(*s == 0)
80104630:	80 3b 00             	cmpb   $0x0,(%ebx)
80104633:	75 0d                	jne    80104642 <fetchstr+0x32>
80104635:	eb 21                	jmp    80104658 <fetchstr+0x48>
80104637:	90                   	nop
80104638:	80 3a 00             	cmpb   $0x0,(%edx)
8010463b:	90                   	nop
8010463c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104640:	74 16                	je     80104658 <fetchstr+0x48>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104642:	83 c2 01             	add    $0x1,%edx
80104645:	39 d0                	cmp    %edx,%eax
80104647:	77 ef                	ja     80104638 <fetchstr+0x28>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104649:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010464c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104651:	5b                   	pop    %ebx
80104652:	5d                   	pop    %ebp
80104653:	c3                   	ret    
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104658:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
8010465b:	89 d0                	mov    %edx,%eax
8010465d:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
8010465f:	5b                   	pop    %ebx
80104660:	5d                   	pop    %ebp
80104661:	c3                   	ret    
80104662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104670 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	56                   	push   %esi
80104674:	8b 75 0c             	mov    0xc(%ebp),%esi
80104677:	53                   	push   %ebx
80104678:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010467b:	e8 00 f1 ff ff       	call   80103780 <myproc>
80104680:	89 75 0c             	mov    %esi,0xc(%ebp)
80104683:	8b 40 18             	mov    0x18(%eax),%eax
80104686:	8b 40 44             	mov    0x44(%eax),%eax
80104689:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
8010468d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80104690:	5b                   	pop    %ebx
80104691:	5e                   	pop    %esi
80104692:	5d                   	pop    %ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104693:	e9 38 ff ff ff       	jmp    801045d0 <fetchint>
80104698:	90                   	nop
80104699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046a0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	56                   	push   %esi
801046a4:	53                   	push   %ebx
801046a5:	83 ec 20             	sub    $0x20,%esp
801046a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801046ab:	e8 d0 f0 ff ff       	call   80103780 <myproc>
801046b0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801046b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801046b5:	89 44 24 04          	mov    %eax,0x4(%esp)
801046b9:	8b 45 08             	mov    0x8(%ebp),%eax
801046bc:	89 04 24             	mov    %eax,(%esp)
801046bf:	e8 ac ff ff ff       	call   80104670 <argint>
801046c4:	85 c0                	test   %eax,%eax
801046c6:	78 28                	js     801046f0 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801046c8:	85 db                	test   %ebx,%ebx
801046ca:	78 24                	js     801046f0 <argptr+0x50>
801046cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046cf:	8b 06                	mov    (%esi),%eax
801046d1:	39 c2                	cmp    %eax,%edx
801046d3:	73 1b                	jae    801046f0 <argptr+0x50>
801046d5:	01 d3                	add    %edx,%ebx
801046d7:	39 d8                	cmp    %ebx,%eax
801046d9:	72 15                	jb     801046f0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801046db:	8b 45 0c             	mov    0xc(%ebp),%eax
801046de:	89 10                	mov    %edx,(%eax)
  return 0;
}
801046e0:	83 c4 20             	add    $0x20,%esp
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
801046e3:	31 c0                	xor    %eax,%eax
}
801046e5:	5b                   	pop    %ebx
801046e6:	5e                   	pop    %esi
801046e7:	5d                   	pop    %ebp
801046e8:	c3                   	ret    
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046f0:	83 c4 20             	add    $0x20,%esp
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
801046f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}
801046f8:	5b                   	pop    %ebx
801046f9:	5e                   	pop    %esi
801046fa:	5d                   	pop    %ebp
801046fb:	c3                   	ret    
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104700 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104706:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104709:	89 44 24 04          	mov    %eax,0x4(%esp)
8010470d:	8b 45 08             	mov    0x8(%ebp),%eax
80104710:	89 04 24             	mov    %eax,(%esp)
80104713:	e8 58 ff ff ff       	call   80104670 <argint>
80104718:	85 c0                	test   %eax,%eax
8010471a:	78 14                	js     80104730 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010471c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010471f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104723:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104726:	89 04 24             	mov    %eax,(%esp)
80104729:	e8 e2 fe ff ff       	call   80104610 <fetchstr>
}
8010472e:	c9                   	leave  
8010472f:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104735:	c9                   	leave  
80104736:	c3                   	ret    
80104737:	89 f6                	mov    %esi,%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104748:	e8 33 f0 ff ff       	call   80103780 <myproc>

  num = curproc->tf->eax;
8010474d:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104750:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104752:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104755:	8d 50 ff             	lea    -0x1(%eax),%edx
80104758:	83 fa 14             	cmp    $0x14,%edx
8010475b:	77 1b                	ja     80104778 <syscall+0x38>
8010475d:	8b 14 85 40 74 10 80 	mov    -0x7fef8bc0(,%eax,4),%edx
80104764:	85 d2                	test   %edx,%edx
80104766:	74 10                	je     80104778 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104768:	ff d2                	call   *%edx
8010476a:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010476d:	83 c4 10             	add    $0x10,%esp
80104770:	5b                   	pop    %ebx
80104771:	5e                   	pop    %esi
80104772:	5d                   	pop    %ebp
80104773:	c3                   	ret    
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104778:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010477c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010477f:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104783:	8b 43 10             	mov    0x10(%ebx),%eax
80104786:	c7 04 24 11 74 10 80 	movl   $0x80107411,(%esp)
8010478d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104791:	e8 8a bf ff ff       	call   80100720 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104796:	8b 43 18             	mov    0x18(%ebx),%eax
80104799:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801047a0:	83 c4 10             	add    $0x10,%esp
801047a3:	5b                   	pop    %ebx
801047a4:	5e                   	pop    %esi
801047a5:	5d                   	pop    %ebp
801047a6:	c3                   	ret    
801047a7:	66 90                	xchg   %ax,%ax
801047a9:	66 90                	xchg   %ax,%ax
801047ab:	66 90                	xchg   %ax,%ax
801047ad:	66 90                	xchg   %ax,%ax
801047af:	90                   	nop

801047b0 <create>:
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	57                   	push   %edi
801047b4:	56                   	push   %esi
801047b5:	53                   	push   %ebx
801047b6:	8d 5d da             	lea    -0x26(%ebp),%ebx
801047b9:	83 ec 44             	sub    $0x44,%esp
801047bc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801047bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
801047c2:	53                   	push   %ebx
801047c3:	50                   	push   %eax
801047c4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801047c7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
801047ca:	e8 41 d8 ff ff       	call   80102010 <nameiparent>
801047cf:	83 c4 10             	add    $0x10,%esp
801047d2:	85 c0                	test   %eax,%eax
801047d4:	0f 84 f6 00 00 00    	je     801048d0 <create+0x120>
801047da:	83 ec 0c             	sub    $0xc,%esp
801047dd:	89 c6                	mov    %eax,%esi
801047df:	50                   	push   %eax
801047e0:	e8 bb cf ff ff       	call   801017a0 <ilock>
801047e5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801047e8:	83 c4 0c             	add    $0xc,%esp
801047eb:	50                   	push   %eax
801047ec:	53                   	push   %ebx
801047ed:	56                   	push   %esi
801047ee:	e8 bd d4 ff ff       	call   80101cb0 <dirlookup>
801047f3:	83 c4 10             	add    $0x10,%esp
801047f6:	85 c0                	test   %eax,%eax
801047f8:	89 c7                	mov    %eax,%edi
801047fa:	74 54                	je     80104850 <create+0xa0>
801047fc:	83 ec 0c             	sub    $0xc,%esp
801047ff:	56                   	push   %esi
80104800:	e8 fb d1 ff ff       	call   80101a00 <iunlockput>
80104805:	89 3c 24             	mov    %edi,(%esp)
80104808:	e8 93 cf ff ff       	call   801017a0 <ilock>
8010480d:	83 c4 10             	add    $0x10,%esp
80104810:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104815:	75 19                	jne    80104830 <create+0x80>
80104817:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
8010481c:	75 12                	jne    80104830 <create+0x80>
8010481e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104821:	89 f8                	mov    %edi,%eax
80104823:	5b                   	pop    %ebx
80104824:	5e                   	pop    %esi
80104825:	5f                   	pop    %edi
80104826:	5d                   	pop    %ebp
80104827:	c3                   	ret    
80104828:	90                   	nop
80104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104830:	83 ec 0c             	sub    $0xc,%esp
80104833:	57                   	push   %edi
80104834:	31 ff                	xor    %edi,%edi
80104836:	e8 c5 d1 ff ff       	call   80101a00 <iunlockput>
8010483b:	83 c4 10             	add    $0x10,%esp
8010483e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104841:	89 f8                	mov    %edi,%eax
80104843:	5b                   	pop    %ebx
80104844:	5e                   	pop    %esi
80104845:	5f                   	pop    %edi
80104846:	5d                   	pop    %ebp
80104847:	c3                   	ret    
80104848:	90                   	nop
80104849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104850:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104854:	83 ec 08             	sub    $0x8,%esp
80104857:	50                   	push   %eax
80104858:	ff 36                	pushl  (%esi)
8010485a:	e8 b1 cd ff ff       	call   80101610 <ialloc>
8010485f:	83 c4 10             	add    $0x10,%esp
80104862:	85 c0                	test   %eax,%eax
80104864:	89 c7                	mov    %eax,%edi
80104866:	0f 84 cc 00 00 00    	je     80104938 <create+0x188>
8010486c:	83 ec 0c             	sub    $0xc,%esp
8010486f:	50                   	push   %eax
80104870:	e8 2b cf ff ff       	call   801017a0 <ilock>
80104875:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104879:	66 89 47 52          	mov    %ax,0x52(%edi)
8010487d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104881:	66 89 47 54          	mov    %ax,0x54(%edi)
80104885:	b8 01 00 00 00       	mov    $0x1,%eax
8010488a:	66 89 47 56          	mov    %ax,0x56(%edi)
8010488e:	89 3c 24             	mov    %edi,(%esp)
80104891:	e8 4a ce ff ff       	call   801016e0 <iupdate>
80104896:	83 c4 10             	add    $0x10,%esp
80104899:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010489e:	74 40                	je     801048e0 <create+0x130>
801048a0:	83 ec 04             	sub    $0x4,%esp
801048a3:	ff 77 04             	pushl  0x4(%edi)
801048a6:	53                   	push   %ebx
801048a7:	56                   	push   %esi
801048a8:	e8 63 d6 ff ff       	call   80101f10 <dirlink>
801048ad:	83 c4 10             	add    $0x10,%esp
801048b0:	85 c0                	test   %eax,%eax
801048b2:	78 77                	js     8010492b <create+0x17b>
801048b4:	83 ec 0c             	sub    $0xc,%esp
801048b7:	56                   	push   %esi
801048b8:	e8 43 d1 ff ff       	call   80101a00 <iunlockput>
801048bd:	83 c4 10             	add    $0x10,%esp
801048c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048c3:	89 f8                	mov    %edi,%eax
801048c5:	5b                   	pop    %ebx
801048c6:	5e                   	pop    %esi
801048c7:	5f                   	pop    %edi
801048c8:	5d                   	pop    %ebp
801048c9:	c3                   	ret    
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048d0:	31 ff                	xor    %edi,%edi
801048d2:	e9 47 ff ff ff       	jmp    8010481e <create+0x6e>
801048d7:	89 f6                	mov    %esi,%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048e0:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
801048e5:	83 ec 0c             	sub    $0xc,%esp
801048e8:	56                   	push   %esi
801048e9:	e8 f2 cd ff ff       	call   801016e0 <iupdate>
801048ee:	83 c4 0c             	add    $0xc,%esp
801048f1:	ff 77 04             	pushl  0x4(%edi)
801048f4:	68 b4 74 10 80       	push   $0x801074b4
801048f9:	57                   	push   %edi
801048fa:	e8 11 d6 ff ff       	call   80101f10 <dirlink>
801048ff:	83 c4 10             	add    $0x10,%esp
80104902:	85 c0                	test   %eax,%eax
80104904:	78 18                	js     8010491e <create+0x16e>
80104906:	83 ec 04             	sub    $0x4,%esp
80104909:	ff 76 04             	pushl  0x4(%esi)
8010490c:	68 b3 74 10 80       	push   $0x801074b3
80104911:	57                   	push   %edi
80104912:	e8 f9 d5 ff ff       	call   80101f10 <dirlink>
80104917:	83 c4 10             	add    $0x10,%esp
8010491a:	85 c0                	test   %eax,%eax
8010491c:	79 82                	jns    801048a0 <create+0xf0>
8010491e:	83 ec 0c             	sub    $0xc,%esp
80104921:	68 a7 74 10 80       	push   $0x801074a7
80104926:	e8 35 ba ff ff       	call   80100360 <panic>
8010492b:	83 ec 0c             	sub    $0xc,%esp
8010492e:	68 b6 74 10 80       	push   $0x801074b6
80104933:	e8 28 ba ff ff       	call   80100360 <panic>
80104938:	83 ec 0c             	sub    $0xc,%esp
8010493b:	68 98 74 10 80       	push   $0x80107498
80104940:	e8 1b ba ff ff       	call   80100360 <panic>
80104945:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <argfd.constprop.0>:
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	53                   	push   %ebx
80104955:	89 c6                	mov    %eax,%esi
80104957:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010495a:	89 d3                	mov    %edx,%ebx
8010495c:	83 ec 18             	sub    $0x18,%esp
8010495f:	50                   	push   %eax
80104960:	6a 00                	push   $0x0
80104962:	e8 09 fd ff ff       	call   80104670 <argint>
80104967:	83 c4 10             	add    $0x10,%esp
8010496a:	85 c0                	test   %eax,%eax
8010496c:	78 32                	js     801049a0 <argfd.constprop.0+0x50>
8010496e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104972:	77 2c                	ja     801049a0 <argfd.constprop.0+0x50>
80104974:	e8 07 ee ff ff       	call   80103780 <myproc>
80104979:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010497c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104980:	85 c0                	test   %eax,%eax
80104982:	74 1c                	je     801049a0 <argfd.constprop.0+0x50>
80104984:	85 f6                	test   %esi,%esi
80104986:	74 02                	je     8010498a <argfd.constprop.0+0x3a>
80104988:	89 16                	mov    %edx,(%esi)
8010498a:	85 db                	test   %ebx,%ebx
8010498c:	74 22                	je     801049b0 <argfd.constprop.0+0x60>
8010498e:	89 03                	mov    %eax,(%ebx)
80104990:	31 c0                	xor    %eax,%eax
80104992:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104995:	5b                   	pop    %ebx
80104996:	5e                   	pop    %esi
80104997:	5d                   	pop    %ebp
80104998:	c3                   	ret    
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049a8:	5b                   	pop    %ebx
801049a9:	5e                   	pop    %esi
801049aa:	5d                   	pop    %ebp
801049ab:	c3                   	ret    
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049b0:	31 c0                	xor    %eax,%eax
801049b2:	eb de                	jmp    80104992 <argfd.constprop.0+0x42>
801049b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801049c0 <sys_dup>:
801049c0:	55                   	push   %ebp
801049c1:	31 c0                	xor    %eax,%eax
801049c3:	89 e5                	mov    %esp,%ebp
801049c5:	56                   	push   %esi
801049c6:	53                   	push   %ebx
801049c7:	8d 55 f4             	lea    -0xc(%ebp),%edx
801049ca:	83 ec 10             	sub    $0x10,%esp
801049cd:	e8 7e ff ff ff       	call   80104950 <argfd.constprop.0>
801049d2:	85 c0                	test   %eax,%eax
801049d4:	78 1a                	js     801049f0 <sys_dup+0x30>
801049d6:	31 db                	xor    %ebx,%ebx
801049d8:	8b 75 f4             	mov    -0xc(%ebp),%esi
801049db:	e8 a0 ed ff ff       	call   80103780 <myproc>
801049e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801049e4:	85 d2                	test   %edx,%edx
801049e6:	74 18                	je     80104a00 <sys_dup+0x40>
801049e8:	83 c3 01             	add    $0x1,%ebx
801049eb:	83 fb 10             	cmp    $0x10,%ebx
801049ee:	75 f0                	jne    801049e0 <sys_dup+0x20>
801049f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801049f8:	89 d8                	mov    %ebx,%eax
801049fa:	5b                   	pop    %ebx
801049fb:	5e                   	pop    %esi
801049fc:	5d                   	pop    %ebp
801049fd:	c3                   	ret    
801049fe:	66 90                	xchg   %ax,%ax
80104a00:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80104a04:	83 ec 0c             	sub    $0xc,%esp
80104a07:	ff 75 f4             	pushl  -0xc(%ebp)
80104a0a:	e8 b1 c4 ff ff       	call   80100ec0 <filedup>
80104a0f:	83 c4 10             	add    $0x10,%esp
80104a12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a15:	89 d8                	mov    %ebx,%eax
80104a17:	5b                   	pop    %ebx
80104a18:	5e                   	pop    %esi
80104a19:	5d                   	pop    %ebp
80104a1a:	c3                   	ret    
80104a1b:	90                   	nop
80104a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a20 <sys_read>:
80104a20:	55                   	push   %ebp
80104a21:	31 c0                	xor    %eax,%eax
80104a23:	89 e5                	mov    %esp,%ebp
80104a25:	83 ec 18             	sub    $0x18,%esp
80104a28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a2b:	e8 20 ff ff ff       	call   80104950 <argfd.constprop.0>
80104a30:	85 c0                	test   %eax,%eax
80104a32:	78 4c                	js     80104a80 <sys_read+0x60>
80104a34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a37:	83 ec 08             	sub    $0x8,%esp
80104a3a:	50                   	push   %eax
80104a3b:	6a 02                	push   $0x2
80104a3d:	e8 2e fc ff ff       	call   80104670 <argint>
80104a42:	83 c4 10             	add    $0x10,%esp
80104a45:	85 c0                	test   %eax,%eax
80104a47:	78 37                	js     80104a80 <sys_read+0x60>
80104a49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a4c:	83 ec 04             	sub    $0x4,%esp
80104a4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104a52:	50                   	push   %eax
80104a53:	6a 01                	push   $0x1
80104a55:	e8 46 fc ff ff       	call   801046a0 <argptr>
80104a5a:	83 c4 10             	add    $0x10,%esp
80104a5d:	85 c0                	test   %eax,%eax
80104a5f:	78 1f                	js     80104a80 <sys_read+0x60>
80104a61:	83 ec 04             	sub    $0x4,%esp
80104a64:	ff 75 f0             	pushl  -0x10(%ebp)
80104a67:	ff 75 f4             	pushl  -0xc(%ebp)
80104a6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104a6d:	e8 ae c5 ff ff       	call   80101020 <fileread>
80104a72:	83 c4 10             	add    $0x10,%esp
80104a75:	c9                   	leave  
80104a76:	c3                   	ret    
80104a77:	89 f6                	mov    %esi,%esi
80104a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a85:	c9                   	leave  
80104a86:	c3                   	ret    
80104a87:	89 f6                	mov    %esi,%esi
80104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a90 <sys_write>:
80104a90:	55                   	push   %ebp
80104a91:	31 c0                	xor    %eax,%eax
80104a93:	89 e5                	mov    %esp,%ebp
80104a95:	83 ec 18             	sub    $0x18,%esp
80104a98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a9b:	e8 b0 fe ff ff       	call   80104950 <argfd.constprop.0>
80104aa0:	85 c0                	test   %eax,%eax
80104aa2:	78 4c                	js     80104af0 <sys_write+0x60>
80104aa4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104aa7:	83 ec 08             	sub    $0x8,%esp
80104aaa:	50                   	push   %eax
80104aab:	6a 02                	push   $0x2
80104aad:	e8 be fb ff ff       	call   80104670 <argint>
80104ab2:	83 c4 10             	add    $0x10,%esp
80104ab5:	85 c0                	test   %eax,%eax
80104ab7:	78 37                	js     80104af0 <sys_write+0x60>
80104ab9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104abc:	83 ec 04             	sub    $0x4,%esp
80104abf:	ff 75 f0             	pushl  -0x10(%ebp)
80104ac2:	50                   	push   %eax
80104ac3:	6a 01                	push   $0x1
80104ac5:	e8 d6 fb ff ff       	call   801046a0 <argptr>
80104aca:	83 c4 10             	add    $0x10,%esp
80104acd:	85 c0                	test   %eax,%eax
80104acf:	78 1f                	js     80104af0 <sys_write+0x60>
80104ad1:	83 ec 04             	sub    $0x4,%esp
80104ad4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ad7:	ff 75 f4             	pushl  -0xc(%ebp)
80104ada:	ff 75 ec             	pushl  -0x14(%ebp)
80104add:	e8 de c5 ff ff       	call   801010c0 <filewrite>
80104ae2:	83 c4 10             	add    $0x10,%esp
80104ae5:	c9                   	leave  
80104ae6:	c3                   	ret    
80104ae7:	89 f6                	mov    %esi,%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104af5:	c9                   	leave  
80104af6:	c3                   	ret    
80104af7:	89 f6                	mov    %esi,%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b00 <sys_close>:
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	83 ec 18             	sub    $0x18,%esp
80104b06:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104b09:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b0c:	e8 3f fe ff ff       	call   80104950 <argfd.constprop.0>
80104b11:	85 c0                	test   %eax,%eax
80104b13:	78 2b                	js     80104b40 <sys_close+0x40>
80104b15:	e8 66 ec ff ff       	call   80103780 <myproc>
80104b1a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104b1d:	83 ec 0c             	sub    $0xc,%esp
80104b20:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104b27:	00 
80104b28:	ff 75 f4             	pushl  -0xc(%ebp)
80104b2b:	e8 e0 c3 ff ff       	call   80100f10 <fileclose>
80104b30:	83 c4 10             	add    $0x10,%esp
80104b33:	31 c0                	xor    %eax,%eax
80104b35:	c9                   	leave  
80104b36:	c3                   	ret    
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b45:	c9                   	leave  
80104b46:	c3                   	ret    
80104b47:	89 f6                	mov    %esi,%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b50 <sys_fstat>:
80104b50:	55                   	push   %ebp
80104b51:	31 c0                	xor    %eax,%eax
80104b53:	89 e5                	mov    %esp,%ebp
80104b55:	83 ec 18             	sub    $0x18,%esp
80104b58:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104b5b:	e8 f0 fd ff ff       	call   80104950 <argfd.constprop.0>
80104b60:	85 c0                	test   %eax,%eax
80104b62:	78 2c                	js     80104b90 <sys_fstat+0x40>
80104b64:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b67:	83 ec 04             	sub    $0x4,%esp
80104b6a:	6a 14                	push   $0x14
80104b6c:	50                   	push   %eax
80104b6d:	6a 01                	push   $0x1
80104b6f:	e8 2c fb ff ff       	call   801046a0 <argptr>
80104b74:	83 c4 10             	add    $0x10,%esp
80104b77:	85 c0                	test   %eax,%eax
80104b79:	78 15                	js     80104b90 <sys_fstat+0x40>
80104b7b:	83 ec 08             	sub    $0x8,%esp
80104b7e:	ff 75 f4             	pushl  -0xc(%ebp)
80104b81:	ff 75 f0             	pushl  -0x10(%ebp)
80104b84:	e8 47 c4 ff ff       	call   80100fd0 <filestat>
80104b89:	83 c4 10             	add    $0x10,%esp
80104b8c:	c9                   	leave  
80104b8d:	c3                   	ret    
80104b8e:	66 90                	xchg   %ax,%ax
80104b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b95:	c9                   	leave  
80104b96:	c3                   	ret    
80104b97:	89 f6                	mov    %esi,%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ba0 <sys_link>:
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	57                   	push   %edi
80104ba4:	56                   	push   %esi
80104ba5:	53                   	push   %ebx
80104ba6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104ba9:	83 ec 34             	sub    $0x34,%esp
80104bac:	50                   	push   %eax
80104bad:	6a 00                	push   $0x0
80104baf:	e8 4c fb ff ff       	call   80104700 <argstr>
80104bb4:	83 c4 10             	add    $0x10,%esp
80104bb7:	85 c0                	test   %eax,%eax
80104bb9:	0f 88 fb 00 00 00    	js     80104cba <sys_link+0x11a>
80104bbf:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104bc2:	83 ec 08             	sub    $0x8,%esp
80104bc5:	50                   	push   %eax
80104bc6:	6a 01                	push   $0x1
80104bc8:	e8 33 fb ff ff       	call   80104700 <argstr>
80104bcd:	83 c4 10             	add    $0x10,%esp
80104bd0:	85 c0                	test   %eax,%eax
80104bd2:	0f 88 e2 00 00 00    	js     80104cba <sys_link+0x11a>
80104bd8:	e8 13 e0 ff ff       	call   80102bf0 <begin_op>
80104bdd:	83 ec 0c             	sub    $0xc,%esp
80104be0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104be3:	e8 08 d4 ff ff       	call   80101ff0 <namei>
80104be8:	83 c4 10             	add    $0x10,%esp
80104beb:	85 c0                	test   %eax,%eax
80104bed:	89 c3                	mov    %eax,%ebx
80104bef:	0f 84 f3 00 00 00    	je     80104ce8 <sys_link+0x148>
80104bf5:	83 ec 0c             	sub    $0xc,%esp
80104bf8:	50                   	push   %eax
80104bf9:	e8 a2 cb ff ff       	call   801017a0 <ilock>
80104bfe:	83 c4 10             	add    $0x10,%esp
80104c01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104c06:	0f 84 c4 00 00 00    	je     80104cd0 <sys_link+0x130>
80104c0c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104c11:	83 ec 0c             	sub    $0xc,%esp
80104c14:	8d 7d da             	lea    -0x26(%ebp),%edi
80104c17:	53                   	push   %ebx
80104c18:	e8 c3 ca ff ff       	call   801016e0 <iupdate>
80104c1d:	89 1c 24             	mov    %ebx,(%esp)
80104c20:	e8 5b cc ff ff       	call   80101880 <iunlock>
80104c25:	58                   	pop    %eax
80104c26:	5a                   	pop    %edx
80104c27:	57                   	push   %edi
80104c28:	ff 75 d0             	pushl  -0x30(%ebp)
80104c2b:	e8 e0 d3 ff ff       	call   80102010 <nameiparent>
80104c30:	83 c4 10             	add    $0x10,%esp
80104c33:	85 c0                	test   %eax,%eax
80104c35:	89 c6                	mov    %eax,%esi
80104c37:	74 5b                	je     80104c94 <sys_link+0xf4>
80104c39:	83 ec 0c             	sub    $0xc,%esp
80104c3c:	50                   	push   %eax
80104c3d:	e8 5e cb ff ff       	call   801017a0 <ilock>
80104c42:	83 c4 10             	add    $0x10,%esp
80104c45:	8b 03                	mov    (%ebx),%eax
80104c47:	39 06                	cmp    %eax,(%esi)
80104c49:	75 3d                	jne    80104c88 <sys_link+0xe8>
80104c4b:	83 ec 04             	sub    $0x4,%esp
80104c4e:	ff 73 04             	pushl  0x4(%ebx)
80104c51:	57                   	push   %edi
80104c52:	56                   	push   %esi
80104c53:	e8 b8 d2 ff ff       	call   80101f10 <dirlink>
80104c58:	83 c4 10             	add    $0x10,%esp
80104c5b:	85 c0                	test   %eax,%eax
80104c5d:	78 29                	js     80104c88 <sys_link+0xe8>
80104c5f:	83 ec 0c             	sub    $0xc,%esp
80104c62:	56                   	push   %esi
80104c63:	e8 98 cd ff ff       	call   80101a00 <iunlockput>
80104c68:	89 1c 24             	mov    %ebx,(%esp)
80104c6b:	e8 50 cc ff ff       	call   801018c0 <iput>
80104c70:	e8 eb df ff ff       	call   80102c60 <end_op>
80104c75:	83 c4 10             	add    $0x10,%esp
80104c78:	31 c0                	xor    %eax,%eax
80104c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c7d:	5b                   	pop    %ebx
80104c7e:	5e                   	pop    %esi
80104c7f:	5f                   	pop    %edi
80104c80:	5d                   	pop    %ebp
80104c81:	c3                   	ret    
80104c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c88:	83 ec 0c             	sub    $0xc,%esp
80104c8b:	56                   	push   %esi
80104c8c:	e8 6f cd ff ff       	call   80101a00 <iunlockput>
80104c91:	83 c4 10             	add    $0x10,%esp
80104c94:	83 ec 0c             	sub    $0xc,%esp
80104c97:	53                   	push   %ebx
80104c98:	e8 03 cb ff ff       	call   801017a0 <ilock>
80104c9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80104ca2:	89 1c 24             	mov    %ebx,(%esp)
80104ca5:	e8 36 ca ff ff       	call   801016e0 <iupdate>
80104caa:	89 1c 24             	mov    %ebx,(%esp)
80104cad:	e8 4e cd ff ff       	call   80101a00 <iunlockput>
80104cb2:	e8 a9 df ff ff       	call   80102c60 <end_op>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cc2:	5b                   	pop    %ebx
80104cc3:	5e                   	pop    %esi
80104cc4:	5f                   	pop    %edi
80104cc5:	5d                   	pop    %ebp
80104cc6:	c3                   	ret    
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104cd0:	83 ec 0c             	sub    $0xc,%esp
80104cd3:	53                   	push   %ebx
80104cd4:	e8 27 cd ff ff       	call   80101a00 <iunlockput>
80104cd9:	e8 82 df ff ff       	call   80102c60 <end_op>
80104cde:	83 c4 10             	add    $0x10,%esp
80104ce1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ce6:	eb 92                	jmp    80104c7a <sys_link+0xda>
80104ce8:	e8 73 df ff ff       	call   80102c60 <end_op>
80104ced:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cf2:	eb 86                	jmp    80104c7a <sys_link+0xda>
80104cf4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d00 <sys_unlink>:
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	57                   	push   %edi
80104d04:	56                   	push   %esi
80104d05:	53                   	push   %ebx
80104d06:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104d09:	83 ec 54             	sub    $0x54,%esp
80104d0c:	50                   	push   %eax
80104d0d:	6a 00                	push   $0x0
80104d0f:	e8 ec f9 ff ff       	call   80104700 <argstr>
80104d14:	83 c4 10             	add    $0x10,%esp
80104d17:	85 c0                	test   %eax,%eax
80104d19:	0f 88 82 01 00 00    	js     80104ea1 <sys_unlink+0x1a1>
80104d1f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104d22:	e8 c9 de ff ff       	call   80102bf0 <begin_op>
80104d27:	83 ec 08             	sub    $0x8,%esp
80104d2a:	53                   	push   %ebx
80104d2b:	ff 75 c0             	pushl  -0x40(%ebp)
80104d2e:	e8 dd d2 ff ff       	call   80102010 <nameiparent>
80104d33:	83 c4 10             	add    $0x10,%esp
80104d36:	85 c0                	test   %eax,%eax
80104d38:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104d3b:	0f 84 6a 01 00 00    	je     80104eab <sys_unlink+0x1ab>
80104d41:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104d44:	83 ec 0c             	sub    $0xc,%esp
80104d47:	56                   	push   %esi
80104d48:	e8 53 ca ff ff       	call   801017a0 <ilock>
80104d4d:	58                   	pop    %eax
80104d4e:	5a                   	pop    %edx
80104d4f:	68 b4 74 10 80       	push   $0x801074b4
80104d54:	53                   	push   %ebx
80104d55:	e8 26 cf ff ff       	call   80101c80 <namecmp>
80104d5a:	83 c4 10             	add    $0x10,%esp
80104d5d:	85 c0                	test   %eax,%eax
80104d5f:	0f 84 fc 00 00 00    	je     80104e61 <sys_unlink+0x161>
80104d65:	83 ec 08             	sub    $0x8,%esp
80104d68:	68 b3 74 10 80       	push   $0x801074b3
80104d6d:	53                   	push   %ebx
80104d6e:	e8 0d cf ff ff       	call   80101c80 <namecmp>
80104d73:	83 c4 10             	add    $0x10,%esp
80104d76:	85 c0                	test   %eax,%eax
80104d78:	0f 84 e3 00 00 00    	je     80104e61 <sys_unlink+0x161>
80104d7e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104d81:	83 ec 04             	sub    $0x4,%esp
80104d84:	50                   	push   %eax
80104d85:	53                   	push   %ebx
80104d86:	56                   	push   %esi
80104d87:	e8 24 cf ff ff       	call   80101cb0 <dirlookup>
80104d8c:	83 c4 10             	add    $0x10,%esp
80104d8f:	85 c0                	test   %eax,%eax
80104d91:	89 c3                	mov    %eax,%ebx
80104d93:	0f 84 c8 00 00 00    	je     80104e61 <sys_unlink+0x161>
80104d99:	83 ec 0c             	sub    $0xc,%esp
80104d9c:	50                   	push   %eax
80104d9d:	e8 fe c9 ff ff       	call   801017a0 <ilock>
80104da2:	83 c4 10             	add    $0x10,%esp
80104da5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104daa:	0f 8e 24 01 00 00    	jle    80104ed4 <sys_unlink+0x1d4>
80104db0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104db5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104db8:	74 66                	je     80104e20 <sys_unlink+0x120>
80104dba:	83 ec 04             	sub    $0x4,%esp
80104dbd:	6a 10                	push   $0x10
80104dbf:	6a 00                	push   $0x0
80104dc1:	56                   	push   %esi
80104dc2:	e8 b9 f5 ff ff       	call   80104380 <memset>
80104dc7:	6a 10                	push   $0x10
80104dc9:	ff 75 c4             	pushl  -0x3c(%ebp)
80104dcc:	56                   	push   %esi
80104dcd:	ff 75 b4             	pushl  -0x4c(%ebp)
80104dd0:	e8 7b cd ff ff       	call   80101b50 <writei>
80104dd5:	83 c4 20             	add    $0x20,%esp
80104dd8:	83 f8 10             	cmp    $0x10,%eax
80104ddb:	0f 85 e6 00 00 00    	jne    80104ec7 <sys_unlink+0x1c7>
80104de1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104de6:	0f 84 9c 00 00 00    	je     80104e88 <sys_unlink+0x188>
80104dec:	83 ec 0c             	sub    $0xc,%esp
80104def:	ff 75 b4             	pushl  -0x4c(%ebp)
80104df2:	e8 09 cc ff ff       	call   80101a00 <iunlockput>
80104df7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80104dfc:	89 1c 24             	mov    %ebx,(%esp)
80104dff:	e8 dc c8 ff ff       	call   801016e0 <iupdate>
80104e04:	89 1c 24             	mov    %ebx,(%esp)
80104e07:	e8 f4 cb ff ff       	call   80101a00 <iunlockput>
80104e0c:	e8 4f de ff ff       	call   80102c60 <end_op>
80104e11:	83 c4 10             	add    $0x10,%esp
80104e14:	31 c0                	xor    %eax,%eax
80104e16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e19:	5b                   	pop    %ebx
80104e1a:	5e                   	pop    %esi
80104e1b:	5f                   	pop    %edi
80104e1c:	5d                   	pop    %ebp
80104e1d:	c3                   	ret    
80104e1e:	66 90                	xchg   %ax,%ax
80104e20:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104e24:	76 94                	jbe    80104dba <sys_unlink+0xba>
80104e26:	bf 20 00 00 00       	mov    $0x20,%edi
80104e2b:	eb 0f                	jmp    80104e3c <sys_unlink+0x13c>
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi
80104e30:	83 c7 10             	add    $0x10,%edi
80104e33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80104e36:	0f 83 7e ff ff ff    	jae    80104dba <sys_unlink+0xba>
80104e3c:	6a 10                	push   $0x10
80104e3e:	57                   	push   %edi
80104e3f:	56                   	push   %esi
80104e40:	53                   	push   %ebx
80104e41:	e8 0a cc ff ff       	call   80101a50 <readi>
80104e46:	83 c4 10             	add    $0x10,%esp
80104e49:	83 f8 10             	cmp    $0x10,%eax
80104e4c:	75 6c                	jne    80104eba <sys_unlink+0x1ba>
80104e4e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104e53:	74 db                	je     80104e30 <sys_unlink+0x130>
80104e55:	83 ec 0c             	sub    $0xc,%esp
80104e58:	53                   	push   %ebx
80104e59:	e8 a2 cb ff ff       	call   80101a00 <iunlockput>
80104e5e:	83 c4 10             	add    $0x10,%esp
80104e61:	83 ec 0c             	sub    $0xc,%esp
80104e64:	ff 75 b4             	pushl  -0x4c(%ebp)
80104e67:	e8 94 cb ff ff       	call   80101a00 <iunlockput>
80104e6c:	e8 ef dd ff ff       	call   80102c60 <end_op>
80104e71:	83 c4 10             	add    $0x10,%esp
80104e74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e7c:	5b                   	pop    %ebx
80104e7d:	5e                   	pop    %esi
80104e7e:	5f                   	pop    %edi
80104e7f:	5d                   	pop    %ebp
80104e80:	c3                   	ret    
80104e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e88:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e8b:	83 ec 0c             	sub    $0xc,%esp
80104e8e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
80104e93:	50                   	push   %eax
80104e94:	e8 47 c8 ff ff       	call   801016e0 <iupdate>
80104e99:	83 c4 10             	add    $0x10,%esp
80104e9c:	e9 4b ff ff ff       	jmp    80104dec <sys_unlink+0xec>
80104ea1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ea6:	e9 6b ff ff ff       	jmp    80104e16 <sys_unlink+0x116>
80104eab:	e8 b0 dd ff ff       	call   80102c60 <end_op>
80104eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104eb5:	e9 5c ff ff ff       	jmp    80104e16 <sys_unlink+0x116>
80104eba:	83 ec 0c             	sub    $0xc,%esp
80104ebd:	68 d8 74 10 80       	push   $0x801074d8
80104ec2:	e8 99 b4 ff ff       	call   80100360 <panic>
80104ec7:	83 ec 0c             	sub    $0xc,%esp
80104eca:	68 ea 74 10 80       	push   $0x801074ea
80104ecf:	e8 8c b4 ff ff       	call   80100360 <panic>
80104ed4:	83 ec 0c             	sub    $0xc,%esp
80104ed7:	68 c6 74 10 80       	push   $0x801074c6
80104edc:	e8 7f b4 ff ff       	call   80100360 <panic>
80104ee1:	eb 0d                	jmp    80104ef0 <sys_open>
80104ee3:	90                   	nop
80104ee4:	90                   	nop
80104ee5:	90                   	nop
80104ee6:	90                   	nop
80104ee7:	90                   	nop
80104ee8:	90                   	nop
80104ee9:	90                   	nop
80104eea:	90                   	nop
80104eeb:	90                   	nop
80104eec:	90                   	nop
80104eed:	90                   	nop
80104eee:	90                   	nop
80104eef:	90                   	nop

80104ef0 <sys_open>:
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	57                   	push   %edi
80104ef4:	56                   	push   %esi
80104ef5:	53                   	push   %ebx
80104ef6:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104ef9:	83 ec 24             	sub    $0x24,%esp
80104efc:	50                   	push   %eax
80104efd:	6a 00                	push   $0x0
80104eff:	e8 fc f7 ff ff       	call   80104700 <argstr>
80104f04:	83 c4 10             	add    $0x10,%esp
80104f07:	85 c0                	test   %eax,%eax
80104f09:	0f 88 9e 00 00 00    	js     80104fad <sys_open+0xbd>
80104f0f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104f12:	83 ec 08             	sub    $0x8,%esp
80104f15:	50                   	push   %eax
80104f16:	6a 01                	push   $0x1
80104f18:	e8 53 f7 ff ff       	call   80104670 <argint>
80104f1d:	83 c4 10             	add    $0x10,%esp
80104f20:	85 c0                	test   %eax,%eax
80104f22:	0f 88 85 00 00 00    	js     80104fad <sys_open+0xbd>
80104f28:	e8 c3 dc ff ff       	call   80102bf0 <begin_op>
80104f2d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104f31:	0f 85 89 00 00 00    	jne    80104fc0 <sys_open+0xd0>
80104f37:	83 ec 0c             	sub    $0xc,%esp
80104f3a:	ff 75 e0             	pushl  -0x20(%ebp)
80104f3d:	e8 ae d0 ff ff       	call   80101ff0 <namei>
80104f42:	83 c4 10             	add    $0x10,%esp
80104f45:	85 c0                	test   %eax,%eax
80104f47:	89 c6                	mov    %eax,%esi
80104f49:	0f 84 8e 00 00 00    	je     80104fdd <sys_open+0xed>
80104f4f:	83 ec 0c             	sub    $0xc,%esp
80104f52:	50                   	push   %eax
80104f53:	e8 48 c8 ff ff       	call   801017a0 <ilock>
80104f58:	83 c4 10             	add    $0x10,%esp
80104f5b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104f60:	0f 84 d2 00 00 00    	je     80105038 <sys_open+0x148>
80104f66:	e8 e5 be ff ff       	call   80100e50 <filealloc>
80104f6b:	85 c0                	test   %eax,%eax
80104f6d:	89 c7                	mov    %eax,%edi
80104f6f:	74 2b                	je     80104f9c <sys_open+0xac>
80104f71:	31 db                	xor    %ebx,%ebx
80104f73:	e8 08 e8 ff ff       	call   80103780 <myproc>
80104f78:	90                   	nop
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104f84:	85 d2                	test   %edx,%edx
80104f86:	74 68                	je     80104ff0 <sys_open+0x100>
80104f88:	83 c3 01             	add    $0x1,%ebx
80104f8b:	83 fb 10             	cmp    $0x10,%ebx
80104f8e:	75 f0                	jne    80104f80 <sys_open+0x90>
80104f90:	83 ec 0c             	sub    $0xc,%esp
80104f93:	57                   	push   %edi
80104f94:	e8 77 bf ff ff       	call   80100f10 <fileclose>
80104f99:	83 c4 10             	add    $0x10,%esp
80104f9c:	83 ec 0c             	sub    $0xc,%esp
80104f9f:	56                   	push   %esi
80104fa0:	e8 5b ca ff ff       	call   80101a00 <iunlockput>
80104fa5:	e8 b6 dc ff ff       	call   80102c60 <end_op>
80104faa:	83 c4 10             	add    $0x10,%esp
80104fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fb0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104fb5:	89 d8                	mov    %ebx,%eax
80104fb7:	5b                   	pop    %ebx
80104fb8:	5e                   	pop    %esi
80104fb9:	5f                   	pop    %edi
80104fba:	5d                   	pop    %ebp
80104fbb:	c3                   	ret    
80104fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fc0:	83 ec 0c             	sub    $0xc,%esp
80104fc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104fc6:	31 c9                	xor    %ecx,%ecx
80104fc8:	6a 00                	push   $0x0
80104fca:	ba 02 00 00 00       	mov    $0x2,%edx
80104fcf:	e8 dc f7 ff ff       	call   801047b0 <create>
80104fd4:	83 c4 10             	add    $0x10,%esp
80104fd7:	85 c0                	test   %eax,%eax
80104fd9:	89 c6                	mov    %eax,%esi
80104fdb:	75 89                	jne    80104f66 <sys_open+0x76>
80104fdd:	e8 7e dc ff ff       	call   80102c60 <end_op>
80104fe2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104fe7:	eb 40                	jmp    80105029 <sys_open+0x139>
80104fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ff0:	83 ec 0c             	sub    $0xc,%esp
80104ff3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80104ff7:	56                   	push   %esi
80104ff8:	e8 83 c8 ff ff       	call   80101880 <iunlock>
80104ffd:	e8 5e dc ff ff       	call   80102c60 <end_op>
80105002:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105008:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010500b:	83 c4 10             	add    $0x10,%esp
8010500e:	89 77 10             	mov    %esi,0x10(%edi)
80105011:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80105018:	89 c2                	mov    %eax,%edx
8010501a:	f7 d2                	not    %edx
8010501c:	88 57 08             	mov    %dl,0x8(%edi)
8010501f:	80 67 08 01          	andb   $0x1,0x8(%edi)
80105023:	a8 03                	test   $0x3,%al
80105025:	0f 95 47 09          	setne  0x9(%edi)
80105029:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010502c:	89 d8                	mov    %ebx,%eax
8010502e:	5b                   	pop    %ebx
8010502f:	5e                   	pop    %esi
80105030:	5f                   	pop    %edi
80105031:	5d                   	pop    %ebp
80105032:	c3                   	ret    
80105033:	90                   	nop
80105034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105038:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010503b:	85 c9                	test   %ecx,%ecx
8010503d:	0f 84 23 ff ff ff    	je     80104f66 <sys_open+0x76>
80105043:	e9 54 ff ff ff       	jmp    80104f9c <sys_open+0xac>
80105048:	90                   	nop
80105049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105050 <sys_mkdir>:
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	83 ec 18             	sub    $0x18,%esp
80105056:	e8 95 db ff ff       	call   80102bf0 <begin_op>
8010505b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010505e:	83 ec 08             	sub    $0x8,%esp
80105061:	50                   	push   %eax
80105062:	6a 00                	push   $0x0
80105064:	e8 97 f6 ff ff       	call   80104700 <argstr>
80105069:	83 c4 10             	add    $0x10,%esp
8010506c:	85 c0                	test   %eax,%eax
8010506e:	78 30                	js     801050a0 <sys_mkdir+0x50>
80105070:	83 ec 0c             	sub    $0xc,%esp
80105073:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105076:	31 c9                	xor    %ecx,%ecx
80105078:	6a 00                	push   $0x0
8010507a:	ba 01 00 00 00       	mov    $0x1,%edx
8010507f:	e8 2c f7 ff ff       	call   801047b0 <create>
80105084:	83 c4 10             	add    $0x10,%esp
80105087:	85 c0                	test   %eax,%eax
80105089:	74 15                	je     801050a0 <sys_mkdir+0x50>
8010508b:	83 ec 0c             	sub    $0xc,%esp
8010508e:	50                   	push   %eax
8010508f:	e8 6c c9 ff ff       	call   80101a00 <iunlockput>
80105094:	e8 c7 db ff ff       	call   80102c60 <end_op>
80105099:	83 c4 10             	add    $0x10,%esp
8010509c:	31 c0                	xor    %eax,%eax
8010509e:	c9                   	leave  
8010509f:	c3                   	ret    
801050a0:	e8 bb db ff ff       	call   80102c60 <end_op>
801050a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050aa:	c9                   	leave  
801050ab:	c3                   	ret    
801050ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050b0 <sys_mknod>:
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	83 ec 18             	sub    $0x18,%esp
801050b6:	e8 35 db ff ff       	call   80102bf0 <begin_op>
801050bb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801050be:	83 ec 08             	sub    $0x8,%esp
801050c1:	50                   	push   %eax
801050c2:	6a 00                	push   $0x0
801050c4:	e8 37 f6 ff ff       	call   80104700 <argstr>
801050c9:	83 c4 10             	add    $0x10,%esp
801050cc:	85 c0                	test   %eax,%eax
801050ce:	78 60                	js     80105130 <sys_mknod+0x80>
801050d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050d3:	83 ec 08             	sub    $0x8,%esp
801050d6:	50                   	push   %eax
801050d7:	6a 01                	push   $0x1
801050d9:	e8 92 f5 ff ff       	call   80104670 <argint>
801050de:	83 c4 10             	add    $0x10,%esp
801050e1:	85 c0                	test   %eax,%eax
801050e3:	78 4b                	js     80105130 <sys_mknod+0x80>
801050e5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050e8:	83 ec 08             	sub    $0x8,%esp
801050eb:	50                   	push   %eax
801050ec:	6a 02                	push   $0x2
801050ee:	e8 7d f5 ff ff       	call   80104670 <argint>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	85 c0                	test   %eax,%eax
801050f8:	78 36                	js     80105130 <sys_mknod+0x80>
801050fa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801050fe:	83 ec 0c             	sub    $0xc,%esp
80105101:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105105:	ba 03 00 00 00       	mov    $0x3,%edx
8010510a:	50                   	push   %eax
8010510b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010510e:	e8 9d f6 ff ff       	call   801047b0 <create>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	85 c0                	test   %eax,%eax
80105118:	74 16                	je     80105130 <sys_mknod+0x80>
8010511a:	83 ec 0c             	sub    $0xc,%esp
8010511d:	50                   	push   %eax
8010511e:	e8 dd c8 ff ff       	call   80101a00 <iunlockput>
80105123:	e8 38 db ff ff       	call   80102c60 <end_op>
80105128:	83 c4 10             	add    $0x10,%esp
8010512b:	31 c0                	xor    %eax,%eax
8010512d:	c9                   	leave  
8010512e:	c3                   	ret    
8010512f:	90                   	nop
80105130:	e8 2b db ff ff       	call   80102c60 <end_op>
80105135:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010513a:	c9                   	leave  
8010513b:	c3                   	ret    
8010513c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105140 <sys_chdir>:
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	56                   	push   %esi
80105144:	53                   	push   %ebx
80105145:	83 ec 10             	sub    $0x10,%esp
80105148:	e8 33 e6 ff ff       	call   80103780 <myproc>
8010514d:	89 c6                	mov    %eax,%esi
8010514f:	e8 9c da ff ff       	call   80102bf0 <begin_op>
80105154:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105157:	83 ec 08             	sub    $0x8,%esp
8010515a:	50                   	push   %eax
8010515b:	6a 00                	push   $0x0
8010515d:	e8 9e f5 ff ff       	call   80104700 <argstr>
80105162:	83 c4 10             	add    $0x10,%esp
80105165:	85 c0                	test   %eax,%eax
80105167:	78 77                	js     801051e0 <sys_chdir+0xa0>
80105169:	83 ec 0c             	sub    $0xc,%esp
8010516c:	ff 75 f4             	pushl  -0xc(%ebp)
8010516f:	e8 7c ce ff ff       	call   80101ff0 <namei>
80105174:	83 c4 10             	add    $0x10,%esp
80105177:	85 c0                	test   %eax,%eax
80105179:	89 c3                	mov    %eax,%ebx
8010517b:	74 63                	je     801051e0 <sys_chdir+0xa0>
8010517d:	83 ec 0c             	sub    $0xc,%esp
80105180:	50                   	push   %eax
80105181:	e8 1a c6 ff ff       	call   801017a0 <ilock>
80105186:	83 c4 10             	add    $0x10,%esp
80105189:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010518e:	75 30                	jne    801051c0 <sys_chdir+0x80>
80105190:	83 ec 0c             	sub    $0xc,%esp
80105193:	53                   	push   %ebx
80105194:	e8 e7 c6 ff ff       	call   80101880 <iunlock>
80105199:	58                   	pop    %eax
8010519a:	ff 76 68             	pushl  0x68(%esi)
8010519d:	e8 1e c7 ff ff       	call   801018c0 <iput>
801051a2:	e8 b9 da ff ff       	call   80102c60 <end_op>
801051a7:	89 5e 68             	mov    %ebx,0x68(%esi)
801051aa:	83 c4 10             	add    $0x10,%esp
801051ad:	31 c0                	xor    %eax,%eax
801051af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051b2:	5b                   	pop    %ebx
801051b3:	5e                   	pop    %esi
801051b4:	5d                   	pop    %ebp
801051b5:	c3                   	ret    
801051b6:	8d 76 00             	lea    0x0(%esi),%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801051c0:	83 ec 0c             	sub    $0xc,%esp
801051c3:	53                   	push   %ebx
801051c4:	e8 37 c8 ff ff       	call   80101a00 <iunlockput>
801051c9:	e8 92 da ff ff       	call   80102c60 <end_op>
801051ce:	83 c4 10             	add    $0x10,%esp
801051d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051d6:	eb d7                	jmp    801051af <sys_chdir+0x6f>
801051d8:	90                   	nop
801051d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051e0:	e8 7b da ff ff       	call   80102c60 <end_op>
801051e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051ea:	eb c3                	jmp    801051af <sys_chdir+0x6f>
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051f0 <sys_exec>:
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	57                   	push   %edi
801051f4:	56                   	push   %esi
801051f5:	53                   	push   %ebx
801051f6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801051fc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105202:	50                   	push   %eax
80105203:	6a 00                	push   $0x0
80105205:	e8 f6 f4 ff ff       	call   80104700 <argstr>
8010520a:	83 c4 10             	add    $0x10,%esp
8010520d:	85 c0                	test   %eax,%eax
8010520f:	78 7f                	js     80105290 <sys_exec+0xa0>
80105211:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105217:	83 ec 08             	sub    $0x8,%esp
8010521a:	50                   	push   %eax
8010521b:	6a 01                	push   $0x1
8010521d:	e8 4e f4 ff ff       	call   80104670 <argint>
80105222:	83 c4 10             	add    $0x10,%esp
80105225:	85 c0                	test   %eax,%eax
80105227:	78 67                	js     80105290 <sys_exec+0xa0>
80105229:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010522f:	83 ec 04             	sub    $0x4,%esp
80105232:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105238:	68 80 00 00 00       	push   $0x80
8010523d:	6a 00                	push   $0x0
8010523f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105245:	50                   	push   %eax
80105246:	31 db                	xor    %ebx,%ebx
80105248:	e8 33 f1 ff ff       	call   80104380 <memset>
8010524d:	83 c4 10             	add    $0x10,%esp
80105250:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105256:	83 ec 08             	sub    $0x8,%esp
80105259:	57                   	push   %edi
8010525a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010525d:	50                   	push   %eax
8010525e:	e8 6d f3 ff ff       	call   801045d0 <fetchint>
80105263:	83 c4 10             	add    $0x10,%esp
80105266:	85 c0                	test   %eax,%eax
80105268:	78 26                	js     80105290 <sys_exec+0xa0>
8010526a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105270:	85 c0                	test   %eax,%eax
80105272:	74 2c                	je     801052a0 <sys_exec+0xb0>
80105274:	83 ec 08             	sub    $0x8,%esp
80105277:	56                   	push   %esi
80105278:	50                   	push   %eax
80105279:	e8 92 f3 ff ff       	call   80104610 <fetchstr>
8010527e:	83 c4 10             	add    $0x10,%esp
80105281:	85 c0                	test   %eax,%eax
80105283:	78 0b                	js     80105290 <sys_exec+0xa0>
80105285:	83 c3 01             	add    $0x1,%ebx
80105288:	83 c6 04             	add    $0x4,%esi
8010528b:	83 fb 20             	cmp    $0x20,%ebx
8010528e:	75 c0                	jne    80105250 <sys_exec+0x60>
80105290:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105293:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105298:	5b                   	pop    %ebx
80105299:	5e                   	pop    %esi
8010529a:	5f                   	pop    %edi
8010529b:	5d                   	pop    %ebp
8010529c:	c3                   	ret    
8010529d:	8d 76 00             	lea    0x0(%esi),%esi
801052a0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801052a6:	83 ec 08             	sub    $0x8,%esp
801052a9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801052b0:	00 00 00 00 
801052b4:	50                   	push   %eax
801052b5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801052bb:	e8 c0 b7 ff ff       	call   80100a80 <exec>
801052c0:	83 c4 10             	add    $0x10,%esp
801052c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052c6:	5b                   	pop    %ebx
801052c7:	5e                   	pop    %esi
801052c8:	5f                   	pop    %edi
801052c9:	5d                   	pop    %ebp
801052ca:	c3                   	ret    
801052cb:	90                   	nop
801052cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052d0 <sys_pipe>:
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	57                   	push   %edi
801052d4:	56                   	push   %esi
801052d5:	53                   	push   %ebx
801052d6:	8d 45 dc             	lea    -0x24(%ebp),%eax
801052d9:	83 ec 20             	sub    $0x20,%esp
801052dc:	6a 08                	push   $0x8
801052de:	50                   	push   %eax
801052df:	6a 00                	push   $0x0
801052e1:	e8 ba f3 ff ff       	call   801046a0 <argptr>
801052e6:	83 c4 10             	add    $0x10,%esp
801052e9:	85 c0                	test   %eax,%eax
801052eb:	78 4a                	js     80105337 <sys_pipe+0x67>
801052ed:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801052f0:	83 ec 08             	sub    $0x8,%esp
801052f3:	50                   	push   %eax
801052f4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801052f7:	50                   	push   %eax
801052f8:	e8 53 df ff ff       	call   80103250 <pipealloc>
801052fd:	83 c4 10             	add    $0x10,%esp
80105300:	85 c0                	test   %eax,%eax
80105302:	78 33                	js     80105337 <sys_pipe+0x67>
80105304:	31 db                	xor    %ebx,%ebx
80105306:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105309:	e8 72 e4 ff ff       	call   80103780 <myproc>
8010530e:	66 90                	xchg   %ax,%ax
80105310:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105314:	85 f6                	test   %esi,%esi
80105316:	74 30                	je     80105348 <sys_pipe+0x78>
80105318:	83 c3 01             	add    $0x1,%ebx
8010531b:	83 fb 10             	cmp    $0x10,%ebx
8010531e:	75 f0                	jne    80105310 <sys_pipe+0x40>
80105320:	83 ec 0c             	sub    $0xc,%esp
80105323:	ff 75 e0             	pushl  -0x20(%ebp)
80105326:	e8 e5 bb ff ff       	call   80100f10 <fileclose>
8010532b:	58                   	pop    %eax
8010532c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010532f:	e8 dc bb ff ff       	call   80100f10 <fileclose>
80105334:	83 c4 10             	add    $0x10,%esp
80105337:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010533a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010533f:	5b                   	pop    %ebx
80105340:	5e                   	pop    %esi
80105341:	5f                   	pop    %edi
80105342:	5d                   	pop    %ebp
80105343:	c3                   	ret    
80105344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105348:	8d 73 08             	lea    0x8(%ebx),%esi
8010534b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
8010534f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105352:	e8 29 e4 ff ff       	call   80103780 <myproc>
80105357:	31 d2                	xor    %edx,%edx
80105359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105360:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105364:	85 c9                	test   %ecx,%ecx
80105366:	74 18                	je     80105380 <sys_pipe+0xb0>
80105368:	83 c2 01             	add    $0x1,%edx
8010536b:	83 fa 10             	cmp    $0x10,%edx
8010536e:	75 f0                	jne    80105360 <sys_pipe+0x90>
80105370:	e8 0b e4 ff ff       	call   80103780 <myproc>
80105375:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010537c:	00 
8010537d:	eb a1                	jmp    80105320 <sys_pipe+0x50>
8010537f:	90                   	nop
80105380:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
80105384:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105387:	89 18                	mov    %ebx,(%eax)
80105389:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010538c:	89 50 04             	mov    %edx,0x4(%eax)
8010538f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105392:	31 c0                	xor    %eax,%eax
80105394:	5b                   	pop    %ebx
80105395:	5e                   	pop    %esi
80105396:	5f                   	pop    %edi
80105397:	5d                   	pop    %ebp
80105398:	c3                   	ret    
80105399:	66 90                	xchg   %ax,%ax
8010539b:	66 90                	xchg   %ax,%ax
8010539d:	66 90                	xchg   %ax,%ax
8010539f:	90                   	nop

801053a0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801053a3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801053a4:	e9 87 e5 ff ff       	jmp    80103930 <fork>
801053a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053b0 <sys_exit>:
}

int
sys_exit(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	83 ec 08             	sub    $0x8,%esp
  exit();
801053b6:	e8 c5 e7 ff ff       	call   80103b80 <exit>
  return 0;  // not reached
}
801053bb:	31 c0                	xor    %eax,%eax
801053bd:	c9                   	leave  
801053be:	c3                   	ret    
801053bf:	90                   	nop

801053c0 <sys_wait>:

int
sys_wait(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801053c3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801053c4:	e9 c7 e9 ff ff       	jmp    80103d90 <wait>
801053c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053d0 <sys_kill>:
}

int
sys_kill(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801053d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801053dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053e4:	e8 87 f2 ff ff       	call   80104670 <argint>
801053e9:	85 c0                	test   %eax,%eax
801053eb:	78 13                	js     80105400 <sys_kill+0x30>
    return -1;
  return kill(pid);
801053ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053f0:	89 04 24             	mov    %eax,(%esp)
801053f3:	e8 d8 ea ff ff       	call   80103ed0 <kill>
}
801053f8:	c9                   	leave  
801053f9:	c3                   	ret    
801053fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105405:	c9                   	leave  
80105406:	c3                   	ret    
80105407:	89 f6                	mov    %esi,%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105410 <sys_getpid>:

int
sys_getpid(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105416:	e8 65 e3 ff ff       	call   80103780 <myproc>
8010541b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010541e:	c9                   	leave  
8010541f:	c3                   	ret    

80105420 <sys_sbrk>:

int
sys_sbrk(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	53                   	push   %ebx
80105424:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105427:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010542a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010542e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105435:	e8 36 f2 ff ff       	call   80104670 <argint>
8010543a:	85 c0                	test   %eax,%eax
8010543c:	78 22                	js     80105460 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010543e:	e8 3d e3 ff ff       	call   80103780 <myproc>
  if(growproc(n) < 0)
80105443:	8b 55 f4             	mov    -0xc(%ebp),%edx
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105446:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105448:	89 14 24             	mov    %edx,(%esp)
8010544b:	e8 70 e4 ff ff       	call   801038c0 <growproc>
80105450:	85 c0                	test   %eax,%eax
80105452:	78 0c                	js     80105460 <sys_sbrk+0x40>
    return -1;
  return addr;
80105454:	89 d8                	mov    %ebx,%eax
}
80105456:	83 c4 24             	add    $0x24,%esp
80105459:	5b                   	pop    %ebx
8010545a:	5d                   	pop    %ebp
8010545b:	c3                   	ret    
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105465:	eb ef                	jmp    80105456 <sys_sbrk+0x36>
80105467:	89 f6                	mov    %esi,%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105470 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	53                   	push   %ebx
80105474:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105477:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010547a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010547e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105485:	e8 e6 f1 ff ff       	call   80104670 <argint>
8010548a:	85 c0                	test   %eax,%eax
8010548c:	78 7e                	js     8010550c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
8010548e:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105495:	e8 26 ee ff ff       	call   801042c0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010549a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
8010549d:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
801054a3:	85 d2                	test   %edx,%edx
801054a5:	75 29                	jne    801054d0 <sys_sleep+0x60>
801054a7:	eb 4f                	jmp    801054f8 <sys_sleep+0x88>
801054a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801054b0:	c7 44 24 04 60 4c 11 	movl   $0x80114c60,0x4(%esp)
801054b7:	80 
801054b8:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
801054bf:	e8 1c e8 ff ff       	call   80103ce0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801054c4:	a1 a0 54 11 80       	mov    0x801154a0,%eax
801054c9:	29 d8                	sub    %ebx,%eax
801054cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801054ce:	73 28                	jae    801054f8 <sys_sleep+0x88>
    if(myproc()->killed){
801054d0:	e8 ab e2 ff ff       	call   80103780 <myproc>
801054d5:	8b 40 24             	mov    0x24(%eax),%eax
801054d8:	85 c0                	test   %eax,%eax
801054da:	74 d4                	je     801054b0 <sys_sleep+0x40>
      release(&tickslock);
801054dc:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801054e3:	e8 48 ee ff ff       	call   80104330 <release>
      return -1;
801054e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801054ed:	83 c4 24             	add    $0x24,%esp
801054f0:	5b                   	pop    %ebx
801054f1:	5d                   	pop    %ebp
801054f2:	c3                   	ret    
801054f3:	90                   	nop
801054f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801054f8:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801054ff:	e8 2c ee ff ff       	call   80104330 <release>
  return 0;
}
80105504:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
80105507:	31 c0                	xor    %eax,%eax
}
80105509:	5b                   	pop    %ebx
8010550a:	5d                   	pop    %ebp
8010550b:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
8010550c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105511:	eb da                	jmp    801054ed <sys_sleep+0x7d>
80105513:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105520 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	53                   	push   %ebx
80105524:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105527:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
8010552e:	e8 8d ed ff ff       	call   801042c0 <acquire>
  xticks = ticks;
80105533:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
80105539:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105540:	e8 eb ed ff ff       	call   80104330 <release>
  return xticks;
}
80105545:	83 c4 14             	add    $0x14,%esp
80105548:	89 d8                	mov    %ebx,%eax
8010554a:	5b                   	pop    %ebx
8010554b:	5d                   	pop    %ebp
8010554c:	c3                   	ret    

8010554d <alltraps>:
8010554d:	1e                   	push   %ds
8010554e:	06                   	push   %es
8010554f:	0f a0                	push   %fs
80105551:	0f a8                	push   %gs
80105553:	60                   	pusha  
80105554:	66 b8 10 00          	mov    $0x10,%ax
80105558:	8e d8                	mov    %eax,%ds
8010555a:	8e c0                	mov    %eax,%es
8010555c:	54                   	push   %esp
8010555d:	e8 de 00 00 00       	call   80105640 <trap>
80105562:	83 c4 04             	add    $0x4,%esp

80105565 <trapret>:
80105565:	61                   	popa   
80105566:	0f a9                	pop    %gs
80105568:	0f a1                	pop    %fs
8010556a:	07                   	pop    %es
8010556b:	1f                   	pop    %ds
8010556c:	83 c4 08             	add    $0x8,%esp
8010556f:	cf                   	iret   

80105570 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105570:	31 c0                	xor    %eax,%eax
80105572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105578:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010557f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105584:	66 89 0c c5 a2 4c 11 	mov    %cx,-0x7feeb35e(,%eax,8)
8010558b:	80 
8010558c:	c6 04 c5 a4 4c 11 80 	movb   $0x0,-0x7feeb35c(,%eax,8)
80105593:	00 
80105594:	c6 04 c5 a5 4c 11 80 	movb   $0x8e,-0x7feeb35b(,%eax,8)
8010559b:	8e 
8010559c:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
801055a3:	80 
801055a4:	c1 ea 10             	shr    $0x10,%edx
801055a7:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
801055ae:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801055af:	83 c0 01             	add    $0x1,%eax
801055b2:	3d 00 01 00 00       	cmp    $0x100,%eax
801055b7:	75 bf                	jne    80105578 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801055b9:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801055ba:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801055bf:	89 e5                	mov    %esp,%ebp
801055c1:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801055c4:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
801055c9:	c7 44 24 04 f9 74 10 	movl   $0x801074f9,0x4(%esp)
801055d0:	80 
801055d1:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801055d8:	66 89 15 a2 4e 11 80 	mov    %dx,0x80114ea2
801055df:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
801055e5:	c1 e8 10             	shr    $0x10,%eax
801055e8:	c6 05 a4 4e 11 80 00 	movb   $0x0,0x80114ea4
801055ef:	c6 05 a5 4e 11 80 ef 	movb   $0xef,0x80114ea5
801055f6:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6

  initlock(&tickslock, "time");
801055fc:	e8 4f eb ff ff       	call   80104150 <initlock>
}
80105601:	c9                   	leave  
80105602:	c3                   	ret    
80105603:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <idtinit>:

void
idtinit(void)
{
80105610:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105611:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105616:	89 e5                	mov    %esp,%ebp
80105618:	83 ec 10             	sub    $0x10,%esp
8010561b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010561f:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
80105624:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105628:	c1 e8 10             	shr    $0x10,%eax
8010562b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010562f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105632:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105635:	c9                   	leave  
80105636:	c3                   	ret    
80105637:	89 f6                	mov    %esi,%esi
80105639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105640 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	57                   	push   %edi
80105644:	56                   	push   %esi
80105645:	53                   	push   %ebx
80105646:	83 ec 3c             	sub    $0x3c,%esp
80105649:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010564c:	8b 43 30             	mov    0x30(%ebx),%eax
8010564f:	83 f8 40             	cmp    $0x40,%eax
80105652:	0f 84 a0 01 00 00    	je     801057f8 <trap+0x1b8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105658:	83 e8 20             	sub    $0x20,%eax
8010565b:	83 f8 1f             	cmp    $0x1f,%eax
8010565e:	77 08                	ja     80105668 <trap+0x28>
80105660:	ff 24 85 a0 75 10 80 	jmp    *-0x7fef8a60(,%eax,4)
80105667:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105668:	e8 13 e1 ff ff       	call   80103780 <myproc>
8010566d:	85 c0                	test   %eax,%eax
8010566f:	90                   	nop
80105670:	0f 84 fa 01 00 00    	je     80105870 <trap+0x230>
80105676:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010567a:	0f 84 f0 01 00 00    	je     80105870 <trap+0x230>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105680:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105683:	8b 53 38             	mov    0x38(%ebx),%edx
80105686:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105689:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010568c:	e8 cf e0 ff ff       	call   80103760 <cpuid>
80105691:	8b 73 30             	mov    0x30(%ebx),%esi
80105694:	89 c7                	mov    %eax,%edi
80105696:	8b 43 34             	mov    0x34(%ebx),%eax
80105699:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010569c:	e8 df e0 ff ff       	call   80103780 <myproc>
801056a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
801056a4:	e8 d7 e0 ff ff       	call   80103780 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056a9:	8b 55 dc             	mov    -0x24(%ebp),%edx
801056ac:	89 74 24 0c          	mov    %esi,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801056b0:	8b 75 e0             	mov    -0x20(%ebp),%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056b3:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801056b6:	89 7c 24 14          	mov    %edi,0x14(%esp)
801056ba:	89 54 24 18          	mov    %edx,0x18(%esp)
801056be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801056c1:	83 c6 6c             	add    $0x6c,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056c4:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801056c8:	89 74 24 08          	mov    %esi,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056cc:	89 54 24 10          	mov    %edx,0x10(%esp)
801056d0:	8b 40 10             	mov    0x10(%eax),%eax
801056d3:	c7 04 24 5c 75 10 80 	movl   $0x8010755c,(%esp)
801056da:	89 44 24 04          	mov    %eax,0x4(%esp)
801056de:	e8 3d b0 ff ff       	call   80100720 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801056e3:	e8 98 e0 ff ff       	call   80103780 <myproc>
801056e8:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801056ef:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801056f0:	e8 8b e0 ff ff       	call   80103780 <myproc>
801056f5:	85 c0                	test   %eax,%eax
801056f7:	74 0c                	je     80105705 <trap+0xc5>
801056f9:	e8 82 e0 ff ff       	call   80103780 <myproc>
801056fe:	8b 50 24             	mov    0x24(%eax),%edx
80105701:	85 d2                	test   %edx,%edx
80105703:	75 4b                	jne    80105750 <trap+0x110>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105705:	e8 76 e0 ff ff       	call   80103780 <myproc>
8010570a:	85 c0                	test   %eax,%eax
8010570c:	74 0d                	je     8010571b <trap+0xdb>
8010570e:	66 90                	xchg   %ax,%ax
80105710:	e8 6b e0 ff ff       	call   80103780 <myproc>
80105715:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105719:	74 4d                	je     80105768 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010571b:	e8 60 e0 ff ff       	call   80103780 <myproc>
80105720:	85 c0                	test   %eax,%eax
80105722:	74 1d                	je     80105741 <trap+0x101>
80105724:	e8 57 e0 ff ff       	call   80103780 <myproc>
80105729:	8b 40 24             	mov    0x24(%eax),%eax
8010572c:	85 c0                	test   %eax,%eax
8010572e:	74 11                	je     80105741 <trap+0x101>
80105730:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105734:	83 e0 03             	and    $0x3,%eax
80105737:	66 83 f8 03          	cmp    $0x3,%ax
8010573b:	0f 84 e8 00 00 00    	je     80105829 <trap+0x1e9>
    exit();
}
80105741:	83 c4 3c             	add    $0x3c,%esp
80105744:	5b                   	pop    %ebx
80105745:	5e                   	pop    %esi
80105746:	5f                   	pop    %edi
80105747:	5d                   	pop    %ebp
80105748:	c3                   	ret    
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105750:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105754:	83 e0 03             	and    $0x3,%eax
80105757:	66 83 f8 03          	cmp    $0x3,%ax
8010575b:	75 a8                	jne    80105705 <trap+0xc5>
    exit();
8010575d:	e8 1e e4 ff ff       	call   80103b80 <exit>
80105762:	eb a1                	jmp    80105705 <trap+0xc5>
80105764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105768:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105770:	75 a9                	jne    8010571b <trap+0xdb>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105772:	e8 29 e5 ff ff       	call   80103ca0 <yield>
80105777:	eb a2                	jmp    8010571b <trap+0xdb>
80105779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105780:	e8 db df ff ff       	call   80103760 <cpuid>
80105785:	85 c0                	test   %eax,%eax
80105787:	0f 84 b3 00 00 00    	je     80105840 <trap+0x200>
8010578d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105790:	e8 cb d0 ff ff       	call   80102860 <lapiceoi>
    break;
80105795:	e9 56 ff ff ff       	jmp    801056f0 <trap+0xb0>
8010579a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801057a0:	e8 1b cf ff ff       	call   801026c0 <kbdintr>
    lapiceoi();
801057a5:	e8 b6 d0 ff ff       	call   80102860 <lapiceoi>
    break;
801057aa:	e9 41 ff ff ff       	jmp    801056f0 <trap+0xb0>
801057af:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801057b0:	e8 0b 02 00 00       	call   801059c0 <uartintr>
    lapiceoi();
801057b5:	e8 a6 d0 ff ff       	call   80102860 <lapiceoi>
    break;
801057ba:	e9 31 ff ff ff       	jmp    801056f0 <trap+0xb0>
801057bf:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801057c0:	8b 7b 38             	mov    0x38(%ebx),%edi
801057c3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801057c7:	e8 94 df ff ff       	call   80103760 <cpuid>
801057cc:	c7 04 24 04 75 10 80 	movl   $0x80107504,(%esp)
801057d3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801057d7:	89 74 24 08          	mov    %esi,0x8(%esp)
801057db:	89 44 24 04          	mov    %eax,0x4(%esp)
801057df:	e8 3c af ff ff       	call   80100720 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
801057e4:	e8 77 d0 ff ff       	call   80102860 <lapiceoi>
    break;
801057e9:	e9 02 ff ff ff       	jmp    801056f0 <trap+0xb0>
801057ee:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801057f0:	e8 7b c9 ff ff       	call   80102170 <ideintr>
801057f5:	eb 96                	jmp    8010578d <trap+0x14d>
801057f7:	90                   	nop
801057f8:	90                   	nop
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105800:	e8 7b df ff ff       	call   80103780 <myproc>
80105805:	8b 70 24             	mov    0x24(%eax),%esi
80105808:	85 f6                	test   %esi,%esi
8010580a:	75 2c                	jne    80105838 <trap+0x1f8>
      exit();
    myproc()->tf = tf;
8010580c:	e8 6f df ff ff       	call   80103780 <myproc>
80105811:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105814:	e8 27 ef ff ff       	call   80104740 <syscall>
    if(myproc()->killed)
80105819:	e8 62 df ff ff       	call   80103780 <myproc>
8010581e:	8b 48 24             	mov    0x24(%eax),%ecx
80105821:	85 c9                	test   %ecx,%ecx
80105823:	0f 84 18 ff ff ff    	je     80105741 <trap+0x101>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105829:	83 c4 3c             	add    $0x3c,%esp
8010582c:	5b                   	pop    %ebx
8010582d:	5e                   	pop    %esi
8010582e:	5f                   	pop    %edi
8010582f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105830:	e9 4b e3 ff ff       	jmp    80103b80 <exit>
80105835:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105838:	e8 43 e3 ff ff       	call   80103b80 <exit>
8010583d:	eb cd                	jmp    8010580c <trap+0x1cc>
8010583f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105840:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105847:	e8 74 ea ff ff       	call   801042c0 <acquire>
      ticks++;
      wakeup(&ticks);
8010584c:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105853:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
8010585a:	e8 11 e6 ff ff       	call   80103e70 <wakeup>
      release(&tickslock);
8010585f:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105866:	e8 c5 ea ff ff       	call   80104330 <release>
8010586b:	e9 1d ff ff ff       	jmp    8010578d <trap+0x14d>
80105870:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105873:	8b 73 38             	mov    0x38(%ebx),%esi
80105876:	e8 e5 de ff ff       	call   80103760 <cpuid>
8010587b:	89 7c 24 10          	mov    %edi,0x10(%esp)
8010587f:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105883:	89 44 24 08          	mov    %eax,0x8(%esp)
80105887:	8b 43 30             	mov    0x30(%ebx),%eax
8010588a:	c7 04 24 28 75 10 80 	movl   $0x80107528,(%esp)
80105891:	89 44 24 04          	mov    %eax,0x4(%esp)
80105895:	e8 86 ae ff ff       	call   80100720 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
8010589a:	c7 04 24 fe 74 10 80 	movl   $0x801074fe,(%esp)
801058a1:	e8 ba aa ff ff       	call   80100360 <panic>
801058a6:	66 90                	xchg   %ax,%ax
801058a8:	66 90                	xchg   %ax,%ax
801058aa:	66 90                	xchg   %ax,%ax
801058ac:	66 90                	xchg   %ax,%ax
801058ae:	66 90                	xchg   %ax,%ax

801058b0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801058b0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801058b5:	55                   	push   %ebp
801058b6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801058b8:	85 c0                	test   %eax,%eax
801058ba:	74 14                	je     801058d0 <uartgetc+0x20>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801058bc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801058c1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801058c2:	a8 01                	test   $0x1,%al
801058c4:	74 0a                	je     801058d0 <uartgetc+0x20>
801058c6:	b2 f8                	mov    $0xf8,%dl
801058c8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801058c9:	0f b6 c0             	movzbl %al,%eax
}
801058cc:	5d                   	pop    %ebp
801058cd:	c3                   	ret    
801058ce:	66 90                	xchg   %ax,%ax

static int
uartgetc(void)
{
  if(!uart)
    return -1;
801058d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
801058d5:	5d                   	pop    %ebp
801058d6:	c3                   	ret    
801058d7:	89 f6                	mov    %esi,%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
801058e0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
801058e5:	85 c0                	test   %eax,%eax
801058e7:	74 3f                	je     80105928 <uartputc+0x48>
    uartputc(*p);
}

void
uartputc(int c)
{
801058e9:	55                   	push   %ebp
801058ea:	89 e5                	mov    %esp,%ebp
801058ec:	56                   	push   %esi
801058ed:	be fd 03 00 00       	mov    $0x3fd,%esi
801058f2:	53                   	push   %ebx
  int i;

  if(!uart)
801058f3:	bb 80 00 00 00       	mov    $0x80,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
801058f8:	83 ec 10             	sub    $0x10,%esp
801058fb:	eb 14                	jmp    80105911 <uartputc+0x31>
801058fd:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105900:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105907:	e8 74 cf ff ff       	call   80102880 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010590c:	83 eb 01             	sub    $0x1,%ebx
8010590f:	74 07                	je     80105918 <uartputc+0x38>
80105911:	89 f2                	mov    %esi,%edx
80105913:	ec                   	in     (%dx),%al
80105914:	a8 20                	test   $0x20,%al
80105916:	74 e8                	je     80105900 <uartputc+0x20>
    microdelay(10);
  outb(COM1+0, c);
80105918:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010591c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105921:	ee                   	out    %al,(%dx)
}
80105922:	83 c4 10             	add    $0x10,%esp
80105925:	5b                   	pop    %ebx
80105926:	5e                   	pop    %esi
80105927:	5d                   	pop    %ebp
80105928:	f3 c3                	repz ret 
8010592a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105930 <uartinit>:
80105930:	ba fa 03 00 00       	mov    $0x3fa,%edx
80105935:	31 c0                	xor    %eax,%eax
80105937:	ee                   	out    %al,(%dx)
80105938:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010593d:	b2 fb                	mov    $0xfb,%dl
8010593f:	ee                   	out    %al,(%dx)
80105940:	b8 0c 00 00 00       	mov    $0xc,%eax
80105945:	b2 f8                	mov    $0xf8,%dl
80105947:	ee                   	out    %al,(%dx)
80105948:	31 c0                	xor    %eax,%eax
8010594a:	b2 f9                	mov    $0xf9,%dl
8010594c:	ee                   	out    %al,(%dx)
8010594d:	b8 03 00 00 00       	mov    $0x3,%eax
80105952:	b2 fb                	mov    $0xfb,%dl
80105954:	ee                   	out    %al,(%dx)
80105955:	31 c0                	xor    %eax,%eax
80105957:	b2 fc                	mov    $0xfc,%dl
80105959:	ee                   	out    %al,(%dx)
8010595a:	b8 01 00 00 00       	mov    $0x1,%eax
8010595f:	b2 f9                	mov    $0xf9,%dl
80105961:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105962:	b2 fd                	mov    $0xfd,%dl
80105964:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105965:	3c ff                	cmp    $0xff,%al
80105967:	74 4e                	je     801059b7 <uartinit+0x87>

static int uart;    // is there a uart?

void
uartinit(void)
{
80105969:	55                   	push   %ebp
8010596a:	b2 fa                	mov    $0xfa,%dl
8010596c:	89 e5                	mov    %esp,%ebp
8010596e:	53                   	push   %ebx
8010596f:	83 ec 14             	sub    $0x14,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
  uart = 1;
80105972:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105979:	00 00 00 
8010597c:	ec                   	in     (%dx),%al
8010597d:	b2 f8                	mov    $0xf8,%dl
8010597f:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105980:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105987:	00 

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105988:	bb 20 76 10 80       	mov    $0x80107620,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
8010598d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105994:	e8 07 ca ff ff       	call   801023a0 <ioapicenable>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105999:	b8 78 00 00 00       	mov    $0x78,%eax
8010599e:	66 90                	xchg   %ax,%ax
    uartputc(*p);
801059a0:	89 04 24             	mov    %eax,(%esp)
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801059a3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
801059a6:	e8 35 ff ff ff       	call   801058e0 <uartputc>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801059ab:	0f be 03             	movsbl (%ebx),%eax
801059ae:	84 c0                	test   %al,%al
801059b0:	75 ee                	jne    801059a0 <uartinit+0x70>
    uartputc(*p);
}
801059b2:	83 c4 14             	add    $0x14,%esp
801059b5:	5b                   	pop    %ebx
801059b6:	5d                   	pop    %ebp
801059b7:	f3 c3                	repz ret 
801059b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059c0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801059c6:	c7 04 24 b0 58 10 80 	movl   $0x801058b0,(%esp)
801059cd:	e8 ae ae ff ff       	call   80100880 <consoleintr>
}
801059d2:	c9                   	leave  
801059d3:	c3                   	ret    

801059d4 <vector0>:
801059d4:	6a 00                	push   $0x0
801059d6:	6a 00                	push   $0x0
801059d8:	e9 70 fb ff ff       	jmp    8010554d <alltraps>

801059dd <vector1>:
801059dd:	6a 00                	push   $0x0
801059df:	6a 01                	push   $0x1
801059e1:	e9 67 fb ff ff       	jmp    8010554d <alltraps>

801059e6 <vector2>:
801059e6:	6a 00                	push   $0x0
801059e8:	6a 02                	push   $0x2
801059ea:	e9 5e fb ff ff       	jmp    8010554d <alltraps>

801059ef <vector3>:
801059ef:	6a 00                	push   $0x0
801059f1:	6a 03                	push   $0x3
801059f3:	e9 55 fb ff ff       	jmp    8010554d <alltraps>

801059f8 <vector4>:
801059f8:	6a 00                	push   $0x0
801059fa:	6a 04                	push   $0x4
801059fc:	e9 4c fb ff ff       	jmp    8010554d <alltraps>

80105a01 <vector5>:
80105a01:	6a 00                	push   $0x0
80105a03:	6a 05                	push   $0x5
80105a05:	e9 43 fb ff ff       	jmp    8010554d <alltraps>

80105a0a <vector6>:
80105a0a:	6a 00                	push   $0x0
80105a0c:	6a 06                	push   $0x6
80105a0e:	e9 3a fb ff ff       	jmp    8010554d <alltraps>

80105a13 <vector7>:
80105a13:	6a 00                	push   $0x0
80105a15:	6a 07                	push   $0x7
80105a17:	e9 31 fb ff ff       	jmp    8010554d <alltraps>

80105a1c <vector8>:
80105a1c:	6a 08                	push   $0x8
80105a1e:	e9 2a fb ff ff       	jmp    8010554d <alltraps>

80105a23 <vector9>:
80105a23:	6a 00                	push   $0x0
80105a25:	6a 09                	push   $0x9
80105a27:	e9 21 fb ff ff       	jmp    8010554d <alltraps>

80105a2c <vector10>:
80105a2c:	6a 0a                	push   $0xa
80105a2e:	e9 1a fb ff ff       	jmp    8010554d <alltraps>

80105a33 <vector11>:
80105a33:	6a 0b                	push   $0xb
80105a35:	e9 13 fb ff ff       	jmp    8010554d <alltraps>

80105a3a <vector12>:
80105a3a:	6a 0c                	push   $0xc
80105a3c:	e9 0c fb ff ff       	jmp    8010554d <alltraps>

80105a41 <vector13>:
80105a41:	6a 0d                	push   $0xd
80105a43:	e9 05 fb ff ff       	jmp    8010554d <alltraps>

80105a48 <vector14>:
80105a48:	6a 0e                	push   $0xe
80105a4a:	e9 fe fa ff ff       	jmp    8010554d <alltraps>

80105a4f <vector15>:
80105a4f:	6a 00                	push   $0x0
80105a51:	6a 0f                	push   $0xf
80105a53:	e9 f5 fa ff ff       	jmp    8010554d <alltraps>

80105a58 <vector16>:
80105a58:	6a 00                	push   $0x0
80105a5a:	6a 10                	push   $0x10
80105a5c:	e9 ec fa ff ff       	jmp    8010554d <alltraps>

80105a61 <vector17>:
80105a61:	6a 11                	push   $0x11
80105a63:	e9 e5 fa ff ff       	jmp    8010554d <alltraps>

80105a68 <vector18>:
80105a68:	6a 00                	push   $0x0
80105a6a:	6a 12                	push   $0x12
80105a6c:	e9 dc fa ff ff       	jmp    8010554d <alltraps>

80105a71 <vector19>:
80105a71:	6a 00                	push   $0x0
80105a73:	6a 13                	push   $0x13
80105a75:	e9 d3 fa ff ff       	jmp    8010554d <alltraps>

80105a7a <vector20>:
80105a7a:	6a 00                	push   $0x0
80105a7c:	6a 14                	push   $0x14
80105a7e:	e9 ca fa ff ff       	jmp    8010554d <alltraps>

80105a83 <vector21>:
80105a83:	6a 00                	push   $0x0
80105a85:	6a 15                	push   $0x15
80105a87:	e9 c1 fa ff ff       	jmp    8010554d <alltraps>

80105a8c <vector22>:
80105a8c:	6a 00                	push   $0x0
80105a8e:	6a 16                	push   $0x16
80105a90:	e9 b8 fa ff ff       	jmp    8010554d <alltraps>

80105a95 <vector23>:
80105a95:	6a 00                	push   $0x0
80105a97:	6a 17                	push   $0x17
80105a99:	e9 af fa ff ff       	jmp    8010554d <alltraps>

80105a9e <vector24>:
80105a9e:	6a 00                	push   $0x0
80105aa0:	6a 18                	push   $0x18
80105aa2:	e9 a6 fa ff ff       	jmp    8010554d <alltraps>

80105aa7 <vector25>:
80105aa7:	6a 00                	push   $0x0
80105aa9:	6a 19                	push   $0x19
80105aab:	e9 9d fa ff ff       	jmp    8010554d <alltraps>

80105ab0 <vector26>:
80105ab0:	6a 00                	push   $0x0
80105ab2:	6a 1a                	push   $0x1a
80105ab4:	e9 94 fa ff ff       	jmp    8010554d <alltraps>

80105ab9 <vector27>:
80105ab9:	6a 00                	push   $0x0
80105abb:	6a 1b                	push   $0x1b
80105abd:	e9 8b fa ff ff       	jmp    8010554d <alltraps>

80105ac2 <vector28>:
80105ac2:	6a 00                	push   $0x0
80105ac4:	6a 1c                	push   $0x1c
80105ac6:	e9 82 fa ff ff       	jmp    8010554d <alltraps>

80105acb <vector29>:
80105acb:	6a 00                	push   $0x0
80105acd:	6a 1d                	push   $0x1d
80105acf:	e9 79 fa ff ff       	jmp    8010554d <alltraps>

80105ad4 <vector30>:
80105ad4:	6a 00                	push   $0x0
80105ad6:	6a 1e                	push   $0x1e
80105ad8:	e9 70 fa ff ff       	jmp    8010554d <alltraps>

80105add <vector31>:
80105add:	6a 00                	push   $0x0
80105adf:	6a 1f                	push   $0x1f
80105ae1:	e9 67 fa ff ff       	jmp    8010554d <alltraps>

80105ae6 <vector32>:
80105ae6:	6a 00                	push   $0x0
80105ae8:	6a 20                	push   $0x20
80105aea:	e9 5e fa ff ff       	jmp    8010554d <alltraps>

80105aef <vector33>:
80105aef:	6a 00                	push   $0x0
80105af1:	6a 21                	push   $0x21
80105af3:	e9 55 fa ff ff       	jmp    8010554d <alltraps>

80105af8 <vector34>:
80105af8:	6a 00                	push   $0x0
80105afa:	6a 22                	push   $0x22
80105afc:	e9 4c fa ff ff       	jmp    8010554d <alltraps>

80105b01 <vector35>:
80105b01:	6a 00                	push   $0x0
80105b03:	6a 23                	push   $0x23
80105b05:	e9 43 fa ff ff       	jmp    8010554d <alltraps>

80105b0a <vector36>:
80105b0a:	6a 00                	push   $0x0
80105b0c:	6a 24                	push   $0x24
80105b0e:	e9 3a fa ff ff       	jmp    8010554d <alltraps>

80105b13 <vector37>:
80105b13:	6a 00                	push   $0x0
80105b15:	6a 25                	push   $0x25
80105b17:	e9 31 fa ff ff       	jmp    8010554d <alltraps>

80105b1c <vector38>:
80105b1c:	6a 00                	push   $0x0
80105b1e:	6a 26                	push   $0x26
80105b20:	e9 28 fa ff ff       	jmp    8010554d <alltraps>

80105b25 <vector39>:
80105b25:	6a 00                	push   $0x0
80105b27:	6a 27                	push   $0x27
80105b29:	e9 1f fa ff ff       	jmp    8010554d <alltraps>

80105b2e <vector40>:
80105b2e:	6a 00                	push   $0x0
80105b30:	6a 28                	push   $0x28
80105b32:	e9 16 fa ff ff       	jmp    8010554d <alltraps>

80105b37 <vector41>:
80105b37:	6a 00                	push   $0x0
80105b39:	6a 29                	push   $0x29
80105b3b:	e9 0d fa ff ff       	jmp    8010554d <alltraps>

80105b40 <vector42>:
80105b40:	6a 00                	push   $0x0
80105b42:	6a 2a                	push   $0x2a
80105b44:	e9 04 fa ff ff       	jmp    8010554d <alltraps>

80105b49 <vector43>:
80105b49:	6a 00                	push   $0x0
80105b4b:	6a 2b                	push   $0x2b
80105b4d:	e9 fb f9 ff ff       	jmp    8010554d <alltraps>

80105b52 <vector44>:
80105b52:	6a 00                	push   $0x0
80105b54:	6a 2c                	push   $0x2c
80105b56:	e9 f2 f9 ff ff       	jmp    8010554d <alltraps>

80105b5b <vector45>:
80105b5b:	6a 00                	push   $0x0
80105b5d:	6a 2d                	push   $0x2d
80105b5f:	e9 e9 f9 ff ff       	jmp    8010554d <alltraps>

80105b64 <vector46>:
80105b64:	6a 00                	push   $0x0
80105b66:	6a 2e                	push   $0x2e
80105b68:	e9 e0 f9 ff ff       	jmp    8010554d <alltraps>

80105b6d <vector47>:
80105b6d:	6a 00                	push   $0x0
80105b6f:	6a 2f                	push   $0x2f
80105b71:	e9 d7 f9 ff ff       	jmp    8010554d <alltraps>

80105b76 <vector48>:
80105b76:	6a 00                	push   $0x0
80105b78:	6a 30                	push   $0x30
80105b7a:	e9 ce f9 ff ff       	jmp    8010554d <alltraps>

80105b7f <vector49>:
80105b7f:	6a 00                	push   $0x0
80105b81:	6a 31                	push   $0x31
80105b83:	e9 c5 f9 ff ff       	jmp    8010554d <alltraps>

80105b88 <vector50>:
80105b88:	6a 00                	push   $0x0
80105b8a:	6a 32                	push   $0x32
80105b8c:	e9 bc f9 ff ff       	jmp    8010554d <alltraps>

80105b91 <vector51>:
80105b91:	6a 00                	push   $0x0
80105b93:	6a 33                	push   $0x33
80105b95:	e9 b3 f9 ff ff       	jmp    8010554d <alltraps>

80105b9a <vector52>:
80105b9a:	6a 00                	push   $0x0
80105b9c:	6a 34                	push   $0x34
80105b9e:	e9 aa f9 ff ff       	jmp    8010554d <alltraps>

80105ba3 <vector53>:
80105ba3:	6a 00                	push   $0x0
80105ba5:	6a 35                	push   $0x35
80105ba7:	e9 a1 f9 ff ff       	jmp    8010554d <alltraps>

80105bac <vector54>:
80105bac:	6a 00                	push   $0x0
80105bae:	6a 36                	push   $0x36
80105bb0:	e9 98 f9 ff ff       	jmp    8010554d <alltraps>

80105bb5 <vector55>:
80105bb5:	6a 00                	push   $0x0
80105bb7:	6a 37                	push   $0x37
80105bb9:	e9 8f f9 ff ff       	jmp    8010554d <alltraps>

80105bbe <vector56>:
80105bbe:	6a 00                	push   $0x0
80105bc0:	6a 38                	push   $0x38
80105bc2:	e9 86 f9 ff ff       	jmp    8010554d <alltraps>

80105bc7 <vector57>:
80105bc7:	6a 00                	push   $0x0
80105bc9:	6a 39                	push   $0x39
80105bcb:	e9 7d f9 ff ff       	jmp    8010554d <alltraps>

80105bd0 <vector58>:
80105bd0:	6a 00                	push   $0x0
80105bd2:	6a 3a                	push   $0x3a
80105bd4:	e9 74 f9 ff ff       	jmp    8010554d <alltraps>

80105bd9 <vector59>:
80105bd9:	6a 00                	push   $0x0
80105bdb:	6a 3b                	push   $0x3b
80105bdd:	e9 6b f9 ff ff       	jmp    8010554d <alltraps>

80105be2 <vector60>:
80105be2:	6a 00                	push   $0x0
80105be4:	6a 3c                	push   $0x3c
80105be6:	e9 62 f9 ff ff       	jmp    8010554d <alltraps>

80105beb <vector61>:
80105beb:	6a 00                	push   $0x0
80105bed:	6a 3d                	push   $0x3d
80105bef:	e9 59 f9 ff ff       	jmp    8010554d <alltraps>

80105bf4 <vector62>:
80105bf4:	6a 00                	push   $0x0
80105bf6:	6a 3e                	push   $0x3e
80105bf8:	e9 50 f9 ff ff       	jmp    8010554d <alltraps>

80105bfd <vector63>:
80105bfd:	6a 00                	push   $0x0
80105bff:	6a 3f                	push   $0x3f
80105c01:	e9 47 f9 ff ff       	jmp    8010554d <alltraps>

80105c06 <vector64>:
80105c06:	6a 00                	push   $0x0
80105c08:	6a 40                	push   $0x40
80105c0a:	e9 3e f9 ff ff       	jmp    8010554d <alltraps>

80105c0f <vector65>:
80105c0f:	6a 00                	push   $0x0
80105c11:	6a 41                	push   $0x41
80105c13:	e9 35 f9 ff ff       	jmp    8010554d <alltraps>

80105c18 <vector66>:
80105c18:	6a 00                	push   $0x0
80105c1a:	6a 42                	push   $0x42
80105c1c:	e9 2c f9 ff ff       	jmp    8010554d <alltraps>

80105c21 <vector67>:
80105c21:	6a 00                	push   $0x0
80105c23:	6a 43                	push   $0x43
80105c25:	e9 23 f9 ff ff       	jmp    8010554d <alltraps>

80105c2a <vector68>:
80105c2a:	6a 00                	push   $0x0
80105c2c:	6a 44                	push   $0x44
80105c2e:	e9 1a f9 ff ff       	jmp    8010554d <alltraps>

80105c33 <vector69>:
80105c33:	6a 00                	push   $0x0
80105c35:	6a 45                	push   $0x45
80105c37:	e9 11 f9 ff ff       	jmp    8010554d <alltraps>

80105c3c <vector70>:
80105c3c:	6a 00                	push   $0x0
80105c3e:	6a 46                	push   $0x46
80105c40:	e9 08 f9 ff ff       	jmp    8010554d <alltraps>

80105c45 <vector71>:
80105c45:	6a 00                	push   $0x0
80105c47:	6a 47                	push   $0x47
80105c49:	e9 ff f8 ff ff       	jmp    8010554d <alltraps>

80105c4e <vector72>:
80105c4e:	6a 00                	push   $0x0
80105c50:	6a 48                	push   $0x48
80105c52:	e9 f6 f8 ff ff       	jmp    8010554d <alltraps>

80105c57 <vector73>:
80105c57:	6a 00                	push   $0x0
80105c59:	6a 49                	push   $0x49
80105c5b:	e9 ed f8 ff ff       	jmp    8010554d <alltraps>

80105c60 <vector74>:
80105c60:	6a 00                	push   $0x0
80105c62:	6a 4a                	push   $0x4a
80105c64:	e9 e4 f8 ff ff       	jmp    8010554d <alltraps>

80105c69 <vector75>:
80105c69:	6a 00                	push   $0x0
80105c6b:	6a 4b                	push   $0x4b
80105c6d:	e9 db f8 ff ff       	jmp    8010554d <alltraps>

80105c72 <vector76>:
80105c72:	6a 00                	push   $0x0
80105c74:	6a 4c                	push   $0x4c
80105c76:	e9 d2 f8 ff ff       	jmp    8010554d <alltraps>

80105c7b <vector77>:
80105c7b:	6a 00                	push   $0x0
80105c7d:	6a 4d                	push   $0x4d
80105c7f:	e9 c9 f8 ff ff       	jmp    8010554d <alltraps>

80105c84 <vector78>:
80105c84:	6a 00                	push   $0x0
80105c86:	6a 4e                	push   $0x4e
80105c88:	e9 c0 f8 ff ff       	jmp    8010554d <alltraps>

80105c8d <vector79>:
80105c8d:	6a 00                	push   $0x0
80105c8f:	6a 4f                	push   $0x4f
80105c91:	e9 b7 f8 ff ff       	jmp    8010554d <alltraps>

80105c96 <vector80>:
80105c96:	6a 00                	push   $0x0
80105c98:	6a 50                	push   $0x50
80105c9a:	e9 ae f8 ff ff       	jmp    8010554d <alltraps>

80105c9f <vector81>:
80105c9f:	6a 00                	push   $0x0
80105ca1:	6a 51                	push   $0x51
80105ca3:	e9 a5 f8 ff ff       	jmp    8010554d <alltraps>

80105ca8 <vector82>:
80105ca8:	6a 00                	push   $0x0
80105caa:	6a 52                	push   $0x52
80105cac:	e9 9c f8 ff ff       	jmp    8010554d <alltraps>

80105cb1 <vector83>:
80105cb1:	6a 00                	push   $0x0
80105cb3:	6a 53                	push   $0x53
80105cb5:	e9 93 f8 ff ff       	jmp    8010554d <alltraps>

80105cba <vector84>:
80105cba:	6a 00                	push   $0x0
80105cbc:	6a 54                	push   $0x54
80105cbe:	e9 8a f8 ff ff       	jmp    8010554d <alltraps>

80105cc3 <vector85>:
80105cc3:	6a 00                	push   $0x0
80105cc5:	6a 55                	push   $0x55
80105cc7:	e9 81 f8 ff ff       	jmp    8010554d <alltraps>

80105ccc <vector86>:
80105ccc:	6a 00                	push   $0x0
80105cce:	6a 56                	push   $0x56
80105cd0:	e9 78 f8 ff ff       	jmp    8010554d <alltraps>

80105cd5 <vector87>:
80105cd5:	6a 00                	push   $0x0
80105cd7:	6a 57                	push   $0x57
80105cd9:	e9 6f f8 ff ff       	jmp    8010554d <alltraps>

80105cde <vector88>:
80105cde:	6a 00                	push   $0x0
80105ce0:	6a 58                	push   $0x58
80105ce2:	e9 66 f8 ff ff       	jmp    8010554d <alltraps>

80105ce7 <vector89>:
80105ce7:	6a 00                	push   $0x0
80105ce9:	6a 59                	push   $0x59
80105ceb:	e9 5d f8 ff ff       	jmp    8010554d <alltraps>

80105cf0 <vector90>:
80105cf0:	6a 00                	push   $0x0
80105cf2:	6a 5a                	push   $0x5a
80105cf4:	e9 54 f8 ff ff       	jmp    8010554d <alltraps>

80105cf9 <vector91>:
80105cf9:	6a 00                	push   $0x0
80105cfb:	6a 5b                	push   $0x5b
80105cfd:	e9 4b f8 ff ff       	jmp    8010554d <alltraps>

80105d02 <vector92>:
80105d02:	6a 00                	push   $0x0
80105d04:	6a 5c                	push   $0x5c
80105d06:	e9 42 f8 ff ff       	jmp    8010554d <alltraps>

80105d0b <vector93>:
80105d0b:	6a 00                	push   $0x0
80105d0d:	6a 5d                	push   $0x5d
80105d0f:	e9 39 f8 ff ff       	jmp    8010554d <alltraps>

80105d14 <vector94>:
80105d14:	6a 00                	push   $0x0
80105d16:	6a 5e                	push   $0x5e
80105d18:	e9 30 f8 ff ff       	jmp    8010554d <alltraps>

80105d1d <vector95>:
80105d1d:	6a 00                	push   $0x0
80105d1f:	6a 5f                	push   $0x5f
80105d21:	e9 27 f8 ff ff       	jmp    8010554d <alltraps>

80105d26 <vector96>:
80105d26:	6a 00                	push   $0x0
80105d28:	6a 60                	push   $0x60
80105d2a:	e9 1e f8 ff ff       	jmp    8010554d <alltraps>

80105d2f <vector97>:
80105d2f:	6a 00                	push   $0x0
80105d31:	6a 61                	push   $0x61
80105d33:	e9 15 f8 ff ff       	jmp    8010554d <alltraps>

80105d38 <vector98>:
80105d38:	6a 00                	push   $0x0
80105d3a:	6a 62                	push   $0x62
80105d3c:	e9 0c f8 ff ff       	jmp    8010554d <alltraps>

80105d41 <vector99>:
80105d41:	6a 00                	push   $0x0
80105d43:	6a 63                	push   $0x63
80105d45:	e9 03 f8 ff ff       	jmp    8010554d <alltraps>

80105d4a <vector100>:
80105d4a:	6a 00                	push   $0x0
80105d4c:	6a 64                	push   $0x64
80105d4e:	e9 fa f7 ff ff       	jmp    8010554d <alltraps>

80105d53 <vector101>:
80105d53:	6a 00                	push   $0x0
80105d55:	6a 65                	push   $0x65
80105d57:	e9 f1 f7 ff ff       	jmp    8010554d <alltraps>

80105d5c <vector102>:
80105d5c:	6a 00                	push   $0x0
80105d5e:	6a 66                	push   $0x66
80105d60:	e9 e8 f7 ff ff       	jmp    8010554d <alltraps>

80105d65 <vector103>:
80105d65:	6a 00                	push   $0x0
80105d67:	6a 67                	push   $0x67
80105d69:	e9 df f7 ff ff       	jmp    8010554d <alltraps>

80105d6e <vector104>:
80105d6e:	6a 00                	push   $0x0
80105d70:	6a 68                	push   $0x68
80105d72:	e9 d6 f7 ff ff       	jmp    8010554d <alltraps>

80105d77 <vector105>:
80105d77:	6a 00                	push   $0x0
80105d79:	6a 69                	push   $0x69
80105d7b:	e9 cd f7 ff ff       	jmp    8010554d <alltraps>

80105d80 <vector106>:
80105d80:	6a 00                	push   $0x0
80105d82:	6a 6a                	push   $0x6a
80105d84:	e9 c4 f7 ff ff       	jmp    8010554d <alltraps>

80105d89 <vector107>:
80105d89:	6a 00                	push   $0x0
80105d8b:	6a 6b                	push   $0x6b
80105d8d:	e9 bb f7 ff ff       	jmp    8010554d <alltraps>

80105d92 <vector108>:
80105d92:	6a 00                	push   $0x0
80105d94:	6a 6c                	push   $0x6c
80105d96:	e9 b2 f7 ff ff       	jmp    8010554d <alltraps>

80105d9b <vector109>:
80105d9b:	6a 00                	push   $0x0
80105d9d:	6a 6d                	push   $0x6d
80105d9f:	e9 a9 f7 ff ff       	jmp    8010554d <alltraps>

80105da4 <vector110>:
80105da4:	6a 00                	push   $0x0
80105da6:	6a 6e                	push   $0x6e
80105da8:	e9 a0 f7 ff ff       	jmp    8010554d <alltraps>

80105dad <vector111>:
80105dad:	6a 00                	push   $0x0
80105daf:	6a 6f                	push   $0x6f
80105db1:	e9 97 f7 ff ff       	jmp    8010554d <alltraps>

80105db6 <vector112>:
80105db6:	6a 00                	push   $0x0
80105db8:	6a 70                	push   $0x70
80105dba:	e9 8e f7 ff ff       	jmp    8010554d <alltraps>

80105dbf <vector113>:
80105dbf:	6a 00                	push   $0x0
80105dc1:	6a 71                	push   $0x71
80105dc3:	e9 85 f7 ff ff       	jmp    8010554d <alltraps>

80105dc8 <vector114>:
80105dc8:	6a 00                	push   $0x0
80105dca:	6a 72                	push   $0x72
80105dcc:	e9 7c f7 ff ff       	jmp    8010554d <alltraps>

80105dd1 <vector115>:
80105dd1:	6a 00                	push   $0x0
80105dd3:	6a 73                	push   $0x73
80105dd5:	e9 73 f7 ff ff       	jmp    8010554d <alltraps>

80105dda <vector116>:
80105dda:	6a 00                	push   $0x0
80105ddc:	6a 74                	push   $0x74
80105dde:	e9 6a f7 ff ff       	jmp    8010554d <alltraps>

80105de3 <vector117>:
80105de3:	6a 00                	push   $0x0
80105de5:	6a 75                	push   $0x75
80105de7:	e9 61 f7 ff ff       	jmp    8010554d <alltraps>

80105dec <vector118>:
80105dec:	6a 00                	push   $0x0
80105dee:	6a 76                	push   $0x76
80105df0:	e9 58 f7 ff ff       	jmp    8010554d <alltraps>

80105df5 <vector119>:
80105df5:	6a 00                	push   $0x0
80105df7:	6a 77                	push   $0x77
80105df9:	e9 4f f7 ff ff       	jmp    8010554d <alltraps>

80105dfe <vector120>:
80105dfe:	6a 00                	push   $0x0
80105e00:	6a 78                	push   $0x78
80105e02:	e9 46 f7 ff ff       	jmp    8010554d <alltraps>

80105e07 <vector121>:
80105e07:	6a 00                	push   $0x0
80105e09:	6a 79                	push   $0x79
80105e0b:	e9 3d f7 ff ff       	jmp    8010554d <alltraps>

80105e10 <vector122>:
80105e10:	6a 00                	push   $0x0
80105e12:	6a 7a                	push   $0x7a
80105e14:	e9 34 f7 ff ff       	jmp    8010554d <alltraps>

80105e19 <vector123>:
80105e19:	6a 00                	push   $0x0
80105e1b:	6a 7b                	push   $0x7b
80105e1d:	e9 2b f7 ff ff       	jmp    8010554d <alltraps>

80105e22 <vector124>:
80105e22:	6a 00                	push   $0x0
80105e24:	6a 7c                	push   $0x7c
80105e26:	e9 22 f7 ff ff       	jmp    8010554d <alltraps>

80105e2b <vector125>:
80105e2b:	6a 00                	push   $0x0
80105e2d:	6a 7d                	push   $0x7d
80105e2f:	e9 19 f7 ff ff       	jmp    8010554d <alltraps>

80105e34 <vector126>:
80105e34:	6a 00                	push   $0x0
80105e36:	6a 7e                	push   $0x7e
80105e38:	e9 10 f7 ff ff       	jmp    8010554d <alltraps>

80105e3d <vector127>:
80105e3d:	6a 00                	push   $0x0
80105e3f:	6a 7f                	push   $0x7f
80105e41:	e9 07 f7 ff ff       	jmp    8010554d <alltraps>

80105e46 <vector128>:
80105e46:	6a 00                	push   $0x0
80105e48:	68 80 00 00 00       	push   $0x80
80105e4d:	e9 fb f6 ff ff       	jmp    8010554d <alltraps>

80105e52 <vector129>:
80105e52:	6a 00                	push   $0x0
80105e54:	68 81 00 00 00       	push   $0x81
80105e59:	e9 ef f6 ff ff       	jmp    8010554d <alltraps>

80105e5e <vector130>:
80105e5e:	6a 00                	push   $0x0
80105e60:	68 82 00 00 00       	push   $0x82
80105e65:	e9 e3 f6 ff ff       	jmp    8010554d <alltraps>

80105e6a <vector131>:
80105e6a:	6a 00                	push   $0x0
80105e6c:	68 83 00 00 00       	push   $0x83
80105e71:	e9 d7 f6 ff ff       	jmp    8010554d <alltraps>

80105e76 <vector132>:
80105e76:	6a 00                	push   $0x0
80105e78:	68 84 00 00 00       	push   $0x84
80105e7d:	e9 cb f6 ff ff       	jmp    8010554d <alltraps>

80105e82 <vector133>:
80105e82:	6a 00                	push   $0x0
80105e84:	68 85 00 00 00       	push   $0x85
80105e89:	e9 bf f6 ff ff       	jmp    8010554d <alltraps>

80105e8e <vector134>:
80105e8e:	6a 00                	push   $0x0
80105e90:	68 86 00 00 00       	push   $0x86
80105e95:	e9 b3 f6 ff ff       	jmp    8010554d <alltraps>

80105e9a <vector135>:
80105e9a:	6a 00                	push   $0x0
80105e9c:	68 87 00 00 00       	push   $0x87
80105ea1:	e9 a7 f6 ff ff       	jmp    8010554d <alltraps>

80105ea6 <vector136>:
80105ea6:	6a 00                	push   $0x0
80105ea8:	68 88 00 00 00       	push   $0x88
80105ead:	e9 9b f6 ff ff       	jmp    8010554d <alltraps>

80105eb2 <vector137>:
80105eb2:	6a 00                	push   $0x0
80105eb4:	68 89 00 00 00       	push   $0x89
80105eb9:	e9 8f f6 ff ff       	jmp    8010554d <alltraps>

80105ebe <vector138>:
80105ebe:	6a 00                	push   $0x0
80105ec0:	68 8a 00 00 00       	push   $0x8a
80105ec5:	e9 83 f6 ff ff       	jmp    8010554d <alltraps>

80105eca <vector139>:
80105eca:	6a 00                	push   $0x0
80105ecc:	68 8b 00 00 00       	push   $0x8b
80105ed1:	e9 77 f6 ff ff       	jmp    8010554d <alltraps>

80105ed6 <vector140>:
80105ed6:	6a 00                	push   $0x0
80105ed8:	68 8c 00 00 00       	push   $0x8c
80105edd:	e9 6b f6 ff ff       	jmp    8010554d <alltraps>

80105ee2 <vector141>:
80105ee2:	6a 00                	push   $0x0
80105ee4:	68 8d 00 00 00       	push   $0x8d
80105ee9:	e9 5f f6 ff ff       	jmp    8010554d <alltraps>

80105eee <vector142>:
80105eee:	6a 00                	push   $0x0
80105ef0:	68 8e 00 00 00       	push   $0x8e
80105ef5:	e9 53 f6 ff ff       	jmp    8010554d <alltraps>

80105efa <vector143>:
80105efa:	6a 00                	push   $0x0
80105efc:	68 8f 00 00 00       	push   $0x8f
80105f01:	e9 47 f6 ff ff       	jmp    8010554d <alltraps>

80105f06 <vector144>:
80105f06:	6a 00                	push   $0x0
80105f08:	68 90 00 00 00       	push   $0x90
80105f0d:	e9 3b f6 ff ff       	jmp    8010554d <alltraps>

80105f12 <vector145>:
80105f12:	6a 00                	push   $0x0
80105f14:	68 91 00 00 00       	push   $0x91
80105f19:	e9 2f f6 ff ff       	jmp    8010554d <alltraps>

80105f1e <vector146>:
80105f1e:	6a 00                	push   $0x0
80105f20:	68 92 00 00 00       	push   $0x92
80105f25:	e9 23 f6 ff ff       	jmp    8010554d <alltraps>

80105f2a <vector147>:
80105f2a:	6a 00                	push   $0x0
80105f2c:	68 93 00 00 00       	push   $0x93
80105f31:	e9 17 f6 ff ff       	jmp    8010554d <alltraps>

80105f36 <vector148>:
80105f36:	6a 00                	push   $0x0
80105f38:	68 94 00 00 00       	push   $0x94
80105f3d:	e9 0b f6 ff ff       	jmp    8010554d <alltraps>

80105f42 <vector149>:
80105f42:	6a 00                	push   $0x0
80105f44:	68 95 00 00 00       	push   $0x95
80105f49:	e9 ff f5 ff ff       	jmp    8010554d <alltraps>

80105f4e <vector150>:
80105f4e:	6a 00                	push   $0x0
80105f50:	68 96 00 00 00       	push   $0x96
80105f55:	e9 f3 f5 ff ff       	jmp    8010554d <alltraps>

80105f5a <vector151>:
80105f5a:	6a 00                	push   $0x0
80105f5c:	68 97 00 00 00       	push   $0x97
80105f61:	e9 e7 f5 ff ff       	jmp    8010554d <alltraps>

80105f66 <vector152>:
80105f66:	6a 00                	push   $0x0
80105f68:	68 98 00 00 00       	push   $0x98
80105f6d:	e9 db f5 ff ff       	jmp    8010554d <alltraps>

80105f72 <vector153>:
80105f72:	6a 00                	push   $0x0
80105f74:	68 99 00 00 00       	push   $0x99
80105f79:	e9 cf f5 ff ff       	jmp    8010554d <alltraps>

80105f7e <vector154>:
80105f7e:	6a 00                	push   $0x0
80105f80:	68 9a 00 00 00       	push   $0x9a
80105f85:	e9 c3 f5 ff ff       	jmp    8010554d <alltraps>

80105f8a <vector155>:
80105f8a:	6a 00                	push   $0x0
80105f8c:	68 9b 00 00 00       	push   $0x9b
80105f91:	e9 b7 f5 ff ff       	jmp    8010554d <alltraps>

80105f96 <vector156>:
80105f96:	6a 00                	push   $0x0
80105f98:	68 9c 00 00 00       	push   $0x9c
80105f9d:	e9 ab f5 ff ff       	jmp    8010554d <alltraps>

80105fa2 <vector157>:
80105fa2:	6a 00                	push   $0x0
80105fa4:	68 9d 00 00 00       	push   $0x9d
80105fa9:	e9 9f f5 ff ff       	jmp    8010554d <alltraps>

80105fae <vector158>:
80105fae:	6a 00                	push   $0x0
80105fb0:	68 9e 00 00 00       	push   $0x9e
80105fb5:	e9 93 f5 ff ff       	jmp    8010554d <alltraps>

80105fba <vector159>:
80105fba:	6a 00                	push   $0x0
80105fbc:	68 9f 00 00 00       	push   $0x9f
80105fc1:	e9 87 f5 ff ff       	jmp    8010554d <alltraps>

80105fc6 <vector160>:
80105fc6:	6a 00                	push   $0x0
80105fc8:	68 a0 00 00 00       	push   $0xa0
80105fcd:	e9 7b f5 ff ff       	jmp    8010554d <alltraps>

80105fd2 <vector161>:
80105fd2:	6a 00                	push   $0x0
80105fd4:	68 a1 00 00 00       	push   $0xa1
80105fd9:	e9 6f f5 ff ff       	jmp    8010554d <alltraps>

80105fde <vector162>:
80105fde:	6a 00                	push   $0x0
80105fe0:	68 a2 00 00 00       	push   $0xa2
80105fe5:	e9 63 f5 ff ff       	jmp    8010554d <alltraps>

80105fea <vector163>:
80105fea:	6a 00                	push   $0x0
80105fec:	68 a3 00 00 00       	push   $0xa3
80105ff1:	e9 57 f5 ff ff       	jmp    8010554d <alltraps>

80105ff6 <vector164>:
80105ff6:	6a 00                	push   $0x0
80105ff8:	68 a4 00 00 00       	push   $0xa4
80105ffd:	e9 4b f5 ff ff       	jmp    8010554d <alltraps>

80106002 <vector165>:
80106002:	6a 00                	push   $0x0
80106004:	68 a5 00 00 00       	push   $0xa5
80106009:	e9 3f f5 ff ff       	jmp    8010554d <alltraps>

8010600e <vector166>:
8010600e:	6a 00                	push   $0x0
80106010:	68 a6 00 00 00       	push   $0xa6
80106015:	e9 33 f5 ff ff       	jmp    8010554d <alltraps>

8010601a <vector167>:
8010601a:	6a 00                	push   $0x0
8010601c:	68 a7 00 00 00       	push   $0xa7
80106021:	e9 27 f5 ff ff       	jmp    8010554d <alltraps>

80106026 <vector168>:
80106026:	6a 00                	push   $0x0
80106028:	68 a8 00 00 00       	push   $0xa8
8010602d:	e9 1b f5 ff ff       	jmp    8010554d <alltraps>

80106032 <vector169>:
80106032:	6a 00                	push   $0x0
80106034:	68 a9 00 00 00       	push   $0xa9
80106039:	e9 0f f5 ff ff       	jmp    8010554d <alltraps>

8010603e <vector170>:
8010603e:	6a 00                	push   $0x0
80106040:	68 aa 00 00 00       	push   $0xaa
80106045:	e9 03 f5 ff ff       	jmp    8010554d <alltraps>

8010604a <vector171>:
8010604a:	6a 00                	push   $0x0
8010604c:	68 ab 00 00 00       	push   $0xab
80106051:	e9 f7 f4 ff ff       	jmp    8010554d <alltraps>

80106056 <vector172>:
80106056:	6a 00                	push   $0x0
80106058:	68 ac 00 00 00       	push   $0xac
8010605d:	e9 eb f4 ff ff       	jmp    8010554d <alltraps>

80106062 <vector173>:
80106062:	6a 00                	push   $0x0
80106064:	68 ad 00 00 00       	push   $0xad
80106069:	e9 df f4 ff ff       	jmp    8010554d <alltraps>

8010606e <vector174>:
8010606e:	6a 00                	push   $0x0
80106070:	68 ae 00 00 00       	push   $0xae
80106075:	e9 d3 f4 ff ff       	jmp    8010554d <alltraps>

8010607a <vector175>:
8010607a:	6a 00                	push   $0x0
8010607c:	68 af 00 00 00       	push   $0xaf
80106081:	e9 c7 f4 ff ff       	jmp    8010554d <alltraps>

80106086 <vector176>:
80106086:	6a 00                	push   $0x0
80106088:	68 b0 00 00 00       	push   $0xb0
8010608d:	e9 bb f4 ff ff       	jmp    8010554d <alltraps>

80106092 <vector177>:
80106092:	6a 00                	push   $0x0
80106094:	68 b1 00 00 00       	push   $0xb1
80106099:	e9 af f4 ff ff       	jmp    8010554d <alltraps>

8010609e <vector178>:
8010609e:	6a 00                	push   $0x0
801060a0:	68 b2 00 00 00       	push   $0xb2
801060a5:	e9 a3 f4 ff ff       	jmp    8010554d <alltraps>

801060aa <vector179>:
801060aa:	6a 00                	push   $0x0
801060ac:	68 b3 00 00 00       	push   $0xb3
801060b1:	e9 97 f4 ff ff       	jmp    8010554d <alltraps>

801060b6 <vector180>:
801060b6:	6a 00                	push   $0x0
801060b8:	68 b4 00 00 00       	push   $0xb4
801060bd:	e9 8b f4 ff ff       	jmp    8010554d <alltraps>

801060c2 <vector181>:
801060c2:	6a 00                	push   $0x0
801060c4:	68 b5 00 00 00       	push   $0xb5
801060c9:	e9 7f f4 ff ff       	jmp    8010554d <alltraps>

801060ce <vector182>:
801060ce:	6a 00                	push   $0x0
801060d0:	68 b6 00 00 00       	push   $0xb6
801060d5:	e9 73 f4 ff ff       	jmp    8010554d <alltraps>

801060da <vector183>:
801060da:	6a 00                	push   $0x0
801060dc:	68 b7 00 00 00       	push   $0xb7
801060e1:	e9 67 f4 ff ff       	jmp    8010554d <alltraps>

801060e6 <vector184>:
801060e6:	6a 00                	push   $0x0
801060e8:	68 b8 00 00 00       	push   $0xb8
801060ed:	e9 5b f4 ff ff       	jmp    8010554d <alltraps>

801060f2 <vector185>:
801060f2:	6a 00                	push   $0x0
801060f4:	68 b9 00 00 00       	push   $0xb9
801060f9:	e9 4f f4 ff ff       	jmp    8010554d <alltraps>

801060fe <vector186>:
801060fe:	6a 00                	push   $0x0
80106100:	68 ba 00 00 00       	push   $0xba
80106105:	e9 43 f4 ff ff       	jmp    8010554d <alltraps>

8010610a <vector187>:
8010610a:	6a 00                	push   $0x0
8010610c:	68 bb 00 00 00       	push   $0xbb
80106111:	e9 37 f4 ff ff       	jmp    8010554d <alltraps>

80106116 <vector188>:
80106116:	6a 00                	push   $0x0
80106118:	68 bc 00 00 00       	push   $0xbc
8010611d:	e9 2b f4 ff ff       	jmp    8010554d <alltraps>

80106122 <vector189>:
80106122:	6a 00                	push   $0x0
80106124:	68 bd 00 00 00       	push   $0xbd
80106129:	e9 1f f4 ff ff       	jmp    8010554d <alltraps>

8010612e <vector190>:
8010612e:	6a 00                	push   $0x0
80106130:	68 be 00 00 00       	push   $0xbe
80106135:	e9 13 f4 ff ff       	jmp    8010554d <alltraps>

8010613a <vector191>:
8010613a:	6a 00                	push   $0x0
8010613c:	68 bf 00 00 00       	push   $0xbf
80106141:	e9 07 f4 ff ff       	jmp    8010554d <alltraps>

80106146 <vector192>:
80106146:	6a 00                	push   $0x0
80106148:	68 c0 00 00 00       	push   $0xc0
8010614d:	e9 fb f3 ff ff       	jmp    8010554d <alltraps>

80106152 <vector193>:
80106152:	6a 00                	push   $0x0
80106154:	68 c1 00 00 00       	push   $0xc1
80106159:	e9 ef f3 ff ff       	jmp    8010554d <alltraps>

8010615e <vector194>:
8010615e:	6a 00                	push   $0x0
80106160:	68 c2 00 00 00       	push   $0xc2
80106165:	e9 e3 f3 ff ff       	jmp    8010554d <alltraps>

8010616a <vector195>:
8010616a:	6a 00                	push   $0x0
8010616c:	68 c3 00 00 00       	push   $0xc3
80106171:	e9 d7 f3 ff ff       	jmp    8010554d <alltraps>

80106176 <vector196>:
80106176:	6a 00                	push   $0x0
80106178:	68 c4 00 00 00       	push   $0xc4
8010617d:	e9 cb f3 ff ff       	jmp    8010554d <alltraps>

80106182 <vector197>:
80106182:	6a 00                	push   $0x0
80106184:	68 c5 00 00 00       	push   $0xc5
80106189:	e9 bf f3 ff ff       	jmp    8010554d <alltraps>

8010618e <vector198>:
8010618e:	6a 00                	push   $0x0
80106190:	68 c6 00 00 00       	push   $0xc6
80106195:	e9 b3 f3 ff ff       	jmp    8010554d <alltraps>

8010619a <vector199>:
8010619a:	6a 00                	push   $0x0
8010619c:	68 c7 00 00 00       	push   $0xc7
801061a1:	e9 a7 f3 ff ff       	jmp    8010554d <alltraps>

801061a6 <vector200>:
801061a6:	6a 00                	push   $0x0
801061a8:	68 c8 00 00 00       	push   $0xc8
801061ad:	e9 9b f3 ff ff       	jmp    8010554d <alltraps>

801061b2 <vector201>:
801061b2:	6a 00                	push   $0x0
801061b4:	68 c9 00 00 00       	push   $0xc9
801061b9:	e9 8f f3 ff ff       	jmp    8010554d <alltraps>

801061be <vector202>:
801061be:	6a 00                	push   $0x0
801061c0:	68 ca 00 00 00       	push   $0xca
801061c5:	e9 83 f3 ff ff       	jmp    8010554d <alltraps>

801061ca <vector203>:
801061ca:	6a 00                	push   $0x0
801061cc:	68 cb 00 00 00       	push   $0xcb
801061d1:	e9 77 f3 ff ff       	jmp    8010554d <alltraps>

801061d6 <vector204>:
801061d6:	6a 00                	push   $0x0
801061d8:	68 cc 00 00 00       	push   $0xcc
801061dd:	e9 6b f3 ff ff       	jmp    8010554d <alltraps>

801061e2 <vector205>:
801061e2:	6a 00                	push   $0x0
801061e4:	68 cd 00 00 00       	push   $0xcd
801061e9:	e9 5f f3 ff ff       	jmp    8010554d <alltraps>

801061ee <vector206>:
801061ee:	6a 00                	push   $0x0
801061f0:	68 ce 00 00 00       	push   $0xce
801061f5:	e9 53 f3 ff ff       	jmp    8010554d <alltraps>

801061fa <vector207>:
801061fa:	6a 00                	push   $0x0
801061fc:	68 cf 00 00 00       	push   $0xcf
80106201:	e9 47 f3 ff ff       	jmp    8010554d <alltraps>

80106206 <vector208>:
80106206:	6a 00                	push   $0x0
80106208:	68 d0 00 00 00       	push   $0xd0
8010620d:	e9 3b f3 ff ff       	jmp    8010554d <alltraps>

80106212 <vector209>:
80106212:	6a 00                	push   $0x0
80106214:	68 d1 00 00 00       	push   $0xd1
80106219:	e9 2f f3 ff ff       	jmp    8010554d <alltraps>

8010621e <vector210>:
8010621e:	6a 00                	push   $0x0
80106220:	68 d2 00 00 00       	push   $0xd2
80106225:	e9 23 f3 ff ff       	jmp    8010554d <alltraps>

8010622a <vector211>:
8010622a:	6a 00                	push   $0x0
8010622c:	68 d3 00 00 00       	push   $0xd3
80106231:	e9 17 f3 ff ff       	jmp    8010554d <alltraps>

80106236 <vector212>:
80106236:	6a 00                	push   $0x0
80106238:	68 d4 00 00 00       	push   $0xd4
8010623d:	e9 0b f3 ff ff       	jmp    8010554d <alltraps>

80106242 <vector213>:
80106242:	6a 00                	push   $0x0
80106244:	68 d5 00 00 00       	push   $0xd5
80106249:	e9 ff f2 ff ff       	jmp    8010554d <alltraps>

8010624e <vector214>:
8010624e:	6a 00                	push   $0x0
80106250:	68 d6 00 00 00       	push   $0xd6
80106255:	e9 f3 f2 ff ff       	jmp    8010554d <alltraps>

8010625a <vector215>:
8010625a:	6a 00                	push   $0x0
8010625c:	68 d7 00 00 00       	push   $0xd7
80106261:	e9 e7 f2 ff ff       	jmp    8010554d <alltraps>

80106266 <vector216>:
80106266:	6a 00                	push   $0x0
80106268:	68 d8 00 00 00       	push   $0xd8
8010626d:	e9 db f2 ff ff       	jmp    8010554d <alltraps>

80106272 <vector217>:
80106272:	6a 00                	push   $0x0
80106274:	68 d9 00 00 00       	push   $0xd9
80106279:	e9 cf f2 ff ff       	jmp    8010554d <alltraps>

8010627e <vector218>:
8010627e:	6a 00                	push   $0x0
80106280:	68 da 00 00 00       	push   $0xda
80106285:	e9 c3 f2 ff ff       	jmp    8010554d <alltraps>

8010628a <vector219>:
8010628a:	6a 00                	push   $0x0
8010628c:	68 db 00 00 00       	push   $0xdb
80106291:	e9 b7 f2 ff ff       	jmp    8010554d <alltraps>

80106296 <vector220>:
80106296:	6a 00                	push   $0x0
80106298:	68 dc 00 00 00       	push   $0xdc
8010629d:	e9 ab f2 ff ff       	jmp    8010554d <alltraps>

801062a2 <vector221>:
801062a2:	6a 00                	push   $0x0
801062a4:	68 dd 00 00 00       	push   $0xdd
801062a9:	e9 9f f2 ff ff       	jmp    8010554d <alltraps>

801062ae <vector222>:
801062ae:	6a 00                	push   $0x0
801062b0:	68 de 00 00 00       	push   $0xde
801062b5:	e9 93 f2 ff ff       	jmp    8010554d <alltraps>

801062ba <vector223>:
801062ba:	6a 00                	push   $0x0
801062bc:	68 df 00 00 00       	push   $0xdf
801062c1:	e9 87 f2 ff ff       	jmp    8010554d <alltraps>

801062c6 <vector224>:
801062c6:	6a 00                	push   $0x0
801062c8:	68 e0 00 00 00       	push   $0xe0
801062cd:	e9 7b f2 ff ff       	jmp    8010554d <alltraps>

801062d2 <vector225>:
801062d2:	6a 00                	push   $0x0
801062d4:	68 e1 00 00 00       	push   $0xe1
801062d9:	e9 6f f2 ff ff       	jmp    8010554d <alltraps>

801062de <vector226>:
801062de:	6a 00                	push   $0x0
801062e0:	68 e2 00 00 00       	push   $0xe2
801062e5:	e9 63 f2 ff ff       	jmp    8010554d <alltraps>

801062ea <vector227>:
801062ea:	6a 00                	push   $0x0
801062ec:	68 e3 00 00 00       	push   $0xe3
801062f1:	e9 57 f2 ff ff       	jmp    8010554d <alltraps>

801062f6 <vector228>:
801062f6:	6a 00                	push   $0x0
801062f8:	68 e4 00 00 00       	push   $0xe4
801062fd:	e9 4b f2 ff ff       	jmp    8010554d <alltraps>

80106302 <vector229>:
80106302:	6a 00                	push   $0x0
80106304:	68 e5 00 00 00       	push   $0xe5
80106309:	e9 3f f2 ff ff       	jmp    8010554d <alltraps>

8010630e <vector230>:
8010630e:	6a 00                	push   $0x0
80106310:	68 e6 00 00 00       	push   $0xe6
80106315:	e9 33 f2 ff ff       	jmp    8010554d <alltraps>

8010631a <vector231>:
8010631a:	6a 00                	push   $0x0
8010631c:	68 e7 00 00 00       	push   $0xe7
80106321:	e9 27 f2 ff ff       	jmp    8010554d <alltraps>

80106326 <vector232>:
80106326:	6a 00                	push   $0x0
80106328:	68 e8 00 00 00       	push   $0xe8
8010632d:	e9 1b f2 ff ff       	jmp    8010554d <alltraps>

80106332 <vector233>:
80106332:	6a 00                	push   $0x0
80106334:	68 e9 00 00 00       	push   $0xe9
80106339:	e9 0f f2 ff ff       	jmp    8010554d <alltraps>

8010633e <vector234>:
8010633e:	6a 00                	push   $0x0
80106340:	68 ea 00 00 00       	push   $0xea
80106345:	e9 03 f2 ff ff       	jmp    8010554d <alltraps>

8010634a <vector235>:
8010634a:	6a 00                	push   $0x0
8010634c:	68 eb 00 00 00       	push   $0xeb
80106351:	e9 f7 f1 ff ff       	jmp    8010554d <alltraps>

80106356 <vector236>:
80106356:	6a 00                	push   $0x0
80106358:	68 ec 00 00 00       	push   $0xec
8010635d:	e9 eb f1 ff ff       	jmp    8010554d <alltraps>

80106362 <vector237>:
80106362:	6a 00                	push   $0x0
80106364:	68 ed 00 00 00       	push   $0xed
80106369:	e9 df f1 ff ff       	jmp    8010554d <alltraps>

8010636e <vector238>:
8010636e:	6a 00                	push   $0x0
80106370:	68 ee 00 00 00       	push   $0xee
80106375:	e9 d3 f1 ff ff       	jmp    8010554d <alltraps>

8010637a <vector239>:
8010637a:	6a 00                	push   $0x0
8010637c:	68 ef 00 00 00       	push   $0xef
80106381:	e9 c7 f1 ff ff       	jmp    8010554d <alltraps>

80106386 <vector240>:
80106386:	6a 00                	push   $0x0
80106388:	68 f0 00 00 00       	push   $0xf0
8010638d:	e9 bb f1 ff ff       	jmp    8010554d <alltraps>

80106392 <vector241>:
80106392:	6a 00                	push   $0x0
80106394:	68 f1 00 00 00       	push   $0xf1
80106399:	e9 af f1 ff ff       	jmp    8010554d <alltraps>

8010639e <vector242>:
8010639e:	6a 00                	push   $0x0
801063a0:	68 f2 00 00 00       	push   $0xf2
801063a5:	e9 a3 f1 ff ff       	jmp    8010554d <alltraps>

801063aa <vector243>:
801063aa:	6a 00                	push   $0x0
801063ac:	68 f3 00 00 00       	push   $0xf3
801063b1:	e9 97 f1 ff ff       	jmp    8010554d <alltraps>

801063b6 <vector244>:
801063b6:	6a 00                	push   $0x0
801063b8:	68 f4 00 00 00       	push   $0xf4
801063bd:	e9 8b f1 ff ff       	jmp    8010554d <alltraps>

801063c2 <vector245>:
801063c2:	6a 00                	push   $0x0
801063c4:	68 f5 00 00 00       	push   $0xf5
801063c9:	e9 7f f1 ff ff       	jmp    8010554d <alltraps>

801063ce <vector246>:
801063ce:	6a 00                	push   $0x0
801063d0:	68 f6 00 00 00       	push   $0xf6
801063d5:	e9 73 f1 ff ff       	jmp    8010554d <alltraps>

801063da <vector247>:
801063da:	6a 00                	push   $0x0
801063dc:	68 f7 00 00 00       	push   $0xf7
801063e1:	e9 67 f1 ff ff       	jmp    8010554d <alltraps>

801063e6 <vector248>:
801063e6:	6a 00                	push   $0x0
801063e8:	68 f8 00 00 00       	push   $0xf8
801063ed:	e9 5b f1 ff ff       	jmp    8010554d <alltraps>

801063f2 <vector249>:
801063f2:	6a 00                	push   $0x0
801063f4:	68 f9 00 00 00       	push   $0xf9
801063f9:	e9 4f f1 ff ff       	jmp    8010554d <alltraps>

801063fe <vector250>:
801063fe:	6a 00                	push   $0x0
80106400:	68 fa 00 00 00       	push   $0xfa
80106405:	e9 43 f1 ff ff       	jmp    8010554d <alltraps>

8010640a <vector251>:
8010640a:	6a 00                	push   $0x0
8010640c:	68 fb 00 00 00       	push   $0xfb
80106411:	e9 37 f1 ff ff       	jmp    8010554d <alltraps>

80106416 <vector252>:
80106416:	6a 00                	push   $0x0
80106418:	68 fc 00 00 00       	push   $0xfc
8010641d:	e9 2b f1 ff ff       	jmp    8010554d <alltraps>

80106422 <vector253>:
80106422:	6a 00                	push   $0x0
80106424:	68 fd 00 00 00       	push   $0xfd
80106429:	e9 1f f1 ff ff       	jmp    8010554d <alltraps>

8010642e <vector254>:
8010642e:	6a 00                	push   $0x0
80106430:	68 fe 00 00 00       	push   $0xfe
80106435:	e9 13 f1 ff ff       	jmp    8010554d <alltraps>

8010643a <vector255>:
8010643a:	6a 00                	push   $0x0
8010643c:	68 ff 00 00 00       	push   $0xff
80106441:	e9 07 f1 ff ff       	jmp    8010554d <alltraps>
80106446:	66 90                	xchg   %ax,%ax
80106448:	66 90                	xchg   %ax,%ax
8010644a:	66 90                	xchg   %ax,%ax
8010644c:	66 90                	xchg   %ax,%ax
8010644e:	66 90                	xchg   %ax,%ax

80106450 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	57                   	push   %edi
80106454:	56                   	push   %esi
80106455:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106457:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010645a:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010645b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010645e:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106461:	8b 1f                	mov    (%edi),%ebx
80106463:	f6 c3 01             	test   $0x1,%bl
80106466:	74 28                	je     80106490 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106468:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010646e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106474:	c1 ee 0a             	shr    $0xa,%esi
}
80106477:	83 c4 1c             	add    $0x1c,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
8010647a:	89 f2                	mov    %esi,%edx
8010647c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106482:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106485:	5b                   	pop    %ebx
80106486:	5e                   	pop    %esi
80106487:	5f                   	pop    %edi
80106488:	5d                   	pop    %ebp
80106489:	c3                   	ret    
8010648a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106490:	85 c9                	test   %ecx,%ecx
80106492:	74 34                	je     801064c8 <walkpgdir+0x78>
80106494:	e8 f7 c0 ff ff       	call   80102590 <kalloc>
80106499:	85 c0                	test   %eax,%eax
8010649b:	89 c3                	mov    %eax,%ebx
8010649d:	74 29                	je     801064c8 <walkpgdir+0x78>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010649f:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801064a6:	00 
801064a7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801064ae:	00 
801064af:	89 04 24             	mov    %eax,(%esp)
801064b2:	e8 c9 de ff ff       	call   80104380 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801064b7:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801064bd:	83 c8 07             	or     $0x7,%eax
801064c0:	89 07                	mov    %eax,(%edi)
801064c2:	eb b0                	jmp    80106474 <walkpgdir+0x24>
801064c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
801064c8:	83 c4 1c             	add    $0x1c,%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801064cb:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801064cd:	5b                   	pop    %ebx
801064ce:	5e                   	pop    %esi
801064cf:	5f                   	pop    %edi
801064d0:	5d                   	pop    %ebp
801064d1:	c3                   	ret    
801064d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064e0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	57                   	push   %edi
801064e4:	56                   	push   %esi
801064e5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801064e6:	89 d3                	mov    %edx,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064e8:	83 ec 1c             	sub    $0x1c,%esp
801064eb:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801064ee:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801064f7:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801064fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801064fe:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106502:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
80106509:	29 df                	sub    %ebx,%edi
8010650b:	eb 18                	jmp    80106525 <mappages+0x45>
8010650d:	8d 76 00             	lea    0x0(%esi),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106510:	f6 00 01             	testb  $0x1,(%eax)
80106513:	75 3d                	jne    80106552 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106515:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
80106518:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010651b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010651d:	74 29                	je     80106548 <mappages+0x68>
      break;
    a += PGSIZE;
8010651f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106525:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106528:	b9 01 00 00 00       	mov    $0x1,%ecx
8010652d:	89 da                	mov    %ebx,%edx
8010652f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106532:	e8 19 ff ff ff       	call   80106450 <walkpgdir>
80106537:	85 c0                	test   %eax,%eax
80106539:	75 d5                	jne    80106510 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010653b:	83 c4 1c             	add    $0x1c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010653e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106543:	5b                   	pop    %ebx
80106544:	5e                   	pop    %esi
80106545:	5f                   	pop    %edi
80106546:	5d                   	pop    %ebp
80106547:	c3                   	ret    
80106548:	83 c4 1c             	add    $0x1c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
8010654b:	31 c0                	xor    %eax,%eax
}
8010654d:	5b                   	pop    %ebx
8010654e:	5e                   	pop    %esi
8010654f:	5f                   	pop    %edi
80106550:	5d                   	pop    %ebp
80106551:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106552:	c7 04 24 28 76 10 80 	movl   $0x80107628,(%esp)
80106559:	e8 02 9e ff ff       	call   80100360 <panic>
8010655e:	66 90                	xchg   %ax,%ax

80106560 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106560:	55                   	push   %ebp
80106561:	89 e5                	mov    %esp,%ebp
80106563:	57                   	push   %edi
80106564:	89 c7                	mov    %eax,%edi
80106566:	56                   	push   %esi
80106567:	89 d6                	mov    %edx,%esi
80106569:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010656a:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106570:	83 ec 1c             	sub    $0x1c,%esp
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106573:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106579:	39 d3                	cmp    %edx,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010657b:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010657e:	72 3b                	jb     801065bb <deallocuvm.part.0+0x5b>
80106580:	eb 5e                	jmp    801065e0 <deallocuvm.part.0+0x80>
80106582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106588:	8b 10                	mov    (%eax),%edx
8010658a:	f6 c2 01             	test   $0x1,%dl
8010658d:	74 22                	je     801065b1 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010658f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106595:	74 54                	je     801065eb <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80106597:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
8010659d:	89 14 24             	mov    %edx,(%esp)
801065a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801065a3:	e8 38 be ff ff       	call   801023e0 <kfree>
      *pte = 0;
801065a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801065ab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801065b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801065b7:	39 f3                	cmp    %esi,%ebx
801065b9:	73 25                	jae    801065e0 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
801065bb:	31 c9                	xor    %ecx,%ecx
801065bd:	89 da                	mov    %ebx,%edx
801065bf:	89 f8                	mov    %edi,%eax
801065c1:	e8 8a fe ff ff       	call   80106450 <walkpgdir>
    if(!pte)
801065c6:	85 c0                	test   %eax,%eax
801065c8:	75 be                	jne    80106588 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801065ca:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801065d0:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801065d6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801065dc:	39 f3                	cmp    %esi,%ebx
801065de:	72 db                	jb     801065bb <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801065e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801065e3:	83 c4 1c             	add    $0x1c,%esp
801065e6:	5b                   	pop    %ebx
801065e7:	5e                   	pop    %esi
801065e8:	5f                   	pop    %edi
801065e9:	5d                   	pop    %ebp
801065ea:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
801065eb:	c7 04 24 c6 6f 10 80 	movl   $0x80106fc6,(%esp)
801065f2:	e8 69 9d ff ff       	call   80100360 <panic>
801065f7:	89 f6                	mov    %esi,%esi
801065f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106600 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106606:	e8 55 d1 ff ff       	call   80103760 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010660b:	31 c9                	xor    %ecx,%ecx
8010660d:	ba ff ff ff ff       	mov    $0xffffffff,%edx

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106612:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106618:	05 80 27 11 80       	add    $0x80112780,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010661d:	66 89 50 78          	mov    %dx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106621:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  lgdt(c->gdt, sizeof(c->gdt));
80106626:	83 c0 70             	add    $0x70,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106629:	66 89 48 0a          	mov    %cx,0xa(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010662d:	31 c9                	xor    %ecx,%ecx
8010662f:	66 89 50 10          	mov    %dx,0x10(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106633:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106638:	66 89 48 12          	mov    %cx,0x12(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010663c:	31 c9                	xor    %ecx,%ecx
8010663e:	66 89 50 18          	mov    %dx,0x18(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106642:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106647:	66 89 48 1a          	mov    %cx,0x1a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010664b:	31 c9                	xor    %ecx,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010664d:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
80106651:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106655:	c6 40 15 92          	movb   $0x92,0x15(%eax)
80106659:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010665d:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
80106661:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106665:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
80106669:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
8010666d:	66 89 50 20          	mov    %dx,0x20(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106671:	ba 2f 00 00 00       	mov    $0x2f,%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106676:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
8010667a:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010667e:	c6 40 14 00          	movb   $0x0,0x14(%eax)
80106682:	c6 40 17 00          	movb   $0x0,0x17(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106686:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
8010668a:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010668e:	66 89 48 22          	mov    %cx,0x22(%eax)
80106692:	c6 40 24 00          	movb   $0x0,0x24(%eax)
80106696:	c6 40 27 00          	movb   $0x0,0x27(%eax)
8010669a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
8010669e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801066a2:	c1 e8 10             	shr    $0x10,%eax
801066a5:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801066a9:	8d 45 f2             	lea    -0xe(%ebp),%eax
801066ac:	0f 01 10             	lgdtl  (%eax)
  lgdt(c->gdt, sizeof(c->gdt));
}
801066af:	c9                   	leave  
801066b0:	c3                   	ret    
801066b1:	eb 0d                	jmp    801066c0 <switchkvm>
801066b3:	90                   	nop
801066b4:	90                   	nop
801066b5:	90                   	nop
801066b6:	90                   	nop
801066b7:	90                   	nop
801066b8:	90                   	nop
801066b9:	90                   	nop
801066ba:	90                   	nop
801066bb:	90                   	nop
801066bc:	90                   	nop
801066bd:	90                   	nop
801066be:	90                   	nop
801066bf:	90                   	nop

801066c0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801066c0:	a1 a4 54 11 80       	mov    0x801154a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801066c5:	55                   	push   %ebp
801066c6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801066c8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801066cd:	0f 22 d8             	mov    %eax,%cr3
}
801066d0:	5d                   	pop    %ebp
801066d1:	c3                   	ret    
801066d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066e0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801066e0:	55                   	push   %ebp
801066e1:	89 e5                	mov    %esp,%ebp
801066e3:	57                   	push   %edi
801066e4:	56                   	push   %esi
801066e5:	53                   	push   %ebx
801066e6:	83 ec 1c             	sub    $0x1c,%esp
801066e9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801066ec:	85 f6                	test   %esi,%esi
801066ee:	0f 84 cd 00 00 00    	je     801067c1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
801066f4:	8b 46 08             	mov    0x8(%esi),%eax
801066f7:	85 c0                	test   %eax,%eax
801066f9:	0f 84 da 00 00 00    	je     801067d9 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
801066ff:	8b 7e 04             	mov    0x4(%esi),%edi
80106702:	85 ff                	test   %edi,%edi
80106704:	0f 84 c3 00 00 00    	je     801067cd <switchuvm+0xed>
    panic("switchuvm: no pgdir");

  pushcli();
8010670a:	e8 c1 da ff ff       	call   801041d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010670f:	e8 cc cf ff ff       	call   801036e0 <mycpu>
80106714:	89 c3                	mov    %eax,%ebx
80106716:	e8 c5 cf ff ff       	call   801036e0 <mycpu>
8010671b:	89 c7                	mov    %eax,%edi
8010671d:	e8 be cf ff ff       	call   801036e0 <mycpu>
80106722:	83 c7 08             	add    $0x8,%edi
80106725:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106728:	e8 b3 cf ff ff       	call   801036e0 <mycpu>
8010672d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106730:	ba 67 00 00 00       	mov    $0x67,%edx
80106735:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
8010673c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106743:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
8010674a:	83 c1 08             	add    $0x8,%ecx
8010674d:	c1 e9 10             	shr    $0x10,%ecx
80106750:	83 c0 08             	add    $0x8,%eax
80106753:	c1 e8 18             	shr    $0x18,%eax
80106756:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010675c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106763:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106769:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
8010676e:	e8 6d cf ff ff       	call   801036e0 <mycpu>
80106773:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010677a:	e8 61 cf ff ff       	call   801036e0 <mycpu>
8010677f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106784:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106788:	e8 53 cf ff ff       	call   801036e0 <mycpu>
8010678d:	8b 56 08             	mov    0x8(%esi),%edx
80106790:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106796:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106799:	e8 42 cf ff ff       	call   801036e0 <mycpu>
8010679e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801067a2:	b8 28 00 00 00       	mov    $0x28,%eax
801067a7:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
801067aa:	8b 46 04             	mov    0x4(%esi),%eax
801067ad:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801067b2:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
801067b5:	83 c4 1c             	add    $0x1c,%esp
801067b8:	5b                   	pop    %ebx
801067b9:	5e                   	pop    %esi
801067ba:	5f                   	pop    %edi
801067bb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801067bc:	e9 4f da ff ff       	jmp    80104210 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
801067c1:	c7 04 24 2e 76 10 80 	movl   $0x8010762e,(%esp)
801067c8:	e8 93 9b ff ff       	call   80100360 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
801067cd:	c7 04 24 59 76 10 80 	movl   $0x80107659,(%esp)
801067d4:	e8 87 9b ff ff       	call   80100360 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
801067d9:	c7 04 24 44 76 10 80 	movl   $0x80107644,(%esp)
801067e0:	e8 7b 9b ff ff       	call   80100360 <panic>
801067e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067f0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801067f0:	55                   	push   %ebp
801067f1:	89 e5                	mov    %esp,%ebp
801067f3:	57                   	push   %edi
801067f4:	56                   	push   %esi
801067f5:	53                   	push   %ebx
801067f6:	83 ec 1c             	sub    $0x1c,%esp
801067f9:	8b 75 10             	mov    0x10(%ebp),%esi
801067fc:	8b 45 08             	mov    0x8(%ebp),%eax
801067ff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106802:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106808:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
8010680b:	77 54                	ja     80106861 <inituvm+0x71>
    panic("inituvm: more than a page");
  mem = kalloc();
8010680d:	e8 7e bd ff ff       	call   80102590 <kalloc>
  memset(mem, 0, PGSIZE);
80106812:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106819:	00 
8010681a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106821:	00 
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106822:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106824:	89 04 24             	mov    %eax,(%esp)
80106827:	e8 54 db ff ff       	call   80104380 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
8010682c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106832:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106837:	89 04 24             	mov    %eax,(%esp)
8010683a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010683d:	31 d2                	xor    %edx,%edx
8010683f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106846:	00 
80106847:	e8 94 fc ff ff       	call   801064e0 <mappages>
  memmove(mem, init, sz);
8010684c:	89 75 10             	mov    %esi,0x10(%ebp)
8010684f:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106852:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106855:	83 c4 1c             	add    $0x1c,%esp
80106858:	5b                   	pop    %ebx
80106859:	5e                   	pop    %esi
8010685a:	5f                   	pop    %edi
8010685b:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
8010685c:	e9 bf db ff ff       	jmp    80104420 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106861:	c7 04 24 6d 76 10 80 	movl   $0x8010766d,(%esp)
80106868:	e8 f3 9a ff ff       	call   80100360 <panic>
8010686d:	8d 76 00             	lea    0x0(%esi),%esi

80106870 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	57                   	push   %edi
80106874:	56                   	push   %esi
80106875:	53                   	push   %ebx
80106876:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106879:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106880:	0f 85 98 00 00 00    	jne    8010691e <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106886:	8b 75 18             	mov    0x18(%ebp),%esi
80106889:	31 db                	xor    %ebx,%ebx
8010688b:	85 f6                	test   %esi,%esi
8010688d:	75 1a                	jne    801068a9 <loaduvm+0x39>
8010688f:	eb 77                	jmp    80106908 <loaduvm+0x98>
80106891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106898:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010689e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801068a4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801068a7:	76 5f                	jbe    80106908 <loaduvm+0x98>
801068a9:	8b 55 0c             	mov    0xc(%ebp),%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801068ac:	31 c9                	xor    %ecx,%ecx
801068ae:	8b 45 08             	mov    0x8(%ebp),%eax
801068b1:	01 da                	add    %ebx,%edx
801068b3:	e8 98 fb ff ff       	call   80106450 <walkpgdir>
801068b8:	85 c0                	test   %eax,%eax
801068ba:	74 56                	je     80106912 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801068bc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
801068be:	bf 00 10 00 00       	mov    $0x1000,%edi
801068c3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801068c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
801068cb:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
801068d1:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801068d4:	05 00 00 00 80       	add    $0x80000000,%eax
801068d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801068dd:	8b 45 10             	mov    0x10(%ebp),%eax
801068e0:	01 d9                	add    %ebx,%ecx
801068e2:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801068e6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801068ea:	89 04 24             	mov    %eax,(%esp)
801068ed:	e8 5e b1 ff ff       	call   80101a50 <readi>
801068f2:	39 f8                	cmp    %edi,%eax
801068f4:	74 a2                	je     80106898 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801068f6:	83 c4 1c             	add    $0x1c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
801068f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801068fe:	5b                   	pop    %ebx
801068ff:	5e                   	pop    %esi
80106900:	5f                   	pop    %edi
80106901:	5d                   	pop    %ebp
80106902:	c3                   	ret    
80106903:	90                   	nop
80106904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106908:	83 c4 1c             	add    $0x1c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010690b:	31 c0                	xor    %eax,%eax
}
8010690d:	5b                   	pop    %ebx
8010690e:	5e                   	pop    %esi
8010690f:	5f                   	pop    %edi
80106910:	5d                   	pop    %ebp
80106911:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106912:	c7 04 24 87 76 10 80 	movl   $0x80107687,(%esp)
80106919:	e8 42 9a ff ff       	call   80100360 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
8010691e:	c7 04 24 28 77 10 80 	movl   $0x80107728,(%esp)
80106925:	e8 36 9a ff ff       	call   80100360 <panic>
8010692a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106930 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	57                   	push   %edi
80106934:	56                   	push   %esi
80106935:	53                   	push   %ebx
80106936:	83 ec 1c             	sub    $0x1c,%esp
80106939:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010693c:	85 ff                	test   %edi,%edi
8010693e:	0f 88 7e 00 00 00    	js     801069c2 <allocuvm+0x92>
    return 0;
  if(newsz < oldsz)
80106944:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106947:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010694a:	72 78                	jb     801069c4 <allocuvm+0x94>
    return oldsz;

  a = PGROUNDUP(oldsz);
8010694c:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106952:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106958:	39 df                	cmp    %ebx,%edi
8010695a:	77 4a                	ja     801069a6 <allocuvm+0x76>
8010695c:	eb 72                	jmp    801069d0 <allocuvm+0xa0>
8010695e:	66 90                	xchg   %ax,%ax
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106960:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106967:	00 
80106968:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010696f:	00 
80106970:	89 04 24             	mov    %eax,(%esp)
80106973:	e8 08 da ff ff       	call   80104380 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106978:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010697e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106983:	89 04 24             	mov    %eax,(%esp)
80106986:	8b 45 08             	mov    0x8(%ebp),%eax
80106989:	89 da                	mov    %ebx,%edx
8010698b:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106992:	00 
80106993:	e8 48 fb ff ff       	call   801064e0 <mappages>
80106998:	85 c0                	test   %eax,%eax
8010699a:	78 44                	js     801069e0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
8010699c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069a2:	39 df                	cmp    %ebx,%edi
801069a4:	76 2a                	jbe    801069d0 <allocuvm+0xa0>
    mem = kalloc();
801069a6:	e8 e5 bb ff ff       	call   80102590 <kalloc>
    if(mem == 0){
801069ab:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
801069ad:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801069af:	75 af                	jne    80106960 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
801069b1:	c7 04 24 a5 76 10 80 	movl   $0x801076a5,(%esp)
801069b8:	e8 63 9d ff ff       	call   80100720 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069bd:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801069c0:	77 48                	ja     80106a0a <allocuvm+0xda>
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
801069c2:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
801069c4:	83 c4 1c             	add    $0x1c,%esp
801069c7:	5b                   	pop    %ebx
801069c8:	5e                   	pop    %esi
801069c9:	5f                   	pop    %edi
801069ca:	5d                   	pop    %ebp
801069cb:	c3                   	ret    
801069cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801069d0:	83 c4 1c             	add    $0x1c,%esp
801069d3:	89 f8                	mov    %edi,%eax
801069d5:	5b                   	pop    %ebx
801069d6:	5e                   	pop    %esi
801069d7:	5f                   	pop    %edi
801069d8:	5d                   	pop    %ebp
801069d9:	c3                   	ret    
801069da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
801069e0:	c7 04 24 bd 76 10 80 	movl   $0x801076bd,(%esp)
801069e7:	e8 34 9d ff ff       	call   80100720 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069ec:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801069ef:	76 0d                	jbe    801069fe <allocuvm+0xce>
801069f1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801069f4:	89 fa                	mov    %edi,%edx
801069f6:	8b 45 08             	mov    0x8(%ebp),%eax
801069f9:	e8 62 fb ff ff       	call   80106560 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
801069fe:	89 34 24             	mov    %esi,(%esp)
80106a01:	e8 da b9 ff ff       	call   801023e0 <kfree>
      return 0;
80106a06:	31 c0                	xor    %eax,%eax
80106a08:	eb ba                	jmp    801069c4 <allocuvm+0x94>
80106a0a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106a0d:	89 fa                	mov    %edi,%edx
80106a0f:	8b 45 08             	mov    0x8(%ebp),%eax
80106a12:	e8 49 fb ff ff       	call   80106560 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106a17:	31 c0                	xor    %eax,%eax
80106a19:	eb a9                	jmp    801069c4 <allocuvm+0x94>
80106a1b:	90                   	nop
80106a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a20 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106a29:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106a2c:	39 d1                	cmp    %edx,%ecx
80106a2e:	73 08                	jae    80106a38 <deallocuvm+0x18>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a30:	5d                   	pop    %ebp
80106a31:	e9 2a fb ff ff       	jmp    80106560 <deallocuvm.part.0>
80106a36:	66 90                	xchg   %ax,%ax
80106a38:	89 d0                	mov    %edx,%eax
80106a3a:	5d                   	pop    %ebp
80106a3b:	c3                   	ret    
80106a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a40 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	56                   	push   %esi
80106a44:	53                   	push   %ebx
80106a45:	83 ec 10             	sub    $0x10,%esp
80106a48:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106a4b:	85 f6                	test   %esi,%esi
80106a4d:	74 59                	je     80106aa8 <freevm+0x68>
80106a4f:	31 c9                	xor    %ecx,%ecx
80106a51:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106a56:	89 f0                	mov    %esi,%eax
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106a58:	31 db                	xor    %ebx,%ebx
80106a5a:	e8 01 fb ff ff       	call   80106560 <deallocuvm.part.0>
80106a5f:	eb 12                	jmp    80106a73 <freevm+0x33>
80106a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a68:	83 c3 01             	add    $0x1,%ebx
80106a6b:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106a71:	74 27                	je     80106a9a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106a73:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
80106a76:	f6 c2 01             	test   $0x1,%dl
80106a79:	74 ed                	je     80106a68 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106a7b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106a81:	83 c3 01             	add    $0x1,%ebx
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106a84:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106a8a:	89 14 24             	mov    %edx,(%esp)
80106a8d:	e8 4e b9 ff ff       	call   801023e0 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106a92:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106a98:	75 d9                	jne    80106a73 <freevm+0x33>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106a9a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106a9d:	83 c4 10             	add    $0x10,%esp
80106aa0:	5b                   	pop    %ebx
80106aa1:	5e                   	pop    %esi
80106aa2:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106aa3:	e9 38 b9 ff ff       	jmp    801023e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106aa8:	c7 04 24 d9 76 10 80 	movl   $0x801076d9,(%esp)
80106aaf:	e8 ac 98 ff ff       	call   80100360 <panic>
80106ab4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106aba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ac0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	56                   	push   %esi
80106ac4:	53                   	push   %ebx
80106ac5:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106ac8:	e8 c3 ba ff ff       	call   80102590 <kalloc>
80106acd:	85 c0                	test   %eax,%eax
80106acf:	89 c6                	mov    %eax,%esi
80106ad1:	74 6d                	je     80106b40 <setupkvm+0x80>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106ad3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106ada:	00 
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106adb:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106ae0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106ae7:	00 
80106ae8:	89 04 24             	mov    %eax,(%esp)
80106aeb:	e8 90 d8 ff ff       	call   80104380 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106af0:	8b 53 0c             	mov    0xc(%ebx),%edx
80106af3:	8b 43 04             	mov    0x4(%ebx),%eax
80106af6:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106af9:	89 54 24 04          	mov    %edx,0x4(%esp)
80106afd:	8b 13                	mov    (%ebx),%edx
80106aff:	89 04 24             	mov    %eax,(%esp)
80106b02:	29 c1                	sub    %eax,%ecx
80106b04:	89 f0                	mov    %esi,%eax
80106b06:	e8 d5 f9 ff ff       	call   801064e0 <mappages>
80106b0b:	85 c0                	test   %eax,%eax
80106b0d:	78 19                	js     80106b28 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106b0f:	83 c3 10             	add    $0x10,%ebx
80106b12:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106b18:	72 d6                	jb     80106af0 <setupkvm+0x30>
80106b1a:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106b1c:	83 c4 10             	add    $0x10,%esp
80106b1f:	5b                   	pop    %ebx
80106b20:	5e                   	pop    %esi
80106b21:	5d                   	pop    %ebp
80106b22:	c3                   	ret    
80106b23:	90                   	nop
80106b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106b28:	89 34 24             	mov    %esi,(%esp)
80106b2b:	e8 10 ff ff ff       	call   80106a40 <freevm>
      return 0;
    }
  return pgdir;
}
80106b30:	83 c4 10             	add    $0x10,%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106b33:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106b35:	5b                   	pop    %ebx
80106b36:	5e                   	pop    %esi
80106b37:	5d                   	pop    %ebp
80106b38:	c3                   	ret    
80106b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106b40:	31 c0                	xor    %eax,%eax
80106b42:	eb d8                	jmp    80106b1c <setupkvm+0x5c>
80106b44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106b50 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106b56:	e8 65 ff ff ff       	call   80106ac0 <setupkvm>
80106b5b:	a3 a4 54 11 80       	mov    %eax,0x801154a4
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b60:	05 00 00 00 80       	add    $0x80000000,%eax
80106b65:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
80106b68:	c9                   	leave  
80106b69:	c3                   	ret    
80106b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b70 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b71:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b73:	89 e5                	mov    %esp,%ebp
80106b75:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b78:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b7b:	8b 45 08             	mov    0x8(%ebp),%eax
80106b7e:	e8 cd f8 ff ff       	call   80106450 <walkpgdir>
  if(pte == 0)
80106b83:	85 c0                	test   %eax,%eax
80106b85:	74 05                	je     80106b8c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106b87:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106b8a:	c9                   	leave  
80106b8b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106b8c:	c7 04 24 ea 76 10 80 	movl   $0x801076ea,(%esp)
80106b93:	e8 c8 97 ff ff       	call   80100360 <panic>
80106b98:	90                   	nop
80106b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ba0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	57                   	push   %edi
80106ba4:	56                   	push   %esi
80106ba5:	53                   	push   %ebx
80106ba6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ba9:	e8 12 ff ff ff       	call   80106ac0 <setupkvm>
80106bae:	85 c0                	test   %eax,%eax
80106bb0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106bb3:	0f 84 b9 00 00 00    	je     80106c72 <copyuvm+0xd2>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bbc:	85 c0                	test   %eax,%eax
80106bbe:	0f 84 94 00 00 00    	je     80106c58 <copyuvm+0xb8>
80106bc4:	31 ff                	xor    %edi,%edi
80106bc6:	eb 48                	jmp    80106c10 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106bc8:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106bce:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106bd5:	00 
80106bd6:	89 74 24 04          	mov    %esi,0x4(%esp)
80106bda:	89 04 24             	mov    %eax,(%esp)
80106bdd:	e8 3e d8 ff ff       	call   80104420 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106be2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106be5:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106bea:	89 fa                	mov    %edi,%edx
80106bec:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bf0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106bf6:	89 04 24             	mov    %eax,(%esp)
80106bf9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106bfc:	e8 df f8 ff ff       	call   801064e0 <mappages>
80106c01:	85 c0                	test   %eax,%eax
80106c03:	78 63                	js     80106c68 <copyuvm+0xc8>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106c05:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106c0b:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106c0e:	76 48                	jbe    80106c58 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106c10:	8b 45 08             	mov    0x8(%ebp),%eax
80106c13:	31 c9                	xor    %ecx,%ecx
80106c15:	89 fa                	mov    %edi,%edx
80106c17:	e8 34 f8 ff ff       	call   80106450 <walkpgdir>
80106c1c:	85 c0                	test   %eax,%eax
80106c1e:	74 62                	je     80106c82 <copyuvm+0xe2>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106c20:	8b 00                	mov    (%eax),%eax
80106c22:	a8 01                	test   $0x1,%al
80106c24:	74 50                	je     80106c76 <copyuvm+0xd6>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106c26:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80106c28:	25 ff 0f 00 00       	and    $0xfff,%eax
80106c2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106c30:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106c36:	e8 55 b9 ff ff       	call   80102590 <kalloc>
80106c3b:	85 c0                	test   %eax,%eax
80106c3d:	89 c3                	mov    %eax,%ebx
80106c3f:	75 87                	jne    80106bc8 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80106c41:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c44:	89 04 24             	mov    %eax,(%esp)
80106c47:	e8 f4 fd ff ff       	call   80106a40 <freevm>
  return 0;
80106c4c:	31 c0                	xor    %eax,%eax
}
80106c4e:	83 c4 2c             	add    $0x2c,%esp
80106c51:	5b                   	pop    %ebx
80106c52:	5e                   	pop    %esi
80106c53:	5f                   	pop    %edi
80106c54:	5d                   	pop    %ebp
80106c55:	c3                   	ret    
80106c56:	66 90                	xchg   %ax,%ax
80106c58:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c5b:	83 c4 2c             	add    $0x2c,%esp
80106c5e:	5b                   	pop    %ebx
80106c5f:	5e                   	pop    %esi
80106c60:	5f                   	pop    %edi
80106c61:	5d                   	pop    %ebp
80106c62:	c3                   	ret    
80106c63:	90                   	nop
80106c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80106c68:	89 1c 24             	mov    %ebx,(%esp)
80106c6b:	e8 70 b7 ff ff       	call   801023e0 <kfree>
      goto bad;
80106c70:	eb cf                	jmp    80106c41 <copyuvm+0xa1>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80106c72:	31 c0                	xor    %eax,%eax
80106c74:	eb d8                	jmp    80106c4e <copyuvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106c76:	c7 04 24 0e 77 10 80 	movl   $0x8010770e,(%esp)
80106c7d:	e8 de 96 ff ff       	call   80100360 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106c82:	c7 04 24 f4 76 10 80 	movl   $0x801076f4,(%esp)
80106c89:	e8 d2 96 ff ff       	call   80100360 <panic>
80106c8e:	66 90                	xchg   %ax,%ax

80106c90 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106c90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106c91:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106c93:	89 e5                	mov    %esp,%ebp
80106c95:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106c98:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c9b:	8b 45 08             	mov    0x8(%ebp),%eax
80106c9e:	e8 ad f7 ff ff       	call   80106450 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106ca3:	8b 00                	mov    (%eax),%eax
80106ca5:	89 c2                	mov    %eax,%edx
80106ca7:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
80106caa:	83 fa 05             	cmp    $0x5,%edx
80106cad:	75 11                	jne    80106cc0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106caf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cb4:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106cb9:	c9                   	leave  
80106cba:	c3                   	ret    
80106cbb:	90                   	nop
80106cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80106cc0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80106cc2:	c9                   	leave  
80106cc3:	c3                   	ret    
80106cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106cd0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	57                   	push   %edi
80106cd4:	56                   	push   %esi
80106cd5:	53                   	push   %ebx
80106cd6:	83 ec 1c             	sub    $0x1c,%esp
80106cd9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106cdc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106cdf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ce2:	85 db                	test   %ebx,%ebx
80106ce4:	75 3a                	jne    80106d20 <copyout+0x50>
80106ce6:	eb 68                	jmp    80106d50 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106ce8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106ceb:	89 f2                	mov    %esi,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106ced:	89 7c 24 04          	mov    %edi,0x4(%esp)
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106cf1:	29 ca                	sub    %ecx,%edx
80106cf3:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106cf9:	39 da                	cmp    %ebx,%edx
80106cfb:	0f 47 d3             	cmova  %ebx,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106cfe:	29 f1                	sub    %esi,%ecx
80106d00:	01 c8                	add    %ecx,%eax
80106d02:	89 54 24 08          	mov    %edx,0x8(%esp)
80106d06:	89 04 24             	mov    %eax,(%esp)
80106d09:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106d0c:	e8 0f d7 ff ff       	call   80104420 <memmove>
    len -= n;
    buf += n;
80106d11:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80106d14:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106d1a:	01 d7                	add    %edx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106d1c:	29 d3                	sub    %edx,%ebx
80106d1e:	74 30                	je     80106d50 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
80106d20:	8b 45 08             	mov    0x8(%ebp),%eax
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106d23:	89 ce                	mov    %ecx,%esi
80106d25:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106d2b:	89 74 24 04          	mov    %esi,0x4(%esp)
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106d2f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80106d32:	89 04 24             	mov    %eax,(%esp)
80106d35:	e8 56 ff ff ff       	call   80106c90 <uva2ka>
    if(pa0 == 0)
80106d3a:	85 c0                	test   %eax,%eax
80106d3c:	75 aa                	jne    80106ce8 <copyout+0x18>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106d3e:	83 c4 1c             	add    $0x1c,%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80106d41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106d46:	5b                   	pop    %ebx
80106d47:	5e                   	pop    %esi
80106d48:	5f                   	pop    %edi
80106d49:	5d                   	pop    %ebp
80106d4a:	c3                   	ret    
80106d4b:	90                   	nop
80106d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d50:	83 c4 1c             	add    $0x1c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106d53:	31 c0                	xor    %eax,%eax
}
80106d55:	5b                   	pop    %ebx
80106d56:	5e                   	pop    %esi
80106d57:	5f                   	pop    %edi
80106d58:	5d                   	pop    %ebp
80106d59:	c3                   	ret    
