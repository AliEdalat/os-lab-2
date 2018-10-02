
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

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
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 70 2f 10 80       	mov    $0x80102f70,%eax
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
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 80 6f 10 80       	push   $0x80106f80
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 75 42 00 00       	call   801042d0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 6f 10 80       	push   $0x80106f87
80100097:	50                   	push   %eax
80100098:	e8 03 41 00 00       	call   801041a0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
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
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 27 43 00 00       	call   80104410 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
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
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
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
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 69 43 00 00       	call   801044d0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 40 00 00       	call   801041e0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 6d 20 00 00       	call   801021f0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 8e 6f 10 80       	push   $0x80106f8e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 cd 40 00 00       	call   80104280 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 27 20 00 00       	jmp    801021f0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 6f 10 80       	push   $0x80106f9f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
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
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 8c 40 00 00       	call   80104280 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 40 00 00       	call   80104240 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 00 42 00 00       	call   80104410 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 6f 42 00 00       	jmp    801044d0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 6f 10 80       	push   $0x80106fa6
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

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
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 ab 15 00 00       	call   80101830 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 7f 41 00 00       	call   80104410 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002a7:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002c5:	e8 86 3b 00 00       	call   80103e50 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 d0 35 00 00       	call   801038b0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 dc 41 00 00       	call   801044d0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 54 14 00 00       	call   80101750 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 7e 41 00 00       	call   801044d0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 f6 13 00 00       	call   80101750 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 52 24 00 00       	call   80102800 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 ad 6f 10 80       	push   $0x80106fad
801003b7:	e8 64 03 00 00       	call   80100720 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 5b 03 00 00       	call   80100720 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 f7 78 10 80 	movl   $0x801078f7,(%esp)
801003cc:	e8 4f 03 00 00       	call   80100720 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 13 3f 00 00       	call   801042f0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 c1 6f 10 80       	push   $0x80106fc1
801003ed:	e8 2e 03 00 00       	call   80100720 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
{
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	83 ec 1c             	sub    $0x1c,%esp
  if(panicked){
80100419:	8b 35 58 a5 10 80    	mov    0x8010a558,%esi
8010041f:	85 f6                	test   %esi,%esi
80100421:	74 0d                	je     80100430 <consputc+0x20>
80100423:	fa                   	cli    
80100424:	eb fe                	jmp    80100424 <consputc+0x14>
80100426:	8d 76 00             	lea    0x0(%esi),%esi
80100429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(c == BACKSPACE){
80100430:	3d 00 01 00 00       	cmp    $0x100,%eax
80100435:	89 c3                	mov    %eax,%ebx
80100437:	0f 84 e3 00 00 00    	je     80100520 <consputc+0x110>
    uartputc(c);
8010043d:	83 ec 0c             	sub    $0xc,%esp
80100440:	50                   	push   %eax
80100441:	e8 4a 57 00 00       	call   80105b90 <uartputc>
80100446:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100449:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010044e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100453:	89 fa                	mov    %edi,%edx
80100455:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100456:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010045b:	89 ca                	mov    %ecx,%edx
8010045d:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
8010045e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100461:	89 fa                	mov    %edi,%edx
80100463:	c1 e0 08             	shl    $0x8,%eax
80100466:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100469:	b8 0f 00 00 00       	mov    $0xf,%eax
8010046e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010046f:	89 ca                	mov    %ecx,%edx
80100471:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100472:	0f b6 f8             	movzbl %al,%edi
80100475:	0b 7d e4             	or     -0x1c(%ebp),%edi
  if(c == '\n')
80100478:	83 fb 0a             	cmp    $0xa,%ebx
8010047b:	0f 84 a9 01 00 00    	je     8010062a <consputc+0x21a>
  else if(c == BACKSPACE) {
80100481:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100487:	0f 84 83 01 00 00    	je     80100610 <consputc+0x200>
  } else if(c == LEFT){
8010048d:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100493:	0f 84 5c 01 00 00    	je     801005f5 <consputc+0x1e5>
  } else if(c == RIGHT){
80100499:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
8010049f:	0f 84 35 01 00 00    	je     801005da <consputc+0x1ca>
  } else if(c == UP){
801004a5:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
801004ab:	0f 84 e3 00 00 00    	je     80100594 <consputc+0x184>
  } else if(c == DOWN){
801004b1:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
801004b7:	89 fa                	mov    %edi,%edx
801004b9:	74 11                	je     801004cc <consputc+0xbc>
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
801004bb:	0f b6 c3             	movzbl %bl,%eax
801004be:	83 c7 01             	add    $0x1,%edi
801004c1:	80 cc 07             	or     $0x7,%ah
801004c4:	66 89 84 12 00 80 0b 	mov    %ax,-0x7ff48000(%edx,%edx,1)
801004cb:	80 
  if(pos < 0 || pos > 25*80)
801004cc:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
801004d2:	0f 87 af 00 00 00    	ja     80100587 <consputc+0x177>
  if((pos/80) >= 24){  // Scroll up.
801004d8:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
801004de:	7f 6a                	jg     8010054a <consputc+0x13a>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004e0:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004e5:	b8 0e 00 00 00       	mov    $0xe,%eax
801004ea:	89 da                	mov    %ebx,%edx
801004ec:	ee                   	out    %al,(%dx)
801004ed:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004f2:	89 f8                	mov    %edi,%eax
801004f4:	c1 f8 08             	sar    $0x8,%eax
801004f7:	89 ca                	mov    %ecx,%edx
801004f9:	ee                   	out    %al,(%dx)
801004fa:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ff:	89 da                	mov    %ebx,%edx
80100501:	ee                   	out    %al,(%dx)
80100502:	89 f8                	mov    %edi,%eax
80100504:	89 ca                	mov    %ecx,%edx
80100506:	ee                   	out    %al,(%dx)
  if(backspace_hit) {
80100507:	85 f6                	test   %esi,%esi
80100509:	74 0d                	je     80100518 <consputc+0x108>
	  crt[pos] = ' ' | 0x0700;
8010050b:	b8 20 07 00 00       	mov    $0x720,%eax
80100510:	66 89 84 3f 00 80 0b 	mov    %ax,-0x7ff48000(%edi,%edi,1)
80100517:	80 
}
80100518:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010051b:	5b                   	pop    %ebx
8010051c:	5e                   	pop    %esi
8010051d:	5f                   	pop    %edi
8010051e:	5d                   	pop    %ebp
8010051f:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100520:	83 ec 0c             	sub    $0xc,%esp
80100523:	6a 08                	push   $0x8
80100525:	e8 66 56 00 00       	call   80105b90 <uartputc>
8010052a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100531:	e8 5a 56 00 00       	call   80105b90 <uartputc>
80100536:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010053d:	e8 4e 56 00 00       	call   80105b90 <uartputc>
80100542:	83 c4 10             	add    $0x10,%esp
80100545:	e9 ff fe ff ff       	jmp    80100449 <consputc+0x39>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054a:	52                   	push   %edx
8010054b:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100550:	83 ef 50             	sub    $0x50,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100553:	68 a0 80 0b 80       	push   $0x800b80a0
80100558:	68 00 80 0b 80       	push   $0x800b8000
8010055d:	e8 6e 40 00 00       	call   801045d0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100562:	b8 80 07 00 00       	mov    $0x780,%eax
80100567:	83 c4 0c             	add    $0xc,%esp
8010056a:	29 f8                	sub    %edi,%eax
8010056c:	01 c0                	add    %eax,%eax
8010056e:	50                   	push   %eax
8010056f:	8d 04 3f             	lea    (%edi,%edi,1),%eax
80100572:	6a 00                	push   $0x0
80100574:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100579:	50                   	push   %eax
8010057a:	e8 a1 3f 00 00       	call   80104520 <memset>
8010057f:	83 c4 10             	add    $0x10,%esp
80100582:	e9 59 ff ff ff       	jmp    801004e0 <consputc+0xd0>
    panic("pos under/overflow");
80100587:	83 ec 0c             	sub    $0xc,%esp
8010058a:	68 c5 6f 10 80       	push   $0x80106fc5
8010058f:	e8 fc fd ff ff       	call   80100390 <panic>
    if(pos > BUFF_SIZE) {
80100594:	83 ff 50             	cmp    $0x50,%edi
80100597:	0f 8e 2f ff ff ff    	jle    801004cc <consputc+0xbc>
      memmove(crt, crt + BUFF_SIZE, sizeof(crt[0]) * 23 * BUFF_SIZE);
8010059d:	51                   	push   %ecx
8010059e:	68 60 0e 00 00       	push   $0xe60
      pos -= BUFF_SIZE;
801005a3:	83 ef 50             	sub    $0x50,%edi
      memmove(crt, crt + BUFF_SIZE, sizeof(crt[0]) * 23 * BUFF_SIZE);
801005a6:	68 a0 80 0b 80       	push   $0x800b80a0
801005ab:	68 00 80 0b 80       	push   $0x800b8000
801005b0:	e8 1b 40 00 00       	call   801045d0 <memmove>
      memset(crt + pos, 0, sizeof(crt[0]) * (24 * BUFF_SIZE - pos));
801005b5:	b8 80 07 00 00       	mov    $0x780,%eax
801005ba:	83 c4 0c             	add    $0xc,%esp
801005bd:	29 f8                	sub    %edi,%eax
801005bf:	01 c0                	add    %eax,%eax
801005c1:	50                   	push   %eax
801005c2:	8d 04 3f             	lea    (%edi,%edi,1),%eax
801005c5:	6a 00                	push   $0x0
801005c7:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
801005cc:	50                   	push   %eax
801005cd:	e8 4e 3f 00 00       	call   80104520 <memset>
801005d2:	83 c4 10             	add    $0x10,%esp
801005d5:	e9 f2 fe ff ff       	jmp    801004cc <consputc+0xbc>
    if (pos % BUFF_SIZE < 75) ++pos;
801005da:	89 f8                	mov    %edi,%eax
801005dc:	b9 50 00 00 00       	mov    $0x50,%ecx
801005e1:	99                   	cltd   
801005e2:	f7 f9                	idiv   %ecx
801005e4:	83 fa 4a             	cmp    $0x4a,%edx
801005e7:	0f 8f df fe ff ff    	jg     801004cc <consputc+0xbc>
801005ed:	83 c7 01             	add    $0x1,%edi
801005f0:	e9 d7 fe ff ff       	jmp    801004cc <consputc+0xbc>
    if (pos % BUFF_SIZE > 2) --pos;
801005f5:	89 f8                	mov    %edi,%eax
801005f7:	b9 50 00 00 00       	mov    $0x50,%ecx
801005fc:	99                   	cltd   
801005fd:	f7 f9                	idiv   %ecx
801005ff:	83 fa 02             	cmp    $0x2,%edx
80100602:	0f 8e c4 fe ff ff    	jle    801004cc <consputc+0xbc>
80100608:	83 ef 01             	sub    $0x1,%edi
8010060b:	e9 bc fe ff ff       	jmp    801004cc <consputc+0xbc>
      if (pos % BUFF_SIZE > 2) --pos;
80100610:	89 f8                	mov    %edi,%eax
80100612:	b9 50 00 00 00       	mov    $0x50,%ecx
      backspace_hit = 1;
80100617:	be 01 00 00 00       	mov    $0x1,%esi
      if (pos % BUFF_SIZE > 2) --pos;
8010061c:	99                   	cltd   
8010061d:	f7 f9                	idiv   %ecx
8010061f:	83 fa 02             	cmp    $0x2,%edx
80100622:	0f 8e a4 fe ff ff    	jle    801004cc <consputc+0xbc>
80100628:	eb de                	jmp    80100608 <consputc+0x1f8>
    pos += BUFF_SIZE - pos % BUFF_SIZE;
8010062a:	89 f8                	mov    %edi,%eax
8010062c:	b9 50 00 00 00       	mov    $0x50,%ecx
80100631:	99                   	cltd   
80100632:	f7 f9                	idiv   %ecx
80100634:	29 d1                	sub    %edx,%ecx
80100636:	01 cf                	add    %ecx,%edi
80100638:	e9 8f fe ff ff       	jmp    801004cc <consputc+0xbc>
8010063d:	8d 76 00             	lea    0x0(%esi),%esi

80100640 <printint>:
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	89 d3                	mov    %edx,%ebx
80100648:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010064b:	85 c9                	test   %ecx,%ecx
{
8010064d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100650:	74 04                	je     80100656 <printint+0x16>
80100652:	85 c0                	test   %eax,%eax
80100654:	78 5a                	js     801006b0 <printint+0x70>
    x = xx;
80100656:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010065d:	31 c9                	xor    %ecx,%ecx
8010065f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100662:	eb 06                	jmp    8010066a <printint+0x2a>
80100664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100668:	89 f9                	mov    %edi,%ecx
8010066a:	31 d2                	xor    %edx,%edx
8010066c:	8d 79 01             	lea    0x1(%ecx),%edi
8010066f:	f7 f3                	div    %ebx
80100671:	0f b6 92 f0 6f 10 80 	movzbl -0x7fef9010(%edx),%edx
  }while((x /= base) != 0);
80100678:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
8010067a:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
8010067d:	75 e9                	jne    80100668 <printint+0x28>
  if(sign)
8010067f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100682:	85 c0                	test   %eax,%eax
80100684:	74 08                	je     8010068e <printint+0x4e>
    buf[i++] = '-';
80100686:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
8010068b:	8d 79 02             	lea    0x2(%ecx),%edi
8010068e:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
80100692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
80100698:	0f be 03             	movsbl (%ebx),%eax
8010069b:	83 eb 01             	sub    $0x1,%ebx
8010069e:	e8 6d fd ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801006a3:	39 f3                	cmp    %esi,%ebx
801006a5:	75 f1                	jne    80100698 <printint+0x58>
}
801006a7:	83 c4 2c             	add    $0x2c,%esp
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop
    x = -xx;
801006b0:	f7 d8                	neg    %eax
801006b2:	eb a9                	jmp    8010065d <printint+0x1d>
801006b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801006ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801006c0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006c0:	55                   	push   %ebp
801006c1:	89 e5                	mov    %esp,%ebp
801006c3:	57                   	push   %edi
801006c4:	56                   	push   %esi
801006c5:	53                   	push   %ebx
801006c6:	83 ec 18             	sub    $0x18,%esp
801006c9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801006cc:	ff 75 08             	pushl  0x8(%ebp)
801006cf:	e8 5c 11 00 00       	call   80101830 <iunlock>
  acquire(&cons.lock);
801006d4:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006db:	e8 30 3d 00 00       	call   80104410 <acquire>
  for(i = 0; i < n; i++)
801006e0:	83 c4 10             	add    $0x10,%esp
801006e3:	85 f6                	test   %esi,%esi
801006e5:	7e 18                	jle    801006ff <consolewrite+0x3f>
801006e7:	8b 7d 0c             	mov    0xc(%ebp),%edi
801006ea:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801006ed:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801006f0:	0f b6 07             	movzbl (%edi),%eax
801006f3:	83 c7 01             	add    $0x1,%edi
801006f6:	e8 15 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
801006fb:	39 fb                	cmp    %edi,%ebx
801006fd:	75 f1                	jne    801006f0 <consolewrite+0x30>
  release(&cons.lock);
801006ff:	83 ec 0c             	sub    $0xc,%esp
80100702:	68 20 a5 10 80       	push   $0x8010a520
80100707:	e8 c4 3d 00 00       	call   801044d0 <release>
  ilock(ip);
8010070c:	58                   	pop    %eax
8010070d:	ff 75 08             	pushl  0x8(%ebp)
80100710:	e8 3b 10 00 00       	call   80101750 <ilock>

  return n;
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	89 f0                	mov    %esi,%eax
8010071a:	5b                   	pop    %ebx
8010071b:	5e                   	pop    %esi
8010071c:	5f                   	pop    %edi
8010071d:	5d                   	pop    %ebp
8010071e:	c3                   	ret    
8010071f:	90                   	nop

80100720 <cprintf>:
{
80100720:	55                   	push   %ebp
80100721:	89 e5                	mov    %esp,%ebp
80100723:	57                   	push   %edi
80100724:	56                   	push   %esi
80100725:	53                   	push   %ebx
80100726:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100729:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010072e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100730:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100733:	0f 85 6f 01 00 00    	jne    801008a8 <cprintf+0x188>
  if (fmt == 0)
80100739:	8b 45 08             	mov    0x8(%ebp),%eax
8010073c:	85 c0                	test   %eax,%eax
8010073e:	89 c7                	mov    %eax,%edi
80100740:	0f 84 77 01 00 00    	je     801008bd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100746:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100749:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010074c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010074e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100751:	85 c0                	test   %eax,%eax
80100753:	75 56                	jne    801007ab <cprintf+0x8b>
80100755:	eb 79                	jmp    801007d0 <cprintf+0xb0>
80100757:	89 f6                	mov    %esi,%esi
80100759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100760:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100763:	85 d2                	test   %edx,%edx
80100765:	74 69                	je     801007d0 <cprintf+0xb0>
80100767:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010076a:	83 fa 70             	cmp    $0x70,%edx
8010076d:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
80100770:	0f 84 84 00 00 00    	je     801007fa <cprintf+0xda>
80100776:	7f 78                	jg     801007f0 <cprintf+0xd0>
80100778:	83 fa 25             	cmp    $0x25,%edx
8010077b:	0f 84 ff 00 00 00    	je     80100880 <cprintf+0x160>
80100781:	83 fa 64             	cmp    $0x64,%edx
80100784:	0f 85 8e 00 00 00    	jne    80100818 <cprintf+0xf8>
      printint(*argp++, 10, 1);
8010078a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010078d:	ba 0a 00 00 00       	mov    $0xa,%edx
80100792:	8d 48 04             	lea    0x4(%eax),%ecx
80100795:	8b 00                	mov    (%eax),%eax
80100797:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010079a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010079f:	e8 9c fe ff ff       	call   80100640 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007a4:	0f b6 06             	movzbl (%esi),%eax
801007a7:	85 c0                	test   %eax,%eax
801007a9:	74 25                	je     801007d0 <cprintf+0xb0>
801007ab:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801007ae:	83 f8 25             	cmp    $0x25,%eax
801007b1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801007b4:	74 aa                	je     80100760 <cprintf+0x40>
801007b6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801007b9:	e8 52 fc ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007be:	0f b6 06             	movzbl (%esi),%eax
      continue;
801007c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801007c4:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007c6:	85 c0                	test   %eax,%eax
801007c8:	75 e1                	jne    801007ab <cprintf+0x8b>
801007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
801007d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801007d3:	85 c0                	test   %eax,%eax
801007d5:	74 10                	je     801007e7 <cprintf+0xc7>
    release(&cons.lock);
801007d7:	83 ec 0c             	sub    $0xc,%esp
801007da:	68 20 a5 10 80       	push   $0x8010a520
801007df:	e8 ec 3c 00 00       	call   801044d0 <release>
801007e4:	83 c4 10             	add    $0x10,%esp
}
801007e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007ea:	5b                   	pop    %ebx
801007eb:	5e                   	pop    %esi
801007ec:	5f                   	pop    %edi
801007ed:	5d                   	pop    %ebp
801007ee:	c3                   	ret    
801007ef:	90                   	nop
    switch(c){
801007f0:	83 fa 73             	cmp    $0x73,%edx
801007f3:	74 43                	je     80100838 <cprintf+0x118>
801007f5:	83 fa 78             	cmp    $0x78,%edx
801007f8:	75 1e                	jne    80100818 <cprintf+0xf8>
      printint(*argp++, 16, 0);
801007fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007fd:	ba 10 00 00 00       	mov    $0x10,%edx
80100802:	8d 48 04             	lea    0x4(%eax),%ecx
80100805:	8b 00                	mov    (%eax),%eax
80100807:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010080a:	31 c9                	xor    %ecx,%ecx
8010080c:	e8 2f fe ff ff       	call   80100640 <printint>
      break;
80100811:	eb 91                	jmp    801007a4 <cprintf+0x84>
80100813:	90                   	nop
80100814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100818:	b8 25 00 00 00       	mov    $0x25,%eax
8010081d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100820:	e8 eb fb ff ff       	call   80100410 <consputc>
      consputc(c);
80100825:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100828:	89 d0                	mov    %edx,%eax
8010082a:	e8 e1 fb ff ff       	call   80100410 <consputc>
      break;
8010082f:	e9 70 ff ff ff       	jmp    801007a4 <cprintf+0x84>
80100834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100838:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010083b:	8b 10                	mov    (%eax),%edx
8010083d:	8d 48 04             	lea    0x4(%eax),%ecx
80100840:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100843:	85 d2                	test   %edx,%edx
80100845:	74 49                	je     80100890 <cprintf+0x170>
      for(; *s; s++)
80100847:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010084a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010084d:	84 c0                	test   %al,%al
8010084f:	0f 84 4f ff ff ff    	je     801007a4 <cprintf+0x84>
80100855:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100858:	89 d3                	mov    %edx,%ebx
8010085a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100860:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
80100863:	e8 a8 fb ff ff       	call   80100410 <consputc>
      for(; *s; s++)
80100868:	0f be 03             	movsbl (%ebx),%eax
8010086b:	84 c0                	test   %al,%al
8010086d:	75 f1                	jne    80100860 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
8010086f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100872:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100875:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100878:	e9 27 ff ff ff       	jmp    801007a4 <cprintf+0x84>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
80100880:	b8 25 00 00 00       	mov    $0x25,%eax
80100885:	e8 86 fb ff ff       	call   80100410 <consputc>
      break;
8010088a:	e9 15 ff ff ff       	jmp    801007a4 <cprintf+0x84>
8010088f:	90                   	nop
        s = "(null)";
80100890:	ba d8 6f 10 80       	mov    $0x80106fd8,%edx
      for(; *s; s++)
80100895:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100898:	b8 28 00 00 00       	mov    $0x28,%eax
8010089d:	89 d3                	mov    %edx,%ebx
8010089f:	eb bf                	jmp    80100860 <cprintf+0x140>
801008a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801008a8:	83 ec 0c             	sub    $0xc,%esp
801008ab:	68 20 a5 10 80       	push   $0x8010a520
801008b0:	e8 5b 3b 00 00       	call   80104410 <acquire>
801008b5:	83 c4 10             	add    $0x10,%esp
801008b8:	e9 7c fe ff ff       	jmp    80100739 <cprintf+0x19>
    panic("null fmt");
801008bd:	83 ec 0c             	sub    $0xc,%esp
801008c0:	68 df 6f 10 80       	push   $0x80106fdf
801008c5:	e8 c6 fa ff ff       	call   80100390 <panic>
801008ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008d0 <consoleintr>:
{
801008d0:	55                   	push   %ebp
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	57                   	push   %edi
801008d4:	56                   	push   %esi
801008d5:	53                   	push   %ebx
  int c, doprocdump = 0;
801008d6:	31 f6                	xor    %esi,%esi
{
801008d8:	83 ec 18             	sub    $0x18,%esp
801008db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801008de:	68 20 a5 10 80       	push   $0x8010a520
801008e3:	e8 28 3b 00 00       	call   80104410 <acquire>
  while((c = getc()) >= 0){
801008e8:	83 c4 10             	add    $0x10,%esp
801008eb:	90                   	nop
801008ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008f0:	ff d3                	call   *%ebx
801008f2:	85 c0                	test   %eax,%eax
801008f4:	89 c7                	mov    %eax,%edi
801008f6:	78 48                	js     80100940 <consoleintr+0x70>
    switch(c){
801008f8:	83 ff 10             	cmp    $0x10,%edi
801008fb:	0f 84 e7 00 00 00    	je     801009e8 <consoleintr+0x118>
80100901:	7e 5d                	jle    80100960 <consoleintr+0x90>
80100903:	83 ff 15             	cmp    $0x15,%edi
80100906:	0f 84 ec 00 00 00    	je     801009f8 <consoleintr+0x128>
8010090c:	83 ff 7f             	cmp    $0x7f,%edi
8010090f:	75 54                	jne    80100965 <consoleintr+0x95>
      if(input.e != input.w){
80100911:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100916:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010091c:	74 d2                	je     801008f0 <consoleintr+0x20>
        input.e--;
8010091e:	83 e8 01             	sub    $0x1,%eax
80100921:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100926:	b8 00 01 00 00       	mov    $0x100,%eax
8010092b:	e8 e0 fa ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100930:	ff d3                	call   *%ebx
80100932:	85 c0                	test   %eax,%eax
80100934:	89 c7                	mov    %eax,%edi
80100936:	79 c0                	jns    801008f8 <consoleintr+0x28>
80100938:	90                   	nop
80100939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100940:	83 ec 0c             	sub    $0xc,%esp
80100943:	68 20 a5 10 80       	push   $0x8010a520
80100948:	e8 83 3b 00 00       	call   801044d0 <release>
  if(doprocdump) {
8010094d:	83 c4 10             	add    $0x10,%esp
80100950:	85 f6                	test   %esi,%esi
80100952:	0f 85 f8 00 00 00    	jne    80100a50 <consoleintr+0x180>
}
80100958:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010095b:	5b                   	pop    %ebx
8010095c:	5e                   	pop    %esi
8010095d:	5f                   	pop    %edi
8010095e:	5d                   	pop    %ebp
8010095f:	c3                   	ret    
    switch(c){
80100960:	83 ff 08             	cmp    $0x8,%edi
80100963:	74 ac                	je     80100911 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100965:	85 ff                	test   %edi,%edi
80100967:	74 87                	je     801008f0 <consoleintr+0x20>
80100969:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010096e:	89 c2                	mov    %eax,%edx
80100970:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100976:	83 fa 7f             	cmp    $0x7f,%edx
80100979:	0f 87 71 ff ff ff    	ja     801008f0 <consoleintr+0x20>
8010097f:	8d 50 01             	lea    0x1(%eax),%edx
80100982:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100985:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100988:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
8010098e:	0f 84 cc 00 00 00    	je     80100a60 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
80100994:	89 f9                	mov    %edi,%ecx
80100996:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010099c:	89 f8                	mov    %edi,%eax
8010099e:	e8 6d fa ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009a3:	83 ff 0a             	cmp    $0xa,%edi
801009a6:	0f 84 c5 00 00 00    	je     80100a71 <consoleintr+0x1a1>
801009ac:	83 ff 04             	cmp    $0x4,%edi
801009af:	0f 84 bc 00 00 00    	je     80100a71 <consoleintr+0x1a1>
801009b5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801009ba:	83 e8 80             	sub    $0xffffff80,%eax
801009bd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801009c3:	0f 85 27 ff ff ff    	jne    801008f0 <consoleintr+0x20>
          wakeup(&input.r);
801009c9:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009cc:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801009d1:	68 a0 ff 10 80       	push   $0x8010ffa0
801009d6:	e8 25 36 00 00       	call   80104000 <wakeup>
801009db:	83 c4 10             	add    $0x10,%esp
801009de:	e9 0d ff ff ff       	jmp    801008f0 <consoleintr+0x20>
801009e3:	90                   	nop
801009e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801009e8:	be 01 00 00 00       	mov    $0x1,%esi
801009ed:	e9 fe fe ff ff       	jmp    801008f0 <consoleintr+0x20>
801009f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801009f8:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009fd:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100a03:	75 2b                	jne    80100a30 <consoleintr+0x160>
80100a05:	e9 e6 fe ff ff       	jmp    801008f0 <consoleintr+0x20>
80100a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100a10:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100a15:	b8 00 01 00 00       	mov    $0x100,%eax
80100a1a:	e8 f1 f9 ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
80100a1f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a24:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100a2a:	0f 84 c0 fe ff ff    	je     801008f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a30:	83 e8 01             	sub    $0x1,%eax
80100a33:	89 c2                	mov    %eax,%edx
80100a35:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a38:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100a3f:	75 cf                	jne    80100a10 <consoleintr+0x140>
80100a41:	e9 aa fe ff ff       	jmp    801008f0 <consoleintr+0x20>
80100a46:	8d 76 00             	lea    0x0(%esi),%esi
80100a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100a50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a53:	5b                   	pop    %ebx
80100a54:	5e                   	pop    %esi
80100a55:	5f                   	pop    %edi
80100a56:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a57:	e9 84 36 00 00       	jmp    801040e0 <procdump>
80100a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a60:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100a67:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a6c:	e8 9f f9 ff ff       	call   80100410 <consputc>
80100a71:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a76:	e9 4e ff ff ff       	jmp    801009c9 <consoleintr+0xf9>
80100a7b:	90                   	nop
80100a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100a80 <consoleinit>:

void
consoleinit(void)
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a86:	68 e8 6f 10 80       	push   $0x80106fe8
80100a8b:	68 20 a5 10 80       	push   $0x8010a520
80100a90:	e8 3b 38 00 00       	call   801042d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a95:	58                   	pop    %eax
80100a96:	5a                   	pop    %edx
80100a97:	6a 00                	push   $0x0
80100a99:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a9b:	c7 05 6c 09 11 80 c0 	movl   $0x801006c0,0x8011096c
80100aa2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100aa5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
80100aac:	02 10 80 
  cons.locking = 1;
80100aaf:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100ab6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100ab9:	e8 e2 18 00 00       	call   801023a0 <ioapicenable>
}
80100abe:	83 c4 10             	add    $0x10,%esp
80100ac1:	c9                   	leave  
80100ac2:	c3                   	ret    
80100ac3:	66 90                	xchg   %ax,%ax
80100ac5:	66 90                	xchg   %ax,%ax
80100ac7:	66 90                	xchg   %ax,%ax
80100ac9:	66 90                	xchg   %ax,%ax
80100acb:	66 90                	xchg   %ax,%ax
80100acd:	66 90                	xchg   %ax,%ax
80100acf:	90                   	nop

80100ad0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ad0:	55                   	push   %ebp
80100ad1:	89 e5                	mov    %esp,%ebp
80100ad3:	57                   	push   %edi
80100ad4:	56                   	push   %esi
80100ad5:	53                   	push   %ebx
80100ad6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100adc:	e8 cf 2d 00 00       	call   801038b0 <myproc>
80100ae1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100ae7:	e8 84 21 00 00       	call   80102c70 <begin_op>

  if((ip = namei(path)) == 0){
80100aec:	83 ec 0c             	sub    $0xc,%esp
80100aef:	ff 75 08             	pushl  0x8(%ebp)
80100af2:	e8 b9 14 00 00       	call   80101fb0 <namei>
80100af7:	83 c4 10             	add    $0x10,%esp
80100afa:	85 c0                	test   %eax,%eax
80100afc:	0f 84 91 01 00 00    	je     80100c93 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b02:	83 ec 0c             	sub    $0xc,%esp
80100b05:	89 c3                	mov    %eax,%ebx
80100b07:	50                   	push   %eax
80100b08:	e8 43 0c 00 00       	call   80101750 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b0d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b13:	6a 34                	push   $0x34
80100b15:	6a 00                	push   $0x0
80100b17:	50                   	push   %eax
80100b18:	53                   	push   %ebx
80100b19:	e8 12 0f 00 00       	call   80101a30 <readi>
80100b1e:	83 c4 20             	add    $0x20,%esp
80100b21:	83 f8 34             	cmp    $0x34,%eax
80100b24:	74 22                	je     80100b48 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b26:	83 ec 0c             	sub    $0xc,%esp
80100b29:	53                   	push   %ebx
80100b2a:	e8 b1 0e 00 00       	call   801019e0 <iunlockput>
    end_op();
80100b2f:	e8 ac 21 00 00       	call   80102ce0 <end_op>
80100b34:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b3f:	5b                   	pop    %ebx
80100b40:	5e                   	pop    %esi
80100b41:	5f                   	pop    %edi
80100b42:	5d                   	pop    %ebp
80100b43:	c3                   	ret    
80100b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b48:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b4f:	45 4c 46 
80100b52:	75 d2                	jne    80100b26 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b54:	e8 87 61 00 00       	call   80106ce0 <setupkvm>
80100b59:	85 c0                	test   %eax,%eax
80100b5b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b61:	74 c3                	je     80100b26 <exec+0x56>
  sz = 0;
80100b63:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b65:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b6c:	00 
80100b6d:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100b73:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b79:	0f 84 8c 02 00 00    	je     80100e0b <exec+0x33b>
80100b7f:	31 f6                	xor    %esi,%esi
80100b81:	eb 7f                	jmp    80100c02 <exec+0x132>
80100b83:	90                   	nop
80100b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b88:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b8f:	75 63                	jne    80100bf4 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100b91:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b97:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b9d:	0f 82 86 00 00 00    	jb     80100c29 <exec+0x159>
80100ba3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ba9:	72 7e                	jb     80100c29 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bab:	83 ec 04             	sub    $0x4,%esp
80100bae:	50                   	push   %eax
80100baf:	57                   	push   %edi
80100bb0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bb6:	e8 45 5f 00 00       	call   80106b00 <allocuvm>
80100bbb:	83 c4 10             	add    $0x10,%esp
80100bbe:	85 c0                	test   %eax,%eax
80100bc0:	89 c7                	mov    %eax,%edi
80100bc2:	74 65                	je     80100c29 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100bc4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bca:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bcf:	75 58                	jne    80100c29 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bd1:	83 ec 0c             	sub    $0xc,%esp
80100bd4:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100bda:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100be0:	53                   	push   %ebx
80100be1:	50                   	push   %eax
80100be2:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100be8:	e8 53 5e 00 00       	call   80106a40 <loaduvm>
80100bed:	83 c4 20             	add    $0x20,%esp
80100bf0:	85 c0                	test   %eax,%eax
80100bf2:	78 35                	js     80100c29 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bf4:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bfb:	83 c6 01             	add    $0x1,%esi
80100bfe:	39 f0                	cmp    %esi,%eax
80100c00:	7e 3d                	jle    80100c3f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c02:	89 f0                	mov    %esi,%eax
80100c04:	6a 20                	push   $0x20
80100c06:	c1 e0 05             	shl    $0x5,%eax
80100c09:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100c0f:	50                   	push   %eax
80100c10:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c16:	50                   	push   %eax
80100c17:	53                   	push   %ebx
80100c18:	e8 13 0e 00 00       	call   80101a30 <readi>
80100c1d:	83 c4 10             	add    $0x10,%esp
80100c20:	83 f8 20             	cmp    $0x20,%eax
80100c23:	0f 84 5f ff ff ff    	je     80100b88 <exec+0xb8>
    freevm(pgdir);
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c32:	e8 29 60 00 00       	call   80106c60 <freevm>
80100c37:	83 c4 10             	add    $0x10,%esp
80100c3a:	e9 e7 fe ff ff       	jmp    80100b26 <exec+0x56>
80100c3f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c45:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c4b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c51:	83 ec 0c             	sub    $0xc,%esp
80100c54:	53                   	push   %ebx
80100c55:	e8 86 0d 00 00       	call   801019e0 <iunlockput>
  end_op();
80100c5a:	e8 81 20 00 00       	call   80102ce0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c5f:	83 c4 0c             	add    $0xc,%esp
80100c62:	56                   	push   %esi
80100c63:	57                   	push   %edi
80100c64:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c6a:	e8 91 5e 00 00       	call   80106b00 <allocuvm>
80100c6f:	83 c4 10             	add    $0x10,%esp
80100c72:	85 c0                	test   %eax,%eax
80100c74:	89 c6                	mov    %eax,%esi
80100c76:	75 3a                	jne    80100cb2 <exec+0x1e2>
    freevm(pgdir);
80100c78:	83 ec 0c             	sub    $0xc,%esp
80100c7b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c81:	e8 da 5f 00 00       	call   80106c60 <freevm>
80100c86:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c8e:	e9 a9 fe ff ff       	jmp    80100b3c <exec+0x6c>
    end_op();
80100c93:	e8 48 20 00 00       	call   80102ce0 <end_op>
    cprintf("exec: fail\n");
80100c98:	83 ec 0c             	sub    $0xc,%esp
80100c9b:	68 01 70 10 80       	push   $0x80107001
80100ca0:	e8 7b fa ff ff       	call   80100720 <cprintf>
    return -1;
80100ca5:	83 c4 10             	add    $0x10,%esp
80100ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cad:	e9 8a fe ff ff       	jmp    80100b3c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cb2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100cb8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100cbb:	31 ff                	xor    %edi,%edi
80100cbd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cbf:	50                   	push   %eax
80100cc0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cc6:	e8 b5 60 00 00       	call   80106d80 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cce:	83 c4 10             	add    $0x10,%esp
80100cd1:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100cd7:	8b 00                	mov    (%eax),%eax
80100cd9:	85 c0                	test   %eax,%eax
80100cdb:	74 70                	je     80100d4d <exec+0x27d>
80100cdd:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100ce3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100ce9:	eb 0a                	jmp    80100cf5 <exec+0x225>
80100ceb:	90                   	nop
80100cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100cf0:	83 ff 20             	cmp    $0x20,%edi
80100cf3:	74 83                	je     80100c78 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cf5:	83 ec 0c             	sub    $0xc,%esp
80100cf8:	50                   	push   %eax
80100cf9:	e8 42 3a 00 00       	call   80104740 <strlen>
80100cfe:	f7 d0                	not    %eax
80100d00:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d02:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d05:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d06:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d09:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d0c:	e8 2f 3a 00 00       	call   80104740 <strlen>
80100d11:	83 c0 01             	add    $0x1,%eax
80100d14:	50                   	push   %eax
80100d15:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d18:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d1b:	53                   	push   %ebx
80100d1c:	56                   	push   %esi
80100d1d:	e8 be 61 00 00       	call   80106ee0 <copyout>
80100d22:	83 c4 20             	add    $0x20,%esp
80100d25:	85 c0                	test   %eax,%eax
80100d27:	0f 88 4b ff ff ff    	js     80100c78 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100d2d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d30:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d37:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d3a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d40:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d43:	85 c0                	test   %eax,%eax
80100d45:	75 a9                	jne    80100cf0 <exec+0x220>
80100d47:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d54:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d56:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d5d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100d61:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d68:	ff ff ff 
  ustack[1] = argc;
80100d6b:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d71:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d73:	83 c0 0c             	add    $0xc,%eax
80100d76:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d78:	50                   	push   %eax
80100d79:	52                   	push   %edx
80100d7a:	53                   	push   %ebx
80100d7b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d81:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d87:	e8 54 61 00 00       	call   80106ee0 <copyout>
80100d8c:	83 c4 10             	add    $0x10,%esp
80100d8f:	85 c0                	test   %eax,%eax
80100d91:	0f 88 e1 fe ff ff    	js     80100c78 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100d97:	8b 45 08             	mov    0x8(%ebp),%eax
80100d9a:	0f b6 00             	movzbl (%eax),%eax
80100d9d:	84 c0                	test   %al,%al
80100d9f:	74 17                	je     80100db8 <exec+0x2e8>
80100da1:	8b 55 08             	mov    0x8(%ebp),%edx
80100da4:	89 d1                	mov    %edx,%ecx
80100da6:	83 c1 01             	add    $0x1,%ecx
80100da9:	3c 2f                	cmp    $0x2f,%al
80100dab:	0f b6 01             	movzbl (%ecx),%eax
80100dae:	0f 44 d1             	cmove  %ecx,%edx
80100db1:	84 c0                	test   %al,%al
80100db3:	75 f1                	jne    80100da6 <exec+0x2d6>
80100db5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100db8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100dbe:	50                   	push   %eax
80100dbf:	6a 10                	push   $0x10
80100dc1:	ff 75 08             	pushl  0x8(%ebp)
80100dc4:	89 f8                	mov    %edi,%eax
80100dc6:	83 c0 6c             	add    $0x6c,%eax
80100dc9:	50                   	push   %eax
80100dca:	e8 31 39 00 00       	call   80104700 <safestrcpy>
  curproc->pgdir = pgdir;
80100dcf:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100dd5:	89 f9                	mov    %edi,%ecx
80100dd7:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100dda:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100ddd:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100ddf:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100de2:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100de8:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100deb:	8b 41 18             	mov    0x18(%ecx),%eax
80100dee:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100df1:	89 0c 24             	mov    %ecx,(%esp)
80100df4:	e8 b7 5a 00 00       	call   801068b0 <switchuvm>
  freevm(oldpgdir);
80100df9:	89 3c 24             	mov    %edi,(%esp)
80100dfc:	e8 5f 5e 00 00       	call   80106c60 <freevm>
  return 0;
80100e01:	83 c4 10             	add    $0x10,%esp
80100e04:	31 c0                	xor    %eax,%eax
80100e06:	e9 31 fd ff ff       	jmp    80100b3c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e0b:	be 00 20 00 00       	mov    $0x2000,%esi
80100e10:	e9 3c fe ff ff       	jmp    80100c51 <exec+0x181>
80100e15:	66 90                	xchg   %ax,%ax
80100e17:	66 90                	xchg   %ax,%ax
80100e19:	66 90                	xchg   %ax,%ax
80100e1b:	66 90                	xchg   %ax,%ax
80100e1d:	66 90                	xchg   %ax,%ax
80100e1f:	90                   	nop

80100e20 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e26:	68 0d 70 10 80       	push   $0x8010700d
80100e2b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e30:	e8 9b 34 00 00       	call   801042d0 <initlock>
}
80100e35:	83 c4 10             	add    $0x10,%esp
80100e38:	c9                   	leave  
80100e39:	c3                   	ret    
80100e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e44:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100e49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e4c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e51:	e8 ba 35 00 00       	call   80104410 <acquire>
80100e56:	83 c4 10             	add    $0x10,%esp
80100e59:	eb 10                	jmp    80100e6b <filealloc+0x2b>
80100e5b:	90                   	nop
80100e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e60:	83 c3 18             	add    $0x18,%ebx
80100e63:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e69:	73 25                	jae    80100e90 <filealloc+0x50>
    if(f->ref == 0){
80100e6b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e6e:	85 c0                	test   %eax,%eax
80100e70:	75 ee                	jne    80100e60 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e72:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e75:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e81:	e8 4a 36 00 00       	call   801044d0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e86:	89 d8                	mov    %ebx,%eax
      return f;
80100e88:	83 c4 10             	add    $0x10,%esp
}
80100e8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e8e:	c9                   	leave  
80100e8f:	c3                   	ret    
  release(&ftable.lock);
80100e90:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e93:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e95:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e9a:	e8 31 36 00 00       	call   801044d0 <release>
}
80100e9f:	89 d8                	mov    %ebx,%eax
  return 0;
80100ea1:	83 c4 10             	add    $0x10,%esp
}
80100ea4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea7:	c9                   	leave  
80100ea8:	c3                   	ret    
80100ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100eb0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	53                   	push   %ebx
80100eb4:	83 ec 10             	sub    $0x10,%esp
80100eb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eba:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ebf:	e8 4c 35 00 00       	call   80104410 <acquire>
  if(f->ref < 1)
80100ec4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ec7:	83 c4 10             	add    $0x10,%esp
80100eca:	85 c0                	test   %eax,%eax
80100ecc:	7e 1a                	jle    80100ee8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ece:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ed1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ed4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ed7:	68 c0 ff 10 80       	push   $0x8010ffc0
80100edc:	e8 ef 35 00 00       	call   801044d0 <release>
  return f;
}
80100ee1:	89 d8                	mov    %ebx,%eax
80100ee3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ee6:	c9                   	leave  
80100ee7:	c3                   	ret    
    panic("filedup");
80100ee8:	83 ec 0c             	sub    $0xc,%esp
80100eeb:	68 14 70 10 80       	push   $0x80107014
80100ef0:	e8 9b f4 ff ff       	call   80100390 <panic>
80100ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f00 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	57                   	push   %edi
80100f04:	56                   	push   %esi
80100f05:	53                   	push   %ebx
80100f06:	83 ec 28             	sub    $0x28,%esp
80100f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f0c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100f11:	e8 fa 34 00 00       	call   80104410 <acquire>
  if(f->ref < 1)
80100f16:	8b 43 04             	mov    0x4(%ebx),%eax
80100f19:	83 c4 10             	add    $0x10,%esp
80100f1c:	85 c0                	test   %eax,%eax
80100f1e:	0f 8e 9b 00 00 00    	jle    80100fbf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100f24:	83 e8 01             	sub    $0x1,%eax
80100f27:	85 c0                	test   %eax,%eax
80100f29:	89 43 04             	mov    %eax,0x4(%ebx)
80100f2c:	74 1a                	je     80100f48 <fileclose+0x48>
    release(&ftable.lock);
80100f2e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f38:	5b                   	pop    %ebx
80100f39:	5e                   	pop    %esi
80100f3a:	5f                   	pop    %edi
80100f3b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f3c:	e9 8f 35 00 00       	jmp    801044d0 <release>
80100f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f48:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f4c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100f4e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f51:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100f54:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f5a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f5d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f60:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100f65:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f68:	e8 63 35 00 00       	call   801044d0 <release>
  if(ff.type == FD_PIPE)
80100f6d:	83 c4 10             	add    $0x10,%esp
80100f70:	83 ff 01             	cmp    $0x1,%edi
80100f73:	74 13                	je     80100f88 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f75:	83 ff 02             	cmp    $0x2,%edi
80100f78:	74 26                	je     80100fa0 <fileclose+0xa0>
}
80100f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7d:	5b                   	pop    %ebx
80100f7e:	5e                   	pop    %esi
80100f7f:	5f                   	pop    %edi
80100f80:	5d                   	pop    %ebp
80100f81:	c3                   	ret    
80100f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f88:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f8c:	83 ec 08             	sub    $0x8,%esp
80100f8f:	53                   	push   %ebx
80100f90:	56                   	push   %esi
80100f91:	e8 8a 24 00 00       	call   80103420 <pipeclose>
80100f96:	83 c4 10             	add    $0x10,%esp
80100f99:	eb df                	jmp    80100f7a <fileclose+0x7a>
80100f9b:	90                   	nop
80100f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100fa0:	e8 cb 1c 00 00       	call   80102c70 <begin_op>
    iput(ff.ip);
80100fa5:	83 ec 0c             	sub    $0xc,%esp
80100fa8:	ff 75 e0             	pushl  -0x20(%ebp)
80100fab:	e8 d0 08 00 00       	call   80101880 <iput>
    end_op();
80100fb0:	83 c4 10             	add    $0x10,%esp
}
80100fb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb6:	5b                   	pop    %ebx
80100fb7:	5e                   	pop    %esi
80100fb8:	5f                   	pop    %edi
80100fb9:	5d                   	pop    %ebp
    end_op();
80100fba:	e9 21 1d 00 00       	jmp    80102ce0 <end_op>
    panic("fileclose");
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	68 1c 70 10 80       	push   $0x8010701c
80100fc7:	e8 c4 f3 ff ff       	call   80100390 <panic>
80100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 04             	sub    $0x4,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
    ilock(f->ip);
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 73 10             	pushl  0x10(%ebx)
80100fe5:	e8 66 07 00 00       	call   80101750 <ilock>
    stati(f->ip, st);
80100fea:	58                   	pop    %eax
80100feb:	5a                   	pop    %edx
80100fec:	ff 75 0c             	pushl  0xc(%ebp)
80100fef:	ff 73 10             	pushl  0x10(%ebx)
80100ff2:	e8 09 0a 00 00       	call   80101a00 <stati>
    iunlock(f->ip);
80100ff7:	59                   	pop    %ecx
80100ff8:	ff 73 10             	pushl  0x10(%ebx)
80100ffb:	e8 30 08 00 00       	call   80101830 <iunlock>
    return 0;
80101000:	83 c4 10             	add    $0x10,%esp
80101003:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101005:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101015:	eb ee                	jmp    80101005 <filestat+0x35>
80101017:	89 f6                	mov    %esi,%esi
80101019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 60                	je     80101098 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 41                	je     80101080 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 5b                	jne    8010109f <fileread+0x7f>
    ilock(f->ip);
80101044:	83 ec 0c             	sub    $0xc,%esp
80101047:	ff 73 10             	pushl  0x10(%ebx)
8010104a:	e8 01 07 00 00       	call   80101750 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010104f:	57                   	push   %edi
80101050:	ff 73 14             	pushl  0x14(%ebx)
80101053:	56                   	push   %esi
80101054:	ff 73 10             	pushl  0x10(%ebx)
80101057:	e8 d4 09 00 00       	call   80101a30 <readi>
8010105c:	83 c4 20             	add    $0x20,%esp
8010105f:	85 c0                	test   %eax,%eax
80101061:	89 c6                	mov    %eax,%esi
80101063:	7e 03                	jle    80101068 <fileread+0x48>
      f->off += r;
80101065:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	ff 73 10             	pushl  0x10(%ebx)
8010106e:	e8 bd 07 00 00       	call   80101830 <iunlock>
    return r;
80101073:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	89 f0                	mov    %esi,%eax
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010108d:	e9 3e 25 00 00       	jmp    801035d0 <piperead>
80101092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101098:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010109d:	eb d7                	jmp    80101076 <fileread+0x56>
  panic("fileread");
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	68 26 70 10 80       	push   $0x80107026
801010a7:	e8 e4 f2 ff ff       	call   80100390 <panic>
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010b0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	57                   	push   %edi
801010b4:	56                   	push   %esi
801010b5:	53                   	push   %ebx
801010b6:	83 ec 1c             	sub    $0x1c,%esp
801010b9:	8b 75 08             	mov    0x8(%ebp),%esi
801010bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801010bf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801010c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010c6:	8b 45 10             	mov    0x10(%ebp),%eax
801010c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010cc:	0f 84 aa 00 00 00    	je     8010117c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
801010d2:	8b 06                	mov    (%esi),%eax
801010d4:	83 f8 01             	cmp    $0x1,%eax
801010d7:	0f 84 c3 00 00 00    	je     801011a0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010dd:	83 f8 02             	cmp    $0x2,%eax
801010e0:	0f 85 d9 00 00 00    	jne    801011bf <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010e9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 34                	jg     80101123 <filewrite+0x73>
801010ef:	e9 9c 00 00 00       	jmp    80101190 <filewrite+0xe0>
801010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010f8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010fb:	83 ec 0c             	sub    $0xc,%esp
801010fe:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101101:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101104:	e8 27 07 00 00       	call   80101830 <iunlock>
      end_op();
80101109:	e8 d2 1b 00 00       	call   80102ce0 <end_op>
8010110e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101111:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101114:	39 c3                	cmp    %eax,%ebx
80101116:	0f 85 96 00 00 00    	jne    801011b2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010111c:	01 df                	add    %ebx,%edi
    while(i < n){
8010111e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101121:	7e 6d                	jle    80101190 <filewrite+0xe0>
      int n1 = n - i;
80101123:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101126:	b8 00 06 00 00       	mov    $0x600,%eax
8010112b:	29 fb                	sub    %edi,%ebx
8010112d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101133:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101136:	e8 35 1b 00 00       	call   80102c70 <begin_op>
      ilock(f->ip);
8010113b:	83 ec 0c             	sub    $0xc,%esp
8010113e:	ff 76 10             	pushl  0x10(%esi)
80101141:	e8 0a 06 00 00       	call   80101750 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101146:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101149:	53                   	push   %ebx
8010114a:	ff 76 14             	pushl  0x14(%esi)
8010114d:	01 f8                	add    %edi,%eax
8010114f:	50                   	push   %eax
80101150:	ff 76 10             	pushl  0x10(%esi)
80101153:	e8 d8 09 00 00       	call   80101b30 <writei>
80101158:	83 c4 20             	add    $0x20,%esp
8010115b:	85 c0                	test   %eax,%eax
8010115d:	7f 99                	jg     801010f8 <filewrite+0x48>
      iunlock(f->ip);
8010115f:	83 ec 0c             	sub    $0xc,%esp
80101162:	ff 76 10             	pushl  0x10(%esi)
80101165:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101168:	e8 c3 06 00 00       	call   80101830 <iunlock>
      end_op();
8010116d:	e8 6e 1b 00 00       	call   80102ce0 <end_op>
      if(r < 0)
80101172:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101175:	83 c4 10             	add    $0x10,%esp
80101178:	85 c0                	test   %eax,%eax
8010117a:	74 98                	je     80101114 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010117c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010117f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101184:	89 f8                	mov    %edi,%eax
80101186:	5b                   	pop    %ebx
80101187:	5e                   	pop    %esi
80101188:	5f                   	pop    %edi
80101189:	5d                   	pop    %ebp
8010118a:	c3                   	ret    
8010118b:	90                   	nop
8010118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101190:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101193:	75 e7                	jne    8010117c <filewrite+0xcc>
}
80101195:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101198:	89 f8                	mov    %edi,%eax
8010119a:	5b                   	pop    %ebx
8010119b:	5e                   	pop    %esi
8010119c:	5f                   	pop    %edi
8010119d:	5d                   	pop    %ebp
8010119e:	c3                   	ret    
8010119f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801011a0:	8b 46 0c             	mov    0xc(%esi),%eax
801011a3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a9:	5b                   	pop    %ebx
801011aa:	5e                   	pop    %esi
801011ab:	5f                   	pop    %edi
801011ac:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011ad:	e9 0e 23 00 00       	jmp    801034c0 <pipewrite>
        panic("short filewrite");
801011b2:	83 ec 0c             	sub    $0xc,%esp
801011b5:	68 2f 70 10 80       	push   $0x8010702f
801011ba:	e8 d1 f1 ff ff       	call   80100390 <panic>
  panic("filewrite");
801011bf:	83 ec 0c             	sub    $0xc,%esp
801011c2:	68 35 70 10 80       	push   $0x80107035
801011c7:	e8 c4 f1 ff ff       	call   80100390 <panic>
801011cc:	66 90                	xchg   %ax,%ax
801011ce:	66 90                	xchg   %ax,%ax

801011d0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011d0:	55                   	push   %ebp
801011d1:	89 e5                	mov    %esp,%ebp
801011d3:	57                   	push   %edi
801011d4:	56                   	push   %esi
801011d5:	53                   	push   %ebx
801011d6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011d9:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
801011df:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011e2:	85 c9                	test   %ecx,%ecx
801011e4:	0f 84 87 00 00 00    	je     80101271 <balloc+0xa1>
801011ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011f1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011f4:	83 ec 08             	sub    $0x8,%esp
801011f7:	89 f0                	mov    %esi,%eax
801011f9:	c1 f8 0c             	sar    $0xc,%eax
801011fc:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101202:	50                   	push   %eax
80101203:	ff 75 d8             	pushl  -0x28(%ebp)
80101206:	e8 c5 ee ff ff       	call   801000d0 <bread>
8010120b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010120e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101219:	31 c0                	xor    %eax,%eax
8010121b:	eb 2f                	jmp    8010124c <balloc+0x7c>
8010121d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101220:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101222:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101225:	bb 01 00 00 00       	mov    $0x1,%ebx
8010122a:	83 e1 07             	and    $0x7,%ecx
8010122d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010122f:	89 c1                	mov    %eax,%ecx
80101231:	c1 f9 03             	sar    $0x3,%ecx
80101234:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101239:	85 df                	test   %ebx,%edi
8010123b:	89 fa                	mov    %edi,%edx
8010123d:	74 41                	je     80101280 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010123f:	83 c0 01             	add    $0x1,%eax
80101242:	83 c6 01             	add    $0x1,%esi
80101245:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010124a:	74 05                	je     80101251 <balloc+0x81>
8010124c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010124f:	77 cf                	ja     80101220 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101251:	83 ec 0c             	sub    $0xc,%esp
80101254:	ff 75 e4             	pushl  -0x1c(%ebp)
80101257:	e8 84 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010125c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101263:	83 c4 10             	add    $0x10,%esp
80101266:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101269:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010126f:	77 80                	ja     801011f1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101271:	83 ec 0c             	sub    $0xc,%esp
80101274:	68 3f 70 10 80       	push   $0x8010703f
80101279:	e8 12 f1 ff ff       	call   80100390 <panic>
8010127e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101280:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101283:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101286:	09 da                	or     %ebx,%edx
80101288:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010128c:	57                   	push   %edi
8010128d:	e8 ae 1b 00 00       	call   80102e40 <log_write>
        brelse(bp);
80101292:	89 3c 24             	mov    %edi,(%esp)
80101295:	e8 46 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010129a:	58                   	pop    %eax
8010129b:	5a                   	pop    %edx
8010129c:	56                   	push   %esi
8010129d:	ff 75 d8             	pushl  -0x28(%ebp)
801012a0:	e8 2b ee ff ff       	call   801000d0 <bread>
801012a5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801012aa:	83 c4 0c             	add    $0xc,%esp
801012ad:	68 00 02 00 00       	push   $0x200
801012b2:	6a 00                	push   $0x0
801012b4:	50                   	push   %eax
801012b5:	e8 66 32 00 00       	call   80104520 <memset>
  log_write(bp);
801012ba:	89 1c 24             	mov    %ebx,(%esp)
801012bd:	e8 7e 1b 00 00       	call   80102e40 <log_write>
  brelse(bp);
801012c2:	89 1c 24             	mov    %ebx,(%esp)
801012c5:	e8 16 ef ff ff       	call   801001e0 <brelse>
}
801012ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012cd:	89 f0                	mov    %esi,%eax
801012cf:	5b                   	pop    %ebx
801012d0:	5e                   	pop    %esi
801012d1:	5f                   	pop    %edi
801012d2:	5d                   	pop    %ebp
801012d3:	c3                   	ret    
801012d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

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
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012e8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ea:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012ef:	83 ec 28             	sub    $0x28,%esp
801012f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012f5:	68 e0 09 11 80       	push   $0x801109e0
801012fa:	e8 11 31 00 00       	call   80104410 <acquire>
801012ff:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101302:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101305:	eb 17                	jmp    8010131e <iget+0x3e>
80101307:	89 f6                	mov    %esi,%esi
80101309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101310:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101316:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010131c:	73 22                	jae    80101340 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010131e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101321:	85 c9                	test   %ecx,%ecx
80101323:	7e 04                	jle    80101329 <iget+0x49>
80101325:	39 3b                	cmp    %edi,(%ebx)
80101327:	74 4f                	je     80101378 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101329:	85 f6                	test   %esi,%esi
8010132b:	75 e3                	jne    80101310 <iget+0x30>
8010132d:	85 c9                	test   %ecx,%ecx
8010132f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101332:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101338:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010133e:	72 de                	jb     8010131e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101340:	85 f6                	test   %esi,%esi
80101342:	74 5b                	je     8010139f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101344:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101347:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101349:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010134c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101353:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010135a:	68 e0 09 11 80       	push   $0x801109e0
8010135f:	e8 6c 31 00 00       	call   801044d0 <release>

  return ip;
80101364:	83 c4 10             	add    $0x10,%esp
}
80101367:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136a:	89 f0                	mov    %esi,%eax
8010136c:	5b                   	pop    %ebx
8010136d:	5e                   	pop    %esi
8010136e:	5f                   	pop    %edi
8010136f:	5d                   	pop    %ebp
80101370:	c3                   	ret    
80101371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101378:	39 53 04             	cmp    %edx,0x4(%ebx)
8010137b:	75 ac                	jne    80101329 <iget+0x49>
      release(&icache.lock);
8010137d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101380:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101383:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101385:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
8010138a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010138d:	e8 3e 31 00 00       	call   801044d0 <release>
      return ip;
80101392:	83 c4 10             	add    $0x10,%esp
}
80101395:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101398:	89 f0                	mov    %esi,%eax
8010139a:	5b                   	pop    %ebx
8010139b:	5e                   	pop    %esi
8010139c:	5f                   	pop    %edi
8010139d:	5d                   	pop    %ebp
8010139e:	c3                   	ret    
    panic("iget: no inodes");
8010139f:	83 ec 0c             	sub    $0xc,%esp
801013a2:	68 55 70 10 80       	push   $0x80107055
801013a7:	e8 e4 ef ff ff       	call   80100390 <panic>
801013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	57                   	push   %edi
801013b4:	56                   	push   %esi
801013b5:	53                   	push   %ebx
801013b6:	89 c6                	mov    %eax,%esi
801013b8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013bb:	83 fa 0b             	cmp    $0xb,%edx
801013be:	77 18                	ja     801013d8 <bmap+0x28>
801013c0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801013c3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801013c6:	85 db                	test   %ebx,%ebx
801013c8:	74 76                	je     80101440 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013cd:	89 d8                	mov    %ebx,%eax
801013cf:	5b                   	pop    %ebx
801013d0:	5e                   	pop    %esi
801013d1:	5f                   	pop    %edi
801013d2:	5d                   	pop    %ebp
801013d3:	c3                   	ret    
801013d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801013d8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801013db:	83 fb 7f             	cmp    $0x7f,%ebx
801013de:	0f 87 90 00 00 00    	ja     80101474 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801013e4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013ea:	8b 00                	mov    (%eax),%eax
801013ec:	85 d2                	test   %edx,%edx
801013ee:	74 70                	je     80101460 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013f0:	83 ec 08             	sub    $0x8,%esp
801013f3:	52                   	push   %edx
801013f4:	50                   	push   %eax
801013f5:	e8 d6 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013fa:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013fe:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101401:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101403:	8b 1a                	mov    (%edx),%ebx
80101405:	85 db                	test   %ebx,%ebx
80101407:	75 1d                	jne    80101426 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101409:	8b 06                	mov    (%esi),%eax
8010140b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010140e:	e8 bd fd ff ff       	call   801011d0 <balloc>
80101413:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101416:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101419:	89 c3                	mov    %eax,%ebx
8010141b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010141d:	57                   	push   %edi
8010141e:	e8 1d 1a 00 00       	call   80102e40 <log_write>
80101423:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101426:	83 ec 0c             	sub    $0xc,%esp
80101429:	57                   	push   %edi
8010142a:	e8 b1 ed ff ff       	call   801001e0 <brelse>
8010142f:	83 c4 10             	add    $0x10,%esp
}
80101432:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101435:	89 d8                	mov    %ebx,%eax
80101437:	5b                   	pop    %ebx
80101438:	5e                   	pop    %esi
80101439:	5f                   	pop    %edi
8010143a:	5d                   	pop    %ebp
8010143b:	c3                   	ret    
8010143c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101440:	8b 00                	mov    (%eax),%eax
80101442:	e8 89 fd ff ff       	call   801011d0 <balloc>
80101447:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010144a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010144d:	89 c3                	mov    %eax,%ebx
}
8010144f:	89 d8                	mov    %ebx,%eax
80101451:	5b                   	pop    %ebx
80101452:	5e                   	pop    %esi
80101453:	5f                   	pop    %edi
80101454:	5d                   	pop    %ebp
80101455:	c3                   	ret    
80101456:	8d 76 00             	lea    0x0(%esi),%esi
80101459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101460:	e8 6b fd ff ff       	call   801011d0 <balloc>
80101465:	89 c2                	mov    %eax,%edx
80101467:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010146d:	8b 06                	mov    (%esi),%eax
8010146f:	e9 7c ff ff ff       	jmp    801013f0 <bmap+0x40>
  panic("bmap: out of range");
80101474:	83 ec 0c             	sub    $0xc,%esp
80101477:	68 65 70 10 80       	push   $0x80107065
8010147c:	e8 0f ef ff ff       	call   80100390 <panic>
80101481:	eb 0d                	jmp    80101490 <readsb>
80101483:	90                   	nop
80101484:	90                   	nop
80101485:	90                   	nop
80101486:	90                   	nop
80101487:	90                   	nop
80101488:	90                   	nop
80101489:	90                   	nop
8010148a:	90                   	nop
8010148b:	90                   	nop
8010148c:	90                   	nop
8010148d:	90                   	nop
8010148e:	90                   	nop
8010148f:	90                   	nop

80101490 <readsb>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	56                   	push   %esi
80101494:	53                   	push   %ebx
80101495:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101498:	83 ec 08             	sub    $0x8,%esp
8010149b:	6a 01                	push   $0x1
8010149d:	ff 75 08             	pushl  0x8(%ebp)
801014a0:	e8 2b ec ff ff       	call   801000d0 <bread>
801014a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801014a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801014aa:	83 c4 0c             	add    $0xc,%esp
801014ad:	6a 1c                	push   $0x1c
801014af:	50                   	push   %eax
801014b0:	56                   	push   %esi
801014b1:	e8 1a 31 00 00       	call   801045d0 <memmove>
  brelse(bp);
801014b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801014b9:	83 c4 10             	add    $0x10,%esp
}
801014bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014bf:	5b                   	pop    %ebx
801014c0:	5e                   	pop    %esi
801014c1:	5d                   	pop    %ebp
  brelse(bp);
801014c2:	e9 19 ed ff ff       	jmp    801001e0 <brelse>
801014c7:	89 f6                	mov    %esi,%esi
801014c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014d0 <bfree>:
{
801014d0:	55                   	push   %ebp
801014d1:	89 e5                	mov    %esp,%ebp
801014d3:	56                   	push   %esi
801014d4:	53                   	push   %ebx
801014d5:	89 d3                	mov    %edx,%ebx
801014d7:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
801014d9:	83 ec 08             	sub    $0x8,%esp
801014dc:	68 c0 09 11 80       	push   $0x801109c0
801014e1:	50                   	push   %eax
801014e2:	e8 a9 ff ff ff       	call   80101490 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014e7:	58                   	pop    %eax
801014e8:	5a                   	pop    %edx
801014e9:	89 da                	mov    %ebx,%edx
801014eb:	c1 ea 0c             	shr    $0xc,%edx
801014ee:	03 15 d8 09 11 80    	add    0x801109d8,%edx
801014f4:	52                   	push   %edx
801014f5:	56                   	push   %esi
801014f6:	e8 d5 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014fb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014fd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101500:	ba 01 00 00 00       	mov    $0x1,%edx
80101505:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101508:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010150e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101511:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101513:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101518:	85 d1                	test   %edx,%ecx
8010151a:	74 25                	je     80101541 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010151c:	f7 d2                	not    %edx
8010151e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101520:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101523:	21 ca                	and    %ecx,%edx
80101525:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101529:	56                   	push   %esi
8010152a:	e8 11 19 00 00       	call   80102e40 <log_write>
  brelse(bp);
8010152f:	89 34 24             	mov    %esi,(%esp)
80101532:	e8 a9 ec ff ff       	call   801001e0 <brelse>
}
80101537:	83 c4 10             	add    $0x10,%esp
8010153a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010153d:	5b                   	pop    %ebx
8010153e:	5e                   	pop    %esi
8010153f:	5d                   	pop    %ebp
80101540:	c3                   	ret    
    panic("freeing free block");
80101541:	83 ec 0c             	sub    $0xc,%esp
80101544:	68 78 70 10 80       	push   $0x80107078
80101549:	e8 42 ee ff ff       	call   80100390 <panic>
8010154e:	66 90                	xchg   %ax,%ax

80101550 <iinit>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	53                   	push   %ebx
80101554:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101559:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010155c:	68 8b 70 10 80       	push   $0x8010708b
80101561:	68 e0 09 11 80       	push   $0x801109e0
80101566:	e8 65 2d 00 00       	call   801042d0 <initlock>
8010156b:	83 c4 10             	add    $0x10,%esp
8010156e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101570:	83 ec 08             	sub    $0x8,%esp
80101573:	68 92 70 10 80       	push   $0x80107092
80101578:	53                   	push   %ebx
80101579:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010157f:	e8 1c 2c 00 00       	call   801041a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101584:	83 c4 10             	add    $0x10,%esp
80101587:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010158d:	75 e1                	jne    80101570 <iinit+0x20>
  readsb(dev, &sb);
8010158f:	83 ec 08             	sub    $0x8,%esp
80101592:	68 c0 09 11 80       	push   $0x801109c0
80101597:	ff 75 08             	pushl  0x8(%ebp)
8010159a:	e8 f1 fe ff ff       	call   80101490 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010159f:	ff 35 d8 09 11 80    	pushl  0x801109d8
801015a5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801015ab:	ff 35 d0 09 11 80    	pushl  0x801109d0
801015b1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801015b7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801015bd:	ff 35 c4 09 11 80    	pushl  0x801109c4
801015c3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801015c9:	68 f8 70 10 80       	push   $0x801070f8
801015ce:	e8 4d f1 ff ff       	call   80100720 <cprintf>
}
801015d3:	83 c4 30             	add    $0x30,%esp
801015d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015d9:	c9                   	leave  
801015da:	c3                   	ret    
801015db:	90                   	nop
801015dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015e0 <ialloc>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	57                   	push   %edi
801015e4:	56                   	push   %esi
801015e5:	53                   	push   %ebx
801015e6:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015e9:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
801015f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801015f3:	8b 75 08             	mov    0x8(%ebp),%esi
801015f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015f9:	0f 86 91 00 00 00    	jbe    80101690 <ialloc+0xb0>
801015ff:	bb 01 00 00 00       	mov    $0x1,%ebx
80101604:	eb 21                	jmp    80101627 <ialloc+0x47>
80101606:	8d 76 00             	lea    0x0(%esi),%esi
80101609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101610:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101613:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101616:	57                   	push   %edi
80101617:	e8 c4 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010161c:	83 c4 10             	add    $0x10,%esp
8010161f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101625:	76 69                	jbe    80101690 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101627:	89 d8                	mov    %ebx,%eax
80101629:	83 ec 08             	sub    $0x8,%esp
8010162c:	c1 e8 03             	shr    $0x3,%eax
8010162f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101635:	50                   	push   %eax
80101636:	56                   	push   %esi
80101637:	e8 94 ea ff ff       	call   801000d0 <bread>
8010163c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010163e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101640:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101643:	83 e0 07             	and    $0x7,%eax
80101646:	c1 e0 06             	shl    $0x6,%eax
80101649:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010164d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101651:	75 bd                	jne    80101610 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101653:	83 ec 04             	sub    $0x4,%esp
80101656:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101659:	6a 40                	push   $0x40
8010165b:	6a 00                	push   $0x0
8010165d:	51                   	push   %ecx
8010165e:	e8 bd 2e 00 00       	call   80104520 <memset>
      dip->type = type;
80101663:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101667:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010166a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010166d:	89 3c 24             	mov    %edi,(%esp)
80101670:	e8 cb 17 00 00       	call   80102e40 <log_write>
      brelse(bp);
80101675:	89 3c 24             	mov    %edi,(%esp)
80101678:	e8 63 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010167d:	83 c4 10             	add    $0x10,%esp
}
80101680:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101683:	89 da                	mov    %ebx,%edx
80101685:	89 f0                	mov    %esi,%eax
}
80101687:	5b                   	pop    %ebx
80101688:	5e                   	pop    %esi
80101689:	5f                   	pop    %edi
8010168a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010168b:	e9 50 fc ff ff       	jmp    801012e0 <iget>
  panic("ialloc: no inodes");
80101690:	83 ec 0c             	sub    $0xc,%esp
80101693:	68 98 70 10 80       	push   $0x80107098
80101698:	e8 f3 ec ff ff       	call   80100390 <panic>
8010169d:	8d 76 00             	lea    0x0(%esi),%esi

801016a0 <iupdate>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	56                   	push   %esi
801016a4:	53                   	push   %ebx
801016a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016a8:	83 ec 08             	sub    $0x8,%esp
801016ab:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ae:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b1:	c1 e8 03             	shr    $0x3,%eax
801016b4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016ba:	50                   	push   %eax
801016bb:	ff 73 a4             	pushl  -0x5c(%ebx)
801016be:	e8 0d ea ff ff       	call   801000d0 <bread>
801016c3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016c5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801016c8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016cc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016cf:	83 e0 07             	and    $0x7,%eax
801016d2:	c1 e0 06             	shl    $0x6,%eax
801016d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016d9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016dc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016e0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016e3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016e7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016eb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016ef:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016f3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016f7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016fa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016fd:	6a 34                	push   $0x34
801016ff:	53                   	push   %ebx
80101700:	50                   	push   %eax
80101701:	e8 ca 2e 00 00       	call   801045d0 <memmove>
  log_write(bp);
80101706:	89 34 24             	mov    %esi,(%esp)
80101709:	e8 32 17 00 00       	call   80102e40 <log_write>
  brelse(bp);
8010170e:	89 75 08             	mov    %esi,0x8(%ebp)
80101711:	83 c4 10             	add    $0x10,%esp
}
80101714:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101717:	5b                   	pop    %ebx
80101718:	5e                   	pop    %esi
80101719:	5d                   	pop    %ebp
  brelse(bp);
8010171a:	e9 c1 ea ff ff       	jmp    801001e0 <brelse>
8010171f:	90                   	nop

80101720 <idup>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	53                   	push   %ebx
80101724:	83 ec 10             	sub    $0x10,%esp
80101727:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010172a:	68 e0 09 11 80       	push   $0x801109e0
8010172f:	e8 dc 2c 00 00       	call   80104410 <acquire>
  ip->ref++;
80101734:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101738:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010173f:	e8 8c 2d 00 00       	call   801044d0 <release>
}
80101744:	89 d8                	mov    %ebx,%eax
80101746:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101749:	c9                   	leave  
8010174a:	c3                   	ret    
8010174b:	90                   	nop
8010174c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101750 <ilock>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101758:	85 db                	test   %ebx,%ebx
8010175a:	0f 84 b7 00 00 00    	je     80101817 <ilock+0xc7>
80101760:	8b 53 08             	mov    0x8(%ebx),%edx
80101763:	85 d2                	test   %edx,%edx
80101765:	0f 8e ac 00 00 00    	jle    80101817 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010176b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010176e:	83 ec 0c             	sub    $0xc,%esp
80101771:	50                   	push   %eax
80101772:	e8 69 2a 00 00       	call   801041e0 <acquiresleep>
  if(ip->valid == 0){
80101777:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010177a:	83 c4 10             	add    $0x10,%esp
8010177d:	85 c0                	test   %eax,%eax
8010177f:	74 0f                	je     80101790 <ilock+0x40>
}
80101781:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101784:	5b                   	pop    %ebx
80101785:	5e                   	pop    %esi
80101786:	5d                   	pop    %ebp
80101787:	c3                   	ret    
80101788:	90                   	nop
80101789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101790:	8b 43 04             	mov    0x4(%ebx),%eax
80101793:	83 ec 08             	sub    $0x8,%esp
80101796:	c1 e8 03             	shr    $0x3,%eax
80101799:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010179f:	50                   	push   %eax
801017a0:	ff 33                	pushl  (%ebx)
801017a2:	e8 29 e9 ff ff       	call   801000d0 <bread>
801017a7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017a9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ac:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017af:	83 e0 07             	and    $0x7,%eax
801017b2:	c1 e0 06             	shl    $0x6,%eax
801017b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017b9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017bc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017bf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017c3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017c7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017cb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017cf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017d3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017d7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017db:	8b 50 fc             	mov    -0x4(%eax),%edx
801017de:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017e1:	6a 34                	push   $0x34
801017e3:	50                   	push   %eax
801017e4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017e7:	50                   	push   %eax
801017e8:	e8 e3 2d 00 00       	call   801045d0 <memmove>
    brelse(bp);
801017ed:	89 34 24             	mov    %esi,(%esp)
801017f0:	e8 eb e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
801017f5:	83 c4 10             	add    $0x10,%esp
801017f8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017fd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101804:	0f 85 77 ff ff ff    	jne    80101781 <ilock+0x31>
      panic("ilock: no type");
8010180a:	83 ec 0c             	sub    $0xc,%esp
8010180d:	68 b0 70 10 80       	push   $0x801070b0
80101812:	e8 79 eb ff ff       	call   80100390 <panic>
    panic("ilock");
80101817:	83 ec 0c             	sub    $0xc,%esp
8010181a:	68 aa 70 10 80       	push   $0x801070aa
8010181f:	e8 6c eb ff ff       	call   80100390 <panic>
80101824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010182a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101830 <iunlock>:
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	56                   	push   %esi
80101834:	53                   	push   %ebx
80101835:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101838:	85 db                	test   %ebx,%ebx
8010183a:	74 28                	je     80101864 <iunlock+0x34>
8010183c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010183f:	83 ec 0c             	sub    $0xc,%esp
80101842:	56                   	push   %esi
80101843:	e8 38 2a 00 00       	call   80104280 <holdingsleep>
80101848:	83 c4 10             	add    $0x10,%esp
8010184b:	85 c0                	test   %eax,%eax
8010184d:	74 15                	je     80101864 <iunlock+0x34>
8010184f:	8b 43 08             	mov    0x8(%ebx),%eax
80101852:	85 c0                	test   %eax,%eax
80101854:	7e 0e                	jle    80101864 <iunlock+0x34>
  releasesleep(&ip->lock);
80101856:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101859:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010185c:	5b                   	pop    %ebx
8010185d:	5e                   	pop    %esi
8010185e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010185f:	e9 dc 29 00 00       	jmp    80104240 <releasesleep>
    panic("iunlock");
80101864:	83 ec 0c             	sub    $0xc,%esp
80101867:	68 bf 70 10 80       	push   $0x801070bf
8010186c:	e8 1f eb ff ff       	call   80100390 <panic>
80101871:	eb 0d                	jmp    80101880 <iput>
80101873:	90                   	nop
80101874:	90                   	nop
80101875:	90                   	nop
80101876:	90                   	nop
80101877:	90                   	nop
80101878:	90                   	nop
80101879:	90                   	nop
8010187a:	90                   	nop
8010187b:	90                   	nop
8010187c:	90                   	nop
8010187d:	90                   	nop
8010187e:	90                   	nop
8010187f:	90                   	nop

80101880 <iput>:
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	57                   	push   %edi
80101884:	56                   	push   %esi
80101885:	53                   	push   %ebx
80101886:	83 ec 28             	sub    $0x28,%esp
80101889:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010188c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010188f:	57                   	push   %edi
80101890:	e8 4b 29 00 00       	call   801041e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101895:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101898:	83 c4 10             	add    $0x10,%esp
8010189b:	85 d2                	test   %edx,%edx
8010189d:	74 07                	je     801018a6 <iput+0x26>
8010189f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018a4:	74 32                	je     801018d8 <iput+0x58>
  releasesleep(&ip->lock);
801018a6:	83 ec 0c             	sub    $0xc,%esp
801018a9:	57                   	push   %edi
801018aa:	e8 91 29 00 00       	call   80104240 <releasesleep>
  acquire(&icache.lock);
801018af:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018b6:	e8 55 2b 00 00       	call   80104410 <acquire>
  ip->ref--;
801018bb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018bf:	83 c4 10             	add    $0x10,%esp
801018c2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801018c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018cc:	5b                   	pop    %ebx
801018cd:	5e                   	pop    %esi
801018ce:	5f                   	pop    %edi
801018cf:	5d                   	pop    %ebp
  release(&icache.lock);
801018d0:	e9 fb 2b 00 00       	jmp    801044d0 <release>
801018d5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018d8:	83 ec 0c             	sub    $0xc,%esp
801018db:	68 e0 09 11 80       	push   $0x801109e0
801018e0:	e8 2b 2b 00 00       	call   80104410 <acquire>
    int r = ip->ref;
801018e5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018e8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018ef:	e8 dc 2b 00 00       	call   801044d0 <release>
    if(r == 1){
801018f4:	83 c4 10             	add    $0x10,%esp
801018f7:	83 fe 01             	cmp    $0x1,%esi
801018fa:	75 aa                	jne    801018a6 <iput+0x26>
801018fc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101902:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101905:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101908:	89 cf                	mov    %ecx,%edi
8010190a:	eb 0b                	jmp    80101917 <iput+0x97>
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101910:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101913:	39 fe                	cmp    %edi,%esi
80101915:	74 19                	je     80101930 <iput+0xb0>
    if(ip->addrs[i]){
80101917:	8b 16                	mov    (%esi),%edx
80101919:	85 d2                	test   %edx,%edx
8010191b:	74 f3                	je     80101910 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010191d:	8b 03                	mov    (%ebx),%eax
8010191f:	e8 ac fb ff ff       	call   801014d0 <bfree>
      ip->addrs[i] = 0;
80101924:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010192a:	eb e4                	jmp    80101910 <iput+0x90>
8010192c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101930:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101936:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101939:	85 c0                	test   %eax,%eax
8010193b:	75 33                	jne    80101970 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010193d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101940:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101947:	53                   	push   %ebx
80101948:	e8 53 fd ff ff       	call   801016a0 <iupdate>
      ip->type = 0;
8010194d:	31 c0                	xor    %eax,%eax
8010194f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101953:	89 1c 24             	mov    %ebx,(%esp)
80101956:	e8 45 fd ff ff       	call   801016a0 <iupdate>
      ip->valid = 0;
8010195b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101962:	83 c4 10             	add    $0x10,%esp
80101965:	e9 3c ff ff ff       	jmp    801018a6 <iput+0x26>
8010196a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101970:	83 ec 08             	sub    $0x8,%esp
80101973:	50                   	push   %eax
80101974:	ff 33                	pushl  (%ebx)
80101976:	e8 55 e7 ff ff       	call   801000d0 <bread>
8010197b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101981:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101984:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101987:	8d 70 5c             	lea    0x5c(%eax),%esi
8010198a:	83 c4 10             	add    $0x10,%esp
8010198d:	89 cf                	mov    %ecx,%edi
8010198f:	eb 0e                	jmp    8010199f <iput+0x11f>
80101991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101998:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010199b:	39 fe                	cmp    %edi,%esi
8010199d:	74 0f                	je     801019ae <iput+0x12e>
      if(a[j])
8010199f:	8b 16                	mov    (%esi),%edx
801019a1:	85 d2                	test   %edx,%edx
801019a3:	74 f3                	je     80101998 <iput+0x118>
        bfree(ip->dev, a[j]);
801019a5:	8b 03                	mov    (%ebx),%eax
801019a7:	e8 24 fb ff ff       	call   801014d0 <bfree>
801019ac:	eb ea                	jmp    80101998 <iput+0x118>
    brelse(bp);
801019ae:	83 ec 0c             	sub    $0xc,%esp
801019b1:	ff 75 e4             	pushl  -0x1c(%ebp)
801019b4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019b7:	e8 24 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019bc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019c2:	8b 03                	mov    (%ebx),%eax
801019c4:	e8 07 fb ff ff       	call   801014d0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019c9:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019d0:	00 00 00 
801019d3:	83 c4 10             	add    $0x10,%esp
801019d6:	e9 62 ff ff ff       	jmp    8010193d <iput+0xbd>
801019db:	90                   	nop
801019dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019e0 <iunlockput>:
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	53                   	push   %ebx
801019e4:	83 ec 10             	sub    $0x10,%esp
801019e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019ea:	53                   	push   %ebx
801019eb:	e8 40 fe ff ff       	call   80101830 <iunlock>
  iput(ip);
801019f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019f3:	83 c4 10             	add    $0x10,%esp
}
801019f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019f9:	c9                   	leave  
  iput(ip);
801019fa:	e9 81 fe ff ff       	jmp    80101880 <iput>
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
80101a36:	83 ec 1c             	sub    $0x1c,%esp
80101a39:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a3f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a42:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a47:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101a4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a4d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a50:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a53:	0f 84 a7 00 00 00    	je     80101b00 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a5c:	8b 40 58             	mov    0x58(%eax),%eax
80101a5f:	39 c6                	cmp    %eax,%esi
80101a61:	0f 87 ba 00 00 00    	ja     80101b21 <readi+0xf1>
80101a67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a6a:	89 f9                	mov    %edi,%ecx
80101a6c:	01 f1                	add    %esi,%ecx
80101a6e:	0f 82 ad 00 00 00    	jb     80101b21 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a74:	89 c2                	mov    %eax,%edx
80101a76:	29 f2                	sub    %esi,%edx
80101a78:	39 c8                	cmp    %ecx,%eax
80101a7a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a7d:	31 ff                	xor    %edi,%edi
80101a7f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101a81:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a84:	74 6c                	je     80101af2 <readi+0xc2>
80101a86:	8d 76 00             	lea    0x0(%esi),%esi
80101a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a90:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a93:	89 f2                	mov    %esi,%edx
80101a95:	c1 ea 09             	shr    $0x9,%edx
80101a98:	89 d8                	mov    %ebx,%eax
80101a9a:	e8 11 f9 ff ff       	call   801013b0 <bmap>
80101a9f:	83 ec 08             	sub    $0x8,%esp
80101aa2:	50                   	push   %eax
80101aa3:	ff 33                	pushl  (%ebx)
80101aa5:	e8 26 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aaa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aad:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101aaf:	89 f0                	mov    %esi,%eax
80101ab1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ab6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101abb:	83 c4 0c             	add    $0xc,%esp
80101abe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ac0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101ac4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac7:	29 fb                	sub    %edi,%ebx
80101ac9:	39 d9                	cmp    %ebx,%ecx
80101acb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ace:	53                   	push   %ebx
80101acf:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ad0:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ad2:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ad5:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ad7:	e8 f4 2a 00 00       	call   801045d0 <memmove>
    brelse(bp);
80101adc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101adf:	89 14 24             	mov    %edx,(%esp)
80101ae2:	e8 f9 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aea:	83 c4 10             	add    $0x10,%esp
80101aed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101af0:	77 9e                	ja     80101a90 <readi+0x60>
  }
  return n;
80101af2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101af5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101af8:	5b                   	pop    %ebx
80101af9:	5e                   	pop    %esi
80101afa:	5f                   	pop    %edi
80101afb:	5d                   	pop    %ebp
80101afc:	c3                   	ret    
80101afd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b00:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b04:	66 83 f8 09          	cmp    $0x9,%ax
80101b08:	77 17                	ja     80101b21 <readi+0xf1>
80101b0a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101b11:	85 c0                	test   %eax,%eax
80101b13:	74 0c                	je     80101b21 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b15:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b1b:	5b                   	pop    %ebx
80101b1c:	5e                   	pop    %esi
80101b1d:	5f                   	pop    %edi
80101b1e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b1f:	ff e0                	jmp    *%eax
      return -1;
80101b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b26:	eb cd                	jmp    80101af5 <readi+0xc5>
80101b28:	90                   	nop
80101b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

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
80101b36:	83 ec 1c             	sub    $0x1c,%esp
80101b39:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b3f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b42:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b47:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b4d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b50:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b53:	0f 84 b7 00 00 00    	je     80101c10 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b5f:	0f 82 eb 00 00 00    	jb     80101c50 <writei+0x120>
80101b65:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b68:	31 d2                	xor    %edx,%edx
80101b6a:	89 f8                	mov    %edi,%eax
80101b6c:	01 f0                	add    %esi,%eax
80101b6e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b71:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b76:	0f 87 d4 00 00 00    	ja     80101c50 <writei+0x120>
80101b7c:	85 d2                	test   %edx,%edx
80101b7e:	0f 85 cc 00 00 00    	jne    80101c50 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b84:	85 ff                	test   %edi,%edi
80101b86:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b8d:	74 72                	je     80101c01 <writei+0xd1>
80101b8f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b90:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b93:	89 f2                	mov    %esi,%edx
80101b95:	c1 ea 09             	shr    $0x9,%edx
80101b98:	89 f8                	mov    %edi,%eax
80101b9a:	e8 11 f8 ff ff       	call   801013b0 <bmap>
80101b9f:	83 ec 08             	sub    $0x8,%esp
80101ba2:	50                   	push   %eax
80101ba3:	ff 37                	pushl  (%edi)
80101ba5:	e8 26 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101baa:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101bad:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bb0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bb2:	89 f0                	mov    %esi,%eax
80101bb4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bb9:	83 c4 0c             	add    $0xc,%esp
80101bbc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bc1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101bc3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc7:	39 d9                	cmp    %ebx,%ecx
80101bc9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bcc:	53                   	push   %ebx
80101bcd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bd0:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101bd2:	50                   	push   %eax
80101bd3:	e8 f8 29 00 00       	call   801045d0 <memmove>
    log_write(bp);
80101bd8:	89 3c 24             	mov    %edi,(%esp)
80101bdb:	e8 60 12 00 00       	call   80102e40 <log_write>
    brelse(bp);
80101be0:	89 3c 24             	mov    %edi,(%esp)
80101be3:	e8 f8 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101beb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bee:	83 c4 10             	add    $0x10,%esp
80101bf1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bf4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bf7:	77 97                	ja     80101b90 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101bf9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bfc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bff:	77 37                	ja     80101c38 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c01:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c07:	5b                   	pop    %ebx
80101c08:	5e                   	pop    %esi
80101c09:	5f                   	pop    %edi
80101c0a:	5d                   	pop    %ebp
80101c0b:	c3                   	ret    
80101c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c14:	66 83 f8 09          	cmp    $0x9,%ax
80101c18:	77 36                	ja     80101c50 <writei+0x120>
80101c1a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101c21:	85 c0                	test   %eax,%eax
80101c23:	74 2b                	je     80101c50 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101c25:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c2b:	5b                   	pop    %ebx
80101c2c:	5e                   	pop    %esi
80101c2d:	5f                   	pop    %edi
80101c2e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c2f:	ff e0                	jmp    *%eax
80101c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c38:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c3b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c3e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c41:	50                   	push   %eax
80101c42:	e8 59 fa ff ff       	call   801016a0 <iupdate>
80101c47:	83 c4 10             	add    $0x10,%esp
80101c4a:	eb b5                	jmp    80101c01 <writei+0xd1>
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c55:	eb ad                	jmp    80101c04 <writei+0xd4>
80101c57:	89 f6                	mov    %esi,%esi
80101c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c60 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c66:	6a 0e                	push   $0xe
80101c68:	ff 75 0c             	pushl  0xc(%ebp)
80101c6b:	ff 75 08             	pushl  0x8(%ebp)
80101c6e:	e8 cd 29 00 00       	call   80104640 <strncmp>
}
80101c73:	c9                   	leave  
80101c74:	c3                   	ret    
80101c75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c80 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	83 ec 1c             	sub    $0x1c,%esp
80101c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c8c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c91:	0f 85 85 00 00 00    	jne    80101d1c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c97:	8b 53 58             	mov    0x58(%ebx),%edx
80101c9a:	31 ff                	xor    %edi,%edi
80101c9c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c9f:	85 d2                	test   %edx,%edx
80101ca1:	74 3e                	je     80101ce1 <dirlookup+0x61>
80101ca3:	90                   	nop
80101ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ca8:	6a 10                	push   $0x10
80101caa:	57                   	push   %edi
80101cab:	56                   	push   %esi
80101cac:	53                   	push   %ebx
80101cad:	e8 7e fd ff ff       	call   80101a30 <readi>
80101cb2:	83 c4 10             	add    $0x10,%esp
80101cb5:	83 f8 10             	cmp    $0x10,%eax
80101cb8:	75 55                	jne    80101d0f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101cba:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cbf:	74 18                	je     80101cd9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101cc1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cc4:	83 ec 04             	sub    $0x4,%esp
80101cc7:	6a 0e                	push   $0xe
80101cc9:	50                   	push   %eax
80101cca:	ff 75 0c             	pushl  0xc(%ebp)
80101ccd:	e8 6e 29 00 00       	call   80104640 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101cd2:	83 c4 10             	add    $0x10,%esp
80101cd5:	85 c0                	test   %eax,%eax
80101cd7:	74 17                	je     80101cf0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101cd9:	83 c7 10             	add    $0x10,%edi
80101cdc:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101cdf:	72 c7                	jb     80101ca8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101ce1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101ce4:	31 c0                	xor    %eax,%eax
}
80101ce6:	5b                   	pop    %ebx
80101ce7:	5e                   	pop    %esi
80101ce8:	5f                   	pop    %edi
80101ce9:	5d                   	pop    %ebp
80101cea:	c3                   	ret    
80101ceb:	90                   	nop
80101cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101cf0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cf3:	85 c0                	test   %eax,%eax
80101cf5:	74 05                	je     80101cfc <dirlookup+0x7c>
        *poff = off;
80101cf7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cfa:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cfc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d00:	8b 03                	mov    (%ebx),%eax
80101d02:	e8 d9 f5 ff ff       	call   801012e0 <iget>
}
80101d07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0a:	5b                   	pop    %ebx
80101d0b:	5e                   	pop    %esi
80101d0c:	5f                   	pop    %edi
80101d0d:	5d                   	pop    %ebp
80101d0e:	c3                   	ret    
      panic("dirlookup read");
80101d0f:	83 ec 0c             	sub    $0xc,%esp
80101d12:	68 d9 70 10 80       	push   $0x801070d9
80101d17:	e8 74 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101d1c:	83 ec 0c             	sub    $0xc,%esp
80101d1f:	68 c7 70 10 80       	push   $0x801070c7
80101d24:	e8 67 e6 ff ff       	call   80100390 <panic>
80101d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d30 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	57                   	push   %edi
80101d34:	56                   	push   %esi
80101d35:	53                   	push   %ebx
80101d36:	89 cf                	mov    %ecx,%edi
80101d38:	89 c3                	mov    %eax,%ebx
80101d3a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d3d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d40:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d43:	0f 84 67 01 00 00    	je     80101eb0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d49:	e8 62 1b 00 00       	call   801038b0 <myproc>
  acquire(&icache.lock);
80101d4e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d51:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d54:	68 e0 09 11 80       	push   $0x801109e0
80101d59:	e8 b2 26 00 00       	call   80104410 <acquire>
  ip->ref++;
80101d5e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d62:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d69:	e8 62 27 00 00       	call   801044d0 <release>
80101d6e:	83 c4 10             	add    $0x10,%esp
80101d71:	eb 08                	jmp    80101d7b <namex+0x4b>
80101d73:	90                   	nop
80101d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101d78:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d7b:	0f b6 03             	movzbl (%ebx),%eax
80101d7e:	3c 2f                	cmp    $0x2f,%al
80101d80:	74 f6                	je     80101d78 <namex+0x48>
  if(*path == 0)
80101d82:	84 c0                	test   %al,%al
80101d84:	0f 84 ee 00 00 00    	je     80101e78 <namex+0x148>
  while(*path != '/' && *path != 0)
80101d8a:	0f b6 03             	movzbl (%ebx),%eax
80101d8d:	3c 2f                	cmp    $0x2f,%al
80101d8f:	0f 84 b3 00 00 00    	je     80101e48 <namex+0x118>
80101d95:	84 c0                	test   %al,%al
80101d97:	89 da                	mov    %ebx,%edx
80101d99:	75 09                	jne    80101da4 <namex+0x74>
80101d9b:	e9 a8 00 00 00       	jmp    80101e48 <namex+0x118>
80101da0:	84 c0                	test   %al,%al
80101da2:	74 0a                	je     80101dae <namex+0x7e>
    path++;
80101da4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101da7:	0f b6 02             	movzbl (%edx),%eax
80101daa:	3c 2f                	cmp    $0x2f,%al
80101dac:	75 f2                	jne    80101da0 <namex+0x70>
80101dae:	89 d1                	mov    %edx,%ecx
80101db0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101db2:	83 f9 0d             	cmp    $0xd,%ecx
80101db5:	0f 8e 91 00 00 00    	jle    80101e4c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101dbb:	83 ec 04             	sub    $0x4,%esp
80101dbe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101dc1:	6a 0e                	push   $0xe
80101dc3:	53                   	push   %ebx
80101dc4:	57                   	push   %edi
80101dc5:	e8 06 28 00 00       	call   801045d0 <memmove>
    path++;
80101dca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101dcd:	83 c4 10             	add    $0x10,%esp
    path++;
80101dd0:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101dd2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101dd5:	75 11                	jne    80101de8 <namex+0xb8>
80101dd7:	89 f6                	mov    %esi,%esi
80101dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101de0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101de3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101de6:	74 f8                	je     80101de0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	56                   	push   %esi
80101dec:	e8 5f f9 ff ff       	call   80101750 <ilock>
    if(ip->type != T_DIR){
80101df1:	83 c4 10             	add    $0x10,%esp
80101df4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101df9:	0f 85 91 00 00 00    	jne    80101e90 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101dff:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e02:	85 d2                	test   %edx,%edx
80101e04:	74 09                	je     80101e0f <namex+0xdf>
80101e06:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e09:	0f 84 b7 00 00 00    	je     80101ec6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e0f:	83 ec 04             	sub    $0x4,%esp
80101e12:	6a 00                	push   $0x0
80101e14:	57                   	push   %edi
80101e15:	56                   	push   %esi
80101e16:	e8 65 fe ff ff       	call   80101c80 <dirlookup>
80101e1b:	83 c4 10             	add    $0x10,%esp
80101e1e:	85 c0                	test   %eax,%eax
80101e20:	74 6e                	je     80101e90 <namex+0x160>
  iunlock(ip);
80101e22:	83 ec 0c             	sub    $0xc,%esp
80101e25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e28:	56                   	push   %esi
80101e29:	e8 02 fa ff ff       	call   80101830 <iunlock>
  iput(ip);
80101e2e:	89 34 24             	mov    %esi,(%esp)
80101e31:	e8 4a fa ff ff       	call   80101880 <iput>
80101e36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e39:	83 c4 10             	add    $0x10,%esp
80101e3c:	89 c6                	mov    %eax,%esi
80101e3e:	e9 38 ff ff ff       	jmp    80101d7b <namex+0x4b>
80101e43:	90                   	nop
80101e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101e48:	89 da                	mov    %ebx,%edx
80101e4a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101e4c:	83 ec 04             	sub    $0x4,%esp
80101e4f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e52:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e55:	51                   	push   %ecx
80101e56:	53                   	push   %ebx
80101e57:	57                   	push   %edi
80101e58:	e8 73 27 00 00       	call   801045d0 <memmove>
    name[len] = 0;
80101e5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e60:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e63:	83 c4 10             	add    $0x10,%esp
80101e66:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e6a:	89 d3                	mov    %edx,%ebx
80101e6c:	e9 61 ff ff ff       	jmp    80101dd2 <namex+0xa2>
80101e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e7b:	85 c0                	test   %eax,%eax
80101e7d:	75 5d                	jne    80101edc <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e82:	89 f0                	mov    %esi,%eax
80101e84:	5b                   	pop    %ebx
80101e85:	5e                   	pop    %esi
80101e86:	5f                   	pop    %edi
80101e87:	5d                   	pop    %ebp
80101e88:	c3                   	ret    
80101e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e90:	83 ec 0c             	sub    $0xc,%esp
80101e93:	56                   	push   %esi
80101e94:	e8 97 f9 ff ff       	call   80101830 <iunlock>
  iput(ip);
80101e99:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e9c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e9e:	e8 dd f9 ff ff       	call   80101880 <iput>
      return 0;
80101ea3:	83 c4 10             	add    $0x10,%esp
}
80101ea6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea9:	89 f0                	mov    %esi,%eax
80101eab:	5b                   	pop    %ebx
80101eac:	5e                   	pop    %esi
80101ead:	5f                   	pop    %edi
80101eae:	5d                   	pop    %ebp
80101eaf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101eb0:	ba 01 00 00 00       	mov    $0x1,%edx
80101eb5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eba:	e8 21 f4 ff ff       	call   801012e0 <iget>
80101ebf:	89 c6                	mov    %eax,%esi
80101ec1:	e9 b5 fe ff ff       	jmp    80101d7b <namex+0x4b>
      iunlock(ip);
80101ec6:	83 ec 0c             	sub    $0xc,%esp
80101ec9:	56                   	push   %esi
80101eca:	e8 61 f9 ff ff       	call   80101830 <iunlock>
      return ip;
80101ecf:	83 c4 10             	add    $0x10,%esp
}
80101ed2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed5:	89 f0                	mov    %esi,%eax
80101ed7:	5b                   	pop    %ebx
80101ed8:	5e                   	pop    %esi
80101ed9:	5f                   	pop    %edi
80101eda:	5d                   	pop    %ebp
80101edb:	c3                   	ret    
    iput(ip);
80101edc:	83 ec 0c             	sub    $0xc,%esp
80101edf:	56                   	push   %esi
    return 0;
80101ee0:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee2:	e8 99 f9 ff ff       	call   80101880 <iput>
    return 0;
80101ee7:	83 c4 10             	add    $0x10,%esp
80101eea:	eb 93                	jmp    80101e7f <namex+0x14f>
80101eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ef0 <dirlink>:
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
80101ef6:	83 ec 20             	sub    $0x20,%esp
80101ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101efc:	6a 00                	push   $0x0
80101efe:	ff 75 0c             	pushl  0xc(%ebp)
80101f01:	53                   	push   %ebx
80101f02:	e8 79 fd ff ff       	call   80101c80 <dirlookup>
80101f07:	83 c4 10             	add    $0x10,%esp
80101f0a:	85 c0                	test   %eax,%eax
80101f0c:	75 67                	jne    80101f75 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f0e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f11:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f14:	85 ff                	test   %edi,%edi
80101f16:	74 29                	je     80101f41 <dirlink+0x51>
80101f18:	31 ff                	xor    %edi,%edi
80101f1a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f1d:	eb 09                	jmp    80101f28 <dirlink+0x38>
80101f1f:	90                   	nop
80101f20:	83 c7 10             	add    $0x10,%edi
80101f23:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f26:	73 19                	jae    80101f41 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f28:	6a 10                	push   $0x10
80101f2a:	57                   	push   %edi
80101f2b:	56                   	push   %esi
80101f2c:	53                   	push   %ebx
80101f2d:	e8 fe fa ff ff       	call   80101a30 <readi>
80101f32:	83 c4 10             	add    $0x10,%esp
80101f35:	83 f8 10             	cmp    $0x10,%eax
80101f38:	75 4e                	jne    80101f88 <dirlink+0x98>
    if(de.inum == 0)
80101f3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f3f:	75 df                	jne    80101f20 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f41:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f44:	83 ec 04             	sub    $0x4,%esp
80101f47:	6a 0e                	push   $0xe
80101f49:	ff 75 0c             	pushl  0xc(%ebp)
80101f4c:	50                   	push   %eax
80101f4d:	e8 4e 27 00 00       	call   801046a0 <strncpy>
  de.inum = inum;
80101f52:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f55:	6a 10                	push   $0x10
80101f57:	57                   	push   %edi
80101f58:	56                   	push   %esi
80101f59:	53                   	push   %ebx
  de.inum = inum;
80101f5a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f5e:	e8 cd fb ff ff       	call   80101b30 <writei>
80101f63:	83 c4 20             	add    $0x20,%esp
80101f66:	83 f8 10             	cmp    $0x10,%eax
80101f69:	75 2a                	jne    80101f95 <dirlink+0xa5>
  return 0;
80101f6b:	31 c0                	xor    %eax,%eax
}
80101f6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f70:	5b                   	pop    %ebx
80101f71:	5e                   	pop    %esi
80101f72:	5f                   	pop    %edi
80101f73:	5d                   	pop    %ebp
80101f74:	c3                   	ret    
    iput(ip);
80101f75:	83 ec 0c             	sub    $0xc,%esp
80101f78:	50                   	push   %eax
80101f79:	e8 02 f9 ff ff       	call   80101880 <iput>
    return -1;
80101f7e:	83 c4 10             	add    $0x10,%esp
80101f81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f86:	eb e5                	jmp    80101f6d <dirlink+0x7d>
      panic("dirlink read");
80101f88:	83 ec 0c             	sub    $0xc,%esp
80101f8b:	68 e8 70 10 80       	push   $0x801070e8
80101f90:	e8 fb e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101f95:	83 ec 0c             	sub    $0xc,%esp
80101f98:	68 de 76 10 80       	push   $0x801076de
80101f9d:	e8 ee e3 ff ff       	call   80100390 <panic>
80101fa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fb0 <namei>:

struct inode*
namei(char *path)
{
80101fb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fb1:	31 d2                	xor    %edx,%edx
{
80101fb3:	89 e5                	mov    %esp,%ebp
80101fb5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fbe:	e8 6d fd ff ff       	call   80101d30 <namex>
}
80101fc3:	c9                   	leave  
80101fc4:	c3                   	ret    
80101fc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fd0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fd1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fd6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fd8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101fdb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fde:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fdf:	e9 4c fd ff ff       	jmp    80101d30 <namex>
80101fe4:	66 90                	xchg   %ax,%ax
80101fe6:	66 90                	xchg   %ax,%ax
80101fe8:	66 90                	xchg   %ax,%ax
80101fea:	66 90                	xchg   %ax,%ax
80101fec:	66 90                	xchg   %ax,%ax
80101fee:	66 90                	xchg   %ax,%ax

80101ff0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101ff9:	85 c0                	test   %eax,%eax
80101ffb:	0f 84 b4 00 00 00    	je     801020b5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102001:	8b 58 08             	mov    0x8(%eax),%ebx
80102004:	89 c6                	mov    %eax,%esi
80102006:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010200c:	0f 87 96 00 00 00    	ja     801020a8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102012:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102017:	89 f6                	mov    %esi,%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102020:	89 ca                	mov    %ecx,%edx
80102022:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102023:	83 e0 c0             	and    $0xffffffc0,%eax
80102026:	3c 40                	cmp    $0x40,%al
80102028:	75 f6                	jne    80102020 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010202a:	31 ff                	xor    %edi,%edi
8010202c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102031:	89 f8                	mov    %edi,%eax
80102033:	ee                   	out    %al,(%dx)
80102034:	b8 01 00 00 00       	mov    $0x1,%eax
80102039:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010203e:	ee                   	out    %al,(%dx)
8010203f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102044:	89 d8                	mov    %ebx,%eax
80102046:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102047:	89 d8                	mov    %ebx,%eax
80102049:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010204e:	c1 f8 08             	sar    $0x8,%eax
80102051:	ee                   	out    %al,(%dx)
80102052:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102057:	89 f8                	mov    %edi,%eax
80102059:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010205a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010205e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102063:	c1 e0 04             	shl    $0x4,%eax
80102066:	83 e0 10             	and    $0x10,%eax
80102069:	83 c8 e0             	or     $0xffffffe0,%eax
8010206c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010206d:	f6 06 04             	testb  $0x4,(%esi)
80102070:	75 16                	jne    80102088 <idestart+0x98>
80102072:	b8 20 00 00 00       	mov    $0x20,%eax
80102077:	89 ca                	mov    %ecx,%edx
80102079:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010207a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010207d:	5b                   	pop    %ebx
8010207e:	5e                   	pop    %esi
8010207f:	5f                   	pop    %edi
80102080:	5d                   	pop    %ebp
80102081:	c3                   	ret    
80102082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102088:	b8 30 00 00 00       	mov    $0x30,%eax
8010208d:	89 ca                	mov    %ecx,%edx
8010208f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102090:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102095:	83 c6 5c             	add    $0x5c,%esi
80102098:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010209d:	fc                   	cld    
8010209e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020a3:	5b                   	pop    %ebx
801020a4:	5e                   	pop    %esi
801020a5:	5f                   	pop    %edi
801020a6:	5d                   	pop    %ebp
801020a7:	c3                   	ret    
    panic("incorrect blockno");
801020a8:	83 ec 0c             	sub    $0xc,%esp
801020ab:	68 54 71 10 80       	push   $0x80107154
801020b0:	e8 db e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020b5:	83 ec 0c             	sub    $0xc,%esp
801020b8:	68 4b 71 10 80       	push   $0x8010714b
801020bd:	e8 ce e2 ff ff       	call   80100390 <panic>
801020c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020d0 <ideinit>:
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020d6:	68 66 71 10 80       	push   $0x80107166
801020db:	68 80 a5 10 80       	push   $0x8010a580
801020e0:	e8 eb 21 00 00       	call   801042d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020e5:	58                   	pop    %eax
801020e6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
801020eb:	5a                   	pop    %edx
801020ec:	83 e8 01             	sub    $0x1,%eax
801020ef:	50                   	push   %eax
801020f0:	6a 0e                	push   $0xe
801020f2:	e8 a9 02 00 00       	call   801023a0 <ioapicenable>
801020f7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020fa:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ff:	90                   	nop
80102100:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102101:	83 e0 c0             	and    $0xffffffc0,%eax
80102104:	3c 40                	cmp    $0x40,%al
80102106:	75 f8                	jne    80102100 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102108:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010210d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102112:	ee                   	out    %al,(%dx)
80102113:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102118:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010211d:	eb 06                	jmp    80102125 <ideinit+0x55>
8010211f:	90                   	nop
  for(i=0; i<1000; i++){
80102120:	83 e9 01             	sub    $0x1,%ecx
80102123:	74 0f                	je     80102134 <ideinit+0x64>
80102125:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102126:	84 c0                	test   %al,%al
80102128:	74 f6                	je     80102120 <ideinit+0x50>
      havedisk1 = 1;
8010212a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102131:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102134:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102139:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010213e:	ee                   	out    %al,(%dx)
}
8010213f:	c9                   	leave  
80102140:	c3                   	ret    
80102141:	eb 0d                	jmp    80102150 <ideintr>
80102143:	90                   	nop
80102144:	90                   	nop
80102145:	90                   	nop
80102146:	90                   	nop
80102147:	90                   	nop
80102148:	90                   	nop
80102149:	90                   	nop
8010214a:	90                   	nop
8010214b:	90                   	nop
8010214c:	90                   	nop
8010214d:	90                   	nop
8010214e:	90                   	nop
8010214f:	90                   	nop

80102150 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	57                   	push   %edi
80102154:	56                   	push   %esi
80102155:	53                   	push   %ebx
80102156:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102159:	68 80 a5 10 80       	push   $0x8010a580
8010215e:	e8 ad 22 00 00       	call   80104410 <acquire>

  if((b = idequeue) == 0){
80102163:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102169:	83 c4 10             	add    $0x10,%esp
8010216c:	85 db                	test   %ebx,%ebx
8010216e:	74 67                	je     801021d7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102170:	8b 43 58             	mov    0x58(%ebx),%eax
80102173:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102178:	8b 3b                	mov    (%ebx),%edi
8010217a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102180:	75 31                	jne    801021b3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102182:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102187:	89 f6                	mov    %esi,%esi
80102189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102190:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102191:	89 c6                	mov    %eax,%esi
80102193:	83 e6 c0             	and    $0xffffffc0,%esi
80102196:	89 f1                	mov    %esi,%ecx
80102198:	80 f9 40             	cmp    $0x40,%cl
8010219b:	75 f3                	jne    80102190 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010219d:	a8 21                	test   $0x21,%al
8010219f:	75 12                	jne    801021b3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801021a1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021a4:	b9 80 00 00 00       	mov    $0x80,%ecx
801021a9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021ae:	fc                   	cld    
801021af:	f3 6d                	rep insl (%dx),%es:(%edi)
801021b1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021b3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801021b6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021b9:	89 f9                	mov    %edi,%ecx
801021bb:	83 c9 02             	or     $0x2,%ecx
801021be:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021c0:	53                   	push   %ebx
801021c1:	e8 3a 1e 00 00       	call   80104000 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021c6:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801021cb:	83 c4 10             	add    $0x10,%esp
801021ce:	85 c0                	test   %eax,%eax
801021d0:	74 05                	je     801021d7 <ideintr+0x87>
    idestart(idequeue);
801021d2:	e8 19 fe ff ff       	call   80101ff0 <idestart>
    release(&idelock);
801021d7:	83 ec 0c             	sub    $0xc,%esp
801021da:	68 80 a5 10 80       	push   $0x8010a580
801021df:	e8 ec 22 00 00       	call   801044d0 <release>

  release(&idelock);
}
801021e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021e7:	5b                   	pop    %ebx
801021e8:	5e                   	pop    %esi
801021e9:	5f                   	pop    %edi
801021ea:	5d                   	pop    %ebp
801021eb:	c3                   	ret    
801021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

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
801021f4:	83 ec 10             	sub    $0x10,%esp
801021f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801021fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801021fd:	50                   	push   %eax
801021fe:	e8 7d 20 00 00       	call   80104280 <holdingsleep>
80102203:	83 c4 10             	add    $0x10,%esp
80102206:	85 c0                	test   %eax,%eax
80102208:	0f 84 c6 00 00 00    	je     801022d4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010220e:	8b 03                	mov    (%ebx),%eax
80102210:	83 e0 06             	and    $0x6,%eax
80102213:	83 f8 02             	cmp    $0x2,%eax
80102216:	0f 84 ab 00 00 00    	je     801022c7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010221c:	8b 53 04             	mov    0x4(%ebx),%edx
8010221f:	85 d2                	test   %edx,%edx
80102221:	74 0d                	je     80102230 <iderw+0x40>
80102223:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102228:	85 c0                	test   %eax,%eax
8010222a:	0f 84 b1 00 00 00    	je     801022e1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102230:	83 ec 0c             	sub    $0xc,%esp
80102233:	68 80 a5 10 80       	push   $0x8010a580
80102238:	e8 d3 21 00 00       	call   80104410 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010223d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102243:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102246:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224d:	85 d2                	test   %edx,%edx
8010224f:	75 09                	jne    8010225a <iderw+0x6a>
80102251:	eb 6d                	jmp    801022c0 <iderw+0xd0>
80102253:	90                   	nop
80102254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102258:	89 c2                	mov    %eax,%edx
8010225a:	8b 42 58             	mov    0x58(%edx),%eax
8010225d:	85 c0                	test   %eax,%eax
8010225f:	75 f7                	jne    80102258 <iderw+0x68>
80102261:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102264:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102266:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010226c:	74 42                	je     801022b0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010226e:	8b 03                	mov    (%ebx),%eax
80102270:	83 e0 06             	and    $0x6,%eax
80102273:	83 f8 02             	cmp    $0x2,%eax
80102276:	74 23                	je     8010229b <iderw+0xab>
80102278:	90                   	nop
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102280:	83 ec 08             	sub    $0x8,%esp
80102283:	68 80 a5 10 80       	push   $0x8010a580
80102288:	53                   	push   %ebx
80102289:	e8 c2 1b 00 00       	call   80103e50 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010228e:	8b 03                	mov    (%ebx),%eax
80102290:	83 c4 10             	add    $0x10,%esp
80102293:	83 e0 06             	and    $0x6,%eax
80102296:	83 f8 02             	cmp    $0x2,%eax
80102299:	75 e5                	jne    80102280 <iderw+0x90>
  }


  release(&idelock);
8010229b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801022a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022a5:	c9                   	leave  
  release(&idelock);
801022a6:	e9 25 22 00 00       	jmp    801044d0 <release>
801022ab:	90                   	nop
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022b0:	89 d8                	mov    %ebx,%eax
801022b2:	e8 39 fd ff ff       	call   80101ff0 <idestart>
801022b7:	eb b5                	jmp    8010226e <iderw+0x7e>
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801022c5:	eb 9d                	jmp    80102264 <iderw+0x74>
    panic("iderw: nothing to do");
801022c7:	83 ec 0c             	sub    $0xc,%esp
801022ca:	68 80 71 10 80       	push   $0x80107180
801022cf:	e8 bc e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801022d4:	83 ec 0c             	sub    $0xc,%esp
801022d7:	68 6a 71 10 80       	push   $0x8010716a
801022dc:	e8 af e0 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801022e1:	83 ec 0c             	sub    $0xc,%esp
801022e4:	68 95 71 10 80       	push   $0x80107195
801022e9:	e8 a2 e0 ff ff       	call   80100390 <panic>
801022ee:	66 90                	xchg   %ax,%ax

801022f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022f1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801022f8:	00 c0 fe 
{
801022fb:	89 e5                	mov    %esp,%ebp
801022fd:	56                   	push   %esi
801022fe:	53                   	push   %ebx
  ioapic->reg = reg;
801022ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102306:	00 00 00 
  return ioapic->data;
80102309:	a1 34 26 11 80       	mov    0x80112634,%eax
8010230e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102311:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102317:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010231d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102324:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102327:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010232a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010232d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102330:	39 c2                	cmp    %eax,%edx
80102332:	74 16                	je     8010234a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102334:	83 ec 0c             	sub    $0xc,%esp
80102337:	68 b4 71 10 80       	push   $0x801071b4
8010233c:	e8 df e3 ff ff       	call   80100720 <cprintf>
80102341:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102347:	83 c4 10             	add    $0x10,%esp
8010234a:	83 c3 21             	add    $0x21,%ebx
{
8010234d:	ba 10 00 00 00       	mov    $0x10,%edx
80102352:	b8 20 00 00 00       	mov    $0x20,%eax
80102357:	89 f6                	mov    %esi,%esi
80102359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102360:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102362:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102368:	89 c6                	mov    %eax,%esi
8010236a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102370:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102373:	89 71 10             	mov    %esi,0x10(%ecx)
80102376:	8d 72 01             	lea    0x1(%edx),%esi
80102379:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010237c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010237e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102380:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102386:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010238d:	75 d1                	jne    80102360 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010238f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102392:	5b                   	pop    %ebx
80102393:	5e                   	pop    %esi
80102394:	5d                   	pop    %ebp
80102395:	c3                   	ret    
80102396:	8d 76 00             	lea    0x0(%esi),%esi
80102399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023a0:	55                   	push   %ebp
  ioapic->reg = reg;
801023a1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801023a7:	89 e5                	mov    %esp,%ebp
801023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023ac:	8d 50 20             	lea    0x20(%eax),%edx
801023af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023b5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023be:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023cb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023ce:	89 50 10             	mov    %edx,0x10(%eax)
}
801023d1:	5d                   	pop    %ebp
801023d2:	c3                   	ret    
801023d3:	66 90                	xchg   %ax,%ax
801023d5:	66 90                	xchg   %ax,%ax
801023d7:	66 90                	xchg   %ax,%ax
801023d9:	66 90                	xchg   %ax,%ax
801023db:	66 90                	xchg   %ax,%ax
801023dd:	66 90                	xchg   %ax,%ax
801023df:	90                   	nop

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
801023e4:	83 ec 04             	sub    $0x4,%esp
801023e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023f0:	75 70                	jne    80102462 <kfree+0x82>
801023f2:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
801023f8:	72 68                	jb     80102462 <kfree+0x82>
801023fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102400:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102405:	77 5b                	ja     80102462 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102407:	83 ec 04             	sub    $0x4,%esp
8010240a:	68 00 10 00 00       	push   $0x1000
8010240f:	6a 01                	push   $0x1
80102411:	53                   	push   %ebx
80102412:	e8 09 21 00 00       	call   80104520 <memset>

  if(kmem.use_lock)
80102417:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010241d:	83 c4 10             	add    $0x10,%esp
80102420:	85 d2                	test   %edx,%edx
80102422:	75 2c                	jne    80102450 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102424:	a1 78 26 11 80       	mov    0x80112678,%eax
80102429:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010242b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102430:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102436:	85 c0                	test   %eax,%eax
80102438:	75 06                	jne    80102440 <kfree+0x60>
    release(&kmem.lock);
}
8010243a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010243d:	c9                   	leave  
8010243e:	c3                   	ret    
8010243f:	90                   	nop
    release(&kmem.lock);
80102440:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010244a:	c9                   	leave  
    release(&kmem.lock);
8010244b:	e9 80 20 00 00       	jmp    801044d0 <release>
    acquire(&kmem.lock);
80102450:	83 ec 0c             	sub    $0xc,%esp
80102453:	68 40 26 11 80       	push   $0x80112640
80102458:	e8 b3 1f 00 00       	call   80104410 <acquire>
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	eb c2                	jmp    80102424 <kfree+0x44>
    panic("kfree");
80102462:	83 ec 0c             	sub    $0xc,%esp
80102465:	68 e6 71 10 80       	push   $0x801071e6
8010246a:	e8 21 df ff ff       	call   80100390 <panic>
8010246f:	90                   	nop

80102470 <freerange>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102475:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102478:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010247b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102481:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102487:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010248d:	39 de                	cmp    %ebx,%esi
8010248f:	72 23                	jb     801024b4 <freerange+0x44>
80102491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102498:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010249e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024a7:	50                   	push   %eax
801024a8:	e8 33 ff ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ad:	83 c4 10             	add    $0x10,%esp
801024b0:	39 f3                	cmp    %esi,%ebx
801024b2:	76 e4                	jbe    80102498 <freerange+0x28>
}
801024b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024b7:	5b                   	pop    %ebx
801024b8:	5e                   	pop    %esi
801024b9:	5d                   	pop    %ebp
801024ba:	c3                   	ret    
801024bb:	90                   	nop
801024bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024c0 <kinit1>:
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	56                   	push   %esi
801024c4:	53                   	push   %ebx
801024c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024c8:	83 ec 08             	sub    $0x8,%esp
801024cb:	68 ec 71 10 80       	push   $0x801071ec
801024d0:	68 40 26 11 80       	push   $0x80112640
801024d5:	e8 f6 1d 00 00       	call   801042d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024dd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801024e0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801024e7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801024ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024fc:	39 de                	cmp    %ebx,%esi
801024fe:	72 1c                	jb     8010251c <kinit1+0x5c>
    kfree(p);
80102500:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102506:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102509:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010250f:	50                   	push   %eax
80102510:	e8 cb fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102515:	83 c4 10             	add    $0x10,%esp
80102518:	39 de                	cmp    %ebx,%esi
8010251a:	73 e4                	jae    80102500 <kinit1+0x40>
}
8010251c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010251f:	5b                   	pop    %ebx
80102520:	5e                   	pop    %esi
80102521:	5d                   	pop    %ebp
80102522:	c3                   	ret    
80102523:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102530 <kinit2>:
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	56                   	push   %esi
80102534:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102535:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102538:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010253b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102541:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102547:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010254d:	39 de                	cmp    %ebx,%esi
8010254f:	72 23                	jb     80102574 <kinit2+0x44>
80102551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102558:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010255e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102561:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102567:	50                   	push   %eax
80102568:	e8 73 fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	39 de                	cmp    %ebx,%esi
80102572:	73 e4                	jae    80102558 <kinit2+0x28>
  kmem.use_lock = 1;
80102574:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010257b:	00 00 00 
}
8010257e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102581:	5b                   	pop    %ebx
80102582:	5e                   	pop    %esi
80102583:	5d                   	pop    %ebp
80102584:	c3                   	ret    
80102585:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102590 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102590:	a1 74 26 11 80       	mov    0x80112674,%eax
80102595:	85 c0                	test   %eax,%eax
80102597:	75 1f                	jne    801025b8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102599:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010259e:	85 c0                	test   %eax,%eax
801025a0:	74 0e                	je     801025b0 <kalloc+0x20>
    kmem.freelist = r->next;
801025a2:	8b 10                	mov    (%eax),%edx
801025a4:	89 15 78 26 11 80    	mov    %edx,0x80112678
801025aa:	c3                   	ret    
801025ab:	90                   	nop
801025ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025b0:	f3 c3                	repz ret 
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801025b8:	55                   	push   %ebp
801025b9:	89 e5                	mov    %esp,%ebp
801025bb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801025be:	68 40 26 11 80       	push   $0x80112640
801025c3:	e8 48 1e 00 00       	call   80104410 <acquire>
  r = kmem.freelist;
801025c8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801025cd:	83 c4 10             	add    $0x10,%esp
801025d0:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801025d6:	85 c0                	test   %eax,%eax
801025d8:	74 08                	je     801025e2 <kalloc+0x52>
    kmem.freelist = r->next;
801025da:	8b 08                	mov    (%eax),%ecx
801025dc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801025e2:	85 d2                	test   %edx,%edx
801025e4:	74 16                	je     801025fc <kalloc+0x6c>
    release(&kmem.lock);
801025e6:	83 ec 0c             	sub    $0xc,%esp
801025e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801025ec:	68 40 26 11 80       	push   $0x80112640
801025f1:	e8 da 1e 00 00       	call   801044d0 <release>
  return (char*)r;
801025f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801025f9:	83 c4 10             	add    $0x10,%esp
}
801025fc:	c9                   	leave  
801025fd:	c3                   	ret    
801025fe:	66 90                	xchg   %ax,%ax

80102600 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102600:	ba 64 00 00 00       	mov    $0x64,%edx
80102605:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102606:	a8 01                	test   $0x1,%al
80102608:	0f 84 c2 00 00 00    	je     801026d0 <kbdgetc+0xd0>
8010260e:	ba 60 00 00 00       	mov    $0x60,%edx
80102613:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102614:	0f b6 d0             	movzbl %al,%edx
80102617:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010261d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102623:	0f 84 7f 00 00 00    	je     801026a8 <kbdgetc+0xa8>
{
80102629:	55                   	push   %ebp
8010262a:	89 e5                	mov    %esp,%ebp
8010262c:	53                   	push   %ebx
8010262d:	89 cb                	mov    %ecx,%ebx
8010262f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102632:	84 c0                	test   %al,%al
80102634:	78 4a                	js     80102680 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102636:	85 db                	test   %ebx,%ebx
80102638:	74 09                	je     80102643 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010263a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010263d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102640:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102643:	0f b6 82 20 73 10 80 	movzbl -0x7fef8ce0(%edx),%eax
8010264a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010264c:	0f b6 82 20 72 10 80 	movzbl -0x7fef8de0(%edx),%eax
80102653:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102655:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102657:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010265d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102660:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102663:	8b 04 85 00 72 10 80 	mov    -0x7fef8e00(,%eax,4),%eax
8010266a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010266e:	74 31                	je     801026a1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102670:	8d 50 9f             	lea    -0x61(%eax),%edx
80102673:	83 fa 19             	cmp    $0x19,%edx
80102676:	77 40                	ja     801026b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102678:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010267b:	5b                   	pop    %ebx
8010267c:	5d                   	pop    %ebp
8010267d:	c3                   	ret    
8010267e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102680:	83 e0 7f             	and    $0x7f,%eax
80102683:	85 db                	test   %ebx,%ebx
80102685:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102688:	0f b6 82 20 73 10 80 	movzbl -0x7fef8ce0(%edx),%eax
8010268f:	83 c8 40             	or     $0x40,%eax
80102692:	0f b6 c0             	movzbl %al,%eax
80102695:	f7 d0                	not    %eax
80102697:	21 c1                	and    %eax,%ecx
    return 0;
80102699:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010269b:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801026a1:	5b                   	pop    %ebx
801026a2:	5d                   	pop    %ebp
801026a3:	c3                   	ret    
801026a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801026a8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801026ab:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026ad:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801026b3:	c3                   	ret    
801026b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026bb:	8d 50 20             	lea    0x20(%eax),%edx
}
801026be:	5b                   	pop    %ebx
      c += 'a' - 'A';
801026bf:	83 f9 1a             	cmp    $0x1a,%ecx
801026c2:	0f 42 c2             	cmovb  %edx,%eax
}
801026c5:	5d                   	pop    %ebp
801026c6:	c3                   	ret    
801026c7:	89 f6                	mov    %esi,%esi
801026c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801026d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801026d5:	c3                   	ret    
801026d6:	8d 76 00             	lea    0x0(%esi),%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026e0 <kbdintr>:

void
kbdintr(void)
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026e6:	68 00 26 10 80       	push   $0x80102600
801026eb:	e8 e0 e1 ff ff       	call   801008d0 <consoleintr>
}
801026f0:	83 c4 10             	add    $0x10,%esp
801026f3:	c9                   	leave  
801026f4:	c3                   	ret    
801026f5:	66 90                	xchg   %ax,%ax
801026f7:	66 90                	xchg   %ax,%ax
801026f9:	66 90                	xchg   %ax,%ax
801026fb:	66 90                	xchg   %ax,%ax
801026fd:	66 90                	xchg   %ax,%ax
801026ff:	90                   	nop

80102700 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102700:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102705:	55                   	push   %ebp
80102706:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102708:	85 c0                	test   %eax,%eax
8010270a:	0f 84 c8 00 00 00    	je     801027d8 <lapicinit+0xd8>
  lapic[index] = value;
80102710:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102717:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010271a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010271d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102724:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102727:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010272a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102731:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102734:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102737:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010273e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102741:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102744:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010274b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010274e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102751:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102758:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010275b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010275e:	8b 50 30             	mov    0x30(%eax),%edx
80102761:	c1 ea 10             	shr    $0x10,%edx
80102764:	80 fa 03             	cmp    $0x3,%dl
80102767:	77 77                	ja     801027e0 <lapicinit+0xe0>
  lapic[index] = value;
80102769:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102770:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102773:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102776:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010277d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102780:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102783:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010278a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010278d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102790:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102797:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010279a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010279d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027aa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027b1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027b4:	8b 50 20             	mov    0x20(%eax),%edx
801027b7:	89 f6                	mov    %esi,%esi
801027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027c0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027c6:	80 e6 10             	and    $0x10,%dh
801027c9:	75 f5                	jne    801027c0 <lapicinit+0xc0>
  lapic[index] = value;
801027cb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027d2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027d8:	5d                   	pop    %ebp
801027d9:	c3                   	ret    
801027da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801027e0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027e7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027ea:	8b 50 20             	mov    0x20(%eax),%edx
801027ed:	e9 77 ff ff ff       	jmp    80102769 <lapicinit+0x69>
801027f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102800 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102800:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
{
80102806:	55                   	push   %ebp
80102807:	31 c0                	xor    %eax,%eax
80102809:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010280b:	85 d2                	test   %edx,%edx
8010280d:	74 06                	je     80102815 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010280f:	8b 42 20             	mov    0x20(%edx),%eax
80102812:	c1 e8 18             	shr    $0x18,%eax
}
80102815:	5d                   	pop    %ebp
80102816:	c3                   	ret    
80102817:	89 f6                	mov    %esi,%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102820 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102820:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102825:	55                   	push   %ebp
80102826:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102828:	85 c0                	test   %eax,%eax
8010282a:	74 0d                	je     80102839 <lapiceoi+0x19>
  lapic[index] = value;
8010282c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102833:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102836:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102839:	5d                   	pop    %ebp
8010283a:	c3                   	ret    
8010283b:	90                   	nop
8010283c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102840 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102840:	55                   	push   %ebp
80102841:	89 e5                	mov    %esp,%ebp
}
80102843:	5d                   	pop    %ebp
80102844:	c3                   	ret    
80102845:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102850 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102850:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102851:	b8 0f 00 00 00       	mov    $0xf,%eax
80102856:	ba 70 00 00 00       	mov    $0x70,%edx
8010285b:	89 e5                	mov    %esp,%ebp
8010285d:	53                   	push   %ebx
8010285e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102861:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102864:	ee                   	out    %al,(%dx)
80102865:	b8 0a 00 00 00       	mov    $0xa,%eax
8010286a:	ba 71 00 00 00       	mov    $0x71,%edx
8010286f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102870:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102872:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102875:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010287b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010287d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102880:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102883:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102885:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102888:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010288e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102893:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102899:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010289c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028bc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028da:	5b                   	pop    %ebx
801028db:	5d                   	pop    %ebp
801028dc:	c3                   	ret    
801028dd:	8d 76 00             	lea    0x0(%esi),%esi

801028e0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028e0:	55                   	push   %ebp
801028e1:	b8 0b 00 00 00       	mov    $0xb,%eax
801028e6:	ba 70 00 00 00       	mov    $0x70,%edx
801028eb:	89 e5                	mov    %esp,%ebp
801028ed:	57                   	push   %edi
801028ee:	56                   	push   %esi
801028ef:	53                   	push   %ebx
801028f0:	83 ec 4c             	sub    $0x4c,%esp
801028f3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f4:	ba 71 00 00 00       	mov    $0x71,%edx
801028f9:	ec                   	in     (%dx),%al
801028fa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028fd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102902:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102905:	8d 76 00             	lea    0x0(%esi),%esi
80102908:	31 c0                	xor    %eax,%eax
8010290a:	89 da                	mov    %ebx,%edx
8010290c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102912:	89 ca                	mov    %ecx,%edx
80102914:	ec                   	in     (%dx),%al
80102915:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102918:	89 da                	mov    %ebx,%edx
8010291a:	b8 02 00 00 00       	mov    $0x2,%eax
8010291f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102920:	89 ca                	mov    %ecx,%edx
80102922:	ec                   	in     (%dx),%al
80102923:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102926:	89 da                	mov    %ebx,%edx
80102928:	b8 04 00 00 00       	mov    $0x4,%eax
8010292d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292e:	89 ca                	mov    %ecx,%edx
80102930:	ec                   	in     (%dx),%al
80102931:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102934:	89 da                	mov    %ebx,%edx
80102936:	b8 07 00 00 00       	mov    $0x7,%eax
8010293b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293c:	89 ca                	mov    %ecx,%edx
8010293e:	ec                   	in     (%dx),%al
8010293f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102942:	89 da                	mov    %ebx,%edx
80102944:	b8 08 00 00 00       	mov    $0x8,%eax
80102949:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294a:	89 ca                	mov    %ecx,%edx
8010294c:	ec                   	in     (%dx),%al
8010294d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010294f:	89 da                	mov    %ebx,%edx
80102951:	b8 09 00 00 00       	mov    $0x9,%eax
80102956:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102957:	89 ca                	mov    %ecx,%edx
80102959:	ec                   	in     (%dx),%al
8010295a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295c:	89 da                	mov    %ebx,%edx
8010295e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102963:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102964:	89 ca                	mov    %ecx,%edx
80102966:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102967:	84 c0                	test   %al,%al
80102969:	78 9d                	js     80102908 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010296b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010296f:	89 fa                	mov    %edi,%edx
80102971:	0f b6 fa             	movzbl %dl,%edi
80102974:	89 f2                	mov    %esi,%edx
80102976:	0f b6 f2             	movzbl %dl,%esi
80102979:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297c:	89 da                	mov    %ebx,%edx
8010297e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102981:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102984:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102988:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010298b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010298f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102992:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102996:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102999:	31 c0                	xor    %eax,%eax
8010299b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299c:	89 ca                	mov    %ecx,%edx
8010299e:	ec                   	in     (%dx),%al
8010299f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a2:	89 da                	mov    %ebx,%edx
801029a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029a7:	b8 02 00 00 00       	mov    $0x2,%eax
801029ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ad:	89 ca                	mov    %ecx,%edx
801029af:	ec                   	in     (%dx),%al
801029b0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b3:	89 da                	mov    %ebx,%edx
801029b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029b8:	b8 04 00 00 00       	mov    $0x4,%eax
801029bd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029be:	89 ca                	mov    %ecx,%edx
801029c0:	ec                   	in     (%dx),%al
801029c1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c4:	89 da                	mov    %ebx,%edx
801029c6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029c9:	b8 07 00 00 00       	mov    $0x7,%eax
801029ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cf:	89 ca                	mov    %ecx,%edx
801029d1:	ec                   	in     (%dx),%al
801029d2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d5:	89 da                	mov    %ebx,%edx
801029d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029da:	b8 08 00 00 00       	mov    $0x8,%eax
801029df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e0:	89 ca                	mov    %ecx,%edx
801029e2:	ec                   	in     (%dx),%al
801029e3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e6:	89 da                	mov    %ebx,%edx
801029e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029eb:	b8 09 00 00 00       	mov    $0x9,%eax
801029f0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f1:	89 ca                	mov    %ecx,%edx
801029f3:	ec                   	in     (%dx),%al
801029f4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029f7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801029fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029fd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a00:	6a 18                	push   $0x18
80102a02:	50                   	push   %eax
80102a03:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a06:	50                   	push   %eax
80102a07:	e8 64 1b 00 00       	call   80104570 <memcmp>
80102a0c:	83 c4 10             	add    $0x10,%esp
80102a0f:	85 c0                	test   %eax,%eax
80102a11:	0f 85 f1 fe ff ff    	jne    80102908 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a17:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a1b:	75 78                	jne    80102a95 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a1d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a20:	89 c2                	mov    %eax,%edx
80102a22:	83 e0 0f             	and    $0xf,%eax
80102a25:	c1 ea 04             	shr    $0x4,%edx
80102a28:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a2b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a2e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a31:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a34:	89 c2                	mov    %eax,%edx
80102a36:	83 e0 0f             	and    $0xf,%eax
80102a39:	c1 ea 04             	shr    $0x4,%edx
80102a3c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a3f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a42:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a45:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a48:	89 c2                	mov    %eax,%edx
80102a4a:	83 e0 0f             	and    $0xf,%eax
80102a4d:	c1 ea 04             	shr    $0x4,%edx
80102a50:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a53:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a56:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a5c:	89 c2                	mov    %eax,%edx
80102a5e:	83 e0 0f             	and    $0xf,%eax
80102a61:	c1 ea 04             	shr    $0x4,%edx
80102a64:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a67:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a6d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a70:	89 c2                	mov    %eax,%edx
80102a72:	83 e0 0f             	and    $0xf,%eax
80102a75:	c1 ea 04             	shr    $0x4,%edx
80102a78:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a7e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a81:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a84:	89 c2                	mov    %eax,%edx
80102a86:	83 e0 0f             	and    $0xf,%eax
80102a89:	c1 ea 04             	shr    $0x4,%edx
80102a8c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a8f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a92:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a95:	8b 75 08             	mov    0x8(%ebp),%esi
80102a98:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a9b:	89 06                	mov    %eax,(%esi)
80102a9d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102aa0:	89 46 04             	mov    %eax,0x4(%esi)
80102aa3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102aa6:	89 46 08             	mov    %eax,0x8(%esi)
80102aa9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102aac:	89 46 0c             	mov    %eax,0xc(%esi)
80102aaf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ab2:	89 46 10             	mov    %eax,0x10(%esi)
80102ab5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ab8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102abb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ac2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ac5:	5b                   	pop    %ebx
80102ac6:	5e                   	pop    %esi
80102ac7:	5f                   	pop    %edi
80102ac8:	5d                   	pop    %ebp
80102ac9:	c3                   	ret    
80102aca:	66 90                	xchg   %ax,%ax
80102acc:	66 90                	xchg   %ax,%ax
80102ace:	66 90                	xchg   %ax,%ax

80102ad0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ad0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102ad6:	85 c9                	test   %ecx,%ecx
80102ad8:	0f 8e 8a 00 00 00    	jle    80102b68 <install_trans+0x98>
{
80102ade:	55                   	push   %ebp
80102adf:	89 e5                	mov    %esp,%ebp
80102ae1:	57                   	push   %edi
80102ae2:	56                   	push   %esi
80102ae3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ae4:	31 db                	xor    %ebx,%ebx
{
80102ae6:	83 ec 0c             	sub    $0xc,%esp
80102ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102af0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102af5:	83 ec 08             	sub    $0x8,%esp
80102af8:	01 d8                	add    %ebx,%eax
80102afa:	83 c0 01             	add    $0x1,%eax
80102afd:	50                   	push   %eax
80102afe:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	58                   	pop    %eax
80102b0c:	5a                   	pop    %edx
80102b0d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102b14:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b1a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b1d:	e8 ae d5 ff ff       	call   801000d0 <bread>
80102b22:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b24:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b27:	83 c4 0c             	add    $0xc,%esp
80102b2a:	68 00 02 00 00       	push   $0x200
80102b2f:	50                   	push   %eax
80102b30:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b33:	50                   	push   %eax
80102b34:	e8 97 1a 00 00       	call   801045d0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b39:	89 34 24             	mov    %esi,(%esp)
80102b3c:	e8 5f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b41:	89 3c 24             	mov    %edi,(%esp)
80102b44:	e8 97 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b49:	89 34 24             	mov    %esi,(%esp)
80102b4c:	e8 8f d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b51:	83 c4 10             	add    $0x10,%esp
80102b54:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102b5a:	7f 94                	jg     80102af0 <install_trans+0x20>
  }
}
80102b5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b5f:	5b                   	pop    %ebx
80102b60:	5e                   	pop    %esi
80102b61:	5f                   	pop    %edi
80102b62:	5d                   	pop    %ebp
80102b63:	c3                   	ret    
80102b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b68:	f3 c3                	repz ret 
80102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	56                   	push   %esi
80102b74:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102b75:	83 ec 08             	sub    $0x8,%esp
80102b78:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102b7e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b84:	e8 47 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b89:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b8f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b92:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102b94:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102b96:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b99:	7e 16                	jle    80102bb1 <write_head+0x41>
80102b9b:	c1 e3 02             	shl    $0x2,%ebx
80102b9e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ba0:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102ba6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102baa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102bad:	39 da                	cmp    %ebx,%edx
80102baf:	75 ef                	jne    80102ba0 <write_head+0x30>
  }
  bwrite(buf);
80102bb1:	83 ec 0c             	sub    $0xc,%esp
80102bb4:	56                   	push   %esi
80102bb5:	e8 e6 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bba:	89 34 24             	mov    %esi,(%esp)
80102bbd:	e8 1e d6 ff ff       	call   801001e0 <brelse>
}
80102bc2:	83 c4 10             	add    $0x10,%esp
80102bc5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102bc8:	5b                   	pop    %ebx
80102bc9:	5e                   	pop    %esi
80102bca:	5d                   	pop    %ebp
80102bcb:	c3                   	ret    
80102bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102bd0 <initlog>:
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	53                   	push   %ebx
80102bd4:	83 ec 2c             	sub    $0x2c,%esp
80102bd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bda:	68 20 74 10 80       	push   $0x80107420
80102bdf:	68 80 26 11 80       	push   $0x80112680
80102be4:	e8 e7 16 00 00       	call   801042d0 <initlock>
  readsb(dev, &sb);
80102be9:	58                   	pop    %eax
80102bea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bed:	5a                   	pop    %edx
80102bee:	50                   	push   %eax
80102bef:	53                   	push   %ebx
80102bf0:	e8 9b e8 ff ff       	call   80101490 <readsb>
  log.size = sb.nlog;
80102bf5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102bf8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102bfb:	59                   	pop    %ecx
  log.dev = dev;
80102bfc:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102c02:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102c08:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102c0d:	5a                   	pop    %edx
80102c0e:	50                   	push   %eax
80102c0f:	53                   	push   %ebx
80102c10:	e8 bb d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c15:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c18:	83 c4 10             	add    $0x10,%esp
80102c1b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c1d:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102c23:	7e 1c                	jle    80102c41 <initlog+0x71>
80102c25:	c1 e3 02             	shl    $0x2,%ebx
80102c28:	31 d2                	xor    %edx,%edx
80102c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102c30:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c34:	83 c2 04             	add    $0x4,%edx
80102c37:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c3d:	39 d3                	cmp    %edx,%ebx
80102c3f:	75 ef                	jne    80102c30 <initlog+0x60>
  brelse(buf);
80102c41:	83 ec 0c             	sub    $0xc,%esp
80102c44:	50                   	push   %eax
80102c45:	e8 96 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c4a:	e8 81 fe ff ff       	call   80102ad0 <install_trans>
  log.lh.n = 0;
80102c4f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c56:	00 00 00 
  write_head(); // clear the log
80102c59:	e8 12 ff ff ff       	call   80102b70 <write_head>
}
80102c5e:	83 c4 10             	add    $0x10,%esp
80102c61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c64:	c9                   	leave  
80102c65:	c3                   	ret    
80102c66:	8d 76 00             	lea    0x0(%esi),%esi
80102c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c76:	68 80 26 11 80       	push   $0x80112680
80102c7b:	e8 90 17 00 00       	call   80104410 <acquire>
80102c80:	83 c4 10             	add    $0x10,%esp
80102c83:	eb 18                	jmp    80102c9d <begin_op+0x2d>
80102c85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c88:	83 ec 08             	sub    $0x8,%esp
80102c8b:	68 80 26 11 80       	push   $0x80112680
80102c90:	68 80 26 11 80       	push   $0x80112680
80102c95:	e8 b6 11 00 00       	call   80103e50 <sleep>
80102c9a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102c9d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102ca2:	85 c0                	test   %eax,%eax
80102ca4:	75 e2                	jne    80102c88 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ca6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102cab:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102cb1:	83 c0 01             	add    $0x1,%eax
80102cb4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cb7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cba:	83 fa 1e             	cmp    $0x1e,%edx
80102cbd:	7f c9                	jg     80102c88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cbf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cc2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102cc7:	68 80 26 11 80       	push   $0x80112680
80102ccc:	e8 ff 17 00 00       	call   801044d0 <release>
      break;
    }
  }
}
80102cd1:	83 c4 10             	add    $0x10,%esp
80102cd4:	c9                   	leave  
80102cd5:	c3                   	ret    
80102cd6:	8d 76 00             	lea    0x0(%esi),%esi
80102cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
80102ce6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ce9:	68 80 26 11 80       	push   $0x80112680
80102cee:	e8 1d 17 00 00       	call   80104410 <acquire>
  log.outstanding -= 1;
80102cf3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102cf8:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102cfe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d01:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d04:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102d06:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102d0c:	0f 85 1a 01 00 00    	jne    80102e2c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102d12:	85 db                	test   %ebx,%ebx
80102d14:	0f 85 ee 00 00 00    	jne    80102e08 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d1a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d1d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102d24:	00 00 00 
  release(&log.lock);
80102d27:	68 80 26 11 80       	push   $0x80112680
80102d2c:	e8 9f 17 00 00       	call   801044d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d31:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d37:	83 c4 10             	add    $0x10,%esp
80102d3a:	85 c9                	test   %ecx,%ecx
80102d3c:	0f 8e 85 00 00 00    	jle    80102dc7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d42:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d47:	83 ec 08             	sub    $0x8,%esp
80102d4a:	01 d8                	add    %ebx,%eax
80102d4c:	83 c0 01             	add    $0x1,%eax
80102d4f:	50                   	push   %eax
80102d50:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102d56:	e8 75 d3 ff ff       	call   801000d0 <bread>
80102d5b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d5d:	58                   	pop    %eax
80102d5e:	5a                   	pop    %edx
80102d5f:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102d66:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d6c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d6f:	e8 5c d3 ff ff       	call   801000d0 <bread>
80102d74:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d76:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d79:	83 c4 0c             	add    $0xc,%esp
80102d7c:	68 00 02 00 00       	push   $0x200
80102d81:	50                   	push   %eax
80102d82:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d85:	50                   	push   %eax
80102d86:	e8 45 18 00 00       	call   801045d0 <memmove>
    bwrite(to);  // write the log
80102d8b:	89 34 24             	mov    %esi,(%esp)
80102d8e:	e8 0d d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d93:	89 3c 24             	mov    %edi,(%esp)
80102d96:	e8 45 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d9b:	89 34 24             	mov    %esi,(%esp)
80102d9e:	e8 3d d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102da3:	83 c4 10             	add    $0x10,%esp
80102da6:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102dac:	7c 94                	jl     80102d42 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dae:	e8 bd fd ff ff       	call   80102b70 <write_head>
    install_trans(); // Now install writes to home locations
80102db3:	e8 18 fd ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102db8:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102dbf:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dc2:	e8 a9 fd ff ff       	call   80102b70 <write_head>
    acquire(&log.lock);
80102dc7:	83 ec 0c             	sub    $0xc,%esp
80102dca:	68 80 26 11 80       	push   $0x80112680
80102dcf:	e8 3c 16 00 00       	call   80104410 <acquire>
    wakeup(&log);
80102dd4:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102ddb:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102de2:	00 00 00 
    wakeup(&log);
80102de5:	e8 16 12 00 00       	call   80104000 <wakeup>
    release(&log.lock);
80102dea:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102df1:	e8 da 16 00 00       	call   801044d0 <release>
80102df6:	83 c4 10             	add    $0x10,%esp
}
80102df9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dfc:	5b                   	pop    %ebx
80102dfd:	5e                   	pop    %esi
80102dfe:	5f                   	pop    %edi
80102dff:	5d                   	pop    %ebp
80102e00:	c3                   	ret    
80102e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102e08:	83 ec 0c             	sub    $0xc,%esp
80102e0b:	68 80 26 11 80       	push   $0x80112680
80102e10:	e8 eb 11 00 00       	call   80104000 <wakeup>
  release(&log.lock);
80102e15:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e1c:	e8 af 16 00 00       	call   801044d0 <release>
80102e21:	83 c4 10             	add    $0x10,%esp
}
80102e24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e27:	5b                   	pop    %ebx
80102e28:	5e                   	pop    %esi
80102e29:	5f                   	pop    %edi
80102e2a:	5d                   	pop    %ebp
80102e2b:	c3                   	ret    
    panic("log.committing");
80102e2c:	83 ec 0c             	sub    $0xc,%esp
80102e2f:	68 24 74 10 80       	push   $0x80107424
80102e34:	e8 57 d5 ff ff       	call   80100390 <panic>
80102e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	53                   	push   %ebx
80102e44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e47:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102e4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e50:	83 fa 1d             	cmp    $0x1d,%edx
80102e53:	0f 8f 9d 00 00 00    	jg     80102ef6 <log_write+0xb6>
80102e59:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102e5e:	83 e8 01             	sub    $0x1,%eax
80102e61:	39 c2                	cmp    %eax,%edx
80102e63:	0f 8d 8d 00 00 00    	jge    80102ef6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e69:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102e6e:	85 c0                	test   %eax,%eax
80102e70:	0f 8e 8d 00 00 00    	jle    80102f03 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e76:	83 ec 0c             	sub    $0xc,%esp
80102e79:	68 80 26 11 80       	push   $0x80112680
80102e7e:	e8 8d 15 00 00       	call   80104410 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e83:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102e89:	83 c4 10             	add    $0x10,%esp
80102e8c:	83 f9 00             	cmp    $0x0,%ecx
80102e8f:	7e 57                	jle    80102ee8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e91:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e94:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e96:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102e9c:	75 0b                	jne    80102ea9 <log_write+0x69>
80102e9e:	eb 38                	jmp    80102ed8 <log_write+0x98>
80102ea0:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102ea7:	74 2f                	je     80102ed8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102ea9:	83 c0 01             	add    $0x1,%eax
80102eac:	39 c1                	cmp    %eax,%ecx
80102eae:	75 f0                	jne    80102ea0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102eb0:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102eb7:	83 c0 01             	add    $0x1,%eax
80102eba:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102ebf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ec2:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102ec9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ecc:	c9                   	leave  
  release(&log.lock);
80102ecd:	e9 fe 15 00 00       	jmp    801044d0 <release>
80102ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ed8:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102edf:	eb de                	jmp    80102ebf <log_write+0x7f>
80102ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ee8:	8b 43 08             	mov    0x8(%ebx),%eax
80102eeb:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102ef0:	75 cd                	jne    80102ebf <log_write+0x7f>
80102ef2:	31 c0                	xor    %eax,%eax
80102ef4:	eb c1                	jmp    80102eb7 <log_write+0x77>
    panic("too big a transaction");
80102ef6:	83 ec 0c             	sub    $0xc,%esp
80102ef9:	68 33 74 10 80       	push   $0x80107433
80102efe:	e8 8d d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102f03:	83 ec 0c             	sub    $0xc,%esp
80102f06:	68 49 74 10 80       	push   $0x80107449
80102f0b:	e8 80 d4 ff ff       	call   80100390 <panic>

80102f10 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f17:	e8 74 09 00 00       	call   80103890 <cpuid>
80102f1c:	89 c3                	mov    %eax,%ebx
80102f1e:	e8 6d 09 00 00       	call   80103890 <cpuid>
80102f23:	83 ec 04             	sub    $0x4,%esp
80102f26:	53                   	push   %ebx
80102f27:	50                   	push   %eax
80102f28:	68 64 74 10 80       	push   $0x80107464
80102f2d:	e8 ee d7 ff ff       	call   80100720 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 69 28 00 00       	call   801057a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f37:	e8 d4 08 00 00       	call   80103810 <mycpu>
80102f3c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f3e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f43:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f4a:	e8 21 0c 00 00       	call   80103b70 <scheduler>
80102f4f:	90                   	nop

80102f50 <mpenter>:
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f56:	e8 35 39 00 00       	call   80106890 <switchkvm>
  seginit();
80102f5b:	e8 a0 38 00 00       	call   80106800 <seginit>
  lapicinit();
80102f60:	e8 9b f7 ff ff       	call   80102700 <lapicinit>
  mpmain();
80102f65:	e8 a6 ff ff ff       	call   80102f10 <mpmain>
80102f6a:	66 90                	xchg   %ax,%ax
80102f6c:	66 90                	xchg   %ax,%ax
80102f6e:	66 90                	xchg   %ax,%ax

80102f70 <main>:
{
80102f70:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f74:	83 e4 f0             	and    $0xfffffff0,%esp
80102f77:	ff 71 fc             	pushl  -0x4(%ecx)
80102f7a:	55                   	push   %ebp
80102f7b:	89 e5                	mov    %esp,%ebp
80102f7d:	53                   	push   %ebx
80102f7e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f7f:	83 ec 08             	sub    $0x8,%esp
80102f82:	68 00 00 40 80       	push   $0x80400000
80102f87:	68 a8 54 11 80       	push   $0x801154a8
80102f8c:	e8 2f f5 ff ff       	call   801024c0 <kinit1>
  kvmalloc();      // kernel page table
80102f91:	e8 ca 3d 00 00       	call   80106d60 <kvmalloc>
  mpinit();        // detect other processors
80102f96:	e8 75 01 00 00       	call   80103110 <mpinit>
  lapicinit();     // interrupt controller
80102f9b:	e8 60 f7 ff ff       	call   80102700 <lapicinit>
  seginit();       // segment descriptors
80102fa0:	e8 5b 38 00 00       	call   80106800 <seginit>
  picinit();       // disable pic
80102fa5:	e8 46 03 00 00       	call   801032f0 <picinit>
  ioapicinit();    // another interrupt controller
80102faa:	e8 41 f3 ff ff       	call   801022f0 <ioapicinit>
  consoleinit();   // console hardware
80102faf:	e8 cc da ff ff       	call   80100a80 <consoleinit>
  uartinit();      // serial port
80102fb4:	e8 17 2b 00 00       	call   80105ad0 <uartinit>
  pinit();         // process table
80102fb9:	e8 32 08 00 00       	call   801037f0 <pinit>
  tvinit();        // trap vectors
80102fbe:	e8 5d 27 00 00       	call   80105720 <tvinit>
  binit();         // buffer cache
80102fc3:	e8 78 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fc8:	e8 53 de ff ff       	call   80100e20 <fileinit>
  ideinit();       // disk 
80102fcd:	e8 fe f0 ff ff       	call   801020d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fd2:	83 c4 0c             	add    $0xc,%esp
80102fd5:	68 8a 00 00 00       	push   $0x8a
80102fda:	68 8c a4 10 80       	push   $0x8010a48c
80102fdf:	68 00 70 00 80       	push   $0x80007000
80102fe4:	e8 e7 15 00 00       	call   801045d0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fe9:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ff0:	00 00 00 
80102ff3:	83 c4 10             	add    $0x10,%esp
80102ff6:	05 80 27 11 80       	add    $0x80112780,%eax
80102ffb:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80103000:	76 71                	jbe    80103073 <main+0x103>
80103002:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80103007:	89 f6                	mov    %esi,%esi
80103009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103010:	e8 fb 07 00 00       	call   80103810 <mycpu>
80103015:	39 d8                	cmp    %ebx,%eax
80103017:	74 41                	je     8010305a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103019:	e8 72 f5 ff ff       	call   80102590 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010301e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103023:	c7 05 f8 6f 00 80 50 	movl   $0x80102f50,0x80006ff8
8010302a:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010302d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80103034:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103037:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010303c:	0f b6 03             	movzbl (%ebx),%eax
8010303f:	83 ec 08             	sub    $0x8,%esp
80103042:	68 00 70 00 00       	push   $0x7000
80103047:	50                   	push   %eax
80103048:	e8 03 f8 ff ff       	call   80102850 <lapicstartap>
8010304d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103050:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103056:	85 c0                	test   %eax,%eax
80103058:	74 f6                	je     80103050 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010305a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103061:	00 00 00 
80103064:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010306a:	05 80 27 11 80       	add    $0x80112780,%eax
8010306f:	39 c3                	cmp    %eax,%ebx
80103071:	72 9d                	jb     80103010 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103073:	83 ec 08             	sub    $0x8,%esp
80103076:	68 00 00 00 8e       	push   $0x8e000000
8010307b:	68 00 00 40 80       	push   $0x80400000
80103080:	e8 ab f4 ff ff       	call   80102530 <kinit2>
  userinit();      // first user process
80103085:	e8 56 08 00 00       	call   801038e0 <userinit>
  mpmain();        // finish this processor's setup
8010308a:	e8 81 fe ff ff       	call   80102f10 <mpmain>
8010308f:	90                   	nop

80103090 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103090:	55                   	push   %ebp
80103091:	89 e5                	mov    %esp,%ebp
80103093:	57                   	push   %edi
80103094:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103095:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010309b:	53                   	push   %ebx
  e = addr+len;
8010309c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010309f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801030a2:	39 de                	cmp    %ebx,%esi
801030a4:	72 10                	jb     801030b6 <mpsearch1+0x26>
801030a6:	eb 50                	jmp    801030f8 <mpsearch1+0x68>
801030a8:	90                   	nop
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030b0:	39 fb                	cmp    %edi,%ebx
801030b2:	89 fe                	mov    %edi,%esi
801030b4:	76 42                	jbe    801030f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030b6:	83 ec 04             	sub    $0x4,%esp
801030b9:	8d 7e 10             	lea    0x10(%esi),%edi
801030bc:	6a 04                	push   $0x4
801030be:	68 78 74 10 80       	push   $0x80107478
801030c3:	56                   	push   %esi
801030c4:	e8 a7 14 00 00       	call   80104570 <memcmp>
801030c9:	83 c4 10             	add    $0x10,%esp
801030cc:	85 c0                	test   %eax,%eax
801030ce:	75 e0                	jne    801030b0 <mpsearch1+0x20>
801030d0:	89 f1                	mov    %esi,%ecx
801030d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801030d8:	0f b6 11             	movzbl (%ecx),%edx
801030db:	83 c1 01             	add    $0x1,%ecx
801030de:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801030e0:	39 f9                	cmp    %edi,%ecx
801030e2:	75 f4                	jne    801030d8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030e4:	84 c0                	test   %al,%al
801030e6:	75 c8                	jne    801030b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030eb:	89 f0                	mov    %esi,%eax
801030ed:	5b                   	pop    %ebx
801030ee:	5e                   	pop    %esi
801030ef:	5f                   	pop    %edi
801030f0:	5d                   	pop    %ebp
801030f1:	c3                   	ret    
801030f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801030fb:	31 f6                	xor    %esi,%esi
}
801030fd:	89 f0                	mov    %esi,%eax
801030ff:	5b                   	pop    %ebx
80103100:	5e                   	pop    %esi
80103101:	5f                   	pop    %edi
80103102:	5d                   	pop    %ebp
80103103:	c3                   	ret    
80103104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010310a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103110 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	57                   	push   %edi
80103114:	56                   	push   %esi
80103115:	53                   	push   %ebx
80103116:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103119:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103120:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103127:	c1 e0 08             	shl    $0x8,%eax
8010312a:	09 d0                	or     %edx,%eax
8010312c:	c1 e0 04             	shl    $0x4,%eax
8010312f:	85 c0                	test   %eax,%eax
80103131:	75 1b                	jne    8010314e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103133:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010313a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103141:	c1 e0 08             	shl    $0x8,%eax
80103144:	09 d0                	or     %edx,%eax
80103146:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103149:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010314e:	ba 00 04 00 00       	mov    $0x400,%edx
80103153:	e8 38 ff ff ff       	call   80103090 <mpsearch1>
80103158:	85 c0                	test   %eax,%eax
8010315a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010315d:	0f 84 3d 01 00 00    	je     801032a0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103163:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103166:	8b 58 04             	mov    0x4(%eax),%ebx
80103169:	85 db                	test   %ebx,%ebx
8010316b:	0f 84 4f 01 00 00    	je     801032c0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103171:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103177:	83 ec 04             	sub    $0x4,%esp
8010317a:	6a 04                	push   $0x4
8010317c:	68 95 74 10 80       	push   $0x80107495
80103181:	56                   	push   %esi
80103182:	e8 e9 13 00 00       	call   80104570 <memcmp>
80103187:	83 c4 10             	add    $0x10,%esp
8010318a:	85 c0                	test   %eax,%eax
8010318c:	0f 85 2e 01 00 00    	jne    801032c0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103192:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103199:	3c 01                	cmp    $0x1,%al
8010319b:	0f 95 c2             	setne  %dl
8010319e:	3c 04                	cmp    $0x4,%al
801031a0:	0f 95 c0             	setne  %al
801031a3:	20 c2                	and    %al,%dl
801031a5:	0f 85 15 01 00 00    	jne    801032c0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801031ab:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801031b2:	66 85 ff             	test   %di,%di
801031b5:	74 1a                	je     801031d1 <mpinit+0xc1>
801031b7:	89 f0                	mov    %esi,%eax
801031b9:	01 f7                	add    %esi,%edi
  sum = 0;
801031bb:	31 d2                	xor    %edx,%edx
801031bd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801031c0:	0f b6 08             	movzbl (%eax),%ecx
801031c3:	83 c0 01             	add    $0x1,%eax
801031c6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801031c8:	39 c7                	cmp    %eax,%edi
801031ca:	75 f4                	jne    801031c0 <mpinit+0xb0>
801031cc:	84 d2                	test   %dl,%dl
801031ce:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031d1:	85 f6                	test   %esi,%esi
801031d3:	0f 84 e7 00 00 00    	je     801032c0 <mpinit+0x1b0>
801031d9:	84 d2                	test   %dl,%dl
801031db:	0f 85 df 00 00 00    	jne    801032c0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031e1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031e7:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031ec:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801031f3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801031f9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031fe:	01 d6                	add    %edx,%esi
80103200:	39 c6                	cmp    %eax,%esi
80103202:	76 23                	jbe    80103227 <mpinit+0x117>
    switch(*p){
80103204:	0f b6 10             	movzbl (%eax),%edx
80103207:	80 fa 04             	cmp    $0x4,%dl
8010320a:	0f 87 ca 00 00 00    	ja     801032da <mpinit+0x1ca>
80103210:	ff 24 95 bc 74 10 80 	jmp    *-0x7fef8b44(,%edx,4)
80103217:	89 f6                	mov    %esi,%esi
80103219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103220:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103223:	39 c6                	cmp    %eax,%esi
80103225:	77 dd                	ja     80103204 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103227:	85 db                	test   %ebx,%ebx
80103229:	0f 84 9e 00 00 00    	je     801032cd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010322f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103232:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103236:	74 15                	je     8010324d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103238:	b8 70 00 00 00       	mov    $0x70,%eax
8010323d:	ba 22 00 00 00       	mov    $0x22,%edx
80103242:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103243:	ba 23 00 00 00       	mov    $0x23,%edx
80103248:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103249:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010324c:	ee                   	out    %al,(%dx)
  }
}
8010324d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103250:	5b                   	pop    %ebx
80103251:	5e                   	pop    %esi
80103252:	5f                   	pop    %edi
80103253:	5d                   	pop    %ebp
80103254:	c3                   	ret    
80103255:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103258:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010325e:	83 f9 07             	cmp    $0x7,%ecx
80103261:	7f 19                	jg     8010327c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103263:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103267:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010326d:	83 c1 01             	add    $0x1,%ecx
80103270:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103276:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
8010327c:	83 c0 14             	add    $0x14,%eax
      continue;
8010327f:	e9 7c ff ff ff       	jmp    80103200 <mpinit+0xf0>
80103284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103288:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010328c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010328f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
80103295:	e9 66 ff ff ff       	jmp    80103200 <mpinit+0xf0>
8010329a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801032a0:	ba 00 00 01 00       	mov    $0x10000,%edx
801032a5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032aa:	e8 e1 fd ff ff       	call   80103090 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032af:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801032b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032b4:	0f 85 a9 fe ff ff    	jne    80103163 <mpinit+0x53>
801032ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801032c0:	83 ec 0c             	sub    $0xc,%esp
801032c3:	68 7d 74 10 80       	push   $0x8010747d
801032c8:	e8 c3 d0 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801032cd:	83 ec 0c             	sub    $0xc,%esp
801032d0:	68 9c 74 10 80       	push   $0x8010749c
801032d5:	e8 b6 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
801032da:	31 db                	xor    %ebx,%ebx
801032dc:	e9 26 ff ff ff       	jmp    80103207 <mpinit+0xf7>
801032e1:	66 90                	xchg   %ax,%ax
801032e3:	66 90                	xchg   %ax,%ax
801032e5:	66 90                	xchg   %ax,%ax
801032e7:	66 90                	xchg   %ax,%ax
801032e9:	66 90                	xchg   %ax,%ax
801032eb:	66 90                	xchg   %ax,%ax
801032ed:	66 90                	xchg   %ax,%ax
801032ef:	90                   	nop

801032f0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801032f0:	55                   	push   %ebp
801032f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032f6:	ba 21 00 00 00       	mov    $0x21,%edx
801032fb:	89 e5                	mov    %esp,%ebp
801032fd:	ee                   	out    %al,(%dx)
801032fe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103303:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103304:	5d                   	pop    %ebp
80103305:	c3                   	ret    
80103306:	66 90                	xchg   %ax,%ax
80103308:	66 90                	xchg   %ax,%ax
8010330a:	66 90                	xchg   %ax,%ax
8010330c:	66 90                	xchg   %ax,%ax
8010330e:	66 90                	xchg   %ax,%ax

80103310 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	57                   	push   %edi
80103314:	56                   	push   %esi
80103315:	53                   	push   %ebx
80103316:	83 ec 0c             	sub    $0xc,%esp
80103319:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010331c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010331f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103325:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010332b:	e8 10 db ff ff       	call   80100e40 <filealloc>
80103330:	85 c0                	test   %eax,%eax
80103332:	89 03                	mov    %eax,(%ebx)
80103334:	74 22                	je     80103358 <pipealloc+0x48>
80103336:	e8 05 db ff ff       	call   80100e40 <filealloc>
8010333b:	85 c0                	test   %eax,%eax
8010333d:	89 06                	mov    %eax,(%esi)
8010333f:	74 3f                	je     80103380 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103341:	e8 4a f2 ff ff       	call   80102590 <kalloc>
80103346:	85 c0                	test   %eax,%eax
80103348:	89 c7                	mov    %eax,%edi
8010334a:	75 54                	jne    801033a0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010334c:	8b 03                	mov    (%ebx),%eax
8010334e:	85 c0                	test   %eax,%eax
80103350:	75 34                	jne    80103386 <pipealloc+0x76>
80103352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103358:	8b 06                	mov    (%esi),%eax
8010335a:	85 c0                	test   %eax,%eax
8010335c:	74 0c                	je     8010336a <pipealloc+0x5a>
    fileclose(*f1);
8010335e:	83 ec 0c             	sub    $0xc,%esp
80103361:	50                   	push   %eax
80103362:	e8 99 db ff ff       	call   80100f00 <fileclose>
80103367:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010336a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010336d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103372:	5b                   	pop    %ebx
80103373:	5e                   	pop    %esi
80103374:	5f                   	pop    %edi
80103375:	5d                   	pop    %ebp
80103376:	c3                   	ret    
80103377:	89 f6                	mov    %esi,%esi
80103379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103380:	8b 03                	mov    (%ebx),%eax
80103382:	85 c0                	test   %eax,%eax
80103384:	74 e4                	je     8010336a <pipealloc+0x5a>
    fileclose(*f0);
80103386:	83 ec 0c             	sub    $0xc,%esp
80103389:	50                   	push   %eax
8010338a:	e8 71 db ff ff       	call   80100f00 <fileclose>
  if(*f1)
8010338f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103391:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103394:	85 c0                	test   %eax,%eax
80103396:	75 c6                	jne    8010335e <pipealloc+0x4e>
80103398:	eb d0                	jmp    8010336a <pipealloc+0x5a>
8010339a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801033a0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801033a3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033aa:	00 00 00 
  p->writeopen = 1;
801033ad:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033b4:	00 00 00 
  p->nwrite = 0;
801033b7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033be:	00 00 00 
  p->nread = 0;
801033c1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033c8:	00 00 00 
  initlock(&p->lock, "pipe");
801033cb:	68 d0 74 10 80       	push   $0x801074d0
801033d0:	50                   	push   %eax
801033d1:	e8 fa 0e 00 00       	call   801042d0 <initlock>
  (*f0)->type = FD_PIPE;
801033d6:	8b 03                	mov    (%ebx),%eax
  return 0;
801033d8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033db:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033e1:	8b 03                	mov    (%ebx),%eax
801033e3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033e7:	8b 03                	mov    (%ebx),%eax
801033e9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033ed:	8b 03                	mov    (%ebx),%eax
801033ef:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033f2:	8b 06                	mov    (%esi),%eax
801033f4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033fa:	8b 06                	mov    (%esi),%eax
801033fc:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103400:	8b 06                	mov    (%esi),%eax
80103402:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103406:	8b 06                	mov    (%esi),%eax
80103408:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010340b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010340e:	31 c0                	xor    %eax,%eax
}
80103410:	5b                   	pop    %ebx
80103411:	5e                   	pop    %esi
80103412:	5f                   	pop    %edi
80103413:	5d                   	pop    %ebp
80103414:	c3                   	ret    
80103415:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103420 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	56                   	push   %esi
80103424:	53                   	push   %ebx
80103425:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103428:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010342b:	83 ec 0c             	sub    $0xc,%esp
8010342e:	53                   	push   %ebx
8010342f:	e8 dc 0f 00 00       	call   80104410 <acquire>
  if(writable){
80103434:	83 c4 10             	add    $0x10,%esp
80103437:	85 f6                	test   %esi,%esi
80103439:	74 45                	je     80103480 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010343b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103441:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103444:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010344b:	00 00 00 
    wakeup(&p->nread);
8010344e:	50                   	push   %eax
8010344f:	e8 ac 0b 00 00       	call   80104000 <wakeup>
80103454:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103457:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010345d:	85 d2                	test   %edx,%edx
8010345f:	75 0a                	jne    8010346b <pipeclose+0x4b>
80103461:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103467:	85 c0                	test   %eax,%eax
80103469:	74 35                	je     801034a0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010346b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010346e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103471:	5b                   	pop    %ebx
80103472:	5e                   	pop    %esi
80103473:	5d                   	pop    %ebp
    release(&p->lock);
80103474:	e9 57 10 00 00       	jmp    801044d0 <release>
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103480:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103486:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103489:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103490:	00 00 00 
    wakeup(&p->nwrite);
80103493:	50                   	push   %eax
80103494:	e8 67 0b 00 00       	call   80104000 <wakeup>
80103499:	83 c4 10             	add    $0x10,%esp
8010349c:	eb b9                	jmp    80103457 <pipeclose+0x37>
8010349e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	53                   	push   %ebx
801034a4:	e8 27 10 00 00       	call   801044d0 <release>
    kfree((char*)p);
801034a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034ac:	83 c4 10             	add    $0x10,%esp
}
801034af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034b2:	5b                   	pop    %ebx
801034b3:	5e                   	pop    %esi
801034b4:	5d                   	pop    %ebp
    kfree((char*)p);
801034b5:	e9 26 ef ff ff       	jmp    801023e0 <kfree>
801034ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034c0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	57                   	push   %edi
801034c4:	56                   	push   %esi
801034c5:	53                   	push   %ebx
801034c6:	83 ec 28             	sub    $0x28,%esp
801034c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034cc:	53                   	push   %ebx
801034cd:	e8 3e 0f 00 00       	call   80104410 <acquire>
  for(i = 0; i < n; i++){
801034d2:	8b 45 10             	mov    0x10(%ebp),%eax
801034d5:	83 c4 10             	add    $0x10,%esp
801034d8:	85 c0                	test   %eax,%eax
801034da:	0f 8e c9 00 00 00    	jle    801035a9 <pipewrite+0xe9>
801034e0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034e3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034e9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034ef:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801034f2:	03 4d 10             	add    0x10(%ebp),%ecx
801034f5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034f8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801034fe:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103504:	39 d0                	cmp    %edx,%eax
80103506:	75 71                	jne    80103579 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103508:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010350e:	85 c0                	test   %eax,%eax
80103510:	74 4e                	je     80103560 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103512:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103518:	eb 3a                	jmp    80103554 <pipewrite+0x94>
8010351a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103520:	83 ec 0c             	sub    $0xc,%esp
80103523:	57                   	push   %edi
80103524:	e8 d7 0a 00 00       	call   80104000 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103529:	5a                   	pop    %edx
8010352a:	59                   	pop    %ecx
8010352b:	53                   	push   %ebx
8010352c:	56                   	push   %esi
8010352d:	e8 1e 09 00 00       	call   80103e50 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103532:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103538:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010353e:	83 c4 10             	add    $0x10,%esp
80103541:	05 00 02 00 00       	add    $0x200,%eax
80103546:	39 c2                	cmp    %eax,%edx
80103548:	75 36                	jne    80103580 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010354a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103550:	85 c0                	test   %eax,%eax
80103552:	74 0c                	je     80103560 <pipewrite+0xa0>
80103554:	e8 57 03 00 00       	call   801038b0 <myproc>
80103559:	8b 40 24             	mov    0x24(%eax),%eax
8010355c:	85 c0                	test   %eax,%eax
8010355e:	74 c0                	je     80103520 <pipewrite+0x60>
        release(&p->lock);
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	53                   	push   %ebx
80103564:	e8 67 0f 00 00       	call   801044d0 <release>
        return -1;
80103569:	83 c4 10             	add    $0x10,%esp
8010356c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103571:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103574:	5b                   	pop    %ebx
80103575:	5e                   	pop    %esi
80103576:	5f                   	pop    %edi
80103577:	5d                   	pop    %ebp
80103578:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103579:	89 c2                	mov    %eax,%edx
8010357b:	90                   	nop
8010357c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103580:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103583:	8d 42 01             	lea    0x1(%edx),%eax
80103586:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010358c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103592:	83 c6 01             	add    $0x1,%esi
80103595:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103599:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010359c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010359f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801035a3:	0f 85 4f ff ff ff    	jne    801034f8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035a9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035af:	83 ec 0c             	sub    $0xc,%esp
801035b2:	50                   	push   %eax
801035b3:	e8 48 0a 00 00       	call   80104000 <wakeup>
  release(&p->lock);
801035b8:	89 1c 24             	mov    %ebx,(%esp)
801035bb:	e8 10 0f 00 00       	call   801044d0 <release>
  return n;
801035c0:	83 c4 10             	add    $0x10,%esp
801035c3:	8b 45 10             	mov    0x10(%ebp),%eax
801035c6:	eb a9                	jmp    80103571 <pipewrite+0xb1>
801035c8:	90                   	nop
801035c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035d0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 18             	sub    $0x18,%esp
801035d9:	8b 75 08             	mov    0x8(%ebp),%esi
801035dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035df:	56                   	push   %esi
801035e0:	e8 2b 0e 00 00       	call   80104410 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035e5:	83 c4 10             	add    $0x10,%esp
801035e8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035ee:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035f4:	75 6a                	jne    80103660 <piperead+0x90>
801035f6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801035fc:	85 db                	test   %ebx,%ebx
801035fe:	0f 84 c4 00 00 00    	je     801036c8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103604:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010360a:	eb 2d                	jmp    80103639 <piperead+0x69>
8010360c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103610:	83 ec 08             	sub    $0x8,%esp
80103613:	56                   	push   %esi
80103614:	53                   	push   %ebx
80103615:	e8 36 08 00 00       	call   80103e50 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010361a:	83 c4 10             	add    $0x10,%esp
8010361d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103623:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103629:	75 35                	jne    80103660 <piperead+0x90>
8010362b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103631:	85 d2                	test   %edx,%edx
80103633:	0f 84 8f 00 00 00    	je     801036c8 <piperead+0xf8>
    if(myproc()->killed){
80103639:	e8 72 02 00 00       	call   801038b0 <myproc>
8010363e:	8b 48 24             	mov    0x24(%eax),%ecx
80103641:	85 c9                	test   %ecx,%ecx
80103643:	74 cb                	je     80103610 <piperead+0x40>
      release(&p->lock);
80103645:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103648:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010364d:	56                   	push   %esi
8010364e:	e8 7d 0e 00 00       	call   801044d0 <release>
      return -1;
80103653:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103656:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103659:	89 d8                	mov    %ebx,%eax
8010365b:	5b                   	pop    %ebx
8010365c:	5e                   	pop    %esi
8010365d:	5f                   	pop    %edi
8010365e:	5d                   	pop    %ebp
8010365f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103660:	8b 45 10             	mov    0x10(%ebp),%eax
80103663:	85 c0                	test   %eax,%eax
80103665:	7e 61                	jle    801036c8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103667:	31 db                	xor    %ebx,%ebx
80103669:	eb 13                	jmp    8010367e <piperead+0xae>
8010366b:	90                   	nop
8010366c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103670:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103676:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010367c:	74 1f                	je     8010369d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010367e:	8d 41 01             	lea    0x1(%ecx),%eax
80103681:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103687:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010368d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103692:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103695:	83 c3 01             	add    $0x1,%ebx
80103698:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010369b:	75 d3                	jne    80103670 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010369d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801036a3:	83 ec 0c             	sub    $0xc,%esp
801036a6:	50                   	push   %eax
801036a7:	e8 54 09 00 00       	call   80104000 <wakeup>
  release(&p->lock);
801036ac:	89 34 24             	mov    %esi,(%esp)
801036af:	e8 1c 0e 00 00       	call   801044d0 <release>
  return i;
801036b4:	83 c4 10             	add    $0x10,%esp
}
801036b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ba:	89 d8                	mov    %ebx,%eax
801036bc:	5b                   	pop    %ebx
801036bd:	5e                   	pop    %esi
801036be:	5f                   	pop    %edi
801036bf:	5d                   	pop    %ebp
801036c0:	c3                   	ret    
801036c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036c8:	31 db                	xor    %ebx,%ebx
801036ca:	eb d1                	jmp    8010369d <piperead+0xcd>
801036cc:	66 90                	xchg   %ax,%ax
801036ce:	66 90                	xchg   %ax,%ax

801036d0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036d4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801036d9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801036dc:	68 20 2d 11 80       	push   $0x80112d20
801036e1:	e8 2a 0d 00 00       	call   80104410 <acquire>
801036e6:	83 c4 10             	add    $0x10,%esp
801036e9:	eb 10                	jmp    801036fb <allocproc+0x2b>
801036eb:	90                   	nop
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036f0:	83 c3 7c             	add    $0x7c,%ebx
801036f3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801036f9:	73 75                	jae    80103770 <allocproc+0xa0>
    if(p->state == UNUSED)
801036fb:	8b 43 0c             	mov    0xc(%ebx),%eax
801036fe:	85 c0                	test   %eax,%eax
80103700:	75 ee                	jne    801036f0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103702:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103707:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010370a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103711:	8d 50 01             	lea    0x1(%eax),%edx
80103714:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103717:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
8010371c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103722:	e8 a9 0d 00 00       	call   801044d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103727:	e8 64 ee ff ff       	call   80102590 <kalloc>
8010372c:	83 c4 10             	add    $0x10,%esp
8010372f:	85 c0                	test   %eax,%eax
80103731:	89 43 08             	mov    %eax,0x8(%ebx)
80103734:	74 53                	je     80103789 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103736:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010373c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010373f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103744:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103747:	c7 40 14 12 57 10 80 	movl   $0x80105712,0x14(%eax)
  p->context = (struct context*)sp;
8010374e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103751:	6a 14                	push   $0x14
80103753:	6a 00                	push   $0x0
80103755:	50                   	push   %eax
80103756:	e8 c5 0d 00 00       	call   80104520 <memset>
  p->context->eip = (uint)forkret;
8010375b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010375e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103761:	c7 40 10 a0 37 10 80 	movl   $0x801037a0,0x10(%eax)
}
80103768:	89 d8                	mov    %ebx,%eax
8010376a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010376d:	c9                   	leave  
8010376e:	c3                   	ret    
8010376f:	90                   	nop
  release(&ptable.lock);
80103770:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103773:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103775:	68 20 2d 11 80       	push   $0x80112d20
8010377a:	e8 51 0d 00 00       	call   801044d0 <release>
}
8010377f:	89 d8                	mov    %ebx,%eax
  return 0;
80103781:	83 c4 10             	add    $0x10,%esp
}
80103784:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103787:	c9                   	leave  
80103788:	c3                   	ret    
    p->state = UNUSED;
80103789:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103790:	31 db                	xor    %ebx,%ebx
80103792:	eb d4                	jmp    80103768 <allocproc+0x98>
80103794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010379a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801037a6:	68 20 2d 11 80       	push   $0x80112d20
801037ab:	e8 20 0d 00 00       	call   801044d0 <release>

  if (first) {
801037b0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801037b5:	83 c4 10             	add    $0x10,%esp
801037b8:	85 c0                	test   %eax,%eax
801037ba:	75 04                	jne    801037c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037bc:	c9                   	leave  
801037bd:	c3                   	ret    
801037be:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801037c0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801037c3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801037ca:	00 00 00 
    iinit(ROOTDEV);
801037cd:	6a 01                	push   $0x1
801037cf:	e8 7c dd ff ff       	call   80101550 <iinit>
    initlog(ROOTDEV);
801037d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037db:	e8 f0 f3 ff ff       	call   80102bd0 <initlog>
801037e0:	83 c4 10             	add    $0x10,%esp
}
801037e3:	c9                   	leave  
801037e4:	c3                   	ret    
801037e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037f0 <pinit>:
{
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801037f6:	68 d5 74 10 80       	push   $0x801074d5
801037fb:	68 20 2d 11 80       	push   $0x80112d20
80103800:	e8 cb 0a 00 00       	call   801042d0 <initlock>
}
80103805:	83 c4 10             	add    $0x10,%esp
80103808:	c9                   	leave  
80103809:	c3                   	ret    
8010380a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103810 <mycpu>:
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	56                   	push   %esi
80103814:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103815:	9c                   	pushf  
80103816:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103817:	f6 c4 02             	test   $0x2,%ah
8010381a:	75 5e                	jne    8010387a <mycpu+0x6a>
  apicid = lapicid();
8010381c:	e8 df ef ff ff       	call   80102800 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103821:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103827:	85 f6                	test   %esi,%esi
80103829:	7e 42                	jle    8010386d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010382b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103832:	39 d0                	cmp    %edx,%eax
80103834:	74 30                	je     80103866 <mycpu+0x56>
80103836:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010383b:	31 d2                	xor    %edx,%edx
8010383d:	8d 76 00             	lea    0x0(%esi),%esi
80103840:	83 c2 01             	add    $0x1,%edx
80103843:	39 f2                	cmp    %esi,%edx
80103845:	74 26                	je     8010386d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103847:	0f b6 19             	movzbl (%ecx),%ebx
8010384a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103850:	39 c3                	cmp    %eax,%ebx
80103852:	75 ec                	jne    80103840 <mycpu+0x30>
80103854:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010385a:	05 80 27 11 80       	add    $0x80112780,%eax
}
8010385f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103862:	5b                   	pop    %ebx
80103863:	5e                   	pop    %esi
80103864:	5d                   	pop    %ebp
80103865:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103866:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010386b:	eb f2                	jmp    8010385f <mycpu+0x4f>
  panic("unknown apicid\n");
8010386d:	83 ec 0c             	sub    $0xc,%esp
80103870:	68 dc 74 10 80       	push   $0x801074dc
80103875:	e8 16 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010387a:	83 ec 0c             	sub    $0xc,%esp
8010387d:	68 b8 75 10 80       	push   $0x801075b8
80103882:	e8 09 cb ff ff       	call   80100390 <panic>
80103887:	89 f6                	mov    %esi,%esi
80103889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103890 <cpuid>:
cpuid() {
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103896:	e8 75 ff ff ff       	call   80103810 <mycpu>
8010389b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
801038a0:	c9                   	leave  
  return mycpu()-cpus;
801038a1:	c1 f8 04             	sar    $0x4,%eax
801038a4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801038aa:	c3                   	ret    
801038ab:	90                   	nop
801038ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038b0 <myproc>:
myproc(void) {
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	53                   	push   %ebx
801038b4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801038b7:	e8 84 0a 00 00       	call   80104340 <pushcli>
  c = mycpu();
801038bc:	e8 4f ff ff ff       	call   80103810 <mycpu>
  p = c->proc;
801038c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038c7:	e8 b4 0a 00 00       	call   80104380 <popcli>
}
801038cc:	83 c4 04             	add    $0x4,%esp
801038cf:	89 d8                	mov    %ebx,%eax
801038d1:	5b                   	pop    %ebx
801038d2:	5d                   	pop    %ebp
801038d3:	c3                   	ret    
801038d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038e0 <userinit>:
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	53                   	push   %ebx
801038e4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038e7:	e8 e4 fd ff ff       	call   801036d0 <allocproc>
801038ec:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038ee:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801038f3:	e8 e8 33 00 00       	call   80106ce0 <setupkvm>
801038f8:	85 c0                	test   %eax,%eax
801038fa:	89 43 04             	mov    %eax,0x4(%ebx)
801038fd:	0f 84 bd 00 00 00    	je     801039c0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103903:	83 ec 04             	sub    $0x4,%esp
80103906:	68 2c 00 00 00       	push   $0x2c
8010390b:	68 60 a4 10 80       	push   $0x8010a460
80103910:	50                   	push   %eax
80103911:	e8 aa 30 00 00       	call   801069c0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103916:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103919:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010391f:	6a 4c                	push   $0x4c
80103921:	6a 00                	push   $0x0
80103923:	ff 73 18             	pushl  0x18(%ebx)
80103926:	e8 f5 0b 00 00       	call   80104520 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010392b:	8b 43 18             	mov    0x18(%ebx),%eax
8010392e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103933:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103938:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010393b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010393f:	8b 43 18             	mov    0x18(%ebx),%eax
80103942:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103946:	8b 43 18             	mov    0x18(%ebx),%eax
80103949:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010394d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103951:	8b 43 18             	mov    0x18(%ebx),%eax
80103954:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103958:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010395c:	8b 43 18             	mov    0x18(%ebx),%eax
8010395f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103966:	8b 43 18             	mov    0x18(%ebx),%eax
80103969:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103970:	8b 43 18             	mov    0x18(%ebx),%eax
80103973:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010397a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010397d:	6a 10                	push   $0x10
8010397f:	68 05 75 10 80       	push   $0x80107505
80103984:	50                   	push   %eax
80103985:	e8 76 0d 00 00       	call   80104700 <safestrcpy>
  p->cwd = namei("/");
8010398a:	c7 04 24 0e 75 10 80 	movl   $0x8010750e,(%esp)
80103991:	e8 1a e6 ff ff       	call   80101fb0 <namei>
80103996:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103999:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039a0:	e8 6b 0a 00 00       	call   80104410 <acquire>
  p->state = RUNNABLE;
801039a5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801039ac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039b3:	e8 18 0b 00 00       	call   801044d0 <release>
}
801039b8:	83 c4 10             	add    $0x10,%esp
801039bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039be:	c9                   	leave  
801039bf:	c3                   	ret    
    panic("userinit: out of memory?");
801039c0:	83 ec 0c             	sub    $0xc,%esp
801039c3:	68 ec 74 10 80       	push   $0x801074ec
801039c8:	e8 c3 c9 ff ff       	call   80100390 <panic>
801039cd:	8d 76 00             	lea    0x0(%esi),%esi

801039d0 <growproc>:
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	56                   	push   %esi
801039d4:	53                   	push   %ebx
801039d5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039d8:	e8 63 09 00 00       	call   80104340 <pushcli>
  c = mycpu();
801039dd:	e8 2e fe ff ff       	call   80103810 <mycpu>
  p = c->proc;
801039e2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039e8:	e8 93 09 00 00       	call   80104380 <popcli>
  if(n > 0){
801039ed:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801039f0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039f2:	7f 1c                	jg     80103a10 <growproc+0x40>
  } else if(n < 0){
801039f4:	75 3a                	jne    80103a30 <growproc+0x60>
  switchuvm(curproc);
801039f6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801039f9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039fb:	53                   	push   %ebx
801039fc:	e8 af 2e 00 00       	call   801068b0 <switchuvm>
  return 0;
80103a01:	83 c4 10             	add    $0x10,%esp
80103a04:	31 c0                	xor    %eax,%eax
}
80103a06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a09:	5b                   	pop    %ebx
80103a0a:	5e                   	pop    %esi
80103a0b:	5d                   	pop    %ebp
80103a0c:	c3                   	ret    
80103a0d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a10:	83 ec 04             	sub    $0x4,%esp
80103a13:	01 c6                	add    %eax,%esi
80103a15:	56                   	push   %esi
80103a16:	50                   	push   %eax
80103a17:	ff 73 04             	pushl  0x4(%ebx)
80103a1a:	e8 e1 30 00 00       	call   80106b00 <allocuvm>
80103a1f:	83 c4 10             	add    $0x10,%esp
80103a22:	85 c0                	test   %eax,%eax
80103a24:	75 d0                	jne    801039f6 <growproc+0x26>
      return -1;
80103a26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a2b:	eb d9                	jmp    80103a06 <growproc+0x36>
80103a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a30:	83 ec 04             	sub    $0x4,%esp
80103a33:	01 c6                	add    %eax,%esi
80103a35:	56                   	push   %esi
80103a36:	50                   	push   %eax
80103a37:	ff 73 04             	pushl  0x4(%ebx)
80103a3a:	e8 f1 31 00 00       	call   80106c30 <deallocuvm>
80103a3f:	83 c4 10             	add    $0x10,%esp
80103a42:	85 c0                	test   %eax,%eax
80103a44:	75 b0                	jne    801039f6 <growproc+0x26>
80103a46:	eb de                	jmp    80103a26 <growproc+0x56>
80103a48:	90                   	nop
80103a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a50 <fork>:
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	57                   	push   %edi
80103a54:	56                   	push   %esi
80103a55:	53                   	push   %ebx
80103a56:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a59:	e8 e2 08 00 00       	call   80104340 <pushcli>
  c = mycpu();
80103a5e:	e8 ad fd ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103a63:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a69:	e8 12 09 00 00       	call   80104380 <popcli>
  if((np = allocproc()) == 0){
80103a6e:	e8 5d fc ff ff       	call   801036d0 <allocproc>
80103a73:	85 c0                	test   %eax,%eax
80103a75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a78:	0f 84 b7 00 00 00    	je     80103b35 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a7e:	83 ec 08             	sub    $0x8,%esp
80103a81:	ff 33                	pushl  (%ebx)
80103a83:	ff 73 04             	pushl  0x4(%ebx)
80103a86:	89 c7                	mov    %eax,%edi
80103a88:	e8 23 33 00 00       	call   80106db0 <copyuvm>
80103a8d:	83 c4 10             	add    $0x10,%esp
80103a90:	85 c0                	test   %eax,%eax
80103a92:	89 47 04             	mov    %eax,0x4(%edi)
80103a95:	0f 84 a1 00 00 00    	je     80103b3c <fork+0xec>
  np->sz = curproc->sz;
80103a9b:	8b 03                	mov    (%ebx),%eax
80103a9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103aa0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103aa2:	89 59 14             	mov    %ebx,0x14(%ecx)
80103aa5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103aa7:	8b 79 18             	mov    0x18(%ecx),%edi
80103aaa:	8b 73 18             	mov    0x18(%ebx),%esi
80103aad:	b9 13 00 00 00       	mov    $0x13,%ecx
80103ab2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103ab4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103ab6:	8b 40 18             	mov    0x18(%eax),%eax
80103ab9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103ac0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ac4:	85 c0                	test   %eax,%eax
80103ac6:	74 13                	je     80103adb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ac8:	83 ec 0c             	sub    $0xc,%esp
80103acb:	50                   	push   %eax
80103acc:	e8 df d3 ff ff       	call   80100eb0 <filedup>
80103ad1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ad4:	83 c4 10             	add    $0x10,%esp
80103ad7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103adb:	83 c6 01             	add    $0x1,%esi
80103ade:	83 fe 10             	cmp    $0x10,%esi
80103ae1:	75 dd                	jne    80103ac0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ae3:	83 ec 0c             	sub    $0xc,%esp
80103ae6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ae9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103aec:	e8 2f dc ff ff       	call   80101720 <idup>
80103af1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103af4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103af7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103afa:	8d 47 6c             	lea    0x6c(%edi),%eax
80103afd:	6a 10                	push   $0x10
80103aff:	53                   	push   %ebx
80103b00:	50                   	push   %eax
80103b01:	e8 fa 0b 00 00       	call   80104700 <safestrcpy>
  pid = np->pid;
80103b06:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103b09:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b10:	e8 fb 08 00 00       	call   80104410 <acquire>
  np->state = RUNNABLE;
80103b15:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103b1c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b23:	e8 a8 09 00 00       	call   801044d0 <release>
  return pid;
80103b28:	83 c4 10             	add    $0x10,%esp
}
80103b2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b2e:	89 d8                	mov    %ebx,%eax
80103b30:	5b                   	pop    %ebx
80103b31:	5e                   	pop    %esi
80103b32:	5f                   	pop    %edi
80103b33:	5d                   	pop    %ebp
80103b34:	c3                   	ret    
    return -1;
80103b35:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b3a:	eb ef                	jmp    80103b2b <fork+0xdb>
    kfree(np->kstack);
80103b3c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103b3f:	83 ec 0c             	sub    $0xc,%esp
80103b42:	ff 73 08             	pushl  0x8(%ebx)
80103b45:	e8 96 e8 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103b4a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b51:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b58:	83 c4 10             	add    $0x10,%esp
80103b5b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b60:	eb c9                	jmp    80103b2b <fork+0xdb>
80103b62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b70 <scheduler>:
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	57                   	push   %edi
80103b74:	56                   	push   %esi
80103b75:	53                   	push   %ebx
80103b76:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b79:	e8 92 fc ff ff       	call   80103810 <mycpu>
80103b7e:	8d 78 04             	lea    0x4(%eax),%edi
80103b81:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103b83:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b8a:	00 00 00 
80103b8d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103b90:	fb                   	sti    
    acquire(&ptable.lock);
80103b91:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b94:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103b99:	68 20 2d 11 80       	push   $0x80112d20
80103b9e:	e8 6d 08 00 00       	call   80104410 <acquire>
80103ba3:	83 c4 10             	add    $0x10,%esp
80103ba6:	8d 76 00             	lea    0x0(%esi),%esi
80103ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103bb0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bb4:	75 33                	jne    80103be9 <scheduler+0x79>
      switchuvm(p);
80103bb6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103bb9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bbf:	53                   	push   %ebx
80103bc0:	e8 eb 2c 00 00       	call   801068b0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103bc5:	58                   	pop    %eax
80103bc6:	5a                   	pop    %edx
80103bc7:	ff 73 1c             	pushl  0x1c(%ebx)
80103bca:	57                   	push   %edi
      p->state = RUNNING;
80103bcb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103bd2:	e8 84 0b 00 00       	call   8010475b <swtch>
      switchkvm();
80103bd7:	e8 b4 2c 00 00       	call   80106890 <switchkvm>
      c->proc = 0;
80103bdc:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103be3:	00 00 00 
80103be6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103be9:	83 c3 7c             	add    $0x7c,%ebx
80103bec:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103bf2:	72 bc                	jb     80103bb0 <scheduler+0x40>
    release(&ptable.lock);
80103bf4:	83 ec 0c             	sub    $0xc,%esp
80103bf7:	68 20 2d 11 80       	push   $0x80112d20
80103bfc:	e8 cf 08 00 00       	call   801044d0 <release>
    sti();
80103c01:	83 c4 10             	add    $0x10,%esp
80103c04:	eb 8a                	jmp    80103b90 <scheduler+0x20>
80103c06:	8d 76 00             	lea    0x0(%esi),%esi
80103c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c10 <sched>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	56                   	push   %esi
80103c14:	53                   	push   %ebx
  pushcli();
80103c15:	e8 26 07 00 00       	call   80104340 <pushcli>
  c = mycpu();
80103c1a:	e8 f1 fb ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103c1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c25:	e8 56 07 00 00       	call   80104380 <popcli>
  if(!holding(&ptable.lock))
80103c2a:	83 ec 0c             	sub    $0xc,%esp
80103c2d:	68 20 2d 11 80       	push   $0x80112d20
80103c32:	e8 a9 07 00 00       	call   801043e0 <holding>
80103c37:	83 c4 10             	add    $0x10,%esp
80103c3a:	85 c0                	test   %eax,%eax
80103c3c:	74 4f                	je     80103c8d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c3e:	e8 cd fb ff ff       	call   80103810 <mycpu>
80103c43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c4a:	75 68                	jne    80103cb4 <sched+0xa4>
  if(p->state == RUNNING)
80103c4c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c50:	74 55                	je     80103ca7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c52:	9c                   	pushf  
80103c53:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c54:	f6 c4 02             	test   $0x2,%ah
80103c57:	75 41                	jne    80103c9a <sched+0x8a>
  intena = mycpu()->intena;
80103c59:	e8 b2 fb ff ff       	call   80103810 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c5e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c61:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c67:	e8 a4 fb ff ff       	call   80103810 <mycpu>
80103c6c:	83 ec 08             	sub    $0x8,%esp
80103c6f:	ff 70 04             	pushl  0x4(%eax)
80103c72:	53                   	push   %ebx
80103c73:	e8 e3 0a 00 00       	call   8010475b <swtch>
  mycpu()->intena = intena;
80103c78:	e8 93 fb ff ff       	call   80103810 <mycpu>
}
80103c7d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103c80:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c89:	5b                   	pop    %ebx
80103c8a:	5e                   	pop    %esi
80103c8b:	5d                   	pop    %ebp
80103c8c:	c3                   	ret    
    panic("sched ptable.lock");
80103c8d:	83 ec 0c             	sub    $0xc,%esp
80103c90:	68 10 75 10 80       	push   $0x80107510
80103c95:	e8 f6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103c9a:	83 ec 0c             	sub    $0xc,%esp
80103c9d:	68 3c 75 10 80       	push   $0x8010753c
80103ca2:	e8 e9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103ca7:	83 ec 0c             	sub    $0xc,%esp
80103caa:	68 2e 75 10 80       	push   $0x8010752e
80103caf:	e8 dc c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103cb4:	83 ec 0c             	sub    $0xc,%esp
80103cb7:	68 22 75 10 80       	push   $0x80107522
80103cbc:	e8 cf c6 ff ff       	call   80100390 <panic>
80103cc1:	eb 0d                	jmp    80103cd0 <exit>
80103cc3:	90                   	nop
80103cc4:	90                   	nop
80103cc5:	90                   	nop
80103cc6:	90                   	nop
80103cc7:	90                   	nop
80103cc8:	90                   	nop
80103cc9:	90                   	nop
80103cca:	90                   	nop
80103ccb:	90                   	nop
80103ccc:	90                   	nop
80103ccd:	90                   	nop
80103cce:	90                   	nop
80103ccf:	90                   	nop

80103cd0 <exit>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103cd9:	e8 62 06 00 00       	call   80104340 <pushcli>
  c = mycpu();
80103cde:	e8 2d fb ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103ce3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ce9:	e8 92 06 00 00       	call   80104380 <popcli>
  if(curproc == initproc)
80103cee:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103cf4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103cf7:	8d 7e 68             	lea    0x68(%esi),%edi
80103cfa:	0f 84 e7 00 00 00    	je     80103de7 <exit+0x117>
    if(curproc->ofile[fd]){
80103d00:	8b 03                	mov    (%ebx),%eax
80103d02:	85 c0                	test   %eax,%eax
80103d04:	74 12                	je     80103d18 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d06:	83 ec 0c             	sub    $0xc,%esp
80103d09:	50                   	push   %eax
80103d0a:	e8 f1 d1 ff ff       	call   80100f00 <fileclose>
      curproc->ofile[fd] = 0;
80103d0f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d15:	83 c4 10             	add    $0x10,%esp
80103d18:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d1b:	39 fb                	cmp    %edi,%ebx
80103d1d:	75 e1                	jne    80103d00 <exit+0x30>
  begin_op();
80103d1f:	e8 4c ef ff ff       	call   80102c70 <begin_op>
  iput(curproc->cwd);
80103d24:	83 ec 0c             	sub    $0xc,%esp
80103d27:	ff 76 68             	pushl  0x68(%esi)
80103d2a:	e8 51 db ff ff       	call   80101880 <iput>
  end_op();
80103d2f:	e8 ac ef ff ff       	call   80102ce0 <end_op>
  curproc->cwd = 0;
80103d34:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103d3b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d42:	e8 c9 06 00 00       	call   80104410 <acquire>
  wakeup1(curproc->parent);
80103d47:	8b 56 14             	mov    0x14(%esi),%edx
80103d4a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d4d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d52:	eb 0e                	jmp    80103d62 <exit+0x92>
80103d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d58:	83 c0 7c             	add    $0x7c,%eax
80103d5b:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103d60:	73 1c                	jae    80103d7e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103d62:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d66:	75 f0                	jne    80103d58 <exit+0x88>
80103d68:	3b 50 20             	cmp    0x20(%eax),%edx
80103d6b:	75 eb                	jne    80103d58 <exit+0x88>
      p->state = RUNNABLE;
80103d6d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d74:	83 c0 7c             	add    $0x7c,%eax
80103d77:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103d7c:	72 e4                	jb     80103d62 <exit+0x92>
      p->parent = initproc;
80103d7e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d84:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103d89:	eb 10                	jmp    80103d9b <exit+0xcb>
80103d8b:	90                   	nop
80103d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d90:	83 c2 7c             	add    $0x7c,%edx
80103d93:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103d99:	73 33                	jae    80103dce <exit+0xfe>
    if(p->parent == curproc){
80103d9b:	39 72 14             	cmp    %esi,0x14(%edx)
80103d9e:	75 f0                	jne    80103d90 <exit+0xc0>
      if(p->state == ZOMBIE)
80103da0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103da4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103da7:	75 e7                	jne    80103d90 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da9:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103dae:	eb 0a                	jmp    80103dba <exit+0xea>
80103db0:	83 c0 7c             	add    $0x7c,%eax
80103db3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103db8:	73 d6                	jae    80103d90 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103dba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dbe:	75 f0                	jne    80103db0 <exit+0xe0>
80103dc0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103dc3:	75 eb                	jne    80103db0 <exit+0xe0>
      p->state = RUNNABLE;
80103dc5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dcc:	eb e2                	jmp    80103db0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103dce:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103dd5:	e8 36 fe ff ff       	call   80103c10 <sched>
  panic("zombie exit");
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	68 5d 75 10 80       	push   $0x8010755d
80103de2:	e8 a9 c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103de7:	83 ec 0c             	sub    $0xc,%esp
80103dea:	68 50 75 10 80       	push   $0x80107550
80103def:	e8 9c c5 ff ff       	call   80100390 <panic>
80103df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e00 <yield>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	53                   	push   %ebx
80103e04:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e07:	68 20 2d 11 80       	push   $0x80112d20
80103e0c:	e8 ff 05 00 00       	call   80104410 <acquire>
  pushcli();
80103e11:	e8 2a 05 00 00       	call   80104340 <pushcli>
  c = mycpu();
80103e16:	e8 f5 f9 ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103e1b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e21:	e8 5a 05 00 00       	call   80104380 <popcli>
  myproc()->state = RUNNABLE;
80103e26:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e2d:	e8 de fd ff ff       	call   80103c10 <sched>
  release(&ptable.lock);
80103e32:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e39:	e8 92 06 00 00       	call   801044d0 <release>
}
80103e3e:	83 c4 10             	add    $0x10,%esp
80103e41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e44:	c9                   	leave  
80103e45:	c3                   	ret    
80103e46:	8d 76 00             	lea    0x0(%esi),%esi
80103e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e50 <sleep>:
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	57                   	push   %edi
80103e54:	56                   	push   %esi
80103e55:	53                   	push   %ebx
80103e56:	83 ec 0c             	sub    $0xc,%esp
80103e59:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e5c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e5f:	e8 dc 04 00 00       	call   80104340 <pushcli>
  c = mycpu();
80103e64:	e8 a7 f9 ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103e69:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e6f:	e8 0c 05 00 00       	call   80104380 <popcli>
  if(p == 0)
80103e74:	85 db                	test   %ebx,%ebx
80103e76:	0f 84 87 00 00 00    	je     80103f03 <sleep+0xb3>
  if(lk == 0)
80103e7c:	85 f6                	test   %esi,%esi
80103e7e:	74 76                	je     80103ef6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e80:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103e86:	74 50                	je     80103ed8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e88:	83 ec 0c             	sub    $0xc,%esp
80103e8b:	68 20 2d 11 80       	push   $0x80112d20
80103e90:	e8 7b 05 00 00       	call   80104410 <acquire>
    release(lk);
80103e95:	89 34 24             	mov    %esi,(%esp)
80103e98:	e8 33 06 00 00       	call   801044d0 <release>
  p->chan = chan;
80103e9d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ea0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ea7:	e8 64 fd ff ff       	call   80103c10 <sched>
  p->chan = 0;
80103eac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103eb3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eba:	e8 11 06 00 00       	call   801044d0 <release>
    acquire(lk);
80103ebf:	89 75 08             	mov    %esi,0x8(%ebp)
80103ec2:	83 c4 10             	add    $0x10,%esp
}
80103ec5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ec8:	5b                   	pop    %ebx
80103ec9:	5e                   	pop    %esi
80103eca:	5f                   	pop    %edi
80103ecb:	5d                   	pop    %ebp
    acquire(lk);
80103ecc:	e9 3f 05 00 00       	jmp    80104410 <acquire>
80103ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103ed8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103edb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ee2:	e8 29 fd ff ff       	call   80103c10 <sched>
  p->chan = 0;
80103ee7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103eee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ef1:	5b                   	pop    %ebx
80103ef2:	5e                   	pop    %esi
80103ef3:	5f                   	pop    %edi
80103ef4:	5d                   	pop    %ebp
80103ef5:	c3                   	ret    
    panic("sleep without lk");
80103ef6:	83 ec 0c             	sub    $0xc,%esp
80103ef9:	68 6f 75 10 80       	push   $0x8010756f
80103efe:	e8 8d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f03:	83 ec 0c             	sub    $0xc,%esp
80103f06:	68 69 75 10 80       	push   $0x80107569
80103f0b:	e8 80 c4 ff ff       	call   80100390 <panic>

80103f10 <wait>:
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	56                   	push   %esi
80103f14:	53                   	push   %ebx
  pushcli();
80103f15:	e8 26 04 00 00       	call   80104340 <pushcli>
  c = mycpu();
80103f1a:	e8 f1 f8 ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103f1f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f25:	e8 56 04 00 00       	call   80104380 <popcli>
  acquire(&ptable.lock);
80103f2a:	83 ec 0c             	sub    $0xc,%esp
80103f2d:	68 20 2d 11 80       	push   $0x80112d20
80103f32:	e8 d9 04 00 00       	call   80104410 <acquire>
80103f37:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f3a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f3c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f41:	eb 10                	jmp    80103f53 <wait+0x43>
80103f43:	90                   	nop
80103f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f48:	83 c3 7c             	add    $0x7c,%ebx
80103f4b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103f51:	73 1b                	jae    80103f6e <wait+0x5e>
      if(p->parent != curproc)
80103f53:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f56:	75 f0                	jne    80103f48 <wait+0x38>
      if(p->state == ZOMBIE){
80103f58:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f5c:	74 32                	je     80103f90 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f5e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80103f61:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f66:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103f6c:	72 e5                	jb     80103f53 <wait+0x43>
    if(!havekids || curproc->killed){
80103f6e:	85 c0                	test   %eax,%eax
80103f70:	74 74                	je     80103fe6 <wait+0xd6>
80103f72:	8b 46 24             	mov    0x24(%esi),%eax
80103f75:	85 c0                	test   %eax,%eax
80103f77:	75 6d                	jne    80103fe6 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f79:	83 ec 08             	sub    $0x8,%esp
80103f7c:	68 20 2d 11 80       	push   $0x80112d20
80103f81:	56                   	push   %esi
80103f82:	e8 c9 fe ff ff       	call   80103e50 <sleep>
    havekids = 0;
80103f87:	83 c4 10             	add    $0x10,%esp
80103f8a:	eb ae                	jmp    80103f3a <wait+0x2a>
80103f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103f90:	83 ec 0c             	sub    $0xc,%esp
80103f93:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103f96:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f99:	e8 42 e4 ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
80103f9e:	5a                   	pop    %edx
80103f9f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103fa2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fa9:	e8 b2 2c 00 00       	call   80106c60 <freevm>
        release(&ptable.lock);
80103fae:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103fb5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fbc:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fc3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fc7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fce:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fd5:	e8 f6 04 00 00       	call   801044d0 <release>
        return pid;
80103fda:	83 c4 10             	add    $0x10,%esp
}
80103fdd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fe0:	89 f0                	mov    %esi,%eax
80103fe2:	5b                   	pop    %ebx
80103fe3:	5e                   	pop    %esi
80103fe4:	5d                   	pop    %ebp
80103fe5:	c3                   	ret    
      release(&ptable.lock);
80103fe6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fe9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fee:	68 20 2d 11 80       	push   $0x80112d20
80103ff3:	e8 d8 04 00 00       	call   801044d0 <release>
      return -1;
80103ff8:	83 c4 10             	add    $0x10,%esp
80103ffb:	eb e0                	jmp    80103fdd <wait+0xcd>
80103ffd:	8d 76 00             	lea    0x0(%esi),%esi

80104000 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	53                   	push   %ebx
80104004:	83 ec 10             	sub    $0x10,%esp
80104007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010400a:	68 20 2d 11 80       	push   $0x80112d20
8010400f:	e8 fc 03 00 00       	call   80104410 <acquire>
80104014:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104017:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010401c:	eb 0c                	jmp    8010402a <wakeup+0x2a>
8010401e:	66 90                	xchg   %ax,%ax
80104020:	83 c0 7c             	add    $0x7c,%eax
80104023:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104028:	73 1c                	jae    80104046 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010402a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010402e:	75 f0                	jne    80104020 <wakeup+0x20>
80104030:	3b 58 20             	cmp    0x20(%eax),%ebx
80104033:	75 eb                	jne    80104020 <wakeup+0x20>
      p->state = RUNNABLE;
80104035:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010403c:	83 c0 7c             	add    $0x7c,%eax
8010403f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104044:	72 e4                	jb     8010402a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104046:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010404d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104050:	c9                   	leave  
  release(&ptable.lock);
80104051:	e9 7a 04 00 00       	jmp    801044d0 <release>
80104056:	8d 76 00             	lea    0x0(%esi),%esi
80104059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104060 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	53                   	push   %ebx
80104064:	83 ec 10             	sub    $0x10,%esp
80104067:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010406a:	68 20 2d 11 80       	push   $0x80112d20
8010406f:	e8 9c 03 00 00       	call   80104410 <acquire>
80104074:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104077:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010407c:	eb 0c                	jmp    8010408a <kill+0x2a>
8010407e:	66 90                	xchg   %ax,%ax
80104080:	83 c0 7c             	add    $0x7c,%eax
80104083:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104088:	73 36                	jae    801040c0 <kill+0x60>
    if(p->pid == pid){
8010408a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010408d:	75 f1                	jne    80104080 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010408f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104093:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010409a:	75 07                	jne    801040a3 <kill+0x43>
        p->state = RUNNABLE;
8010409c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801040a3:	83 ec 0c             	sub    $0xc,%esp
801040a6:	68 20 2d 11 80       	push   $0x80112d20
801040ab:	e8 20 04 00 00       	call   801044d0 <release>
      return 0;
801040b0:	83 c4 10             	add    $0x10,%esp
801040b3:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040b8:	c9                   	leave  
801040b9:	c3                   	ret    
801040ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801040c0:	83 ec 0c             	sub    $0xc,%esp
801040c3:	68 20 2d 11 80       	push   $0x80112d20
801040c8:	e8 03 04 00 00       	call   801044d0 <release>
  return -1;
801040cd:	83 c4 10             	add    $0x10,%esp
801040d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d8:	c9                   	leave  
801040d9:	c3                   	ret    
801040da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	57                   	push   %edi
801040e4:	56                   	push   %esi
801040e5:	53                   	push   %ebx
801040e6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040e9:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801040ee:	83 ec 3c             	sub    $0x3c,%esp
801040f1:	eb 24                	jmp    80104117 <procdump+0x37>
801040f3:	90                   	nop
801040f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801040f8:	83 ec 0c             	sub    $0xc,%esp
801040fb:	68 f7 78 10 80       	push   $0x801078f7
80104100:	e8 1b c6 ff ff       	call   80100720 <cprintf>
80104105:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104108:	83 c3 7c             	add    $0x7c,%ebx
8010410b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104111:	0f 83 81 00 00 00    	jae    80104198 <procdump+0xb8>
    if(p->state == UNUSED)
80104117:	8b 43 0c             	mov    0xc(%ebx),%eax
8010411a:	85 c0                	test   %eax,%eax
8010411c:	74 ea                	je     80104108 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010411e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104121:	ba 80 75 10 80       	mov    $0x80107580,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104126:	77 11                	ja     80104139 <procdump+0x59>
80104128:	8b 14 85 e0 75 10 80 	mov    -0x7fef8a20(,%eax,4),%edx
      state = "???";
8010412f:	b8 80 75 10 80       	mov    $0x80107580,%eax
80104134:	85 d2                	test   %edx,%edx
80104136:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104139:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010413c:	50                   	push   %eax
8010413d:	52                   	push   %edx
8010413e:	ff 73 10             	pushl  0x10(%ebx)
80104141:	68 84 75 10 80       	push   $0x80107584
80104146:	e8 d5 c5 ff ff       	call   80100720 <cprintf>
    if(p->state == SLEEPING){
8010414b:	83 c4 10             	add    $0x10,%esp
8010414e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104152:	75 a4                	jne    801040f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104154:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104157:	83 ec 08             	sub    $0x8,%esp
8010415a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010415d:	50                   	push   %eax
8010415e:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104161:	8b 40 0c             	mov    0xc(%eax),%eax
80104164:	83 c0 08             	add    $0x8,%eax
80104167:	50                   	push   %eax
80104168:	e8 83 01 00 00       	call   801042f0 <getcallerpcs>
8010416d:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104170:	8b 17                	mov    (%edi),%edx
80104172:	85 d2                	test   %edx,%edx
80104174:	74 82                	je     801040f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104176:	83 ec 08             	sub    $0x8,%esp
80104179:	83 c7 04             	add    $0x4,%edi
8010417c:	52                   	push   %edx
8010417d:	68 c1 6f 10 80       	push   $0x80106fc1
80104182:	e8 99 c5 ff ff       	call   80100720 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104187:	83 c4 10             	add    $0x10,%esp
8010418a:	39 fe                	cmp    %edi,%esi
8010418c:	75 e2                	jne    80104170 <procdump+0x90>
8010418e:	e9 65 ff ff ff       	jmp    801040f8 <procdump+0x18>
80104193:	90                   	nop
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
80104198:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010419b:	5b                   	pop    %ebx
8010419c:	5e                   	pop    %esi
8010419d:	5f                   	pop    %edi
8010419e:	5d                   	pop    %ebp
8010419f:	c3                   	ret    

801041a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	53                   	push   %ebx
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041aa:	68 f8 75 10 80       	push   $0x801075f8
801041af:	8d 43 04             	lea    0x4(%ebx),%eax
801041b2:	50                   	push   %eax
801041b3:	e8 18 01 00 00       	call   801042d0 <initlock>
  lk->name = name;
801041b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801041bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801041c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801041c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801041cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801041ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041d1:	c9                   	leave  
801041d2:	c3                   	ret    
801041d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	56                   	push   %esi
801041e4:	53                   	push   %ebx
801041e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801041e8:	83 ec 0c             	sub    $0xc,%esp
801041eb:	8d 73 04             	lea    0x4(%ebx),%esi
801041ee:	56                   	push   %esi
801041ef:	e8 1c 02 00 00       	call   80104410 <acquire>
  while (lk->locked) {
801041f4:	8b 13                	mov    (%ebx),%edx
801041f6:	83 c4 10             	add    $0x10,%esp
801041f9:	85 d2                	test   %edx,%edx
801041fb:	74 16                	je     80104213 <acquiresleep+0x33>
801041fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104200:	83 ec 08             	sub    $0x8,%esp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	e8 46 fc ff ff       	call   80103e50 <sleep>
  while (lk->locked) {
8010420a:	8b 03                	mov    (%ebx),%eax
8010420c:	83 c4 10             	add    $0x10,%esp
8010420f:	85 c0                	test   %eax,%eax
80104211:	75 ed                	jne    80104200 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104213:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104219:	e8 92 f6 ff ff       	call   801038b0 <myproc>
8010421e:	8b 40 10             	mov    0x10(%eax),%eax
80104221:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104224:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104227:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010422a:	5b                   	pop    %ebx
8010422b:	5e                   	pop    %esi
8010422c:	5d                   	pop    %ebp
  release(&lk->lk);
8010422d:	e9 9e 02 00 00       	jmp    801044d0 <release>
80104232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104240 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	56                   	push   %esi
80104244:	53                   	push   %ebx
80104245:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104248:	83 ec 0c             	sub    $0xc,%esp
8010424b:	8d 73 04             	lea    0x4(%ebx),%esi
8010424e:	56                   	push   %esi
8010424f:	e8 bc 01 00 00       	call   80104410 <acquire>
  lk->locked = 0;
80104254:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010425a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104261:	89 1c 24             	mov    %ebx,(%esp)
80104264:	e8 97 fd ff ff       	call   80104000 <wakeup>
  release(&lk->lk);
80104269:	89 75 08             	mov    %esi,0x8(%ebp)
8010426c:	83 c4 10             	add    $0x10,%esp
}
8010426f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104272:	5b                   	pop    %ebx
80104273:	5e                   	pop    %esi
80104274:	5d                   	pop    %ebp
  release(&lk->lk);
80104275:	e9 56 02 00 00       	jmp    801044d0 <release>
8010427a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104280 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	57                   	push   %edi
80104284:	56                   	push   %esi
80104285:	53                   	push   %ebx
80104286:	31 ff                	xor    %edi,%edi
80104288:	83 ec 18             	sub    $0x18,%esp
8010428b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010428e:	8d 73 04             	lea    0x4(%ebx),%esi
80104291:	56                   	push   %esi
80104292:	e8 79 01 00 00       	call   80104410 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104297:	8b 03                	mov    (%ebx),%eax
80104299:	83 c4 10             	add    $0x10,%esp
8010429c:	85 c0                	test   %eax,%eax
8010429e:	74 13                	je     801042b3 <holdingsleep+0x33>
801042a0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801042a3:	e8 08 f6 ff ff       	call   801038b0 <myproc>
801042a8:	39 58 10             	cmp    %ebx,0x10(%eax)
801042ab:	0f 94 c0             	sete   %al
801042ae:	0f b6 c0             	movzbl %al,%eax
801042b1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801042b3:	83 ec 0c             	sub    $0xc,%esp
801042b6:	56                   	push   %esi
801042b7:	e8 14 02 00 00       	call   801044d0 <release>
  return r;
}
801042bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042bf:	89 f8                	mov    %edi,%eax
801042c1:	5b                   	pop    %ebx
801042c2:	5e                   	pop    %esi
801042c3:	5f                   	pop    %edi
801042c4:	5d                   	pop    %ebp
801042c5:	c3                   	ret    
801042c6:	66 90                	xchg   %ax,%ax
801042c8:	66 90                	xchg   %ax,%ax
801042ca:	66 90                	xchg   %ax,%ax
801042cc:	66 90                	xchg   %ax,%ax
801042ce:	66 90                	xchg   %ax,%ax

801042d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801042d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801042d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801042df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801042e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801042e9:	5d                   	pop    %ebp
801042ea:	c3                   	ret    
801042eb:	90                   	nop
801042ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801042f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801042f1:	31 d2                	xor    %edx,%edx
{
801042f3:	89 e5                	mov    %esp,%ebp
801042f5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801042f6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801042f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801042fc:	83 e8 08             	sub    $0x8,%eax
801042ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104300:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104306:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010430c:	77 1a                	ja     80104328 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010430e:	8b 58 04             	mov    0x4(%eax),%ebx
80104311:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104314:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104317:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104319:	83 fa 0a             	cmp    $0xa,%edx
8010431c:	75 e2                	jne    80104300 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010431e:	5b                   	pop    %ebx
8010431f:	5d                   	pop    %ebp
80104320:	c3                   	ret    
80104321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104328:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010432b:	83 c1 28             	add    $0x28,%ecx
8010432e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104330:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104336:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104339:	39 c1                	cmp    %eax,%ecx
8010433b:	75 f3                	jne    80104330 <getcallerpcs+0x40>
}
8010433d:	5b                   	pop    %ebx
8010433e:	5d                   	pop    %ebp
8010433f:	c3                   	ret    

80104340 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 04             	sub    $0x4,%esp
80104347:	9c                   	pushf  
80104348:	5b                   	pop    %ebx
  asm volatile("cli");
80104349:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010434a:	e8 c1 f4 ff ff       	call   80103810 <mycpu>
8010434f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104355:	85 c0                	test   %eax,%eax
80104357:	75 11                	jne    8010436a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104359:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010435f:	e8 ac f4 ff ff       	call   80103810 <mycpu>
80104364:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010436a:	e8 a1 f4 ff ff       	call   80103810 <mycpu>
8010436f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104376:	83 c4 04             	add    $0x4,%esp
80104379:	5b                   	pop    %ebx
8010437a:	5d                   	pop    %ebp
8010437b:	c3                   	ret    
8010437c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104380 <popcli>:

void
popcli(void)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104386:	9c                   	pushf  
80104387:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104388:	f6 c4 02             	test   $0x2,%ah
8010438b:	75 35                	jne    801043c2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010438d:	e8 7e f4 ff ff       	call   80103810 <mycpu>
80104392:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104399:	78 34                	js     801043cf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010439b:	e8 70 f4 ff ff       	call   80103810 <mycpu>
801043a0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801043a6:	85 d2                	test   %edx,%edx
801043a8:	74 06                	je     801043b0 <popcli+0x30>
    sti();
}
801043aa:	c9                   	leave  
801043ab:	c3                   	ret    
801043ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801043b0:	e8 5b f4 ff ff       	call   80103810 <mycpu>
801043b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801043bb:	85 c0                	test   %eax,%eax
801043bd:	74 eb                	je     801043aa <popcli+0x2a>
  asm volatile("sti");
801043bf:	fb                   	sti    
}
801043c0:	c9                   	leave  
801043c1:	c3                   	ret    
    panic("popcli - interruptible");
801043c2:	83 ec 0c             	sub    $0xc,%esp
801043c5:	68 03 76 10 80       	push   $0x80107603
801043ca:	e8 c1 bf ff ff       	call   80100390 <panic>
    panic("popcli");
801043cf:	83 ec 0c             	sub    $0xc,%esp
801043d2:	68 1a 76 10 80       	push   $0x8010761a
801043d7:	e8 b4 bf ff ff       	call   80100390 <panic>
801043dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043e0 <holding>:
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	8b 75 08             	mov    0x8(%ebp),%esi
801043e8:	31 db                	xor    %ebx,%ebx
  pushcli();
801043ea:	e8 51 ff ff ff       	call   80104340 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801043ef:	8b 06                	mov    (%esi),%eax
801043f1:	85 c0                	test   %eax,%eax
801043f3:	74 10                	je     80104405 <holding+0x25>
801043f5:	8b 5e 08             	mov    0x8(%esi),%ebx
801043f8:	e8 13 f4 ff ff       	call   80103810 <mycpu>
801043fd:	39 c3                	cmp    %eax,%ebx
801043ff:	0f 94 c3             	sete   %bl
80104402:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104405:	e8 76 ff ff ff       	call   80104380 <popcli>
}
8010440a:	89 d8                	mov    %ebx,%eax
8010440c:	5b                   	pop    %ebx
8010440d:	5e                   	pop    %esi
8010440e:	5d                   	pop    %ebp
8010440f:	c3                   	ret    

80104410 <acquire>:
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	56                   	push   %esi
80104414:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104415:	e8 26 ff ff ff       	call   80104340 <pushcli>
  if(holding(lk))
8010441a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010441d:	83 ec 0c             	sub    $0xc,%esp
80104420:	53                   	push   %ebx
80104421:	e8 ba ff ff ff       	call   801043e0 <holding>
80104426:	83 c4 10             	add    $0x10,%esp
80104429:	85 c0                	test   %eax,%eax
8010442b:	0f 85 83 00 00 00    	jne    801044b4 <acquire+0xa4>
80104431:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104433:	ba 01 00 00 00       	mov    $0x1,%edx
80104438:	eb 09                	jmp    80104443 <acquire+0x33>
8010443a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104440:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104443:	89 d0                	mov    %edx,%eax
80104445:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104448:	85 c0                	test   %eax,%eax
8010444a:	75 f4                	jne    80104440 <acquire+0x30>
  __sync_synchronize();
8010444c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104451:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104454:	e8 b7 f3 ff ff       	call   80103810 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104459:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010445c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010445f:	89 e8                	mov    %ebp,%eax
80104461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104468:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010446e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104474:	77 1a                	ja     80104490 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104476:	8b 48 04             	mov    0x4(%eax),%ecx
80104479:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010447c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010447f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104481:	83 fe 0a             	cmp    $0xa,%esi
80104484:	75 e2                	jne    80104468 <acquire+0x58>
}
80104486:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104489:	5b                   	pop    %ebx
8010448a:	5e                   	pop    %esi
8010448b:	5d                   	pop    %ebp
8010448c:	c3                   	ret    
8010448d:	8d 76 00             	lea    0x0(%esi),%esi
80104490:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104493:	83 c2 28             	add    $0x28,%edx
80104496:	8d 76 00             	lea    0x0(%esi),%esi
80104499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801044a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801044a6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801044a9:	39 d0                	cmp    %edx,%eax
801044ab:	75 f3                	jne    801044a0 <acquire+0x90>
}
801044ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044b0:	5b                   	pop    %ebx
801044b1:	5e                   	pop    %esi
801044b2:	5d                   	pop    %ebp
801044b3:	c3                   	ret    
    panic("acquire");
801044b4:	83 ec 0c             	sub    $0xc,%esp
801044b7:	68 21 76 10 80       	push   $0x80107621
801044bc:	e8 cf be ff ff       	call   80100390 <panic>
801044c1:	eb 0d                	jmp    801044d0 <release>
801044c3:	90                   	nop
801044c4:	90                   	nop
801044c5:	90                   	nop
801044c6:	90                   	nop
801044c7:	90                   	nop
801044c8:	90                   	nop
801044c9:	90                   	nop
801044ca:	90                   	nop
801044cb:	90                   	nop
801044cc:	90                   	nop
801044cd:	90                   	nop
801044ce:	90                   	nop
801044cf:	90                   	nop

801044d0 <release>:
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 10             	sub    $0x10,%esp
801044d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801044da:	53                   	push   %ebx
801044db:	e8 00 ff ff ff       	call   801043e0 <holding>
801044e0:	83 c4 10             	add    $0x10,%esp
801044e3:	85 c0                	test   %eax,%eax
801044e5:	74 22                	je     80104509 <release+0x39>
  lk->pcs[0] = 0;
801044e7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801044ee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801044f5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801044fa:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104500:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104503:	c9                   	leave  
  popcli();
80104504:	e9 77 fe ff ff       	jmp    80104380 <popcli>
    panic("release");
80104509:	83 ec 0c             	sub    $0xc,%esp
8010450c:	68 29 76 10 80       	push   $0x80107629
80104511:	e8 7a be ff ff       	call   80100390 <panic>
80104516:	66 90                	xchg   %ax,%ax
80104518:	66 90                	xchg   %ax,%ax
8010451a:	66 90                	xchg   %ax,%ax
8010451c:	66 90                	xchg   %ax,%ax
8010451e:	66 90                	xchg   %ax,%ax

80104520 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	57                   	push   %edi
80104524:	53                   	push   %ebx
80104525:	8b 55 08             	mov    0x8(%ebp),%edx
80104528:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010452b:	f6 c2 03             	test   $0x3,%dl
8010452e:	75 05                	jne    80104535 <memset+0x15>
80104530:	f6 c1 03             	test   $0x3,%cl
80104533:	74 13                	je     80104548 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104535:	89 d7                	mov    %edx,%edi
80104537:	8b 45 0c             	mov    0xc(%ebp),%eax
8010453a:	fc                   	cld    
8010453b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010453d:	5b                   	pop    %ebx
8010453e:	89 d0                	mov    %edx,%eax
80104540:	5f                   	pop    %edi
80104541:	5d                   	pop    %ebp
80104542:	c3                   	ret    
80104543:	90                   	nop
80104544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104548:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010454c:	c1 e9 02             	shr    $0x2,%ecx
8010454f:	89 f8                	mov    %edi,%eax
80104551:	89 fb                	mov    %edi,%ebx
80104553:	c1 e0 18             	shl    $0x18,%eax
80104556:	c1 e3 10             	shl    $0x10,%ebx
80104559:	09 d8                	or     %ebx,%eax
8010455b:	09 f8                	or     %edi,%eax
8010455d:	c1 e7 08             	shl    $0x8,%edi
80104560:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104562:	89 d7                	mov    %edx,%edi
80104564:	fc                   	cld    
80104565:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104567:	5b                   	pop    %ebx
80104568:	89 d0                	mov    %edx,%eax
8010456a:	5f                   	pop    %edi
8010456b:	5d                   	pop    %ebp
8010456c:	c3                   	ret    
8010456d:	8d 76 00             	lea    0x0(%esi),%esi

80104570 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	57                   	push   %edi
80104574:	56                   	push   %esi
80104575:	53                   	push   %ebx
80104576:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104579:	8b 75 08             	mov    0x8(%ebp),%esi
8010457c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010457f:	85 db                	test   %ebx,%ebx
80104581:	74 29                	je     801045ac <memcmp+0x3c>
    if(*s1 != *s2)
80104583:	0f b6 16             	movzbl (%esi),%edx
80104586:	0f b6 0f             	movzbl (%edi),%ecx
80104589:	38 d1                	cmp    %dl,%cl
8010458b:	75 2b                	jne    801045b8 <memcmp+0x48>
8010458d:	b8 01 00 00 00       	mov    $0x1,%eax
80104592:	eb 14                	jmp    801045a8 <memcmp+0x38>
80104594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104598:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010459c:	83 c0 01             	add    $0x1,%eax
8010459f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801045a4:	38 ca                	cmp    %cl,%dl
801045a6:	75 10                	jne    801045b8 <memcmp+0x48>
  while(n-- > 0){
801045a8:	39 d8                	cmp    %ebx,%eax
801045aa:	75 ec                	jne    80104598 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801045ac:	5b                   	pop    %ebx
  return 0;
801045ad:	31 c0                	xor    %eax,%eax
}
801045af:	5e                   	pop    %esi
801045b0:	5f                   	pop    %edi
801045b1:	5d                   	pop    %ebp
801045b2:	c3                   	ret    
801045b3:	90                   	nop
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801045b8:	0f b6 c2             	movzbl %dl,%eax
}
801045bb:	5b                   	pop    %ebx
      return *s1 - *s2;
801045bc:	29 c8                	sub    %ecx,%eax
}
801045be:	5e                   	pop    %esi
801045bf:	5f                   	pop    %edi
801045c0:	5d                   	pop    %ebp
801045c1:	c3                   	ret    
801045c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045d0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	56                   	push   %esi
801045d4:	53                   	push   %ebx
801045d5:	8b 45 08             	mov    0x8(%ebp),%eax
801045d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801045db:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801045de:	39 c3                	cmp    %eax,%ebx
801045e0:	73 26                	jae    80104608 <memmove+0x38>
801045e2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
801045e5:	39 c8                	cmp    %ecx,%eax
801045e7:	73 1f                	jae    80104608 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801045e9:	85 f6                	test   %esi,%esi
801045eb:	8d 56 ff             	lea    -0x1(%esi),%edx
801045ee:	74 0f                	je     801045ff <memmove+0x2f>
      *--d = *--s;
801045f0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801045f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801045f7:	83 ea 01             	sub    $0x1,%edx
801045fa:	83 fa ff             	cmp    $0xffffffff,%edx
801045fd:	75 f1                	jne    801045f0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801045ff:	5b                   	pop    %ebx
80104600:	5e                   	pop    %esi
80104601:	5d                   	pop    %ebp
80104602:	c3                   	ret    
80104603:	90                   	nop
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104608:	31 d2                	xor    %edx,%edx
8010460a:	85 f6                	test   %esi,%esi
8010460c:	74 f1                	je     801045ff <memmove+0x2f>
8010460e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104610:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104614:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104617:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010461a:	39 d6                	cmp    %edx,%esi
8010461c:	75 f2                	jne    80104610 <memmove+0x40>
}
8010461e:	5b                   	pop    %ebx
8010461f:	5e                   	pop    %esi
80104620:	5d                   	pop    %ebp
80104621:	c3                   	ret    
80104622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104633:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104634:	eb 9a                	jmp    801045d0 <memmove>
80104636:	8d 76 00             	lea    0x0(%esi),%esi
80104639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104640 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	57                   	push   %edi
80104644:	56                   	push   %esi
80104645:	8b 7d 10             	mov    0x10(%ebp),%edi
80104648:	53                   	push   %ebx
80104649:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010464c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010464f:	85 ff                	test   %edi,%edi
80104651:	74 2f                	je     80104682 <strncmp+0x42>
80104653:	0f b6 01             	movzbl (%ecx),%eax
80104656:	0f b6 1e             	movzbl (%esi),%ebx
80104659:	84 c0                	test   %al,%al
8010465b:	74 37                	je     80104694 <strncmp+0x54>
8010465d:	38 c3                	cmp    %al,%bl
8010465f:	75 33                	jne    80104694 <strncmp+0x54>
80104661:	01 f7                	add    %esi,%edi
80104663:	eb 13                	jmp    80104678 <strncmp+0x38>
80104665:	8d 76 00             	lea    0x0(%esi),%esi
80104668:	0f b6 01             	movzbl (%ecx),%eax
8010466b:	84 c0                	test   %al,%al
8010466d:	74 21                	je     80104690 <strncmp+0x50>
8010466f:	0f b6 1a             	movzbl (%edx),%ebx
80104672:	89 d6                	mov    %edx,%esi
80104674:	38 d8                	cmp    %bl,%al
80104676:	75 1c                	jne    80104694 <strncmp+0x54>
    n--, p++, q++;
80104678:	8d 56 01             	lea    0x1(%esi),%edx
8010467b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010467e:	39 fa                	cmp    %edi,%edx
80104680:	75 e6                	jne    80104668 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104682:	5b                   	pop    %ebx
    return 0;
80104683:	31 c0                	xor    %eax,%eax
}
80104685:	5e                   	pop    %esi
80104686:	5f                   	pop    %edi
80104687:	5d                   	pop    %ebp
80104688:	c3                   	ret    
80104689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104690:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104694:	29 d8                	sub    %ebx,%eax
}
80104696:	5b                   	pop    %ebx
80104697:	5e                   	pop    %esi
80104698:	5f                   	pop    %edi
80104699:	5d                   	pop    %ebp
8010469a:	c3                   	ret    
8010469b:	90                   	nop
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046a0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	56                   	push   %esi
801046a4:	53                   	push   %ebx
801046a5:	8b 45 08             	mov    0x8(%ebp),%eax
801046a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801046ae:	89 c2                	mov    %eax,%edx
801046b0:	eb 19                	jmp    801046cb <strncpy+0x2b>
801046b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046b8:	83 c3 01             	add    $0x1,%ebx
801046bb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046bf:	83 c2 01             	add    $0x1,%edx
801046c2:	84 c9                	test   %cl,%cl
801046c4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046c7:	74 09                	je     801046d2 <strncpy+0x32>
801046c9:	89 f1                	mov    %esi,%ecx
801046cb:	85 c9                	test   %ecx,%ecx
801046cd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801046d0:	7f e6                	jg     801046b8 <strncpy+0x18>
    ;
  while(n-- > 0)
801046d2:	31 c9                	xor    %ecx,%ecx
801046d4:	85 f6                	test   %esi,%esi
801046d6:	7e 17                	jle    801046ef <strncpy+0x4f>
801046d8:	90                   	nop
801046d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801046e0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801046e4:	89 f3                	mov    %esi,%ebx
801046e6:	83 c1 01             	add    $0x1,%ecx
801046e9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801046eb:	85 db                	test   %ebx,%ebx
801046ed:	7f f1                	jg     801046e0 <strncpy+0x40>
  return os;
}
801046ef:	5b                   	pop    %ebx
801046f0:	5e                   	pop    %esi
801046f1:	5d                   	pop    %ebp
801046f2:	c3                   	ret    
801046f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	56                   	push   %esi
80104704:	53                   	push   %ebx
80104705:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104708:	8b 45 08             	mov    0x8(%ebp),%eax
8010470b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010470e:	85 c9                	test   %ecx,%ecx
80104710:	7e 26                	jle    80104738 <safestrcpy+0x38>
80104712:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104716:	89 c1                	mov    %eax,%ecx
80104718:	eb 17                	jmp    80104731 <safestrcpy+0x31>
8010471a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104720:	83 c2 01             	add    $0x1,%edx
80104723:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104727:	83 c1 01             	add    $0x1,%ecx
8010472a:	84 db                	test   %bl,%bl
8010472c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010472f:	74 04                	je     80104735 <safestrcpy+0x35>
80104731:	39 f2                	cmp    %esi,%edx
80104733:	75 eb                	jne    80104720 <safestrcpy+0x20>
    ;
  *s = 0;
80104735:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104738:	5b                   	pop    %ebx
80104739:	5e                   	pop    %esi
8010473a:	5d                   	pop    %ebp
8010473b:	c3                   	ret    
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104740 <strlen>:

int
strlen(const char *s)
{
80104740:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104741:	31 c0                	xor    %eax,%eax
{
80104743:	89 e5                	mov    %esp,%ebp
80104745:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104748:	80 3a 00             	cmpb   $0x0,(%edx)
8010474b:	74 0c                	je     80104759 <strlen+0x19>
8010474d:	8d 76 00             	lea    0x0(%esi),%esi
80104750:	83 c0 01             	add    $0x1,%eax
80104753:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104757:	75 f7                	jne    80104750 <strlen+0x10>
    ;
  return n;
}
80104759:	5d                   	pop    %ebp
8010475a:	c3                   	ret    

8010475b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010475b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010475f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104763:	55                   	push   %ebp
  pushl %ebx
80104764:	53                   	push   %ebx
  pushl %esi
80104765:	56                   	push   %esi
  pushl %edi
80104766:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104767:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104769:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010476b:	5f                   	pop    %edi
  popl %esi
8010476c:	5e                   	pop    %esi
  popl %ebx
8010476d:	5b                   	pop    %ebx
  popl %ebp
8010476e:	5d                   	pop    %ebp
  ret
8010476f:	c3                   	ret    

80104770 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	83 ec 04             	sub    $0x4,%esp
80104777:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010477a:	e8 31 f1 ff ff       	call   801038b0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010477f:	8b 00                	mov    (%eax),%eax
80104781:	39 d8                	cmp    %ebx,%eax
80104783:	76 1b                	jbe    801047a0 <fetchint+0x30>
80104785:	8d 53 04             	lea    0x4(%ebx),%edx
80104788:	39 d0                	cmp    %edx,%eax
8010478a:	72 14                	jb     801047a0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010478c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010478f:	8b 13                	mov    (%ebx),%edx
80104791:	89 10                	mov    %edx,(%eax)
  return 0;
80104793:	31 c0                	xor    %eax,%eax
}
80104795:	83 c4 04             	add    $0x4,%esp
80104798:	5b                   	pop    %ebx
80104799:	5d                   	pop    %ebp
8010479a:	c3                   	ret    
8010479b:	90                   	nop
8010479c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801047a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047a5:	eb ee                	jmp    80104795 <fetchint+0x25>
801047a7:	89 f6                	mov    %esi,%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047b0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	53                   	push   %ebx
801047b4:	83 ec 04             	sub    $0x4,%esp
801047b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801047ba:	e8 f1 f0 ff ff       	call   801038b0 <myproc>

  if(addr >= curproc->sz)
801047bf:	39 18                	cmp    %ebx,(%eax)
801047c1:	76 29                	jbe    801047ec <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801047c3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801047c6:	89 da                	mov    %ebx,%edx
801047c8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801047ca:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801047cc:	39 c3                	cmp    %eax,%ebx
801047ce:	73 1c                	jae    801047ec <fetchstr+0x3c>
    if(*s == 0)
801047d0:	80 3b 00             	cmpb   $0x0,(%ebx)
801047d3:	75 10                	jne    801047e5 <fetchstr+0x35>
801047d5:	eb 39                	jmp    80104810 <fetchstr+0x60>
801047d7:	89 f6                	mov    %esi,%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801047e0:	80 3a 00             	cmpb   $0x0,(%edx)
801047e3:	74 1b                	je     80104800 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801047e5:	83 c2 01             	add    $0x1,%edx
801047e8:	39 d0                	cmp    %edx,%eax
801047ea:	77 f4                	ja     801047e0 <fetchstr+0x30>
    return -1;
801047ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801047f1:	83 c4 04             	add    $0x4,%esp
801047f4:	5b                   	pop    %ebx
801047f5:	5d                   	pop    %ebp
801047f6:	c3                   	ret    
801047f7:	89 f6                	mov    %esi,%esi
801047f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104800:	83 c4 04             	add    $0x4,%esp
80104803:	89 d0                	mov    %edx,%eax
80104805:	29 d8                	sub    %ebx,%eax
80104807:	5b                   	pop    %ebx
80104808:	5d                   	pop    %ebp
80104809:	c3                   	ret    
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104810:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104812:	eb dd                	jmp    801047f1 <fetchstr+0x41>
80104814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010481a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104820 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	56                   	push   %esi
80104824:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104825:	e8 86 f0 ff ff       	call   801038b0 <myproc>
8010482a:	8b 40 18             	mov    0x18(%eax),%eax
8010482d:	8b 55 08             	mov    0x8(%ebp),%edx
80104830:	8b 40 44             	mov    0x44(%eax),%eax
80104833:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104836:	e8 75 f0 ff ff       	call   801038b0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010483b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010483d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104840:	39 c6                	cmp    %eax,%esi
80104842:	73 1c                	jae    80104860 <argint+0x40>
80104844:	8d 53 08             	lea    0x8(%ebx),%edx
80104847:	39 d0                	cmp    %edx,%eax
80104849:	72 15                	jb     80104860 <argint+0x40>
  *ip = *(int*)(addr);
8010484b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010484e:	8b 53 04             	mov    0x4(%ebx),%edx
80104851:	89 10                	mov    %edx,(%eax)
  return 0;
80104853:	31 c0                	xor    %eax,%eax
}
80104855:	5b                   	pop    %ebx
80104856:	5e                   	pop    %esi
80104857:	5d                   	pop    %ebp
80104858:	c3                   	ret    
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104865:	eb ee                	jmp    80104855 <argint+0x35>
80104867:	89 f6                	mov    %esi,%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104870 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	56                   	push   %esi
80104874:	53                   	push   %ebx
80104875:	83 ec 10             	sub    $0x10,%esp
80104878:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010487b:	e8 30 f0 ff ff       	call   801038b0 <myproc>
80104880:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104882:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104885:	83 ec 08             	sub    $0x8,%esp
80104888:	50                   	push   %eax
80104889:	ff 75 08             	pushl  0x8(%ebp)
8010488c:	e8 8f ff ff ff       	call   80104820 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104891:	83 c4 10             	add    $0x10,%esp
80104894:	85 c0                	test   %eax,%eax
80104896:	78 28                	js     801048c0 <argptr+0x50>
80104898:	85 db                	test   %ebx,%ebx
8010489a:	78 24                	js     801048c0 <argptr+0x50>
8010489c:	8b 16                	mov    (%esi),%edx
8010489e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048a1:	39 c2                	cmp    %eax,%edx
801048a3:	76 1b                	jbe    801048c0 <argptr+0x50>
801048a5:	01 c3                	add    %eax,%ebx
801048a7:	39 da                	cmp    %ebx,%edx
801048a9:	72 15                	jb     801048c0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801048ab:	8b 55 0c             	mov    0xc(%ebp),%edx
801048ae:	89 02                	mov    %eax,(%edx)
  return 0;
801048b0:	31 c0                	xor    %eax,%eax
}
801048b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048b5:	5b                   	pop    %ebx
801048b6:	5e                   	pop    %esi
801048b7:	5d                   	pop    %ebp
801048b8:	c3                   	ret    
801048b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048c5:	eb eb                	jmp    801048b2 <argptr+0x42>
801048c7:	89 f6                	mov    %esi,%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801048d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048d9:	50                   	push   %eax
801048da:	ff 75 08             	pushl  0x8(%ebp)
801048dd:	e8 3e ff ff ff       	call   80104820 <argint>
801048e2:	83 c4 10             	add    $0x10,%esp
801048e5:	85 c0                	test   %eax,%eax
801048e7:	78 17                	js     80104900 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801048e9:	83 ec 08             	sub    $0x8,%esp
801048ec:	ff 75 0c             	pushl  0xc(%ebp)
801048ef:	ff 75 f4             	pushl  -0xc(%ebp)
801048f2:	e8 b9 fe ff ff       	call   801047b0 <fetchstr>
801048f7:	83 c4 10             	add    $0x10,%esp
}
801048fa:	c9                   	leave  
801048fb:	c3                   	ret    
801048fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104905:	c9                   	leave  
80104906:	c3                   	ret    
80104907:	89 f6                	mov    %esi,%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104910 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	53                   	push   %ebx
80104914:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104917:	e8 94 ef ff ff       	call   801038b0 <myproc>
8010491c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010491e:	8b 40 18             	mov    0x18(%eax),%eax
80104921:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104924:	8d 50 ff             	lea    -0x1(%eax),%edx
80104927:	83 fa 14             	cmp    $0x14,%edx
8010492a:	77 1c                	ja     80104948 <syscall+0x38>
8010492c:	8b 14 85 60 76 10 80 	mov    -0x7fef89a0(,%eax,4),%edx
80104933:	85 d2                	test   %edx,%edx
80104935:	74 11                	je     80104948 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104937:	ff d2                	call   *%edx
80104939:	8b 53 18             	mov    0x18(%ebx),%edx
8010493c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010493f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104942:	c9                   	leave  
80104943:	c3                   	ret    
80104944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104948:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104949:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010494c:	50                   	push   %eax
8010494d:	ff 73 10             	pushl  0x10(%ebx)
80104950:	68 31 76 10 80       	push   $0x80107631
80104955:	e8 c6 bd ff ff       	call   80100720 <cprintf>
    curproc->tf->eax = -1;
8010495a:	8b 43 18             	mov    0x18(%ebx),%eax
8010495d:	83 c4 10             	add    $0x10,%esp
80104960:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104967:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010496a:	c9                   	leave  
8010496b:	c3                   	ret    
8010496c:	66 90                	xchg   %ax,%ax
8010496e:	66 90                	xchg   %ax,%ax

80104970 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	57                   	push   %edi
80104974:	56                   	push   %esi
80104975:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104976:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104979:	83 ec 44             	sub    $0x44,%esp
8010497c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010497f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104982:	56                   	push   %esi
80104983:	50                   	push   %eax
{
80104984:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104987:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010498a:	e8 41 d6 ff ff       	call   80101fd0 <nameiparent>
8010498f:	83 c4 10             	add    $0x10,%esp
80104992:	85 c0                	test   %eax,%eax
80104994:	0f 84 46 01 00 00    	je     80104ae0 <create+0x170>
    return 0;
  ilock(dp);
8010499a:	83 ec 0c             	sub    $0xc,%esp
8010499d:	89 c3                	mov    %eax,%ebx
8010499f:	50                   	push   %eax
801049a0:	e8 ab cd ff ff       	call   80101750 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801049a5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801049a8:	83 c4 0c             	add    $0xc,%esp
801049ab:	50                   	push   %eax
801049ac:	56                   	push   %esi
801049ad:	53                   	push   %ebx
801049ae:	e8 cd d2 ff ff       	call   80101c80 <dirlookup>
801049b3:	83 c4 10             	add    $0x10,%esp
801049b6:	85 c0                	test   %eax,%eax
801049b8:	89 c7                	mov    %eax,%edi
801049ba:	74 34                	je     801049f0 <create+0x80>
    iunlockput(dp);
801049bc:	83 ec 0c             	sub    $0xc,%esp
801049bf:	53                   	push   %ebx
801049c0:	e8 1b d0 ff ff       	call   801019e0 <iunlockput>
    ilock(ip);
801049c5:	89 3c 24             	mov    %edi,(%esp)
801049c8:	e8 83 cd ff ff       	call   80101750 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801049cd:	83 c4 10             	add    $0x10,%esp
801049d0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801049d5:	0f 85 95 00 00 00    	jne    80104a70 <create+0x100>
801049db:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801049e0:	0f 85 8a 00 00 00    	jne    80104a70 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801049e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049e9:	89 f8                	mov    %edi,%eax
801049eb:	5b                   	pop    %ebx
801049ec:	5e                   	pop    %esi
801049ed:	5f                   	pop    %edi
801049ee:	5d                   	pop    %ebp
801049ef:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801049f0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801049f4:	83 ec 08             	sub    $0x8,%esp
801049f7:	50                   	push   %eax
801049f8:	ff 33                	pushl  (%ebx)
801049fa:	e8 e1 cb ff ff       	call   801015e0 <ialloc>
801049ff:	83 c4 10             	add    $0x10,%esp
80104a02:	85 c0                	test   %eax,%eax
80104a04:	89 c7                	mov    %eax,%edi
80104a06:	0f 84 e8 00 00 00    	je     80104af4 <create+0x184>
  ilock(ip);
80104a0c:	83 ec 0c             	sub    $0xc,%esp
80104a0f:	50                   	push   %eax
80104a10:	e8 3b cd ff ff       	call   80101750 <ilock>
  ip->major = major;
80104a15:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104a19:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104a1d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104a21:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104a25:	b8 01 00 00 00       	mov    $0x1,%eax
80104a2a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104a2e:	89 3c 24             	mov    %edi,(%esp)
80104a31:	e8 6a cc ff ff       	call   801016a0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104a36:	83 c4 10             	add    $0x10,%esp
80104a39:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104a3e:	74 50                	je     80104a90 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104a40:	83 ec 04             	sub    $0x4,%esp
80104a43:	ff 77 04             	pushl  0x4(%edi)
80104a46:	56                   	push   %esi
80104a47:	53                   	push   %ebx
80104a48:	e8 a3 d4 ff ff       	call   80101ef0 <dirlink>
80104a4d:	83 c4 10             	add    $0x10,%esp
80104a50:	85 c0                	test   %eax,%eax
80104a52:	0f 88 8f 00 00 00    	js     80104ae7 <create+0x177>
  iunlockput(dp);
80104a58:	83 ec 0c             	sub    $0xc,%esp
80104a5b:	53                   	push   %ebx
80104a5c:	e8 7f cf ff ff       	call   801019e0 <iunlockput>
  return ip;
80104a61:	83 c4 10             	add    $0x10,%esp
}
80104a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a67:	89 f8                	mov    %edi,%eax
80104a69:	5b                   	pop    %ebx
80104a6a:	5e                   	pop    %esi
80104a6b:	5f                   	pop    %edi
80104a6c:	5d                   	pop    %ebp
80104a6d:	c3                   	ret    
80104a6e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104a70:	83 ec 0c             	sub    $0xc,%esp
80104a73:	57                   	push   %edi
    return 0;
80104a74:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104a76:	e8 65 cf ff ff       	call   801019e0 <iunlockput>
    return 0;
80104a7b:	83 c4 10             	add    $0x10,%esp
}
80104a7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a81:	89 f8                	mov    %edi,%eax
80104a83:	5b                   	pop    %ebx
80104a84:	5e                   	pop    %esi
80104a85:	5f                   	pop    %edi
80104a86:	5d                   	pop    %ebp
80104a87:	c3                   	ret    
80104a88:	90                   	nop
80104a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104a90:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104a95:	83 ec 0c             	sub    $0xc,%esp
80104a98:	53                   	push   %ebx
80104a99:	e8 02 cc ff ff       	call   801016a0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104a9e:	83 c4 0c             	add    $0xc,%esp
80104aa1:	ff 77 04             	pushl  0x4(%edi)
80104aa4:	68 d4 76 10 80       	push   $0x801076d4
80104aa9:	57                   	push   %edi
80104aaa:	e8 41 d4 ff ff       	call   80101ef0 <dirlink>
80104aaf:	83 c4 10             	add    $0x10,%esp
80104ab2:	85 c0                	test   %eax,%eax
80104ab4:	78 1c                	js     80104ad2 <create+0x162>
80104ab6:	83 ec 04             	sub    $0x4,%esp
80104ab9:	ff 73 04             	pushl  0x4(%ebx)
80104abc:	68 d3 76 10 80       	push   $0x801076d3
80104ac1:	57                   	push   %edi
80104ac2:	e8 29 d4 ff ff       	call   80101ef0 <dirlink>
80104ac7:	83 c4 10             	add    $0x10,%esp
80104aca:	85 c0                	test   %eax,%eax
80104acc:	0f 89 6e ff ff ff    	jns    80104a40 <create+0xd0>
      panic("create dots");
80104ad2:	83 ec 0c             	sub    $0xc,%esp
80104ad5:	68 c7 76 10 80       	push   $0x801076c7
80104ada:	e8 b1 b8 ff ff       	call   80100390 <panic>
80104adf:	90                   	nop
    return 0;
80104ae0:	31 ff                	xor    %edi,%edi
80104ae2:	e9 ff fe ff ff       	jmp    801049e6 <create+0x76>
    panic("create: dirlink");
80104ae7:	83 ec 0c             	sub    $0xc,%esp
80104aea:	68 d6 76 10 80       	push   $0x801076d6
80104aef:	e8 9c b8 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104af4:	83 ec 0c             	sub    $0xc,%esp
80104af7:	68 b8 76 10 80       	push   $0x801076b8
80104afc:	e8 8f b8 ff ff       	call   80100390 <panic>
80104b01:	eb 0d                	jmp    80104b10 <argfd.constprop.0>
80104b03:	90                   	nop
80104b04:	90                   	nop
80104b05:	90                   	nop
80104b06:	90                   	nop
80104b07:	90                   	nop
80104b08:	90                   	nop
80104b09:	90                   	nop
80104b0a:	90                   	nop
80104b0b:	90                   	nop
80104b0c:	90                   	nop
80104b0d:	90                   	nop
80104b0e:	90                   	nop
80104b0f:	90                   	nop

80104b10 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	56                   	push   %esi
80104b14:	53                   	push   %ebx
80104b15:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104b17:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104b1a:	89 d6                	mov    %edx,%esi
80104b1c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104b1f:	50                   	push   %eax
80104b20:	6a 00                	push   $0x0
80104b22:	e8 f9 fc ff ff       	call   80104820 <argint>
80104b27:	83 c4 10             	add    $0x10,%esp
80104b2a:	85 c0                	test   %eax,%eax
80104b2c:	78 2a                	js     80104b58 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104b2e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104b32:	77 24                	ja     80104b58 <argfd.constprop.0+0x48>
80104b34:	e8 77 ed ff ff       	call   801038b0 <myproc>
80104b39:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b3c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104b40:	85 c0                	test   %eax,%eax
80104b42:	74 14                	je     80104b58 <argfd.constprop.0+0x48>
  if(pfd)
80104b44:	85 db                	test   %ebx,%ebx
80104b46:	74 02                	je     80104b4a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104b48:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104b4a:	89 06                	mov    %eax,(%esi)
  return 0;
80104b4c:	31 c0                	xor    %eax,%eax
}
80104b4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b51:	5b                   	pop    %ebx
80104b52:	5e                   	pop    %esi
80104b53:	5d                   	pop    %ebp
80104b54:	c3                   	ret    
80104b55:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104b58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b5d:	eb ef                	jmp    80104b4e <argfd.constprop.0+0x3e>
80104b5f:	90                   	nop

80104b60 <sys_dup>:
{
80104b60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104b61:	31 c0                	xor    %eax,%eax
{
80104b63:	89 e5                	mov    %esp,%ebp
80104b65:	56                   	push   %esi
80104b66:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104b67:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104b6a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104b6d:	e8 9e ff ff ff       	call   80104b10 <argfd.constprop.0>
80104b72:	85 c0                	test   %eax,%eax
80104b74:	78 42                	js     80104bb8 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104b76:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104b79:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104b7b:	e8 30 ed ff ff       	call   801038b0 <myproc>
80104b80:	eb 0e                	jmp    80104b90 <sys_dup+0x30>
80104b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104b88:	83 c3 01             	add    $0x1,%ebx
80104b8b:	83 fb 10             	cmp    $0x10,%ebx
80104b8e:	74 28                	je     80104bb8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104b90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104b94:	85 d2                	test   %edx,%edx
80104b96:	75 f0                	jne    80104b88 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104b98:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	ff 75 f4             	pushl  -0xc(%ebp)
80104ba2:	e8 09 c3 ff ff       	call   80100eb0 <filedup>
  return fd;
80104ba7:	83 c4 10             	add    $0x10,%esp
}
80104baa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bad:	89 d8                	mov    %ebx,%eax
80104baf:	5b                   	pop    %ebx
80104bb0:	5e                   	pop    %esi
80104bb1:	5d                   	pop    %ebp
80104bb2:	c3                   	ret    
80104bb3:	90                   	nop
80104bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bb8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104bbb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104bc0:	89 d8                	mov    %ebx,%eax
80104bc2:	5b                   	pop    %ebx
80104bc3:	5e                   	pop    %esi
80104bc4:	5d                   	pop    %ebp
80104bc5:	c3                   	ret    
80104bc6:	8d 76 00             	lea    0x0(%esi),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <sys_read>:
{
80104bd0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bd1:	31 c0                	xor    %eax,%eax
{
80104bd3:	89 e5                	mov    %esp,%ebp
80104bd5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bd8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104bdb:	e8 30 ff ff ff       	call   80104b10 <argfd.constprop.0>
80104be0:	85 c0                	test   %eax,%eax
80104be2:	78 4c                	js     80104c30 <sys_read+0x60>
80104be4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104be7:	83 ec 08             	sub    $0x8,%esp
80104bea:	50                   	push   %eax
80104beb:	6a 02                	push   $0x2
80104bed:	e8 2e fc ff ff       	call   80104820 <argint>
80104bf2:	83 c4 10             	add    $0x10,%esp
80104bf5:	85 c0                	test   %eax,%eax
80104bf7:	78 37                	js     80104c30 <sys_read+0x60>
80104bf9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bfc:	83 ec 04             	sub    $0x4,%esp
80104bff:	ff 75 f0             	pushl  -0x10(%ebp)
80104c02:	50                   	push   %eax
80104c03:	6a 01                	push   $0x1
80104c05:	e8 66 fc ff ff       	call   80104870 <argptr>
80104c0a:	83 c4 10             	add    $0x10,%esp
80104c0d:	85 c0                	test   %eax,%eax
80104c0f:	78 1f                	js     80104c30 <sys_read+0x60>
  return fileread(f, p, n);
80104c11:	83 ec 04             	sub    $0x4,%esp
80104c14:	ff 75 f0             	pushl  -0x10(%ebp)
80104c17:	ff 75 f4             	pushl  -0xc(%ebp)
80104c1a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c1d:	e8 fe c3 ff ff       	call   80101020 <fileread>
80104c22:	83 c4 10             	add    $0x10,%esp
}
80104c25:	c9                   	leave  
80104c26:	c3                   	ret    
80104c27:	89 f6                	mov    %esi,%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c35:	c9                   	leave  
80104c36:	c3                   	ret    
80104c37:	89 f6                	mov    %esi,%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <sys_write>:
{
80104c40:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c41:	31 c0                	xor    %eax,%eax
{
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c48:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c4b:	e8 c0 fe ff ff       	call   80104b10 <argfd.constprop.0>
80104c50:	85 c0                	test   %eax,%eax
80104c52:	78 4c                	js     80104ca0 <sys_write+0x60>
80104c54:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c57:	83 ec 08             	sub    $0x8,%esp
80104c5a:	50                   	push   %eax
80104c5b:	6a 02                	push   $0x2
80104c5d:	e8 be fb ff ff       	call   80104820 <argint>
80104c62:	83 c4 10             	add    $0x10,%esp
80104c65:	85 c0                	test   %eax,%eax
80104c67:	78 37                	js     80104ca0 <sys_write+0x60>
80104c69:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c6c:	83 ec 04             	sub    $0x4,%esp
80104c6f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c72:	50                   	push   %eax
80104c73:	6a 01                	push   $0x1
80104c75:	e8 f6 fb ff ff       	call   80104870 <argptr>
80104c7a:	83 c4 10             	add    $0x10,%esp
80104c7d:	85 c0                	test   %eax,%eax
80104c7f:	78 1f                	js     80104ca0 <sys_write+0x60>
  return filewrite(f, p, n);
80104c81:	83 ec 04             	sub    $0x4,%esp
80104c84:	ff 75 f0             	pushl  -0x10(%ebp)
80104c87:	ff 75 f4             	pushl  -0xc(%ebp)
80104c8a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c8d:	e8 1e c4 ff ff       	call   801010b0 <filewrite>
80104c92:	83 c4 10             	add    $0x10,%esp
}
80104c95:	c9                   	leave  
80104c96:	c3                   	ret    
80104c97:	89 f6                	mov    %esi,%esi
80104c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104ca0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ca5:	c9                   	leave  
80104ca6:	c3                   	ret    
80104ca7:	89 f6                	mov    %esi,%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cb0 <sys_close>:
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104cb6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104cb9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cbc:	e8 4f fe ff ff       	call   80104b10 <argfd.constprop.0>
80104cc1:	85 c0                	test   %eax,%eax
80104cc3:	78 2b                	js     80104cf0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104cc5:	e8 e6 eb ff ff       	call   801038b0 <myproc>
80104cca:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104ccd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104cd0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104cd7:	00 
  fileclose(f);
80104cd8:	ff 75 f4             	pushl  -0xc(%ebp)
80104cdb:	e8 20 c2 ff ff       	call   80100f00 <fileclose>
  return 0;
80104ce0:	83 c4 10             	add    $0x10,%esp
80104ce3:	31 c0                	xor    %eax,%eax
}
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <sys_fstat>:
{
80104d00:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d01:	31 c0                	xor    %eax,%eax
{
80104d03:	89 e5                	mov    %esp,%ebp
80104d05:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d08:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d0b:	e8 00 fe ff ff       	call   80104b10 <argfd.constprop.0>
80104d10:	85 c0                	test   %eax,%eax
80104d12:	78 2c                	js     80104d40 <sys_fstat+0x40>
80104d14:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d17:	83 ec 04             	sub    $0x4,%esp
80104d1a:	6a 14                	push   $0x14
80104d1c:	50                   	push   %eax
80104d1d:	6a 01                	push   $0x1
80104d1f:	e8 4c fb ff ff       	call   80104870 <argptr>
80104d24:	83 c4 10             	add    $0x10,%esp
80104d27:	85 c0                	test   %eax,%eax
80104d29:	78 15                	js     80104d40 <sys_fstat+0x40>
  return filestat(f, st);
80104d2b:	83 ec 08             	sub    $0x8,%esp
80104d2e:	ff 75 f4             	pushl  -0xc(%ebp)
80104d31:	ff 75 f0             	pushl  -0x10(%ebp)
80104d34:	e8 97 c2 ff ff       	call   80100fd0 <filestat>
80104d39:	83 c4 10             	add    $0x10,%esp
}
80104d3c:	c9                   	leave  
80104d3d:	c3                   	ret    
80104d3e:	66 90                	xchg   %ax,%ax
    return -1;
80104d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d50 <sys_link>:
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	57                   	push   %edi
80104d54:	56                   	push   %esi
80104d55:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d56:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104d59:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d5c:	50                   	push   %eax
80104d5d:	6a 00                	push   $0x0
80104d5f:	e8 6c fb ff ff       	call   801048d0 <argstr>
80104d64:	83 c4 10             	add    $0x10,%esp
80104d67:	85 c0                	test   %eax,%eax
80104d69:	0f 88 fb 00 00 00    	js     80104e6a <sys_link+0x11a>
80104d6f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104d72:	83 ec 08             	sub    $0x8,%esp
80104d75:	50                   	push   %eax
80104d76:	6a 01                	push   $0x1
80104d78:	e8 53 fb ff ff       	call   801048d0 <argstr>
80104d7d:	83 c4 10             	add    $0x10,%esp
80104d80:	85 c0                	test   %eax,%eax
80104d82:	0f 88 e2 00 00 00    	js     80104e6a <sys_link+0x11a>
  begin_op();
80104d88:	e8 e3 de ff ff       	call   80102c70 <begin_op>
  if((ip = namei(old)) == 0){
80104d8d:	83 ec 0c             	sub    $0xc,%esp
80104d90:	ff 75 d4             	pushl  -0x2c(%ebp)
80104d93:	e8 18 d2 ff ff       	call   80101fb0 <namei>
80104d98:	83 c4 10             	add    $0x10,%esp
80104d9b:	85 c0                	test   %eax,%eax
80104d9d:	89 c3                	mov    %eax,%ebx
80104d9f:	0f 84 ea 00 00 00    	je     80104e8f <sys_link+0x13f>
  ilock(ip);
80104da5:	83 ec 0c             	sub    $0xc,%esp
80104da8:	50                   	push   %eax
80104da9:	e8 a2 c9 ff ff       	call   80101750 <ilock>
  if(ip->type == T_DIR){
80104dae:	83 c4 10             	add    $0x10,%esp
80104db1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104db6:	0f 84 bb 00 00 00    	je     80104e77 <sys_link+0x127>
  ip->nlink++;
80104dbc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104dc1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104dc4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104dc7:	53                   	push   %ebx
80104dc8:	e8 d3 c8 ff ff       	call   801016a0 <iupdate>
  iunlock(ip);
80104dcd:	89 1c 24             	mov    %ebx,(%esp)
80104dd0:	e8 5b ca ff ff       	call   80101830 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104dd5:	58                   	pop    %eax
80104dd6:	5a                   	pop    %edx
80104dd7:	57                   	push   %edi
80104dd8:	ff 75 d0             	pushl  -0x30(%ebp)
80104ddb:	e8 f0 d1 ff ff       	call   80101fd0 <nameiparent>
80104de0:	83 c4 10             	add    $0x10,%esp
80104de3:	85 c0                	test   %eax,%eax
80104de5:	89 c6                	mov    %eax,%esi
80104de7:	74 5b                	je     80104e44 <sys_link+0xf4>
  ilock(dp);
80104de9:	83 ec 0c             	sub    $0xc,%esp
80104dec:	50                   	push   %eax
80104ded:	e8 5e c9 ff ff       	call   80101750 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104df2:	83 c4 10             	add    $0x10,%esp
80104df5:	8b 03                	mov    (%ebx),%eax
80104df7:	39 06                	cmp    %eax,(%esi)
80104df9:	75 3d                	jne    80104e38 <sys_link+0xe8>
80104dfb:	83 ec 04             	sub    $0x4,%esp
80104dfe:	ff 73 04             	pushl  0x4(%ebx)
80104e01:	57                   	push   %edi
80104e02:	56                   	push   %esi
80104e03:	e8 e8 d0 ff ff       	call   80101ef0 <dirlink>
80104e08:	83 c4 10             	add    $0x10,%esp
80104e0b:	85 c0                	test   %eax,%eax
80104e0d:	78 29                	js     80104e38 <sys_link+0xe8>
  iunlockput(dp);
80104e0f:	83 ec 0c             	sub    $0xc,%esp
80104e12:	56                   	push   %esi
80104e13:	e8 c8 cb ff ff       	call   801019e0 <iunlockput>
  iput(ip);
80104e18:	89 1c 24             	mov    %ebx,(%esp)
80104e1b:	e8 60 ca ff ff       	call   80101880 <iput>
  end_op();
80104e20:	e8 bb de ff ff       	call   80102ce0 <end_op>
  return 0;
80104e25:	83 c4 10             	add    $0x10,%esp
80104e28:	31 c0                	xor    %eax,%eax
}
80104e2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e2d:	5b                   	pop    %ebx
80104e2e:	5e                   	pop    %esi
80104e2f:	5f                   	pop    %edi
80104e30:	5d                   	pop    %ebp
80104e31:	c3                   	ret    
80104e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104e38:	83 ec 0c             	sub    $0xc,%esp
80104e3b:	56                   	push   %esi
80104e3c:	e8 9f cb ff ff       	call   801019e0 <iunlockput>
    goto bad;
80104e41:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104e44:	83 ec 0c             	sub    $0xc,%esp
80104e47:	53                   	push   %ebx
80104e48:	e8 03 c9 ff ff       	call   80101750 <ilock>
  ip->nlink--;
80104e4d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e52:	89 1c 24             	mov    %ebx,(%esp)
80104e55:	e8 46 c8 ff ff       	call   801016a0 <iupdate>
  iunlockput(ip);
80104e5a:	89 1c 24             	mov    %ebx,(%esp)
80104e5d:	e8 7e cb ff ff       	call   801019e0 <iunlockput>
  end_op();
80104e62:	e8 79 de ff ff       	call   80102ce0 <end_op>
  return -1;
80104e67:	83 c4 10             	add    $0x10,%esp
}
80104e6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104e6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e72:	5b                   	pop    %ebx
80104e73:	5e                   	pop    %esi
80104e74:	5f                   	pop    %edi
80104e75:	5d                   	pop    %ebp
80104e76:	c3                   	ret    
    iunlockput(ip);
80104e77:	83 ec 0c             	sub    $0xc,%esp
80104e7a:	53                   	push   %ebx
80104e7b:	e8 60 cb ff ff       	call   801019e0 <iunlockput>
    end_op();
80104e80:	e8 5b de ff ff       	call   80102ce0 <end_op>
    return -1;
80104e85:	83 c4 10             	add    $0x10,%esp
80104e88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e8d:	eb 9b                	jmp    80104e2a <sys_link+0xda>
    end_op();
80104e8f:	e8 4c de ff ff       	call   80102ce0 <end_op>
    return -1;
80104e94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e99:	eb 8f                	jmp    80104e2a <sys_link+0xda>
80104e9b:	90                   	nop
80104e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ea0 <sys_unlink>:
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	57                   	push   %edi
80104ea4:	56                   	push   %esi
80104ea5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104ea6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104ea9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104eac:	50                   	push   %eax
80104ead:	6a 00                	push   $0x0
80104eaf:	e8 1c fa ff ff       	call   801048d0 <argstr>
80104eb4:	83 c4 10             	add    $0x10,%esp
80104eb7:	85 c0                	test   %eax,%eax
80104eb9:	0f 88 77 01 00 00    	js     80105036 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104ebf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104ec2:	e8 a9 dd ff ff       	call   80102c70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104ec7:	83 ec 08             	sub    $0x8,%esp
80104eca:	53                   	push   %ebx
80104ecb:	ff 75 c0             	pushl  -0x40(%ebp)
80104ece:	e8 fd d0 ff ff       	call   80101fd0 <nameiparent>
80104ed3:	83 c4 10             	add    $0x10,%esp
80104ed6:	85 c0                	test   %eax,%eax
80104ed8:	89 c6                	mov    %eax,%esi
80104eda:	0f 84 60 01 00 00    	je     80105040 <sys_unlink+0x1a0>
  ilock(dp);
80104ee0:	83 ec 0c             	sub    $0xc,%esp
80104ee3:	50                   	push   %eax
80104ee4:	e8 67 c8 ff ff       	call   80101750 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104ee9:	58                   	pop    %eax
80104eea:	5a                   	pop    %edx
80104eeb:	68 d4 76 10 80       	push   $0x801076d4
80104ef0:	53                   	push   %ebx
80104ef1:	e8 6a cd ff ff       	call   80101c60 <namecmp>
80104ef6:	83 c4 10             	add    $0x10,%esp
80104ef9:	85 c0                	test   %eax,%eax
80104efb:	0f 84 03 01 00 00    	je     80105004 <sys_unlink+0x164>
80104f01:	83 ec 08             	sub    $0x8,%esp
80104f04:	68 d3 76 10 80       	push   $0x801076d3
80104f09:	53                   	push   %ebx
80104f0a:	e8 51 cd ff ff       	call   80101c60 <namecmp>
80104f0f:	83 c4 10             	add    $0x10,%esp
80104f12:	85 c0                	test   %eax,%eax
80104f14:	0f 84 ea 00 00 00    	je     80105004 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104f1a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104f1d:	83 ec 04             	sub    $0x4,%esp
80104f20:	50                   	push   %eax
80104f21:	53                   	push   %ebx
80104f22:	56                   	push   %esi
80104f23:	e8 58 cd ff ff       	call   80101c80 <dirlookup>
80104f28:	83 c4 10             	add    $0x10,%esp
80104f2b:	85 c0                	test   %eax,%eax
80104f2d:	89 c3                	mov    %eax,%ebx
80104f2f:	0f 84 cf 00 00 00    	je     80105004 <sys_unlink+0x164>
  ilock(ip);
80104f35:	83 ec 0c             	sub    $0xc,%esp
80104f38:	50                   	push   %eax
80104f39:	e8 12 c8 ff ff       	call   80101750 <ilock>
  if(ip->nlink < 1)
80104f3e:	83 c4 10             	add    $0x10,%esp
80104f41:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104f46:	0f 8e 10 01 00 00    	jle    8010505c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104f4c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f51:	74 6d                	je     80104fc0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80104f53:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104f56:	83 ec 04             	sub    $0x4,%esp
80104f59:	6a 10                	push   $0x10
80104f5b:	6a 00                	push   $0x0
80104f5d:	50                   	push   %eax
80104f5e:	e8 bd f5 ff ff       	call   80104520 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f63:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104f66:	6a 10                	push   $0x10
80104f68:	ff 75 c4             	pushl  -0x3c(%ebp)
80104f6b:	50                   	push   %eax
80104f6c:	56                   	push   %esi
80104f6d:	e8 be cb ff ff       	call   80101b30 <writei>
80104f72:	83 c4 20             	add    $0x20,%esp
80104f75:	83 f8 10             	cmp    $0x10,%eax
80104f78:	0f 85 eb 00 00 00    	jne    80105069 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80104f7e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f83:	0f 84 97 00 00 00    	je     80105020 <sys_unlink+0x180>
  iunlockput(dp);
80104f89:	83 ec 0c             	sub    $0xc,%esp
80104f8c:	56                   	push   %esi
80104f8d:	e8 4e ca ff ff       	call   801019e0 <iunlockput>
  ip->nlink--;
80104f92:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f97:	89 1c 24             	mov    %ebx,(%esp)
80104f9a:	e8 01 c7 ff ff       	call   801016a0 <iupdate>
  iunlockput(ip);
80104f9f:	89 1c 24             	mov    %ebx,(%esp)
80104fa2:	e8 39 ca ff ff       	call   801019e0 <iunlockput>
  end_op();
80104fa7:	e8 34 dd ff ff       	call   80102ce0 <end_op>
  return 0;
80104fac:	83 c4 10             	add    $0x10,%esp
80104faf:	31 c0                	xor    %eax,%eax
}
80104fb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fb4:	5b                   	pop    %ebx
80104fb5:	5e                   	pop    %esi
80104fb6:	5f                   	pop    %edi
80104fb7:	5d                   	pop    %ebp
80104fb8:	c3                   	ret    
80104fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104fc0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104fc4:	76 8d                	jbe    80104f53 <sys_unlink+0xb3>
80104fc6:	bf 20 00 00 00       	mov    $0x20,%edi
80104fcb:	eb 0f                	jmp    80104fdc <sys_unlink+0x13c>
80104fcd:	8d 76 00             	lea    0x0(%esi),%esi
80104fd0:	83 c7 10             	add    $0x10,%edi
80104fd3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80104fd6:	0f 83 77 ff ff ff    	jae    80104f53 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104fdc:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104fdf:	6a 10                	push   $0x10
80104fe1:	57                   	push   %edi
80104fe2:	50                   	push   %eax
80104fe3:	53                   	push   %ebx
80104fe4:	e8 47 ca ff ff       	call   80101a30 <readi>
80104fe9:	83 c4 10             	add    $0x10,%esp
80104fec:	83 f8 10             	cmp    $0x10,%eax
80104fef:	75 5e                	jne    8010504f <sys_unlink+0x1af>
    if(de.inum != 0)
80104ff1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104ff6:	74 d8                	je     80104fd0 <sys_unlink+0x130>
    iunlockput(ip);
80104ff8:	83 ec 0c             	sub    $0xc,%esp
80104ffb:	53                   	push   %ebx
80104ffc:	e8 df c9 ff ff       	call   801019e0 <iunlockput>
    goto bad;
80105001:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105004:	83 ec 0c             	sub    $0xc,%esp
80105007:	56                   	push   %esi
80105008:	e8 d3 c9 ff ff       	call   801019e0 <iunlockput>
  end_op();
8010500d:	e8 ce dc ff ff       	call   80102ce0 <end_op>
  return -1;
80105012:	83 c4 10             	add    $0x10,%esp
80105015:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010501a:	eb 95                	jmp    80104fb1 <sys_unlink+0x111>
8010501c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105020:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105025:	83 ec 0c             	sub    $0xc,%esp
80105028:	56                   	push   %esi
80105029:	e8 72 c6 ff ff       	call   801016a0 <iupdate>
8010502e:	83 c4 10             	add    $0x10,%esp
80105031:	e9 53 ff ff ff       	jmp    80104f89 <sys_unlink+0xe9>
    return -1;
80105036:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010503b:	e9 71 ff ff ff       	jmp    80104fb1 <sys_unlink+0x111>
    end_op();
80105040:	e8 9b dc ff ff       	call   80102ce0 <end_op>
    return -1;
80105045:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010504a:	e9 62 ff ff ff       	jmp    80104fb1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010504f:	83 ec 0c             	sub    $0xc,%esp
80105052:	68 f8 76 10 80       	push   $0x801076f8
80105057:	e8 34 b3 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010505c:	83 ec 0c             	sub    $0xc,%esp
8010505f:	68 e6 76 10 80       	push   $0x801076e6
80105064:	e8 27 b3 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	68 0a 77 10 80       	push   $0x8010770a
80105071:	e8 1a b3 ff ff       	call   80100390 <panic>
80105076:	8d 76 00             	lea    0x0(%esi),%esi
80105079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105080 <sys_open>:

int
sys_open(void)
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	57                   	push   %edi
80105084:	56                   	push   %esi
80105085:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105086:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105089:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010508c:	50                   	push   %eax
8010508d:	6a 00                	push   $0x0
8010508f:	e8 3c f8 ff ff       	call   801048d0 <argstr>
80105094:	83 c4 10             	add    $0x10,%esp
80105097:	85 c0                	test   %eax,%eax
80105099:	0f 88 1d 01 00 00    	js     801051bc <sys_open+0x13c>
8010509f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801050a2:	83 ec 08             	sub    $0x8,%esp
801050a5:	50                   	push   %eax
801050a6:	6a 01                	push   $0x1
801050a8:	e8 73 f7 ff ff       	call   80104820 <argint>
801050ad:	83 c4 10             	add    $0x10,%esp
801050b0:	85 c0                	test   %eax,%eax
801050b2:	0f 88 04 01 00 00    	js     801051bc <sys_open+0x13c>
    return -1;

  begin_op();
801050b8:	e8 b3 db ff ff       	call   80102c70 <begin_op>

  if(omode & O_CREATE){
801050bd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801050c1:	0f 85 a9 00 00 00    	jne    80105170 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801050c7:	83 ec 0c             	sub    $0xc,%esp
801050ca:	ff 75 e0             	pushl  -0x20(%ebp)
801050cd:	e8 de ce ff ff       	call   80101fb0 <namei>
801050d2:	83 c4 10             	add    $0x10,%esp
801050d5:	85 c0                	test   %eax,%eax
801050d7:	89 c6                	mov    %eax,%esi
801050d9:	0f 84 b2 00 00 00    	je     80105191 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801050df:	83 ec 0c             	sub    $0xc,%esp
801050e2:	50                   	push   %eax
801050e3:	e8 68 c6 ff ff       	call   80101750 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801050e8:	83 c4 10             	add    $0x10,%esp
801050eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801050f0:	0f 84 aa 00 00 00    	je     801051a0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801050f6:	e8 45 bd ff ff       	call   80100e40 <filealloc>
801050fb:	85 c0                	test   %eax,%eax
801050fd:	89 c7                	mov    %eax,%edi
801050ff:	0f 84 a6 00 00 00    	je     801051ab <sys_open+0x12b>
  struct proc *curproc = myproc();
80105105:	e8 a6 e7 ff ff       	call   801038b0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010510a:	31 db                	xor    %ebx,%ebx
8010510c:	eb 0e                	jmp    8010511c <sys_open+0x9c>
8010510e:	66 90                	xchg   %ax,%ax
80105110:	83 c3 01             	add    $0x1,%ebx
80105113:	83 fb 10             	cmp    $0x10,%ebx
80105116:	0f 84 ac 00 00 00    	je     801051c8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010511c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105120:	85 d2                	test   %edx,%edx
80105122:	75 ec                	jne    80105110 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105124:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105127:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010512b:	56                   	push   %esi
8010512c:	e8 ff c6 ff ff       	call   80101830 <iunlock>
  end_op();
80105131:	e8 aa db ff ff       	call   80102ce0 <end_op>

  f->type = FD_INODE;
80105136:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010513c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010513f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105142:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105145:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010514c:	89 d0                	mov    %edx,%eax
8010514e:	f7 d0                	not    %eax
80105150:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105153:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105156:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105159:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010515d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105160:	89 d8                	mov    %ebx,%eax
80105162:	5b                   	pop    %ebx
80105163:	5e                   	pop    %esi
80105164:	5f                   	pop    %edi
80105165:	5d                   	pop    %ebp
80105166:	c3                   	ret    
80105167:	89 f6                	mov    %esi,%esi
80105169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105170:	83 ec 0c             	sub    $0xc,%esp
80105173:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105176:	31 c9                	xor    %ecx,%ecx
80105178:	6a 00                	push   $0x0
8010517a:	ba 02 00 00 00       	mov    $0x2,%edx
8010517f:	e8 ec f7 ff ff       	call   80104970 <create>
    if(ip == 0){
80105184:	83 c4 10             	add    $0x10,%esp
80105187:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105189:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010518b:	0f 85 65 ff ff ff    	jne    801050f6 <sys_open+0x76>
      end_op();
80105191:	e8 4a db ff ff       	call   80102ce0 <end_op>
      return -1;
80105196:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010519b:	eb c0                	jmp    8010515d <sys_open+0xdd>
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801051a0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801051a3:	85 c9                	test   %ecx,%ecx
801051a5:	0f 84 4b ff ff ff    	je     801050f6 <sys_open+0x76>
    iunlockput(ip);
801051ab:	83 ec 0c             	sub    $0xc,%esp
801051ae:	56                   	push   %esi
801051af:	e8 2c c8 ff ff       	call   801019e0 <iunlockput>
    end_op();
801051b4:	e8 27 db ff ff       	call   80102ce0 <end_op>
    return -1;
801051b9:	83 c4 10             	add    $0x10,%esp
801051bc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801051c1:	eb 9a                	jmp    8010515d <sys_open+0xdd>
801051c3:	90                   	nop
801051c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801051c8:	83 ec 0c             	sub    $0xc,%esp
801051cb:	57                   	push   %edi
801051cc:	e8 2f bd ff ff       	call   80100f00 <fileclose>
801051d1:	83 c4 10             	add    $0x10,%esp
801051d4:	eb d5                	jmp    801051ab <sys_open+0x12b>
801051d6:	8d 76 00             	lea    0x0(%esi),%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051e0 <sys_mkdir>:

int
sys_mkdir(void)
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801051e6:	e8 85 da ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801051eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051ee:	83 ec 08             	sub    $0x8,%esp
801051f1:	50                   	push   %eax
801051f2:	6a 00                	push   $0x0
801051f4:	e8 d7 f6 ff ff       	call   801048d0 <argstr>
801051f9:	83 c4 10             	add    $0x10,%esp
801051fc:	85 c0                	test   %eax,%eax
801051fe:	78 30                	js     80105230 <sys_mkdir+0x50>
80105200:	83 ec 0c             	sub    $0xc,%esp
80105203:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105206:	31 c9                	xor    %ecx,%ecx
80105208:	6a 00                	push   $0x0
8010520a:	ba 01 00 00 00       	mov    $0x1,%edx
8010520f:	e8 5c f7 ff ff       	call   80104970 <create>
80105214:	83 c4 10             	add    $0x10,%esp
80105217:	85 c0                	test   %eax,%eax
80105219:	74 15                	je     80105230 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010521b:	83 ec 0c             	sub    $0xc,%esp
8010521e:	50                   	push   %eax
8010521f:	e8 bc c7 ff ff       	call   801019e0 <iunlockput>
  end_op();
80105224:	e8 b7 da ff ff       	call   80102ce0 <end_op>
  return 0;
80105229:	83 c4 10             	add    $0x10,%esp
8010522c:	31 c0                	xor    %eax,%eax
}
8010522e:	c9                   	leave  
8010522f:	c3                   	ret    
    end_op();
80105230:	e8 ab da ff ff       	call   80102ce0 <end_op>
    return -1;
80105235:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010523a:	c9                   	leave  
8010523b:	c3                   	ret    
8010523c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105240 <sys_mknod>:

int
sys_mknod(void)
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105246:	e8 25 da ff ff       	call   80102c70 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010524b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010524e:	83 ec 08             	sub    $0x8,%esp
80105251:	50                   	push   %eax
80105252:	6a 00                	push   $0x0
80105254:	e8 77 f6 ff ff       	call   801048d0 <argstr>
80105259:	83 c4 10             	add    $0x10,%esp
8010525c:	85 c0                	test   %eax,%eax
8010525e:	78 60                	js     801052c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105260:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105263:	83 ec 08             	sub    $0x8,%esp
80105266:	50                   	push   %eax
80105267:	6a 01                	push   $0x1
80105269:	e8 b2 f5 ff ff       	call   80104820 <argint>
  if((argstr(0, &path)) < 0 ||
8010526e:	83 c4 10             	add    $0x10,%esp
80105271:	85 c0                	test   %eax,%eax
80105273:	78 4b                	js     801052c0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105275:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105278:	83 ec 08             	sub    $0x8,%esp
8010527b:	50                   	push   %eax
8010527c:	6a 02                	push   $0x2
8010527e:	e8 9d f5 ff ff       	call   80104820 <argint>
     argint(1, &major) < 0 ||
80105283:	83 c4 10             	add    $0x10,%esp
80105286:	85 c0                	test   %eax,%eax
80105288:	78 36                	js     801052c0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010528a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010528e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105291:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105295:	ba 03 00 00 00       	mov    $0x3,%edx
8010529a:	50                   	push   %eax
8010529b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010529e:	e8 cd f6 ff ff       	call   80104970 <create>
801052a3:	83 c4 10             	add    $0x10,%esp
801052a6:	85 c0                	test   %eax,%eax
801052a8:	74 16                	je     801052c0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052aa:	83 ec 0c             	sub    $0xc,%esp
801052ad:	50                   	push   %eax
801052ae:	e8 2d c7 ff ff       	call   801019e0 <iunlockput>
  end_op();
801052b3:	e8 28 da ff ff       	call   80102ce0 <end_op>
  return 0;
801052b8:	83 c4 10             	add    $0x10,%esp
801052bb:	31 c0                	xor    %eax,%eax
}
801052bd:	c9                   	leave  
801052be:	c3                   	ret    
801052bf:	90                   	nop
    end_op();
801052c0:	e8 1b da ff ff       	call   80102ce0 <end_op>
    return -1;
801052c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052ca:	c9                   	leave  
801052cb:	c3                   	ret    
801052cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052d0 <sys_chdir>:

int
sys_chdir(void)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	56                   	push   %esi
801052d4:	53                   	push   %ebx
801052d5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801052d8:	e8 d3 e5 ff ff       	call   801038b0 <myproc>
801052dd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801052df:	e8 8c d9 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801052e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052e7:	83 ec 08             	sub    $0x8,%esp
801052ea:	50                   	push   %eax
801052eb:	6a 00                	push   $0x0
801052ed:	e8 de f5 ff ff       	call   801048d0 <argstr>
801052f2:	83 c4 10             	add    $0x10,%esp
801052f5:	85 c0                	test   %eax,%eax
801052f7:	78 77                	js     80105370 <sys_chdir+0xa0>
801052f9:	83 ec 0c             	sub    $0xc,%esp
801052fc:	ff 75 f4             	pushl  -0xc(%ebp)
801052ff:	e8 ac cc ff ff       	call   80101fb0 <namei>
80105304:	83 c4 10             	add    $0x10,%esp
80105307:	85 c0                	test   %eax,%eax
80105309:	89 c3                	mov    %eax,%ebx
8010530b:	74 63                	je     80105370 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010530d:	83 ec 0c             	sub    $0xc,%esp
80105310:	50                   	push   %eax
80105311:	e8 3a c4 ff ff       	call   80101750 <ilock>
  if(ip->type != T_DIR){
80105316:	83 c4 10             	add    $0x10,%esp
80105319:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010531e:	75 30                	jne    80105350 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105320:	83 ec 0c             	sub    $0xc,%esp
80105323:	53                   	push   %ebx
80105324:	e8 07 c5 ff ff       	call   80101830 <iunlock>
  iput(curproc->cwd);
80105329:	58                   	pop    %eax
8010532a:	ff 76 68             	pushl  0x68(%esi)
8010532d:	e8 4e c5 ff ff       	call   80101880 <iput>
  end_op();
80105332:	e8 a9 d9 ff ff       	call   80102ce0 <end_op>
  curproc->cwd = ip;
80105337:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010533a:	83 c4 10             	add    $0x10,%esp
8010533d:	31 c0                	xor    %eax,%eax
}
8010533f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105342:	5b                   	pop    %ebx
80105343:	5e                   	pop    %esi
80105344:	5d                   	pop    %ebp
80105345:	c3                   	ret    
80105346:	8d 76 00             	lea    0x0(%esi),%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	53                   	push   %ebx
80105354:	e8 87 c6 ff ff       	call   801019e0 <iunlockput>
    end_op();
80105359:	e8 82 d9 ff ff       	call   80102ce0 <end_op>
    return -1;
8010535e:	83 c4 10             	add    $0x10,%esp
80105361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105366:	eb d7                	jmp    8010533f <sys_chdir+0x6f>
80105368:	90                   	nop
80105369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105370:	e8 6b d9 ff ff       	call   80102ce0 <end_op>
    return -1;
80105375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010537a:	eb c3                	jmp    8010533f <sys_chdir+0x6f>
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_exec>:

int
sys_exec(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	57                   	push   %edi
80105384:	56                   	push   %esi
80105385:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105386:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010538c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105392:	50                   	push   %eax
80105393:	6a 00                	push   $0x0
80105395:	e8 36 f5 ff ff       	call   801048d0 <argstr>
8010539a:	83 c4 10             	add    $0x10,%esp
8010539d:	85 c0                	test   %eax,%eax
8010539f:	0f 88 87 00 00 00    	js     8010542c <sys_exec+0xac>
801053a5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801053ab:	83 ec 08             	sub    $0x8,%esp
801053ae:	50                   	push   %eax
801053af:	6a 01                	push   $0x1
801053b1:	e8 6a f4 ff ff       	call   80104820 <argint>
801053b6:	83 c4 10             	add    $0x10,%esp
801053b9:	85 c0                	test   %eax,%eax
801053bb:	78 6f                	js     8010542c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801053bd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801053c3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801053c6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801053c8:	68 80 00 00 00       	push   $0x80
801053cd:	6a 00                	push   $0x0
801053cf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801053d5:	50                   	push   %eax
801053d6:	e8 45 f1 ff ff       	call   80104520 <memset>
801053db:	83 c4 10             	add    $0x10,%esp
801053de:	eb 2c                	jmp    8010540c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801053e0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801053e6:	85 c0                	test   %eax,%eax
801053e8:	74 56                	je     80105440 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801053ea:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801053f0:	83 ec 08             	sub    $0x8,%esp
801053f3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801053f6:	52                   	push   %edx
801053f7:	50                   	push   %eax
801053f8:	e8 b3 f3 ff ff       	call   801047b0 <fetchstr>
801053fd:	83 c4 10             	add    $0x10,%esp
80105400:	85 c0                	test   %eax,%eax
80105402:	78 28                	js     8010542c <sys_exec+0xac>
  for(i=0;; i++){
80105404:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105407:	83 fb 20             	cmp    $0x20,%ebx
8010540a:	74 20                	je     8010542c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010540c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105412:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105419:	83 ec 08             	sub    $0x8,%esp
8010541c:	57                   	push   %edi
8010541d:	01 f0                	add    %esi,%eax
8010541f:	50                   	push   %eax
80105420:	e8 4b f3 ff ff       	call   80104770 <fetchint>
80105425:	83 c4 10             	add    $0x10,%esp
80105428:	85 c0                	test   %eax,%eax
8010542a:	79 b4                	jns    801053e0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010542c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010542f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105434:	5b                   	pop    %ebx
80105435:	5e                   	pop    %esi
80105436:	5f                   	pop    %edi
80105437:	5d                   	pop    %ebp
80105438:	c3                   	ret    
80105439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105440:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105446:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105449:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105450:	00 00 00 00 
  return exec(path, argv);
80105454:	50                   	push   %eax
80105455:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010545b:	e8 70 b6 ff ff       	call   80100ad0 <exec>
80105460:	83 c4 10             	add    $0x10,%esp
}
80105463:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105466:	5b                   	pop    %ebx
80105467:	5e                   	pop    %esi
80105468:	5f                   	pop    %edi
80105469:	5d                   	pop    %ebp
8010546a:	c3                   	ret    
8010546b:	90                   	nop
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105470 <sys_pipe>:

int
sys_pipe(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
80105475:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105476:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105479:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010547c:	6a 08                	push   $0x8
8010547e:	50                   	push   %eax
8010547f:	6a 00                	push   $0x0
80105481:	e8 ea f3 ff ff       	call   80104870 <argptr>
80105486:	83 c4 10             	add    $0x10,%esp
80105489:	85 c0                	test   %eax,%eax
8010548b:	0f 88 ae 00 00 00    	js     8010553f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105491:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105494:	83 ec 08             	sub    $0x8,%esp
80105497:	50                   	push   %eax
80105498:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010549b:	50                   	push   %eax
8010549c:	e8 6f de ff ff       	call   80103310 <pipealloc>
801054a1:	83 c4 10             	add    $0x10,%esp
801054a4:	85 c0                	test   %eax,%eax
801054a6:	0f 88 93 00 00 00    	js     8010553f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801054ac:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801054af:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801054b1:	e8 fa e3 ff ff       	call   801038b0 <myproc>
801054b6:	eb 10                	jmp    801054c8 <sys_pipe+0x58>
801054b8:	90                   	nop
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801054c0:	83 c3 01             	add    $0x1,%ebx
801054c3:	83 fb 10             	cmp    $0x10,%ebx
801054c6:	74 60                	je     80105528 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801054c8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801054cc:	85 f6                	test   %esi,%esi
801054ce:	75 f0                	jne    801054c0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801054d0:	8d 73 08             	lea    0x8(%ebx),%esi
801054d3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801054d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801054da:	e8 d1 e3 ff ff       	call   801038b0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801054df:	31 d2                	xor    %edx,%edx
801054e1:	eb 0d                	jmp    801054f0 <sys_pipe+0x80>
801054e3:	90                   	nop
801054e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054e8:	83 c2 01             	add    $0x1,%edx
801054eb:	83 fa 10             	cmp    $0x10,%edx
801054ee:	74 28                	je     80105518 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801054f0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801054f4:	85 c9                	test   %ecx,%ecx
801054f6:	75 f0                	jne    801054e8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801054f8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801054fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801054ff:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105501:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105504:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105507:	31 c0                	xor    %eax,%eax
}
80105509:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010550c:	5b                   	pop    %ebx
8010550d:	5e                   	pop    %esi
8010550e:	5f                   	pop    %edi
8010550f:	5d                   	pop    %ebp
80105510:	c3                   	ret    
80105511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105518:	e8 93 e3 ff ff       	call   801038b0 <myproc>
8010551d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105524:	00 
80105525:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105528:	83 ec 0c             	sub    $0xc,%esp
8010552b:	ff 75 e0             	pushl  -0x20(%ebp)
8010552e:	e8 cd b9 ff ff       	call   80100f00 <fileclose>
    fileclose(wf);
80105533:	58                   	pop    %eax
80105534:	ff 75 e4             	pushl  -0x1c(%ebp)
80105537:	e8 c4 b9 ff ff       	call   80100f00 <fileclose>
    return -1;
8010553c:	83 c4 10             	add    $0x10,%esp
8010553f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105544:	eb c3                	jmp    80105509 <sys_pipe+0x99>
80105546:	66 90                	xchg   %ax,%ax
80105548:	66 90                	xchg   %ax,%ax
8010554a:	66 90                	xchg   %ax,%ax
8010554c:	66 90                	xchg   %ax,%ax
8010554e:	66 90                	xchg   %ax,%ax

80105550 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105553:	5d                   	pop    %ebp
  return fork();
80105554:	e9 f7 e4 ff ff       	jmp    80103a50 <fork>
80105559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105560 <sys_exit>:

int
sys_exit(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	83 ec 08             	sub    $0x8,%esp
  exit();
80105566:	e8 65 e7 ff ff       	call   80103cd0 <exit>
  return 0;  // not reached
}
8010556b:	31 c0                	xor    %eax,%eax
8010556d:	c9                   	leave  
8010556e:	c3                   	ret    
8010556f:	90                   	nop

80105570 <sys_wait>:

int
sys_wait(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105573:	5d                   	pop    %ebp
  return wait();
80105574:	e9 97 e9 ff ff       	jmp    80103f10 <wait>
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105580 <sys_kill>:

int
sys_kill(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105586:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105589:	50                   	push   %eax
8010558a:	6a 00                	push   $0x0
8010558c:	e8 8f f2 ff ff       	call   80104820 <argint>
80105591:	83 c4 10             	add    $0x10,%esp
80105594:	85 c0                	test   %eax,%eax
80105596:	78 18                	js     801055b0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105598:	83 ec 0c             	sub    $0xc,%esp
8010559b:	ff 75 f4             	pushl  -0xc(%ebp)
8010559e:	e8 bd ea ff ff       	call   80104060 <kill>
801055a3:	83 c4 10             	add    $0x10,%esp
}
801055a6:	c9                   	leave  
801055a7:	c3                   	ret    
801055a8:	90                   	nop
801055a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801055b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055b5:	c9                   	leave  
801055b6:	c3                   	ret    
801055b7:	89 f6                	mov    %esi,%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055c0 <sys_getpid>:

int
sys_getpid(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801055c6:	e8 e5 e2 ff ff       	call   801038b0 <myproc>
801055cb:	8b 40 10             	mov    0x10(%eax),%eax
}
801055ce:	c9                   	leave  
801055cf:	c3                   	ret    

801055d0 <sys_sbrk>:

int
sys_sbrk(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801055d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801055d7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801055da:	50                   	push   %eax
801055db:	6a 00                	push   $0x0
801055dd:	e8 3e f2 ff ff       	call   80104820 <argint>
801055e2:	83 c4 10             	add    $0x10,%esp
801055e5:	85 c0                	test   %eax,%eax
801055e7:	78 27                	js     80105610 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801055e9:	e8 c2 e2 ff ff       	call   801038b0 <myproc>
  if(growproc(n) < 0)
801055ee:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801055f1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801055f3:	ff 75 f4             	pushl  -0xc(%ebp)
801055f6:	e8 d5 e3 ff ff       	call   801039d0 <growproc>
801055fb:	83 c4 10             	add    $0x10,%esp
801055fe:	85 c0                	test   %eax,%eax
80105600:	78 0e                	js     80105610 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105602:	89 d8                	mov    %ebx,%eax
80105604:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105607:	c9                   	leave  
80105608:	c3                   	ret    
80105609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105610:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105615:	eb eb                	jmp    80105602 <sys_sbrk+0x32>
80105617:	89 f6                	mov    %esi,%esi
80105619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105620 <sys_sleep>:

int
sys_sleep(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105624:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105627:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010562a:	50                   	push   %eax
8010562b:	6a 00                	push   $0x0
8010562d:	e8 ee f1 ff ff       	call   80104820 <argint>
80105632:	83 c4 10             	add    $0x10,%esp
80105635:	85 c0                	test   %eax,%eax
80105637:	0f 88 8a 00 00 00    	js     801056c7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010563d:	83 ec 0c             	sub    $0xc,%esp
80105640:	68 60 4c 11 80       	push   $0x80114c60
80105645:	e8 c6 ed ff ff       	call   80104410 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010564a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010564d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105650:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
80105656:	85 d2                	test   %edx,%edx
80105658:	75 27                	jne    80105681 <sys_sleep+0x61>
8010565a:	eb 54                	jmp    801056b0 <sys_sleep+0x90>
8010565c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105660:	83 ec 08             	sub    $0x8,%esp
80105663:	68 60 4c 11 80       	push   $0x80114c60
80105668:	68 a0 54 11 80       	push   $0x801154a0
8010566d:	e8 de e7 ff ff       	call   80103e50 <sleep>
  while(ticks - ticks0 < n){
80105672:	a1 a0 54 11 80       	mov    0x801154a0,%eax
80105677:	83 c4 10             	add    $0x10,%esp
8010567a:	29 d8                	sub    %ebx,%eax
8010567c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010567f:	73 2f                	jae    801056b0 <sys_sleep+0x90>
    if(myproc()->killed){
80105681:	e8 2a e2 ff ff       	call   801038b0 <myproc>
80105686:	8b 40 24             	mov    0x24(%eax),%eax
80105689:	85 c0                	test   %eax,%eax
8010568b:	74 d3                	je     80105660 <sys_sleep+0x40>
      release(&tickslock);
8010568d:	83 ec 0c             	sub    $0xc,%esp
80105690:	68 60 4c 11 80       	push   $0x80114c60
80105695:	e8 36 ee ff ff       	call   801044d0 <release>
      return -1;
8010569a:	83 c4 10             	add    $0x10,%esp
8010569d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801056a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056a5:	c9                   	leave  
801056a6:	c3                   	ret    
801056a7:	89 f6                	mov    %esi,%esi
801056a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801056b0:	83 ec 0c             	sub    $0xc,%esp
801056b3:	68 60 4c 11 80       	push   $0x80114c60
801056b8:	e8 13 ee ff ff       	call   801044d0 <release>
  return 0;
801056bd:	83 c4 10             	add    $0x10,%esp
801056c0:	31 c0                	xor    %eax,%eax
}
801056c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056c5:	c9                   	leave  
801056c6:	c3                   	ret    
    return -1;
801056c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056cc:	eb f4                	jmp    801056c2 <sys_sleep+0xa2>
801056ce:	66 90                	xchg   %ax,%ax

801056d0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	53                   	push   %ebx
801056d4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801056d7:	68 60 4c 11 80       	push   $0x80114c60
801056dc:	e8 2f ed ff ff       	call   80104410 <acquire>
  xticks = ticks;
801056e1:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
801056e7:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801056ee:	e8 dd ed ff ff       	call   801044d0 <release>
  return xticks;
}
801056f3:	89 d8                	mov    %ebx,%eax
801056f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056f8:	c9                   	leave  
801056f9:	c3                   	ret    

801056fa <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801056fa:	1e                   	push   %ds
  pushl %es
801056fb:	06                   	push   %es
  pushl %fs
801056fc:	0f a0                	push   %fs
  pushl %gs
801056fe:	0f a8                	push   %gs
  pushal
80105700:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105701:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105705:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105707:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105709:	54                   	push   %esp
  call trap
8010570a:	e8 c1 00 00 00       	call   801057d0 <trap>
  addl $4, %esp
8010570f:	83 c4 04             	add    $0x4,%esp

80105712 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105712:	61                   	popa   
  popl %gs
80105713:	0f a9                	pop    %gs
  popl %fs
80105715:	0f a1                	pop    %fs
  popl %es
80105717:	07                   	pop    %es
  popl %ds
80105718:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105719:	83 c4 08             	add    $0x8,%esp
  iret
8010571c:	cf                   	iret   
8010571d:	66 90                	xchg   %ax,%ax
8010571f:	90                   	nop

80105720 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105720:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105721:	31 c0                	xor    %eax,%eax
{
80105723:	89 e5                	mov    %esp,%ebp
80105725:	83 ec 08             	sub    $0x8,%esp
80105728:	90                   	nop
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105730:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105737:	c7 04 c5 a2 4c 11 80 	movl   $0x8e000008,-0x7feeb35e(,%eax,8)
8010573e:	08 00 00 8e 
80105742:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
80105749:	80 
8010574a:	c1 ea 10             	shr    $0x10,%edx
8010574d:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
80105754:	80 
  for(i = 0; i < 256; i++)
80105755:	83 c0 01             	add    $0x1,%eax
80105758:	3d 00 01 00 00       	cmp    $0x100,%eax
8010575d:	75 d1                	jne    80105730 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010575f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105764:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105767:	c7 05 a2 4e 11 80 08 	movl   $0xef000008,0x80114ea2
8010576e:	00 00 ef 
  initlock(&tickslock, "time");
80105771:	68 19 77 10 80       	push   $0x80107719
80105776:	68 60 4c 11 80       	push   $0x80114c60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010577b:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
80105781:	c1 e8 10             	shr    $0x10,%eax
80105784:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6
  initlock(&tickslock, "time");
8010578a:	e8 41 eb ff ff       	call   801042d0 <initlock>
}
8010578f:	83 c4 10             	add    $0x10,%esp
80105792:	c9                   	leave  
80105793:	c3                   	ret    
80105794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010579a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801057a0 <idtinit>:

void
idtinit(void)
{
801057a0:	55                   	push   %ebp
  pd[0] = size-1;
801057a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801057a6:	89 e5                	mov    %esp,%ebp
801057a8:	83 ec 10             	sub    $0x10,%esp
801057ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801057af:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
801057b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801057b8:	c1 e8 10             	shr    $0x10,%eax
801057bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801057bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801057c2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801057c5:	c9                   	leave  
801057c6:	c3                   	ret    
801057c7:	89 f6                	mov    %esi,%esi
801057c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057d0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	57                   	push   %edi
801057d4:	56                   	push   %esi
801057d5:	53                   	push   %ebx
801057d6:	83 ec 1c             	sub    $0x1c,%esp
801057d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801057dc:	8b 47 30             	mov    0x30(%edi),%eax
801057df:	83 f8 40             	cmp    $0x40,%eax
801057e2:	0f 84 f0 00 00 00    	je     801058d8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801057e8:	83 e8 20             	sub    $0x20,%eax
801057eb:	83 f8 1f             	cmp    $0x1f,%eax
801057ee:	77 10                	ja     80105800 <trap+0x30>
801057f0:	ff 24 85 c0 77 10 80 	jmp    *-0x7fef8840(,%eax,4)
801057f7:	89 f6                	mov    %esi,%esi
801057f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105800:	e8 ab e0 ff ff       	call   801038b0 <myproc>
80105805:	85 c0                	test   %eax,%eax
80105807:	8b 5f 38             	mov    0x38(%edi),%ebx
8010580a:	0f 84 14 02 00 00    	je     80105a24 <trap+0x254>
80105810:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105814:	0f 84 0a 02 00 00    	je     80105a24 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010581a:	0f 20 d1             	mov    %cr2,%ecx
8010581d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105820:	e8 6b e0 ff ff       	call   80103890 <cpuid>
80105825:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105828:	8b 47 34             	mov    0x34(%edi),%eax
8010582b:	8b 77 30             	mov    0x30(%edi),%esi
8010582e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105831:	e8 7a e0 ff ff       	call   801038b0 <myproc>
80105836:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105839:	e8 72 e0 ff ff       	call   801038b0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010583e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105841:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105844:	51                   	push   %ecx
80105845:	53                   	push   %ebx
80105846:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105847:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010584a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010584d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010584e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105851:	52                   	push   %edx
80105852:	ff 70 10             	pushl  0x10(%eax)
80105855:	68 7c 77 10 80       	push   $0x8010777c
8010585a:	e8 c1 ae ff ff       	call   80100720 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010585f:	83 c4 20             	add    $0x20,%esp
80105862:	e8 49 e0 ff ff       	call   801038b0 <myproc>
80105867:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010586e:	e8 3d e0 ff ff       	call   801038b0 <myproc>
80105873:	85 c0                	test   %eax,%eax
80105875:	74 1d                	je     80105894 <trap+0xc4>
80105877:	e8 34 e0 ff ff       	call   801038b0 <myproc>
8010587c:	8b 50 24             	mov    0x24(%eax),%edx
8010587f:	85 d2                	test   %edx,%edx
80105881:	74 11                	je     80105894 <trap+0xc4>
80105883:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105887:	83 e0 03             	and    $0x3,%eax
8010588a:	66 83 f8 03          	cmp    $0x3,%ax
8010588e:	0f 84 4c 01 00 00    	je     801059e0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105894:	e8 17 e0 ff ff       	call   801038b0 <myproc>
80105899:	85 c0                	test   %eax,%eax
8010589b:	74 0b                	je     801058a8 <trap+0xd8>
8010589d:	e8 0e e0 ff ff       	call   801038b0 <myproc>
801058a2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801058a6:	74 68                	je     80105910 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801058a8:	e8 03 e0 ff ff       	call   801038b0 <myproc>
801058ad:	85 c0                	test   %eax,%eax
801058af:	74 19                	je     801058ca <trap+0xfa>
801058b1:	e8 fa df ff ff       	call   801038b0 <myproc>
801058b6:	8b 40 24             	mov    0x24(%eax),%eax
801058b9:	85 c0                	test   %eax,%eax
801058bb:	74 0d                	je     801058ca <trap+0xfa>
801058bd:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801058c1:	83 e0 03             	and    $0x3,%eax
801058c4:	66 83 f8 03          	cmp    $0x3,%ax
801058c8:	74 37                	je     80105901 <trap+0x131>
    exit();
}
801058ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058cd:	5b                   	pop    %ebx
801058ce:	5e                   	pop    %esi
801058cf:	5f                   	pop    %edi
801058d0:	5d                   	pop    %ebp
801058d1:	c3                   	ret    
801058d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801058d8:	e8 d3 df ff ff       	call   801038b0 <myproc>
801058dd:	8b 58 24             	mov    0x24(%eax),%ebx
801058e0:	85 db                	test   %ebx,%ebx
801058e2:	0f 85 e8 00 00 00    	jne    801059d0 <trap+0x200>
    myproc()->tf = tf;
801058e8:	e8 c3 df ff ff       	call   801038b0 <myproc>
801058ed:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801058f0:	e8 1b f0 ff ff       	call   80104910 <syscall>
    if(myproc()->killed)
801058f5:	e8 b6 df ff ff       	call   801038b0 <myproc>
801058fa:	8b 48 24             	mov    0x24(%eax),%ecx
801058fd:	85 c9                	test   %ecx,%ecx
801058ff:	74 c9                	je     801058ca <trap+0xfa>
}
80105901:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105904:	5b                   	pop    %ebx
80105905:	5e                   	pop    %esi
80105906:	5f                   	pop    %edi
80105907:	5d                   	pop    %ebp
      exit();
80105908:	e9 c3 e3 ff ff       	jmp    80103cd0 <exit>
8010590d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105910:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105914:	75 92                	jne    801058a8 <trap+0xd8>
    yield();
80105916:	e8 e5 e4 ff ff       	call   80103e00 <yield>
8010591b:	eb 8b                	jmp    801058a8 <trap+0xd8>
8010591d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105920:	e8 6b df ff ff       	call   80103890 <cpuid>
80105925:	85 c0                	test   %eax,%eax
80105927:	0f 84 c3 00 00 00    	je     801059f0 <trap+0x220>
    lapiceoi();
8010592d:	e8 ee ce ff ff       	call   80102820 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105932:	e8 79 df ff ff       	call   801038b0 <myproc>
80105937:	85 c0                	test   %eax,%eax
80105939:	0f 85 38 ff ff ff    	jne    80105877 <trap+0xa7>
8010593f:	e9 50 ff ff ff       	jmp    80105894 <trap+0xc4>
80105944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105948:	e8 93 cd ff ff       	call   801026e0 <kbdintr>
    lapiceoi();
8010594d:	e8 ce ce ff ff       	call   80102820 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105952:	e8 59 df ff ff       	call   801038b0 <myproc>
80105957:	85 c0                	test   %eax,%eax
80105959:	0f 85 18 ff ff ff    	jne    80105877 <trap+0xa7>
8010595f:	e9 30 ff ff ff       	jmp    80105894 <trap+0xc4>
80105964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105968:	e8 53 02 00 00       	call   80105bc0 <uartintr>
    lapiceoi();
8010596d:	e8 ae ce ff ff       	call   80102820 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105972:	e8 39 df ff ff       	call   801038b0 <myproc>
80105977:	85 c0                	test   %eax,%eax
80105979:	0f 85 f8 fe ff ff    	jne    80105877 <trap+0xa7>
8010597f:	e9 10 ff ff ff       	jmp    80105894 <trap+0xc4>
80105984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105988:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010598c:	8b 77 38             	mov    0x38(%edi),%esi
8010598f:	e8 fc de ff ff       	call   80103890 <cpuid>
80105994:	56                   	push   %esi
80105995:	53                   	push   %ebx
80105996:	50                   	push   %eax
80105997:	68 24 77 10 80       	push   $0x80107724
8010599c:	e8 7f ad ff ff       	call   80100720 <cprintf>
    lapiceoi();
801059a1:	e8 7a ce ff ff       	call   80102820 <lapiceoi>
    break;
801059a6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059a9:	e8 02 df ff ff       	call   801038b0 <myproc>
801059ae:	85 c0                	test   %eax,%eax
801059b0:	0f 85 c1 fe ff ff    	jne    80105877 <trap+0xa7>
801059b6:	e9 d9 fe ff ff       	jmp    80105894 <trap+0xc4>
801059bb:	90                   	nop
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801059c0:	e8 8b c7 ff ff       	call   80102150 <ideintr>
801059c5:	e9 63 ff ff ff       	jmp    8010592d <trap+0x15d>
801059ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801059d0:	e8 fb e2 ff ff       	call   80103cd0 <exit>
801059d5:	e9 0e ff ff ff       	jmp    801058e8 <trap+0x118>
801059da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801059e0:	e8 eb e2 ff ff       	call   80103cd0 <exit>
801059e5:	e9 aa fe ff ff       	jmp    80105894 <trap+0xc4>
801059ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801059f0:	83 ec 0c             	sub    $0xc,%esp
801059f3:	68 60 4c 11 80       	push   $0x80114c60
801059f8:	e8 13 ea ff ff       	call   80104410 <acquire>
      wakeup(&ticks);
801059fd:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
      ticks++;
80105a04:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
80105a0b:	e8 f0 e5 ff ff       	call   80104000 <wakeup>
      release(&tickslock);
80105a10:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105a17:	e8 b4 ea ff ff       	call   801044d0 <release>
80105a1c:	83 c4 10             	add    $0x10,%esp
80105a1f:	e9 09 ff ff ff       	jmp    8010592d <trap+0x15d>
80105a24:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105a27:	e8 64 de ff ff       	call   80103890 <cpuid>
80105a2c:	83 ec 0c             	sub    $0xc,%esp
80105a2f:	56                   	push   %esi
80105a30:	53                   	push   %ebx
80105a31:	50                   	push   %eax
80105a32:	ff 77 30             	pushl  0x30(%edi)
80105a35:	68 48 77 10 80       	push   $0x80107748
80105a3a:	e8 e1 ac ff ff       	call   80100720 <cprintf>
      panic("trap");
80105a3f:	83 c4 14             	add    $0x14,%esp
80105a42:	68 1e 77 10 80       	push   $0x8010771e
80105a47:	e8 44 a9 ff ff       	call   80100390 <panic>
80105a4c:	66 90                	xchg   %ax,%ax
80105a4e:	66 90                	xchg   %ax,%ax

80105a50 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105a50:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105a55:	55                   	push   %ebp
80105a56:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105a58:	85 c0                	test   %eax,%eax
80105a5a:	74 1c                	je     80105a78 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105a5c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105a61:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105a62:	a8 01                	test   $0x1,%al
80105a64:	74 12                	je     80105a78 <uartgetc+0x28>
80105a66:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a6b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105a6c:	0f b6 c0             	movzbl %al,%eax
}
80105a6f:	5d                   	pop    %ebp
80105a70:	c3                   	ret    
80105a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a7d:	5d                   	pop    %ebp
80105a7e:	c3                   	ret    
80105a7f:	90                   	nop

80105a80 <uartputc.part.0>:
uartputc(int c)
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	57                   	push   %edi
80105a84:	56                   	push   %esi
80105a85:	53                   	push   %ebx
80105a86:	89 c7                	mov    %eax,%edi
80105a88:	bb 80 00 00 00       	mov    $0x80,%ebx
80105a8d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105a92:	83 ec 0c             	sub    $0xc,%esp
80105a95:	eb 1b                	jmp    80105ab2 <uartputc.part.0+0x32>
80105a97:	89 f6                	mov    %esi,%esi
80105a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105aa0:	83 ec 0c             	sub    $0xc,%esp
80105aa3:	6a 0a                	push   $0xa
80105aa5:	e8 96 cd ff ff       	call   80102840 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105aaa:	83 c4 10             	add    $0x10,%esp
80105aad:	83 eb 01             	sub    $0x1,%ebx
80105ab0:	74 07                	je     80105ab9 <uartputc.part.0+0x39>
80105ab2:	89 f2                	mov    %esi,%edx
80105ab4:	ec                   	in     (%dx),%al
80105ab5:	a8 20                	test   $0x20,%al
80105ab7:	74 e7                	je     80105aa0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ab9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105abe:	89 f8                	mov    %edi,%eax
80105ac0:	ee                   	out    %al,(%dx)
}
80105ac1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ac4:	5b                   	pop    %ebx
80105ac5:	5e                   	pop    %esi
80105ac6:	5f                   	pop    %edi
80105ac7:	5d                   	pop    %ebp
80105ac8:	c3                   	ret    
80105ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ad0 <uartinit>:
{
80105ad0:	55                   	push   %ebp
80105ad1:	31 c9                	xor    %ecx,%ecx
80105ad3:	89 c8                	mov    %ecx,%eax
80105ad5:	89 e5                	mov    %esp,%ebp
80105ad7:	57                   	push   %edi
80105ad8:	56                   	push   %esi
80105ad9:	53                   	push   %ebx
80105ada:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105adf:	89 da                	mov    %ebx,%edx
80105ae1:	83 ec 0c             	sub    $0xc,%esp
80105ae4:	ee                   	out    %al,(%dx)
80105ae5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105aea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105aef:	89 fa                	mov    %edi,%edx
80105af1:	ee                   	out    %al,(%dx)
80105af2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105af7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105afc:	ee                   	out    %al,(%dx)
80105afd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105b02:	89 c8                	mov    %ecx,%eax
80105b04:	89 f2                	mov    %esi,%edx
80105b06:	ee                   	out    %al,(%dx)
80105b07:	b8 03 00 00 00       	mov    $0x3,%eax
80105b0c:	89 fa                	mov    %edi,%edx
80105b0e:	ee                   	out    %al,(%dx)
80105b0f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105b14:	89 c8                	mov    %ecx,%eax
80105b16:	ee                   	out    %al,(%dx)
80105b17:	b8 01 00 00 00       	mov    $0x1,%eax
80105b1c:	89 f2                	mov    %esi,%edx
80105b1e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b1f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b24:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105b25:	3c ff                	cmp    $0xff,%al
80105b27:	74 5a                	je     80105b83 <uartinit+0xb3>
  uart = 1;
80105b29:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105b30:	00 00 00 
80105b33:	89 da                	mov    %ebx,%edx
80105b35:	ec                   	in     (%dx),%al
80105b36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b3b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105b3c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105b3f:	bb 40 78 10 80       	mov    $0x80107840,%ebx
  ioapicenable(IRQ_COM1, 0);
80105b44:	6a 00                	push   $0x0
80105b46:	6a 04                	push   $0x4
80105b48:	e8 53 c8 ff ff       	call   801023a0 <ioapicenable>
80105b4d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105b50:	b8 78 00 00 00       	mov    $0x78,%eax
80105b55:	eb 13                	jmp    80105b6a <uartinit+0x9a>
80105b57:	89 f6                	mov    %esi,%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105b60:	83 c3 01             	add    $0x1,%ebx
80105b63:	0f be 03             	movsbl (%ebx),%eax
80105b66:	84 c0                	test   %al,%al
80105b68:	74 19                	je     80105b83 <uartinit+0xb3>
  if(!uart)
80105b6a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105b70:	85 d2                	test   %edx,%edx
80105b72:	74 ec                	je     80105b60 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105b74:	83 c3 01             	add    $0x1,%ebx
80105b77:	e8 04 ff ff ff       	call   80105a80 <uartputc.part.0>
80105b7c:	0f be 03             	movsbl (%ebx),%eax
80105b7f:	84 c0                	test   %al,%al
80105b81:	75 e7                	jne    80105b6a <uartinit+0x9a>
}
80105b83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b86:	5b                   	pop    %ebx
80105b87:	5e                   	pop    %esi
80105b88:	5f                   	pop    %edi
80105b89:	5d                   	pop    %ebp
80105b8a:	c3                   	ret    
80105b8b:	90                   	nop
80105b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b90 <uartputc>:
  if(!uart)
80105b90:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105b96:	55                   	push   %ebp
80105b97:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b99:	85 d2                	test   %edx,%edx
{
80105b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105b9e:	74 10                	je     80105bb0 <uartputc+0x20>
}
80105ba0:	5d                   	pop    %ebp
80105ba1:	e9 da fe ff ff       	jmp    80105a80 <uartputc.part.0>
80105ba6:	8d 76 00             	lea    0x0(%esi),%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105bb0:	5d                   	pop    %ebp
80105bb1:	c3                   	ret    
80105bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bc0 <uartintr>:

void
uartintr(void)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105bc6:	68 50 5a 10 80       	push   $0x80105a50
80105bcb:	e8 00 ad ff ff       	call   801008d0 <consoleintr>
}
80105bd0:	83 c4 10             	add    $0x10,%esp
80105bd3:	c9                   	leave  
80105bd4:	c3                   	ret    

80105bd5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105bd5:	6a 00                	push   $0x0
  pushl $0
80105bd7:	6a 00                	push   $0x0
  jmp alltraps
80105bd9:	e9 1c fb ff ff       	jmp    801056fa <alltraps>

80105bde <vector1>:
.globl vector1
vector1:
  pushl $0
80105bde:	6a 00                	push   $0x0
  pushl $1
80105be0:	6a 01                	push   $0x1
  jmp alltraps
80105be2:	e9 13 fb ff ff       	jmp    801056fa <alltraps>

80105be7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105be7:	6a 00                	push   $0x0
  pushl $2
80105be9:	6a 02                	push   $0x2
  jmp alltraps
80105beb:	e9 0a fb ff ff       	jmp    801056fa <alltraps>

80105bf0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105bf0:	6a 00                	push   $0x0
  pushl $3
80105bf2:	6a 03                	push   $0x3
  jmp alltraps
80105bf4:	e9 01 fb ff ff       	jmp    801056fa <alltraps>

80105bf9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105bf9:	6a 00                	push   $0x0
  pushl $4
80105bfb:	6a 04                	push   $0x4
  jmp alltraps
80105bfd:	e9 f8 fa ff ff       	jmp    801056fa <alltraps>

80105c02 <vector5>:
.globl vector5
vector5:
  pushl $0
80105c02:	6a 00                	push   $0x0
  pushl $5
80105c04:	6a 05                	push   $0x5
  jmp alltraps
80105c06:	e9 ef fa ff ff       	jmp    801056fa <alltraps>

80105c0b <vector6>:
.globl vector6
vector6:
  pushl $0
80105c0b:	6a 00                	push   $0x0
  pushl $6
80105c0d:	6a 06                	push   $0x6
  jmp alltraps
80105c0f:	e9 e6 fa ff ff       	jmp    801056fa <alltraps>

80105c14 <vector7>:
.globl vector7
vector7:
  pushl $0
80105c14:	6a 00                	push   $0x0
  pushl $7
80105c16:	6a 07                	push   $0x7
  jmp alltraps
80105c18:	e9 dd fa ff ff       	jmp    801056fa <alltraps>

80105c1d <vector8>:
.globl vector8
vector8:
  pushl $8
80105c1d:	6a 08                	push   $0x8
  jmp alltraps
80105c1f:	e9 d6 fa ff ff       	jmp    801056fa <alltraps>

80105c24 <vector9>:
.globl vector9
vector9:
  pushl $0
80105c24:	6a 00                	push   $0x0
  pushl $9
80105c26:	6a 09                	push   $0x9
  jmp alltraps
80105c28:	e9 cd fa ff ff       	jmp    801056fa <alltraps>

80105c2d <vector10>:
.globl vector10
vector10:
  pushl $10
80105c2d:	6a 0a                	push   $0xa
  jmp alltraps
80105c2f:	e9 c6 fa ff ff       	jmp    801056fa <alltraps>

80105c34 <vector11>:
.globl vector11
vector11:
  pushl $11
80105c34:	6a 0b                	push   $0xb
  jmp alltraps
80105c36:	e9 bf fa ff ff       	jmp    801056fa <alltraps>

80105c3b <vector12>:
.globl vector12
vector12:
  pushl $12
80105c3b:	6a 0c                	push   $0xc
  jmp alltraps
80105c3d:	e9 b8 fa ff ff       	jmp    801056fa <alltraps>

80105c42 <vector13>:
.globl vector13
vector13:
  pushl $13
80105c42:	6a 0d                	push   $0xd
  jmp alltraps
80105c44:	e9 b1 fa ff ff       	jmp    801056fa <alltraps>

80105c49 <vector14>:
.globl vector14
vector14:
  pushl $14
80105c49:	6a 0e                	push   $0xe
  jmp alltraps
80105c4b:	e9 aa fa ff ff       	jmp    801056fa <alltraps>

80105c50 <vector15>:
.globl vector15
vector15:
  pushl $0
80105c50:	6a 00                	push   $0x0
  pushl $15
80105c52:	6a 0f                	push   $0xf
  jmp alltraps
80105c54:	e9 a1 fa ff ff       	jmp    801056fa <alltraps>

80105c59 <vector16>:
.globl vector16
vector16:
  pushl $0
80105c59:	6a 00                	push   $0x0
  pushl $16
80105c5b:	6a 10                	push   $0x10
  jmp alltraps
80105c5d:	e9 98 fa ff ff       	jmp    801056fa <alltraps>

80105c62 <vector17>:
.globl vector17
vector17:
  pushl $17
80105c62:	6a 11                	push   $0x11
  jmp alltraps
80105c64:	e9 91 fa ff ff       	jmp    801056fa <alltraps>

80105c69 <vector18>:
.globl vector18
vector18:
  pushl $0
80105c69:	6a 00                	push   $0x0
  pushl $18
80105c6b:	6a 12                	push   $0x12
  jmp alltraps
80105c6d:	e9 88 fa ff ff       	jmp    801056fa <alltraps>

80105c72 <vector19>:
.globl vector19
vector19:
  pushl $0
80105c72:	6a 00                	push   $0x0
  pushl $19
80105c74:	6a 13                	push   $0x13
  jmp alltraps
80105c76:	e9 7f fa ff ff       	jmp    801056fa <alltraps>

80105c7b <vector20>:
.globl vector20
vector20:
  pushl $0
80105c7b:	6a 00                	push   $0x0
  pushl $20
80105c7d:	6a 14                	push   $0x14
  jmp alltraps
80105c7f:	e9 76 fa ff ff       	jmp    801056fa <alltraps>

80105c84 <vector21>:
.globl vector21
vector21:
  pushl $0
80105c84:	6a 00                	push   $0x0
  pushl $21
80105c86:	6a 15                	push   $0x15
  jmp alltraps
80105c88:	e9 6d fa ff ff       	jmp    801056fa <alltraps>

80105c8d <vector22>:
.globl vector22
vector22:
  pushl $0
80105c8d:	6a 00                	push   $0x0
  pushl $22
80105c8f:	6a 16                	push   $0x16
  jmp alltraps
80105c91:	e9 64 fa ff ff       	jmp    801056fa <alltraps>

80105c96 <vector23>:
.globl vector23
vector23:
  pushl $0
80105c96:	6a 00                	push   $0x0
  pushl $23
80105c98:	6a 17                	push   $0x17
  jmp alltraps
80105c9a:	e9 5b fa ff ff       	jmp    801056fa <alltraps>

80105c9f <vector24>:
.globl vector24
vector24:
  pushl $0
80105c9f:	6a 00                	push   $0x0
  pushl $24
80105ca1:	6a 18                	push   $0x18
  jmp alltraps
80105ca3:	e9 52 fa ff ff       	jmp    801056fa <alltraps>

80105ca8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ca8:	6a 00                	push   $0x0
  pushl $25
80105caa:	6a 19                	push   $0x19
  jmp alltraps
80105cac:	e9 49 fa ff ff       	jmp    801056fa <alltraps>

80105cb1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105cb1:	6a 00                	push   $0x0
  pushl $26
80105cb3:	6a 1a                	push   $0x1a
  jmp alltraps
80105cb5:	e9 40 fa ff ff       	jmp    801056fa <alltraps>

80105cba <vector27>:
.globl vector27
vector27:
  pushl $0
80105cba:	6a 00                	push   $0x0
  pushl $27
80105cbc:	6a 1b                	push   $0x1b
  jmp alltraps
80105cbe:	e9 37 fa ff ff       	jmp    801056fa <alltraps>

80105cc3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105cc3:	6a 00                	push   $0x0
  pushl $28
80105cc5:	6a 1c                	push   $0x1c
  jmp alltraps
80105cc7:	e9 2e fa ff ff       	jmp    801056fa <alltraps>

80105ccc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ccc:	6a 00                	push   $0x0
  pushl $29
80105cce:	6a 1d                	push   $0x1d
  jmp alltraps
80105cd0:	e9 25 fa ff ff       	jmp    801056fa <alltraps>

80105cd5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105cd5:	6a 00                	push   $0x0
  pushl $30
80105cd7:	6a 1e                	push   $0x1e
  jmp alltraps
80105cd9:	e9 1c fa ff ff       	jmp    801056fa <alltraps>

80105cde <vector31>:
.globl vector31
vector31:
  pushl $0
80105cde:	6a 00                	push   $0x0
  pushl $31
80105ce0:	6a 1f                	push   $0x1f
  jmp alltraps
80105ce2:	e9 13 fa ff ff       	jmp    801056fa <alltraps>

80105ce7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105ce7:	6a 00                	push   $0x0
  pushl $32
80105ce9:	6a 20                	push   $0x20
  jmp alltraps
80105ceb:	e9 0a fa ff ff       	jmp    801056fa <alltraps>

80105cf0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105cf0:	6a 00                	push   $0x0
  pushl $33
80105cf2:	6a 21                	push   $0x21
  jmp alltraps
80105cf4:	e9 01 fa ff ff       	jmp    801056fa <alltraps>

80105cf9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105cf9:	6a 00                	push   $0x0
  pushl $34
80105cfb:	6a 22                	push   $0x22
  jmp alltraps
80105cfd:	e9 f8 f9 ff ff       	jmp    801056fa <alltraps>

80105d02 <vector35>:
.globl vector35
vector35:
  pushl $0
80105d02:	6a 00                	push   $0x0
  pushl $35
80105d04:	6a 23                	push   $0x23
  jmp alltraps
80105d06:	e9 ef f9 ff ff       	jmp    801056fa <alltraps>

80105d0b <vector36>:
.globl vector36
vector36:
  pushl $0
80105d0b:	6a 00                	push   $0x0
  pushl $36
80105d0d:	6a 24                	push   $0x24
  jmp alltraps
80105d0f:	e9 e6 f9 ff ff       	jmp    801056fa <alltraps>

80105d14 <vector37>:
.globl vector37
vector37:
  pushl $0
80105d14:	6a 00                	push   $0x0
  pushl $37
80105d16:	6a 25                	push   $0x25
  jmp alltraps
80105d18:	e9 dd f9 ff ff       	jmp    801056fa <alltraps>

80105d1d <vector38>:
.globl vector38
vector38:
  pushl $0
80105d1d:	6a 00                	push   $0x0
  pushl $38
80105d1f:	6a 26                	push   $0x26
  jmp alltraps
80105d21:	e9 d4 f9 ff ff       	jmp    801056fa <alltraps>

80105d26 <vector39>:
.globl vector39
vector39:
  pushl $0
80105d26:	6a 00                	push   $0x0
  pushl $39
80105d28:	6a 27                	push   $0x27
  jmp alltraps
80105d2a:	e9 cb f9 ff ff       	jmp    801056fa <alltraps>

80105d2f <vector40>:
.globl vector40
vector40:
  pushl $0
80105d2f:	6a 00                	push   $0x0
  pushl $40
80105d31:	6a 28                	push   $0x28
  jmp alltraps
80105d33:	e9 c2 f9 ff ff       	jmp    801056fa <alltraps>

80105d38 <vector41>:
.globl vector41
vector41:
  pushl $0
80105d38:	6a 00                	push   $0x0
  pushl $41
80105d3a:	6a 29                	push   $0x29
  jmp alltraps
80105d3c:	e9 b9 f9 ff ff       	jmp    801056fa <alltraps>

80105d41 <vector42>:
.globl vector42
vector42:
  pushl $0
80105d41:	6a 00                	push   $0x0
  pushl $42
80105d43:	6a 2a                	push   $0x2a
  jmp alltraps
80105d45:	e9 b0 f9 ff ff       	jmp    801056fa <alltraps>

80105d4a <vector43>:
.globl vector43
vector43:
  pushl $0
80105d4a:	6a 00                	push   $0x0
  pushl $43
80105d4c:	6a 2b                	push   $0x2b
  jmp alltraps
80105d4e:	e9 a7 f9 ff ff       	jmp    801056fa <alltraps>

80105d53 <vector44>:
.globl vector44
vector44:
  pushl $0
80105d53:	6a 00                	push   $0x0
  pushl $44
80105d55:	6a 2c                	push   $0x2c
  jmp alltraps
80105d57:	e9 9e f9 ff ff       	jmp    801056fa <alltraps>

80105d5c <vector45>:
.globl vector45
vector45:
  pushl $0
80105d5c:	6a 00                	push   $0x0
  pushl $45
80105d5e:	6a 2d                	push   $0x2d
  jmp alltraps
80105d60:	e9 95 f9 ff ff       	jmp    801056fa <alltraps>

80105d65 <vector46>:
.globl vector46
vector46:
  pushl $0
80105d65:	6a 00                	push   $0x0
  pushl $46
80105d67:	6a 2e                	push   $0x2e
  jmp alltraps
80105d69:	e9 8c f9 ff ff       	jmp    801056fa <alltraps>

80105d6e <vector47>:
.globl vector47
vector47:
  pushl $0
80105d6e:	6a 00                	push   $0x0
  pushl $47
80105d70:	6a 2f                	push   $0x2f
  jmp alltraps
80105d72:	e9 83 f9 ff ff       	jmp    801056fa <alltraps>

80105d77 <vector48>:
.globl vector48
vector48:
  pushl $0
80105d77:	6a 00                	push   $0x0
  pushl $48
80105d79:	6a 30                	push   $0x30
  jmp alltraps
80105d7b:	e9 7a f9 ff ff       	jmp    801056fa <alltraps>

80105d80 <vector49>:
.globl vector49
vector49:
  pushl $0
80105d80:	6a 00                	push   $0x0
  pushl $49
80105d82:	6a 31                	push   $0x31
  jmp alltraps
80105d84:	e9 71 f9 ff ff       	jmp    801056fa <alltraps>

80105d89 <vector50>:
.globl vector50
vector50:
  pushl $0
80105d89:	6a 00                	push   $0x0
  pushl $50
80105d8b:	6a 32                	push   $0x32
  jmp alltraps
80105d8d:	e9 68 f9 ff ff       	jmp    801056fa <alltraps>

80105d92 <vector51>:
.globl vector51
vector51:
  pushl $0
80105d92:	6a 00                	push   $0x0
  pushl $51
80105d94:	6a 33                	push   $0x33
  jmp alltraps
80105d96:	e9 5f f9 ff ff       	jmp    801056fa <alltraps>

80105d9b <vector52>:
.globl vector52
vector52:
  pushl $0
80105d9b:	6a 00                	push   $0x0
  pushl $52
80105d9d:	6a 34                	push   $0x34
  jmp alltraps
80105d9f:	e9 56 f9 ff ff       	jmp    801056fa <alltraps>

80105da4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105da4:	6a 00                	push   $0x0
  pushl $53
80105da6:	6a 35                	push   $0x35
  jmp alltraps
80105da8:	e9 4d f9 ff ff       	jmp    801056fa <alltraps>

80105dad <vector54>:
.globl vector54
vector54:
  pushl $0
80105dad:	6a 00                	push   $0x0
  pushl $54
80105daf:	6a 36                	push   $0x36
  jmp alltraps
80105db1:	e9 44 f9 ff ff       	jmp    801056fa <alltraps>

80105db6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105db6:	6a 00                	push   $0x0
  pushl $55
80105db8:	6a 37                	push   $0x37
  jmp alltraps
80105dba:	e9 3b f9 ff ff       	jmp    801056fa <alltraps>

80105dbf <vector56>:
.globl vector56
vector56:
  pushl $0
80105dbf:	6a 00                	push   $0x0
  pushl $56
80105dc1:	6a 38                	push   $0x38
  jmp alltraps
80105dc3:	e9 32 f9 ff ff       	jmp    801056fa <alltraps>

80105dc8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105dc8:	6a 00                	push   $0x0
  pushl $57
80105dca:	6a 39                	push   $0x39
  jmp alltraps
80105dcc:	e9 29 f9 ff ff       	jmp    801056fa <alltraps>

80105dd1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105dd1:	6a 00                	push   $0x0
  pushl $58
80105dd3:	6a 3a                	push   $0x3a
  jmp alltraps
80105dd5:	e9 20 f9 ff ff       	jmp    801056fa <alltraps>

80105dda <vector59>:
.globl vector59
vector59:
  pushl $0
80105dda:	6a 00                	push   $0x0
  pushl $59
80105ddc:	6a 3b                	push   $0x3b
  jmp alltraps
80105dde:	e9 17 f9 ff ff       	jmp    801056fa <alltraps>

80105de3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105de3:	6a 00                	push   $0x0
  pushl $60
80105de5:	6a 3c                	push   $0x3c
  jmp alltraps
80105de7:	e9 0e f9 ff ff       	jmp    801056fa <alltraps>

80105dec <vector61>:
.globl vector61
vector61:
  pushl $0
80105dec:	6a 00                	push   $0x0
  pushl $61
80105dee:	6a 3d                	push   $0x3d
  jmp alltraps
80105df0:	e9 05 f9 ff ff       	jmp    801056fa <alltraps>

80105df5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105df5:	6a 00                	push   $0x0
  pushl $62
80105df7:	6a 3e                	push   $0x3e
  jmp alltraps
80105df9:	e9 fc f8 ff ff       	jmp    801056fa <alltraps>

80105dfe <vector63>:
.globl vector63
vector63:
  pushl $0
80105dfe:	6a 00                	push   $0x0
  pushl $63
80105e00:	6a 3f                	push   $0x3f
  jmp alltraps
80105e02:	e9 f3 f8 ff ff       	jmp    801056fa <alltraps>

80105e07 <vector64>:
.globl vector64
vector64:
  pushl $0
80105e07:	6a 00                	push   $0x0
  pushl $64
80105e09:	6a 40                	push   $0x40
  jmp alltraps
80105e0b:	e9 ea f8 ff ff       	jmp    801056fa <alltraps>

80105e10 <vector65>:
.globl vector65
vector65:
  pushl $0
80105e10:	6a 00                	push   $0x0
  pushl $65
80105e12:	6a 41                	push   $0x41
  jmp alltraps
80105e14:	e9 e1 f8 ff ff       	jmp    801056fa <alltraps>

80105e19 <vector66>:
.globl vector66
vector66:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $66
80105e1b:	6a 42                	push   $0x42
  jmp alltraps
80105e1d:	e9 d8 f8 ff ff       	jmp    801056fa <alltraps>

80105e22 <vector67>:
.globl vector67
vector67:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $67
80105e24:	6a 43                	push   $0x43
  jmp alltraps
80105e26:	e9 cf f8 ff ff       	jmp    801056fa <alltraps>

80105e2b <vector68>:
.globl vector68
vector68:
  pushl $0
80105e2b:	6a 00                	push   $0x0
  pushl $68
80105e2d:	6a 44                	push   $0x44
  jmp alltraps
80105e2f:	e9 c6 f8 ff ff       	jmp    801056fa <alltraps>

80105e34 <vector69>:
.globl vector69
vector69:
  pushl $0
80105e34:	6a 00                	push   $0x0
  pushl $69
80105e36:	6a 45                	push   $0x45
  jmp alltraps
80105e38:	e9 bd f8 ff ff       	jmp    801056fa <alltraps>

80105e3d <vector70>:
.globl vector70
vector70:
  pushl $0
80105e3d:	6a 00                	push   $0x0
  pushl $70
80105e3f:	6a 46                	push   $0x46
  jmp alltraps
80105e41:	e9 b4 f8 ff ff       	jmp    801056fa <alltraps>

80105e46 <vector71>:
.globl vector71
vector71:
  pushl $0
80105e46:	6a 00                	push   $0x0
  pushl $71
80105e48:	6a 47                	push   $0x47
  jmp alltraps
80105e4a:	e9 ab f8 ff ff       	jmp    801056fa <alltraps>

80105e4f <vector72>:
.globl vector72
vector72:
  pushl $0
80105e4f:	6a 00                	push   $0x0
  pushl $72
80105e51:	6a 48                	push   $0x48
  jmp alltraps
80105e53:	e9 a2 f8 ff ff       	jmp    801056fa <alltraps>

80105e58 <vector73>:
.globl vector73
vector73:
  pushl $0
80105e58:	6a 00                	push   $0x0
  pushl $73
80105e5a:	6a 49                	push   $0x49
  jmp alltraps
80105e5c:	e9 99 f8 ff ff       	jmp    801056fa <alltraps>

80105e61 <vector74>:
.globl vector74
vector74:
  pushl $0
80105e61:	6a 00                	push   $0x0
  pushl $74
80105e63:	6a 4a                	push   $0x4a
  jmp alltraps
80105e65:	e9 90 f8 ff ff       	jmp    801056fa <alltraps>

80105e6a <vector75>:
.globl vector75
vector75:
  pushl $0
80105e6a:	6a 00                	push   $0x0
  pushl $75
80105e6c:	6a 4b                	push   $0x4b
  jmp alltraps
80105e6e:	e9 87 f8 ff ff       	jmp    801056fa <alltraps>

80105e73 <vector76>:
.globl vector76
vector76:
  pushl $0
80105e73:	6a 00                	push   $0x0
  pushl $76
80105e75:	6a 4c                	push   $0x4c
  jmp alltraps
80105e77:	e9 7e f8 ff ff       	jmp    801056fa <alltraps>

80105e7c <vector77>:
.globl vector77
vector77:
  pushl $0
80105e7c:	6a 00                	push   $0x0
  pushl $77
80105e7e:	6a 4d                	push   $0x4d
  jmp alltraps
80105e80:	e9 75 f8 ff ff       	jmp    801056fa <alltraps>

80105e85 <vector78>:
.globl vector78
vector78:
  pushl $0
80105e85:	6a 00                	push   $0x0
  pushl $78
80105e87:	6a 4e                	push   $0x4e
  jmp alltraps
80105e89:	e9 6c f8 ff ff       	jmp    801056fa <alltraps>

80105e8e <vector79>:
.globl vector79
vector79:
  pushl $0
80105e8e:	6a 00                	push   $0x0
  pushl $79
80105e90:	6a 4f                	push   $0x4f
  jmp alltraps
80105e92:	e9 63 f8 ff ff       	jmp    801056fa <alltraps>

80105e97 <vector80>:
.globl vector80
vector80:
  pushl $0
80105e97:	6a 00                	push   $0x0
  pushl $80
80105e99:	6a 50                	push   $0x50
  jmp alltraps
80105e9b:	e9 5a f8 ff ff       	jmp    801056fa <alltraps>

80105ea0 <vector81>:
.globl vector81
vector81:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $81
80105ea2:	6a 51                	push   $0x51
  jmp alltraps
80105ea4:	e9 51 f8 ff ff       	jmp    801056fa <alltraps>

80105ea9 <vector82>:
.globl vector82
vector82:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $82
80105eab:	6a 52                	push   $0x52
  jmp alltraps
80105ead:	e9 48 f8 ff ff       	jmp    801056fa <alltraps>

80105eb2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $83
80105eb4:	6a 53                	push   $0x53
  jmp alltraps
80105eb6:	e9 3f f8 ff ff       	jmp    801056fa <alltraps>

80105ebb <vector84>:
.globl vector84
vector84:
  pushl $0
80105ebb:	6a 00                	push   $0x0
  pushl $84
80105ebd:	6a 54                	push   $0x54
  jmp alltraps
80105ebf:	e9 36 f8 ff ff       	jmp    801056fa <alltraps>

80105ec4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105ec4:	6a 00                	push   $0x0
  pushl $85
80105ec6:	6a 55                	push   $0x55
  jmp alltraps
80105ec8:	e9 2d f8 ff ff       	jmp    801056fa <alltraps>

80105ecd <vector86>:
.globl vector86
vector86:
  pushl $0
80105ecd:	6a 00                	push   $0x0
  pushl $86
80105ecf:	6a 56                	push   $0x56
  jmp alltraps
80105ed1:	e9 24 f8 ff ff       	jmp    801056fa <alltraps>

80105ed6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105ed6:	6a 00                	push   $0x0
  pushl $87
80105ed8:	6a 57                	push   $0x57
  jmp alltraps
80105eda:	e9 1b f8 ff ff       	jmp    801056fa <alltraps>

80105edf <vector88>:
.globl vector88
vector88:
  pushl $0
80105edf:	6a 00                	push   $0x0
  pushl $88
80105ee1:	6a 58                	push   $0x58
  jmp alltraps
80105ee3:	e9 12 f8 ff ff       	jmp    801056fa <alltraps>

80105ee8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105ee8:	6a 00                	push   $0x0
  pushl $89
80105eea:	6a 59                	push   $0x59
  jmp alltraps
80105eec:	e9 09 f8 ff ff       	jmp    801056fa <alltraps>

80105ef1 <vector90>:
.globl vector90
vector90:
  pushl $0
80105ef1:	6a 00                	push   $0x0
  pushl $90
80105ef3:	6a 5a                	push   $0x5a
  jmp alltraps
80105ef5:	e9 00 f8 ff ff       	jmp    801056fa <alltraps>

80105efa <vector91>:
.globl vector91
vector91:
  pushl $0
80105efa:	6a 00                	push   $0x0
  pushl $91
80105efc:	6a 5b                	push   $0x5b
  jmp alltraps
80105efe:	e9 f7 f7 ff ff       	jmp    801056fa <alltraps>

80105f03 <vector92>:
.globl vector92
vector92:
  pushl $0
80105f03:	6a 00                	push   $0x0
  pushl $92
80105f05:	6a 5c                	push   $0x5c
  jmp alltraps
80105f07:	e9 ee f7 ff ff       	jmp    801056fa <alltraps>

80105f0c <vector93>:
.globl vector93
vector93:
  pushl $0
80105f0c:	6a 00                	push   $0x0
  pushl $93
80105f0e:	6a 5d                	push   $0x5d
  jmp alltraps
80105f10:	e9 e5 f7 ff ff       	jmp    801056fa <alltraps>

80105f15 <vector94>:
.globl vector94
vector94:
  pushl $0
80105f15:	6a 00                	push   $0x0
  pushl $94
80105f17:	6a 5e                	push   $0x5e
  jmp alltraps
80105f19:	e9 dc f7 ff ff       	jmp    801056fa <alltraps>

80105f1e <vector95>:
.globl vector95
vector95:
  pushl $0
80105f1e:	6a 00                	push   $0x0
  pushl $95
80105f20:	6a 5f                	push   $0x5f
  jmp alltraps
80105f22:	e9 d3 f7 ff ff       	jmp    801056fa <alltraps>

80105f27 <vector96>:
.globl vector96
vector96:
  pushl $0
80105f27:	6a 00                	push   $0x0
  pushl $96
80105f29:	6a 60                	push   $0x60
  jmp alltraps
80105f2b:	e9 ca f7 ff ff       	jmp    801056fa <alltraps>

80105f30 <vector97>:
.globl vector97
vector97:
  pushl $0
80105f30:	6a 00                	push   $0x0
  pushl $97
80105f32:	6a 61                	push   $0x61
  jmp alltraps
80105f34:	e9 c1 f7 ff ff       	jmp    801056fa <alltraps>

80105f39 <vector98>:
.globl vector98
vector98:
  pushl $0
80105f39:	6a 00                	push   $0x0
  pushl $98
80105f3b:	6a 62                	push   $0x62
  jmp alltraps
80105f3d:	e9 b8 f7 ff ff       	jmp    801056fa <alltraps>

80105f42 <vector99>:
.globl vector99
vector99:
  pushl $0
80105f42:	6a 00                	push   $0x0
  pushl $99
80105f44:	6a 63                	push   $0x63
  jmp alltraps
80105f46:	e9 af f7 ff ff       	jmp    801056fa <alltraps>

80105f4b <vector100>:
.globl vector100
vector100:
  pushl $0
80105f4b:	6a 00                	push   $0x0
  pushl $100
80105f4d:	6a 64                	push   $0x64
  jmp alltraps
80105f4f:	e9 a6 f7 ff ff       	jmp    801056fa <alltraps>

80105f54 <vector101>:
.globl vector101
vector101:
  pushl $0
80105f54:	6a 00                	push   $0x0
  pushl $101
80105f56:	6a 65                	push   $0x65
  jmp alltraps
80105f58:	e9 9d f7 ff ff       	jmp    801056fa <alltraps>

80105f5d <vector102>:
.globl vector102
vector102:
  pushl $0
80105f5d:	6a 00                	push   $0x0
  pushl $102
80105f5f:	6a 66                	push   $0x66
  jmp alltraps
80105f61:	e9 94 f7 ff ff       	jmp    801056fa <alltraps>

80105f66 <vector103>:
.globl vector103
vector103:
  pushl $0
80105f66:	6a 00                	push   $0x0
  pushl $103
80105f68:	6a 67                	push   $0x67
  jmp alltraps
80105f6a:	e9 8b f7 ff ff       	jmp    801056fa <alltraps>

80105f6f <vector104>:
.globl vector104
vector104:
  pushl $0
80105f6f:	6a 00                	push   $0x0
  pushl $104
80105f71:	6a 68                	push   $0x68
  jmp alltraps
80105f73:	e9 82 f7 ff ff       	jmp    801056fa <alltraps>

80105f78 <vector105>:
.globl vector105
vector105:
  pushl $0
80105f78:	6a 00                	push   $0x0
  pushl $105
80105f7a:	6a 69                	push   $0x69
  jmp alltraps
80105f7c:	e9 79 f7 ff ff       	jmp    801056fa <alltraps>

80105f81 <vector106>:
.globl vector106
vector106:
  pushl $0
80105f81:	6a 00                	push   $0x0
  pushl $106
80105f83:	6a 6a                	push   $0x6a
  jmp alltraps
80105f85:	e9 70 f7 ff ff       	jmp    801056fa <alltraps>

80105f8a <vector107>:
.globl vector107
vector107:
  pushl $0
80105f8a:	6a 00                	push   $0x0
  pushl $107
80105f8c:	6a 6b                	push   $0x6b
  jmp alltraps
80105f8e:	e9 67 f7 ff ff       	jmp    801056fa <alltraps>

80105f93 <vector108>:
.globl vector108
vector108:
  pushl $0
80105f93:	6a 00                	push   $0x0
  pushl $108
80105f95:	6a 6c                	push   $0x6c
  jmp alltraps
80105f97:	e9 5e f7 ff ff       	jmp    801056fa <alltraps>

80105f9c <vector109>:
.globl vector109
vector109:
  pushl $0
80105f9c:	6a 00                	push   $0x0
  pushl $109
80105f9e:	6a 6d                	push   $0x6d
  jmp alltraps
80105fa0:	e9 55 f7 ff ff       	jmp    801056fa <alltraps>

80105fa5 <vector110>:
.globl vector110
vector110:
  pushl $0
80105fa5:	6a 00                	push   $0x0
  pushl $110
80105fa7:	6a 6e                	push   $0x6e
  jmp alltraps
80105fa9:	e9 4c f7 ff ff       	jmp    801056fa <alltraps>

80105fae <vector111>:
.globl vector111
vector111:
  pushl $0
80105fae:	6a 00                	push   $0x0
  pushl $111
80105fb0:	6a 6f                	push   $0x6f
  jmp alltraps
80105fb2:	e9 43 f7 ff ff       	jmp    801056fa <alltraps>

80105fb7 <vector112>:
.globl vector112
vector112:
  pushl $0
80105fb7:	6a 00                	push   $0x0
  pushl $112
80105fb9:	6a 70                	push   $0x70
  jmp alltraps
80105fbb:	e9 3a f7 ff ff       	jmp    801056fa <alltraps>

80105fc0 <vector113>:
.globl vector113
vector113:
  pushl $0
80105fc0:	6a 00                	push   $0x0
  pushl $113
80105fc2:	6a 71                	push   $0x71
  jmp alltraps
80105fc4:	e9 31 f7 ff ff       	jmp    801056fa <alltraps>

80105fc9 <vector114>:
.globl vector114
vector114:
  pushl $0
80105fc9:	6a 00                	push   $0x0
  pushl $114
80105fcb:	6a 72                	push   $0x72
  jmp alltraps
80105fcd:	e9 28 f7 ff ff       	jmp    801056fa <alltraps>

80105fd2 <vector115>:
.globl vector115
vector115:
  pushl $0
80105fd2:	6a 00                	push   $0x0
  pushl $115
80105fd4:	6a 73                	push   $0x73
  jmp alltraps
80105fd6:	e9 1f f7 ff ff       	jmp    801056fa <alltraps>

80105fdb <vector116>:
.globl vector116
vector116:
  pushl $0
80105fdb:	6a 00                	push   $0x0
  pushl $116
80105fdd:	6a 74                	push   $0x74
  jmp alltraps
80105fdf:	e9 16 f7 ff ff       	jmp    801056fa <alltraps>

80105fe4 <vector117>:
.globl vector117
vector117:
  pushl $0
80105fe4:	6a 00                	push   $0x0
  pushl $117
80105fe6:	6a 75                	push   $0x75
  jmp alltraps
80105fe8:	e9 0d f7 ff ff       	jmp    801056fa <alltraps>

80105fed <vector118>:
.globl vector118
vector118:
  pushl $0
80105fed:	6a 00                	push   $0x0
  pushl $118
80105fef:	6a 76                	push   $0x76
  jmp alltraps
80105ff1:	e9 04 f7 ff ff       	jmp    801056fa <alltraps>

80105ff6 <vector119>:
.globl vector119
vector119:
  pushl $0
80105ff6:	6a 00                	push   $0x0
  pushl $119
80105ff8:	6a 77                	push   $0x77
  jmp alltraps
80105ffa:	e9 fb f6 ff ff       	jmp    801056fa <alltraps>

80105fff <vector120>:
.globl vector120
vector120:
  pushl $0
80105fff:	6a 00                	push   $0x0
  pushl $120
80106001:	6a 78                	push   $0x78
  jmp alltraps
80106003:	e9 f2 f6 ff ff       	jmp    801056fa <alltraps>

80106008 <vector121>:
.globl vector121
vector121:
  pushl $0
80106008:	6a 00                	push   $0x0
  pushl $121
8010600a:	6a 79                	push   $0x79
  jmp alltraps
8010600c:	e9 e9 f6 ff ff       	jmp    801056fa <alltraps>

80106011 <vector122>:
.globl vector122
vector122:
  pushl $0
80106011:	6a 00                	push   $0x0
  pushl $122
80106013:	6a 7a                	push   $0x7a
  jmp alltraps
80106015:	e9 e0 f6 ff ff       	jmp    801056fa <alltraps>

8010601a <vector123>:
.globl vector123
vector123:
  pushl $0
8010601a:	6a 00                	push   $0x0
  pushl $123
8010601c:	6a 7b                	push   $0x7b
  jmp alltraps
8010601e:	e9 d7 f6 ff ff       	jmp    801056fa <alltraps>

80106023 <vector124>:
.globl vector124
vector124:
  pushl $0
80106023:	6a 00                	push   $0x0
  pushl $124
80106025:	6a 7c                	push   $0x7c
  jmp alltraps
80106027:	e9 ce f6 ff ff       	jmp    801056fa <alltraps>

8010602c <vector125>:
.globl vector125
vector125:
  pushl $0
8010602c:	6a 00                	push   $0x0
  pushl $125
8010602e:	6a 7d                	push   $0x7d
  jmp alltraps
80106030:	e9 c5 f6 ff ff       	jmp    801056fa <alltraps>

80106035 <vector126>:
.globl vector126
vector126:
  pushl $0
80106035:	6a 00                	push   $0x0
  pushl $126
80106037:	6a 7e                	push   $0x7e
  jmp alltraps
80106039:	e9 bc f6 ff ff       	jmp    801056fa <alltraps>

8010603e <vector127>:
.globl vector127
vector127:
  pushl $0
8010603e:	6a 00                	push   $0x0
  pushl $127
80106040:	6a 7f                	push   $0x7f
  jmp alltraps
80106042:	e9 b3 f6 ff ff       	jmp    801056fa <alltraps>

80106047 <vector128>:
.globl vector128
vector128:
  pushl $0
80106047:	6a 00                	push   $0x0
  pushl $128
80106049:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010604e:	e9 a7 f6 ff ff       	jmp    801056fa <alltraps>

80106053 <vector129>:
.globl vector129
vector129:
  pushl $0
80106053:	6a 00                	push   $0x0
  pushl $129
80106055:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010605a:	e9 9b f6 ff ff       	jmp    801056fa <alltraps>

8010605f <vector130>:
.globl vector130
vector130:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $130
80106061:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106066:	e9 8f f6 ff ff       	jmp    801056fa <alltraps>

8010606b <vector131>:
.globl vector131
vector131:
  pushl $0
8010606b:	6a 00                	push   $0x0
  pushl $131
8010606d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106072:	e9 83 f6 ff ff       	jmp    801056fa <alltraps>

80106077 <vector132>:
.globl vector132
vector132:
  pushl $0
80106077:	6a 00                	push   $0x0
  pushl $132
80106079:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010607e:	e9 77 f6 ff ff       	jmp    801056fa <alltraps>

80106083 <vector133>:
.globl vector133
vector133:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $133
80106085:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010608a:	e9 6b f6 ff ff       	jmp    801056fa <alltraps>

8010608f <vector134>:
.globl vector134
vector134:
  pushl $0
8010608f:	6a 00                	push   $0x0
  pushl $134
80106091:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106096:	e9 5f f6 ff ff       	jmp    801056fa <alltraps>

8010609b <vector135>:
.globl vector135
vector135:
  pushl $0
8010609b:	6a 00                	push   $0x0
  pushl $135
8010609d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801060a2:	e9 53 f6 ff ff       	jmp    801056fa <alltraps>

801060a7 <vector136>:
.globl vector136
vector136:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $136
801060a9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801060ae:	e9 47 f6 ff ff       	jmp    801056fa <alltraps>

801060b3 <vector137>:
.globl vector137
vector137:
  pushl $0
801060b3:	6a 00                	push   $0x0
  pushl $137
801060b5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801060ba:	e9 3b f6 ff ff       	jmp    801056fa <alltraps>

801060bf <vector138>:
.globl vector138
vector138:
  pushl $0
801060bf:	6a 00                	push   $0x0
  pushl $138
801060c1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801060c6:	e9 2f f6 ff ff       	jmp    801056fa <alltraps>

801060cb <vector139>:
.globl vector139
vector139:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $139
801060cd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801060d2:	e9 23 f6 ff ff       	jmp    801056fa <alltraps>

801060d7 <vector140>:
.globl vector140
vector140:
  pushl $0
801060d7:	6a 00                	push   $0x0
  pushl $140
801060d9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801060de:	e9 17 f6 ff ff       	jmp    801056fa <alltraps>

801060e3 <vector141>:
.globl vector141
vector141:
  pushl $0
801060e3:	6a 00                	push   $0x0
  pushl $141
801060e5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801060ea:	e9 0b f6 ff ff       	jmp    801056fa <alltraps>

801060ef <vector142>:
.globl vector142
vector142:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $142
801060f1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801060f6:	e9 ff f5 ff ff       	jmp    801056fa <alltraps>

801060fb <vector143>:
.globl vector143
vector143:
  pushl $0
801060fb:	6a 00                	push   $0x0
  pushl $143
801060fd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106102:	e9 f3 f5 ff ff       	jmp    801056fa <alltraps>

80106107 <vector144>:
.globl vector144
vector144:
  pushl $0
80106107:	6a 00                	push   $0x0
  pushl $144
80106109:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010610e:	e9 e7 f5 ff ff       	jmp    801056fa <alltraps>

80106113 <vector145>:
.globl vector145
vector145:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $145
80106115:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010611a:	e9 db f5 ff ff       	jmp    801056fa <alltraps>

8010611f <vector146>:
.globl vector146
vector146:
  pushl $0
8010611f:	6a 00                	push   $0x0
  pushl $146
80106121:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106126:	e9 cf f5 ff ff       	jmp    801056fa <alltraps>

8010612b <vector147>:
.globl vector147
vector147:
  pushl $0
8010612b:	6a 00                	push   $0x0
  pushl $147
8010612d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106132:	e9 c3 f5 ff ff       	jmp    801056fa <alltraps>

80106137 <vector148>:
.globl vector148
vector148:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $148
80106139:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010613e:	e9 b7 f5 ff ff       	jmp    801056fa <alltraps>

80106143 <vector149>:
.globl vector149
vector149:
  pushl $0
80106143:	6a 00                	push   $0x0
  pushl $149
80106145:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010614a:	e9 ab f5 ff ff       	jmp    801056fa <alltraps>

8010614f <vector150>:
.globl vector150
vector150:
  pushl $0
8010614f:	6a 00                	push   $0x0
  pushl $150
80106151:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106156:	e9 9f f5 ff ff       	jmp    801056fa <alltraps>

8010615b <vector151>:
.globl vector151
vector151:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $151
8010615d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106162:	e9 93 f5 ff ff       	jmp    801056fa <alltraps>

80106167 <vector152>:
.globl vector152
vector152:
  pushl $0
80106167:	6a 00                	push   $0x0
  pushl $152
80106169:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010616e:	e9 87 f5 ff ff       	jmp    801056fa <alltraps>

80106173 <vector153>:
.globl vector153
vector153:
  pushl $0
80106173:	6a 00                	push   $0x0
  pushl $153
80106175:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010617a:	e9 7b f5 ff ff       	jmp    801056fa <alltraps>

8010617f <vector154>:
.globl vector154
vector154:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $154
80106181:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106186:	e9 6f f5 ff ff       	jmp    801056fa <alltraps>

8010618b <vector155>:
.globl vector155
vector155:
  pushl $0
8010618b:	6a 00                	push   $0x0
  pushl $155
8010618d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106192:	e9 63 f5 ff ff       	jmp    801056fa <alltraps>

80106197 <vector156>:
.globl vector156
vector156:
  pushl $0
80106197:	6a 00                	push   $0x0
  pushl $156
80106199:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010619e:	e9 57 f5 ff ff       	jmp    801056fa <alltraps>

801061a3 <vector157>:
.globl vector157
vector157:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $157
801061a5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801061aa:	e9 4b f5 ff ff       	jmp    801056fa <alltraps>

801061af <vector158>:
.globl vector158
vector158:
  pushl $0
801061af:	6a 00                	push   $0x0
  pushl $158
801061b1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801061b6:	e9 3f f5 ff ff       	jmp    801056fa <alltraps>

801061bb <vector159>:
.globl vector159
vector159:
  pushl $0
801061bb:	6a 00                	push   $0x0
  pushl $159
801061bd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801061c2:	e9 33 f5 ff ff       	jmp    801056fa <alltraps>

801061c7 <vector160>:
.globl vector160
vector160:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $160
801061c9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801061ce:	e9 27 f5 ff ff       	jmp    801056fa <alltraps>

801061d3 <vector161>:
.globl vector161
vector161:
  pushl $0
801061d3:	6a 00                	push   $0x0
  pushl $161
801061d5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801061da:	e9 1b f5 ff ff       	jmp    801056fa <alltraps>

801061df <vector162>:
.globl vector162
vector162:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $162
801061e1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801061e6:	e9 0f f5 ff ff       	jmp    801056fa <alltraps>

801061eb <vector163>:
.globl vector163
vector163:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $163
801061ed:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801061f2:	e9 03 f5 ff ff       	jmp    801056fa <alltraps>

801061f7 <vector164>:
.globl vector164
vector164:
  pushl $0
801061f7:	6a 00                	push   $0x0
  pushl $164
801061f9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801061fe:	e9 f7 f4 ff ff       	jmp    801056fa <alltraps>

80106203 <vector165>:
.globl vector165
vector165:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $165
80106205:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010620a:	e9 eb f4 ff ff       	jmp    801056fa <alltraps>

8010620f <vector166>:
.globl vector166
vector166:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $166
80106211:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106216:	e9 df f4 ff ff       	jmp    801056fa <alltraps>

8010621b <vector167>:
.globl vector167
vector167:
  pushl $0
8010621b:	6a 00                	push   $0x0
  pushl $167
8010621d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106222:	e9 d3 f4 ff ff       	jmp    801056fa <alltraps>

80106227 <vector168>:
.globl vector168
vector168:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $168
80106229:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010622e:	e9 c7 f4 ff ff       	jmp    801056fa <alltraps>

80106233 <vector169>:
.globl vector169
vector169:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $169
80106235:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010623a:	e9 bb f4 ff ff       	jmp    801056fa <alltraps>

8010623f <vector170>:
.globl vector170
vector170:
  pushl $0
8010623f:	6a 00                	push   $0x0
  pushl $170
80106241:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106246:	e9 af f4 ff ff       	jmp    801056fa <alltraps>

8010624b <vector171>:
.globl vector171
vector171:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $171
8010624d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106252:	e9 a3 f4 ff ff       	jmp    801056fa <alltraps>

80106257 <vector172>:
.globl vector172
vector172:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $172
80106259:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010625e:	e9 97 f4 ff ff       	jmp    801056fa <alltraps>

80106263 <vector173>:
.globl vector173
vector173:
  pushl $0
80106263:	6a 00                	push   $0x0
  pushl $173
80106265:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010626a:	e9 8b f4 ff ff       	jmp    801056fa <alltraps>

8010626f <vector174>:
.globl vector174
vector174:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $174
80106271:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106276:	e9 7f f4 ff ff       	jmp    801056fa <alltraps>

8010627b <vector175>:
.globl vector175
vector175:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $175
8010627d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106282:	e9 73 f4 ff ff       	jmp    801056fa <alltraps>

80106287 <vector176>:
.globl vector176
vector176:
  pushl $0
80106287:	6a 00                	push   $0x0
  pushl $176
80106289:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010628e:	e9 67 f4 ff ff       	jmp    801056fa <alltraps>

80106293 <vector177>:
.globl vector177
vector177:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $177
80106295:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010629a:	e9 5b f4 ff ff       	jmp    801056fa <alltraps>

8010629f <vector178>:
.globl vector178
vector178:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $178
801062a1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801062a6:	e9 4f f4 ff ff       	jmp    801056fa <alltraps>

801062ab <vector179>:
.globl vector179
vector179:
  pushl $0
801062ab:	6a 00                	push   $0x0
  pushl $179
801062ad:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801062b2:	e9 43 f4 ff ff       	jmp    801056fa <alltraps>

801062b7 <vector180>:
.globl vector180
vector180:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $180
801062b9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801062be:	e9 37 f4 ff ff       	jmp    801056fa <alltraps>

801062c3 <vector181>:
.globl vector181
vector181:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $181
801062c5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801062ca:	e9 2b f4 ff ff       	jmp    801056fa <alltraps>

801062cf <vector182>:
.globl vector182
vector182:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $182
801062d1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801062d6:	e9 1f f4 ff ff       	jmp    801056fa <alltraps>

801062db <vector183>:
.globl vector183
vector183:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $183
801062dd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801062e2:	e9 13 f4 ff ff       	jmp    801056fa <alltraps>

801062e7 <vector184>:
.globl vector184
vector184:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $184
801062e9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801062ee:	e9 07 f4 ff ff       	jmp    801056fa <alltraps>

801062f3 <vector185>:
.globl vector185
vector185:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $185
801062f5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801062fa:	e9 fb f3 ff ff       	jmp    801056fa <alltraps>

801062ff <vector186>:
.globl vector186
vector186:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $186
80106301:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106306:	e9 ef f3 ff ff       	jmp    801056fa <alltraps>

8010630b <vector187>:
.globl vector187
vector187:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $187
8010630d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106312:	e9 e3 f3 ff ff       	jmp    801056fa <alltraps>

80106317 <vector188>:
.globl vector188
vector188:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $188
80106319:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010631e:	e9 d7 f3 ff ff       	jmp    801056fa <alltraps>

80106323 <vector189>:
.globl vector189
vector189:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $189
80106325:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010632a:	e9 cb f3 ff ff       	jmp    801056fa <alltraps>

8010632f <vector190>:
.globl vector190
vector190:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $190
80106331:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106336:	e9 bf f3 ff ff       	jmp    801056fa <alltraps>

8010633b <vector191>:
.globl vector191
vector191:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $191
8010633d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106342:	e9 b3 f3 ff ff       	jmp    801056fa <alltraps>

80106347 <vector192>:
.globl vector192
vector192:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $192
80106349:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010634e:	e9 a7 f3 ff ff       	jmp    801056fa <alltraps>

80106353 <vector193>:
.globl vector193
vector193:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $193
80106355:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010635a:	e9 9b f3 ff ff       	jmp    801056fa <alltraps>

8010635f <vector194>:
.globl vector194
vector194:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $194
80106361:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106366:	e9 8f f3 ff ff       	jmp    801056fa <alltraps>

8010636b <vector195>:
.globl vector195
vector195:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $195
8010636d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106372:	e9 83 f3 ff ff       	jmp    801056fa <alltraps>

80106377 <vector196>:
.globl vector196
vector196:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $196
80106379:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010637e:	e9 77 f3 ff ff       	jmp    801056fa <alltraps>

80106383 <vector197>:
.globl vector197
vector197:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $197
80106385:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010638a:	e9 6b f3 ff ff       	jmp    801056fa <alltraps>

8010638f <vector198>:
.globl vector198
vector198:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $198
80106391:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106396:	e9 5f f3 ff ff       	jmp    801056fa <alltraps>

8010639b <vector199>:
.globl vector199
vector199:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $199
8010639d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801063a2:	e9 53 f3 ff ff       	jmp    801056fa <alltraps>

801063a7 <vector200>:
.globl vector200
vector200:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $200
801063a9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801063ae:	e9 47 f3 ff ff       	jmp    801056fa <alltraps>

801063b3 <vector201>:
.globl vector201
vector201:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $201
801063b5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801063ba:	e9 3b f3 ff ff       	jmp    801056fa <alltraps>

801063bf <vector202>:
.globl vector202
vector202:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $202
801063c1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801063c6:	e9 2f f3 ff ff       	jmp    801056fa <alltraps>

801063cb <vector203>:
.globl vector203
vector203:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $203
801063cd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801063d2:	e9 23 f3 ff ff       	jmp    801056fa <alltraps>

801063d7 <vector204>:
.globl vector204
vector204:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $204
801063d9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801063de:	e9 17 f3 ff ff       	jmp    801056fa <alltraps>

801063e3 <vector205>:
.globl vector205
vector205:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $205
801063e5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801063ea:	e9 0b f3 ff ff       	jmp    801056fa <alltraps>

801063ef <vector206>:
.globl vector206
vector206:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $206
801063f1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801063f6:	e9 ff f2 ff ff       	jmp    801056fa <alltraps>

801063fb <vector207>:
.globl vector207
vector207:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $207
801063fd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106402:	e9 f3 f2 ff ff       	jmp    801056fa <alltraps>

80106407 <vector208>:
.globl vector208
vector208:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $208
80106409:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010640e:	e9 e7 f2 ff ff       	jmp    801056fa <alltraps>

80106413 <vector209>:
.globl vector209
vector209:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $209
80106415:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010641a:	e9 db f2 ff ff       	jmp    801056fa <alltraps>

8010641f <vector210>:
.globl vector210
vector210:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $210
80106421:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106426:	e9 cf f2 ff ff       	jmp    801056fa <alltraps>

8010642b <vector211>:
.globl vector211
vector211:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $211
8010642d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106432:	e9 c3 f2 ff ff       	jmp    801056fa <alltraps>

80106437 <vector212>:
.globl vector212
vector212:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $212
80106439:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010643e:	e9 b7 f2 ff ff       	jmp    801056fa <alltraps>

80106443 <vector213>:
.globl vector213
vector213:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $213
80106445:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010644a:	e9 ab f2 ff ff       	jmp    801056fa <alltraps>

8010644f <vector214>:
.globl vector214
vector214:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $214
80106451:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106456:	e9 9f f2 ff ff       	jmp    801056fa <alltraps>

8010645b <vector215>:
.globl vector215
vector215:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $215
8010645d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106462:	e9 93 f2 ff ff       	jmp    801056fa <alltraps>

80106467 <vector216>:
.globl vector216
vector216:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $216
80106469:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010646e:	e9 87 f2 ff ff       	jmp    801056fa <alltraps>

80106473 <vector217>:
.globl vector217
vector217:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $217
80106475:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010647a:	e9 7b f2 ff ff       	jmp    801056fa <alltraps>

8010647f <vector218>:
.globl vector218
vector218:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $218
80106481:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106486:	e9 6f f2 ff ff       	jmp    801056fa <alltraps>

8010648b <vector219>:
.globl vector219
vector219:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $219
8010648d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106492:	e9 63 f2 ff ff       	jmp    801056fa <alltraps>

80106497 <vector220>:
.globl vector220
vector220:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $220
80106499:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010649e:	e9 57 f2 ff ff       	jmp    801056fa <alltraps>

801064a3 <vector221>:
.globl vector221
vector221:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $221
801064a5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801064aa:	e9 4b f2 ff ff       	jmp    801056fa <alltraps>

801064af <vector222>:
.globl vector222
vector222:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $222
801064b1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801064b6:	e9 3f f2 ff ff       	jmp    801056fa <alltraps>

801064bb <vector223>:
.globl vector223
vector223:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $223
801064bd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801064c2:	e9 33 f2 ff ff       	jmp    801056fa <alltraps>

801064c7 <vector224>:
.globl vector224
vector224:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $224
801064c9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801064ce:	e9 27 f2 ff ff       	jmp    801056fa <alltraps>

801064d3 <vector225>:
.globl vector225
vector225:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $225
801064d5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801064da:	e9 1b f2 ff ff       	jmp    801056fa <alltraps>

801064df <vector226>:
.globl vector226
vector226:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $226
801064e1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801064e6:	e9 0f f2 ff ff       	jmp    801056fa <alltraps>

801064eb <vector227>:
.globl vector227
vector227:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $227
801064ed:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801064f2:	e9 03 f2 ff ff       	jmp    801056fa <alltraps>

801064f7 <vector228>:
.globl vector228
vector228:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $228
801064f9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801064fe:	e9 f7 f1 ff ff       	jmp    801056fa <alltraps>

80106503 <vector229>:
.globl vector229
vector229:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $229
80106505:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010650a:	e9 eb f1 ff ff       	jmp    801056fa <alltraps>

8010650f <vector230>:
.globl vector230
vector230:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $230
80106511:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106516:	e9 df f1 ff ff       	jmp    801056fa <alltraps>

8010651b <vector231>:
.globl vector231
vector231:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $231
8010651d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106522:	e9 d3 f1 ff ff       	jmp    801056fa <alltraps>

80106527 <vector232>:
.globl vector232
vector232:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $232
80106529:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010652e:	e9 c7 f1 ff ff       	jmp    801056fa <alltraps>

80106533 <vector233>:
.globl vector233
vector233:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $233
80106535:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010653a:	e9 bb f1 ff ff       	jmp    801056fa <alltraps>

8010653f <vector234>:
.globl vector234
vector234:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $234
80106541:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106546:	e9 af f1 ff ff       	jmp    801056fa <alltraps>

8010654b <vector235>:
.globl vector235
vector235:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $235
8010654d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106552:	e9 a3 f1 ff ff       	jmp    801056fa <alltraps>

80106557 <vector236>:
.globl vector236
vector236:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $236
80106559:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010655e:	e9 97 f1 ff ff       	jmp    801056fa <alltraps>

80106563 <vector237>:
.globl vector237
vector237:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $237
80106565:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010656a:	e9 8b f1 ff ff       	jmp    801056fa <alltraps>

8010656f <vector238>:
.globl vector238
vector238:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $238
80106571:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106576:	e9 7f f1 ff ff       	jmp    801056fa <alltraps>

8010657b <vector239>:
.globl vector239
vector239:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $239
8010657d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106582:	e9 73 f1 ff ff       	jmp    801056fa <alltraps>

80106587 <vector240>:
.globl vector240
vector240:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $240
80106589:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010658e:	e9 67 f1 ff ff       	jmp    801056fa <alltraps>

80106593 <vector241>:
.globl vector241
vector241:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $241
80106595:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010659a:	e9 5b f1 ff ff       	jmp    801056fa <alltraps>

8010659f <vector242>:
.globl vector242
vector242:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $242
801065a1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801065a6:	e9 4f f1 ff ff       	jmp    801056fa <alltraps>

801065ab <vector243>:
.globl vector243
vector243:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $243
801065ad:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801065b2:	e9 43 f1 ff ff       	jmp    801056fa <alltraps>

801065b7 <vector244>:
.globl vector244
vector244:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $244
801065b9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801065be:	e9 37 f1 ff ff       	jmp    801056fa <alltraps>

801065c3 <vector245>:
.globl vector245
vector245:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $245
801065c5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801065ca:	e9 2b f1 ff ff       	jmp    801056fa <alltraps>

801065cf <vector246>:
.globl vector246
vector246:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $246
801065d1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801065d6:	e9 1f f1 ff ff       	jmp    801056fa <alltraps>

801065db <vector247>:
.globl vector247
vector247:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $247
801065dd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801065e2:	e9 13 f1 ff ff       	jmp    801056fa <alltraps>

801065e7 <vector248>:
.globl vector248
vector248:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $248
801065e9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801065ee:	e9 07 f1 ff ff       	jmp    801056fa <alltraps>

801065f3 <vector249>:
.globl vector249
vector249:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $249
801065f5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801065fa:	e9 fb f0 ff ff       	jmp    801056fa <alltraps>

801065ff <vector250>:
.globl vector250
vector250:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $250
80106601:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106606:	e9 ef f0 ff ff       	jmp    801056fa <alltraps>

8010660b <vector251>:
.globl vector251
vector251:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $251
8010660d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106612:	e9 e3 f0 ff ff       	jmp    801056fa <alltraps>

80106617 <vector252>:
.globl vector252
vector252:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $252
80106619:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010661e:	e9 d7 f0 ff ff       	jmp    801056fa <alltraps>

80106623 <vector253>:
.globl vector253
vector253:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $253
80106625:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010662a:	e9 cb f0 ff ff       	jmp    801056fa <alltraps>

8010662f <vector254>:
.globl vector254
vector254:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $254
80106631:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106636:	e9 bf f0 ff ff       	jmp    801056fa <alltraps>

8010663b <vector255>:
.globl vector255
vector255:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $255
8010663d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106642:	e9 b3 f0 ff ff       	jmp    801056fa <alltraps>
80106647:	66 90                	xchg   %ax,%ax
80106649:	66 90                	xchg   %ax,%ax
8010664b:	66 90                	xchg   %ax,%ax
8010664d:	66 90                	xchg   %ax,%ax
8010664f:	90                   	nop

80106650 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106650:	55                   	push   %ebp
80106651:	89 e5                	mov    %esp,%ebp
80106653:	57                   	push   %edi
80106654:	56                   	push   %esi
80106655:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106656:	89 d3                	mov    %edx,%ebx
{
80106658:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010665a:	c1 eb 16             	shr    $0x16,%ebx
8010665d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106660:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106663:	8b 06                	mov    (%esi),%eax
80106665:	a8 01                	test   $0x1,%al
80106667:	74 27                	je     80106690 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106669:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010666e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106674:	c1 ef 0a             	shr    $0xa,%edi
}
80106677:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010667a:	89 fa                	mov    %edi,%edx
8010667c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106682:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106685:	5b                   	pop    %ebx
80106686:	5e                   	pop    %esi
80106687:	5f                   	pop    %edi
80106688:	5d                   	pop    %ebp
80106689:	c3                   	ret    
8010668a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106690:	85 c9                	test   %ecx,%ecx
80106692:	74 2c                	je     801066c0 <walkpgdir+0x70>
80106694:	e8 f7 be ff ff       	call   80102590 <kalloc>
80106699:	85 c0                	test   %eax,%eax
8010669b:	89 c3                	mov    %eax,%ebx
8010669d:	74 21                	je     801066c0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010669f:	83 ec 04             	sub    $0x4,%esp
801066a2:	68 00 10 00 00       	push   $0x1000
801066a7:	6a 00                	push   $0x0
801066a9:	50                   	push   %eax
801066aa:	e8 71 de ff ff       	call   80104520 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801066af:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801066b5:	83 c4 10             	add    $0x10,%esp
801066b8:	83 c8 07             	or     $0x7,%eax
801066bb:	89 06                	mov    %eax,(%esi)
801066bd:	eb b5                	jmp    80106674 <walkpgdir+0x24>
801066bf:	90                   	nop
}
801066c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801066c3:	31 c0                	xor    %eax,%eax
}
801066c5:	5b                   	pop    %ebx
801066c6:	5e                   	pop    %esi
801066c7:	5f                   	pop    %edi
801066c8:	5d                   	pop    %ebp
801066c9:	c3                   	ret    
801066ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801066d0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801066d0:	55                   	push   %ebp
801066d1:	89 e5                	mov    %esp,%ebp
801066d3:	57                   	push   %edi
801066d4:	56                   	push   %esi
801066d5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801066d6:	89 d3                	mov    %edx,%ebx
801066d8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801066de:	83 ec 1c             	sub    $0x1c,%esp
801066e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801066e4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801066e8:	8b 7d 08             	mov    0x8(%ebp),%edi
801066eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801066f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801066f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801066f6:	29 df                	sub    %ebx,%edi
801066f8:	83 c8 01             	or     $0x1,%eax
801066fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801066fe:	eb 15                	jmp    80106715 <mappages+0x45>
    if(*pte & PTE_P)
80106700:	f6 00 01             	testb  $0x1,(%eax)
80106703:	75 45                	jne    8010674a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106705:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106708:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010670b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010670d:	74 31                	je     80106740 <mappages+0x70>
      break;
    a += PGSIZE;
8010670f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106715:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106718:	b9 01 00 00 00       	mov    $0x1,%ecx
8010671d:	89 da                	mov    %ebx,%edx
8010671f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106722:	e8 29 ff ff ff       	call   80106650 <walkpgdir>
80106727:	85 c0                	test   %eax,%eax
80106729:	75 d5                	jne    80106700 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010672b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010672e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106733:	5b                   	pop    %ebx
80106734:	5e                   	pop    %esi
80106735:	5f                   	pop    %edi
80106736:	5d                   	pop    %ebp
80106737:	c3                   	ret    
80106738:	90                   	nop
80106739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106740:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106743:	31 c0                	xor    %eax,%eax
}
80106745:	5b                   	pop    %ebx
80106746:	5e                   	pop    %esi
80106747:	5f                   	pop    %edi
80106748:	5d                   	pop    %ebp
80106749:	c3                   	ret    
      panic("remap");
8010674a:	83 ec 0c             	sub    $0xc,%esp
8010674d:	68 48 78 10 80       	push   $0x80107848
80106752:	e8 39 9c ff ff       	call   80100390 <panic>
80106757:	89 f6                	mov    %esi,%esi
80106759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106760 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106760:	55                   	push   %ebp
80106761:	89 e5                	mov    %esp,%ebp
80106763:	57                   	push   %edi
80106764:	56                   	push   %esi
80106765:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106766:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010676c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010676e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106774:	83 ec 1c             	sub    $0x1c,%esp
80106777:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010677a:	39 d3                	cmp    %edx,%ebx
8010677c:	73 66                	jae    801067e4 <deallocuvm.part.0+0x84>
8010677e:	89 d6                	mov    %edx,%esi
80106780:	eb 3d                	jmp    801067bf <deallocuvm.part.0+0x5f>
80106782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106788:	8b 10                	mov    (%eax),%edx
8010678a:	f6 c2 01             	test   $0x1,%dl
8010678d:	74 26                	je     801067b5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010678f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106795:	74 58                	je     801067ef <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106797:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010679a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801067a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801067a3:	52                   	push   %edx
801067a4:	e8 37 bc ff ff       	call   801023e0 <kfree>
      *pte = 0;
801067a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801067ac:	83 c4 10             	add    $0x10,%esp
801067af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801067b5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067bb:	39 f3                	cmp    %esi,%ebx
801067bd:	73 25                	jae    801067e4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801067bf:	31 c9                	xor    %ecx,%ecx
801067c1:	89 da                	mov    %ebx,%edx
801067c3:	89 f8                	mov    %edi,%eax
801067c5:	e8 86 fe ff ff       	call   80106650 <walkpgdir>
    if(!pte)
801067ca:	85 c0                	test   %eax,%eax
801067cc:	75 ba                	jne    80106788 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801067ce:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801067d4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801067da:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067e0:	39 f3                	cmp    %esi,%ebx
801067e2:	72 db                	jb     801067bf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801067e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801067e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067ea:	5b                   	pop    %ebx
801067eb:	5e                   	pop    %esi
801067ec:	5f                   	pop    %edi
801067ed:	5d                   	pop    %ebp
801067ee:	c3                   	ret    
        panic("kfree");
801067ef:	83 ec 0c             	sub    $0xc,%esp
801067f2:	68 e6 71 10 80       	push   $0x801071e6
801067f7:	e8 94 9b ff ff       	call   80100390 <panic>
801067fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106800 <seginit>:
{
80106800:	55                   	push   %ebp
80106801:	89 e5                	mov    %esp,%ebp
80106803:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106806:	e8 85 d0 ff ff       	call   80103890 <cpuid>
8010680b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106811:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106816:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010681a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106821:	ff 00 00 
80106824:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
8010682b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010682e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106835:	ff 00 00 
80106838:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
8010683f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106842:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106849:	ff 00 00 
8010684c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106853:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106856:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
8010685d:	ff 00 00 
80106860:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106867:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010686a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
8010686f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106873:	c1 e8 10             	shr    $0x10,%eax
80106876:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010687a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010687d:	0f 01 10             	lgdtl  (%eax)
}
80106880:	c9                   	leave  
80106881:	c3                   	ret    
80106882:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106890 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106890:	a1 a4 54 11 80       	mov    0x801154a4,%eax
{
80106895:	55                   	push   %ebp
80106896:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106898:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010689d:	0f 22 d8             	mov    %eax,%cr3
}
801068a0:	5d                   	pop    %ebp
801068a1:	c3                   	ret    
801068a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068b0 <switchuvm>:
{
801068b0:	55                   	push   %ebp
801068b1:	89 e5                	mov    %esp,%ebp
801068b3:	57                   	push   %edi
801068b4:	56                   	push   %esi
801068b5:	53                   	push   %ebx
801068b6:	83 ec 1c             	sub    $0x1c,%esp
801068b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801068bc:	85 db                	test   %ebx,%ebx
801068be:	0f 84 cb 00 00 00    	je     8010698f <switchuvm+0xdf>
  if(p->kstack == 0)
801068c4:	8b 43 08             	mov    0x8(%ebx),%eax
801068c7:	85 c0                	test   %eax,%eax
801068c9:	0f 84 da 00 00 00    	je     801069a9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801068cf:	8b 43 04             	mov    0x4(%ebx),%eax
801068d2:	85 c0                	test   %eax,%eax
801068d4:	0f 84 c2 00 00 00    	je     8010699c <switchuvm+0xec>
  pushcli();
801068da:	e8 61 da ff ff       	call   80104340 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801068df:	e8 2c cf ff ff       	call   80103810 <mycpu>
801068e4:	89 c6                	mov    %eax,%esi
801068e6:	e8 25 cf ff ff       	call   80103810 <mycpu>
801068eb:	89 c7                	mov    %eax,%edi
801068ed:	e8 1e cf ff ff       	call   80103810 <mycpu>
801068f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801068f5:	83 c7 08             	add    $0x8,%edi
801068f8:	e8 13 cf ff ff       	call   80103810 <mycpu>
801068fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106900:	83 c0 08             	add    $0x8,%eax
80106903:	ba 67 00 00 00       	mov    $0x67,%edx
80106908:	c1 e8 18             	shr    $0x18,%eax
8010690b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106912:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106919:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010691f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106924:	83 c1 08             	add    $0x8,%ecx
80106927:	c1 e9 10             	shr    $0x10,%ecx
8010692a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106930:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106935:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010693c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106941:	e8 ca ce ff ff       	call   80103810 <mycpu>
80106946:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010694d:	e8 be ce ff ff       	call   80103810 <mycpu>
80106952:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106956:	8b 73 08             	mov    0x8(%ebx),%esi
80106959:	e8 b2 ce ff ff       	call   80103810 <mycpu>
8010695e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106964:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106967:	e8 a4 ce ff ff       	call   80103810 <mycpu>
8010696c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106970:	b8 28 00 00 00       	mov    $0x28,%eax
80106975:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106978:	8b 43 04             	mov    0x4(%ebx),%eax
8010697b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106980:	0f 22 d8             	mov    %eax,%cr3
}
80106983:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106986:	5b                   	pop    %ebx
80106987:	5e                   	pop    %esi
80106988:	5f                   	pop    %edi
80106989:	5d                   	pop    %ebp
  popcli();
8010698a:	e9 f1 d9 ff ff       	jmp    80104380 <popcli>
    panic("switchuvm: no process");
8010698f:	83 ec 0c             	sub    $0xc,%esp
80106992:	68 4e 78 10 80       	push   $0x8010784e
80106997:	e8 f4 99 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010699c:	83 ec 0c             	sub    $0xc,%esp
8010699f:	68 79 78 10 80       	push   $0x80107879
801069a4:	e8 e7 99 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801069a9:	83 ec 0c             	sub    $0xc,%esp
801069ac:	68 64 78 10 80       	push   $0x80107864
801069b1:	e8 da 99 ff ff       	call   80100390 <panic>
801069b6:	8d 76 00             	lea    0x0(%esi),%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069c0 <inituvm>:
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	57                   	push   %edi
801069c4:	56                   	push   %esi
801069c5:	53                   	push   %ebx
801069c6:	83 ec 1c             	sub    $0x1c,%esp
801069c9:	8b 75 10             	mov    0x10(%ebp),%esi
801069cc:	8b 45 08             	mov    0x8(%ebp),%eax
801069cf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
801069d2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801069d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801069db:	77 49                	ja     80106a26 <inituvm+0x66>
  mem = kalloc();
801069dd:	e8 ae bb ff ff       	call   80102590 <kalloc>
  memset(mem, 0, PGSIZE);
801069e2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801069e5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801069e7:	68 00 10 00 00       	push   $0x1000
801069ec:	6a 00                	push   $0x0
801069ee:	50                   	push   %eax
801069ef:	e8 2c db ff ff       	call   80104520 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801069f4:	58                   	pop    %eax
801069f5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801069fb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106a00:	5a                   	pop    %edx
80106a01:	6a 06                	push   $0x6
80106a03:	50                   	push   %eax
80106a04:	31 d2                	xor    %edx,%edx
80106a06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a09:	e8 c2 fc ff ff       	call   801066d0 <mappages>
  memmove(mem, init, sz);
80106a0e:	89 75 10             	mov    %esi,0x10(%ebp)
80106a11:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106a14:	83 c4 10             	add    $0x10,%esp
80106a17:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106a1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a1d:	5b                   	pop    %ebx
80106a1e:	5e                   	pop    %esi
80106a1f:	5f                   	pop    %edi
80106a20:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106a21:	e9 aa db ff ff       	jmp    801045d0 <memmove>
    panic("inituvm: more than a page");
80106a26:	83 ec 0c             	sub    $0xc,%esp
80106a29:	68 8d 78 10 80       	push   $0x8010788d
80106a2e:	e8 5d 99 ff ff       	call   80100390 <panic>
80106a33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a40 <loaduvm>:
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	57                   	push   %edi
80106a44:	56                   	push   %esi
80106a45:	53                   	push   %ebx
80106a46:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106a49:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106a50:	0f 85 91 00 00 00    	jne    80106ae7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106a56:	8b 75 18             	mov    0x18(%ebp),%esi
80106a59:	31 db                	xor    %ebx,%ebx
80106a5b:	85 f6                	test   %esi,%esi
80106a5d:	75 1a                	jne    80106a79 <loaduvm+0x39>
80106a5f:	eb 6f                	jmp    80106ad0 <loaduvm+0x90>
80106a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a68:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a6e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106a74:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106a77:	76 57                	jbe    80106ad0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106a79:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a7c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a7f:	31 c9                	xor    %ecx,%ecx
80106a81:	01 da                	add    %ebx,%edx
80106a83:	e8 c8 fb ff ff       	call   80106650 <walkpgdir>
80106a88:	85 c0                	test   %eax,%eax
80106a8a:	74 4e                	je     80106ada <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106a8c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106a8e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106a91:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106a96:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106a9b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106aa1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106aa4:	01 d9                	add    %ebx,%ecx
80106aa6:	05 00 00 00 80       	add    $0x80000000,%eax
80106aab:	57                   	push   %edi
80106aac:	51                   	push   %ecx
80106aad:	50                   	push   %eax
80106aae:	ff 75 10             	pushl  0x10(%ebp)
80106ab1:	e8 7a af ff ff       	call   80101a30 <readi>
80106ab6:	83 c4 10             	add    $0x10,%esp
80106ab9:	39 f8                	cmp    %edi,%eax
80106abb:	74 ab                	je     80106a68 <loaduvm+0x28>
}
80106abd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ac5:	5b                   	pop    %ebx
80106ac6:	5e                   	pop    %esi
80106ac7:	5f                   	pop    %edi
80106ac8:	5d                   	pop    %ebp
80106ac9:	c3                   	ret    
80106aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ad3:	31 c0                	xor    %eax,%eax
}
80106ad5:	5b                   	pop    %ebx
80106ad6:	5e                   	pop    %esi
80106ad7:	5f                   	pop    %edi
80106ad8:	5d                   	pop    %ebp
80106ad9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106ada:	83 ec 0c             	sub    $0xc,%esp
80106add:	68 a7 78 10 80       	push   $0x801078a7
80106ae2:	e8 a9 98 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106ae7:	83 ec 0c             	sub    $0xc,%esp
80106aea:	68 48 79 10 80       	push   $0x80107948
80106aef:	e8 9c 98 ff ff       	call   80100390 <panic>
80106af4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106afa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106b00 <allocuvm>:
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	57                   	push   %edi
80106b04:	56                   	push   %esi
80106b05:	53                   	push   %ebx
80106b06:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106b09:	8b 7d 10             	mov    0x10(%ebp),%edi
80106b0c:	85 ff                	test   %edi,%edi
80106b0e:	0f 88 8e 00 00 00    	js     80106ba2 <allocuvm+0xa2>
  if(newsz < oldsz)
80106b14:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106b17:	0f 82 93 00 00 00    	jb     80106bb0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106b1d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b20:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106b26:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106b2c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106b2f:	0f 86 7e 00 00 00    	jbe    80106bb3 <allocuvm+0xb3>
80106b35:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106b38:	8b 7d 08             	mov    0x8(%ebp),%edi
80106b3b:	eb 42                	jmp    80106b7f <allocuvm+0x7f>
80106b3d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106b40:	83 ec 04             	sub    $0x4,%esp
80106b43:	68 00 10 00 00       	push   $0x1000
80106b48:	6a 00                	push   $0x0
80106b4a:	50                   	push   %eax
80106b4b:	e8 d0 d9 ff ff       	call   80104520 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106b50:	58                   	pop    %eax
80106b51:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106b57:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b5c:	5a                   	pop    %edx
80106b5d:	6a 06                	push   $0x6
80106b5f:	50                   	push   %eax
80106b60:	89 da                	mov    %ebx,%edx
80106b62:	89 f8                	mov    %edi,%eax
80106b64:	e8 67 fb ff ff       	call   801066d0 <mappages>
80106b69:	83 c4 10             	add    $0x10,%esp
80106b6c:	85 c0                	test   %eax,%eax
80106b6e:	78 50                	js     80106bc0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106b70:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b76:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106b79:	0f 86 81 00 00 00    	jbe    80106c00 <allocuvm+0x100>
    mem = kalloc();
80106b7f:	e8 0c ba ff ff       	call   80102590 <kalloc>
    if(mem == 0){
80106b84:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106b86:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106b88:	75 b6                	jne    80106b40 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106b8a:	83 ec 0c             	sub    $0xc,%esp
80106b8d:	68 c5 78 10 80       	push   $0x801078c5
80106b92:	e8 89 9b ff ff       	call   80100720 <cprintf>
  if(newsz >= oldsz)
80106b97:	83 c4 10             	add    $0x10,%esp
80106b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b9d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ba0:	77 6e                	ja     80106c10 <allocuvm+0x110>
}
80106ba2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106ba5:	31 ff                	xor    %edi,%edi
}
80106ba7:	89 f8                	mov    %edi,%eax
80106ba9:	5b                   	pop    %ebx
80106baa:	5e                   	pop    %esi
80106bab:	5f                   	pop    %edi
80106bac:	5d                   	pop    %ebp
80106bad:	c3                   	ret    
80106bae:	66 90                	xchg   %ax,%ax
    return oldsz;
80106bb0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106bb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bb6:	89 f8                	mov    %edi,%eax
80106bb8:	5b                   	pop    %ebx
80106bb9:	5e                   	pop    %esi
80106bba:	5f                   	pop    %edi
80106bbb:	5d                   	pop    %ebp
80106bbc:	c3                   	ret    
80106bbd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106bc0:	83 ec 0c             	sub    $0xc,%esp
80106bc3:	68 dd 78 10 80       	push   $0x801078dd
80106bc8:	e8 53 9b ff ff       	call   80100720 <cprintf>
  if(newsz >= oldsz)
80106bcd:	83 c4 10             	add    $0x10,%esp
80106bd0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bd3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106bd6:	76 0d                	jbe    80106be5 <allocuvm+0xe5>
80106bd8:	89 c1                	mov    %eax,%ecx
80106bda:	8b 55 10             	mov    0x10(%ebp),%edx
80106bdd:	8b 45 08             	mov    0x8(%ebp),%eax
80106be0:	e8 7b fb ff ff       	call   80106760 <deallocuvm.part.0>
      kfree(mem);
80106be5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106be8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106bea:	56                   	push   %esi
80106beb:	e8 f0 b7 ff ff       	call   801023e0 <kfree>
      return 0;
80106bf0:	83 c4 10             	add    $0x10,%esp
}
80106bf3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bf6:	89 f8                	mov    %edi,%eax
80106bf8:	5b                   	pop    %ebx
80106bf9:	5e                   	pop    %esi
80106bfa:	5f                   	pop    %edi
80106bfb:	5d                   	pop    %ebp
80106bfc:	c3                   	ret    
80106bfd:	8d 76 00             	lea    0x0(%esi),%esi
80106c00:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106c03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c06:	5b                   	pop    %ebx
80106c07:	89 f8                	mov    %edi,%eax
80106c09:	5e                   	pop    %esi
80106c0a:	5f                   	pop    %edi
80106c0b:	5d                   	pop    %ebp
80106c0c:	c3                   	ret    
80106c0d:	8d 76 00             	lea    0x0(%esi),%esi
80106c10:	89 c1                	mov    %eax,%ecx
80106c12:	8b 55 10             	mov    0x10(%ebp),%edx
80106c15:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106c18:	31 ff                	xor    %edi,%edi
80106c1a:	e8 41 fb ff ff       	call   80106760 <deallocuvm.part.0>
80106c1f:	eb 92                	jmp    80106bb3 <allocuvm+0xb3>
80106c21:	eb 0d                	jmp    80106c30 <deallocuvm>
80106c23:	90                   	nop
80106c24:	90                   	nop
80106c25:	90                   	nop
80106c26:	90                   	nop
80106c27:	90                   	nop
80106c28:	90                   	nop
80106c29:	90                   	nop
80106c2a:	90                   	nop
80106c2b:	90                   	nop
80106c2c:	90                   	nop
80106c2d:	90                   	nop
80106c2e:	90                   	nop
80106c2f:	90                   	nop

80106c30 <deallocuvm>:
{
80106c30:	55                   	push   %ebp
80106c31:	89 e5                	mov    %esp,%ebp
80106c33:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c36:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106c39:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106c3c:	39 d1                	cmp    %edx,%ecx
80106c3e:	73 10                	jae    80106c50 <deallocuvm+0x20>
}
80106c40:	5d                   	pop    %ebp
80106c41:	e9 1a fb ff ff       	jmp    80106760 <deallocuvm.part.0>
80106c46:	8d 76 00             	lea    0x0(%esi),%esi
80106c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106c50:	89 d0                	mov    %edx,%eax
80106c52:	5d                   	pop    %ebp
80106c53:	c3                   	ret    
80106c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c60 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 0c             	sub    $0xc,%esp
80106c69:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106c6c:	85 f6                	test   %esi,%esi
80106c6e:	74 59                	je     80106cc9 <freevm+0x69>
80106c70:	31 c9                	xor    %ecx,%ecx
80106c72:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106c77:	89 f0                	mov    %esi,%eax
80106c79:	e8 e2 fa ff ff       	call   80106760 <deallocuvm.part.0>
80106c7e:	89 f3                	mov    %esi,%ebx
80106c80:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106c86:	eb 0f                	jmp    80106c97 <freevm+0x37>
80106c88:	90                   	nop
80106c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c90:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106c93:	39 fb                	cmp    %edi,%ebx
80106c95:	74 23                	je     80106cba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106c97:	8b 03                	mov    (%ebx),%eax
80106c99:	a8 01                	test   $0x1,%al
80106c9b:	74 f3                	je     80106c90 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106c9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106ca2:	83 ec 0c             	sub    $0xc,%esp
80106ca5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ca8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106cad:	50                   	push   %eax
80106cae:	e8 2d b7 ff ff       	call   801023e0 <kfree>
80106cb3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106cb6:	39 fb                	cmp    %edi,%ebx
80106cb8:	75 dd                	jne    80106c97 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106cba:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106cbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cc0:	5b                   	pop    %ebx
80106cc1:	5e                   	pop    %esi
80106cc2:	5f                   	pop    %edi
80106cc3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106cc4:	e9 17 b7 ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80106cc9:	83 ec 0c             	sub    $0xc,%esp
80106ccc:	68 f9 78 10 80       	push   $0x801078f9
80106cd1:	e8 ba 96 ff ff       	call   80100390 <panic>
80106cd6:	8d 76 00             	lea    0x0(%esi),%esi
80106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ce0 <setupkvm>:
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	56                   	push   %esi
80106ce4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106ce5:	e8 a6 b8 ff ff       	call   80102590 <kalloc>
80106cea:	85 c0                	test   %eax,%eax
80106cec:	89 c6                	mov    %eax,%esi
80106cee:	74 42                	je     80106d32 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106cf0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106cf3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106cf8:	68 00 10 00 00       	push   $0x1000
80106cfd:	6a 00                	push   $0x0
80106cff:	50                   	push   %eax
80106d00:	e8 1b d8 ff ff       	call   80104520 <memset>
80106d05:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106d08:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106d0b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106d0e:	83 ec 08             	sub    $0x8,%esp
80106d11:	8b 13                	mov    (%ebx),%edx
80106d13:	ff 73 0c             	pushl  0xc(%ebx)
80106d16:	50                   	push   %eax
80106d17:	29 c1                	sub    %eax,%ecx
80106d19:	89 f0                	mov    %esi,%eax
80106d1b:	e8 b0 f9 ff ff       	call   801066d0 <mappages>
80106d20:	83 c4 10             	add    $0x10,%esp
80106d23:	85 c0                	test   %eax,%eax
80106d25:	78 19                	js     80106d40 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106d27:	83 c3 10             	add    $0x10,%ebx
80106d2a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106d30:	75 d6                	jne    80106d08 <setupkvm+0x28>
}
80106d32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106d35:	89 f0                	mov    %esi,%eax
80106d37:	5b                   	pop    %ebx
80106d38:	5e                   	pop    %esi
80106d39:	5d                   	pop    %ebp
80106d3a:	c3                   	ret    
80106d3b:	90                   	nop
80106d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106d40:	83 ec 0c             	sub    $0xc,%esp
80106d43:	56                   	push   %esi
      return 0;
80106d44:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106d46:	e8 15 ff ff ff       	call   80106c60 <freevm>
      return 0;
80106d4b:	83 c4 10             	add    $0x10,%esp
}
80106d4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106d51:	89 f0                	mov    %esi,%eax
80106d53:	5b                   	pop    %ebx
80106d54:	5e                   	pop    %esi
80106d55:	5d                   	pop    %ebp
80106d56:	c3                   	ret    
80106d57:	89 f6                	mov    %esi,%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d60 <kvmalloc>:
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106d66:	e8 75 ff ff ff       	call   80106ce0 <setupkvm>
80106d6b:	a3 a4 54 11 80       	mov    %eax,0x801154a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d70:	05 00 00 00 80       	add    $0x80000000,%eax
80106d75:	0f 22 d8             	mov    %eax,%cr3
}
80106d78:	c9                   	leave  
80106d79:	c3                   	ret    
80106d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d80 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d80:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d81:	31 c9                	xor    %ecx,%ecx
{
80106d83:	89 e5                	mov    %esp,%ebp
80106d85:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106d88:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d8b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d8e:	e8 bd f8 ff ff       	call   80106650 <walkpgdir>
  if(pte == 0)
80106d93:	85 c0                	test   %eax,%eax
80106d95:	74 05                	je     80106d9c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106d97:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106d9a:	c9                   	leave  
80106d9b:	c3                   	ret    
    panic("clearpteu");
80106d9c:	83 ec 0c             	sub    $0xc,%esp
80106d9f:	68 0a 79 10 80       	push   $0x8010790a
80106da4:	e8 e7 95 ff ff       	call   80100390 <panic>
80106da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106db0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106db0:	55                   	push   %ebp
80106db1:	89 e5                	mov    %esp,%ebp
80106db3:	57                   	push   %edi
80106db4:	56                   	push   %esi
80106db5:	53                   	push   %ebx
80106db6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106db9:	e8 22 ff ff ff       	call   80106ce0 <setupkvm>
80106dbe:	85 c0                	test   %eax,%eax
80106dc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106dc3:	0f 84 9f 00 00 00    	je     80106e68 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106dc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106dcc:	85 c9                	test   %ecx,%ecx
80106dce:	0f 84 94 00 00 00    	je     80106e68 <copyuvm+0xb8>
80106dd4:	31 ff                	xor    %edi,%edi
80106dd6:	eb 4a                	jmp    80106e22 <copyuvm+0x72>
80106dd8:	90                   	nop
80106dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106de0:	83 ec 04             	sub    $0x4,%esp
80106de3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106de9:	68 00 10 00 00       	push   $0x1000
80106dee:	53                   	push   %ebx
80106def:	50                   	push   %eax
80106df0:	e8 db d7 ff ff       	call   801045d0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106df5:	58                   	pop    %eax
80106df6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106dfc:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e01:	5a                   	pop    %edx
80106e02:	ff 75 e4             	pushl  -0x1c(%ebp)
80106e05:	50                   	push   %eax
80106e06:	89 fa                	mov    %edi,%edx
80106e08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e0b:	e8 c0 f8 ff ff       	call   801066d0 <mappages>
80106e10:	83 c4 10             	add    $0x10,%esp
80106e13:	85 c0                	test   %eax,%eax
80106e15:	78 61                	js     80106e78 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106e17:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106e1d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106e20:	76 46                	jbe    80106e68 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106e22:	8b 45 08             	mov    0x8(%ebp),%eax
80106e25:	31 c9                	xor    %ecx,%ecx
80106e27:	89 fa                	mov    %edi,%edx
80106e29:	e8 22 f8 ff ff       	call   80106650 <walkpgdir>
80106e2e:	85 c0                	test   %eax,%eax
80106e30:	74 61                	je     80106e93 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106e32:	8b 00                	mov    (%eax),%eax
80106e34:	a8 01                	test   $0x1,%al
80106e36:	74 4e                	je     80106e86 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106e38:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106e3a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106e3f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106e45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106e48:	e8 43 b7 ff ff       	call   80102590 <kalloc>
80106e4d:	85 c0                	test   %eax,%eax
80106e4f:	89 c6                	mov    %eax,%esi
80106e51:	75 8d                	jne    80106de0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106e53:	83 ec 0c             	sub    $0xc,%esp
80106e56:	ff 75 e0             	pushl  -0x20(%ebp)
80106e59:	e8 02 fe ff ff       	call   80106c60 <freevm>
  return 0;
80106e5e:	83 c4 10             	add    $0x10,%esp
80106e61:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106e68:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e6e:	5b                   	pop    %ebx
80106e6f:	5e                   	pop    %esi
80106e70:	5f                   	pop    %edi
80106e71:	5d                   	pop    %ebp
80106e72:	c3                   	ret    
80106e73:	90                   	nop
80106e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106e78:	83 ec 0c             	sub    $0xc,%esp
80106e7b:	56                   	push   %esi
80106e7c:	e8 5f b5 ff ff       	call   801023e0 <kfree>
      goto bad;
80106e81:	83 c4 10             	add    $0x10,%esp
80106e84:	eb cd                	jmp    80106e53 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106e86:	83 ec 0c             	sub    $0xc,%esp
80106e89:	68 2e 79 10 80       	push   $0x8010792e
80106e8e:	e8 fd 94 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80106e93:	83 ec 0c             	sub    $0xc,%esp
80106e96:	68 14 79 10 80       	push   $0x80107914
80106e9b:	e8 f0 94 ff ff       	call   80100390 <panic>

80106ea0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106ea0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106ea1:	31 c9                	xor    %ecx,%ecx
{
80106ea3:	89 e5                	mov    %esp,%ebp
80106ea5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106ea8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106eab:	8b 45 08             	mov    0x8(%ebp),%eax
80106eae:	e8 9d f7 ff ff       	call   80106650 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106eb3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106eb5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106eb6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106eb8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106ebd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106ec0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ec5:	83 fa 05             	cmp    $0x5,%edx
80106ec8:	ba 00 00 00 00       	mov    $0x0,%edx
80106ecd:	0f 45 c2             	cmovne %edx,%eax
}
80106ed0:	c3                   	ret    
80106ed1:	eb 0d                	jmp    80106ee0 <copyout>
80106ed3:	90                   	nop
80106ed4:	90                   	nop
80106ed5:	90                   	nop
80106ed6:	90                   	nop
80106ed7:	90                   	nop
80106ed8:	90                   	nop
80106ed9:	90                   	nop
80106eda:	90                   	nop
80106edb:	90                   	nop
80106edc:	90                   	nop
80106edd:	90                   	nop
80106ede:	90                   	nop
80106edf:	90                   	nop

80106ee0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	57                   	push   %edi
80106ee4:	56                   	push   %esi
80106ee5:	53                   	push   %ebx
80106ee6:	83 ec 1c             	sub    $0x1c,%esp
80106ee9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106eec:	8b 55 0c             	mov    0xc(%ebp),%edx
80106eef:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ef2:	85 db                	test   %ebx,%ebx
80106ef4:	75 40                	jne    80106f36 <copyout+0x56>
80106ef6:	eb 70                	jmp    80106f68 <copyout+0x88>
80106ef8:	90                   	nop
80106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106f00:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106f03:	89 f1                	mov    %esi,%ecx
80106f05:	29 d1                	sub    %edx,%ecx
80106f07:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106f0d:	39 d9                	cmp    %ebx,%ecx
80106f0f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106f12:	29 f2                	sub    %esi,%edx
80106f14:	83 ec 04             	sub    $0x4,%esp
80106f17:	01 d0                	add    %edx,%eax
80106f19:	51                   	push   %ecx
80106f1a:	57                   	push   %edi
80106f1b:	50                   	push   %eax
80106f1c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106f1f:	e8 ac d6 ff ff       	call   801045d0 <memmove>
    len -= n;
    buf += n;
80106f24:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80106f27:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80106f2a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80106f30:	01 cf                	add    %ecx,%edi
  while(len > 0){
80106f32:	29 cb                	sub    %ecx,%ebx
80106f34:	74 32                	je     80106f68 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80106f36:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f38:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80106f3b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106f3e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f44:	56                   	push   %esi
80106f45:	ff 75 08             	pushl  0x8(%ebp)
80106f48:	e8 53 ff ff ff       	call   80106ea0 <uva2ka>
    if(pa0 == 0)
80106f4d:	83 c4 10             	add    $0x10,%esp
80106f50:	85 c0                	test   %eax,%eax
80106f52:	75 ac                	jne    80106f00 <copyout+0x20>
  }
  return 0;
}
80106f54:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f5c:	5b                   	pop    %ebx
80106f5d:	5e                   	pop    %esi
80106f5e:	5f                   	pop    %edi
80106f5f:	5d                   	pop    %ebp
80106f60:	c3                   	ret    
80106f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f68:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f6b:	31 c0                	xor    %eax,%eax
}
80106f6d:	5b                   	pop    %ebx
80106f6e:	5e                   	pop    %esi
80106f6f:	5f                   	pop    %edi
80106f70:	5d                   	pop    %ebp
80106f71:	c3                   	ret    
