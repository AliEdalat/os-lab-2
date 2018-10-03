
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
8010004c:	68 a0 6f 10 80       	push   $0x80106fa0
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
80100092:	68 a7 6f 10 80       	push   $0x80106fa7
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
801000e4:	e8 47 43 00 00       	call   80104430 <acquire>
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
80100162:	e8 79 43 00 00       	call   801044e0 <release>
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
8010017e:	e8 5d 20 00 00       	call   801021e0 <iderw>
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
80100193:	68 ae 6f 10 80       	push   $0x80106fae
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
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
801001c4:	e9 17 20 00 00       	jmp    801021e0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 6f 10 80       	push   $0x80106fbf
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
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
8010020b:	e8 20 42 00 00       	call   80104430 <acquire>
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
8010025c:	e9 7f 42 00 00       	jmp    801044e0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 6f 10 80       	push   $0x80106fc6
80100269:	e8 02 01 00 00       	call   80100370 <panic>
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
80100280:	e8 bb 15 00 00       	call   80101840 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 9f 41 00 00       	call   80104430 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002a6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 a0 ff 10 80       	push   $0x8010ffa0
801002bd:	e8 6e 3b 00 00       	call   80103e30 <sleep>
    while(input.r == input.w){
801002c2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 a9 35 00 00       	call   80103880 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 a5 10 80       	push   $0x8010a520
801002e6:	e8 f5 41 00 00       	call   801044e0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 6d 14 00 00       	call   80101760 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 95 41 00 00       	call   801044e0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 0d 14 00 00       	call   80101760 <ilock>
  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        input.r--;
80100360:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  cons.locking = 0;
80100379:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100380:	00 00 00 
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 62 24 00 00       	call   801027f0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 cd 6f 10 80       	push   $0x80106fcd
80100397:	e8 a4 03 00 00       	call   80100740 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 9b 03 00 00       	call   80100740 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 17 79 10 80 	movl   $0x80107917,(%esp)
801003ac:	e8 8f 03 00 00       	call   80100740 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 33 3f 00 00       	call   801042f0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 e1 6f 10 80       	push   $0x80106fe1
801003cd:	e8 6e 03 00 00       	call   80100740 <cprintf>
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003d9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c6                	mov    %eax,%esi
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 f0 00 00 00    	je     80100506 <consputc+0x116>
  } else if(c != UP && c != DOWN && c != LEFT && c != RIGHT){
80100416:	8d 80 1e ff ff ff    	lea    -0xe2(%eax),%eax
8010041c:	83 f8 03             	cmp    $0x3,%eax
8010041f:	0f 87 1b 02 00 00    	ja     80100640 <consputc+0x250>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100425:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010042a:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042f:	89 fa                	mov    %edi,%edx
80100431:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100432:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100437:	89 ca                	mov    %ecx,%edx
80100439:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
8010043a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043d:	89 fa                	mov    %edi,%edx
8010043f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100444:	c1 e3 08             	shl    $0x8,%ebx
80100447:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010044a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044b:	89 ca                	mov    %ecx,%edx
8010044d:	ec                   	in     (%dx),%al
8010044e:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
80100451:	0b 5d e4             	or     -0x1c(%ebp),%ebx
  if(c == '\n')
80100454:	83 fe 0a             	cmp    $0xa,%esi
80100457:	0f 84 c7 01 00 00    	je     80100624 <consputc+0x234>
  else if(c == BACKSPACE) {
8010045d:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100463:	0f 84 5a 01 00 00    	je     801005c3 <consputc+0x1d3>
  } else if(c == LEFT){
80100469:	81 fe e4 00 00 00    	cmp    $0xe4,%esi
8010046f:	0f 84 1f 01 00 00    	je     80100594 <consputc+0x1a4>
  } else if(c == RIGHT){
80100475:	81 fe e5 00 00 00    	cmp    $0xe5,%esi
8010047b:	0f 84 af 00 00 00    	je     80100530 <consputc+0x140>
  } else if(c == DOWN){
80100481:	8d 86 1e ff ff ff    	lea    -0xe2(%esi),%eax
80100487:	83 f8 01             	cmp    $0x1,%eax
8010048a:	76 3b                	jbe    801004c7 <consputc+0xd7>
    memmove(crt + pos + 1, crt + pos, 128 - pos % 128);
8010048c:	89 d9                	mov    %ebx,%ecx
8010048e:	8d 3c 1b             	lea    (%ebx,%ebx,1),%edi
80100491:	b8 80 00 00 00       	mov    $0x80,%eax
80100496:	83 e1 7f             	and    $0x7f,%ecx
80100499:	83 ec 04             	sub    $0x4,%esp
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
8010049c:	83 c3 01             	add    $0x1,%ebx
    memmove(crt + pos + 1, crt + pos, 128 - pos % 128);
8010049f:	29 c8                	sub    %ecx,%eax
801004a1:	8d 97 00 80 0b 80    	lea    -0x7ff48000(%edi),%edx
801004a7:	50                   	push   %eax
801004a8:	8d 87 02 80 0b 80    	lea    -0x7ff47ffe(%edi),%eax
801004ae:	52                   	push   %edx
801004af:	50                   	push   %eax
801004b0:	e8 2b 41 00 00       	call   801045e0 <memmove>
    crt[pos++] = (c & 0xff) | 0x0700;  // black on white
801004b5:	89 f0                	mov    %esi,%eax
801004b7:	83 c4 10             	add    $0x10,%esp
801004ba:	0f b6 c0             	movzbl %al,%eax
801004bd:	80 cc 07             	or     $0x7,%ah
801004c0:	66 89 87 00 80 0b 80 	mov    %ax,-0x7ff48000(%edi)
  if(pos < 0 || pos > 25*80)
801004c7:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004cd:	77 7a                	ja     80100549 <consputc+0x159>
  if((pos/80) >= 24){  // Scroll up.
801004cf:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004d5:	7f 7f                	jg     80100556 <consputc+0x166>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004d7:	be d4 03 00 00       	mov    $0x3d4,%esi
801004dc:	b8 0e 00 00 00       	mov    $0xe,%eax
801004e1:	89 f2                	mov    %esi,%edx
801004e3:	ee                   	out    %al,(%dx)
801004e4:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004e9:	89 d8                	mov    %ebx,%eax
801004eb:	c1 f8 08             	sar    $0x8,%eax
801004ee:	89 ca                	mov    %ecx,%edx
801004f0:	ee                   	out    %al,(%dx)
801004f1:	b8 0f 00 00 00       	mov    $0xf,%eax
801004f6:	89 f2                	mov    %esi,%edx
801004f8:	ee                   	out    %al,(%dx)
801004f9:	89 d8                	mov    %ebx,%eax
801004fb:	89 ca                	mov    %ecx,%edx
801004fd:	ee                   	out    %al,(%dx)
}
801004fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100501:	5b                   	pop    %ebx
80100502:	5e                   	pop    %esi
80100503:	5f                   	pop    %edi
80100504:	5d                   	pop    %ebp
80100505:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100506:	83 ec 0c             	sub    $0xc,%esp
80100509:	6a 08                	push   $0x8
8010050b:	e8 70 56 00 00       	call   80105b80 <uartputc>
80100510:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100517:	e8 64 56 00 00       	call   80105b80 <uartputc>
8010051c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100523:	e8 58 56 00 00       	call   80105b80 <uartputc>
80100528:	83 c4 10             	add    $0x10,%esp
8010052b:	e9 f5 fe ff ff       	jmp    80100425 <consputc+0x35>
    if (crt[pos] != (' ' | 0x0700)) ++pos;
80100530:	31 c0                	xor    %eax,%eax
80100532:	66 81 bc 1b 00 80 0b 	cmpw   $0x720,-0x7ff48000(%ebx,%ebx,1)
80100539:	80 20 07 
8010053c:	0f 95 c0             	setne  %al
8010053f:	01 c3                	add    %eax,%ebx
  if(pos < 0 || pos > 25*80)
80100541:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100547:	76 86                	jbe    801004cf <consputc+0xdf>
    panic("pos under/overflow");
80100549:	83 ec 0c             	sub    $0xc,%esp
8010054c:	68 e5 6f 10 80       	push   $0x80106fe5
80100551:	e8 1a fe ff ff       	call   80100370 <panic>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100556:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100559:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010055c:	68 60 0e 00 00       	push   $0xe60
80100561:	68 a0 80 0b 80       	push   $0x800b80a0
80100566:	68 00 80 0b 80       	push   $0x800b8000
8010056b:	e8 70 40 00 00       	call   801045e0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100570:	b8 80 07 00 00       	mov    $0x780,%eax
80100575:	83 c4 0c             	add    $0xc,%esp
80100578:	29 d8                	sub    %ebx,%eax
8010057a:	01 c0                	add    %eax,%eax
8010057c:	50                   	push   %eax
8010057d:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100584:	6a 00                	push   $0x0
80100586:	50                   	push   %eax
80100587:	e8 a4 3f 00 00       	call   80104530 <memset>
8010058c:	83 c4 10             	add    $0x10,%esp
8010058f:	e9 43 ff ff ff       	jmp    801004d7 <consputc+0xe7>
    if (pos % BUFF_SIZE > 2) --pos;
80100594:	89 d8                	mov    %ebx,%eax
80100596:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010059b:	89 df                	mov    %ebx,%edi
8010059d:	f7 ea                	imul   %edx
8010059f:	89 d0                	mov    %edx,%eax
801005a1:	89 da                	mov    %ebx,%edx
801005a3:	c1 f8 05             	sar    $0x5,%eax
801005a6:	c1 fa 1f             	sar    $0x1f,%edx
801005a9:	29 d0                	sub    %edx,%eax
801005ab:	8d 04 80             	lea    (%eax,%eax,4),%eax
801005ae:	c1 e0 04             	shl    $0x4,%eax
801005b1:	29 c7                	sub    %eax,%edi
801005b3:	83 ff 03             	cmp    $0x3,%edi
801005b6:	0f 9d c0             	setge  %al
801005b9:	0f b6 c0             	movzbl %al,%eax
801005bc:	29 c3                	sub    %eax,%ebx
801005be:	e9 04 ff ff ff       	jmp    801004c7 <consputc+0xd7>
      if (pos % BUFF_SIZE > 2){
801005c3:	89 d8                	mov    %ebx,%eax
801005c5:	ba 67 66 66 66       	mov    $0x66666667,%edx
801005ca:	89 df                	mov    %ebx,%edi
801005cc:	f7 ea                	imul   %edx
801005ce:	89 d0                	mov    %edx,%eax
801005d0:	89 da                	mov    %ebx,%edx
801005d2:	c1 f8 05             	sar    $0x5,%eax
801005d5:	c1 fa 1f             	sar    $0x1f,%edx
801005d8:	29 d0                	sub    %edx,%eax
801005da:	8d 04 80             	lea    (%eax,%eax,4),%eax
801005dd:	c1 e0 04             	shl    $0x4,%eax
801005e0:	29 c7                	sub    %eax,%edi
801005e2:	83 ff 02             	cmp    $0x2,%edi
801005e5:	0f 8e dc fe ff ff    	jle    801004c7 <consputc+0xd7>
 	--pos;
801005eb:	83 eb 01             	sub    $0x1,%ebx
	memmove(crt + pos, crt + pos + 1, 128 - pos % 128);
801005ee:	83 ec 04             	sub    $0x4,%esp
801005f1:	89 d8                	mov    %ebx,%eax
801005f3:	8d 54 1b 02          	lea    0x2(%ebx,%ebx,1),%edx
801005f7:	c1 f8 1f             	sar    $0x1f,%eax
801005fa:	c1 e8 19             	shr    $0x19,%eax
801005fd:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
80100600:	83 e1 7f             	and    $0x7f,%ecx
80100603:	29 c8                	sub    %ecx,%eax
80100605:	83 e8 80             	sub    $0xffffff80,%eax
80100608:	50                   	push   %eax
80100609:	8d 82 00 80 0b 80    	lea    -0x7ff48000(%edx),%eax
8010060f:	81 ea 02 80 f4 7f    	sub    $0x7ff48002,%edx
80100615:	50                   	push   %eax
80100616:	52                   	push   %edx
80100617:	e8 c4 3f 00 00       	call   801045e0 <memmove>
8010061c:	83 c4 10             	add    $0x10,%esp
8010061f:	e9 a3 fe ff ff       	jmp    801004c7 <consputc+0xd7>
    pos += BUFF_SIZE - pos % BUFF_SIZE;
80100624:	89 d8                	mov    %ebx,%eax
80100626:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010062b:	f7 ea                	imul   %edx
8010062d:	89 d0                	mov    %edx,%eax
8010062f:	c1 e8 05             	shr    $0x5,%eax
80100632:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100635:	c1 e0 04             	shl    $0x4,%eax
80100638:	8d 58 50             	lea    0x50(%eax),%ebx
8010063b:	e9 87 fe ff ff       	jmp    801004c7 <consputc+0xd7>
    uartputc(c);
80100640:	83 ec 0c             	sub    $0xc,%esp
80100643:	56                   	push   %esi
80100644:	e8 37 55 00 00       	call   80105b80 <uartputc>
80100649:	83 c4 10             	add    $0x10,%esp
8010064c:	e9 d4 fd ff ff       	jmp    80100425 <consputc+0x35>
80100651:	eb 0d                	jmp    80100660 <printint>
80100653:	90                   	nop
80100654:	90                   	nop
80100655:	90                   	nop
80100656:	90                   	nop
80100657:	90                   	nop
80100658:	90                   	nop
80100659:	90                   	nop
8010065a:	90                   	nop
8010065b:	90                   	nop
8010065c:	90                   	nop
8010065d:	90                   	nop
8010065e:	90                   	nop
8010065f:	90                   	nop

80100660 <printint>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	89 d6                	mov    %edx,%esi
80100668:	83 ec 1c             	sub    $0x1c,%esp
  if(sign && (sign = xx < 0))
8010066b:	85 c9                	test   %ecx,%ecx
8010066d:	74 04                	je     80100673 <printint+0x13>
8010066f:	85 c0                	test   %eax,%eax
80100671:	78 57                	js     801006ca <printint+0x6a>
    x = xx;
80100673:	31 ff                	xor    %edi,%edi
  i = 0;
80100675:	31 c9                	xor    %ecx,%ecx
80100677:	eb 09                	jmp    80100682 <printint+0x22>
80100679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100680:	89 d9                	mov    %ebx,%ecx
80100682:	31 d2                	xor    %edx,%edx
80100684:	8d 59 01             	lea    0x1(%ecx),%ebx
80100687:	f7 f6                	div    %esi
80100689:	0f b6 92 10 70 10 80 	movzbl -0x7fef8ff0(%edx),%edx
  }while((x /= base) != 0);
80100690:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
80100692:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100696:	75 e8                	jne    80100680 <printint+0x20>
  if(sign)
80100698:	85 ff                	test   %edi,%edi
8010069a:	74 08                	je     801006a4 <printint+0x44>
    buf[i++] = '-';
8010069c:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
801006a1:	8d 59 02             	lea    0x2(%ecx),%ebx
  while(--i >= 0)
801006a4:	83 eb 01             	sub    $0x1,%ebx
801006a7:	89 f6                	mov    %esi,%esi
801006a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
801006b0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  while(--i >= 0)
801006b5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801006b8:	e8 33 fd ff ff       	call   801003f0 <consputc>
  while(--i >= 0)
801006bd:	83 fb ff             	cmp    $0xffffffff,%ebx
801006c0:	75 ee                	jne    801006b0 <printint+0x50>
}
801006c2:	83 c4 1c             	add    $0x1c,%esp
801006c5:	5b                   	pop    %ebx
801006c6:	5e                   	pop    %esi
801006c7:	5f                   	pop    %edi
801006c8:	5d                   	pop    %ebp
801006c9:	c3                   	ret    
    x = -xx;
801006ca:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
801006cc:	bf 01 00 00 00       	mov    $0x1,%edi
    x = -xx;
801006d1:	eb a2                	jmp    80100675 <printint+0x15>
801006d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801006d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801006e0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006e0:	55                   	push   %ebp
801006e1:	89 e5                	mov    %esp,%ebp
801006e3:	57                   	push   %edi
801006e4:	56                   	push   %esi
801006e5:	53                   	push   %ebx
801006e6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801006e9:	ff 75 08             	pushl  0x8(%ebp)
{
801006ec:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801006ef:	e8 4c 11 00 00       	call   80101840 <iunlock>
  acquire(&cons.lock);
801006f4:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006fb:	e8 30 3d 00 00       	call   80104430 <acquire>
80100700:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100703:	83 c4 10             	add    $0x10,%esp
80100706:	85 f6                	test   %esi,%esi
80100708:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010070b:	7e 12                	jle    8010071f <consolewrite+0x3f>
8010070d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100710:	0f b6 07             	movzbl (%edi),%eax
80100713:	83 c7 01             	add    $0x1,%edi
80100716:	e8 d5 fc ff ff       	call   801003f0 <consputc>
  for(i = 0; i < n; i++)
8010071b:	39 fb                	cmp    %edi,%ebx
8010071d:	75 f1                	jne    80100710 <consolewrite+0x30>
  release(&cons.lock);
8010071f:	83 ec 0c             	sub    $0xc,%esp
80100722:	68 20 a5 10 80       	push   $0x8010a520
80100727:	e8 b4 3d 00 00       	call   801044e0 <release>
  ilock(ip);
8010072c:	58                   	pop    %eax
8010072d:	ff 75 08             	pushl  0x8(%ebp)
80100730:	e8 2b 10 00 00       	call   80101760 <ilock>

  return n;
}
80100735:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100738:	89 f0                	mov    %esi,%eax
8010073a:	5b                   	pop    %ebx
8010073b:	5e                   	pop    %esi
8010073c:	5f                   	pop    %edi
8010073d:	5d                   	pop    %ebp
8010073e:	c3                   	ret    
8010073f:	90                   	nop

80100740 <cprintf>:
{
80100740:	55                   	push   %ebp
80100741:	89 e5                	mov    %esp,%ebp
80100743:	57                   	push   %edi
80100744:	56                   	push   %esi
80100745:	53                   	push   %ebx
80100746:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100749:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010074e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100750:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100753:	0f 85 27 01 00 00    	jne    80100880 <cprintf+0x140>
  if (fmt == 0)
80100759:	8b 75 08             	mov    0x8(%ebp),%esi
8010075c:	85 f6                	test   %esi,%esi
8010075e:	0f 84 40 01 00 00    	je     801008a4 <cprintf+0x164>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100764:	0f b6 06             	movzbl (%esi),%eax
80100767:	31 db                	xor    %ebx,%ebx
80100769:	8d 7d 0c             	lea    0xc(%ebp),%edi
8010076c:	85 c0                	test   %eax,%eax
8010076e:	75 51                	jne    801007c1 <cprintf+0x81>
80100770:	eb 64                	jmp    801007d6 <cprintf+0x96>
80100772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    c = fmt[++i] & 0xff;
80100778:	83 c3 01             	add    $0x1,%ebx
8010077b:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
8010077f:	85 d2                	test   %edx,%edx
80100781:	74 53                	je     801007d6 <cprintf+0x96>
    switch(c){
80100783:	83 fa 70             	cmp    $0x70,%edx
80100786:	74 7a                	je     80100802 <cprintf+0xc2>
80100788:	7f 6e                	jg     801007f8 <cprintf+0xb8>
8010078a:	83 fa 25             	cmp    $0x25,%edx
8010078d:	0f 84 ad 00 00 00    	je     80100840 <cprintf+0x100>
80100793:	83 fa 64             	cmp    $0x64,%edx
80100796:	0f 85 84 00 00 00    	jne    80100820 <cprintf+0xe0>
      printint(*argp++, 10, 1);
8010079c:	8d 47 04             	lea    0x4(%edi),%eax
8010079f:	b9 01 00 00 00       	mov    $0x1,%ecx
801007a4:	ba 0a 00 00 00       	mov    $0xa,%edx
801007a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007ac:	8b 07                	mov    (%edi),%eax
801007ae:	e8 ad fe ff ff       	call   80100660 <printint>
801007b3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b6:	83 c3 01             	add    $0x1,%ebx
801007b9:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	74 15                	je     801007d6 <cprintf+0x96>
    if(c != '%'){
801007c1:	83 f8 25             	cmp    $0x25,%eax
801007c4:	74 b2                	je     80100778 <cprintf+0x38>
      consputc('%');
801007c6:	e8 25 fc ff ff       	call   801003f0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	75 eb                	jne    801007c1 <cprintf+0x81>
  if(locking)
801007d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007d9:	85 c0                	test   %eax,%eax
801007db:	74 10                	je     801007ed <cprintf+0xad>
    release(&cons.lock);
801007dd:	83 ec 0c             	sub    $0xc,%esp
801007e0:	68 20 a5 10 80       	push   $0x8010a520
801007e5:	e8 f6 3c 00 00       	call   801044e0 <release>
801007ea:	83 c4 10             	add    $0x10,%esp
}
801007ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007f0:	5b                   	pop    %ebx
801007f1:	5e                   	pop    %esi
801007f2:	5f                   	pop    %edi
801007f3:	5d                   	pop    %ebp
801007f4:	c3                   	ret    
801007f5:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801007f8:	83 fa 73             	cmp    $0x73,%edx
801007fb:	74 53                	je     80100850 <cprintf+0x110>
801007fd:	83 fa 78             	cmp    $0x78,%edx
80100800:	75 1e                	jne    80100820 <cprintf+0xe0>
      printint(*argp++, 16, 0);
80100802:	8d 47 04             	lea    0x4(%edi),%eax
80100805:	31 c9                	xor    %ecx,%ecx
80100807:	ba 10 00 00 00       	mov    $0x10,%edx
8010080c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010080f:	8b 07                	mov    (%edi),%eax
80100811:	e8 4a fe ff ff       	call   80100660 <printint>
80100816:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      break;
80100819:	eb 9b                	jmp    801007b6 <cprintf+0x76>
8010081b:	90                   	nop
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100820:	b8 25 00 00 00       	mov    $0x25,%eax
80100825:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100828:	e8 c3 fb ff ff       	call   801003f0 <consputc>
      consputc(c);
8010082d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100830:	89 d0                	mov    %edx,%eax
80100832:	e8 b9 fb ff ff       	call   801003f0 <consputc>
      break;
80100837:	e9 7a ff ff ff       	jmp    801007b6 <cprintf+0x76>
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100840:	b8 25 00 00 00       	mov    $0x25,%eax
80100845:	e8 a6 fb ff ff       	call   801003f0 <consputc>
8010084a:	e9 7c ff ff ff       	jmp    801007cb <cprintf+0x8b>
8010084f:	90                   	nop
      if((s = (char*)*argp++) == 0)
80100850:	8d 47 04             	lea    0x4(%edi),%eax
80100853:	8b 3f                	mov    (%edi),%edi
80100855:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100858:	85 ff                	test   %edi,%edi
8010085a:	75 0c                	jne    80100868 <cprintf+0x128>
8010085c:	eb 3a                	jmp    80100898 <cprintf+0x158>
8010085e:	66 90                	xchg   %ax,%ax
      for(; *s; s++)
80100860:	83 c7 01             	add    $0x1,%edi
        consputc(*s);
80100863:	e8 88 fb ff ff       	call   801003f0 <consputc>
      for(; *s; s++)
80100868:	0f be 07             	movsbl (%edi),%eax
8010086b:	84 c0                	test   %al,%al
8010086d:	75 f1                	jne    80100860 <cprintf+0x120>
      if((s = (char*)*argp++) == 0)
8010086f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100872:	e9 3f ff ff ff       	jmp    801007b6 <cprintf+0x76>
80100877:	89 f6                	mov    %esi,%esi
80100879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 a3 3b 00 00       	call   80104430 <acquire>
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	e9 c4 fe ff ff       	jmp    80100759 <cprintf+0x19>
80100895:	8d 76 00             	lea    0x0(%esi),%esi
      for(; *s; s++)
80100898:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
8010089d:	bf f8 6f 10 80       	mov    $0x80106ff8,%edi
801008a2:	eb bc                	jmp    80100860 <cprintf+0x120>
    panic("null fmt");
801008a4:	83 ec 0c             	sub    $0xc,%esp
801008a7:	68 ff 6f 10 80       	push   $0x80106fff
801008ac:	e8 bf fa ff ff       	call   80100370 <panic>
801008b1:	eb 0d                	jmp    801008c0 <consoleintr>
801008b3:	90                   	nop
801008b4:	90                   	nop
801008b5:	90                   	nop
801008b6:	90                   	nop
801008b7:	90                   	nop
801008b8:	90                   	nop
801008b9:	90                   	nop
801008ba:	90                   	nop
801008bb:	90                   	nop
801008bc:	90                   	nop
801008bd:	90                   	nop
801008be:	90                   	nop
801008bf:	90                   	nop

801008c0 <consoleintr>:
{
801008c0:	55                   	push   %ebp
801008c1:	89 e5                	mov    %esp,%ebp
801008c3:	57                   	push   %edi
801008c4:	56                   	push   %esi
801008c5:	53                   	push   %ebx
  int c, doprocdump = 0;
801008c6:	31 f6                	xor    %esi,%esi
{
801008c8:	83 ec 18             	sub    $0x18,%esp
801008cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801008ce:	68 20 a5 10 80       	push   $0x8010a520
801008d3:	e8 58 3b 00 00       	call   80104430 <acquire>
  while((c = getc()) >= 0){
801008d8:	83 c4 10             	add    $0x10,%esp
801008db:	90                   	nop
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008e0:	ff d3                	call   *%ebx
801008e2:	85 c0                	test   %eax,%eax
801008e4:	89 c7                	mov    %eax,%edi
801008e6:	78 28                	js     80100910 <consoleintr+0x50>
    switch(c){
801008e8:	83 ff 15             	cmp    $0x15,%edi
801008eb:	74 63                	je     80100950 <consoleintr+0x90>
801008ed:	7f 41                	jg     80100930 <consoleintr+0x70>
801008ef:	83 ff 08             	cmp    $0x8,%edi
801008f2:	0f 84 28 01 00 00    	je     80100a20 <consoleintr+0x160>
801008f8:	83 ff 10             	cmp    $0x10,%edi
801008fb:	0f 85 9f 00 00 00    	jne    801009a0 <consoleintr+0xe0>
  while((c = getc()) >= 0){
80100901:	ff d3                	call   *%ebx
80100903:	85 c0                	test   %eax,%eax
      doprocdump = 1;
80100905:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
8010090a:	89 c7                	mov    %eax,%edi
8010090c:	79 da                	jns    801008e8 <consoleintr+0x28>
8010090e:	66 90                	xchg   %ax,%ax
  release(&cons.lock);
80100910:	83 ec 0c             	sub    $0xc,%esp
80100913:	68 20 a5 10 80       	push   $0x8010a520
80100918:	e8 c3 3b 00 00       	call   801044e0 <release>
  if(doprocdump) {
8010091d:	83 c4 10             	add    $0x10,%esp
80100920:	85 f6                	test   %esi,%esi
80100922:	0f 85 28 01 00 00    	jne    80100a50 <consoleintr+0x190>
}
80100928:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010092b:	5b                   	pop    %ebx
8010092c:	5e                   	pop    %esi
8010092d:	5f                   	pop    %edi
8010092e:	5d                   	pop    %ebp
8010092f:	c3                   	ret    
    switch(c){
80100930:	83 ff 7f             	cmp    $0x7f,%edi
80100933:	0f 84 e7 00 00 00    	je     80100a20 <consoleintr+0x160>
80100939:	7c 65                	jl     801009a0 <consoleintr+0xe0>
8010093b:	8d 87 1e ff ff ff    	lea    -0xe2(%edi),%eax
80100941:	83 f8 03             	cmp    $0x3,%eax
80100944:	77 5a                	ja     801009a0 <consoleintr+0xe0>
      consputc(c);
80100946:	89 f8                	mov    %edi,%eax
80100948:	e8 a3 fa ff ff       	call   801003f0 <consputc>
      break;
8010094d:	eb 91                	jmp    801008e0 <consoleintr+0x20>
8010094f:	90                   	nop
      while(input.e != input.w &&
80100950:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100955:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
8010095b:	75 23                	jne    80100980 <consoleintr+0xc0>
8010095d:	eb 81                	jmp    801008e0 <consoleintr+0x20>
8010095f:	90                   	nop
        input.e--;
80100960:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100965:	b8 00 01 00 00       	mov    $0x100,%eax
8010096a:	e8 81 fa ff ff       	call   801003f0 <consputc>
      while(input.e != input.w &&
8010096f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100974:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010097a:	0f 84 60 ff ff ff    	je     801008e0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100980:	83 e8 01             	sub    $0x1,%eax
80100983:	89 c2                	mov    %eax,%edx
80100985:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100988:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010098f:	75 cf                	jne    80100960 <consoleintr+0xa0>
80100991:	e9 4a ff ff ff       	jmp    801008e0 <consoleintr+0x20>
80100996:	8d 76 00             	lea    0x0(%esi),%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009a0:	85 ff                	test   %edi,%edi
801009a2:	0f 84 38 ff ff ff    	je     801008e0 <consoleintr+0x20>
801009a8:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009ad:	89 c2                	mov    %eax,%edx
801009af:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801009b5:	83 fa 7f             	cmp    $0x7f,%edx
801009b8:	0f 87 22 ff ff ff    	ja     801008e0 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
801009be:	8d 50 01             	lea    0x1(%eax),%edx
801009c1:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801009c4:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801009c7:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801009cd:	0f 84 89 00 00 00    	je     80100a5c <consoleintr+0x19c>
        input.buf[input.e++ % INPUT_BUF] = c;
801009d3:	89 f9                	mov    %edi,%ecx
801009d5:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801009db:	89 f8                	mov    %edi,%eax
801009dd:	e8 0e fa ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009e2:	83 ff 0a             	cmp    $0xa,%edi
801009e5:	0f 84 82 00 00 00    	je     80100a6d <consoleintr+0x1ad>
801009eb:	83 ff 04             	cmp    $0x4,%edi
801009ee:	74 7d                	je     80100a6d <consoleintr+0x1ad>
801009f0:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801009f5:	83 e8 80             	sub    $0xffffff80,%eax
801009f8:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801009fe:	0f 85 dc fe ff ff    	jne    801008e0 <consoleintr+0x20>
          wakeup(&input.r);
80100a04:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a07:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100a0c:	68 a0 ff 10 80       	push   $0x8010ffa0
80100a11:	e8 da 35 00 00       	call   80103ff0 <wakeup>
80100a16:	83 c4 10             	add    $0x10,%esp
80100a19:	e9 c2 fe ff ff       	jmp    801008e0 <consoleintr+0x20>
80100a1e:	66 90                	xchg   %ax,%ax
      if(input.e != input.w){
80100a20:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a25:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100a2b:	0f 84 af fe ff ff    	je     801008e0 <consoleintr+0x20>
        input.e--;
80100a31:	83 e8 01             	sub    $0x1,%eax
80100a34:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100a39:	b8 00 01 00 00       	mov    $0x100,%eax
80100a3e:	e8 ad f9 ff ff       	call   801003f0 <consputc>
80100a43:	e9 98 fe ff ff       	jmp    801008e0 <consoleintr+0x20>
80100a48:	90                   	nop
80100a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80100a50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a53:	5b                   	pop    %ebx
80100a54:	5e                   	pop    %esi
80100a55:	5f                   	pop    %edi
80100a56:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a57:	e9 84 36 00 00       	jmp    801040e0 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a5c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100a63:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a68:	e8 83 f9 ff ff       	call   801003f0 <consputc>
80100a6d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a72:	eb 90                	jmp    80100a04 <consoleintr+0x144>
80100a74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100a7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100a80 <consoleinit>:

void
consoleinit(void)
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a86:	68 08 70 10 80       	push   $0x80107008
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
80100a9b:	c7 05 6c 09 11 80 e0 	movl   $0x801006e0,0x8011096c
80100aa2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100aa5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
80100aac:	02 10 80 
  cons.locking = 1;
80100aaf:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100ab6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100ab9:	e8 d2 18 00 00       	call   80102390 <ioapicenable>
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
80100adc:	e8 9f 2d 00 00       	call   80103880 <myproc>
80100ae1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100ae7:	e8 74 21 00 00       	call   80102c60 <begin_op>

  if((ip = namei(path)) == 0){
80100aec:	83 ec 0c             	sub    $0xc,%esp
80100aef:	ff 75 08             	pushl  0x8(%ebp)
80100af2:	e8 b9 14 00 00       	call   80101fb0 <namei>
80100af7:	83 c4 10             	add    $0x10,%esp
80100afa:	85 c0                	test   %eax,%eax
80100afc:	0f 84 9c 01 00 00    	je     80100c9e <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b02:	83 ec 0c             	sub    $0xc,%esp
80100b05:	89 c3                	mov    %eax,%ebx
80100b07:	50                   	push   %eax
80100b08:	e8 53 0c 00 00       	call   80101760 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b0d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b13:	6a 34                	push   $0x34
80100b15:	6a 00                	push   $0x0
80100b17:	50                   	push   %eax
80100b18:	53                   	push   %ebx
80100b19:	e8 22 0f 00 00       	call   80101a40 <readi>
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
80100b2a:	e8 c1 0e 00 00       	call   801019f0 <iunlockput>
    end_op();
80100b2f:	e8 9c 21 00 00       	call   80102cd0 <end_op>
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
80100b54:	e8 a7 61 00 00       	call   80106d00 <setupkvm>
80100b59:	85 c0                	test   %eax,%eax
80100b5b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b61:	74 c3                	je     80100b26 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b63:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b6a:	00 
80100b6b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b71:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100b78:	00 00 00 
80100b7b:	0f 84 c5 00 00 00    	je     80100c46 <exec+0x176>
80100b81:	31 ff                	xor    %edi,%edi
80100b83:	eb 18                	jmp    80100b9d <exec+0xcd>
80100b85:	8d 76 00             	lea    0x0(%esi),%esi
80100b88:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b8f:	83 c7 01             	add    $0x1,%edi
80100b92:	83 c6 20             	add    $0x20,%esi
80100b95:	39 f8                	cmp    %edi,%eax
80100b97:	0f 8e a9 00 00 00    	jle    80100c46 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b9d:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ba3:	6a 20                	push   $0x20
80100ba5:	56                   	push   %esi
80100ba6:	50                   	push   %eax
80100ba7:	53                   	push   %ebx
80100ba8:	e8 93 0e 00 00       	call   80101a40 <readi>
80100bad:	83 c4 10             	add    $0x10,%esp
80100bb0:	83 f8 20             	cmp    $0x20,%eax
80100bb3:	75 7b                	jne    80100c30 <exec+0x160>
    if(ph.type != ELF_PROG_LOAD)
80100bb5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100bbc:	75 ca                	jne    80100b88 <exec+0xb8>
    if(ph.memsz < ph.filesz)
80100bbe:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100bc4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100bca:	72 64                	jb     80100c30 <exec+0x160>
80100bcc:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100bd2:	72 5c                	jb     80100c30 <exec+0x160>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bd4:	83 ec 04             	sub    $0x4,%esp
80100bd7:	50                   	push   %eax
80100bd8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100bde:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100be4:	e8 77 5f 00 00       	call   80106b60 <allocuvm>
80100be9:	83 c4 10             	add    $0x10,%esp
80100bec:	85 c0                	test   %eax,%eax
80100bee:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100bf4:	74 3a                	je     80100c30 <exec+0x160>
    if(ph.vaddr % PGSIZE != 0)
80100bf6:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bfc:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100c01:	75 2d                	jne    80100c30 <exec+0x160>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c03:	83 ec 0c             	sub    $0xc,%esp
80100c06:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100c0c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100c12:	53                   	push   %ebx
80100c13:	50                   	push   %eax
80100c14:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c1a:	e8 81 5e 00 00       	call   80106aa0 <loaduvm>
80100c1f:	83 c4 20             	add    $0x20,%esp
80100c22:	85 c0                	test   %eax,%eax
80100c24:	0f 89 5e ff ff ff    	jns    80100b88 <exec+0xb8>
80100c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    freevm(pgdir);
80100c30:	83 ec 0c             	sub    $0xc,%esp
80100c33:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c39:	e8 42 60 00 00       	call   80106c80 <freevm>
80100c3e:	83 c4 10             	add    $0x10,%esp
80100c41:	e9 e0 fe ff ff       	jmp    80100b26 <exec+0x56>
  iunlockput(ip);
80100c46:	83 ec 0c             	sub    $0xc,%esp
80100c49:	53                   	push   %ebx
80100c4a:	e8 a1 0d 00 00       	call   801019f0 <iunlockput>
  end_op();
80100c4f:	e8 7c 20 00 00       	call   80102cd0 <end_op>
  sz = PGROUNDUP(sz);
80100c54:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c5a:	83 c4 0c             	add    $0xc,%esp
  sz = PGROUNDUP(sz);
80100c5d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c62:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c67:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100c6d:	52                   	push   %edx
80100c6e:	50                   	push   %eax
80100c6f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c75:	e8 e6 5e 00 00       	call   80106b60 <allocuvm>
80100c7a:	83 c4 10             	add    $0x10,%esp
80100c7d:	85 c0                	test   %eax,%eax
80100c7f:	89 c6                	mov    %eax,%esi
80100c81:	75 3a                	jne    80100cbd <exec+0x1ed>
    freevm(pgdir);
80100c83:	83 ec 0c             	sub    $0xc,%esp
80100c86:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c8c:	e8 ef 5f 00 00       	call   80106c80 <freevm>
80100c91:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c99:	e9 9e fe ff ff       	jmp    80100b3c <exec+0x6c>
    end_op();
80100c9e:	e8 2d 20 00 00       	call   80102cd0 <end_op>
    cprintf("exec: fail\n");
80100ca3:	83 ec 0c             	sub    $0xc,%esp
80100ca6:	68 21 70 10 80       	push   $0x80107021
80100cab:	e8 90 fa ff ff       	call   80100740 <cprintf>
    return -1;
80100cb0:	83 c4 10             	add    $0x10,%esp
80100cb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cb8:	e9 7f fe ff ff       	jmp    80100b3c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cbd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100cc3:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100cc6:	31 ff                	xor    %edi,%edi
80100cc8:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cca:	50                   	push   %eax
80100ccb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cd1:	e8 ca 60 00 00       	call   80106da0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cd6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cd9:	83 c4 10             	add    $0x10,%esp
80100cdc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100ce2:	8b 00                	mov    (%eax),%eax
80100ce4:	85 c0                	test   %eax,%eax
80100ce6:	74 79                	je     80100d61 <exec+0x291>
80100ce8:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100cee:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100cf4:	eb 13                	jmp    80100d09 <exec+0x239>
80100cf6:	8d 76 00             	lea    0x0(%esi),%esi
80100cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100d00:	83 ff 20             	cmp    $0x20,%edi
80100d03:	0f 84 7a ff ff ff    	je     80100c83 <exec+0x1b3>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d09:	83 ec 0c             	sub    $0xc,%esp
80100d0c:	50                   	push   %eax
80100d0d:	e8 3e 3a 00 00       	call   80104750 <strlen>
80100d12:	f7 d0                	not    %eax
80100d14:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d16:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d19:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d1a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d1d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d20:	e8 2b 3a 00 00       	call   80104750 <strlen>
80100d25:	83 c0 01             	add    $0x1,%eax
80100d28:	50                   	push   %eax
80100d29:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d2c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d2f:	53                   	push   %ebx
80100d30:	56                   	push   %esi
80100d31:	e8 ca 61 00 00       	call   80106f00 <copyout>
80100d36:	83 c4 20             	add    $0x20,%esp
80100d39:	85 c0                	test   %eax,%eax
80100d3b:	0f 88 42 ff ff ff    	js     80100c83 <exec+0x1b3>
  for(argc = 0; argv[argc]; argc++) {
80100d41:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d44:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d4b:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d4e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d54:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d57:	85 c0                	test   %eax,%eax
80100d59:	75 a5                	jne    80100d00 <exec+0x230>
80100d5b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d61:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d68:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d6a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d71:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100d75:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d7c:	ff ff ff 
  ustack[1] = argc;
80100d7f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d85:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d87:	83 c0 0c             	add    $0xc,%eax
80100d8a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d8c:	50                   	push   %eax
80100d8d:	52                   	push   %edx
80100d8e:	53                   	push   %ebx
80100d8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d95:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d9b:	e8 60 61 00 00       	call   80106f00 <copyout>
80100da0:	83 c4 10             	add    $0x10,%esp
80100da3:	85 c0                	test   %eax,%eax
80100da5:	0f 88 d8 fe ff ff    	js     80100c83 <exec+0x1b3>
  for(last=s=path; *s; s++)
80100dab:	8b 45 08             	mov    0x8(%ebp),%eax
80100dae:	0f b6 10             	movzbl (%eax),%edx
80100db1:	84 d2                	test   %dl,%dl
80100db3:	74 19                	je     80100dce <exec+0x2fe>
80100db5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100db8:	83 c0 01             	add    $0x1,%eax
      last = s+1;
80100dbb:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
80100dbe:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
80100dc1:	0f 44 c8             	cmove  %eax,%ecx
80100dc4:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
80100dc7:	84 d2                	test   %dl,%dl
80100dc9:	75 f0                	jne    80100dbb <exec+0x2eb>
80100dcb:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100dce:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100dd4:	50                   	push   %eax
80100dd5:	6a 10                	push   $0x10
80100dd7:	ff 75 08             	pushl  0x8(%ebp)
80100dda:	89 f8                	mov    %edi,%eax
80100ddc:	83 c0 6c             	add    $0x6c,%eax
80100ddf:	50                   	push   %eax
80100de0:	e8 2b 39 00 00       	call   80104710 <safestrcpy>
  curproc->pgdir = pgdir;
80100de5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100deb:	89 f8                	mov    %edi,%eax
80100ded:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100df0:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100df2:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100df5:	89 c1                	mov    %eax,%ecx
80100df7:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dfd:	8b 40 18             	mov    0x18(%eax),%eax
80100e00:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e03:	8b 41 18             	mov    0x18(%ecx),%eax
80100e06:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e09:	89 0c 24             	mov    %ecx,(%esp)
80100e0c:	e8 ff 5a 00 00       	call   80106910 <switchuvm>
  freevm(oldpgdir);
80100e11:	89 3c 24             	mov    %edi,(%esp)
80100e14:	e8 67 5e 00 00       	call   80106c80 <freevm>
  return 0;
80100e19:	83 c4 10             	add    $0x10,%esp
80100e1c:	31 c0                	xor    %eax,%eax
80100e1e:	e9 19 fd ff ff       	jmp    80100b3c <exec+0x6c>
80100e23:	66 90                	xchg   %ax,%ax
80100e25:	66 90                	xchg   %ax,%ax
80100e27:	66 90                	xchg   %ax,%ax
80100e29:	66 90                	xchg   %ax,%ax
80100e2b:	66 90                	xchg   %ax,%ax
80100e2d:	66 90                	xchg   %ax,%ax
80100e2f:	90                   	nop

80100e30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e36:	68 2d 70 10 80       	push   $0x8010702d
80100e3b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e40:	e8 8b 34 00 00       	call   801042d0 <initlock>
}
80100e45:	83 c4 10             	add    $0x10,%esp
80100e48:	c9                   	leave  
80100e49:	c3                   	ret    
80100e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
{
80100e59:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e5c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e61:	e8 ca 35 00 00       	call   80104430 <acquire>
80100e66:	83 c4 10             	add    $0x10,%esp
80100e69:	eb 10                	jmp    80100e7b <filealloc+0x2b>
80100e6b:	90                   	nop
80100e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e70:	83 c3 18             	add    $0x18,%ebx
80100e73:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e79:	73 25                	jae    80100ea0 <filealloc+0x50>
    if(f->ref == 0){
80100e7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e7e:	85 c0                	test   %eax,%eax
80100e80:	75 ee                	jne    80100e70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e82:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e8c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e91:	e8 4a 36 00 00       	call   801044e0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e96:	89 d8                	mov    %ebx,%eax
      return f;
80100e98:	83 c4 10             	add    $0x10,%esp
}
80100e9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e9e:	c9                   	leave  
80100e9f:	c3                   	ret    
  release(&ftable.lock);
80100ea0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100ea3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ea5:	68 c0 ff 10 80       	push   $0x8010ffc0
80100eaa:	e8 31 36 00 00       	call   801044e0 <release>
}
80100eaf:	89 d8                	mov    %ebx,%eax
  return 0;
80100eb1:	83 c4 10             	add    $0x10,%esp
}
80100eb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eb7:	c9                   	leave  
80100eb8:	c3                   	ret    
80100eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ec0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	53                   	push   %ebx
80100ec4:	83 ec 10             	sub    $0x10,%esp
80100ec7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eca:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ecf:	e8 5c 35 00 00       	call   80104430 <acquire>
  if(f->ref < 1)
80100ed4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ed7:	83 c4 10             	add    $0x10,%esp
80100eda:	85 c0                	test   %eax,%eax
80100edc:	7e 1a                	jle    80100ef8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ede:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ee1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ee4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ee7:	68 c0 ff 10 80       	push   $0x8010ffc0
80100eec:	e8 ef 35 00 00       	call   801044e0 <release>
  return f;
}
80100ef1:	89 d8                	mov    %ebx,%eax
80100ef3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ef6:	c9                   	leave  
80100ef7:	c3                   	ret    
    panic("filedup");
80100ef8:	83 ec 0c             	sub    $0xc,%esp
80100efb:	68 34 70 10 80       	push   $0x80107034
80100f00:	e8 6b f4 ff ff       	call   80100370 <panic>
80100f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f10 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	57                   	push   %edi
80100f14:	56                   	push   %esi
80100f15:	53                   	push   %ebx
80100f16:	83 ec 28             	sub    $0x28,%esp
80100f19:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100f1c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100f21:	e8 0a 35 00 00       	call   80104430 <acquire>
  if(f->ref < 1)
80100f26:	8b 47 04             	mov    0x4(%edi),%eax
80100f29:	83 c4 10             	add    $0x10,%esp
80100f2c:	85 c0                	test   %eax,%eax
80100f2e:	0f 8e 9b 00 00 00    	jle    80100fcf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100f34:	83 e8 01             	sub    $0x1,%eax
80100f37:	85 c0                	test   %eax,%eax
80100f39:	89 47 04             	mov    %eax,0x4(%edi)
80100f3c:	74 1a                	je     80100f58 <fileclose+0x48>
    release(&ftable.lock);
80100f3e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f48:	5b                   	pop    %ebx
80100f49:	5e                   	pop    %esi
80100f4a:	5f                   	pop    %edi
80100f4b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f4c:	e9 8f 35 00 00       	jmp    801044e0 <release>
80100f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f58:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100f5c:	8b 1f                	mov    (%edi),%ebx
  release(&ftable.lock);
80100f5e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f61:	8b 77 0c             	mov    0xc(%edi),%esi
  f->type = FD_NONE;
80100f64:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  ff = *f;
80100f6a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f6d:	8b 47 10             	mov    0x10(%edi),%eax
  release(&ftable.lock);
80100f70:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100f75:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f78:	e8 63 35 00 00       	call   801044e0 <release>
  if(ff.type == FD_PIPE)
80100f7d:	83 c4 10             	add    $0x10,%esp
80100f80:	83 fb 01             	cmp    $0x1,%ebx
80100f83:	74 13                	je     80100f98 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f85:	83 fb 02             	cmp    $0x2,%ebx
80100f88:	74 26                	je     80100fb0 <fileclose+0xa0>
}
80100f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8d:	5b                   	pop    %ebx
80100f8e:	5e                   	pop    %esi
80100f8f:	5f                   	pop    %edi
80100f90:	5d                   	pop    %ebp
80100f91:	c3                   	ret    
80100f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f98:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f9c:	83 ec 08             	sub    $0x8,%esp
80100f9f:	53                   	push   %ebx
80100fa0:	56                   	push   %esi
80100fa1:	e8 4a 24 00 00       	call   801033f0 <pipeclose>
80100fa6:	83 c4 10             	add    $0x10,%esp
80100fa9:	eb df                	jmp    80100f8a <fileclose+0x7a>
80100fab:	90                   	nop
80100fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100fb0:	e8 ab 1c 00 00       	call   80102c60 <begin_op>
    iput(ff.ip);
80100fb5:	83 ec 0c             	sub    $0xc,%esp
80100fb8:	ff 75 e0             	pushl  -0x20(%ebp)
80100fbb:	e8 d0 08 00 00       	call   80101890 <iput>
    end_op();
80100fc0:	83 c4 10             	add    $0x10,%esp
}
80100fc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc6:	5b                   	pop    %ebx
80100fc7:	5e                   	pop    %esi
80100fc8:	5f                   	pop    %edi
80100fc9:	5d                   	pop    %ebp
    end_op();
80100fca:	e9 01 1d 00 00       	jmp    80102cd0 <end_op>
    panic("fileclose");
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 3c 70 10 80       	push   $0x8010703c
80100fd7:	e8 94 f3 ff ff       	call   80100370 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	53                   	push   %ebx
80100fe4:	83 ec 04             	sub    $0x4,%esp
80100fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fea:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fed:	75 31                	jne    80101020 <filestat+0x40>
    ilock(f->ip);
80100fef:	83 ec 0c             	sub    $0xc,%esp
80100ff2:	ff 73 10             	pushl  0x10(%ebx)
80100ff5:	e8 66 07 00 00       	call   80101760 <ilock>
    stati(f->ip, st);
80100ffa:	58                   	pop    %eax
80100ffb:	5a                   	pop    %edx
80100ffc:	ff 75 0c             	pushl  0xc(%ebp)
80100fff:	ff 73 10             	pushl  0x10(%ebx)
80101002:	e8 09 0a 00 00       	call   80101a10 <stati>
    iunlock(f->ip);
80101007:	59                   	pop    %ecx
80101008:	ff 73 10             	pushl  0x10(%ebx)
8010100b:	e8 30 08 00 00       	call   80101840 <iunlock>
    return 0;
80101010:	83 c4 10             	add    $0x10,%esp
80101013:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101015:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101018:	c9                   	leave  
80101019:	c3                   	ret    
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101025:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101028:	c9                   	leave  
80101029:	c3                   	ret    
8010102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101030 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 0c             	sub    $0xc,%esp
80101039:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010103c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010103f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101042:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101046:	74 60                	je     801010a8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101048:	8b 03                	mov    (%ebx),%eax
8010104a:	83 f8 01             	cmp    $0x1,%eax
8010104d:	74 41                	je     80101090 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010104f:	83 f8 02             	cmp    $0x2,%eax
80101052:	75 5b                	jne    801010af <fileread+0x7f>
    ilock(f->ip);
80101054:	83 ec 0c             	sub    $0xc,%esp
80101057:	ff 73 10             	pushl  0x10(%ebx)
8010105a:	e8 01 07 00 00       	call   80101760 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010105f:	57                   	push   %edi
80101060:	ff 73 14             	pushl  0x14(%ebx)
80101063:	56                   	push   %esi
80101064:	ff 73 10             	pushl  0x10(%ebx)
80101067:	e8 d4 09 00 00       	call   80101a40 <readi>
8010106c:	83 c4 20             	add    $0x20,%esp
8010106f:	85 c0                	test   %eax,%eax
80101071:	89 c6                	mov    %eax,%esi
80101073:	7e 03                	jle    80101078 <fileread+0x48>
      f->off += r;
80101075:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101078:	83 ec 0c             	sub    $0xc,%esp
8010107b:	ff 73 10             	pushl  0x10(%ebx)
8010107e:	e8 bd 07 00 00       	call   80101840 <iunlock>
    return r;
80101083:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	89 f0                	mov    %esi,%eax
8010108b:	5b                   	pop    %ebx
8010108c:	5e                   	pop    %esi
8010108d:	5f                   	pop    %edi
8010108e:	5d                   	pop    %ebp
8010108f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101090:	8b 43 0c             	mov    0xc(%ebx),%eax
80101093:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101096:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101099:	5b                   	pop    %ebx
8010109a:	5e                   	pop    %esi
8010109b:	5f                   	pop    %edi
8010109c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010109d:	e9 fe 24 00 00       	jmp    801035a0 <piperead>
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010ad:	eb d7                	jmp    80101086 <fileread+0x56>
  panic("fileread");
801010af:	83 ec 0c             	sub    $0xc,%esp
801010b2:	68 46 70 10 80       	push   $0x80107046
801010b7:	e8 b4 f2 ff ff       	call   80100370 <panic>
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

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
801010c6:	83 ec 1c             	sub    $0x1c,%esp
801010c9:	8b 75 08             	mov    0x8(%ebp),%esi
801010cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801010cf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801010d3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010d6:	8b 45 10             	mov    0x10(%ebp),%eax
801010d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010dc:	0f 84 aa 00 00 00    	je     8010118c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
801010e2:	8b 06                	mov    (%esi),%eax
801010e4:	83 f8 01             	cmp    $0x1,%eax
801010e7:	0f 84 c2 00 00 00    	je     801011af <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ed:	83 f8 02             	cmp    $0x2,%eax
801010f0:	0f 85 e4 00 00 00    	jne    801011da <filewrite+0x11a>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010f9:	31 ff                	xor    %edi,%edi
801010fb:	85 c0                	test   %eax,%eax
801010fd:	7f 34                	jg     80101133 <filewrite+0x73>
801010ff:	e9 9c 00 00 00       	jmp    801011a0 <filewrite+0xe0>
80101104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101108:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010110b:	83 ec 0c             	sub    $0xc,%esp
8010110e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101111:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101114:	e8 27 07 00 00       	call   80101840 <iunlock>
      end_op();
80101119:	e8 b2 1b 00 00       	call   80102cd0 <end_op>
8010111e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101121:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101124:	39 d8                	cmp    %ebx,%eax
80101126:	0f 85 a1 00 00 00    	jne    801011cd <filewrite+0x10d>
        panic("short filewrite");
      i += r;
8010112c:	01 c7                	add    %eax,%edi
    while(i < n){
8010112e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101131:	7e 6d                	jle    801011a0 <filewrite+0xe0>
      int n1 = n - i;
80101133:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101136:	b8 00 06 00 00       	mov    $0x600,%eax
8010113b:	29 fb                	sub    %edi,%ebx
8010113d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101143:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101146:	e8 15 1b 00 00       	call   80102c60 <begin_op>
      ilock(f->ip);
8010114b:	83 ec 0c             	sub    $0xc,%esp
8010114e:	ff 76 10             	pushl  0x10(%esi)
80101151:	e8 0a 06 00 00       	call   80101760 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101156:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101159:	53                   	push   %ebx
8010115a:	ff 76 14             	pushl  0x14(%esi)
8010115d:	01 f8                	add    %edi,%eax
8010115f:	50                   	push   %eax
80101160:	ff 76 10             	pushl  0x10(%esi)
80101163:	e8 d8 09 00 00       	call   80101b40 <writei>
80101168:	83 c4 20             	add    $0x20,%esp
8010116b:	85 c0                	test   %eax,%eax
8010116d:	7f 99                	jg     80101108 <filewrite+0x48>
      iunlock(f->ip);
8010116f:	83 ec 0c             	sub    $0xc,%esp
80101172:	ff 76 10             	pushl  0x10(%esi)
80101175:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101178:	e8 c3 06 00 00       	call   80101840 <iunlock>
      end_op();
8010117d:	e8 4e 1b 00 00       	call   80102cd0 <end_op>
      if(r < 0)
80101182:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101185:	83 c4 10             	add    $0x10,%esp
80101188:	85 c0                	test   %eax,%eax
8010118a:	74 98                	je     80101124 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010118c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010118f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101194:	5b                   	pop    %ebx
80101195:	5e                   	pop    %esi
80101196:	5f                   	pop    %edi
80101197:	5d                   	pop    %ebp
80101198:	c3                   	ret    
80101199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801011a0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801011a3:	75 e7                	jne    8010118c <filewrite+0xcc>
}
801011a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a8:	89 f8                	mov    %edi,%eax
801011aa:	5b                   	pop    %ebx
801011ab:	5e                   	pop    %esi
801011ac:	5f                   	pop    %edi
801011ad:	5d                   	pop    %ebp
801011ae:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801011af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011b2:	89 45 10             	mov    %eax,0x10(%ebp)
801011b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b8:	89 45 0c             	mov    %eax,0xc(%ebp)
801011bb:	8b 46 0c             	mov    0xc(%esi),%eax
801011be:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c4:	5b                   	pop    %ebx
801011c5:	5e                   	pop    %esi
801011c6:	5f                   	pop    %edi
801011c7:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011c8:	e9 c3 22 00 00       	jmp    80103490 <pipewrite>
        panic("short filewrite");
801011cd:	83 ec 0c             	sub    $0xc,%esp
801011d0:	68 4f 70 10 80       	push   $0x8010704f
801011d5:	e8 96 f1 ff ff       	call   80100370 <panic>
  panic("filewrite");
801011da:	83 ec 0c             	sub    $0xc,%esp
801011dd:	68 55 70 10 80       	push   $0x80107055
801011e2:	e8 89 f1 ff ff       	call   80100370 <panic>
801011e7:	66 90                	xchg   %ax,%ax
801011e9:	66 90                	xchg   %ax,%ax
801011eb:	66 90                	xchg   %ax,%ax
801011ed:	66 90                	xchg   %ax,%ax
801011ef:	90                   	nop

801011f0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011f0:	55                   	push   %ebp
801011f1:	89 e5                	mov    %esp,%ebp
801011f3:	57                   	push   %edi
801011f4:	56                   	push   %esi
801011f5:	53                   	push   %ebx
801011f6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011f9:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
801011ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101202:	85 c9                	test   %ecx,%ecx
80101204:	0f 84 87 00 00 00    	je     80101291 <balloc+0xa1>
8010120a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101211:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101214:	83 ec 08             	sub    $0x8,%esp
80101217:	89 f0                	mov    %esi,%eax
80101219:	c1 f8 0c             	sar    $0xc,%eax
8010121c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101222:	50                   	push   %eax
80101223:	ff 75 d8             	pushl  -0x28(%ebp)
80101226:	e8 a5 ee ff ff       	call   801000d0 <bread>
8010122b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010122e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101233:	83 c4 10             	add    $0x10,%esp
80101236:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101239:	31 c0                	xor    %eax,%eax
8010123b:	eb 2f                	jmp    8010126c <balloc+0x7c>
8010123d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101240:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101245:	bb 01 00 00 00       	mov    $0x1,%ebx
8010124a:	83 e1 07             	and    $0x7,%ecx
8010124d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010124f:	89 c1                	mov    %eax,%ecx
80101251:	c1 f9 03             	sar    $0x3,%ecx
80101254:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101259:	85 df                	test   %ebx,%edi
8010125b:	89 fa                	mov    %edi,%edx
8010125d:	74 41                	je     801012a0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010125f:	83 c0 01             	add    $0x1,%eax
80101262:	83 c6 01             	add    $0x1,%esi
80101265:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010126a:	74 05                	je     80101271 <balloc+0x81>
8010126c:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010126f:	72 cf                	jb     80101240 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101271:	83 ec 0c             	sub    $0xc,%esp
80101274:	ff 75 e4             	pushl  -0x1c(%ebp)
80101277:	e8 64 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010127c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101283:	83 c4 10             	add    $0x10,%esp
80101286:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101289:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010128f:	77 80                	ja     80101211 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101291:	83 ec 0c             	sub    $0xc,%esp
80101294:	68 5f 70 10 80       	push   $0x8010705f
80101299:	e8 d2 f0 ff ff       	call   80100370 <panic>
8010129e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801012a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012a3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012a6:	09 da                	or     %ebx,%edx
801012a8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012ac:	57                   	push   %edi
801012ad:	e8 8e 1b 00 00       	call   80102e40 <log_write>
        brelse(bp);
801012b2:	89 3c 24             	mov    %edi,(%esp)
801012b5:	e8 26 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801012ba:	58                   	pop    %eax
801012bb:	5a                   	pop    %edx
801012bc:	56                   	push   %esi
801012bd:	ff 75 d8             	pushl  -0x28(%ebp)
801012c0:	e8 0b ee ff ff       	call   801000d0 <bread>
801012c5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801012ca:	83 c4 0c             	add    $0xc,%esp
801012cd:	68 00 02 00 00       	push   $0x200
801012d2:	6a 00                	push   $0x0
801012d4:	50                   	push   %eax
801012d5:	e8 56 32 00 00       	call   80104530 <memset>
  log_write(bp);
801012da:	89 1c 24             	mov    %ebx,(%esp)
801012dd:	e8 5e 1b 00 00       	call   80102e40 <log_write>
  brelse(bp);
801012e2:	89 1c 24             	mov    %ebx,(%esp)
801012e5:	e8 f6 ee ff ff       	call   801001e0 <brelse>
}
801012ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ed:	89 f0                	mov    %esi,%eax
801012ef:	5b                   	pop    %ebx
801012f0:	5e                   	pop    %esi
801012f1:	5f                   	pop    %edi
801012f2:	5d                   	pop    %ebp
801012f3:	c3                   	ret    
801012f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

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
80101304:	56                   	push   %esi
80101305:	53                   	push   %ebx
80101306:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101308:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010130f:	83 ec 28             	sub    $0x28,%esp
80101312:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101315:	68 e0 09 11 80       	push   $0x801109e0
8010131a:	e8 11 31 00 00       	call   80104430 <acquire>
8010131f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101322:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101325:	eb 1b                	jmp    80101342 <iget+0x42>
80101327:	89 f6                	mov    %esi,%esi
80101329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101330:	85 f6                	test   %esi,%esi
80101332:	74 44                	je     80101378 <iget+0x78>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101334:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010133a:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101340:	73 4e                	jae    80101390 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101342:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101345:	85 c9                	test   %ecx,%ecx
80101347:	7e e7                	jle    80101330 <iget+0x30>
80101349:	39 3b                	cmp    %edi,(%ebx)
8010134b:	75 e3                	jne    80101330 <iget+0x30>
8010134d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101350:	75 de                	jne    80101330 <iget+0x30>
      release(&icache.lock);
80101352:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101355:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101358:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010135a:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
8010135f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101362:	e8 79 31 00 00       	call   801044e0 <release>
      return ip;
80101367:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010136a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136d:	89 f0                	mov    %esi,%eax
8010136f:	5b                   	pop    %ebx
80101370:	5e                   	pop    %esi
80101371:	5f                   	pop    %edi
80101372:	5d                   	pop    %ebp
80101373:	c3                   	ret    
80101374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101378:	85 c9                	test   %ecx,%ecx
8010137a:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010137d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101383:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101389:	72 b7                	jb     80101342 <iget+0x42>
8010138b:	90                   	nop
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(empty == 0)
80101390:	85 f6                	test   %esi,%esi
80101392:	74 2d                	je     801013c1 <iget+0xc1>
  release(&icache.lock);
80101394:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101397:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101399:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010139c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013a3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013aa:	68 e0 09 11 80       	push   $0x801109e0
801013af:	e8 2c 31 00 00       	call   801044e0 <release>
  return ip;
801013b4:	83 c4 10             	add    $0x10,%esp
}
801013b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ba:	89 f0                	mov    %esi,%eax
801013bc:	5b                   	pop    %ebx
801013bd:	5e                   	pop    %esi
801013be:	5f                   	pop    %edi
801013bf:	5d                   	pop    %ebp
801013c0:	c3                   	ret    
    panic("iget: no inodes");
801013c1:	83 ec 0c             	sub    $0xc,%esp
801013c4:	68 75 70 10 80       	push   $0x80107075
801013c9:	e8 a2 ef ff ff       	call   80100370 <panic>
801013ce:	66 90                	xchg   %ax,%ax

801013d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	57                   	push   %edi
801013d4:	56                   	push   %esi
801013d5:	53                   	push   %ebx
801013d6:	89 c6                	mov    %eax,%esi
801013d8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013db:	83 fa 0b             	cmp    $0xb,%edx
801013de:	77 18                	ja     801013f8 <bmap+0x28>
801013e0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801013e3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801013e6:	85 db                	test   %ebx,%ebx
801013e8:	74 76                	je     80101460 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ed:	89 d8                	mov    %ebx,%eax
801013ef:	5b                   	pop    %ebx
801013f0:	5e                   	pop    %esi
801013f1:	5f                   	pop    %edi
801013f2:	5d                   	pop    %ebp
801013f3:	c3                   	ret    
801013f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801013f8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801013fb:	83 fb 7f             	cmp    $0x7f,%ebx
801013fe:	0f 87 8e 00 00 00    	ja     80101492 <bmap+0xc2>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101404:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010140a:	85 c0                	test   %eax,%eax
8010140c:	74 72                	je     80101480 <bmap+0xb0>
    bp = bread(ip->dev, addr);
8010140e:	83 ec 08             	sub    $0x8,%esp
80101411:	50                   	push   %eax
80101412:	ff 36                	pushl  (%esi)
80101414:	e8 b7 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101419:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010141d:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101420:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101422:	8b 1a                	mov    (%edx),%ebx
80101424:	85 db                	test   %ebx,%ebx
80101426:	75 1d                	jne    80101445 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101428:	8b 06                	mov    (%esi),%eax
8010142a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010142d:	e8 be fd ff ff       	call   801011f0 <balloc>
80101432:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101435:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101438:	89 c3                	mov    %eax,%ebx
8010143a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010143c:	57                   	push   %edi
8010143d:	e8 fe 19 00 00       	call   80102e40 <log_write>
80101442:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101445:	83 ec 0c             	sub    $0xc,%esp
80101448:	57                   	push   %edi
80101449:	e8 92 ed ff ff       	call   801001e0 <brelse>
8010144e:	83 c4 10             	add    $0x10,%esp
}
80101451:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101454:	89 d8                	mov    %ebx,%eax
80101456:	5b                   	pop    %ebx
80101457:	5e                   	pop    %esi
80101458:	5f                   	pop    %edi
80101459:	5d                   	pop    %ebp
8010145a:	c3                   	ret    
8010145b:	90                   	nop
8010145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101460:	8b 00                	mov    (%eax),%eax
80101462:	e8 89 fd ff ff       	call   801011f0 <balloc>
80101467:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010146a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010146d:	89 c3                	mov    %eax,%ebx
}
8010146f:	89 d8                	mov    %ebx,%eax
80101471:	5b                   	pop    %ebx
80101472:	5e                   	pop    %esi
80101473:	5f                   	pop    %edi
80101474:	5d                   	pop    %ebp
80101475:	c3                   	ret    
80101476:	8d 76 00             	lea    0x0(%esi),%esi
80101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101480:	8b 06                	mov    (%esi),%eax
80101482:	e8 69 fd ff ff       	call   801011f0 <balloc>
80101487:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010148d:	e9 7c ff ff ff       	jmp    8010140e <bmap+0x3e>
  panic("bmap: out of range");
80101492:	83 ec 0c             	sub    $0xc,%esp
80101495:	68 85 70 10 80       	push   $0x80107085
8010149a:	e8 d1 ee ff ff       	call   80100370 <panic>
8010149f:	90                   	nop

801014a0 <readsb>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	56                   	push   %esi
801014a4:	53                   	push   %ebx
801014a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801014a8:	83 ec 08             	sub    $0x8,%esp
801014ab:	6a 01                	push   $0x1
801014ad:	ff 75 08             	pushl  0x8(%ebp)
801014b0:	e8 1b ec ff ff       	call   801000d0 <bread>
801014b5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801014b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801014ba:	83 c4 0c             	add    $0xc,%esp
801014bd:	6a 1c                	push   $0x1c
801014bf:	50                   	push   %eax
801014c0:	56                   	push   %esi
801014c1:	e8 1a 31 00 00       	call   801045e0 <memmove>
  brelse(bp);
801014c6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801014c9:	83 c4 10             	add    $0x10,%esp
}
801014cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014cf:	5b                   	pop    %ebx
801014d0:	5e                   	pop    %esi
801014d1:	5d                   	pop    %ebp
  brelse(bp);
801014d2:	e9 09 ed ff ff       	jmp    801001e0 <brelse>
801014d7:	89 f6                	mov    %esi,%esi
801014d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014e0 <bfree>:
{
801014e0:	55                   	push   %ebp
801014e1:	89 e5                	mov    %esp,%ebp
801014e3:	56                   	push   %esi
801014e4:	53                   	push   %ebx
801014e5:	89 d3                	mov    %edx,%ebx
801014e7:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
801014e9:	83 ec 08             	sub    $0x8,%esp
801014ec:	68 c0 09 11 80       	push   $0x801109c0
801014f1:	50                   	push   %eax
801014f2:	e8 a9 ff ff ff       	call   801014a0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014f7:	58                   	pop    %eax
801014f8:	5a                   	pop    %edx
801014f9:	89 da                	mov    %ebx,%edx
801014fb:	c1 ea 0c             	shr    $0xc,%edx
801014fe:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101504:	52                   	push   %edx
80101505:	56                   	push   %esi
80101506:	e8 c5 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010150b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010150d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101510:	ba 01 00 00 00       	mov    $0x1,%edx
80101515:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101518:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010151e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101521:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101523:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101528:	85 d1                	test   %edx,%ecx
8010152a:	74 25                	je     80101551 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010152c:	f7 d2                	not    %edx
8010152e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101530:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101533:	21 ca                	and    %ecx,%edx
80101535:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101539:	56                   	push   %esi
8010153a:	e8 01 19 00 00       	call   80102e40 <log_write>
  brelse(bp);
8010153f:	89 34 24             	mov    %esi,(%esp)
80101542:	e8 99 ec ff ff       	call   801001e0 <brelse>
}
80101547:	83 c4 10             	add    $0x10,%esp
8010154a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010154d:	5b                   	pop    %ebx
8010154e:	5e                   	pop    %esi
8010154f:	5d                   	pop    %ebp
80101550:	c3                   	ret    
    panic("freeing free block");
80101551:	83 ec 0c             	sub    $0xc,%esp
80101554:	68 98 70 10 80       	push   $0x80107098
80101559:	e8 12 ee ff ff       	call   80100370 <panic>
8010155e:	66 90                	xchg   %ax,%ax

80101560 <iinit>:
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	53                   	push   %ebx
80101564:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101569:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010156c:	68 ab 70 10 80       	push   $0x801070ab
80101571:	68 e0 09 11 80       	push   $0x801109e0
80101576:	e8 55 2d 00 00       	call   801042d0 <initlock>
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 b2 70 10 80       	push   $0x801070b2
80101588:	53                   	push   %ebx
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010158f:	e8 0c 2c 00 00       	call   801041a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101594:	83 c4 10             	add    $0x10,%esp
80101597:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010159d:	75 e1                	jne    80101580 <iinit+0x20>
  readsb(dev, &sb);
8010159f:	83 ec 08             	sub    $0x8,%esp
801015a2:	68 c0 09 11 80       	push   $0x801109c0
801015a7:	ff 75 08             	pushl  0x8(%ebp)
801015aa:	e8 f1 fe ff ff       	call   801014a0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015af:	ff 35 d8 09 11 80    	pushl  0x801109d8
801015b5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801015bb:	ff 35 d0 09 11 80    	pushl  0x801109d0
801015c1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801015c7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801015cd:	ff 35 c4 09 11 80    	pushl  0x801109c4
801015d3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801015d9:	68 18 71 10 80       	push   $0x80107118
801015de:	e8 5d f1 ff ff       	call   80100740 <cprintf>
}
801015e3:	83 c4 30             	add    $0x30,%esp
801015e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015e9:	c9                   	leave  
801015ea:	c3                   	ret    
801015eb:	90                   	nop
801015ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015f0 <ialloc>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	57                   	push   %edi
801015f4:	56                   	push   %esi
801015f5:	53                   	push   %ebx
801015f6:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015f9:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101600:	8b 45 0c             	mov    0xc(%ebp),%eax
80101603:	8b 75 08             	mov    0x8(%ebp),%esi
80101606:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101609:	0f 86 91 00 00 00    	jbe    801016a0 <ialloc+0xb0>
8010160f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101614:	eb 21                	jmp    80101637 <ialloc+0x47>
80101616:	8d 76 00             	lea    0x0(%esi),%esi
80101619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101620:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101623:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101626:	57                   	push   %edi
80101627:	e8 b4 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010162c:	83 c4 10             	add    $0x10,%esp
8010162f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101635:	76 69                	jbe    801016a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101637:	89 d8                	mov    %ebx,%eax
80101639:	83 ec 08             	sub    $0x8,%esp
8010163c:	c1 e8 03             	shr    $0x3,%eax
8010163f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101645:	50                   	push   %eax
80101646:	56                   	push   %esi
80101647:	e8 84 ea ff ff       	call   801000d0 <bread>
8010164c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010164e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101650:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101653:	83 e0 07             	and    $0x7,%eax
80101656:	c1 e0 06             	shl    $0x6,%eax
80101659:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010165d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101661:	75 bd                	jne    80101620 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101663:	83 ec 04             	sub    $0x4,%esp
80101666:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101669:	6a 40                	push   $0x40
8010166b:	6a 00                	push   $0x0
8010166d:	51                   	push   %ecx
8010166e:	e8 bd 2e 00 00       	call   80104530 <memset>
      dip->type = type;
80101673:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101677:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010167a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010167d:	89 3c 24             	mov    %edi,(%esp)
80101680:	e8 bb 17 00 00       	call   80102e40 <log_write>
      brelse(bp);
80101685:	89 3c 24             	mov    %edi,(%esp)
80101688:	e8 53 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010168d:	83 c4 10             	add    $0x10,%esp
}
80101690:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101693:	89 da                	mov    %ebx,%edx
80101695:	89 f0                	mov    %esi,%eax
}
80101697:	5b                   	pop    %ebx
80101698:	5e                   	pop    %esi
80101699:	5f                   	pop    %edi
8010169a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010169b:	e9 60 fc ff ff       	jmp    80101300 <iget>
  panic("ialloc: no inodes");
801016a0:	83 ec 0c             	sub    $0xc,%esp
801016a3:	68 b8 70 10 80       	push   $0x801070b8
801016a8:	e8 c3 ec ff ff       	call   80100370 <panic>
801016ad:	8d 76 00             	lea    0x0(%esi),%esi

801016b0 <iupdate>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b8:	83 ec 08             	sub    $0x8,%esp
801016bb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016be:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c1:	c1 e8 03             	shr    $0x3,%eax
801016c4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016ca:	50                   	push   %eax
801016cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801016ce:	e8 fd e9 ff ff       	call   801000d0 <bread>
801016d3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801016d8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016f0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101703:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101707:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010170a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010170d:	6a 34                	push   $0x34
8010170f:	53                   	push   %ebx
80101710:	50                   	push   %eax
80101711:	e8 ca 2e 00 00       	call   801045e0 <memmove>
  log_write(bp);
80101716:	89 34 24             	mov    %esi,(%esp)
80101719:	e8 22 17 00 00       	call   80102e40 <log_write>
  brelse(bp);
8010171e:	89 75 08             	mov    %esi,0x8(%ebp)
80101721:	83 c4 10             	add    $0x10,%esp
}
80101724:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101727:	5b                   	pop    %ebx
80101728:	5e                   	pop    %esi
80101729:	5d                   	pop    %ebp
  brelse(bp);
8010172a:	e9 b1 ea ff ff       	jmp    801001e0 <brelse>
8010172f:	90                   	nop

80101730 <idup>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	53                   	push   %ebx
80101734:	83 ec 10             	sub    $0x10,%esp
80101737:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010173a:	68 e0 09 11 80       	push   $0x801109e0
8010173f:	e8 ec 2c 00 00       	call   80104430 <acquire>
  ip->ref++;
80101744:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101748:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010174f:	e8 8c 2d 00 00       	call   801044e0 <release>
}
80101754:	89 d8                	mov    %ebx,%eax
80101756:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101759:	c9                   	leave  
8010175a:	c3                   	ret    
8010175b:	90                   	nop
8010175c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101760 <ilock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	0f 84 b7 00 00 00    	je     80101827 <ilock+0xc7>
80101770:	8b 53 08             	mov    0x8(%ebx),%edx
80101773:	85 d2                	test   %edx,%edx
80101775:	0f 8e ac 00 00 00    	jle    80101827 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010177b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010177e:	83 ec 0c             	sub    $0xc,%esp
80101781:	50                   	push   %eax
80101782:	e8 59 2a 00 00       	call   801041e0 <acquiresleep>
  if(ip->valid == 0){
80101787:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010178a:	83 c4 10             	add    $0x10,%esp
8010178d:	85 c0                	test   %eax,%eax
8010178f:	74 0f                	je     801017a0 <ilock+0x40>
}
80101791:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101794:	5b                   	pop    %ebx
80101795:	5e                   	pop    %esi
80101796:	5d                   	pop    %ebp
80101797:	c3                   	ret    
80101798:	90                   	nop
80101799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017a0:	8b 43 04             	mov    0x4(%ebx),%eax
801017a3:	83 ec 08             	sub    $0x8,%esp
801017a6:	c1 e8 03             	shr    $0x3,%eax
801017a9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801017af:	50                   	push   %eax
801017b0:	ff 33                	pushl  (%ebx)
801017b2:	e8 19 e9 ff ff       	call   801000d0 <bread>
801017b7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017b9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017bc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017bf:	83 e0 07             	and    $0x7,%eax
801017c2:	c1 e0 06             	shl    $0x6,%eax
801017c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017c9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017cc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801017ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017f1:	6a 34                	push   $0x34
801017f3:	50                   	push   %eax
801017f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017f7:	50                   	push   %eax
801017f8:	e8 e3 2d 00 00       	call   801045e0 <memmove>
    brelse(bp);
801017fd:	89 34 24             	mov    %esi,(%esp)
80101800:	e8 db e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101805:	83 c4 10             	add    $0x10,%esp
80101808:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010180d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101814:	0f 85 77 ff ff ff    	jne    80101791 <ilock+0x31>
      panic("ilock: no type");
8010181a:	83 ec 0c             	sub    $0xc,%esp
8010181d:	68 d0 70 10 80       	push   $0x801070d0
80101822:	e8 49 eb ff ff       	call   80100370 <panic>
    panic("ilock");
80101827:	83 ec 0c             	sub    $0xc,%esp
8010182a:	68 ca 70 10 80       	push   $0x801070ca
8010182f:	e8 3c eb ff ff       	call   80100370 <panic>
80101834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010183a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101840 <iunlock>:
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	56                   	push   %esi
80101844:	53                   	push   %ebx
80101845:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101848:	85 db                	test   %ebx,%ebx
8010184a:	74 28                	je     80101874 <iunlock+0x34>
8010184c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010184f:	83 ec 0c             	sub    $0xc,%esp
80101852:	56                   	push   %esi
80101853:	e8 28 2a 00 00       	call   80104280 <holdingsleep>
80101858:	83 c4 10             	add    $0x10,%esp
8010185b:	85 c0                	test   %eax,%eax
8010185d:	74 15                	je     80101874 <iunlock+0x34>
8010185f:	8b 43 08             	mov    0x8(%ebx),%eax
80101862:	85 c0                	test   %eax,%eax
80101864:	7e 0e                	jle    80101874 <iunlock+0x34>
  releasesleep(&ip->lock);
80101866:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101869:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010186c:	5b                   	pop    %ebx
8010186d:	5e                   	pop    %esi
8010186e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010186f:	e9 cc 29 00 00       	jmp    80104240 <releasesleep>
    panic("iunlock");
80101874:	83 ec 0c             	sub    $0xc,%esp
80101877:	68 df 70 10 80       	push   $0x801070df
8010187c:	e8 ef ea ff ff       	call   80100370 <panic>
80101881:	eb 0d                	jmp    80101890 <iput>
80101883:	90                   	nop
80101884:	90                   	nop
80101885:	90                   	nop
80101886:	90                   	nop
80101887:	90                   	nop
80101888:	90                   	nop
80101889:	90                   	nop
8010188a:	90                   	nop
8010188b:	90                   	nop
8010188c:	90                   	nop
8010188d:	90                   	nop
8010188e:	90                   	nop
8010188f:	90                   	nop

80101890 <iput>:
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	57                   	push   %edi
80101894:	56                   	push   %esi
80101895:	53                   	push   %ebx
80101896:	83 ec 28             	sub    $0x28,%esp
80101899:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010189c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010189f:	57                   	push   %edi
801018a0:	e8 3b 29 00 00       	call   801041e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018a5:	8b 56 4c             	mov    0x4c(%esi),%edx
801018a8:	83 c4 10             	add    $0x10,%esp
801018ab:	85 d2                	test   %edx,%edx
801018ad:	74 07                	je     801018b6 <iput+0x26>
801018af:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801018b4:	74 32                	je     801018e8 <iput+0x58>
  releasesleep(&ip->lock);
801018b6:	83 ec 0c             	sub    $0xc,%esp
801018b9:	57                   	push   %edi
801018ba:	e8 81 29 00 00       	call   80104240 <releasesleep>
  acquire(&icache.lock);
801018bf:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018c6:	e8 65 2b 00 00       	call   80104430 <acquire>
  ip->ref--;
801018cb:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801018cf:	83 c4 10             	add    $0x10,%esp
801018d2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801018d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018dc:	5b                   	pop    %ebx
801018dd:	5e                   	pop    %esi
801018de:	5f                   	pop    %edi
801018df:	5d                   	pop    %ebp
  release(&icache.lock);
801018e0:	e9 fb 2b 00 00       	jmp    801044e0 <release>
801018e5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018e8:	83 ec 0c             	sub    $0xc,%esp
801018eb:	68 e0 09 11 80       	push   $0x801109e0
801018f0:	e8 3b 2b 00 00       	call   80104430 <acquire>
    int r = ip->ref;
801018f5:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801018f8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018ff:	e8 dc 2b 00 00       	call   801044e0 <release>
    if(r == 1){
80101904:	83 c4 10             	add    $0x10,%esp
80101907:	83 fb 01             	cmp    $0x1,%ebx
8010190a:	75 aa                	jne    801018b6 <iput+0x26>
8010190c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101912:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101915:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101918:	89 cf                	mov    %ecx,%edi
8010191a:	eb 0b                	jmp    80101927 <iput+0x97>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101920:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101923:	39 fb                	cmp    %edi,%ebx
80101925:	74 19                	je     80101940 <iput+0xb0>
    if(ip->addrs[i]){
80101927:	8b 13                	mov    (%ebx),%edx
80101929:	85 d2                	test   %edx,%edx
8010192b:	74 f3                	je     80101920 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010192d:	8b 06                	mov    (%esi),%eax
8010192f:	e8 ac fb ff ff       	call   801014e0 <bfree>
      ip->addrs[i] = 0;
80101934:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010193a:	eb e4                	jmp    80101920 <iput+0x90>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101940:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101946:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101949:	85 c0                	test   %eax,%eax
8010194b:	75 33                	jne    80101980 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010194d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101950:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101957:	56                   	push   %esi
80101958:	e8 53 fd ff ff       	call   801016b0 <iupdate>
      ip->type = 0;
8010195d:	31 c0                	xor    %eax,%eax
8010195f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101963:	89 34 24             	mov    %esi,(%esp)
80101966:	e8 45 fd ff ff       	call   801016b0 <iupdate>
      ip->valid = 0;
8010196b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101972:	83 c4 10             	add    $0x10,%esp
80101975:	e9 3c ff ff ff       	jmp    801018b6 <iput+0x26>
8010197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101980:	83 ec 08             	sub    $0x8,%esp
80101983:	50                   	push   %eax
80101984:	ff 36                	pushl  (%esi)
80101986:	e8 45 e7 ff ff       	call   801000d0 <bread>
8010198b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101991:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101994:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101997:	8d 58 5c             	lea    0x5c(%eax),%ebx
8010199a:	83 c4 10             	add    $0x10,%esp
8010199d:	89 cf                	mov    %ecx,%edi
8010199f:	eb 0e                	jmp    801019af <iput+0x11f>
801019a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019a8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801019ab:	39 fb                	cmp    %edi,%ebx
801019ad:	74 0f                	je     801019be <iput+0x12e>
      if(a[j])
801019af:	8b 13                	mov    (%ebx),%edx
801019b1:	85 d2                	test   %edx,%edx
801019b3:	74 f3                	je     801019a8 <iput+0x118>
        bfree(ip->dev, a[j]);
801019b5:	8b 06                	mov    (%esi),%eax
801019b7:	e8 24 fb ff ff       	call   801014e0 <bfree>
801019bc:	eb ea                	jmp    801019a8 <iput+0x118>
    brelse(bp);
801019be:	83 ec 0c             	sub    $0xc,%esp
801019c1:	ff 75 e4             	pushl  -0x1c(%ebp)
801019c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019c7:	e8 14 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019cc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801019d2:	8b 06                	mov    (%esi),%eax
801019d4:	e8 07 fb ff ff       	call   801014e0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019d9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801019e0:	00 00 00 
801019e3:	83 c4 10             	add    $0x10,%esp
801019e6:	e9 62 ff ff ff       	jmp    8010194d <iput+0xbd>
801019eb:	90                   	nop
801019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019f0 <iunlockput>:
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	53                   	push   %ebx
801019f4:	83 ec 10             	sub    $0x10,%esp
801019f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019fa:	53                   	push   %ebx
801019fb:	e8 40 fe ff ff       	call   80101840 <iunlock>
  iput(ip);
80101a00:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a03:	83 c4 10             	add    $0x10,%esp
}
80101a06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a09:	c9                   	leave  
  iput(ip);
80101a0a:	e9 81 fe ff ff       	jmp    80101890 <iput>
80101a0f:	90                   	nop

80101a10 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	8b 55 08             	mov    0x8(%ebp),%edx
80101a16:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a19:	8b 0a                	mov    (%edx),%ecx
80101a1b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a1e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a21:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a24:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a28:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a2b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a2f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a33:	8b 52 58             	mov    0x58(%edx),%edx
80101a36:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a39:	5d                   	pop    %ebp
80101a3a:	c3                   	ret    
80101a3b:	90                   	nop
80101a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a40 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 1c             	sub    $0x1c,%esp
80101a49:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a4f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a57:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a5a:	8b 7d 14             	mov    0x14(%ebp),%edi
80101a5d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a60:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a63:	0f 84 a7 00 00 00    	je     80101b10 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a6c:	8b 40 58             	mov    0x58(%eax),%eax
80101a6f:	39 f0                	cmp    %esi,%eax
80101a71:	0f 82 ba 00 00 00    	jb     80101b31 <readi+0xf1>
80101a77:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a7a:	89 f9                	mov    %edi,%ecx
80101a7c:	01 f1                	add    %esi,%ecx
80101a7e:	0f 82 ad 00 00 00    	jb     80101b31 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a84:	89 c2                	mov    %eax,%edx
80101a86:	29 f2                	sub    %esi,%edx
80101a88:	39 c8                	cmp    %ecx,%eax
80101a8a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a8d:	31 ff                	xor    %edi,%edi
80101a8f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101a91:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a94:	74 6c                	je     80101b02 <readi+0xc2>
80101a96:	8d 76 00             	lea    0x0(%esi),%esi
80101a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101aa3:	89 f2                	mov    %esi,%edx
80101aa5:	c1 ea 09             	shr    $0x9,%edx
80101aa8:	89 d8                	mov    %ebx,%eax
80101aaa:	e8 21 f9 ff ff       	call   801013d0 <bmap>
80101aaf:	83 ec 08             	sub    $0x8,%esp
80101ab2:	50                   	push   %eax
80101ab3:	ff 33                	pushl  (%ebx)
80101ab5:	e8 16 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101abd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101abf:	89 f0                	mov    %esi,%eax
80101ac1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ac6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101acb:	83 c4 0c             	add    $0xc,%esp
80101ace:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ad0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101ad4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ad7:	29 fb                	sub    %edi,%ebx
80101ad9:	39 d9                	cmp    %ebx,%ecx
80101adb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ade:	53                   	push   %ebx
80101adf:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae0:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ae2:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae5:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ae7:	e8 f4 2a 00 00       	call   801045e0 <memmove>
    brelse(bp);
80101aec:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101aef:	89 14 24             	mov    %edx,(%esp)
80101af2:	e8 e9 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101af7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101afa:	83 c4 10             	add    $0x10,%esp
80101afd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b00:	77 9e                	ja     80101aa0 <readi+0x60>
  }
  return n;
80101b02:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b05:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b08:	5b                   	pop    %ebx
80101b09:	5e                   	pop    %esi
80101b0a:	5f                   	pop    %edi
80101b0b:	5d                   	pop    %ebp
80101b0c:	c3                   	ret    
80101b0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b14:	66 83 f8 09          	cmp    $0x9,%ax
80101b18:	77 17                	ja     80101b31 <readi+0xf1>
80101b1a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101b21:	85 c0                	test   %eax,%eax
80101b23:	74 0c                	je     80101b31 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b25:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b2b:	5b                   	pop    %ebx
80101b2c:	5e                   	pop    %esi
80101b2d:	5f                   	pop    %edi
80101b2e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b2f:	ff e0                	jmp    *%eax
      return -1;
80101b31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b36:	eb cd                	jmp    80101b05 <readi+0xc5>
80101b38:	90                   	nop
80101b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b40 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	57                   	push   %edi
80101b44:	56                   	push   %esi
80101b45:	53                   	push   %ebx
80101b46:	83 ec 1c             	sub    $0x1c,%esp
80101b49:	8b 45 08             	mov    0x8(%ebp),%eax
80101b4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b4f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b57:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b5d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b60:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b63:	0f 84 b7 00 00 00    	je     80101c20 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b6f:	0f 82 eb 00 00 00    	jb     80101c60 <writei+0x120>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b75:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b78:	89 c8                	mov    %ecx,%eax
80101b7a:	01 f0                	add    %esi,%eax
80101b7c:	0f 82 de 00 00 00    	jb     80101c60 <writei+0x120>
80101b82:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b87:	0f 87 d3 00 00 00    	ja     80101c60 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b8d:	85 c9                	test   %ecx,%ecx
80101b8f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b96:	74 79                	je     80101c11 <writei+0xd1>
80101b98:	90                   	nop
80101b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ba0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ba3:	89 f2                	mov    %esi,%edx
80101ba5:	c1 ea 09             	shr    $0x9,%edx
80101ba8:	89 f8                	mov    %edi,%eax
80101baa:	e8 21 f8 ff ff       	call   801013d0 <bmap>
80101baf:	83 ec 08             	sub    $0x8,%esp
80101bb2:	50                   	push   %eax
80101bb3:	ff 37                	pushl  (%edi)
80101bb5:	e8 16 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bba:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101bbd:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bc0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc2:	89 f0                	mov    %esi,%eax
80101bc4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bc9:	83 c4 0c             	add    $0xc,%esp
80101bcc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bd1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101bd3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd7:	39 d9                	cmp    %ebx,%ecx
80101bd9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bdc:	53                   	push   %ebx
80101bdd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be0:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101be2:	50                   	push   %eax
80101be3:	e8 f8 29 00 00       	call   801045e0 <memmove>
    log_write(bp);
80101be8:	89 3c 24             	mov    %edi,(%esp)
80101beb:	e8 50 12 00 00       	call   80102e40 <log_write>
    brelse(bp);
80101bf0:	89 3c 24             	mov    %edi,(%esp)
80101bf3:	e8 e8 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bf8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bfb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bfe:	83 c4 10             	add    $0x10,%esp
80101c01:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c04:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101c07:	77 97                	ja     80101ba0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c0c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c0f:	77 37                	ja     80101c48 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c11:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c17:	5b                   	pop    %ebx
80101c18:	5e                   	pop    %esi
80101c19:	5f                   	pop    %edi
80101c1a:	5d                   	pop    %ebp
80101c1b:	c3                   	ret    
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c24:	66 83 f8 09          	cmp    $0x9,%ax
80101c28:	77 36                	ja     80101c60 <writei+0x120>
80101c2a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101c31:	85 c0                	test   %eax,%eax
80101c33:	74 2b                	je     80101c60 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101c35:	89 4d 10             	mov    %ecx,0x10(%ebp)
}
80101c38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3b:	5b                   	pop    %ebx
80101c3c:	5e                   	pop    %esi
80101c3d:	5f                   	pop    %edi
80101c3e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c3f:	ff e0                	jmp    *%eax
80101c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c48:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c4b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c4e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c51:	50                   	push   %eax
80101c52:	e8 59 fa ff ff       	call   801016b0 <iupdate>
80101c57:	83 c4 10             	add    $0x10,%esp
80101c5a:	eb b5                	jmp    80101c11 <writei+0xd1>
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c65:	eb ad                	jmp    80101c14 <writei+0xd4>
80101c67:	89 f6                	mov    %esi,%esi
80101c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c70 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c76:	6a 0e                	push   $0xe
80101c78:	ff 75 0c             	pushl  0xc(%ebp)
80101c7b:	ff 75 08             	pushl  0x8(%ebp)
80101c7e:	e8 cd 29 00 00       	call   80104650 <strncmp>
}
80101c83:	c9                   	leave  
80101c84:	c3                   	ret    
80101c85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
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
80101c96:	83 ec 1c             	sub    $0x1c,%esp
80101c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ca1:	0f 85 80 00 00 00    	jne    80101d27 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ca7:	8b 53 58             	mov    0x58(%ebx),%edx
80101caa:	31 ff                	xor    %edi,%edi
80101cac:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101caf:	85 d2                	test   %edx,%edx
80101cb1:	75 0d                	jne    80101cc0 <dirlookup+0x30>
80101cb3:	eb 5b                	jmp    80101d10 <dirlookup+0x80>
80101cb5:	8d 76 00             	lea    0x0(%esi),%esi
80101cb8:	83 c7 10             	add    $0x10,%edi
80101cbb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101cbe:	76 50                	jbe    80101d10 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101cc0:	6a 10                	push   $0x10
80101cc2:	57                   	push   %edi
80101cc3:	56                   	push   %esi
80101cc4:	53                   	push   %ebx
80101cc5:	e8 76 fd ff ff       	call   80101a40 <readi>
80101cca:	83 c4 10             	add    $0x10,%esp
80101ccd:	83 f8 10             	cmp    $0x10,%eax
80101cd0:	75 48                	jne    80101d1a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101cd2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cd7:	74 df                	je     80101cb8 <dirlookup+0x28>
  return strncmp(s, t, DIRSIZ);
80101cd9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cdc:	83 ec 04             	sub    $0x4,%esp
80101cdf:	6a 0e                	push   $0xe
80101ce1:	50                   	push   %eax
80101ce2:	ff 75 0c             	pushl  0xc(%ebp)
80101ce5:	e8 66 29 00 00       	call   80104650 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101cea:	83 c4 10             	add    $0x10,%esp
80101ced:	85 c0                	test   %eax,%eax
80101cef:	75 c7                	jne    80101cb8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101cf1:	8b 45 10             	mov    0x10(%ebp),%eax
80101cf4:	85 c0                	test   %eax,%eax
80101cf6:	74 05                	je     80101cfd <dirlookup+0x6d>
        *poff = off;
80101cf8:	8b 45 10             	mov    0x10(%ebp),%eax
80101cfb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cfd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d01:	8b 03                	mov    (%ebx),%eax
80101d03:	e8 f8 f5 ff ff       	call   80101300 <iget>
    }
  }

  return 0;
}
80101d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0b:	5b                   	pop    %ebx
80101d0c:	5e                   	pop    %esi
80101d0d:	5f                   	pop    %edi
80101d0e:	5d                   	pop    %ebp
80101d0f:	c3                   	ret    
80101d10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d13:	31 c0                	xor    %eax,%eax
}
80101d15:	5b                   	pop    %ebx
80101d16:	5e                   	pop    %esi
80101d17:	5f                   	pop    %edi
80101d18:	5d                   	pop    %ebp
80101d19:	c3                   	ret    
      panic("dirlookup read");
80101d1a:	83 ec 0c             	sub    $0xc,%esp
80101d1d:	68 f9 70 10 80       	push   $0x801070f9
80101d22:	e8 49 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d27:	83 ec 0c             	sub    $0xc,%esp
80101d2a:	68 e7 70 10 80       	push   $0x801070e7
80101d2f:	e8 3c e6 ff ff       	call   80100370 <panic>
80101d34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101d40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	89 cf                	mov    %ecx,%edi
80101d48:	89 c3                	mov    %eax,%ebx
80101d4a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d4d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d53:	0f 84 55 01 00 00    	je     80101eae <namex+0x16e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d59:	e8 22 1b 00 00       	call   80103880 <myproc>
  acquire(&icache.lock);
80101d5e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d61:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d64:	68 e0 09 11 80       	push   $0x801109e0
80101d69:	e8 c2 26 00 00       	call   80104430 <acquire>
  ip->ref++;
80101d6e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d72:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d79:	e8 62 27 00 00       	call   801044e0 <release>
80101d7e:	83 c4 10             	add    $0x10,%esp
80101d81:	eb 08                	jmp    80101d8b <namex+0x4b>
80101d83:	90                   	nop
80101d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101d88:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d8b:	0f b6 03             	movzbl (%ebx),%eax
80101d8e:	3c 2f                	cmp    $0x2f,%al
80101d90:	74 f6                	je     80101d88 <namex+0x48>
  if(*path == 0)
80101d92:	84 c0                	test   %al,%al
80101d94:	0f 84 e3 00 00 00    	je     80101e7d <namex+0x13d>
  while(*path != '/' && *path != 0)
80101d9a:	0f b6 03             	movzbl (%ebx),%eax
80101d9d:	89 da                	mov    %ebx,%edx
80101d9f:	84 c0                	test   %al,%al
80101da1:	0f 84 ac 00 00 00    	je     80101e53 <namex+0x113>
80101da7:	3c 2f                	cmp    $0x2f,%al
80101da9:	75 09                	jne    80101db4 <namex+0x74>
80101dab:	e9 a3 00 00 00       	jmp    80101e53 <namex+0x113>
80101db0:	84 c0                	test   %al,%al
80101db2:	74 0a                	je     80101dbe <namex+0x7e>
    path++;
80101db4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101db7:	0f b6 02             	movzbl (%edx),%eax
80101dba:	3c 2f                	cmp    $0x2f,%al
80101dbc:	75 f2                	jne    80101db0 <namex+0x70>
80101dbe:	89 d1                	mov    %edx,%ecx
80101dc0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101dc2:	83 f9 0d             	cmp    $0xd,%ecx
80101dc5:	0f 8e 8d 00 00 00    	jle    80101e58 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101dcb:	83 ec 04             	sub    $0x4,%esp
80101dce:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101dd1:	6a 0e                	push   $0xe
80101dd3:	53                   	push   %ebx
80101dd4:	57                   	push   %edi
80101dd5:	e8 06 28 00 00       	call   801045e0 <memmove>
    path++;
80101dda:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101ddd:	83 c4 10             	add    $0x10,%esp
    path++;
80101de0:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101de2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101de5:	75 11                	jne    80101df8 <namex+0xb8>
80101de7:	89 f6                	mov    %esi,%esi
80101de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101df0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101df3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101df6:	74 f8                	je     80101df0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101df8:	83 ec 0c             	sub    $0xc,%esp
80101dfb:	56                   	push   %esi
80101dfc:	e8 5f f9 ff ff       	call   80101760 <ilock>
    if(ip->type != T_DIR){
80101e01:	83 c4 10             	add    $0x10,%esp
80101e04:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e09:	0f 85 7f 00 00 00    	jne    80101e8e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e0f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e12:	85 d2                	test   %edx,%edx
80101e14:	74 09                	je     80101e1f <namex+0xdf>
80101e16:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e19:	0f 84 a5 00 00 00    	je     80101ec4 <namex+0x184>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e1f:	83 ec 04             	sub    $0x4,%esp
80101e22:	6a 00                	push   $0x0
80101e24:	57                   	push   %edi
80101e25:	56                   	push   %esi
80101e26:	e8 65 fe ff ff       	call   80101c90 <dirlookup>
80101e2b:	83 c4 10             	add    $0x10,%esp
80101e2e:	85 c0                	test   %eax,%eax
80101e30:	74 5c                	je     80101e8e <namex+0x14e>
  iunlock(ip);
80101e32:	83 ec 0c             	sub    $0xc,%esp
80101e35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e38:	56                   	push   %esi
80101e39:	e8 02 fa ff ff       	call   80101840 <iunlock>
  iput(ip);
80101e3e:	89 34 24             	mov    %esi,(%esp)
80101e41:	e8 4a fa ff ff       	call   80101890 <iput>
80101e46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e49:	83 c4 10             	add    $0x10,%esp
80101e4c:	89 c6                	mov    %eax,%esi
80101e4e:	e9 38 ff ff ff       	jmp    80101d8b <namex+0x4b>
  while(*path != '/' && *path != 0)
80101e53:	31 c9                	xor    %ecx,%ecx
80101e55:	8d 76 00             	lea    0x0(%esi),%esi
    memmove(name, s, len);
80101e58:	83 ec 04             	sub    $0x4,%esp
80101e5b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e5e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e61:	51                   	push   %ecx
80101e62:	53                   	push   %ebx
80101e63:	57                   	push   %edi
80101e64:	e8 77 27 00 00       	call   801045e0 <memmove>
    name[len] = 0;
80101e69:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e6c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e6f:	83 c4 10             	add    $0x10,%esp
80101e72:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e76:	89 d3                	mov    %edx,%ebx
80101e78:	e9 65 ff ff ff       	jmp    80101de2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e80:	85 c0                	test   %eax,%eax
80101e82:	75 56                	jne    80101eda <namex+0x19a>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e87:	89 f0                	mov    %esi,%eax
80101e89:	5b                   	pop    %ebx
80101e8a:	5e                   	pop    %esi
80101e8b:	5f                   	pop    %edi
80101e8c:	5d                   	pop    %ebp
80101e8d:	c3                   	ret    
  iunlock(ip);
80101e8e:	83 ec 0c             	sub    $0xc,%esp
80101e91:	56                   	push   %esi
80101e92:	e8 a9 f9 ff ff       	call   80101840 <iunlock>
  iput(ip);
80101e97:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e9a:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e9c:	e8 ef f9 ff ff       	call   80101890 <iput>
      return 0;
80101ea1:	83 c4 10             	add    $0x10,%esp
}
80101ea4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea7:	89 f0                	mov    %esi,%eax
80101ea9:	5b                   	pop    %ebx
80101eaa:	5e                   	pop    %esi
80101eab:	5f                   	pop    %edi
80101eac:	5d                   	pop    %ebp
80101ead:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101eae:	ba 01 00 00 00       	mov    $0x1,%edx
80101eb3:	b8 01 00 00 00       	mov    $0x1,%eax
80101eb8:	e8 43 f4 ff ff       	call   80101300 <iget>
80101ebd:	89 c6                	mov    %eax,%esi
80101ebf:	e9 c7 fe ff ff       	jmp    80101d8b <namex+0x4b>
      iunlock(ip);
80101ec4:	83 ec 0c             	sub    $0xc,%esp
80101ec7:	56                   	push   %esi
80101ec8:	e8 73 f9 ff ff       	call   80101840 <iunlock>
      return ip;
80101ecd:	83 c4 10             	add    $0x10,%esp
}
80101ed0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed3:	89 f0                	mov    %esi,%eax
80101ed5:	5b                   	pop    %ebx
80101ed6:	5e                   	pop    %esi
80101ed7:	5f                   	pop    %edi
80101ed8:	5d                   	pop    %ebp
80101ed9:	c3                   	ret    
    iput(ip);
80101eda:	83 ec 0c             	sub    $0xc,%esp
80101edd:	56                   	push   %esi
    return 0;
80101ede:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee0:	e8 ab f9 ff ff       	call   80101890 <iput>
    return 0;
80101ee5:	83 c4 10             	add    $0x10,%esp
80101ee8:	eb 9a                	jmp    80101e84 <namex+0x144>
80101eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
80101f02:	e8 89 fd ff ff       	call   80101c90 <dirlookup>
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
80101f23:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101f26:	76 19                	jbe    80101f41 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f28:	6a 10                	push   $0x10
80101f2a:	57                   	push   %edi
80101f2b:	56                   	push   %esi
80101f2c:	53                   	push   %ebx
80101f2d:	e8 0e fb ff ff       	call   80101a40 <readi>
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
80101f4d:	e8 5e 27 00 00       	call   801046b0 <strncpy>
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
80101f5e:	e8 dd fb ff ff       	call   80101b40 <writei>
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
80101f79:	e8 12 f9 ff ff       	call   80101890 <iput>
    return -1;
80101f7e:	83 c4 10             	add    $0x10,%esp
80101f81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f86:	eb e5                	jmp    80101f6d <dirlink+0x7d>
      panic("dirlink read");
80101f88:	83 ec 0c             	sub    $0xc,%esp
80101f8b:	68 08 71 10 80       	push   $0x80107108
80101f90:	e8 db e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101f95:	83 ec 0c             	sub    $0xc,%esp
80101f98:	68 fe 76 10 80       	push   $0x801076fe
80101f9d:	e8 ce e3 ff ff       	call   80100370 <panic>
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
80101fbe:	e8 7d fd ff ff       	call   80101d40 <namex>
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
80101fdf:	e9 5c fd ff ff       	jmp    80101d40 <namex>
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
  if(b == 0)
80101ff1:	85 c0                	test   %eax,%eax
{
80101ff3:	89 e5                	mov    %esp,%ebp
80101ff5:	56                   	push   %esi
80101ff6:	53                   	push   %ebx
  if(b == 0)
80101ff7:	0f 84 ad 00 00 00    	je     801020aa <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101ffd:	8b 58 08             	mov    0x8(%eax),%ebx
80102000:	89 c1                	mov    %eax,%ecx
80102002:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102008:	0f 87 8f 00 00 00    	ja     8010209d <idestart+0xad>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010200e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102013:	90                   	nop
80102014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102018:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102019:	83 e0 c0             	and    $0xffffffc0,%eax
8010201c:	3c 40                	cmp    $0x40,%al
8010201e:	75 f8                	jne    80102018 <idestart+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102020:	31 f6                	xor    %esi,%esi
80102022:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102027:	89 f0                	mov    %esi,%eax
80102029:	ee                   	out    %al,(%dx)
8010202a:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010202f:	b8 01 00 00 00       	mov    $0x1,%eax
80102034:	ee                   	out    %al,(%dx)
80102035:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010203a:	89 d8                	mov    %ebx,%eax
8010203c:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
8010203d:	89 d8                	mov    %ebx,%eax
8010203f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102044:	c1 f8 08             	sar    $0x8,%eax
80102047:	ee                   	out    %al,(%dx)
80102048:	ba f5 01 00 00       	mov    $0x1f5,%edx
8010204d:	89 f0                	mov    %esi,%eax
8010204f:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102050:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102054:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102059:	c1 e0 04             	shl    $0x4,%eax
8010205c:	83 e0 10             	and    $0x10,%eax
8010205f:	83 c8 e0             	or     $0xffffffe0,%eax
80102062:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102063:	f6 01 04             	testb  $0x4,(%ecx)
80102066:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206b:	75 13                	jne    80102080 <idestart+0x90>
8010206d:	b8 20 00 00 00       	mov    $0x20,%eax
80102072:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102073:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102076:	5b                   	pop    %ebx
80102077:	5e                   	pop    %esi
80102078:	5d                   	pop    %ebp
80102079:	c3                   	ret    
8010207a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102080:	b8 30 00 00 00       	mov    $0x30,%eax
80102085:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102086:	ba f0 01 00 00       	mov    $0x1f0,%edx
    outsl(0x1f0, b->data, BSIZE/4);
8010208b:	8d 71 5c             	lea    0x5c(%ecx),%esi
8010208e:	b9 80 00 00 00       	mov    $0x80,%ecx
80102093:	fc                   	cld    
80102094:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102096:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102099:	5b                   	pop    %ebx
8010209a:	5e                   	pop    %esi
8010209b:	5d                   	pop    %ebp
8010209c:	c3                   	ret    
    panic("incorrect blockno");
8010209d:	83 ec 0c             	sub    $0xc,%esp
801020a0:	68 74 71 10 80       	push   $0x80107174
801020a5:	e8 c6 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020aa:	83 ec 0c             	sub    $0xc,%esp
801020ad:	68 6b 71 10 80       	push   $0x8010716b
801020b2:	e8 b9 e2 ff ff       	call   80100370 <panic>
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020c0 <ideinit>:
{
801020c0:	55                   	push   %ebp
801020c1:	89 e5                	mov    %esp,%ebp
801020c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020c6:	68 86 71 10 80       	push   $0x80107186
801020cb:	68 80 a5 10 80       	push   $0x8010a580
801020d0:	e8 fb 21 00 00       	call   801042d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020d5:	58                   	pop    %eax
801020d6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
801020db:	5a                   	pop    %edx
801020dc:	83 e8 01             	sub    $0x1,%eax
801020df:	50                   	push   %eax
801020e0:	6a 0e                	push   $0xe
801020e2:	e8 a9 02 00 00       	call   80102390 <ioapicenable>
801020e7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ef:	90                   	nop
801020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f1:	83 e0 c0             	and    $0xffffffc0,%eax
801020f4:	3c 40                	cmp    $0x40,%al
801020f6:	75 f8                	jne    801020f0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020f8:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020fd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102102:	ee                   	out    %al,(%dx)
80102103:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102108:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010210d:	eb 06                	jmp    80102115 <ideinit+0x55>
8010210f:	90                   	nop
  for(i=0; i<1000; i++){
80102110:	83 e9 01             	sub    $0x1,%ecx
80102113:	74 0f                	je     80102124 <ideinit+0x64>
80102115:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102116:	84 c0                	test   %al,%al
80102118:	74 f6                	je     80102110 <ideinit+0x50>
      havedisk1 = 1;
8010211a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102121:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102124:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102129:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010212e:	ee                   	out    %al,(%dx)
}
8010212f:	c9                   	leave  
80102130:	c3                   	ret    
80102131:	eb 0d                	jmp    80102140 <ideintr>
80102133:	90                   	nop
80102134:	90                   	nop
80102135:	90                   	nop
80102136:	90                   	nop
80102137:	90                   	nop
80102138:	90                   	nop
80102139:	90                   	nop
8010213a:	90                   	nop
8010213b:	90                   	nop
8010213c:	90                   	nop
8010213d:	90                   	nop
8010213e:	90                   	nop
8010213f:	90                   	nop

80102140 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	57                   	push   %edi
80102144:	56                   	push   %esi
80102145:	53                   	push   %ebx
80102146:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102149:	68 80 a5 10 80       	push   $0x8010a580
8010214e:	e8 dd 22 00 00       	call   80104430 <acquire>

  if((b = idequeue) == 0){
80102153:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102159:	83 c4 10             	add    $0x10,%esp
8010215c:	85 db                	test   %ebx,%ebx
8010215e:	74 34                	je     80102194 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102160:	8b 43 58             	mov    0x58(%ebx),%eax
80102163:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102168:	8b 33                	mov    (%ebx),%esi
8010216a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102170:	74 3e                	je     801021b0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102172:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102175:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102178:	83 ce 02             	or     $0x2,%esi
8010217b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010217d:	53                   	push   %ebx
8010217e:	e8 6d 1e 00 00       	call   80103ff0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102183:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102188:	83 c4 10             	add    $0x10,%esp
8010218b:	85 c0                	test   %eax,%eax
8010218d:	74 05                	je     80102194 <ideintr+0x54>
    idestart(idequeue);
8010218f:	e8 5c fe ff ff       	call   80101ff0 <idestart>
    release(&idelock);
80102194:	83 ec 0c             	sub    $0xc,%esp
80102197:	68 80 a5 10 80       	push   $0x8010a580
8010219c:	e8 3f 23 00 00       	call   801044e0 <release>

  release(&idelock);
}
801021a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021a4:	5b                   	pop    %ebx
801021a5:	5e                   	pop    %esi
801021a6:	5f                   	pop    %edi
801021a7:	5d                   	pop    %ebp
801021a8:	c3                   	ret    
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021b0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021b5:	8d 76 00             	lea    0x0(%esi),%esi
801021b8:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021b9:	89 c1                	mov    %eax,%ecx
801021bb:	83 e1 c0             	and    $0xffffffc0,%ecx
801021be:	80 f9 40             	cmp    $0x40,%cl
801021c1:	75 f5                	jne    801021b8 <ideintr+0x78>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021c3:	a8 21                	test   $0x21,%al
801021c5:	75 ab                	jne    80102172 <ideintr+0x32>
    insl(0x1f0, b->data, BSIZE/4);
801021c7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021ca:	b9 80 00 00 00       	mov    $0x80,%ecx
801021cf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021d4:	fc                   	cld    
801021d5:	f3 6d                	rep insl (%dx),%es:(%edi)
801021d7:	8b 33                	mov    (%ebx),%esi
801021d9:	eb 97                	jmp    80102172 <ideintr+0x32>
801021db:	90                   	nop
801021dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801021e0:	55                   	push   %ebp
801021e1:	89 e5                	mov    %esp,%ebp
801021e3:	53                   	push   %ebx
801021e4:	83 ec 10             	sub    $0x10,%esp
801021e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801021ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801021ed:	50                   	push   %eax
801021ee:	e8 8d 20 00 00       	call   80104280 <holdingsleep>
801021f3:	83 c4 10             	add    $0x10,%esp
801021f6:	85 c0                	test   %eax,%eax
801021f8:	0f 84 ad 00 00 00    	je     801022ab <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801021fe:	8b 03                	mov    (%ebx),%eax
80102200:	83 e0 06             	and    $0x6,%eax
80102203:	83 f8 02             	cmp    $0x2,%eax
80102206:	0f 84 b9 00 00 00    	je     801022c5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010220c:	8b 53 04             	mov    0x4(%ebx),%edx
8010220f:	85 d2                	test   %edx,%edx
80102211:	74 0d                	je     80102220 <iderw+0x40>
80102213:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102218:	85 c0                	test   %eax,%eax
8010221a:	0f 84 98 00 00 00    	je     801022b8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102220:	83 ec 0c             	sub    $0xc,%esp
80102223:	68 80 a5 10 80       	push   $0x8010a580
80102228:	e8 03 22 00 00       	call   80104430 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010222d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102233:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102236:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010223d:	85 d2                	test   %edx,%edx
8010223f:	75 09                	jne    8010224a <iderw+0x6a>
80102241:	eb 58                	jmp    8010229b <iderw+0xbb>
80102243:	90                   	nop
80102244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102248:	89 c2                	mov    %eax,%edx
8010224a:	8b 42 58             	mov    0x58(%edx),%eax
8010224d:	85 c0                	test   %eax,%eax
8010224f:	75 f7                	jne    80102248 <iderw+0x68>
80102251:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102254:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102256:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010225c:	74 44                	je     801022a2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010225e:	8b 03                	mov    (%ebx),%eax
80102260:	83 e0 06             	and    $0x6,%eax
80102263:	83 f8 02             	cmp    $0x2,%eax
80102266:	74 23                	je     8010228b <iderw+0xab>
80102268:	90                   	nop
80102269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102270:	83 ec 08             	sub    $0x8,%esp
80102273:	68 80 a5 10 80       	push   $0x8010a580
80102278:	53                   	push   %ebx
80102279:	e8 b2 1b 00 00       	call   80103e30 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010227e:	8b 03                	mov    (%ebx),%eax
80102280:	83 c4 10             	add    $0x10,%esp
80102283:	83 e0 06             	and    $0x6,%eax
80102286:	83 f8 02             	cmp    $0x2,%eax
80102289:	75 e5                	jne    80102270 <iderw+0x90>
  }


  release(&idelock);
8010228b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102292:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102295:	c9                   	leave  
  release(&idelock);
80102296:	e9 45 22 00 00       	jmp    801044e0 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010229b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801022a0:	eb b2                	jmp    80102254 <iderw+0x74>
    idestart(b);
801022a2:	89 d8                	mov    %ebx,%eax
801022a4:	e8 47 fd ff ff       	call   80101ff0 <idestart>
801022a9:	eb b3                	jmp    8010225e <iderw+0x7e>
    panic("iderw: buf not locked");
801022ab:	83 ec 0c             	sub    $0xc,%esp
801022ae:	68 8a 71 10 80       	push   $0x8010718a
801022b3:	e8 b8 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022b8:	83 ec 0c             	sub    $0xc,%esp
801022bb:	68 b5 71 10 80       	push   $0x801071b5
801022c0:	e8 ab e0 ff ff       	call   80100370 <panic>
    panic("iderw: nothing to do");
801022c5:	83 ec 0c             	sub    $0xc,%esp
801022c8:	68 a0 71 10 80       	push   $0x801071a0
801022cd:	e8 9e e0 ff ff       	call   80100370 <panic>
801022d2:	66 90                	xchg   %ax,%ax
801022d4:	66 90                	xchg   %ax,%ax
801022d6:	66 90                	xchg   %ax,%ax
801022d8:	66 90                	xchg   %ax,%ax
801022da:	66 90                	xchg   %ax,%ax
801022dc:	66 90                	xchg   %ax,%ax
801022de:	66 90                	xchg   %ax,%ax

801022e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022e0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022e1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801022e8:	00 c0 fe 
{
801022eb:	89 e5                	mov    %esp,%ebp
801022ed:	56                   	push   %esi
801022ee:	53                   	push   %ebx
  ioapic->reg = reg;
801022ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801022f6:	00 00 00 
  return ioapic->data;
801022f9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801022ff:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102302:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102308:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010230e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102315:	c1 ee 10             	shr    $0x10,%esi
80102318:	89 f0                	mov    %esi,%eax
8010231a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010231d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102320:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102323:	39 d0                	cmp    %edx,%eax
80102325:	74 16                	je     8010233d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102327:	83 ec 0c             	sub    $0xc,%esp
8010232a:	68 d4 71 10 80       	push   $0x801071d4
8010232f:	e8 0c e4 ff ff       	call   80100740 <cprintf>
80102334:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010233a:	83 c4 10             	add    $0x10,%esp
8010233d:	83 c6 21             	add    $0x21,%esi
{
80102340:	ba 10 00 00 00       	mov    $0x10,%edx
80102345:	b8 20 00 00 00       	mov    $0x20,%eax
8010234a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102350:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102352:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102358:	89 c3                	mov    %eax,%ebx
8010235a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102360:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102363:	89 59 10             	mov    %ebx,0x10(%ecx)
80102366:	8d 5a 01             	lea    0x1(%edx),%ebx
80102369:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010236c:	39 f0                	cmp    %esi,%eax
  ioapic->reg = reg;
8010236e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102370:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102376:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010237d:	75 d1                	jne    80102350 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010237f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102382:	5b                   	pop    %ebx
80102383:	5e                   	pop    %esi
80102384:	5d                   	pop    %ebp
80102385:	c3                   	ret    
80102386:	8d 76 00             	lea    0x0(%esi),%esi
80102389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102390 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102390:	55                   	push   %ebp
  ioapic->reg = reg;
80102391:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102397:	89 e5                	mov    %esp,%ebp
80102399:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010239c:	8d 50 20             	lea    0x20(%eax),%edx
8010239f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023a5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023ae:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023b4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023b6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023be:	89 50 10             	mov    %edx,0x10(%eax)
}
801023c1:	5d                   	pop    %ebp
801023c2:	c3                   	ret    
801023c3:	66 90                	xchg   %ax,%ax
801023c5:	66 90                	xchg   %ax,%ax
801023c7:	66 90                	xchg   %ax,%ax
801023c9:	66 90                	xchg   %ax,%ax
801023cb:	66 90                	xchg   %ax,%ax
801023cd:	66 90                	xchg   %ax,%ax
801023cf:	90                   	nop

801023d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	53                   	push   %ebx
801023d4:	83 ec 04             	sub    $0x4,%esp
801023d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023e0:	75 70                	jne    80102452 <kfree+0x82>
801023e2:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
801023e8:	72 68                	jb     80102452 <kfree+0x82>
801023ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801023f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801023f5:	77 5b                	ja     80102452 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801023f7:	83 ec 04             	sub    $0x4,%esp
801023fa:	68 00 10 00 00       	push   $0x1000
801023ff:	6a 01                	push   $0x1
80102401:	53                   	push   %ebx
80102402:	e8 29 21 00 00       	call   80104530 <memset>

  if(kmem.use_lock)
80102407:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	85 d2                	test   %edx,%edx
80102412:	75 2c                	jne    80102440 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102414:	a1 78 26 11 80       	mov    0x80112678,%eax
80102419:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010241b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102420:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102426:	85 c0                	test   %eax,%eax
80102428:	75 06                	jne    80102430 <kfree+0x60>
    release(&kmem.lock);
}
8010242a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010242d:	c9                   	leave  
8010242e:	c3                   	ret    
8010242f:	90                   	nop
    release(&kmem.lock);
80102430:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102437:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010243a:	c9                   	leave  
    release(&kmem.lock);
8010243b:	e9 a0 20 00 00       	jmp    801044e0 <release>
    acquire(&kmem.lock);
80102440:	83 ec 0c             	sub    $0xc,%esp
80102443:	68 40 26 11 80       	push   $0x80112640
80102448:	e8 e3 1f 00 00       	call   80104430 <acquire>
8010244d:	83 c4 10             	add    $0x10,%esp
80102450:	eb c2                	jmp    80102414 <kfree+0x44>
    panic("kfree");
80102452:	83 ec 0c             	sub    $0xc,%esp
80102455:	68 06 72 10 80       	push   $0x80107206
8010245a:	e8 11 df ff ff       	call   80100370 <panic>
8010245f:	90                   	nop

80102460 <freerange>:
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102465:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102468:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010246b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102471:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102477:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010247d:	39 de                	cmp    %ebx,%esi
8010247f:	72 23                	jb     801024a4 <freerange+0x44>
80102481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102488:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010248e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102491:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102497:	50                   	push   %eax
80102498:	e8 33 ff ff ff       	call   801023d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249d:	83 c4 10             	add    $0x10,%esp
801024a0:	39 f3                	cmp    %esi,%ebx
801024a2:	76 e4                	jbe    80102488 <freerange+0x28>
}
801024a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024a7:	5b                   	pop    %ebx
801024a8:	5e                   	pop    %esi
801024a9:	5d                   	pop    %ebp
801024aa:	c3                   	ret    
801024ab:	90                   	nop
801024ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024b0 <kinit1>:
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	56                   	push   %esi
801024b4:	53                   	push   %ebx
801024b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024b8:	83 ec 08             	sub    $0x8,%esp
801024bb:	68 0c 72 10 80       	push   $0x8010720c
801024c0:	68 40 26 11 80       	push   $0x80112640
801024c5:	e8 06 1e 00 00       	call   801042d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024cd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801024d0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801024d7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801024da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ec:	39 de                	cmp    %ebx,%esi
801024ee:	72 1c                	jb     8010250c <kinit1+0x5c>
    kfree(p);
801024f0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024f6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024ff:	50                   	push   %eax
80102500:	e8 cb fe ff ff       	call   801023d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102505:	83 c4 10             	add    $0x10,%esp
80102508:	39 de                	cmp    %ebx,%esi
8010250a:	73 e4                	jae    801024f0 <kinit1+0x40>
}
8010250c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010250f:	5b                   	pop    %ebx
80102510:	5e                   	pop    %esi
80102511:	5d                   	pop    %ebp
80102512:	c3                   	ret    
80102513:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102520 <kinit2>:
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	56                   	push   %esi
80102524:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102525:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102528:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010252b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102531:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102537:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010253d:	39 de                	cmp    %ebx,%esi
8010253f:	72 23                	jb     80102564 <kinit2+0x44>
80102541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102548:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010254e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102551:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102557:	50                   	push   %eax
80102558:	e8 73 fe ff ff       	call   801023d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010255d:	83 c4 10             	add    $0x10,%esp
80102560:	39 de                	cmp    %ebx,%esi
80102562:	73 e4                	jae    80102548 <kinit2+0x28>
  kmem.use_lock = 1;
80102564:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010256b:	00 00 00 
}
8010256e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102571:	5b                   	pop    %ebx
80102572:	5e                   	pop    %esi
80102573:	5d                   	pop    %ebp
80102574:	c3                   	ret    
80102575:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102580 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	53                   	push   %ebx
80102584:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102587:	a1 74 26 11 80       	mov    0x80112674,%eax
8010258c:	85 c0                	test   %eax,%eax
8010258e:	75 30                	jne    801025c0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102590:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102596:	85 db                	test   %ebx,%ebx
80102598:	74 1c                	je     801025b6 <kalloc+0x36>
    kmem.freelist = r->next;
8010259a:	8b 13                	mov    (%ebx),%edx
8010259c:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801025a2:	85 c0                	test   %eax,%eax
801025a4:	74 10                	je     801025b6 <kalloc+0x36>
    release(&kmem.lock);
801025a6:	83 ec 0c             	sub    $0xc,%esp
801025a9:	68 40 26 11 80       	push   $0x80112640
801025ae:	e8 2d 1f 00 00       	call   801044e0 <release>
801025b3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801025b6:	89 d8                	mov    %ebx,%eax
801025b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025bb:	c9                   	leave  
801025bc:	c3                   	ret    
801025bd:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801025c0:	83 ec 0c             	sub    $0xc,%esp
801025c3:	68 40 26 11 80       	push   $0x80112640
801025c8:	e8 63 1e 00 00       	call   80104430 <acquire>
  r = kmem.freelist;
801025cd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801025d3:	83 c4 10             	add    $0x10,%esp
801025d6:	a1 74 26 11 80       	mov    0x80112674,%eax
801025db:	85 db                	test   %ebx,%ebx
801025dd:	75 bb                	jne    8010259a <kalloc+0x1a>
801025df:	eb c1                	jmp    801025a2 <kalloc+0x22>
801025e1:	66 90                	xchg   %ax,%ax
801025e3:	66 90                	xchg   %ax,%ax
801025e5:	66 90                	xchg   %ax,%ax
801025e7:	66 90                	xchg   %ax,%ax
801025e9:	66 90                	xchg   %ax,%ax
801025eb:	66 90                	xchg   %ax,%ax
801025ed:	66 90                	xchg   %ax,%ax
801025ef:	90                   	nop

801025f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025f0:	ba 64 00 00 00       	mov    $0x64,%edx
801025f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801025f6:	a8 01                	test   $0x1,%al
801025f8:	0f 84 c2 00 00 00    	je     801026c0 <kbdgetc+0xd0>
801025fe:	ba 60 00 00 00       	mov    $0x60,%edx
80102603:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102604:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102607:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
8010260d:	0f 84 9d 00 00 00    	je     801026b0 <kbdgetc+0xc0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102613:	84 c0                	test   %al,%al
80102615:	78 59                	js     80102670 <kbdgetc+0x80>
{
80102617:	55                   	push   %ebp
80102618:	89 e5                	mov    %esp,%ebp
8010261a:	53                   	push   %ebx
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010261b:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
80102621:	f6 c3 40             	test   $0x40,%bl
80102624:	74 09                	je     8010262f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102626:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102629:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
8010262c:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
8010262f:	0f b6 8a 40 73 10 80 	movzbl -0x7fef8cc0(%edx),%ecx
  shift ^= togglecode[data];
80102636:	0f b6 82 40 72 10 80 	movzbl -0x7fef8dc0(%edx),%eax
  shift |= shiftcode[data];
8010263d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010263f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102641:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102643:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102649:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010264c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010264f:	8b 04 85 20 72 10 80 	mov    -0x7fef8de0(,%eax,4),%eax
80102656:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010265a:	74 0b                	je     80102667 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010265c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010265f:	83 fa 19             	cmp    $0x19,%edx
80102662:	77 3c                	ja     801026a0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102664:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102667:	5b                   	pop    %ebx
80102668:	5d                   	pop    %ebp
80102669:	c3                   	ret    
8010266a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    data = (shift & E0ESC ? data : data & 0x7F);
80102670:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
80102676:	83 e0 7f             	and    $0x7f,%eax
80102679:	f6 c1 40             	test   $0x40,%cl
8010267c:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
8010267f:	0f b6 82 40 73 10 80 	movzbl -0x7fef8cc0(%edx),%eax
80102686:	83 c8 40             	or     $0x40,%eax
80102689:	0f b6 c0             	movzbl %al,%eax
8010268c:	f7 d0                	not    %eax
8010268e:	21 c8                	and    %ecx,%eax
80102690:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
80102695:	31 c0                	xor    %eax,%eax
80102697:	c3                   	ret    
80102698:	90                   	nop
80102699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026a0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026a3:	8d 50 20             	lea    0x20(%eax),%edx
}
801026a6:	5b                   	pop    %ebx
      c += 'a' - 'A';
801026a7:	83 f9 19             	cmp    $0x19,%ecx
801026aa:	0f 46 c2             	cmovbe %edx,%eax
}
801026ad:	5d                   	pop    %ebp
801026ae:	c3                   	ret    
801026af:	90                   	nop
    shift |= E0ESC;
801026b0:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801026b7:	31 c0                	xor    %eax,%eax
801026b9:	c3                   	ret    
801026ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801026c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801026c5:	c3                   	ret    
801026c6:	8d 76 00             	lea    0x0(%esi),%esi
801026c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026d0 <kbdintr>:

void
kbdintr(void)
{
801026d0:	55                   	push   %ebp
801026d1:	89 e5                	mov    %esp,%ebp
801026d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026d6:	68 f0 25 10 80       	push   $0x801025f0
801026db:	e8 e0 e1 ff ff       	call   801008c0 <consoleintr>
}
801026e0:	83 c4 10             	add    $0x10,%esp
801026e3:	c9                   	leave  
801026e4:	c3                   	ret    
801026e5:	66 90                	xchg   %ax,%ax
801026e7:	66 90                	xchg   %ax,%ax
801026e9:	66 90                	xchg   %ax,%ax
801026eb:	66 90                	xchg   %ax,%ax
801026ed:	66 90                	xchg   %ax,%ax
801026ef:	90                   	nop

801026f0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801026f0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
801026f5:	55                   	push   %ebp
801026f6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801026f8:	85 c0                	test   %eax,%eax
801026fa:	0f 84 c8 00 00 00    	je     801027c8 <lapicinit+0xd8>
  lapic[index] = value;
80102700:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102707:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010270a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010270d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102714:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102717:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010271a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102721:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102724:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102727:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010272e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102731:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102734:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010273b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102741:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102748:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010274b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010274e:	8b 50 30             	mov    0x30(%eax),%edx
80102751:	c1 ea 10             	shr    $0x10,%edx
80102754:	80 fa 03             	cmp    $0x3,%dl
80102757:	77 77                	ja     801027d0 <lapicinit+0xe0>
  lapic[index] = value;
80102759:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102760:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102763:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102766:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010276d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102770:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102773:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010277a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010277d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102780:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102787:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010278a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010278d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102794:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102797:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010279a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027a1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027a4:	8b 50 20             	mov    0x20(%eax),%edx
801027a7:	89 f6                	mov    %esi,%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027b6:	80 e6 10             	and    $0x10,%dh
801027b9:	75 f5                	jne    801027b0 <lapicinit+0xc0>
  lapic[index] = value;
801027bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027c8:	5d                   	pop    %ebp
801027c9:	c3                   	ret    
801027ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801027d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027da:	8b 50 20             	mov    0x20(%eax),%edx
801027dd:	e9 77 ff ff ff       	jmp    80102759 <lapicinit+0x69>
801027e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027f0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801027f0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
801027f5:	55                   	push   %ebp
801027f6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801027f8:	85 c0                	test   %eax,%eax
801027fa:	74 0c                	je     80102808 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801027fc:	8b 40 20             	mov    0x20(%eax),%eax
}
801027ff:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
80102800:	c1 e8 18             	shr    $0x18,%eax
}
80102803:	c3                   	ret    
80102804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102808:	31 c0                	xor    %eax,%eax
8010280a:	5d                   	pop    %ebp
8010280b:	c3                   	ret    
8010280c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102810 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102810:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102815:	55                   	push   %ebp
80102816:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102818:	85 c0                	test   %eax,%eax
8010281a:	74 0d                	je     80102829 <lapiceoi+0x19>
  lapic[index] = value;
8010281c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102823:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102826:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102829:	5d                   	pop    %ebp
8010282a:	c3                   	ret    
8010282b:	90                   	nop
8010282c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102830 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102830:	55                   	push   %ebp
80102831:	89 e5                	mov    %esp,%ebp
}
80102833:	5d                   	pop    %ebp
80102834:	c3                   	ret    
80102835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102840 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102840:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102841:	ba 70 00 00 00       	mov    $0x70,%edx
80102846:	b8 0f 00 00 00       	mov    $0xf,%eax
8010284b:	89 e5                	mov    %esp,%ebp
8010284d:	53                   	push   %ebx
8010284e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102851:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102854:	ee                   	out    %al,(%dx)
80102855:	ba 71 00 00 00       	mov    $0x71,%edx
8010285a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010285f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102860:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102862:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102865:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010286b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010286d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102870:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102873:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102875:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102878:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010287e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102883:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102889:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010288c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102893:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102896:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102899:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028ca:	5b                   	pop    %ebx
801028cb:	5d                   	pop    %ebp
801028cc:	c3                   	ret    
801028cd:	8d 76 00             	lea    0x0(%esi),%esi

801028d0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028d0:	55                   	push   %ebp
801028d1:	ba 70 00 00 00       	mov    $0x70,%edx
801028d6:	b8 0b 00 00 00       	mov    $0xb,%eax
801028db:	89 e5                	mov    %esp,%ebp
801028dd:	57                   	push   %edi
801028de:	56                   	push   %esi
801028df:	53                   	push   %ebx
801028e0:	83 ec 5c             	sub    $0x5c,%esp
801028e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e4:	ba 71 00 00 00       	mov    $0x71,%edx
801028e9:	ec                   	in     (%dx),%al
801028ea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ed:	bb 70 00 00 00       	mov    $0x70,%ebx
801028f2:	88 45 a7             	mov    %al,-0x59(%ebp)
801028f5:	8d 76 00             	lea    0x0(%esi),%esi
801028f8:	31 c0                	xor    %eax,%eax
801028fa:	89 da                	mov    %ebx,%edx
801028fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102902:	89 ca                	mov    %ecx,%edx
80102904:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102905:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102908:	89 da                	mov    %ebx,%edx
8010290a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010290d:	b8 02 00 00 00       	mov    $0x2,%eax
80102912:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102913:	89 ca                	mov    %ecx,%edx
80102915:	ec                   	in     (%dx),%al
80102916:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102919:	89 da                	mov    %ebx,%edx
8010291b:	b8 04 00 00 00       	mov    $0x4,%eax
80102920:	89 75 b0             	mov    %esi,-0x50(%ebp)
80102923:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102924:	89 ca                	mov    %ecx,%edx
80102926:	ec                   	in     (%dx),%al
80102927:	0f b6 f8             	movzbl %al,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010292a:	89 da                	mov    %ebx,%edx
8010292c:	b8 07 00 00 00       	mov    $0x7,%eax
80102931:	89 7d ac             	mov    %edi,-0x54(%ebp)
80102934:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102935:	89 ca                	mov    %ecx,%edx
80102937:	ec                   	in     (%dx),%al
80102938:	0f b6 d0             	movzbl %al,%edx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010293b:	b8 08 00 00 00       	mov    $0x8,%eax
80102940:	89 55 a8             	mov    %edx,-0x58(%ebp)
80102943:	89 da                	mov    %ebx,%edx
80102945:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102946:	89 ca                	mov    %ecx,%edx
80102948:	ec                   	in     (%dx),%al
80102949:	0f b6 f8             	movzbl %al,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010294c:	89 da                	mov    %ebx,%edx
8010294e:	b8 09 00 00 00       	mov    $0x9,%eax
80102953:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102954:	89 ca                	mov    %ecx,%edx
80102956:	ec                   	in     (%dx),%al
80102957:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295a:	89 da                	mov    %ebx,%edx
8010295c:	b8 0a 00 00 00       	mov    $0xa,%eax
80102961:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102962:	89 ca                	mov    %ecx,%edx
80102964:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102965:	84 c0                	test   %al,%al
80102967:	78 8f                	js     801028f8 <cmostime+0x28>
80102969:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010296c:	8b 55 a8             	mov    -0x58(%ebp),%edx
8010296f:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102972:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102975:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102978:	8b 45 b0             	mov    -0x50(%ebp),%eax
8010297b:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297e:	89 da                	mov    %ebx,%edx
80102980:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102983:	8b 45 ac             	mov    -0x54(%ebp),%eax
80102986:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102989:	31 c0                	xor    %eax,%eax
8010298b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298c:	89 ca                	mov    %ecx,%edx
8010298e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
8010298f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102992:	89 da                	mov    %ebx,%edx
80102994:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102997:	b8 02 00 00 00       	mov    $0x2,%eax
8010299c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299d:	89 ca                	mov    %ecx,%edx
8010299f:	ec                   	in     (%dx),%al
801029a0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a3:	89 da                	mov    %ebx,%edx
801029a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029a8:	b8 04 00 00 00       	mov    $0x4,%eax
801029ad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ae:	89 ca                	mov    %ecx,%edx
801029b0:	ec                   	in     (%dx),%al
801029b1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b4:	89 da                	mov    %ebx,%edx
801029b6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029b9:	b8 07 00 00 00       	mov    $0x7,%eax
801029be:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bf:	89 ca                	mov    %ecx,%edx
801029c1:	ec                   	in     (%dx),%al
801029c2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c5:	89 da                	mov    %ebx,%edx
801029c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029ca:	b8 08 00 00 00       	mov    $0x8,%eax
801029cf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d0:	89 ca                	mov    %ecx,%edx
801029d2:	ec                   	in     (%dx),%al
801029d3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d6:	89 da                	mov    %ebx,%edx
801029d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029db:	b8 09 00 00 00       	mov    $0x9,%eax
801029e0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e1:	89 ca                	mov    %ecx,%edx
801029e3:	ec                   	in     (%dx),%al
801029e4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029e7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801029ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029ed:	8d 45 d0             	lea    -0x30(%ebp),%eax
801029f0:	6a 18                	push   $0x18
801029f2:	50                   	push   %eax
801029f3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801029f6:	50                   	push   %eax
801029f7:	e8 84 1b 00 00       	call   80104580 <memcmp>
801029fc:	83 c4 10             	add    $0x10,%esp
801029ff:	85 c0                	test   %eax,%eax
80102a01:	0f 85 f1 fe ff ff    	jne    801028f8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a07:	80 7d a7 00          	cmpb   $0x0,-0x59(%ebp)
80102a0b:	75 78                	jne    80102a85 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a0d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a10:	89 c2                	mov    %eax,%edx
80102a12:	83 e0 0f             	and    $0xf,%eax
80102a15:	c1 ea 04             	shr    $0x4,%edx
80102a18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a21:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a24:	89 c2                	mov    %eax,%edx
80102a26:	83 e0 0f             	and    $0xf,%eax
80102a29:	c1 ea 04             	shr    $0x4,%edx
80102a2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a32:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a35:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a38:	89 c2                	mov    %eax,%edx
80102a3a:	83 e0 0f             	and    $0xf,%eax
80102a3d:	c1 ea 04             	shr    $0x4,%edx
80102a40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a43:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a46:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a4c:	89 c2                	mov    %eax,%edx
80102a4e:	83 e0 0f             	and    $0xf,%eax
80102a51:	c1 ea 04             	shr    $0x4,%edx
80102a54:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a57:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a60:	89 c2                	mov    %eax,%edx
80102a62:	83 e0 0f             	and    $0xf,%eax
80102a65:	c1 ea 04             	shr    $0x4,%edx
80102a68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a71:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a74:	89 c2                	mov    %eax,%edx
80102a76:	83 e0 0f             	and    $0xf,%eax
80102a79:	c1 ea 04             	shr    $0x4,%edx
80102a7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a82:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a85:	8b 75 08             	mov    0x8(%ebp),%esi
80102a88:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a8b:	89 06                	mov    %eax,(%esi)
80102a8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a90:	89 46 04             	mov    %eax,0x4(%esi)
80102a93:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a96:	89 46 08             	mov    %eax,0x8(%esi)
80102a99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a9c:	89 46 0c             	mov    %eax,0xc(%esi)
80102a9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102aa2:	89 46 10             	mov    %eax,0x10(%esi)
80102aa5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102aa8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102aab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ab2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ab5:	5b                   	pop    %ebx
80102ab6:	5e                   	pop    %esi
80102ab7:	5f                   	pop    %edi
80102ab8:	5d                   	pop    %ebp
80102ab9:	c3                   	ret    
80102aba:	66 90                	xchg   %ax,%ax
80102abc:	66 90                	xchg   %ax,%ax
80102abe:	66 90                	xchg   %ax,%ax

80102ac0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ac0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102ac6:	85 c9                	test   %ecx,%ecx
80102ac8:	0f 8e 85 00 00 00    	jle    80102b53 <install_trans+0x93>
{
80102ace:	55                   	push   %ebp
80102acf:	89 e5                	mov    %esp,%ebp
80102ad1:	57                   	push   %edi
80102ad2:	56                   	push   %esi
80102ad3:	53                   	push   %ebx
80102ad4:	31 db                	xor    %ebx,%ebx
80102ad6:	83 ec 0c             	sub    $0xc,%esp
80102ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ae0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102ae5:	83 ec 08             	sub    $0x8,%esp
80102ae8:	01 d8                	add    %ebx,%eax
80102aea:	83 c0 01             	add    $0x1,%eax
80102aed:	50                   	push   %eax
80102aee:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102af4:	e8 d7 d5 ff ff       	call   801000d0 <bread>
80102af9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102afb:	58                   	pop    %eax
80102afc:	5a                   	pop    %edx
80102afd:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102b04:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b0a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0d:	e8 be d5 ff ff       	call   801000d0 <bread>
80102b12:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b14:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b17:	83 c4 0c             	add    $0xc,%esp
80102b1a:	68 00 02 00 00       	push   $0x200
80102b1f:	50                   	push   %eax
80102b20:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b23:	50                   	push   %eax
80102b24:	e8 b7 1a 00 00       	call   801045e0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b29:	89 34 24             	mov    %esi,(%esp)
80102b2c:	e8 6f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b31:	89 3c 24             	mov    %edi,(%esp)
80102b34:	e8 a7 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b39:	89 34 24             	mov    %esi,(%esp)
80102b3c:	e8 9f d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b41:	83 c4 10             	add    $0x10,%esp
80102b44:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102b4a:	7f 94                	jg     80102ae0 <install_trans+0x20>
  }
}
80102b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b4f:	5b                   	pop    %ebx
80102b50:	5e                   	pop    %esi
80102b51:	5f                   	pop    %edi
80102b52:	5d                   	pop    %ebp
80102b53:	f3 c3                	repz ret 
80102b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
80102b63:	53                   	push   %ebx
80102b64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b67:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102b6d:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b73:	e8 58 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b78:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b7e:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b81:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b83:	85 c9                	test   %ecx,%ecx
  hb->n = log.lh.n;
80102b85:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b88:	7e 1f                	jle    80102ba9 <write_head+0x49>
80102b8a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102b91:	31 d2                	xor    %edx,%edx
80102b93:	90                   	nop
80102b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102b98:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102b9e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102ba2:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102ba5:	39 c2                	cmp    %eax,%edx
80102ba7:	75 ef                	jne    80102b98 <write_head+0x38>
  }
  bwrite(buf);
80102ba9:	83 ec 0c             	sub    $0xc,%esp
80102bac:	53                   	push   %ebx
80102bad:	e8 ee d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bb2:	89 1c 24             	mov    %ebx,(%esp)
80102bb5:	e8 26 d6 ff ff       	call   801001e0 <brelse>
}
80102bba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bbd:	c9                   	leave  
80102bbe:	c3                   	ret    
80102bbf:	90                   	nop

80102bc0 <initlog>:
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	53                   	push   %ebx
80102bc4:	83 ec 2c             	sub    $0x2c,%esp
80102bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bca:	68 40 74 10 80       	push   $0x80107440
80102bcf:	68 80 26 11 80       	push   $0x80112680
80102bd4:	e8 f7 16 00 00       	call   801042d0 <initlock>
  readsb(dev, &sb);
80102bd9:	58                   	pop    %eax
80102bda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bdd:	5a                   	pop    %edx
80102bde:	50                   	push   %eax
80102bdf:	53                   	push   %ebx
80102be0:	e8 bb e8 ff ff       	call   801014a0 <readsb>
  log.size = sb.nlog;
80102be5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102be8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102beb:	59                   	pop    %ecx
  log.dev = dev;
80102bec:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102bf2:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102bf8:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102bfd:	5a                   	pop    %edx
80102bfe:	50                   	push   %eax
80102bff:	53                   	push   %ebx
80102c00:	e8 cb d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c05:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c08:	83 c4 10             	add    $0x10,%esp
80102c0b:	85 c9                	test   %ecx,%ecx
  log.lh.n = lh->n;
80102c0d:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102c13:	7e 1c                	jle    80102c31 <initlog+0x71>
80102c15:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102c1c:	31 d2                	xor    %edx,%edx
80102c1e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c20:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c24:	83 c2 04             	add    $0x4,%edx
80102c27:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c2d:	39 da                	cmp    %ebx,%edx
80102c2f:	75 ef                	jne    80102c20 <initlog+0x60>
  brelse(buf);
80102c31:	83 ec 0c             	sub    $0xc,%esp
80102c34:	50                   	push   %eax
80102c35:	e8 a6 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c3a:	e8 81 fe ff ff       	call   80102ac0 <install_trans>
  log.lh.n = 0;
80102c3f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c46:	00 00 00 
  write_head(); // clear the log
80102c49:	e8 12 ff ff ff       	call   80102b60 <write_head>
}
80102c4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c51:	c9                   	leave  
80102c52:	c3                   	ret    
80102c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c66:	68 80 26 11 80       	push   $0x80112680
80102c6b:	e8 c0 17 00 00       	call   80104430 <acquire>
80102c70:	83 c4 10             	add    $0x10,%esp
80102c73:	eb 18                	jmp    80102c8d <begin_op+0x2d>
80102c75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c78:	83 ec 08             	sub    $0x8,%esp
80102c7b:	68 80 26 11 80       	push   $0x80112680
80102c80:	68 80 26 11 80       	push   $0x80112680
80102c85:	e8 a6 11 00 00       	call   80103e30 <sleep>
80102c8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102c8d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102c92:	85 c0                	test   %eax,%eax
80102c94:	75 e2                	jne    80102c78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c96:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102c9b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102ca1:	83 c0 01             	add    $0x1,%eax
80102ca4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ca7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102caa:	83 fa 1e             	cmp    $0x1e,%edx
80102cad:	7f c9                	jg     80102c78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102caf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cb2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102cb7:	68 80 26 11 80       	push   $0x80112680
80102cbc:	e8 1f 18 00 00       	call   801044e0 <release>
      break;
    }
  }
}
80102cc1:	83 c4 10             	add    $0x10,%esp
80102cc4:	c9                   	leave  
80102cc5:	c3                   	ret    
80102cc6:	8d 76 00             	lea    0x0(%esi),%esi
80102cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cd0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cd0:	55                   	push   %ebp
80102cd1:	89 e5                	mov    %esp,%ebp
80102cd3:	57                   	push   %edi
80102cd4:	56                   	push   %esi
80102cd5:	53                   	push   %ebx
80102cd6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cd9:	68 80 26 11 80       	push   $0x80112680
80102cde:	e8 4d 17 00 00       	call   80104430 <acquire>
  log.outstanding -= 1;
80102ce3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102ce8:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102cee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102cf1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102cf4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102cf6:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102cfc:	0f 85 22 01 00 00    	jne    80102e24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102d02:	85 db                	test   %ebx,%ebx
80102d04:	0f 85 f6 00 00 00    	jne    80102e00 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d0a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d0d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102d14:	00 00 00 
  release(&log.lock);
80102d17:	68 80 26 11 80       	push   $0x80112680
80102d1c:	e8 bf 17 00 00       	call   801044e0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d21:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d27:	83 c4 10             	add    $0x10,%esp
80102d2a:	85 c9                	test   %ecx,%ecx
80102d2c:	0f 8e 8b 00 00 00    	jle    80102dbd <end_op+0xed>
80102d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d38:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d3d:	83 ec 08             	sub    $0x8,%esp
80102d40:	01 d8                	add    %ebx,%eax
80102d42:	83 c0 01             	add    $0x1,%eax
80102d45:	50                   	push   %eax
80102d46:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102d4c:	e8 7f d3 ff ff       	call   801000d0 <bread>
80102d51:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d53:	58                   	pop    %eax
80102d54:	5a                   	pop    %edx
80102d55:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102d5c:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d62:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d65:	e8 66 d3 ff ff       	call   801000d0 <bread>
80102d6a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d6c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d6f:	83 c4 0c             	add    $0xc,%esp
80102d72:	68 00 02 00 00       	push   $0x200
80102d77:	50                   	push   %eax
80102d78:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d7b:	50                   	push   %eax
80102d7c:	e8 5f 18 00 00       	call   801045e0 <memmove>
    bwrite(to);  // write the log
80102d81:	89 34 24             	mov    %esi,(%esp)
80102d84:	e8 17 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d89:	89 3c 24             	mov    %edi,(%esp)
80102d8c:	e8 4f d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d91:	89 34 24             	mov    %esi,(%esp)
80102d94:	e8 47 d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d99:	83 c4 10             	add    $0x10,%esp
80102d9c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102da2:	7c 94                	jl     80102d38 <end_op+0x68>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102da4:	e8 b7 fd ff ff       	call   80102b60 <write_head>
    install_trans(); // Now install writes to home locations
80102da9:	e8 12 fd ff ff       	call   80102ac0 <install_trans>
    log.lh.n = 0;
80102dae:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102db5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102db8:	e8 a3 fd ff ff       	call   80102b60 <write_head>
    acquire(&log.lock);
80102dbd:	83 ec 0c             	sub    $0xc,%esp
80102dc0:	68 80 26 11 80       	push   $0x80112680
80102dc5:	e8 66 16 00 00       	call   80104430 <acquire>
    wakeup(&log);
80102dca:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102dd1:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102dd8:	00 00 00 
    wakeup(&log);
80102ddb:	e8 10 12 00 00       	call   80103ff0 <wakeup>
    release(&log.lock);
80102de0:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102de7:	e8 f4 16 00 00       	call   801044e0 <release>
80102dec:	83 c4 10             	add    $0x10,%esp
}
80102def:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102df2:	5b                   	pop    %ebx
80102df3:	5e                   	pop    %esi
80102df4:	5f                   	pop    %edi
80102df5:	5d                   	pop    %ebp
80102df6:	c3                   	ret    
80102df7:	89 f6                	mov    %esi,%esi
80102df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    wakeup(&log);
80102e00:	83 ec 0c             	sub    $0xc,%esp
80102e03:	68 80 26 11 80       	push   $0x80112680
80102e08:	e8 e3 11 00 00       	call   80103ff0 <wakeup>
  release(&log.lock);
80102e0d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e14:	e8 c7 16 00 00       	call   801044e0 <release>
80102e19:	83 c4 10             	add    $0x10,%esp
}
80102e1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e1f:	5b                   	pop    %ebx
80102e20:	5e                   	pop    %esi
80102e21:	5f                   	pop    %edi
80102e22:	5d                   	pop    %ebp
80102e23:	c3                   	ret    
    panic("log.committing");
80102e24:	83 ec 0c             	sub    $0xc,%esp
80102e27:	68 44 74 10 80       	push   $0x80107444
80102e2c:	e8 3f d5 ff ff       	call   80100370 <panic>
80102e31:	eb 0d                	jmp    80102e40 <log_write>
80102e33:	90                   	nop
80102e34:	90                   	nop
80102e35:	90                   	nop
80102e36:	90                   	nop
80102e37:	90                   	nop
80102e38:	90                   	nop
80102e39:	90                   	nop
80102e3a:	90                   	nop
80102e3b:	90                   	nop
80102e3c:	90                   	nop
80102e3d:	90                   	nop
80102e3e:	90                   	nop
80102e3f:	90                   	nop

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
80102e53:	0f 8f 97 00 00 00    	jg     80102ef0 <log_write+0xb0>
80102e59:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102e5e:	83 e8 01             	sub    $0x1,%eax
80102e61:	39 c2                	cmp    %eax,%edx
80102e63:	0f 8d 87 00 00 00    	jge    80102ef0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e69:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102e6e:	85 c0                	test   %eax,%eax
80102e70:	0f 8e 87 00 00 00    	jle    80102efd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e76:	83 ec 0c             	sub    $0xc,%esp
80102e79:	68 80 26 11 80       	push   $0x80112680
80102e7e:	e8 ad 15 00 00       	call   80104430 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e83:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102e89:	83 c4 10             	add    $0x10,%esp
80102e8c:	83 f9 00             	cmp    $0x0,%ecx
80102e8f:	7e 50                	jle    80102ee1 <log_write+0xa1>
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
80102eac:	39 c8                	cmp    %ecx,%eax
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
80102ecd:	e9 0e 16 00 00       	jmp    801044e0 <release>
80102ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ed8:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102edf:	eb de                	jmp    80102ebf <log_write+0x7f>
80102ee1:	8b 43 08             	mov    0x8(%ebx),%eax
80102ee4:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102ee9:	75 d4                	jne    80102ebf <log_write+0x7f>
80102eeb:	31 c0                	xor    %eax,%eax
80102eed:	eb c8                	jmp    80102eb7 <log_write+0x77>
80102eef:	90                   	nop
    panic("too big a transaction");
80102ef0:	83 ec 0c             	sub    $0xc,%esp
80102ef3:	68 53 74 10 80       	push   $0x80107453
80102ef8:	e8 73 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102efd:	83 ec 0c             	sub    $0xc,%esp
80102f00:	68 69 74 10 80       	push   $0x80107469
80102f05:	e8 66 d4 ff ff       	call   80100370 <panic>
80102f0a:	66 90                	xchg   %ax,%ax
80102f0c:	66 90                	xchg   %ax,%ax
80102f0e:	66 90                	xchg   %ax,%ax

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
80102f17:	e8 44 09 00 00       	call   80103860 <cpuid>
80102f1c:	89 c3                	mov    %eax,%ebx
80102f1e:	e8 3d 09 00 00       	call   80103860 <cpuid>
80102f23:	83 ec 04             	sub    $0x4,%esp
80102f26:	53                   	push   %ebx
80102f27:	50                   	push   %eax
80102f28:	68 84 74 10 80       	push   $0x80107484
80102f2d:	e8 0e d8 ff ff       	call   80100740 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 99 28 00 00       	call   801057d0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f37:	e8 a4 08 00 00       	call   801037e0 <mycpu>
80102f3c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f3e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f43:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f4a:	e8 f1 0b 00 00       	call   80103b40 <scheduler>
80102f4f:	90                   	nop

80102f50 <mpenter>:
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f56:	e8 95 39 00 00       	call   801068f0 <switchkvm>
  seginit();
80102f5b:	e8 90 38 00 00       	call   801067f0 <seginit>
  lapicinit();
80102f60:	e8 8b f7 ff ff       	call   801026f0 <lapicinit>
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
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f7f:	bb 80 27 11 80       	mov    $0x80112780,%ebx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f84:	83 ec 08             	sub    $0x8,%esp
80102f87:	68 00 00 40 80       	push   $0x80400000
80102f8c:	68 a8 54 11 80       	push   $0x801154a8
80102f91:	e8 1a f5 ff ff       	call   801024b0 <kinit1>
  kvmalloc();      // kernel page table
80102f96:	e8 e5 3d 00 00       	call   80106d80 <kvmalloc>
  mpinit();        // detect other processors
80102f9b:	e8 60 01 00 00       	call   80103100 <mpinit>
  lapicinit();     // interrupt controller
80102fa0:	e8 4b f7 ff ff       	call   801026f0 <lapicinit>
  seginit();       // segment descriptors
80102fa5:	e8 46 38 00 00       	call   801067f0 <seginit>
  picinit();       // disable pic
80102faa:	e8 21 03 00 00       	call   801032d0 <picinit>
  ioapicinit();    // another interrupt controller
80102faf:	e8 2c f3 ff ff       	call   801022e0 <ioapicinit>
  consoleinit();   // console hardware
80102fb4:	e8 c7 da ff ff       	call   80100a80 <consoleinit>
  uartinit();      // serial port
80102fb9:	e8 02 2b 00 00       	call   80105ac0 <uartinit>
  pinit();         // process table
80102fbe:	e8 fd 07 00 00       	call   801037c0 <pinit>
  tvinit();        // trap vectors
80102fc3:	e8 68 27 00 00       	call   80105730 <tvinit>
  binit();         // buffer cache
80102fc8:	e8 73 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fcd:	e8 5e de ff ff       	call   80100e30 <fileinit>
  ideinit();       // disk 
80102fd2:	e8 e9 f0 ff ff       	call   801020c0 <ideinit>
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fd7:	83 c4 0c             	add    $0xc,%esp
80102fda:	68 8a 00 00 00       	push   $0x8a
80102fdf:	68 8c a4 10 80       	push   $0x8010a48c
80102fe4:	68 00 70 00 80       	push   $0x80007000
80102fe9:	e8 f2 15 00 00       	call   801045e0 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
80102fee:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ff5:	00 00 00 
80102ff8:	83 c4 10             	add    $0x10,%esp
80102ffb:	05 80 27 11 80       	add    $0x80112780,%eax
80103000:	39 d8                	cmp    %ebx,%eax
80103002:	76 6f                	jbe    80103073 <main+0x103>
80103004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103008:	e8 d3 07 00 00       	call   801037e0 <mycpu>
8010300d:	39 d8                	cmp    %ebx,%eax
8010300f:	74 49                	je     8010305a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103011:	e8 6a f5 ff ff       	call   80102580 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103016:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
8010301b:	c7 05 f8 6f 00 80 50 	movl   $0x80102f50,0x80006ff8
80103022:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103025:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010302c:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010302f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80103034:	0f b6 03             	movzbl (%ebx),%eax
80103037:	83 ec 08             	sub    $0x8,%esp
8010303a:	68 00 70 00 00       	push   $0x7000
8010303f:	50                   	push   %eax
80103040:	e8 fb f7 ff ff       	call   80102840 <lapicstartap>
80103045:	83 c4 10             	add    $0x10,%esp
80103048:	90                   	nop
80103049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

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
80103071:	72 95                	jb     80103008 <main+0x98>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103073:	83 ec 08             	sub    $0x8,%esp
80103076:	68 00 00 00 8e       	push   $0x8e000000
8010307b:	68 00 00 40 80       	push   $0x80400000
80103080:	e8 9b f4 ff ff       	call   80102520 <kinit2>
  userinit();      // first user process
80103085:	e8 26 08 00 00       	call   801038b0 <userinit>
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
801030a4:	73 40                	jae    801030e6 <mpsearch1+0x56>
801030a6:	8d 76 00             	lea    0x0(%esi),%esi
801030a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030b0:	83 ec 04             	sub    $0x4,%esp
801030b3:	8d 7e 10             	lea    0x10(%esi),%edi
801030b6:	6a 04                	push   $0x4
801030b8:	68 98 74 10 80       	push   $0x80107498
801030bd:	56                   	push   %esi
801030be:	e8 bd 14 00 00       	call   80104580 <memcmp>
801030c3:	83 c4 10             	add    $0x10,%esp
801030c6:	85 c0                	test   %eax,%eax
801030c8:	75 16                	jne    801030e0 <mpsearch1+0x50>
801030ca:	8d 7e 10             	lea    0x10(%esi),%edi
801030cd:	89 f2                	mov    %esi,%edx
801030cf:	90                   	nop
    sum += addr[i];
801030d0:	0f b6 0a             	movzbl (%edx),%ecx
801030d3:	83 c2 01             	add    $0x1,%edx
801030d6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801030d8:	39 fa                	cmp    %edi,%edx
801030da:	75 f4                	jne    801030d0 <mpsearch1+0x40>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030dc:	84 c0                	test   %al,%al
801030de:	74 10                	je     801030f0 <mpsearch1+0x60>
  for(p = addr; p < e; p += sizeof(struct mp))
801030e0:	39 fb                	cmp    %edi,%ebx
801030e2:	89 fe                	mov    %edi,%esi
801030e4:	77 ca                	ja     801030b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801030e9:	31 c0                	xor    %eax,%eax
}
801030eb:	5b                   	pop    %ebx
801030ec:	5e                   	pop    %esi
801030ed:	5f                   	pop    %edi
801030ee:	5d                   	pop    %ebp
801030ef:	c3                   	ret    
801030f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030f3:	89 f0                	mov    %esi,%eax
801030f5:	5b                   	pop    %ebx
801030f6:	5e                   	pop    %esi
801030f7:	5f                   	pop    %edi
801030f8:	5d                   	pop    %ebp
801030f9:	c3                   	ret    
801030fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103100 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103100:	55                   	push   %ebp
80103101:	89 e5                	mov    %esp,%ebp
80103103:	57                   	push   %edi
80103104:	56                   	push   %esi
80103105:	53                   	push   %ebx
80103106:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103109:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103110:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103117:	c1 e0 08             	shl    $0x8,%eax
8010311a:	09 d0                	or     %edx,%eax
8010311c:	c1 e0 04             	shl    $0x4,%eax
8010311f:	85 c0                	test   %eax,%eax
80103121:	75 1b                	jne    8010313e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103123:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010312a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103131:	c1 e0 08             	shl    $0x8,%eax
80103134:	09 d0                	or     %edx,%eax
80103136:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103139:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010313e:	ba 00 04 00 00       	mov    $0x400,%edx
80103143:	e8 48 ff ff ff       	call   80103090 <mpsearch1>
80103148:	85 c0                	test   %eax,%eax
8010314a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010314d:	0f 84 37 01 00 00    	je     8010328a <mpinit+0x18a>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103153:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103156:	8b 58 04             	mov    0x4(%eax),%ebx
80103159:	85 db                	test   %ebx,%ebx
8010315b:	0f 84 43 01 00 00    	je     801032a4 <mpinit+0x1a4>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103161:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103167:	83 ec 04             	sub    $0x4,%esp
8010316a:	6a 04                	push   $0x4
8010316c:	68 b5 74 10 80       	push   $0x801074b5
80103171:	56                   	push   %esi
80103172:	e8 09 14 00 00       	call   80104580 <memcmp>
80103177:	83 c4 10             	add    $0x10,%esp
8010317a:	85 c0                	test   %eax,%eax
8010317c:	0f 85 22 01 00 00    	jne    801032a4 <mpinit+0x1a4>
  if(conf->version != 1 && conf->version != 4)
80103182:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103189:	3c 01                	cmp    $0x1,%al
8010318b:	74 08                	je     80103195 <mpinit+0x95>
8010318d:	3c 04                	cmp    $0x4,%al
8010318f:	0f 85 0f 01 00 00    	jne    801032a4 <mpinit+0x1a4>
  if(sum((uchar*)conf, conf->length) != 0)
80103195:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
8010319c:	85 ff                	test   %edi,%edi
8010319e:	74 21                	je     801031c1 <mpinit+0xc1>
801031a0:	31 d2                	xor    %edx,%edx
801031a2:	31 c0                	xor    %eax,%eax
801031a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801031a8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801031af:	80 
  for(i=0; i<len; i++)
801031b0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801031b3:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801031b5:	39 c7                	cmp    %eax,%edi
801031b7:	75 ef                	jne    801031a8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801031b9:	84 d2                	test   %dl,%dl
801031bb:	0f 85 e3 00 00 00    	jne    801032a4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031c1:	85 f6                	test   %esi,%esi
801031c3:	0f 84 db 00 00 00    	je     801032a4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031c9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031cf:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031d4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801031db:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801031e1:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031e6:	01 d6                	add    %edx,%esi
801031e8:	90                   	nop
801031e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031f0:	39 c6                	cmp    %eax,%esi
801031f2:	76 23                	jbe    80103217 <mpinit+0x117>
801031f4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
801031f7:	80 fa 04             	cmp    $0x4,%dl
801031fa:	0f 87 c0 00 00 00    	ja     801032c0 <mpinit+0x1c0>
80103200:	ff 24 95 dc 74 10 80 	jmp    *-0x7fef8b24(,%edx,4)
80103207:	89 f6                	mov    %esi,%esi
80103209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103210:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103213:	39 c6                	cmp    %eax,%esi
80103215:	77 dd                	ja     801031f4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103217:	85 db                	test   %ebx,%ebx
80103219:	0f 84 92 00 00 00    	je     801032b1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010321f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103222:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103226:	74 15                	je     8010323d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103228:	ba 22 00 00 00       	mov    $0x22,%edx
8010322d:	b8 70 00 00 00       	mov    $0x70,%eax
80103232:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103233:	ba 23 00 00 00       	mov    $0x23,%edx
80103238:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103239:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010323c:	ee                   	out    %al,(%dx)
  }
}
8010323d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103240:	5b                   	pop    %ebx
80103241:	5e                   	pop    %esi
80103242:	5f                   	pop    %edi
80103243:	5d                   	pop    %ebp
80103244:	c3                   	ret    
80103245:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103248:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010324e:	83 f9 07             	cmp    $0x7,%ecx
80103251:	7f 19                	jg     8010326c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103253:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103257:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010325d:	83 c1 01             	add    $0x1,%ecx
80103260:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103266:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
8010326c:	83 c0 14             	add    $0x14,%eax
      continue;
8010326f:	e9 7c ff ff ff       	jmp    801031f0 <mpinit+0xf0>
80103274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010327c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010327f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
80103285:	e9 66 ff ff ff       	jmp    801031f0 <mpinit+0xf0>
  return mpsearch1(0xF0000, 0x10000);
8010328a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010328f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103294:	e8 f7 fd ff ff       	call   80103090 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103299:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
8010329b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010329e:	0f 85 af fe ff ff    	jne    80103153 <mpinit+0x53>
    panic("Expect to run on an SMP");
801032a4:	83 ec 0c             	sub    $0xc,%esp
801032a7:	68 9d 74 10 80       	push   $0x8010749d
801032ac:	e8 bf d0 ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
801032b1:	83 ec 0c             	sub    $0xc,%esp
801032b4:	68 bc 74 10 80       	push   $0x801074bc
801032b9:	e8 b2 d0 ff ff       	call   80100370 <panic>
801032be:	66 90                	xchg   %ax,%ax
      ismp = 0;
801032c0:	31 db                	xor    %ebx,%ebx
801032c2:	e9 30 ff ff ff       	jmp    801031f7 <mpinit+0xf7>
801032c7:	66 90                	xchg   %ax,%ax
801032c9:	66 90                	xchg   %ax,%ax
801032cb:	66 90                	xchg   %ax,%ax
801032cd:	66 90                	xchg   %ax,%ax
801032cf:	90                   	nop

801032d0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801032d0:	55                   	push   %ebp
801032d1:	ba 21 00 00 00       	mov    $0x21,%edx
801032d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032db:	89 e5                	mov    %esp,%ebp
801032dd:	ee                   	out    %al,(%dx)
801032de:	ba a1 00 00 00       	mov    $0xa1,%edx
801032e3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801032e4:	5d                   	pop    %ebp
801032e5:	c3                   	ret    
801032e6:	66 90                	xchg   %ax,%ax
801032e8:	66 90                	xchg   %ax,%ax
801032ea:	66 90                	xchg   %ax,%ax
801032ec:	66 90                	xchg   %ax,%ax
801032ee:	66 90                	xchg   %ax,%ax

801032f0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	57                   	push   %edi
801032f4:	56                   	push   %esi
801032f5:	53                   	push   %ebx
801032f6:	83 ec 0c             	sub    $0xc,%esp
801032f9:	8b 75 08             	mov    0x8(%ebp),%esi
801032fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801032ff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103305:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010330b:	e8 40 db ff ff       	call   80100e50 <filealloc>
80103310:	85 c0                	test   %eax,%eax
80103312:	89 06                	mov    %eax,(%esi)
80103314:	0f 84 a8 00 00 00    	je     801033c2 <pipealloc+0xd2>
8010331a:	e8 31 db ff ff       	call   80100e50 <filealloc>
8010331f:	85 c0                	test   %eax,%eax
80103321:	89 03                	mov    %eax,(%ebx)
80103323:	0f 84 87 00 00 00    	je     801033b0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103329:	e8 52 f2 ff ff       	call   80102580 <kalloc>
8010332e:	85 c0                	test   %eax,%eax
80103330:	89 c7                	mov    %eax,%edi
80103332:	0f 84 b0 00 00 00    	je     801033e8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103338:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
8010333b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103342:	00 00 00 
  p->writeopen = 1;
80103345:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010334c:	00 00 00 
  p->nwrite = 0;
8010334f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103356:	00 00 00 
  p->nread = 0;
80103359:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103360:	00 00 00 
  initlock(&p->lock, "pipe");
80103363:	68 f0 74 10 80       	push   $0x801074f0
80103368:	50                   	push   %eax
80103369:	e8 62 0f 00 00       	call   801042d0 <initlock>
  (*f0)->type = FD_PIPE;
8010336e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103370:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103373:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103379:	8b 06                	mov    (%esi),%eax
8010337b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010337f:	8b 06                	mov    (%esi),%eax
80103381:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103385:	8b 06                	mov    (%esi),%eax
80103387:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010338a:	8b 03                	mov    (%ebx),%eax
8010338c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103392:	8b 03                	mov    (%ebx),%eax
80103394:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103398:	8b 03                	mov    (%ebx),%eax
8010339a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010339e:	8b 03                	mov    (%ebx),%eax
801033a0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801033a6:	31 c0                	xor    %eax,%eax
}
801033a8:	5b                   	pop    %ebx
801033a9:	5e                   	pop    %esi
801033aa:	5f                   	pop    %edi
801033ab:	5d                   	pop    %ebp
801033ac:	c3                   	ret    
801033ad:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801033b0:	8b 06                	mov    (%esi),%eax
801033b2:	85 c0                	test   %eax,%eax
801033b4:	74 1e                	je     801033d4 <pipealloc+0xe4>
    fileclose(*f0);
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	50                   	push   %eax
801033ba:	e8 51 db ff ff       	call   80100f10 <fileclose>
801033bf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033c2:	8b 03                	mov    (%ebx),%eax
801033c4:	85 c0                	test   %eax,%eax
801033c6:	74 0c                	je     801033d4 <pipealloc+0xe4>
    fileclose(*f1);
801033c8:	83 ec 0c             	sub    $0xc,%esp
801033cb:	50                   	push   %eax
801033cc:	e8 3f db ff ff       	call   80100f10 <fileclose>
801033d1:	83 c4 10             	add    $0x10,%esp
}
801033d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801033d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033dc:	5b                   	pop    %ebx
801033dd:	5e                   	pop    %esi
801033de:	5f                   	pop    %edi
801033df:	5d                   	pop    %ebp
801033e0:	c3                   	ret    
801033e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801033e8:	8b 06                	mov    (%esi),%eax
801033ea:	85 c0                	test   %eax,%eax
801033ec:	75 c8                	jne    801033b6 <pipealloc+0xc6>
801033ee:	eb d2                	jmp    801033c2 <pipealloc+0xd2>

801033f0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	56                   	push   %esi
801033f4:	53                   	push   %ebx
801033f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801033fb:	83 ec 0c             	sub    $0xc,%esp
801033fe:	53                   	push   %ebx
801033ff:	e8 2c 10 00 00       	call   80104430 <acquire>
  if(writable){
80103404:	83 c4 10             	add    $0x10,%esp
80103407:	85 f6                	test   %esi,%esi
80103409:	74 45                	je     80103450 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010340b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103411:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103414:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010341b:	00 00 00 
    wakeup(&p->nread);
8010341e:	50                   	push   %eax
8010341f:	e8 cc 0b 00 00       	call   80103ff0 <wakeup>
80103424:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103427:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010342d:	85 d2                	test   %edx,%edx
8010342f:	75 0a                	jne    8010343b <pipeclose+0x4b>
80103431:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103437:	85 c0                	test   %eax,%eax
80103439:	74 35                	je     80103470 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010343b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010343e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103441:	5b                   	pop    %ebx
80103442:	5e                   	pop    %esi
80103443:	5d                   	pop    %ebp
    release(&p->lock);
80103444:	e9 97 10 00 00       	jmp    801044e0 <release>
80103449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103450:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103456:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103459:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103460:	00 00 00 
    wakeup(&p->nwrite);
80103463:	50                   	push   %eax
80103464:	e8 87 0b 00 00       	call   80103ff0 <wakeup>
80103469:	83 c4 10             	add    $0x10,%esp
8010346c:	eb b9                	jmp    80103427 <pipeclose+0x37>
8010346e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103470:	83 ec 0c             	sub    $0xc,%esp
80103473:	53                   	push   %ebx
80103474:	e8 67 10 00 00       	call   801044e0 <release>
    kfree((char*)p);
80103479:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010347c:	83 c4 10             	add    $0x10,%esp
}
8010347f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103482:	5b                   	pop    %ebx
80103483:	5e                   	pop    %esi
80103484:	5d                   	pop    %ebp
    kfree((char*)p);
80103485:	e9 46 ef ff ff       	jmp    801023d0 <kfree>
8010348a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103490 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103490:	55                   	push   %ebp
80103491:	89 e5                	mov    %esp,%ebp
80103493:	57                   	push   %edi
80103494:	56                   	push   %esi
80103495:	53                   	push   %ebx
80103496:	83 ec 28             	sub    $0x28,%esp
80103499:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010349c:	53                   	push   %ebx
8010349d:	e8 8e 0f 00 00       	call   80104430 <acquire>
  for(i = 0; i < n; i++){
801034a2:	8b 45 10             	mov    0x10(%ebp),%eax
801034a5:	83 c4 10             	add    $0x10,%esp
801034a8:	85 c0                	test   %eax,%eax
801034aa:	0f 8e ca 00 00 00    	jle    8010357a <pipewrite+0xea>
801034b0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034b3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034b9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034bf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801034c2:	03 4d 10             	add    0x10(%ebp),%ecx
801034c5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034c8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801034ce:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801034d4:	39 d0                	cmp    %edx,%eax
801034d6:	75 71                	jne    80103549 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801034d8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034de:	85 c0                	test   %eax,%eax
801034e0:	74 4e                	je     80103530 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034e2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801034e8:	eb 3a                	jmp    80103524 <pipewrite+0x94>
801034ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801034f0:	83 ec 0c             	sub    $0xc,%esp
801034f3:	57                   	push   %edi
801034f4:	e8 f7 0a 00 00       	call   80103ff0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034f9:	5a                   	pop    %edx
801034fa:	59                   	pop    %ecx
801034fb:	53                   	push   %ebx
801034fc:	56                   	push   %esi
801034fd:	e8 2e 09 00 00       	call   80103e30 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103502:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103508:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010350e:	83 c4 10             	add    $0x10,%esp
80103511:	05 00 02 00 00       	add    $0x200,%eax
80103516:	39 c2                	cmp    %eax,%edx
80103518:	75 36                	jne    80103550 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010351a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103520:	85 c0                	test   %eax,%eax
80103522:	74 0c                	je     80103530 <pipewrite+0xa0>
80103524:	e8 57 03 00 00       	call   80103880 <myproc>
80103529:	8b 40 24             	mov    0x24(%eax),%eax
8010352c:	85 c0                	test   %eax,%eax
8010352e:	74 c0                	je     801034f0 <pipewrite+0x60>
        release(&p->lock);
80103530:	83 ec 0c             	sub    $0xc,%esp
80103533:	53                   	push   %ebx
80103534:	e8 a7 0f 00 00       	call   801044e0 <release>
        return -1;
80103539:	83 c4 10             	add    $0x10,%esp
8010353c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103541:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103544:	5b                   	pop    %ebx
80103545:	5e                   	pop    %esi
80103546:	5f                   	pop    %edi
80103547:	5d                   	pop    %ebp
80103548:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103549:	89 c2                	mov    %eax,%edx
8010354b:	90                   	nop
8010354c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103550:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103553:	8d 42 01             	lea    0x1(%edx),%eax
80103556:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010355c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103562:	0f b6 0e             	movzbl (%esi),%ecx
80103565:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80103569:	89 f1                	mov    %esi,%ecx
8010356b:	83 c1 01             	add    $0x1,%ecx
  for(i = 0; i < n; i++){
8010356e:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103571:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103574:	0f 85 4e ff ff ff    	jne    801034c8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010357a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103580:	83 ec 0c             	sub    $0xc,%esp
80103583:	50                   	push   %eax
80103584:	e8 67 0a 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
80103589:	89 1c 24             	mov    %ebx,(%esp)
8010358c:	e8 4f 0f 00 00       	call   801044e0 <release>
  return n;
80103591:	83 c4 10             	add    $0x10,%esp
80103594:	8b 45 10             	mov    0x10(%ebp),%eax
80103597:	eb a8                	jmp    80103541 <pipewrite+0xb1>
80103599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035a0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801035a0:	55                   	push   %ebp
801035a1:	89 e5                	mov    %esp,%ebp
801035a3:	57                   	push   %edi
801035a4:	56                   	push   %esi
801035a5:	53                   	push   %ebx
801035a6:	83 ec 18             	sub    $0x18,%esp
801035a9:	8b 75 08             	mov    0x8(%ebp),%esi
801035ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035af:	56                   	push   %esi
801035b0:	e8 7b 0e 00 00       	call   80104430 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035b5:	83 c4 10             	add    $0x10,%esp
801035b8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035be:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035c4:	75 6a                	jne    80103630 <piperead+0x90>
801035c6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801035cc:	85 db                	test   %ebx,%ebx
801035ce:	0f 84 c4 00 00 00    	je     80103698 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801035d4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801035da:	eb 2d                	jmp    80103609 <piperead+0x69>
801035dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035e0:	83 ec 08             	sub    $0x8,%esp
801035e3:	56                   	push   %esi
801035e4:	53                   	push   %ebx
801035e5:	e8 46 08 00 00       	call   80103e30 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035ea:	83 c4 10             	add    $0x10,%esp
801035ed:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035f3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035f9:	75 35                	jne    80103630 <piperead+0x90>
801035fb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103601:	85 d2                	test   %edx,%edx
80103603:	0f 84 8f 00 00 00    	je     80103698 <piperead+0xf8>
    if(myproc()->killed){
80103609:	e8 72 02 00 00       	call   80103880 <myproc>
8010360e:	8b 48 24             	mov    0x24(%eax),%ecx
80103611:	85 c9                	test   %ecx,%ecx
80103613:	74 cb                	je     801035e0 <piperead+0x40>
      release(&p->lock);
80103615:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103618:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010361d:	56                   	push   %esi
8010361e:	e8 bd 0e 00 00       	call   801044e0 <release>
      return -1;
80103623:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103626:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103629:	89 d8                	mov    %ebx,%eax
8010362b:	5b                   	pop    %ebx
8010362c:	5e                   	pop    %esi
8010362d:	5f                   	pop    %edi
8010362e:	5d                   	pop    %ebp
8010362f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103630:	8b 45 10             	mov    0x10(%ebp),%eax
80103633:	85 c0                	test   %eax,%eax
80103635:	7e 61                	jle    80103698 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103637:	31 db                	xor    %ebx,%ebx
80103639:	eb 13                	jmp    8010364e <piperead+0xae>
8010363b:	90                   	nop
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103640:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103646:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010364c:	74 1f                	je     8010366d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010364e:	8d 41 01             	lea    0x1(%ecx),%eax
80103651:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103657:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010365d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103662:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103665:	83 c3 01             	add    $0x1,%ebx
80103668:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010366b:	75 d3                	jne    80103640 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010366d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103673:	83 ec 0c             	sub    $0xc,%esp
80103676:	50                   	push   %eax
80103677:	e8 74 09 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
8010367c:	89 34 24             	mov    %esi,(%esp)
8010367f:	e8 5c 0e 00 00       	call   801044e0 <release>
  return i;
80103684:	83 c4 10             	add    $0x10,%esp
}
80103687:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010368a:	89 d8                	mov    %ebx,%eax
8010368c:	5b                   	pop    %ebx
8010368d:	5e                   	pop    %esi
8010368e:	5f                   	pop    %edi
8010368f:	5d                   	pop    %ebp
80103690:	c3                   	ret    
80103691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
80103698:	31 db                	xor    %ebx,%ebx
8010369a:	eb d1                	jmp    8010366d <piperead+0xcd>
8010369c:	66 90                	xchg   %ax,%ax
8010369e:	66 90                	xchg   %ax,%ax

801036a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036a4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801036a9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801036ac:	68 20 2d 11 80       	push   $0x80112d20
801036b1:	e8 7a 0d 00 00       	call   80104430 <acquire>
801036b6:	83 c4 10             	add    $0x10,%esp
801036b9:	eb 10                	jmp    801036cb <allocproc+0x2b>
801036bb:	90                   	nop
801036bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036c0:	83 c3 7c             	add    $0x7c,%ebx
801036c3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801036c9:	73 75                	jae    80103740 <allocproc+0xa0>
    if(p->state == UNUSED)
801036cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801036ce:	85 c0                	test   %eax,%eax
801036d0:	75 ee                	jne    801036c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801036d2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801036d7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801036da:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801036e1:	8d 50 01             	lea    0x1(%eax),%edx
801036e4:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
801036e7:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
801036ec:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801036f2:	e8 e9 0d 00 00       	call   801044e0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801036f7:	e8 84 ee ff ff       	call   80102580 <kalloc>
801036fc:	83 c4 10             	add    $0x10,%esp
801036ff:	85 c0                	test   %eax,%eax
80103701:	89 43 08             	mov    %eax,0x8(%ebx)
80103704:	74 53                	je     80103759 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103706:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010370c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010370f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103714:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103717:	c7 40 14 22 57 10 80 	movl   $0x80105722,0x14(%eax)
  p->context = (struct context*)sp;
8010371e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103721:	6a 14                	push   $0x14
80103723:	6a 00                	push   $0x0
80103725:	50                   	push   %eax
80103726:	e8 05 0e 00 00       	call   80104530 <memset>
  p->context->eip = (uint)forkret;
8010372b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010372e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103731:	c7 40 10 70 37 10 80 	movl   $0x80103770,0x10(%eax)
}
80103738:	89 d8                	mov    %ebx,%eax
8010373a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010373d:	c9                   	leave  
8010373e:	c3                   	ret    
8010373f:	90                   	nop
  release(&ptable.lock);
80103740:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103743:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103745:	68 20 2d 11 80       	push   $0x80112d20
8010374a:	e8 91 0d 00 00       	call   801044e0 <release>
}
8010374f:	89 d8                	mov    %ebx,%eax
  return 0;
80103751:	83 c4 10             	add    $0x10,%esp
}
80103754:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103757:	c9                   	leave  
80103758:	c3                   	ret    
    p->state = UNUSED;
80103759:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103760:	31 db                	xor    %ebx,%ebx
80103762:	eb d4                	jmp    80103738 <allocproc+0x98>
80103764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010376a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103770 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103776:	68 20 2d 11 80       	push   $0x80112d20
8010377b:	e8 60 0d 00 00       	call   801044e0 <release>

  if (first) {
80103780:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103785:	83 c4 10             	add    $0x10,%esp
80103788:	85 c0                	test   %eax,%eax
8010378a:	75 04                	jne    80103790 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010378c:	c9                   	leave  
8010378d:	c3                   	ret    
8010378e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103790:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103793:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010379a:	00 00 00 
    iinit(ROOTDEV);
8010379d:	6a 01                	push   $0x1
8010379f:	e8 bc dd ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
801037a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037ab:	e8 10 f4 ff ff       	call   80102bc0 <initlog>
801037b0:	83 c4 10             	add    $0x10,%esp
}
801037b3:	c9                   	leave  
801037b4:	c3                   	ret    
801037b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037c0 <pinit>:
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801037c6:	68 f5 74 10 80       	push   $0x801074f5
801037cb:	68 20 2d 11 80       	push   $0x80112d20
801037d0:	e8 fb 0a 00 00       	call   801042d0 <initlock>
}
801037d5:	83 c4 10             	add    $0x10,%esp
801037d8:	c9                   	leave  
801037d9:	c3                   	ret    
801037da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037e0 <mycpu>:
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	56                   	push   %esi
801037e4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801037e5:	9c                   	pushf  
801037e6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801037e7:	f6 c4 02             	test   $0x2,%ah
801037ea:	75 5e                	jne    8010384a <mycpu+0x6a>
  apicid = lapicid();
801037ec:	e8 ff ef ff ff       	call   801027f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801037f1:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801037f7:	85 f6                	test   %esi,%esi
801037f9:	7e 42                	jle    8010383d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801037fb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103802:	39 d0                	cmp    %edx,%eax
80103804:	74 30                	je     80103836 <mycpu+0x56>
80103806:	b9 30 28 11 80       	mov    $0x80112830,%ecx
8010380b:	31 d2                	xor    %edx,%edx
8010380d:	8d 76 00             	lea    0x0(%esi),%esi
  for (i = 0; i < ncpu; ++i) {
80103810:	83 c2 01             	add    $0x1,%edx
80103813:	39 f2                	cmp    %esi,%edx
80103815:	74 26                	je     8010383d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103817:	0f b6 19             	movzbl (%ecx),%ebx
8010381a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103820:	39 d8                	cmp    %ebx,%eax
80103822:	75 ec                	jne    80103810 <mycpu+0x30>
80103824:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010382a:	05 80 27 11 80       	add    $0x80112780,%eax
}
8010382f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103832:	5b                   	pop    %ebx
80103833:	5e                   	pop    %esi
80103834:	5d                   	pop    %ebp
80103835:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103836:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010383b:	eb f2                	jmp    8010382f <mycpu+0x4f>
  panic("unknown apicid\n");
8010383d:	83 ec 0c             	sub    $0xc,%esp
80103840:	68 fc 74 10 80       	push   $0x801074fc
80103845:	e8 26 cb ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
8010384a:	83 ec 0c             	sub    $0xc,%esp
8010384d:	68 d8 75 10 80       	push   $0x801075d8
80103852:	e8 19 cb ff ff       	call   80100370 <panic>
80103857:	89 f6                	mov    %esi,%esi
80103859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103860 <cpuid>:
cpuid() {
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103866:	e8 75 ff ff ff       	call   801037e0 <mycpu>
8010386b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103870:	c9                   	leave  
  return mycpu()-cpus;
80103871:	c1 f8 04             	sar    $0x4,%eax
80103874:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010387a:	c3                   	ret    
8010387b:	90                   	nop
8010387c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103880 <myproc>:
myproc(void) {
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	53                   	push   %ebx
80103884:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103887:	e8 c4 0a 00 00       	call   80104350 <pushcli>
  c = mycpu();
8010388c:	e8 4f ff ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103891:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103897:	e8 f4 0a 00 00       	call   80104390 <popcli>
}
8010389c:	83 c4 04             	add    $0x4,%esp
8010389f:	89 d8                	mov    %ebx,%eax
801038a1:	5b                   	pop    %ebx
801038a2:	5d                   	pop    %ebp
801038a3:	c3                   	ret    
801038a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038b0 <userinit>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	53                   	push   %ebx
801038b4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038b7:	e8 e4 fd ff ff       	call   801036a0 <allocproc>
801038bc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038be:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801038c3:	e8 38 34 00 00       	call   80106d00 <setupkvm>
801038c8:	85 c0                	test   %eax,%eax
801038ca:	89 43 04             	mov    %eax,0x4(%ebx)
801038cd:	0f 84 bd 00 00 00    	je     80103990 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038d3:	83 ec 04             	sub    $0x4,%esp
801038d6:	68 2c 00 00 00       	push   $0x2c
801038db:	68 60 a4 10 80       	push   $0x8010a460
801038e0:	50                   	push   %eax
801038e1:	e8 3a 31 00 00       	call   80106a20 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801038e6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801038e9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801038ef:	6a 4c                	push   $0x4c
801038f1:	6a 00                	push   $0x0
801038f3:	ff 73 18             	pushl  0x18(%ebx)
801038f6:	e8 35 0c 00 00       	call   80104530 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038fb:	8b 43 18             	mov    0x18(%ebx),%eax
801038fe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103903:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103908:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010390b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010390f:	8b 43 18             	mov    0x18(%ebx),%eax
80103912:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103916:	8b 43 18             	mov    0x18(%ebx),%eax
80103919:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010391d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103921:	8b 43 18             	mov    0x18(%ebx),%eax
80103924:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103928:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010392c:	8b 43 18             	mov    0x18(%ebx),%eax
8010392f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103936:	8b 43 18             	mov    0x18(%ebx),%eax
80103939:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103940:	8b 43 18             	mov    0x18(%ebx),%eax
80103943:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010394a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010394d:	6a 10                	push   $0x10
8010394f:	68 25 75 10 80       	push   $0x80107525
80103954:	50                   	push   %eax
80103955:	e8 b6 0d 00 00       	call   80104710 <safestrcpy>
  p->cwd = namei("/");
8010395a:	c7 04 24 2e 75 10 80 	movl   $0x8010752e,(%esp)
80103961:	e8 4a e6 ff ff       	call   80101fb0 <namei>
80103966:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103969:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103970:	e8 bb 0a 00 00       	call   80104430 <acquire>
  p->state = RUNNABLE;
80103975:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010397c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103983:	e8 58 0b 00 00       	call   801044e0 <release>
}
80103988:	83 c4 10             	add    $0x10,%esp
8010398b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010398e:	c9                   	leave  
8010398f:	c3                   	ret    
    panic("userinit: out of memory?");
80103990:	83 ec 0c             	sub    $0xc,%esp
80103993:	68 0c 75 10 80       	push   $0x8010750c
80103998:	e8 d3 c9 ff ff       	call   80100370 <panic>
8010399d:	8d 76 00             	lea    0x0(%esi),%esi

801039a0 <growproc>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	56                   	push   %esi
801039a4:	53                   	push   %ebx
801039a5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039a8:	e8 a3 09 00 00       	call   80104350 <pushcli>
  c = mycpu();
801039ad:	e8 2e fe ff ff       	call   801037e0 <mycpu>
  p = c->proc;
801039b2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039b8:	e8 d3 09 00 00       	call   80104390 <popcli>
  if(n > 0){
801039bd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801039c0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039c2:	7e 34                	jle    801039f8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039c4:	83 ec 04             	sub    $0x4,%esp
801039c7:	01 c6                	add    %eax,%esi
801039c9:	56                   	push   %esi
801039ca:	50                   	push   %eax
801039cb:	ff 73 04             	pushl  0x4(%ebx)
801039ce:	e8 8d 31 00 00       	call   80106b60 <allocuvm>
801039d3:	83 c4 10             	add    $0x10,%esp
801039d6:	85 c0                	test   %eax,%eax
801039d8:	74 36                	je     80103a10 <growproc+0x70>
  switchuvm(curproc);
801039da:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801039dd:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039df:	53                   	push   %ebx
801039e0:	e8 2b 2f 00 00       	call   80106910 <switchuvm>
  return 0;
801039e5:	83 c4 10             	add    $0x10,%esp
801039e8:	31 c0                	xor    %eax,%eax
}
801039ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039ed:	5b                   	pop    %ebx
801039ee:	5e                   	pop    %esi
801039ef:	5d                   	pop    %ebp
801039f0:	c3                   	ret    
801039f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  } else if(n < 0){
801039f8:	74 e0                	je     801039da <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039fa:	83 ec 04             	sub    $0x4,%esp
801039fd:	01 c6                	add    %eax,%esi
801039ff:	56                   	push   %esi
80103a00:	50                   	push   %eax
80103a01:	ff 73 04             	pushl  0x4(%ebx)
80103a04:	e8 47 32 00 00       	call   80106c50 <deallocuvm>
80103a09:	83 c4 10             	add    $0x10,%esp
80103a0c:	85 c0                	test   %eax,%eax
80103a0e:	75 ca                	jne    801039da <growproc+0x3a>
      return -1;
80103a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a15:	eb d3                	jmp    801039ea <growproc+0x4a>
80103a17:	89 f6                	mov    %esi,%esi
80103a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a20 <fork>:
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	57                   	push   %edi
80103a24:	56                   	push   %esi
80103a25:	53                   	push   %ebx
80103a26:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a29:	e8 22 09 00 00       	call   80104350 <pushcli>
  c = mycpu();
80103a2e:	e8 ad fd ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103a33:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a39:	e8 52 09 00 00       	call   80104390 <popcli>
  if((np = allocproc()) == 0){
80103a3e:	e8 5d fc ff ff       	call   801036a0 <allocproc>
80103a43:	85 c0                	test   %eax,%eax
80103a45:	89 c7                	mov    %eax,%edi
80103a47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a4a:	0f 84 b5 00 00 00    	je     80103b05 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a50:	83 ec 08             	sub    $0x8,%esp
80103a53:	ff 33                	pushl  (%ebx)
80103a55:	ff 73 04             	pushl  0x4(%ebx)
80103a58:	e8 73 33 00 00       	call   80106dd0 <copyuvm>
80103a5d:	83 c4 10             	add    $0x10,%esp
80103a60:	85 c0                	test   %eax,%eax
80103a62:	89 47 04             	mov    %eax,0x4(%edi)
80103a65:	0f 84 a1 00 00 00    	je     80103b0c <fork+0xec>
  np->sz = curproc->sz;
80103a6b:	8b 03                	mov    (%ebx),%eax
80103a6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103a70:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103a72:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103a75:	89 c8                	mov    %ecx,%eax
80103a77:	8b 79 18             	mov    0x18(%ecx),%edi
80103a7a:	8b 73 18             	mov    0x18(%ebx),%esi
80103a7d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103a84:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103a86:	8b 40 18             	mov    0x18(%eax),%eax
80103a89:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103a90:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a94:	85 c0                	test   %eax,%eax
80103a96:	74 13                	je     80103aab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a98:	83 ec 0c             	sub    $0xc,%esp
80103a9b:	50                   	push   %eax
80103a9c:	e8 1f d4 ff ff       	call   80100ec0 <filedup>
80103aa1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103aa4:	83 c4 10             	add    $0x10,%esp
80103aa7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103aab:	83 c6 01             	add    $0x1,%esi
80103aae:	83 fe 10             	cmp    $0x10,%esi
80103ab1:	75 dd                	jne    80103a90 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ab3:	83 ec 0c             	sub    $0xc,%esp
80103ab6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ab9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103abc:	e8 6f dc ff ff       	call   80101730 <idup>
80103ac1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ac4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ac7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103aca:	8d 47 6c             	lea    0x6c(%edi),%eax
80103acd:	6a 10                	push   $0x10
80103acf:	53                   	push   %ebx
80103ad0:	50                   	push   %eax
80103ad1:	e8 3a 0c 00 00       	call   80104710 <safestrcpy>
  pid = np->pid;
80103ad6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ad9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ae0:	e8 4b 09 00 00       	call   80104430 <acquire>
  np->state = RUNNABLE;
80103ae5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103aec:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103af3:	e8 e8 09 00 00       	call   801044e0 <release>
  return pid;
80103af8:	83 c4 10             	add    $0x10,%esp
}
80103afb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103afe:	89 d8                	mov    %ebx,%eax
80103b00:	5b                   	pop    %ebx
80103b01:	5e                   	pop    %esi
80103b02:	5f                   	pop    %edi
80103b03:	5d                   	pop    %ebp
80103b04:	c3                   	ret    
    return -1;
80103b05:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b0a:	eb ef                	jmp    80103afb <fork+0xdb>
    kfree(np->kstack);
80103b0c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103b0f:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103b12:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103b17:	ff 77 08             	pushl  0x8(%edi)
80103b1a:	e8 b1 e8 ff ff       	call   801023d0 <kfree>
    np->kstack = 0;
80103b1f:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103b26:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103b2d:	83 c4 10             	add    $0x10,%esp
80103b30:	eb c9                	jmp    80103afb <fork+0xdb>
80103b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b40 <scheduler>:
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	57                   	push   %edi
80103b44:	56                   	push   %esi
80103b45:	53                   	push   %ebx
80103b46:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b49:	e8 92 fc ff ff       	call   801037e0 <mycpu>
80103b4e:	8d 78 04             	lea    0x4(%eax),%edi
80103b51:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103b53:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b5a:	00 00 00 
80103b5d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103b60:	fb                   	sti    
    acquire(&ptable.lock);
80103b61:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b64:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103b69:	68 20 2d 11 80       	push   $0x80112d20
80103b6e:	e8 bd 08 00 00       	call   80104430 <acquire>
80103b73:	83 c4 10             	add    $0x10,%esp
80103b76:	eb 13                	jmp    80103b8b <scheduler+0x4b>
80103b78:	90                   	nop
80103b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b80:	83 c3 7c             	add    $0x7c,%ebx
80103b83:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103b89:	73 45                	jae    80103bd0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103b8b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b8f:	75 ef                	jne    80103b80 <scheduler+0x40>
      switchuvm(p);
80103b91:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103b94:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103b9a:	53                   	push   %ebx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b9b:	83 c3 7c             	add    $0x7c,%ebx
      switchuvm(p);
80103b9e:	e8 6d 2d 00 00       	call   80106910 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103ba3:	58                   	pop    %eax
80103ba4:	5a                   	pop    %edx
80103ba5:	ff 73 a0             	pushl  -0x60(%ebx)
80103ba8:	57                   	push   %edi
      p->state = RUNNING;
80103ba9:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)
      swtch(&(c->scheduler), p->context);
80103bb0:	e8 b6 0b 00 00       	call   8010476b <swtch>
      switchkvm();
80103bb5:	e8 36 2d 00 00       	call   801068f0 <switchkvm>
      c->proc = 0;
80103bba:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bbd:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
      c->proc = 0;
80103bc3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103bca:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bcd:	72 bc                	jb     80103b8b <scheduler+0x4b>
80103bcf:	90                   	nop
    release(&ptable.lock);
80103bd0:	83 ec 0c             	sub    $0xc,%esp
80103bd3:	68 20 2d 11 80       	push   $0x80112d20
80103bd8:	e8 03 09 00 00       	call   801044e0 <release>
    sti();
80103bdd:	83 c4 10             	add    $0x10,%esp
80103be0:	e9 7b ff ff ff       	jmp    80103b60 <scheduler+0x20>
80103be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bf0 <sched>:
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	56                   	push   %esi
80103bf4:	53                   	push   %ebx
  pushcli();
80103bf5:	e8 56 07 00 00       	call   80104350 <pushcli>
  c = mycpu();
80103bfa:	e8 e1 fb ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103bff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c05:	e8 86 07 00 00       	call   80104390 <popcli>
  if(!holding(&ptable.lock))
80103c0a:	83 ec 0c             	sub    $0xc,%esp
80103c0d:	68 20 2d 11 80       	push   $0x80112d20
80103c12:	e8 e9 07 00 00       	call   80104400 <holding>
80103c17:	83 c4 10             	add    $0x10,%esp
80103c1a:	85 c0                	test   %eax,%eax
80103c1c:	74 4f                	je     80103c6d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c1e:	e8 bd fb ff ff       	call   801037e0 <mycpu>
80103c23:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c2a:	75 68                	jne    80103c94 <sched+0xa4>
  if(p->state == RUNNING)
80103c2c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c30:	74 55                	je     80103c87 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c32:	9c                   	pushf  
80103c33:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c34:	f6 c4 02             	test   $0x2,%ah
80103c37:	75 41                	jne    80103c7a <sched+0x8a>
  intena = mycpu()->intena;
80103c39:	e8 a2 fb ff ff       	call   801037e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c3e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c41:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c47:	e8 94 fb ff ff       	call   801037e0 <mycpu>
80103c4c:	83 ec 08             	sub    $0x8,%esp
80103c4f:	ff 70 04             	pushl  0x4(%eax)
80103c52:	53                   	push   %ebx
80103c53:	e8 13 0b 00 00       	call   8010476b <swtch>
  mycpu()->intena = intena;
80103c58:	e8 83 fb ff ff       	call   801037e0 <mycpu>
}
80103c5d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103c60:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c69:	5b                   	pop    %ebx
80103c6a:	5e                   	pop    %esi
80103c6b:	5d                   	pop    %ebp
80103c6c:	c3                   	ret    
    panic("sched ptable.lock");
80103c6d:	83 ec 0c             	sub    $0xc,%esp
80103c70:	68 30 75 10 80       	push   $0x80107530
80103c75:	e8 f6 c6 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
80103c7a:	83 ec 0c             	sub    $0xc,%esp
80103c7d:	68 5c 75 10 80       	push   $0x8010755c
80103c82:	e8 e9 c6 ff ff       	call   80100370 <panic>
    panic("sched running");
80103c87:	83 ec 0c             	sub    $0xc,%esp
80103c8a:	68 4e 75 10 80       	push   $0x8010754e
80103c8f:	e8 dc c6 ff ff       	call   80100370 <panic>
    panic("sched locks");
80103c94:	83 ec 0c             	sub    $0xc,%esp
80103c97:	68 42 75 10 80       	push   $0x80107542
80103c9c:	e8 cf c6 ff ff       	call   80100370 <panic>
80103ca1:	eb 0d                	jmp    80103cb0 <exit>
80103ca3:	90                   	nop
80103ca4:	90                   	nop
80103ca5:	90                   	nop
80103ca6:	90                   	nop
80103ca7:	90                   	nop
80103ca8:	90                   	nop
80103ca9:	90                   	nop
80103caa:	90                   	nop
80103cab:	90                   	nop
80103cac:	90                   	nop
80103cad:	90                   	nop
80103cae:	90                   	nop
80103caf:	90                   	nop

80103cb0 <exit>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	57                   	push   %edi
80103cb4:	56                   	push   %esi
80103cb5:	53                   	push   %ebx
80103cb6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103cb9:	e8 92 06 00 00       	call   80104350 <pushcli>
  c = mycpu();
80103cbe:	e8 1d fb ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103cc3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103cc9:	e8 c2 06 00 00       	call   80104390 <popcli>
  if(curproc == initproc)
80103cce:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103cd4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103cd7:	8d 7e 68             	lea    0x68(%esi),%edi
80103cda:	0f 84 e7 00 00 00    	je     80103dc7 <exit+0x117>
    if(curproc->ofile[fd]){
80103ce0:	8b 03                	mov    (%ebx),%eax
80103ce2:	85 c0                	test   %eax,%eax
80103ce4:	74 12                	je     80103cf8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103ce6:	83 ec 0c             	sub    $0xc,%esp
80103ce9:	50                   	push   %eax
80103cea:	e8 21 d2 ff ff       	call   80100f10 <fileclose>
      curproc->ofile[fd] = 0;
80103cef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103cf5:	83 c4 10             	add    $0x10,%esp
80103cf8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103cfb:	39 fb                	cmp    %edi,%ebx
80103cfd:	75 e1                	jne    80103ce0 <exit+0x30>
  begin_op();
80103cff:	e8 5c ef ff ff       	call   80102c60 <begin_op>
  iput(curproc->cwd);
80103d04:	83 ec 0c             	sub    $0xc,%esp
80103d07:	ff 76 68             	pushl  0x68(%esi)
80103d0a:	e8 81 db ff ff       	call   80101890 <iput>
  end_op();
80103d0f:	e8 bc ef ff ff       	call   80102cd0 <end_op>
  curproc->cwd = 0;
80103d14:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103d1b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d22:	e8 09 07 00 00       	call   80104430 <acquire>
  wakeup1(curproc->parent);
80103d27:	8b 56 14             	mov    0x14(%esi),%edx
80103d2a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d2d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d32:	eb 0e                	jmp    80103d42 <exit+0x92>
80103d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d38:	83 c0 7c             	add    $0x7c,%eax
80103d3b:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103d40:	73 1c                	jae    80103d5e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103d42:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d46:	75 f0                	jne    80103d38 <exit+0x88>
80103d48:	3b 50 20             	cmp    0x20(%eax),%edx
80103d4b:	75 eb                	jne    80103d38 <exit+0x88>
      p->state = RUNNABLE;
80103d4d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d54:	83 c0 7c             	add    $0x7c,%eax
80103d57:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103d5c:	72 e4                	jb     80103d42 <exit+0x92>
      p->parent = initproc;
80103d5e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80103d64:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103d69:	eb 10                	jmp    80103d7b <exit+0xcb>
80103d6b:	90                   	nop
80103d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d70:	83 c2 7c             	add    $0x7c,%edx
80103d73:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103d79:	73 33                	jae    80103dae <exit+0xfe>
    if(p->parent == curproc){
80103d7b:	39 72 14             	cmp    %esi,0x14(%edx)
80103d7e:	75 f0                	jne    80103d70 <exit+0xc0>
      if(p->state == ZOMBIE)
80103d80:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103d84:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d87:	75 e7                	jne    80103d70 <exit+0xc0>
80103d89:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d8e:	eb 0a                	jmp    80103d9a <exit+0xea>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d90:	83 c0 7c             	add    $0x7c,%eax
80103d93:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103d98:	73 d6                	jae    80103d70 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103d9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d9e:	75 f0                	jne    80103d90 <exit+0xe0>
80103da0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103da3:	75 eb                	jne    80103d90 <exit+0xe0>
      p->state = RUNNABLE;
80103da5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dac:	eb e2                	jmp    80103d90 <exit+0xe0>
  curproc->state = ZOMBIE;
80103dae:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103db5:	e8 36 fe ff ff       	call   80103bf0 <sched>
  panic("zombie exit");
80103dba:	83 ec 0c             	sub    $0xc,%esp
80103dbd:	68 7d 75 10 80       	push   $0x8010757d
80103dc2:	e8 a9 c5 ff ff       	call   80100370 <panic>
    panic("init exiting");
80103dc7:	83 ec 0c             	sub    $0xc,%esp
80103dca:	68 70 75 10 80       	push   $0x80107570
80103dcf:	e8 9c c5 ff ff       	call   80100370 <panic>
80103dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103de0 <yield>:
{
80103de0:	55                   	push   %ebp
80103de1:	89 e5                	mov    %esp,%ebp
80103de3:	53                   	push   %ebx
80103de4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103de7:	68 20 2d 11 80       	push   $0x80112d20
80103dec:	e8 3f 06 00 00       	call   80104430 <acquire>
  pushcli();
80103df1:	e8 5a 05 00 00       	call   80104350 <pushcli>
  c = mycpu();
80103df6:	e8 e5 f9 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103dfb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e01:	e8 8a 05 00 00       	call   80104390 <popcli>
  myproc()->state = RUNNABLE;
80103e06:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e0d:	e8 de fd ff ff       	call   80103bf0 <sched>
  release(&ptable.lock);
80103e12:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e19:	e8 c2 06 00 00       	call   801044e0 <release>
}
80103e1e:	83 c4 10             	add    $0x10,%esp
80103e21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e24:	c9                   	leave  
80103e25:	c3                   	ret    
80103e26:	8d 76 00             	lea    0x0(%esi),%esi
80103e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e30 <sleep>:
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	57                   	push   %edi
80103e34:	56                   	push   %esi
80103e35:	53                   	push   %ebx
80103e36:	83 ec 0c             	sub    $0xc,%esp
80103e39:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e3f:	e8 0c 05 00 00       	call   80104350 <pushcli>
  c = mycpu();
80103e44:	e8 97 f9 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103e49:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e4f:	e8 3c 05 00 00       	call   80104390 <popcli>
  if(p == 0)
80103e54:	85 db                	test   %ebx,%ebx
80103e56:	0f 84 87 00 00 00    	je     80103ee3 <sleep+0xb3>
  if(lk == 0)
80103e5c:	85 f6                	test   %esi,%esi
80103e5e:	74 76                	je     80103ed6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e60:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103e66:	74 50                	je     80103eb8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e68:	83 ec 0c             	sub    $0xc,%esp
80103e6b:	68 20 2d 11 80       	push   $0x80112d20
80103e70:	e8 bb 05 00 00       	call   80104430 <acquire>
    release(lk);
80103e75:	89 34 24             	mov    %esi,(%esp)
80103e78:	e8 63 06 00 00       	call   801044e0 <release>
  p->chan = chan;
80103e7d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e80:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e87:	e8 64 fd ff ff       	call   80103bf0 <sched>
  p->chan = 0;
80103e8c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103e93:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e9a:	e8 41 06 00 00       	call   801044e0 <release>
    acquire(lk);
80103e9f:	89 75 08             	mov    %esi,0x8(%ebp)
80103ea2:	83 c4 10             	add    $0x10,%esp
}
80103ea5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ea8:	5b                   	pop    %ebx
80103ea9:	5e                   	pop    %esi
80103eaa:	5f                   	pop    %edi
80103eab:	5d                   	pop    %ebp
    acquire(lk);
80103eac:	e9 7f 05 00 00       	jmp    80104430 <acquire>
80103eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103eb8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ebb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ec2:	e8 29 fd ff ff       	call   80103bf0 <sched>
  p->chan = 0;
80103ec7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103ece:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ed1:	5b                   	pop    %ebx
80103ed2:	5e                   	pop    %esi
80103ed3:	5f                   	pop    %edi
80103ed4:	5d                   	pop    %ebp
80103ed5:	c3                   	ret    
    panic("sleep without lk");
80103ed6:	83 ec 0c             	sub    $0xc,%esp
80103ed9:	68 8f 75 10 80       	push   $0x8010758f
80103ede:	e8 8d c4 ff ff       	call   80100370 <panic>
    panic("sleep");
80103ee3:	83 ec 0c             	sub    $0xc,%esp
80103ee6:	68 89 75 10 80       	push   $0x80107589
80103eeb:	e8 80 c4 ff ff       	call   80100370 <panic>

80103ef0 <wait>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	56                   	push   %esi
80103ef4:	53                   	push   %ebx
  pushcli();
80103ef5:	e8 56 04 00 00       	call   80104350 <pushcli>
  c = mycpu();
80103efa:	e8 e1 f8 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103eff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f05:	e8 86 04 00 00       	call   80104390 <popcli>
  acquire(&ptable.lock);
80103f0a:	83 ec 0c             	sub    $0xc,%esp
80103f0d:	68 20 2d 11 80       	push   $0x80112d20
80103f12:	e8 19 05 00 00       	call   80104430 <acquire>
80103f17:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f1a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f1c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f21:	eb 10                	jmp    80103f33 <wait+0x43>
80103f23:	90                   	nop
80103f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f28:	83 c3 7c             	add    $0x7c,%ebx
80103f2b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103f31:	73 1d                	jae    80103f50 <wait+0x60>
      if(p->parent != curproc)
80103f33:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f36:	75 f0                	jne    80103f28 <wait+0x38>
      if(p->state == ZOMBIE){
80103f38:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f3c:	74 30                	je     80103f6e <wait+0x7e>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f3e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80103f41:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f46:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103f4c:	72 e5                	jb     80103f33 <wait+0x43>
80103f4e:	66 90                	xchg   %ax,%ax
    if(!havekids || curproc->killed){
80103f50:	85 c0                	test   %eax,%eax
80103f52:	74 70                	je     80103fc4 <wait+0xd4>
80103f54:	8b 46 24             	mov    0x24(%esi),%eax
80103f57:	85 c0                	test   %eax,%eax
80103f59:	75 69                	jne    80103fc4 <wait+0xd4>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f5b:	83 ec 08             	sub    $0x8,%esp
80103f5e:	68 20 2d 11 80       	push   $0x80112d20
80103f63:	56                   	push   %esi
80103f64:	e8 c7 fe ff ff       	call   80103e30 <sleep>
    havekids = 0;
80103f69:	83 c4 10             	add    $0x10,%esp
80103f6c:	eb ac                	jmp    80103f1a <wait+0x2a>
        kfree(p->kstack);
80103f6e:	83 ec 0c             	sub    $0xc,%esp
80103f71:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103f74:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f77:	e8 54 e4 ff ff       	call   801023d0 <kfree>
        freevm(p->pgdir);
80103f7c:	5a                   	pop    %edx
80103f7d:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103f80:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f87:	e8 f4 2c 00 00       	call   80106c80 <freevm>
        p->pid = 0;
80103f8c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f93:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f9a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f9e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fa5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fb3:	e8 28 05 00 00       	call   801044e0 <release>
        return pid;
80103fb8:	83 c4 10             	add    $0x10,%esp
}
80103fbb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fbe:	89 f0                	mov    %esi,%eax
80103fc0:	5b                   	pop    %ebx
80103fc1:	5e                   	pop    %esi
80103fc2:	5d                   	pop    %ebp
80103fc3:	c3                   	ret    
      release(&ptable.lock);
80103fc4:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fc7:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fcc:	68 20 2d 11 80       	push   $0x80112d20
80103fd1:	e8 0a 05 00 00       	call   801044e0 <release>
      return -1;
80103fd6:	83 c4 10             	add    $0x10,%esp
}
80103fd9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fdc:	89 f0                	mov    %esi,%eax
80103fde:	5b                   	pop    %ebx
80103fdf:	5e                   	pop    %esi
80103fe0:	5d                   	pop    %ebp
80103fe1:	c3                   	ret    
80103fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ff0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	53                   	push   %ebx
80103ff4:	83 ec 10             	sub    $0x10,%esp
80103ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103ffa:	68 20 2d 11 80       	push   $0x80112d20
80103fff:	e8 2c 04 00 00       	call   80104430 <acquire>
80104004:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104007:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010400c:	eb 0c                	jmp    8010401a <wakeup+0x2a>
8010400e:	66 90                	xchg   %ax,%ax
80104010:	83 c0 7c             	add    $0x7c,%eax
80104013:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104018:	73 1c                	jae    80104036 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010401a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010401e:	75 f0                	jne    80104010 <wakeup+0x20>
80104020:	3b 58 20             	cmp    0x20(%eax),%ebx
80104023:	75 eb                	jne    80104010 <wakeup+0x20>
      p->state = RUNNABLE;
80104025:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010402c:	83 c0 7c             	add    $0x7c,%eax
8010402f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104034:	72 e4                	jb     8010401a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104036:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010403d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104040:	c9                   	leave  
  release(&ptable.lock);
80104041:	e9 9a 04 00 00       	jmp    801044e0 <release>
80104046:	8d 76 00             	lea    0x0(%esi),%esi
80104049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104050 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 10             	sub    $0x10,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010405a:	68 20 2d 11 80       	push   $0x80112d20
8010405f:	e8 cc 03 00 00       	call   80104430 <acquire>
80104064:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104067:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010406c:	eb 0c                	jmp    8010407a <kill+0x2a>
8010406e:	66 90                	xchg   %ax,%ax
80104070:	83 c0 7c             	add    $0x7c,%eax
80104073:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104078:	73 3e                	jae    801040b8 <kill+0x68>
    if(p->pid == pid){
8010407a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010407d:	75 f1                	jne    80104070 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010407f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104083:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010408a:	74 1c                	je     801040a8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010408c:	83 ec 0c             	sub    $0xc,%esp
8010408f:	68 20 2d 11 80       	push   $0x80112d20
80104094:	e8 47 04 00 00       	call   801044e0 <release>
      return 0;
80104099:	83 c4 10             	add    $0x10,%esp
8010409c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010409e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040a1:	c9                   	leave  
801040a2:	c3                   	ret    
801040a3:	90                   	nop
801040a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->state = RUNNABLE;
801040a8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040af:	eb db                	jmp    8010408c <kill+0x3c>
801040b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801040b8:	83 ec 0c             	sub    $0xc,%esp
801040bb:	68 20 2d 11 80       	push   $0x80112d20
801040c0:	e8 1b 04 00 00       	call   801044e0 <release>
  return -1;
801040c5:	83 c4 10             	add    $0x10,%esp
801040c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d0:	c9                   	leave  
801040d1:	c3                   	ret    
801040d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
801040fb:	68 17 79 10 80       	push   $0x80107917
80104100:	e8 3b c6 ff ff       	call   80100740 <cprintf>
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
80104121:	ba a0 75 10 80       	mov    $0x801075a0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104126:	77 11                	ja     80104139 <procdump+0x59>
80104128:	8b 14 85 00 76 10 80 	mov    -0x7fef8a00(,%eax,4),%edx
      state = "???";
8010412f:	b8 a0 75 10 80       	mov    $0x801075a0,%eax
80104134:	85 d2                	test   %edx,%edx
80104136:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104139:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010413c:	50                   	push   %eax
8010413d:	52                   	push   %edx
8010413e:	ff 73 10             	pushl  0x10(%ebx)
80104141:	68 a4 75 10 80       	push   $0x801075a4
80104146:	e8 f5 c5 ff ff       	call   80100740 <cprintf>
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
8010417d:	68 e1 6f 10 80       	push   $0x80106fe1
80104182:	e8 b9 c5 ff ff       	call   80100740 <cprintf>
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
801041aa:	68 18 76 10 80       	push   $0x80107618
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
801041ef:	e8 3c 02 00 00       	call   80104430 <acquire>
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
80104205:	e8 26 fc ff ff       	call   80103e30 <sleep>
  while (lk->locked) {
8010420a:	8b 03                	mov    (%ebx),%eax
8010420c:	83 c4 10             	add    $0x10,%esp
8010420f:	85 c0                	test   %eax,%eax
80104211:	75 ed                	jne    80104200 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104213:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104219:	e8 62 f6 ff ff       	call   80103880 <myproc>
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
8010422d:	e9 ae 02 00 00       	jmp    801044e0 <release>
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
8010424f:	e8 dc 01 00 00       	call   80104430 <acquire>
  lk->locked = 0;
80104254:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010425a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104261:	89 1c 24             	mov    %ebx,(%esp)
80104264:	e8 87 fd ff ff       	call   80103ff0 <wakeup>
  release(&lk->lk);
80104269:	89 75 08             	mov    %esi,0x8(%ebp)
8010426c:	83 c4 10             	add    $0x10,%esp
}
8010426f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104272:	5b                   	pop    %ebx
80104273:	5e                   	pop    %esi
80104274:	5d                   	pop    %ebp
  release(&lk->lk);
80104275:	e9 66 02 00 00       	jmp    801044e0 <release>
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
80104292:	e8 99 01 00 00       	call   80104430 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104297:	8b 03                	mov    (%ebx),%eax
80104299:	83 c4 10             	add    $0x10,%esp
8010429c:	85 c0                	test   %eax,%eax
8010429e:	74 13                	je     801042b3 <holdingsleep+0x33>
801042a0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801042a3:	e8 d8 f5 ff ff       	call   80103880 <myproc>
801042a8:	39 58 10             	cmp    %ebx,0x10(%eax)
801042ab:	0f 94 c0             	sete   %al
801042ae:	0f b6 c0             	movzbl %al,%eax
801042b1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801042b3:	83 ec 0c             	sub    $0xc,%esp
801042b6:	56                   	push   %esi
801042b7:	e8 24 02 00 00       	call   801044e0 <release>
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
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801042f4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801042f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801042fa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801042fd:	31 c0                	xor    %eax,%eax
801042ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104300:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104306:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010430c:	77 1a                	ja     80104328 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010430e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104311:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104314:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104317:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104319:	83 f8 0a             	cmp    $0xa,%eax
8010431c:	75 e2                	jne    80104300 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010431e:	5b                   	pop    %ebx
8010431f:	5d                   	pop    %ebp
80104320:	c3                   	ret    
80104321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104328:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010432f:	83 c0 01             	add    $0x1,%eax
80104332:	83 f8 0a             	cmp    $0xa,%eax
80104335:	74 e7                	je     8010431e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104337:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010433e:	83 c0 01             	add    $0x1,%eax
80104341:	83 f8 0a             	cmp    $0xa,%eax
80104344:	75 e2                	jne    80104328 <getcallerpcs+0x38>
80104346:	eb d6                	jmp    8010431e <getcallerpcs+0x2e>
80104348:	90                   	nop
80104349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104350 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	53                   	push   %ebx
80104354:	83 ec 04             	sub    $0x4,%esp
80104357:	9c                   	pushf  
80104358:	5b                   	pop    %ebx
  asm volatile("cli");
80104359:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010435a:	e8 81 f4 ff ff       	call   801037e0 <mycpu>
8010435f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104365:	85 c0                	test   %eax,%eax
80104367:	75 11                	jne    8010437a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104369:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010436f:	e8 6c f4 ff ff       	call   801037e0 <mycpu>
80104374:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010437a:	e8 61 f4 ff ff       	call   801037e0 <mycpu>
8010437f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104386:	83 c4 04             	add    $0x4,%esp
80104389:	5b                   	pop    %ebx
8010438a:	5d                   	pop    %ebp
8010438b:	c3                   	ret    
8010438c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104390 <popcli>:

void
popcli(void)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104396:	9c                   	pushf  
80104397:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104398:	f6 c4 02             	test   $0x2,%ah
8010439b:	75 52                	jne    801043ef <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010439d:	e8 3e f4 ff ff       	call   801037e0 <mycpu>
801043a2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801043a8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801043ab:	85 d2                	test   %edx,%edx
801043ad:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801043b3:	78 2d                	js     801043e2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801043b5:	e8 26 f4 ff ff       	call   801037e0 <mycpu>
801043ba:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801043c0:	85 d2                	test   %edx,%edx
801043c2:	74 0c                	je     801043d0 <popcli+0x40>
    sti();
}
801043c4:	c9                   	leave  
801043c5:	c3                   	ret    
801043c6:	8d 76 00             	lea    0x0(%esi),%esi
801043c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801043d0:	e8 0b f4 ff ff       	call   801037e0 <mycpu>
801043d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801043db:	85 c0                	test   %eax,%eax
801043dd:	74 e5                	je     801043c4 <popcli+0x34>
  asm volatile("sti");
801043df:	fb                   	sti    
}
801043e0:	c9                   	leave  
801043e1:	c3                   	ret    
    panic("popcli");
801043e2:	83 ec 0c             	sub    $0xc,%esp
801043e5:	68 3a 76 10 80       	push   $0x8010763a
801043ea:	e8 81 bf ff ff       	call   80100370 <panic>
    panic("popcli - interruptible");
801043ef:	83 ec 0c             	sub    $0xc,%esp
801043f2:	68 23 76 10 80       	push   $0x80107623
801043f7:	e8 74 bf ff ff       	call   80100370 <panic>
801043fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104400 <holding>:
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	8b 75 08             	mov    0x8(%ebp),%esi
80104408:	31 db                	xor    %ebx,%ebx
  pushcli();
8010440a:	e8 41 ff ff ff       	call   80104350 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010440f:	8b 06                	mov    (%esi),%eax
80104411:	85 c0                	test   %eax,%eax
80104413:	74 10                	je     80104425 <holding+0x25>
80104415:	8b 5e 08             	mov    0x8(%esi),%ebx
80104418:	e8 c3 f3 ff ff       	call   801037e0 <mycpu>
8010441d:	39 c3                	cmp    %eax,%ebx
8010441f:	0f 94 c3             	sete   %bl
80104422:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104425:	e8 66 ff ff ff       	call   80104390 <popcli>
}
8010442a:	89 d8                	mov    %ebx,%eax
8010442c:	5b                   	pop    %ebx
8010442d:	5e                   	pop    %esi
8010442e:	5d                   	pop    %ebp
8010442f:	c3                   	ret    

80104430 <acquire>:
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	56                   	push   %esi
80104434:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104435:	e8 16 ff ff ff       	call   80104350 <pushcli>
  if(holding(lk))
8010443a:	8b 75 08             	mov    0x8(%ebp),%esi
8010443d:	83 ec 0c             	sub    $0xc,%esp
80104440:	56                   	push   %esi
80104441:	e8 ba ff ff ff       	call   80104400 <holding>
80104446:	83 c4 10             	add    $0x10,%esp
80104449:	85 c0                	test   %eax,%eax
8010444b:	0f 85 7f 00 00 00    	jne    801044d0 <acquire+0xa0>
80104451:	89 c3                	mov    %eax,%ebx
  asm volatile("lock; xchgl %0, %1" :
80104453:	ba 01 00 00 00       	mov    $0x1,%edx
80104458:	eb 09                	jmp    80104463 <acquire+0x33>
8010445a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104460:	8b 75 08             	mov    0x8(%ebp),%esi
80104463:	89 d0                	mov    %edx,%eax
80104465:	f0 87 06             	lock xchg %eax,(%esi)
  while(xchg(&lk->locked, 1) != 0)
80104468:	85 c0                	test   %eax,%eax
8010446a:	75 f4                	jne    80104460 <acquire+0x30>
  __sync_synchronize();
8010446c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104471:	8b 75 08             	mov    0x8(%ebp),%esi
80104474:	e8 67 f3 ff ff       	call   801037e0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104479:	8d 56 0c             	lea    0xc(%esi),%edx
  lk->cpu = mycpu();
8010447c:	89 46 08             	mov    %eax,0x8(%esi)
  ebp = (uint*)v - 2;
8010447f:	89 e8                	mov    %ebp,%eax
80104481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104488:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010448e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104494:	77 1a                	ja     801044b0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104496:	8b 48 04             	mov    0x4(%eax),%ecx
80104499:	89 0c 9a             	mov    %ecx,(%edx,%ebx,4)
  for(i = 0; i < 10; i++){
8010449c:	83 c3 01             	add    $0x1,%ebx
    ebp = (uint*)ebp[0]; // saved %ebp
8010449f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801044a1:	83 fb 0a             	cmp    $0xa,%ebx
801044a4:	75 e2                	jne    80104488 <acquire+0x58>
}
801044a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044a9:	5b                   	pop    %ebx
801044aa:	5e                   	pop    %esi
801044ab:	5d                   	pop    %ebp
801044ac:	c3                   	ret    
801044ad:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
801044b0:	c7 04 9a 00 00 00 00 	movl   $0x0,(%edx,%ebx,4)
  for(; i < 10; i++)
801044b7:	83 c3 01             	add    $0x1,%ebx
801044ba:	83 fb 0a             	cmp    $0xa,%ebx
801044bd:	74 e7                	je     801044a6 <acquire+0x76>
    pcs[i] = 0;
801044bf:	c7 04 9a 00 00 00 00 	movl   $0x0,(%edx,%ebx,4)
  for(; i < 10; i++)
801044c6:	83 c3 01             	add    $0x1,%ebx
801044c9:	83 fb 0a             	cmp    $0xa,%ebx
801044cc:	75 e2                	jne    801044b0 <acquire+0x80>
801044ce:	eb d6                	jmp    801044a6 <acquire+0x76>
    panic("acquire");
801044d0:	83 ec 0c             	sub    $0xc,%esp
801044d3:	68 41 76 10 80       	push   $0x80107641
801044d8:	e8 93 be ff ff       	call   80100370 <panic>
801044dd:	8d 76 00             	lea    0x0(%esi),%esi

801044e0 <release>:
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	53                   	push   %ebx
801044e4:	83 ec 10             	sub    $0x10,%esp
801044e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801044ea:	53                   	push   %ebx
801044eb:	e8 10 ff ff ff       	call   80104400 <holding>
801044f0:	83 c4 10             	add    $0x10,%esp
801044f3:	85 c0                	test   %eax,%eax
801044f5:	74 22                	je     80104519 <release+0x39>
  lk->pcs[0] = 0;
801044f7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801044fe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104505:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010450a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104510:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104513:	c9                   	leave  
  popcli();
80104514:	e9 77 fe ff ff       	jmp    80104390 <popcli>
    panic("release");
80104519:	83 ec 0c             	sub    $0xc,%esp
8010451c:	68 49 76 10 80       	push   $0x80107649
80104521:	e8 4a be ff ff       	call   80100370 <panic>
80104526:	66 90                	xchg   %ax,%ax
80104528:	66 90                	xchg   %ax,%ax
8010452a:	66 90                	xchg   %ax,%ax
8010452c:	66 90                	xchg   %ax,%ax
8010452e:	66 90                	xchg   %ax,%ax

80104530 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	53                   	push   %ebx
80104535:	8b 55 08             	mov    0x8(%ebp),%edx
80104538:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010453b:	f6 c2 03             	test   $0x3,%dl
8010453e:	75 05                	jne    80104545 <memset+0x15>
80104540:	f6 c1 03             	test   $0x3,%cl
80104543:	74 13                	je     80104558 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104545:	89 d7                	mov    %edx,%edi
80104547:	8b 45 0c             	mov    0xc(%ebp),%eax
8010454a:	fc                   	cld    
8010454b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010454d:	5b                   	pop    %ebx
8010454e:	89 d0                	mov    %edx,%eax
80104550:	5f                   	pop    %edi
80104551:	5d                   	pop    %ebp
80104552:	c3                   	ret    
80104553:	90                   	nop
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104558:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010455c:	c1 e9 02             	shr    $0x2,%ecx
8010455f:	89 f8                	mov    %edi,%eax
80104561:	89 fb                	mov    %edi,%ebx
80104563:	c1 e0 18             	shl    $0x18,%eax
80104566:	c1 e3 10             	shl    $0x10,%ebx
80104569:	09 d8                	or     %ebx,%eax
8010456b:	09 f8                	or     %edi,%eax
8010456d:	c1 e7 08             	shl    $0x8,%edi
80104570:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104572:	89 d7                	mov    %edx,%edi
80104574:	fc                   	cld    
80104575:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104577:	5b                   	pop    %ebx
80104578:	89 d0                	mov    %edx,%eax
8010457a:	5f                   	pop    %edi
8010457b:	5d                   	pop    %ebp
8010457c:	c3                   	ret    
8010457d:	8d 76 00             	lea    0x0(%esi),%esi

80104580 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	57                   	push   %edi
80104584:	56                   	push   %esi
80104585:	53                   	push   %ebx
80104586:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104589:	8b 75 08             	mov    0x8(%ebp),%esi
8010458c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010458f:	85 db                	test   %ebx,%ebx
80104591:	74 29                	je     801045bc <memcmp+0x3c>
    if(*s1 != *s2)
80104593:	0f b6 16             	movzbl (%esi),%edx
80104596:	0f b6 0f             	movzbl (%edi),%ecx
80104599:	38 d1                	cmp    %dl,%cl
8010459b:	75 2b                	jne    801045c8 <memcmp+0x48>
8010459d:	b8 01 00 00 00       	mov    $0x1,%eax
801045a2:	eb 14                	jmp    801045b8 <memcmp+0x38>
801045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801045ac:	83 c0 01             	add    $0x1,%eax
801045af:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801045b4:	38 ca                	cmp    %cl,%dl
801045b6:	75 10                	jne    801045c8 <memcmp+0x48>
  while(n-- > 0){
801045b8:	39 d8                	cmp    %ebx,%eax
801045ba:	75 ec                	jne    801045a8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801045bc:	5b                   	pop    %ebx
  return 0;
801045bd:	31 c0                	xor    %eax,%eax
}
801045bf:	5e                   	pop    %esi
801045c0:	5f                   	pop    %edi
801045c1:	5d                   	pop    %ebp
801045c2:	c3                   	ret    
801045c3:	90                   	nop
801045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801045c8:	0f b6 c2             	movzbl %dl,%eax
}
801045cb:	5b                   	pop    %ebx
      return *s1 - *s2;
801045cc:	29 c8                	sub    %ecx,%eax
}
801045ce:	5e                   	pop    %esi
801045cf:	5f                   	pop    %edi
801045d0:	5d                   	pop    %ebp
801045d1:	c3                   	ret    
801045d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045e0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	56                   	push   %esi
801045e4:	53                   	push   %ebx
801045e5:	8b 45 08             	mov    0x8(%ebp),%eax
801045e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801045eb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801045ee:	39 c3                	cmp    %eax,%ebx
801045f0:	73 26                	jae    80104618 <memmove+0x38>
801045f2:	8d 14 33             	lea    (%ebx,%esi,1),%edx
801045f5:	39 d0                	cmp    %edx,%eax
801045f7:	73 1f                	jae    80104618 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801045f9:	85 f6                	test   %esi,%esi
801045fb:	8d 56 ff             	lea    -0x1(%esi),%edx
801045fe:	74 0f                	je     8010460f <memmove+0x2f>
      *--d = *--s;
80104600:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104604:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104607:	83 ea 01             	sub    $0x1,%edx
8010460a:	83 fa ff             	cmp    $0xffffffff,%edx
8010460d:	75 f1                	jne    80104600 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010460f:	5b                   	pop    %ebx
80104610:	5e                   	pop    %esi
80104611:	5d                   	pop    %ebp
80104612:	c3                   	ret    
80104613:	90                   	nop
80104614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104618:	31 d2                	xor    %edx,%edx
8010461a:	85 f6                	test   %esi,%esi
8010461c:	74 f1                	je     8010460f <memmove+0x2f>
8010461e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104620:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104624:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104627:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010462a:	39 f2                	cmp    %esi,%edx
8010462c:	75 f2                	jne    80104620 <memmove+0x40>
}
8010462e:	5b                   	pop    %ebx
8010462f:	5e                   	pop    %esi
80104630:	5d                   	pop    %ebp
80104631:	c3                   	ret    
80104632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104640 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104643:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104644:	eb 9a                	jmp    801045e0 <memmove>
80104646:	8d 76 00             	lea    0x0(%esi),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	57                   	push   %edi
80104654:	56                   	push   %esi
80104655:	8b 7d 10             	mov    0x10(%ebp),%edi
80104658:	53                   	push   %ebx
80104659:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010465c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010465f:	85 ff                	test   %edi,%edi
80104661:	74 2f                	je     80104692 <strncmp+0x42>
80104663:	0f b6 11             	movzbl (%ecx),%edx
80104666:	0f b6 1e             	movzbl (%esi),%ebx
80104669:	84 d2                	test   %dl,%dl
8010466b:	74 37                	je     801046a4 <strncmp+0x54>
8010466d:	38 d3                	cmp    %dl,%bl
8010466f:	75 33                	jne    801046a4 <strncmp+0x54>
80104671:	01 f7                	add    %esi,%edi
80104673:	eb 13                	jmp    80104688 <strncmp+0x38>
80104675:	8d 76 00             	lea    0x0(%esi),%esi
80104678:	0f b6 11             	movzbl (%ecx),%edx
8010467b:	84 d2                	test   %dl,%dl
8010467d:	74 21                	je     801046a0 <strncmp+0x50>
8010467f:	0f b6 18             	movzbl (%eax),%ebx
80104682:	89 c6                	mov    %eax,%esi
80104684:	38 da                	cmp    %bl,%dl
80104686:	75 1c                	jne    801046a4 <strncmp+0x54>
    n--, p++, q++;
80104688:	8d 46 01             	lea    0x1(%esi),%eax
8010468b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010468e:	39 f8                	cmp    %edi,%eax
80104690:	75 e6                	jne    80104678 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104692:	5b                   	pop    %ebx
    return 0;
80104693:	31 c0                	xor    %eax,%eax
}
80104695:	5e                   	pop    %esi
80104696:	5f                   	pop    %edi
80104697:	5d                   	pop    %ebp
80104698:	c3                   	ret    
80104699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801046a4:	0f b6 c2             	movzbl %dl,%eax
801046a7:	29 d8                	sub    %ebx,%eax
}
801046a9:	5b                   	pop    %ebx
801046aa:	5e                   	pop    %esi
801046ab:	5f                   	pop    %edi
801046ac:	5d                   	pop    %ebp
801046ad:	c3                   	ret    
801046ae:	66 90                	xchg   %ax,%ax

801046b0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
801046b5:	8b 45 08             	mov    0x8(%ebp),%eax
801046b8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801046be:	89 c2                	mov    %eax,%edx
801046c0:	eb 19                	jmp    801046db <strncpy+0x2b>
801046c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046c8:	83 c3 01             	add    $0x1,%ebx
801046cb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046cf:	83 c2 01             	add    $0x1,%edx
801046d2:	84 c9                	test   %cl,%cl
801046d4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046d7:	74 09                	je     801046e2 <strncpy+0x32>
801046d9:	89 f1                	mov    %esi,%ecx
801046db:	85 c9                	test   %ecx,%ecx
801046dd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801046e0:	7f e6                	jg     801046c8 <strncpy+0x18>
    ;
  while(n-- > 0)
801046e2:	31 c9                	xor    %ecx,%ecx
801046e4:	85 f6                	test   %esi,%esi
801046e6:	7e 17                	jle    801046ff <strncpy+0x4f>
801046e8:	90                   	nop
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801046f0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801046f4:	89 f3                	mov    %esi,%ebx
801046f6:	83 c1 01             	add    $0x1,%ecx
801046f9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801046fb:	85 db                	test   %ebx,%ebx
801046fd:	7f f1                	jg     801046f0 <strncpy+0x40>
  return os;
}
801046ff:	5b                   	pop    %ebx
80104700:	5e                   	pop    %esi
80104701:	5d                   	pop    %ebp
80104702:	c3                   	ret    
80104703:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104710 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
80104715:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104718:	8b 45 08             	mov    0x8(%ebp),%eax
8010471b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010471e:	85 c9                	test   %ecx,%ecx
80104720:	7e 26                	jle    80104748 <safestrcpy+0x38>
80104722:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104726:	89 c1                	mov    %eax,%ecx
80104728:	eb 17                	jmp    80104741 <safestrcpy+0x31>
8010472a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104730:	83 c2 01             	add    $0x1,%edx
80104733:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104737:	83 c1 01             	add    $0x1,%ecx
8010473a:	84 db                	test   %bl,%bl
8010473c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010473f:	74 04                	je     80104745 <safestrcpy+0x35>
80104741:	39 f2                	cmp    %esi,%edx
80104743:	75 eb                	jne    80104730 <safestrcpy+0x20>
    ;
  *s = 0;
80104745:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104748:	5b                   	pop    %ebx
80104749:	5e                   	pop    %esi
8010474a:	5d                   	pop    %ebp
8010474b:	c3                   	ret    
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104750 <strlen>:

int
strlen(const char *s)
{
80104750:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104751:	31 c0                	xor    %eax,%eax
{
80104753:	89 e5                	mov    %esp,%ebp
80104755:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104758:	80 3a 00             	cmpb   $0x0,(%edx)
8010475b:	74 0c                	je     80104769 <strlen+0x19>
8010475d:	8d 76 00             	lea    0x0(%esi),%esi
80104760:	83 c0 01             	add    $0x1,%eax
80104763:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104767:	75 f7                	jne    80104760 <strlen+0x10>
    ;
  return n;
}
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    

8010476b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010476b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010476f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104773:	55                   	push   %ebp
  pushl %ebx
80104774:	53                   	push   %ebx
  pushl %esi
80104775:	56                   	push   %esi
  pushl %edi
80104776:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104777:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104779:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010477b:	5f                   	pop    %edi
  popl %esi
8010477c:	5e                   	pop    %esi
  popl %ebx
8010477d:	5b                   	pop    %ebx
  popl %ebp
8010477e:	5d                   	pop    %ebp
  ret
8010477f:	c3                   	ret    

80104780 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 04             	sub    $0x4,%esp
80104787:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010478a:	e8 f1 f0 ff ff       	call   80103880 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010478f:	8b 00                	mov    (%eax),%eax
80104791:	39 d8                	cmp    %ebx,%eax
80104793:	76 1b                	jbe    801047b0 <fetchint+0x30>
80104795:	8d 53 04             	lea    0x4(%ebx),%edx
80104798:	39 d0                	cmp    %edx,%eax
8010479a:	72 14                	jb     801047b0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010479c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010479f:	8b 13                	mov    (%ebx),%edx
801047a1:	89 10                	mov    %edx,(%eax)
  return 0;
801047a3:	31 c0                	xor    %eax,%eax
}
801047a5:	83 c4 04             	add    $0x4,%esp
801047a8:	5b                   	pop    %ebx
801047a9:	5d                   	pop    %ebp
801047aa:	c3                   	ret    
801047ab:	90                   	nop
801047ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801047b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047b5:	eb ee                	jmp    801047a5 <fetchint+0x25>
801047b7:	89 f6                	mov    %esi,%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	53                   	push   %ebx
801047c4:	83 ec 04             	sub    $0x4,%esp
801047c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801047ca:	e8 b1 f0 ff ff       	call   80103880 <myproc>

  if(addr >= curproc->sz)
801047cf:	39 18                	cmp    %ebx,(%eax)
801047d1:	76 29                	jbe    801047fc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801047d3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801047d6:	89 da                	mov    %ebx,%edx
801047d8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801047da:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801047dc:	39 c3                	cmp    %eax,%ebx
801047de:	73 1c                	jae    801047fc <fetchstr+0x3c>
    if(*s == 0)
801047e0:	80 3b 00             	cmpb   $0x0,(%ebx)
801047e3:	75 10                	jne    801047f5 <fetchstr+0x35>
801047e5:	eb 29                	jmp    80104810 <fetchstr+0x50>
801047e7:	89 f6                	mov    %esi,%esi
801047e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801047f0:	80 3a 00             	cmpb   $0x0,(%edx)
801047f3:	74 1b                	je     80104810 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801047f5:	83 c2 01             	add    $0x1,%edx
801047f8:	39 d0                	cmp    %edx,%eax
801047fa:	77 f4                	ja     801047f0 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
801047fc:	83 c4 04             	add    $0x4,%esp
    return -1;
801047ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104804:	5b                   	pop    %ebx
80104805:	5d                   	pop    %ebp
80104806:	c3                   	ret    
80104807:	89 f6                	mov    %esi,%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104810:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
80104813:	89 d0                	mov    %edx,%eax
80104815:	29 d8                	sub    %ebx,%eax
}
80104817:	5b                   	pop    %ebx
80104818:	5d                   	pop    %ebp
80104819:	c3                   	ret    
8010481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
80104825:	e8 56 f0 ff ff       	call   80103880 <myproc>
8010482a:	8b 40 18             	mov    0x18(%eax),%eax
8010482d:	8b 55 08             	mov    0x8(%ebp),%edx
80104830:	8b 40 44             	mov    0x44(%eax),%eax
80104833:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104836:	e8 45 f0 ff ff       	call   80103880 <myproc>
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
8010487b:	e8 00 f0 ff ff       	call   80103880 <myproc>
80104880:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104882:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104885:	83 ec 08             	sub    $0x8,%esp
80104888:	50                   	push   %eax
80104889:	ff 75 08             	pushl  0x8(%ebp)
8010488c:	e8 8f ff ff ff       	call   80104820 <argint>
80104891:	c1 e8 1f             	shr    $0x1f,%eax
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104894:	83 c4 10             	add    $0x10,%esp
80104897:	84 c0                	test   %al,%al
80104899:	75 2d                	jne    801048c8 <argptr+0x58>
8010489b:	89 d8                	mov    %ebx,%eax
8010489d:	c1 e8 1f             	shr    $0x1f,%eax
801048a0:	84 c0                	test   %al,%al
801048a2:	75 24                	jne    801048c8 <argptr+0x58>
801048a4:	8b 16                	mov    (%esi),%edx
801048a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048a9:	39 c2                	cmp    %eax,%edx
801048ab:	76 1b                	jbe    801048c8 <argptr+0x58>
801048ad:	01 c3                	add    %eax,%ebx
801048af:	39 da                	cmp    %ebx,%edx
801048b1:	72 15                	jb     801048c8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
801048b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801048b6:	89 02                	mov    %eax,(%edx)
  return 0;
801048b8:	31 c0                	xor    %eax,%eax
}
801048ba:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048bd:	5b                   	pop    %ebx
801048be:	5e                   	pop    %esi
801048bf:	5d                   	pop    %ebp
801048c0:	c3                   	ret    
801048c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048cd:	eb eb                	jmp    801048ba <argptr+0x4a>
801048cf:	90                   	nop

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
801048f2:	e8 c9 fe ff ff       	call   801047c0 <fetchstr>
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
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104915:	e8 66 ef ff ff       	call   80103880 <myproc>

  num = curproc->tf->eax;
8010491a:	8b 70 18             	mov    0x18(%eax),%esi
  struct proc *curproc = myproc();
8010491d:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
8010491f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104922:	8d 50 ff             	lea    -0x1(%eax),%edx
80104925:	83 fa 14             	cmp    $0x14,%edx
80104928:	77 1e                	ja     80104948 <syscall+0x38>
8010492a:	8b 14 85 80 76 10 80 	mov    -0x7fef8980(,%eax,4),%edx
80104931:	85 d2                	test   %edx,%edx
80104933:	74 13                	je     80104948 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104935:	ff d2                	call   *%edx
80104937:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010493a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010493d:	5b                   	pop    %ebx
8010493e:	5e                   	pop    %esi
8010493f:	5d                   	pop    %ebp
80104940:	c3                   	ret    
80104941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104948:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104949:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010494c:	50                   	push   %eax
8010494d:	ff 73 10             	pushl  0x10(%ebx)
80104950:	68 51 76 10 80       	push   $0x80107651
80104955:	e8 e6 bd ff ff       	call   80100740 <cprintf>
    curproc->tf->eax = -1;
8010495a:	8b 43 18             	mov    0x18(%ebx),%eax
8010495d:	83 c4 10             	add    $0x10,%esp
80104960:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104967:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010496a:	5b                   	pop    %ebx
8010496b:	5e                   	pop    %esi
8010496c:	5d                   	pop    %ebp
8010496d:	c3                   	ret    
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
80104976:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80104979:	83 ec 44             	sub    $0x44,%esp
8010497c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010497f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104982:	53                   	push   %ebx
80104983:	50                   	push   %eax
{
80104984:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104987:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010498a:	e8 41 d6 ff ff       	call   80101fd0 <nameiparent>
8010498f:	83 c4 10             	add    $0x10,%esp
80104992:	85 c0                	test   %eax,%eax
80104994:	0f 84 f6 00 00 00    	je     80104a90 <create+0x120>
    return 0;
  ilock(dp);
8010499a:	83 ec 0c             	sub    $0xc,%esp
8010499d:	89 c6                	mov    %eax,%esi
8010499f:	50                   	push   %eax
801049a0:	e8 bb cd ff ff       	call   80101760 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801049a5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801049a8:	83 c4 0c             	add    $0xc,%esp
801049ab:	50                   	push   %eax
801049ac:	53                   	push   %ebx
801049ad:	56                   	push   %esi
801049ae:	e8 dd d2 ff ff       	call   80101c90 <dirlookup>
801049b3:	83 c4 10             	add    $0x10,%esp
801049b6:	85 c0                	test   %eax,%eax
801049b8:	89 c7                	mov    %eax,%edi
801049ba:	74 54                	je     80104a10 <create+0xa0>
    iunlockput(dp);
801049bc:	83 ec 0c             	sub    $0xc,%esp
801049bf:	56                   	push   %esi
801049c0:	e8 2b d0 ff ff       	call   801019f0 <iunlockput>
    ilock(ip);
801049c5:	89 3c 24             	mov    %edi,(%esp)
801049c8:	e8 93 cd ff ff       	call   80101760 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801049cd:	83 c4 10             	add    $0x10,%esp
801049d0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801049d5:	75 19                	jne    801049f0 <create+0x80>
801049d7:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801049dc:	75 12                	jne    801049f0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801049de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049e1:	89 f8                	mov    %edi,%eax
801049e3:	5b                   	pop    %ebx
801049e4:	5e                   	pop    %esi
801049e5:	5f                   	pop    %edi
801049e6:	5d                   	pop    %ebp
801049e7:	c3                   	ret    
801049e8:	90                   	nop
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801049f0:	83 ec 0c             	sub    $0xc,%esp
801049f3:	57                   	push   %edi
    return 0;
801049f4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801049f6:	e8 f5 cf ff ff       	call   801019f0 <iunlockput>
    return 0;
801049fb:	83 c4 10             	add    $0x10,%esp
}
801049fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a01:	89 f8                	mov    %edi,%eax
80104a03:	5b                   	pop    %ebx
80104a04:	5e                   	pop    %esi
80104a05:	5f                   	pop    %edi
80104a06:	5d                   	pop    %ebp
80104a07:	c3                   	ret    
80104a08:	90                   	nop
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80104a10:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104a14:	83 ec 08             	sub    $0x8,%esp
80104a17:	50                   	push   %eax
80104a18:	ff 36                	pushl  (%esi)
80104a1a:	e8 d1 cb ff ff       	call   801015f0 <ialloc>
80104a1f:	83 c4 10             	add    $0x10,%esp
80104a22:	85 c0                	test   %eax,%eax
80104a24:	89 c7                	mov    %eax,%edi
80104a26:	0f 84 cc 00 00 00    	je     80104af8 <create+0x188>
  ilock(ip);
80104a2c:	83 ec 0c             	sub    $0xc,%esp
80104a2f:	50                   	push   %eax
80104a30:	e8 2b cd ff ff       	call   80101760 <ilock>
  ip->major = major;
80104a35:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104a39:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104a3d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104a41:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104a45:	b8 01 00 00 00       	mov    $0x1,%eax
80104a4a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104a4e:	89 3c 24             	mov    %edi,(%esp)
80104a51:	e8 5a cc ff ff       	call   801016b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104a56:	83 c4 10             	add    $0x10,%esp
80104a59:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104a5e:	74 40                	je     80104aa0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80104a60:	83 ec 04             	sub    $0x4,%esp
80104a63:	ff 77 04             	pushl  0x4(%edi)
80104a66:	53                   	push   %ebx
80104a67:	56                   	push   %esi
80104a68:	e8 83 d4 ff ff       	call   80101ef0 <dirlink>
80104a6d:	83 c4 10             	add    $0x10,%esp
80104a70:	85 c0                	test   %eax,%eax
80104a72:	78 77                	js     80104aeb <create+0x17b>
  iunlockput(dp);
80104a74:	83 ec 0c             	sub    $0xc,%esp
80104a77:	56                   	push   %esi
80104a78:	e8 73 cf ff ff       	call   801019f0 <iunlockput>
  return ip;
80104a7d:	83 c4 10             	add    $0x10,%esp
}
80104a80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a83:	89 f8                	mov    %edi,%eax
80104a85:	5b                   	pop    %ebx
80104a86:	5e                   	pop    %esi
80104a87:	5f                   	pop    %edi
80104a88:	5d                   	pop    %ebp
80104a89:	c3                   	ret    
80104a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return 0;
80104a90:	31 ff                	xor    %edi,%edi
80104a92:	e9 47 ff ff ff       	jmp    801049de <create+0x6e>
80104a97:	89 f6                	mov    %esi,%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    dp->nlink++;  // for ".."
80104aa0:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104aa5:	83 ec 0c             	sub    $0xc,%esp
80104aa8:	56                   	push   %esi
80104aa9:	e8 02 cc ff ff       	call   801016b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104aae:	83 c4 0c             	add    $0xc,%esp
80104ab1:	ff 77 04             	pushl  0x4(%edi)
80104ab4:	68 f4 76 10 80       	push   $0x801076f4
80104ab9:	57                   	push   %edi
80104aba:	e8 31 d4 ff ff       	call   80101ef0 <dirlink>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	85 c0                	test   %eax,%eax
80104ac4:	78 18                	js     80104ade <create+0x16e>
80104ac6:	83 ec 04             	sub    $0x4,%esp
80104ac9:	ff 76 04             	pushl  0x4(%esi)
80104acc:	68 f3 76 10 80       	push   $0x801076f3
80104ad1:	57                   	push   %edi
80104ad2:	e8 19 d4 ff ff       	call   80101ef0 <dirlink>
80104ad7:	83 c4 10             	add    $0x10,%esp
80104ada:	85 c0                	test   %eax,%eax
80104adc:	79 82                	jns    80104a60 <create+0xf0>
      panic("create dots");
80104ade:	83 ec 0c             	sub    $0xc,%esp
80104ae1:	68 e7 76 10 80       	push   $0x801076e7
80104ae6:	e8 85 b8 ff ff       	call   80100370 <panic>
    panic("create: dirlink");
80104aeb:	83 ec 0c             	sub    $0xc,%esp
80104aee:	68 f6 76 10 80       	push   $0x801076f6
80104af3:	e8 78 b8 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
80104af8:	83 ec 0c             	sub    $0xc,%esp
80104afb:	68 d8 76 10 80       	push   $0x801076d8
80104b00:	e8 6b b8 ff ff       	call   80100370 <panic>
80104b05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b10 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	56                   	push   %esi
80104b14:	53                   	push   %ebx
80104b15:	89 c6                	mov    %eax,%esi
  if(argint(n, &fd) < 0)
80104b17:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104b1a:	89 d3                	mov    %edx,%ebx
80104b1c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104b1f:	50                   	push   %eax
80104b20:	6a 00                	push   $0x0
80104b22:	e8 f9 fc ff ff       	call   80104820 <argint>
80104b27:	83 c4 10             	add    $0x10,%esp
80104b2a:	85 c0                	test   %eax,%eax
80104b2c:	78 32                	js     80104b60 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104b2e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104b32:	77 2c                	ja     80104b60 <argfd.constprop.0+0x50>
80104b34:	e8 47 ed ff ff       	call   80103880 <myproc>
80104b39:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b3c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104b40:	85 c0                	test   %eax,%eax
80104b42:	74 1c                	je     80104b60 <argfd.constprop.0+0x50>
  if(pfd)
80104b44:	85 f6                	test   %esi,%esi
80104b46:	74 02                	je     80104b4a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104b48:	89 16                	mov    %edx,(%esi)
  if(pf)
80104b4a:	85 db                	test   %ebx,%ebx
80104b4c:	74 22                	je     80104b70 <argfd.constprop.0+0x60>
    *pf = f;
80104b4e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104b50:	31 c0                	xor    %eax,%eax
}
80104b52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b55:	5b                   	pop    %ebx
80104b56:	5e                   	pop    %esi
80104b57:	5d                   	pop    %ebp
80104b58:	c3                   	ret    
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b60:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104b63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b68:	5b                   	pop    %ebx
80104b69:	5e                   	pop    %esi
80104b6a:	5d                   	pop    %ebp
80104b6b:	c3                   	ret    
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
80104b70:	31 c0                	xor    %eax,%eax
80104b72:	eb de                	jmp    80104b52 <argfd.constprop.0+0x42>
80104b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b80 <sys_dup>:
{
80104b80:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104b81:	31 c0                	xor    %eax,%eax
{
80104b83:	89 e5                	mov    %esp,%ebp
80104b85:	56                   	push   %esi
80104b86:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104b87:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104b8a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104b8d:	e8 7e ff ff ff       	call   80104b10 <argfd.constprop.0>
80104b92:	85 c0                	test   %eax,%eax
80104b94:	78 1a                	js     80104bb0 <sys_dup+0x30>
  for(fd = 0; fd < NOFILE; fd++){
80104b96:	31 db                	xor    %ebx,%ebx
  if((fd=fdalloc(f)) < 0)
80104b98:	8b 75 f4             	mov    -0xc(%ebp),%esi
  struct proc *curproc = myproc();
80104b9b:	e8 e0 ec ff ff       	call   80103880 <myproc>
    if(curproc->ofile[fd] == 0){
80104ba0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ba4:	85 d2                	test   %edx,%edx
80104ba6:	74 18                	je     80104bc0 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104ba8:	83 c3 01             	add    $0x1,%ebx
80104bab:	83 fb 10             	cmp    $0x10,%ebx
80104bae:	75 f0                	jne    80104ba0 <sys_dup+0x20>
}
80104bb0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104bb3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104bb8:	89 d8                	mov    %ebx,%eax
80104bba:	5b                   	pop    %ebx
80104bbb:	5e                   	pop    %esi
80104bbc:	5d                   	pop    %ebp
80104bbd:	c3                   	ret    
80104bbe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80104bc0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104bc4:	83 ec 0c             	sub    $0xc,%esp
80104bc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104bca:	e8 f1 c2 ff ff       	call   80100ec0 <filedup>
  return fd;
80104bcf:	83 c4 10             	add    $0x10,%esp
}
80104bd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bd5:	89 d8                	mov    %ebx,%eax
80104bd7:	5b                   	pop    %ebx
80104bd8:	5e                   	pop    %esi
80104bd9:	5d                   	pop    %ebp
80104bda:	c3                   	ret    
80104bdb:	90                   	nop
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104be0 <sys_read>:
{
80104be0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104be1:	31 c0                	xor    %eax,%eax
{
80104be3:	89 e5                	mov    %esp,%ebp
80104be5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104be8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104beb:	e8 20 ff ff ff       	call   80104b10 <argfd.constprop.0>
80104bf0:	85 c0                	test   %eax,%eax
80104bf2:	78 4c                	js     80104c40 <sys_read+0x60>
80104bf4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104bf7:	83 ec 08             	sub    $0x8,%esp
80104bfa:	50                   	push   %eax
80104bfb:	6a 02                	push   $0x2
80104bfd:	e8 1e fc ff ff       	call   80104820 <argint>
80104c02:	83 c4 10             	add    $0x10,%esp
80104c05:	85 c0                	test   %eax,%eax
80104c07:	78 37                	js     80104c40 <sys_read+0x60>
80104c09:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c0c:	83 ec 04             	sub    $0x4,%esp
80104c0f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c12:	50                   	push   %eax
80104c13:	6a 01                	push   $0x1
80104c15:	e8 56 fc ff ff       	call   80104870 <argptr>
80104c1a:	83 c4 10             	add    $0x10,%esp
80104c1d:	85 c0                	test   %eax,%eax
80104c1f:	78 1f                	js     80104c40 <sys_read+0x60>
  return fileread(f, p, n);
80104c21:	83 ec 04             	sub    $0x4,%esp
80104c24:	ff 75 f0             	pushl  -0x10(%ebp)
80104c27:	ff 75 f4             	pushl  -0xc(%ebp)
80104c2a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c2d:	e8 fe c3 ff ff       	call   80101030 <fileread>
80104c32:	83 c4 10             	add    $0x10,%esp
}
80104c35:	c9                   	leave  
80104c36:	c3                   	ret    
80104c37:	89 f6                	mov    %esi,%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104c40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c45:	c9                   	leave  
80104c46:	c3                   	ret    
80104c47:	89 f6                	mov    %esi,%esi
80104c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c50 <sys_write>:
{
80104c50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c51:	31 c0                	xor    %eax,%eax
{
80104c53:	89 e5                	mov    %esp,%ebp
80104c55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c5b:	e8 b0 fe ff ff       	call   80104b10 <argfd.constprop.0>
80104c60:	85 c0                	test   %eax,%eax
80104c62:	78 4c                	js     80104cb0 <sys_write+0x60>
80104c64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c67:	83 ec 08             	sub    $0x8,%esp
80104c6a:	50                   	push   %eax
80104c6b:	6a 02                	push   $0x2
80104c6d:	e8 ae fb ff ff       	call   80104820 <argint>
80104c72:	83 c4 10             	add    $0x10,%esp
80104c75:	85 c0                	test   %eax,%eax
80104c77:	78 37                	js     80104cb0 <sys_write+0x60>
80104c79:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c7c:	83 ec 04             	sub    $0x4,%esp
80104c7f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c82:	50                   	push   %eax
80104c83:	6a 01                	push   $0x1
80104c85:	e8 e6 fb ff ff       	call   80104870 <argptr>
80104c8a:	83 c4 10             	add    $0x10,%esp
80104c8d:	85 c0                	test   %eax,%eax
80104c8f:	78 1f                	js     80104cb0 <sys_write+0x60>
  return filewrite(f, p, n);
80104c91:	83 ec 04             	sub    $0x4,%esp
80104c94:	ff 75 f0             	pushl  -0x10(%ebp)
80104c97:	ff 75 f4             	pushl  -0xc(%ebp)
80104c9a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c9d:	e8 1e c4 ff ff       	call   801010c0 <filewrite>
80104ca2:	83 c4 10             	add    $0x10,%esp
}
80104ca5:	c9                   	leave  
80104ca6:	c3                   	ret    
80104ca7:	89 f6                	mov    %esi,%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cb5:	c9                   	leave  
80104cb6:	c3                   	ret    
80104cb7:	89 f6                	mov    %esi,%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cc0 <sys_close>:
{
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104cc6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104cc9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ccc:	e8 3f fe ff ff       	call   80104b10 <argfd.constprop.0>
80104cd1:	85 c0                	test   %eax,%eax
80104cd3:	78 2b                	js     80104d00 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104cd5:	e8 a6 eb ff ff       	call   80103880 <myproc>
80104cda:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104cdd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104ce0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104ce7:	00 
  fileclose(f);
80104ce8:	ff 75 f4             	pushl  -0xc(%ebp)
80104ceb:	e8 20 c2 ff ff       	call   80100f10 <fileclose>
  return 0;
80104cf0:	83 c4 10             	add    $0x10,%esp
80104cf3:	31 c0                	xor    %eax,%eax
}
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d05:	c9                   	leave  
80104d06:	c3                   	ret    
80104d07:	89 f6                	mov    %esi,%esi
80104d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d10 <sys_fstat>:
{
80104d10:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d11:	31 c0                	xor    %eax,%eax
{
80104d13:	89 e5                	mov    %esp,%ebp
80104d15:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d18:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d1b:	e8 f0 fd ff ff       	call   80104b10 <argfd.constprop.0>
80104d20:	85 c0                	test   %eax,%eax
80104d22:	78 2c                	js     80104d50 <sys_fstat+0x40>
80104d24:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d27:	83 ec 04             	sub    $0x4,%esp
80104d2a:	6a 14                	push   $0x14
80104d2c:	50                   	push   %eax
80104d2d:	6a 01                	push   $0x1
80104d2f:	e8 3c fb ff ff       	call   80104870 <argptr>
80104d34:	83 c4 10             	add    $0x10,%esp
80104d37:	85 c0                	test   %eax,%eax
80104d39:	78 15                	js     80104d50 <sys_fstat+0x40>
  return filestat(f, st);
80104d3b:	83 ec 08             	sub    $0x8,%esp
80104d3e:	ff 75 f4             	pushl  -0xc(%ebp)
80104d41:	ff 75 f0             	pushl  -0x10(%ebp)
80104d44:	e8 97 c2 ff ff       	call   80100fe0 <filestat>
80104d49:	83 c4 10             	add    $0x10,%esp
}
80104d4c:	c9                   	leave  
80104d4d:	c3                   	ret    
80104d4e:	66 90                	xchg   %ax,%ax
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d55:	c9                   	leave  
80104d56:	c3                   	ret    
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <sys_link>:
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	57                   	push   %edi
80104d64:	56                   	push   %esi
80104d65:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d66:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104d69:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d6c:	50                   	push   %eax
80104d6d:	6a 00                	push   $0x0
80104d6f:	e8 5c fb ff ff       	call   801048d0 <argstr>
80104d74:	83 c4 10             	add    $0x10,%esp
80104d77:	85 c0                	test   %eax,%eax
80104d79:	0f 88 fb 00 00 00    	js     80104e7a <sys_link+0x11a>
80104d7f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104d82:	83 ec 08             	sub    $0x8,%esp
80104d85:	50                   	push   %eax
80104d86:	6a 01                	push   $0x1
80104d88:	e8 43 fb ff ff       	call   801048d0 <argstr>
80104d8d:	83 c4 10             	add    $0x10,%esp
80104d90:	85 c0                	test   %eax,%eax
80104d92:	0f 88 e2 00 00 00    	js     80104e7a <sys_link+0x11a>
  begin_op();
80104d98:	e8 c3 de ff ff       	call   80102c60 <begin_op>
  if((ip = namei(old)) == 0){
80104d9d:	83 ec 0c             	sub    $0xc,%esp
80104da0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104da3:	e8 08 d2 ff ff       	call   80101fb0 <namei>
80104da8:	83 c4 10             	add    $0x10,%esp
80104dab:	85 c0                	test   %eax,%eax
80104dad:	89 c3                	mov    %eax,%ebx
80104daf:	0f 84 f3 00 00 00    	je     80104ea8 <sys_link+0x148>
  ilock(ip);
80104db5:	83 ec 0c             	sub    $0xc,%esp
80104db8:	50                   	push   %eax
80104db9:	e8 a2 c9 ff ff       	call   80101760 <ilock>
  if(ip->type == T_DIR){
80104dbe:	83 c4 10             	add    $0x10,%esp
80104dc1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104dc6:	0f 84 c4 00 00 00    	je     80104e90 <sys_link+0x130>
  ip->nlink++;
80104dcc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104dd1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104dd4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104dd7:	53                   	push   %ebx
80104dd8:	e8 d3 c8 ff ff       	call   801016b0 <iupdate>
  iunlock(ip);
80104ddd:	89 1c 24             	mov    %ebx,(%esp)
80104de0:	e8 5b ca ff ff       	call   80101840 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104de5:	58                   	pop    %eax
80104de6:	5a                   	pop    %edx
80104de7:	57                   	push   %edi
80104de8:	ff 75 d0             	pushl  -0x30(%ebp)
80104deb:	e8 e0 d1 ff ff       	call   80101fd0 <nameiparent>
80104df0:	83 c4 10             	add    $0x10,%esp
80104df3:	85 c0                	test   %eax,%eax
80104df5:	89 c6                	mov    %eax,%esi
80104df7:	74 5b                	je     80104e54 <sys_link+0xf4>
  ilock(dp);
80104df9:	83 ec 0c             	sub    $0xc,%esp
80104dfc:	50                   	push   %eax
80104dfd:	e8 5e c9 ff ff       	call   80101760 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104e02:	83 c4 10             	add    $0x10,%esp
80104e05:	8b 03                	mov    (%ebx),%eax
80104e07:	39 06                	cmp    %eax,(%esi)
80104e09:	75 3d                	jne    80104e48 <sys_link+0xe8>
80104e0b:	83 ec 04             	sub    $0x4,%esp
80104e0e:	ff 73 04             	pushl  0x4(%ebx)
80104e11:	57                   	push   %edi
80104e12:	56                   	push   %esi
80104e13:	e8 d8 d0 ff ff       	call   80101ef0 <dirlink>
80104e18:	83 c4 10             	add    $0x10,%esp
80104e1b:	85 c0                	test   %eax,%eax
80104e1d:	78 29                	js     80104e48 <sys_link+0xe8>
  iunlockput(dp);
80104e1f:	83 ec 0c             	sub    $0xc,%esp
80104e22:	56                   	push   %esi
80104e23:	e8 c8 cb ff ff       	call   801019f0 <iunlockput>
  iput(ip);
80104e28:	89 1c 24             	mov    %ebx,(%esp)
80104e2b:	e8 60 ca ff ff       	call   80101890 <iput>
  end_op();
80104e30:	e8 9b de ff ff       	call   80102cd0 <end_op>
  return 0;
80104e35:	83 c4 10             	add    $0x10,%esp
80104e38:	31 c0                	xor    %eax,%eax
}
80104e3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e3d:	5b                   	pop    %ebx
80104e3e:	5e                   	pop    %esi
80104e3f:	5f                   	pop    %edi
80104e40:	5d                   	pop    %ebp
80104e41:	c3                   	ret    
80104e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104e48:	83 ec 0c             	sub    $0xc,%esp
80104e4b:	56                   	push   %esi
80104e4c:	e8 9f cb ff ff       	call   801019f0 <iunlockput>
    goto bad;
80104e51:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104e54:	83 ec 0c             	sub    $0xc,%esp
80104e57:	53                   	push   %ebx
80104e58:	e8 03 c9 ff ff       	call   80101760 <ilock>
  ip->nlink--;
80104e5d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e62:	89 1c 24             	mov    %ebx,(%esp)
80104e65:	e8 46 c8 ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
80104e6a:	89 1c 24             	mov    %ebx,(%esp)
80104e6d:	e8 7e cb ff ff       	call   801019f0 <iunlockput>
  end_op();
80104e72:	e8 59 de ff ff       	call   80102cd0 <end_op>
  return -1;
80104e77:	83 c4 10             	add    $0x10,%esp
}
80104e7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104e7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e82:	5b                   	pop    %ebx
80104e83:	5e                   	pop    %esi
80104e84:	5f                   	pop    %edi
80104e85:	5d                   	pop    %ebp
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80104e90:	83 ec 0c             	sub    $0xc,%esp
80104e93:	53                   	push   %ebx
80104e94:	e8 57 cb ff ff       	call   801019f0 <iunlockput>
    end_op();
80104e99:	e8 32 de ff ff       	call   80102cd0 <end_op>
    return -1;
80104e9e:	83 c4 10             	add    $0x10,%esp
80104ea1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ea6:	eb 92                	jmp    80104e3a <sys_link+0xda>
    end_op();
80104ea8:	e8 23 de ff ff       	call   80102cd0 <end_op>
    return -1;
80104ead:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104eb2:	eb 86                	jmp    80104e3a <sys_link+0xda>
80104eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ec0 <sys_unlink>:
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	57                   	push   %edi
80104ec4:	56                   	push   %esi
80104ec5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104ec6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104ec9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80104ecc:	50                   	push   %eax
80104ecd:	6a 00                	push   $0x0
80104ecf:	e8 fc f9 ff ff       	call   801048d0 <argstr>
80104ed4:	83 c4 10             	add    $0x10,%esp
80104ed7:	85 c0                	test   %eax,%eax
80104ed9:	0f 88 82 01 00 00    	js     80105061 <sys_unlink+0x1a1>
  if((dp = nameiparent(path, name)) == 0){
80104edf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104ee2:	e8 79 dd ff ff       	call   80102c60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104ee7:	83 ec 08             	sub    $0x8,%esp
80104eea:	53                   	push   %ebx
80104eeb:	ff 75 c0             	pushl  -0x40(%ebp)
80104eee:	e8 dd d0 ff ff       	call   80101fd0 <nameiparent>
80104ef3:	83 c4 10             	add    $0x10,%esp
80104ef6:	85 c0                	test   %eax,%eax
80104ef8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104efb:	0f 84 6a 01 00 00    	je     8010506b <sys_unlink+0x1ab>
  ilock(dp);
80104f01:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104f04:	83 ec 0c             	sub    $0xc,%esp
80104f07:	56                   	push   %esi
80104f08:	e8 53 c8 ff ff       	call   80101760 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104f0d:	58                   	pop    %eax
80104f0e:	5a                   	pop    %edx
80104f0f:	68 f4 76 10 80       	push   $0x801076f4
80104f14:	53                   	push   %ebx
80104f15:	e8 56 cd ff ff       	call   80101c70 <namecmp>
80104f1a:	83 c4 10             	add    $0x10,%esp
80104f1d:	85 c0                	test   %eax,%eax
80104f1f:	0f 84 fc 00 00 00    	je     80105021 <sys_unlink+0x161>
80104f25:	83 ec 08             	sub    $0x8,%esp
80104f28:	68 f3 76 10 80       	push   $0x801076f3
80104f2d:	53                   	push   %ebx
80104f2e:	e8 3d cd ff ff       	call   80101c70 <namecmp>
80104f33:	83 c4 10             	add    $0x10,%esp
80104f36:	85 c0                	test   %eax,%eax
80104f38:	0f 84 e3 00 00 00    	je     80105021 <sys_unlink+0x161>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104f3e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104f41:	83 ec 04             	sub    $0x4,%esp
80104f44:	50                   	push   %eax
80104f45:	53                   	push   %ebx
80104f46:	56                   	push   %esi
80104f47:	e8 44 cd ff ff       	call   80101c90 <dirlookup>
80104f4c:	83 c4 10             	add    $0x10,%esp
80104f4f:	85 c0                	test   %eax,%eax
80104f51:	89 c3                	mov    %eax,%ebx
80104f53:	0f 84 c8 00 00 00    	je     80105021 <sys_unlink+0x161>
  ilock(ip);
80104f59:	83 ec 0c             	sub    $0xc,%esp
80104f5c:	50                   	push   %eax
80104f5d:	e8 fe c7 ff ff       	call   80101760 <ilock>
  if(ip->nlink < 1)
80104f62:	83 c4 10             	add    $0x10,%esp
80104f65:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104f6a:	0f 8e 24 01 00 00    	jle    80105094 <sys_unlink+0x1d4>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104f70:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f75:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104f78:	74 66                	je     80104fe0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80104f7a:	83 ec 04             	sub    $0x4,%esp
80104f7d:	6a 10                	push   $0x10
80104f7f:	6a 00                	push   $0x0
80104f81:	56                   	push   %esi
80104f82:	e8 a9 f5 ff ff       	call   80104530 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f87:	6a 10                	push   $0x10
80104f89:	ff 75 c4             	pushl  -0x3c(%ebp)
80104f8c:	56                   	push   %esi
80104f8d:	ff 75 b4             	pushl  -0x4c(%ebp)
80104f90:	e8 ab cb ff ff       	call   80101b40 <writei>
80104f95:	83 c4 20             	add    $0x20,%esp
80104f98:	83 f8 10             	cmp    $0x10,%eax
80104f9b:	0f 85 e6 00 00 00    	jne    80105087 <sys_unlink+0x1c7>
  if(ip->type == T_DIR){
80104fa1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fa6:	0f 84 9c 00 00 00    	je     80105048 <sys_unlink+0x188>
  iunlockput(dp);
80104fac:	83 ec 0c             	sub    $0xc,%esp
80104faf:	ff 75 b4             	pushl  -0x4c(%ebp)
80104fb2:	e8 39 ca ff ff       	call   801019f0 <iunlockput>
  ip->nlink--;
80104fb7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fbc:	89 1c 24             	mov    %ebx,(%esp)
80104fbf:	e8 ec c6 ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
80104fc4:	89 1c 24             	mov    %ebx,(%esp)
80104fc7:	e8 24 ca ff ff       	call   801019f0 <iunlockput>
  end_op();
80104fcc:	e8 ff dc ff ff       	call   80102cd0 <end_op>
  return 0;
80104fd1:	83 c4 10             	add    $0x10,%esp
80104fd4:	31 c0                	xor    %eax,%eax
}
80104fd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fd9:	5b                   	pop    %ebx
80104fda:	5e                   	pop    %esi
80104fdb:	5f                   	pop    %edi
80104fdc:	5d                   	pop    %ebp
80104fdd:	c3                   	ret    
80104fde:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104fe0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104fe4:	76 94                	jbe    80104f7a <sys_unlink+0xba>
80104fe6:	bf 20 00 00 00       	mov    $0x20,%edi
80104feb:	eb 0f                	jmp    80104ffc <sys_unlink+0x13c>
80104fed:	8d 76 00             	lea    0x0(%esi),%esi
80104ff0:	83 c7 10             	add    $0x10,%edi
80104ff3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80104ff6:	0f 83 7e ff ff ff    	jae    80104f7a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104ffc:	6a 10                	push   $0x10
80104ffe:	57                   	push   %edi
80104fff:	56                   	push   %esi
80105000:	53                   	push   %ebx
80105001:	e8 3a ca ff ff       	call   80101a40 <readi>
80105006:	83 c4 10             	add    $0x10,%esp
80105009:	83 f8 10             	cmp    $0x10,%eax
8010500c:	75 6c                	jne    8010507a <sys_unlink+0x1ba>
    if(de.inum != 0)
8010500e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105013:	74 db                	je     80104ff0 <sys_unlink+0x130>
    iunlockput(ip);
80105015:	83 ec 0c             	sub    $0xc,%esp
80105018:	53                   	push   %ebx
80105019:	e8 d2 c9 ff ff       	call   801019f0 <iunlockput>
    goto bad;
8010501e:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105021:	83 ec 0c             	sub    $0xc,%esp
80105024:	ff 75 b4             	pushl  -0x4c(%ebp)
80105027:	e8 c4 c9 ff ff       	call   801019f0 <iunlockput>
  end_op();
8010502c:	e8 9f dc ff ff       	call   80102cd0 <end_op>
  return -1;
80105031:	83 c4 10             	add    $0x10,%esp
}
80105034:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80105037:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010503c:	5b                   	pop    %ebx
8010503d:	5e                   	pop    %esi
8010503e:	5f                   	pop    %edi
8010503f:	5d                   	pop    %ebp
80105040:	c3                   	ret    
80105041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105048:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010504b:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
8010504e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105053:	50                   	push   %eax
80105054:	e8 57 c6 ff ff       	call   801016b0 <iupdate>
80105059:	83 c4 10             	add    $0x10,%esp
8010505c:	e9 4b ff ff ff       	jmp    80104fac <sys_unlink+0xec>
    return -1;
80105061:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105066:	e9 6b ff ff ff       	jmp    80104fd6 <sys_unlink+0x116>
    end_op();
8010506b:	e8 60 dc ff ff       	call   80102cd0 <end_op>
    return -1;
80105070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105075:	e9 5c ff ff ff       	jmp    80104fd6 <sys_unlink+0x116>
      panic("isdirempty: readi");
8010507a:	83 ec 0c             	sub    $0xc,%esp
8010507d:	68 18 77 10 80       	push   $0x80107718
80105082:	e8 e9 b2 ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80105087:	83 ec 0c             	sub    $0xc,%esp
8010508a:	68 2a 77 10 80       	push   $0x8010772a
8010508f:	e8 dc b2 ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
80105094:	83 ec 0c             	sub    $0xc,%esp
80105097:	68 06 77 10 80       	push   $0x80107706
8010509c:	e8 cf b2 ff ff       	call   80100370 <panic>
801050a1:	eb 0d                	jmp    801050b0 <sys_open>
801050a3:	90                   	nop
801050a4:	90                   	nop
801050a5:	90                   	nop
801050a6:	90                   	nop
801050a7:	90                   	nop
801050a8:	90                   	nop
801050a9:	90                   	nop
801050aa:	90                   	nop
801050ab:	90                   	nop
801050ac:	90                   	nop
801050ad:	90                   	nop
801050ae:	90                   	nop
801050af:	90                   	nop

801050b0 <sys_open>:

int
sys_open(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	57                   	push   %edi
801050b4:	56                   	push   %esi
801050b5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050b6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801050b9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050bc:	50                   	push   %eax
801050bd:	6a 00                	push   $0x0
801050bf:	e8 0c f8 ff ff       	call   801048d0 <argstr>
801050c4:	83 c4 10             	add    $0x10,%esp
801050c7:	85 c0                	test   %eax,%eax
801050c9:	0f 88 9e 00 00 00    	js     8010516d <sys_open+0xbd>
801050cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801050d2:	83 ec 08             	sub    $0x8,%esp
801050d5:	50                   	push   %eax
801050d6:	6a 01                	push   $0x1
801050d8:	e8 43 f7 ff ff       	call   80104820 <argint>
801050dd:	83 c4 10             	add    $0x10,%esp
801050e0:	85 c0                	test   %eax,%eax
801050e2:	0f 88 85 00 00 00    	js     8010516d <sys_open+0xbd>
    return -1;

  begin_op();
801050e8:	e8 73 db ff ff       	call   80102c60 <begin_op>

  if(omode & O_CREATE){
801050ed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801050f1:	0f 85 89 00 00 00    	jne    80105180 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801050f7:	83 ec 0c             	sub    $0xc,%esp
801050fa:	ff 75 e0             	pushl  -0x20(%ebp)
801050fd:	e8 ae ce ff ff       	call   80101fb0 <namei>
80105102:	83 c4 10             	add    $0x10,%esp
80105105:	85 c0                	test   %eax,%eax
80105107:	89 c6                	mov    %eax,%esi
80105109:	0f 84 8e 00 00 00    	je     8010519d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010510f:	83 ec 0c             	sub    $0xc,%esp
80105112:	50                   	push   %eax
80105113:	e8 48 c6 ff ff       	call   80101760 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105118:	83 c4 10             	add    $0x10,%esp
8010511b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105120:	0f 84 d2 00 00 00    	je     801051f8 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105126:	e8 25 bd ff ff       	call   80100e50 <filealloc>
8010512b:	85 c0                	test   %eax,%eax
8010512d:	89 c7                	mov    %eax,%edi
8010512f:	74 2b                	je     8010515c <sys_open+0xac>
  for(fd = 0; fd < NOFILE; fd++){
80105131:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105133:	e8 48 e7 ff ff       	call   80103880 <myproc>
80105138:	90                   	nop
80105139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105140:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105144:	85 d2                	test   %edx,%edx
80105146:	74 68                	je     801051b0 <sys_open+0x100>
  for(fd = 0; fd < NOFILE; fd++){
80105148:	83 c3 01             	add    $0x1,%ebx
8010514b:	83 fb 10             	cmp    $0x10,%ebx
8010514e:	75 f0                	jne    80105140 <sys_open+0x90>
    if(f)
      fileclose(f);
80105150:	83 ec 0c             	sub    $0xc,%esp
80105153:	57                   	push   %edi
80105154:	e8 b7 bd ff ff       	call   80100f10 <fileclose>
80105159:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010515c:	83 ec 0c             	sub    $0xc,%esp
8010515f:	56                   	push   %esi
80105160:	e8 8b c8 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105165:	e8 66 db ff ff       	call   80102cd0 <end_op>
    return -1;
8010516a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010516d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105170:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105175:	89 d8                	mov    %ebx,%eax
80105177:	5b                   	pop    %ebx
80105178:	5e                   	pop    %esi
80105179:	5f                   	pop    %edi
8010517a:	5d                   	pop    %ebp
8010517b:	c3                   	ret    
8010517c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105180:	83 ec 0c             	sub    $0xc,%esp
80105183:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105186:	31 c9                	xor    %ecx,%ecx
80105188:	6a 00                	push   $0x0
8010518a:	ba 02 00 00 00       	mov    $0x2,%edx
8010518f:	e8 dc f7 ff ff       	call   80104970 <create>
    if(ip == 0){
80105194:	83 c4 10             	add    $0x10,%esp
80105197:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105199:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010519b:	75 89                	jne    80105126 <sys_open+0x76>
      end_op();
8010519d:	e8 2e db ff ff       	call   80102cd0 <end_op>
      return -1;
801051a2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801051a7:	eb 40                	jmp    801051e9 <sys_open+0x139>
801051a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
801051b0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801051b3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801051b7:	56                   	push   %esi
801051b8:	e8 83 c6 ff ff       	call   80101840 <iunlock>
  end_op();
801051bd:	e8 0e db ff ff       	call   80102cd0 <end_op>
  f->type = FD_INODE;
801051c2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->readable = !(omode & O_WRONLY);
801051c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801051cb:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801051ce:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801051d1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801051d8:	89 c2                	mov    %eax,%edx
801051da:	f7 d2                	not    %edx
801051dc:	88 57 08             	mov    %dl,0x8(%edi)
801051df:	80 67 08 01          	andb   $0x1,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801051e3:	a8 03                	test   $0x3,%al
801051e5:	0f 95 47 09          	setne  0x9(%edi)
}
801051e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051ec:	89 d8                	mov    %ebx,%eax
801051ee:	5b                   	pop    %ebx
801051ef:	5e                   	pop    %esi
801051f0:	5f                   	pop    %edi
801051f1:	5d                   	pop    %ebp
801051f2:	c3                   	ret    
801051f3:	90                   	nop
801051f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801051f8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801051fb:	85 c9                	test   %ecx,%ecx
801051fd:	0f 84 23 ff ff ff    	je     80105126 <sys_open+0x76>
80105203:	e9 54 ff ff ff       	jmp    8010515c <sys_open+0xac>
80105208:	90                   	nop
80105209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105210 <sys_mkdir>:

int
sys_mkdir(void)
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105216:	e8 45 da ff ff       	call   80102c60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010521b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010521e:	83 ec 08             	sub    $0x8,%esp
80105221:	50                   	push   %eax
80105222:	6a 00                	push   $0x0
80105224:	e8 a7 f6 ff ff       	call   801048d0 <argstr>
80105229:	83 c4 10             	add    $0x10,%esp
8010522c:	85 c0                	test   %eax,%eax
8010522e:	78 30                	js     80105260 <sys_mkdir+0x50>
80105230:	83 ec 0c             	sub    $0xc,%esp
80105233:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105236:	31 c9                	xor    %ecx,%ecx
80105238:	6a 00                	push   $0x0
8010523a:	ba 01 00 00 00       	mov    $0x1,%edx
8010523f:	e8 2c f7 ff ff       	call   80104970 <create>
80105244:	83 c4 10             	add    $0x10,%esp
80105247:	85 c0                	test   %eax,%eax
80105249:	74 15                	je     80105260 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010524b:	83 ec 0c             	sub    $0xc,%esp
8010524e:	50                   	push   %eax
8010524f:	e8 9c c7 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105254:	e8 77 da ff ff       	call   80102cd0 <end_op>
  return 0;
80105259:	83 c4 10             	add    $0x10,%esp
8010525c:	31 c0                	xor    %eax,%eax
}
8010525e:	c9                   	leave  
8010525f:	c3                   	ret    
    end_op();
80105260:	e8 6b da ff ff       	call   80102cd0 <end_op>
    return -1;
80105265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010526a:	c9                   	leave  
8010526b:	c3                   	ret    
8010526c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105270 <sys_mknod>:

int
sys_mknod(void)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105276:	e8 e5 d9 ff ff       	call   80102c60 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010527b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010527e:	83 ec 08             	sub    $0x8,%esp
80105281:	50                   	push   %eax
80105282:	6a 00                	push   $0x0
80105284:	e8 47 f6 ff ff       	call   801048d0 <argstr>
80105289:	83 c4 10             	add    $0x10,%esp
8010528c:	85 c0                	test   %eax,%eax
8010528e:	78 60                	js     801052f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105290:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105293:	83 ec 08             	sub    $0x8,%esp
80105296:	50                   	push   %eax
80105297:	6a 01                	push   $0x1
80105299:	e8 82 f5 ff ff       	call   80104820 <argint>
  if((argstr(0, &path)) < 0 ||
8010529e:	83 c4 10             	add    $0x10,%esp
801052a1:	85 c0                	test   %eax,%eax
801052a3:	78 4b                	js     801052f0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801052a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052a8:	83 ec 08             	sub    $0x8,%esp
801052ab:	50                   	push   %eax
801052ac:	6a 02                	push   $0x2
801052ae:	e8 6d f5 ff ff       	call   80104820 <argint>
     argint(1, &major) < 0 ||
801052b3:	83 c4 10             	add    $0x10,%esp
801052b6:	85 c0                	test   %eax,%eax
801052b8:	78 36                	js     801052f0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801052ba:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801052be:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801052c1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801052c5:	ba 03 00 00 00       	mov    $0x3,%edx
801052ca:	50                   	push   %eax
801052cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801052ce:	e8 9d f6 ff ff       	call   80104970 <create>
801052d3:	83 c4 10             	add    $0x10,%esp
801052d6:	85 c0                	test   %eax,%eax
801052d8:	74 16                	je     801052f0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052da:	83 ec 0c             	sub    $0xc,%esp
801052dd:	50                   	push   %eax
801052de:	e8 0d c7 ff ff       	call   801019f0 <iunlockput>
  end_op();
801052e3:	e8 e8 d9 ff ff       	call   80102cd0 <end_op>
  return 0;
801052e8:	83 c4 10             	add    $0x10,%esp
801052eb:	31 c0                	xor    %eax,%eax
}
801052ed:	c9                   	leave  
801052ee:	c3                   	ret    
801052ef:	90                   	nop
    end_op();
801052f0:	e8 db d9 ff ff       	call   80102cd0 <end_op>
    return -1;
801052f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052fa:	c9                   	leave  
801052fb:	c3                   	ret    
801052fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105300 <sys_chdir>:

int
sys_chdir(void)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	56                   	push   %esi
80105304:	53                   	push   %ebx
80105305:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105308:	e8 73 e5 ff ff       	call   80103880 <myproc>
8010530d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010530f:	e8 4c d9 ff ff       	call   80102c60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105314:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105317:	83 ec 08             	sub    $0x8,%esp
8010531a:	50                   	push   %eax
8010531b:	6a 00                	push   $0x0
8010531d:	e8 ae f5 ff ff       	call   801048d0 <argstr>
80105322:	83 c4 10             	add    $0x10,%esp
80105325:	85 c0                	test   %eax,%eax
80105327:	78 77                	js     801053a0 <sys_chdir+0xa0>
80105329:	83 ec 0c             	sub    $0xc,%esp
8010532c:	ff 75 f4             	pushl  -0xc(%ebp)
8010532f:	e8 7c cc ff ff       	call   80101fb0 <namei>
80105334:	83 c4 10             	add    $0x10,%esp
80105337:	85 c0                	test   %eax,%eax
80105339:	89 c3                	mov    %eax,%ebx
8010533b:	74 63                	je     801053a0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010533d:	83 ec 0c             	sub    $0xc,%esp
80105340:	50                   	push   %eax
80105341:	e8 1a c4 ff ff       	call   80101760 <ilock>
  if(ip->type != T_DIR){
80105346:	83 c4 10             	add    $0x10,%esp
80105349:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010534e:	75 30                	jne    80105380 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	53                   	push   %ebx
80105354:	e8 e7 c4 ff ff       	call   80101840 <iunlock>
  iput(curproc->cwd);
80105359:	58                   	pop    %eax
8010535a:	ff 76 68             	pushl  0x68(%esi)
8010535d:	e8 2e c5 ff ff       	call   80101890 <iput>
  end_op();
80105362:	e8 69 d9 ff ff       	call   80102cd0 <end_op>
  curproc->cwd = ip;
80105367:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010536a:	83 c4 10             	add    $0x10,%esp
8010536d:	31 c0                	xor    %eax,%eax
}
8010536f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105372:	5b                   	pop    %ebx
80105373:	5e                   	pop    %esi
80105374:	5d                   	pop    %ebp
80105375:	c3                   	ret    
80105376:	8d 76 00             	lea    0x0(%esi),%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105380:	83 ec 0c             	sub    $0xc,%esp
80105383:	53                   	push   %ebx
80105384:	e8 67 c6 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105389:	e8 42 d9 ff ff       	call   80102cd0 <end_op>
    return -1;
8010538e:	83 c4 10             	add    $0x10,%esp
80105391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105396:	eb d7                	jmp    8010536f <sys_chdir+0x6f>
80105398:	90                   	nop
80105399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801053a0:	e8 2b d9 ff ff       	call   80102cd0 <end_op>
    return -1;
801053a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053aa:	eb c3                	jmp    8010536f <sys_chdir+0x6f>
801053ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053b0 <sys_exec>:

int
sys_exec(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	57                   	push   %edi
801053b4:	56                   	push   %esi
801053b5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801053b6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801053bc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801053c2:	50                   	push   %eax
801053c3:	6a 00                	push   $0x0
801053c5:	e8 06 f5 ff ff       	call   801048d0 <argstr>
801053ca:	83 c4 10             	add    $0x10,%esp
801053cd:	85 c0                	test   %eax,%eax
801053cf:	78 7f                	js     80105450 <sys_exec+0xa0>
801053d1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801053d7:	83 ec 08             	sub    $0x8,%esp
801053da:	50                   	push   %eax
801053db:	6a 01                	push   $0x1
801053dd:	e8 3e f4 ff ff       	call   80104820 <argint>
801053e2:	83 c4 10             	add    $0x10,%esp
801053e5:	85 c0                	test   %eax,%eax
801053e7:	78 67                	js     80105450 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801053e9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801053ef:	83 ec 04             	sub    $0x4,%esp
801053f2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801053f8:	68 80 00 00 00       	push   $0x80
801053fd:	6a 00                	push   $0x0
801053ff:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105405:	50                   	push   %eax
80105406:	31 db                	xor    %ebx,%ebx
80105408:	e8 23 f1 ff ff       	call   80104530 <memset>
8010540d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105410:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105416:	83 ec 08             	sub    $0x8,%esp
80105419:	57                   	push   %edi
8010541a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010541d:	50                   	push   %eax
8010541e:	e8 5d f3 ff ff       	call   80104780 <fetchint>
80105423:	83 c4 10             	add    $0x10,%esp
80105426:	85 c0                	test   %eax,%eax
80105428:	78 26                	js     80105450 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010542a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105430:	85 c0                	test   %eax,%eax
80105432:	74 2c                	je     80105460 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105434:	83 ec 08             	sub    $0x8,%esp
80105437:	56                   	push   %esi
80105438:	50                   	push   %eax
80105439:	e8 82 f3 ff ff       	call   801047c0 <fetchstr>
8010543e:	83 c4 10             	add    $0x10,%esp
80105441:	85 c0                	test   %eax,%eax
80105443:	78 0b                	js     80105450 <sys_exec+0xa0>
  for(i=0;; i++){
80105445:	83 c3 01             	add    $0x1,%ebx
80105448:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010544b:	83 fb 20             	cmp    $0x20,%ebx
8010544e:	75 c0                	jne    80105410 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105450:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105458:	5b                   	pop    %ebx
80105459:	5e                   	pop    %esi
8010545a:	5f                   	pop    %edi
8010545b:	5d                   	pop    %ebp
8010545c:	c3                   	ret    
8010545d:	8d 76 00             	lea    0x0(%esi),%esi
  return exec(path, argv);
80105460:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105466:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105469:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105470:	00 00 00 00 
  return exec(path, argv);
80105474:	50                   	push   %eax
80105475:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010547b:	e8 50 b6 ff ff       	call   80100ad0 <exec>
80105480:	83 c4 10             	add    $0x10,%esp
}
80105483:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105486:	5b                   	pop    %ebx
80105487:	5e                   	pop    %esi
80105488:	5f                   	pop    %edi
80105489:	5d                   	pop    %ebp
8010548a:	c3                   	ret    
8010548b:	90                   	nop
8010548c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105490 <sys_pipe>:

int
sys_pipe(void)
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	57                   	push   %edi
80105494:	56                   	push   %esi
80105495:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105496:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105499:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010549c:	6a 08                	push   $0x8
8010549e:	50                   	push   %eax
8010549f:	6a 00                	push   $0x0
801054a1:	e8 ca f3 ff ff       	call   80104870 <argptr>
801054a6:	83 c4 10             	add    $0x10,%esp
801054a9:	85 c0                	test   %eax,%eax
801054ab:	78 4a                	js     801054f7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801054ad:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801054b0:	83 ec 08             	sub    $0x8,%esp
801054b3:	50                   	push   %eax
801054b4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801054b7:	50                   	push   %eax
801054b8:	e8 33 de ff ff       	call   801032f0 <pipealloc>
801054bd:	83 c4 10             	add    $0x10,%esp
801054c0:	85 c0                	test   %eax,%eax
801054c2:	78 33                	js     801054f7 <sys_pipe+0x67>
  for(fd = 0; fd < NOFILE; fd++){
801054c4:	31 db                	xor    %ebx,%ebx
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801054c6:	8b 7d e0             	mov    -0x20(%ebp),%edi
  struct proc *curproc = myproc();
801054c9:	e8 b2 e3 ff ff       	call   80103880 <myproc>
801054ce:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801054d0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801054d4:	85 f6                	test   %esi,%esi
801054d6:	74 30                	je     80105508 <sys_pipe+0x78>
  for(fd = 0; fd < NOFILE; fd++){
801054d8:	83 c3 01             	add    $0x1,%ebx
801054db:	83 fb 10             	cmp    $0x10,%ebx
801054de:	75 f0                	jne    801054d0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801054e0:	83 ec 0c             	sub    $0xc,%esp
801054e3:	ff 75 e0             	pushl  -0x20(%ebp)
801054e6:	e8 25 ba ff ff       	call   80100f10 <fileclose>
    fileclose(wf);
801054eb:	58                   	pop    %eax
801054ec:	ff 75 e4             	pushl  -0x1c(%ebp)
801054ef:	e8 1c ba ff ff       	call   80100f10 <fileclose>
    return -1;
801054f4:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801054f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801054fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054ff:	5b                   	pop    %ebx
80105500:	5e                   	pop    %esi
80105501:	5f                   	pop    %edi
80105502:	5d                   	pop    %ebp
80105503:	c3                   	ret    
80105504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105508:	8d 73 08             	lea    0x8(%ebx),%esi
8010550b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010550f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105512:	e8 69 e3 ff ff       	call   80103880 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105517:	31 d2                	xor    %edx,%edx
80105519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105520:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105524:	85 c9                	test   %ecx,%ecx
80105526:	74 18                	je     80105540 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105528:	83 c2 01             	add    $0x1,%edx
8010552b:	83 fa 10             	cmp    $0x10,%edx
8010552e:	75 f0                	jne    80105520 <sys_pipe+0x90>
      myproc()->ofile[fd0] = 0;
80105530:	e8 4b e3 ff ff       	call   80103880 <myproc>
80105535:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010553c:	00 
8010553d:	eb a1                	jmp    801054e0 <sys_pipe+0x50>
8010553f:	90                   	nop
      curproc->ofile[fd] = f;
80105540:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  fd[0] = fd0;
80105544:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105547:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105549:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010554c:	89 50 04             	mov    %edx,0x4(%eax)
}
8010554f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80105552:	31 c0                	xor    %eax,%eax
}
80105554:	5b                   	pop    %ebx
80105555:	5e                   	pop    %esi
80105556:	5f                   	pop    %edi
80105557:	5d                   	pop    %ebp
80105558:	c3                   	ret    
80105559:	66 90                	xchg   %ax,%ax
8010555b:	66 90                	xchg   %ax,%ax
8010555d:	66 90                	xchg   %ax,%ax
8010555f:	90                   	nop

80105560 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105563:	5d                   	pop    %ebp
  return fork();
80105564:	e9 b7 e4 ff ff       	jmp    80103a20 <fork>
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105570 <sys_exit>:

int
sys_exit(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	83 ec 08             	sub    $0x8,%esp
  exit();
80105576:	e8 35 e7 ff ff       	call   80103cb0 <exit>
  return 0;  // not reached
}
8010557b:	31 c0                	xor    %eax,%eax
8010557d:	c9                   	leave  
8010557e:	c3                   	ret    
8010557f:	90                   	nop

80105580 <sys_wait>:

int
sys_wait(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105583:	5d                   	pop    %ebp
  return wait();
80105584:	e9 67 e9 ff ff       	jmp    80103ef0 <wait>
80105589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105590 <sys_kill>:

int
sys_kill(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105596:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105599:	50                   	push   %eax
8010559a:	6a 00                	push   $0x0
8010559c:	e8 7f f2 ff ff       	call   80104820 <argint>
801055a1:	83 c4 10             	add    $0x10,%esp
801055a4:	85 c0                	test   %eax,%eax
801055a6:	78 18                	js     801055c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801055a8:	83 ec 0c             	sub    $0xc,%esp
801055ab:	ff 75 f4             	pushl  -0xc(%ebp)
801055ae:	e8 9d ea ff ff       	call   80104050 <kill>
801055b3:	83 c4 10             	add    $0x10,%esp
}
801055b6:	c9                   	leave  
801055b7:	c3                   	ret    
801055b8:	90                   	nop
801055b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801055c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055c5:	c9                   	leave  
801055c6:	c3                   	ret    
801055c7:	89 f6                	mov    %esi,%esi
801055c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055d0 <sys_getpid>:

int
sys_getpid(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801055d6:	e8 a5 e2 ff ff       	call   80103880 <myproc>
801055db:	8b 40 10             	mov    0x10(%eax),%eax
}
801055de:	c9                   	leave  
801055df:	c3                   	ret    

801055e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801055e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801055e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801055ea:	50                   	push   %eax
801055eb:	6a 00                	push   $0x0
801055ed:	e8 2e f2 ff ff       	call   80104820 <argint>
801055f2:	83 c4 10             	add    $0x10,%esp
801055f5:	85 c0                	test   %eax,%eax
801055f7:	78 27                	js     80105620 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801055f9:	e8 82 e2 ff ff       	call   80103880 <myproc>
  if(growproc(n) < 0)
801055fe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105601:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105603:	ff 75 f4             	pushl  -0xc(%ebp)
80105606:	e8 95 e3 ff ff       	call   801039a0 <growproc>
8010560b:	83 c4 10             	add    $0x10,%esp
8010560e:	85 c0                	test   %eax,%eax
80105610:	78 0e                	js     80105620 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105612:	89 d8                	mov    %ebx,%eax
80105614:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105617:	c9                   	leave  
80105618:	c3                   	ret    
80105619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105620:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105625:	eb eb                	jmp    80105612 <sys_sbrk+0x32>
80105627:	89 f6                	mov    %esi,%esi
80105629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105630 <sys_sleep>:

int
sys_sleep(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105634:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105637:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010563a:	50                   	push   %eax
8010563b:	6a 00                	push   $0x0
8010563d:	e8 de f1 ff ff       	call   80104820 <argint>
80105642:	83 c4 10             	add    $0x10,%esp
80105645:	85 c0                	test   %eax,%eax
80105647:	0f 88 8a 00 00 00    	js     801056d7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010564d:	83 ec 0c             	sub    $0xc,%esp
80105650:	68 60 4c 11 80       	push   $0x80114c60
80105655:	e8 d6 ed ff ff       	call   80104430 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010565a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010565d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105660:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
80105666:	85 d2                	test   %edx,%edx
80105668:	75 27                	jne    80105691 <sys_sleep+0x61>
8010566a:	eb 54                	jmp    801056c0 <sys_sleep+0x90>
8010566c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105670:	83 ec 08             	sub    $0x8,%esp
80105673:	68 60 4c 11 80       	push   $0x80114c60
80105678:	68 a0 54 11 80       	push   $0x801154a0
8010567d:	e8 ae e7 ff ff       	call   80103e30 <sleep>
  while(ticks - ticks0 < n){
80105682:	a1 a0 54 11 80       	mov    0x801154a0,%eax
80105687:	83 c4 10             	add    $0x10,%esp
8010568a:	29 d8                	sub    %ebx,%eax
8010568c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010568f:	73 2f                	jae    801056c0 <sys_sleep+0x90>
    if(myproc()->killed){
80105691:	e8 ea e1 ff ff       	call   80103880 <myproc>
80105696:	8b 40 24             	mov    0x24(%eax),%eax
80105699:	85 c0                	test   %eax,%eax
8010569b:	74 d3                	je     80105670 <sys_sleep+0x40>
      release(&tickslock);
8010569d:	83 ec 0c             	sub    $0xc,%esp
801056a0:	68 60 4c 11 80       	push   $0x80114c60
801056a5:	e8 36 ee ff ff       	call   801044e0 <release>
      return -1;
801056aa:	83 c4 10             	add    $0x10,%esp
801056ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801056b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056b5:	c9                   	leave  
801056b6:	c3                   	ret    
801056b7:	89 f6                	mov    %esi,%esi
801056b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801056c0:	83 ec 0c             	sub    $0xc,%esp
801056c3:	68 60 4c 11 80       	push   $0x80114c60
801056c8:	e8 13 ee ff ff       	call   801044e0 <release>
  return 0;
801056cd:	83 c4 10             	add    $0x10,%esp
801056d0:	31 c0                	xor    %eax,%eax
}
801056d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056d5:	c9                   	leave  
801056d6:	c3                   	ret    
    return -1;
801056d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056dc:	eb d4                	jmp    801056b2 <sys_sleep+0x82>
801056de:	66 90                	xchg   %ax,%ax

801056e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	53                   	push   %ebx
801056e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801056e7:	68 60 4c 11 80       	push   $0x80114c60
801056ec:	e8 3f ed ff ff       	call   80104430 <acquire>
  xticks = ticks;
801056f1:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
801056f7:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801056fe:	e8 dd ed ff ff       	call   801044e0 <release>
  return xticks;
}
80105703:	89 d8                	mov    %ebx,%eax
80105705:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105708:	c9                   	leave  
80105709:	c3                   	ret    

8010570a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010570a:	1e                   	push   %ds
  pushl %es
8010570b:	06                   	push   %es
  pushl %fs
8010570c:	0f a0                	push   %fs
  pushl %gs
8010570e:	0f a8                	push   %gs
  pushal
80105710:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105711:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105715:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105717:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105719:	54                   	push   %esp
  call trap
8010571a:	e8 e1 00 00 00       	call   80105800 <trap>
  addl $4, %esp
8010571f:	83 c4 04             	add    $0x4,%esp

80105722 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105722:	61                   	popa   
  popl %gs
80105723:	0f a9                	pop    %gs
  popl %fs
80105725:	0f a1                	pop    %fs
  popl %es
80105727:	07                   	pop    %es
  popl %ds
80105728:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105729:	83 c4 08             	add    $0x8,%esp
  iret
8010572c:	cf                   	iret   
8010572d:	66 90                	xchg   %ax,%ax
8010572f:	90                   	nop

80105730 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105730:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105731:	31 c0                	xor    %eax,%eax
{
80105733:	89 e5                	mov    %esp,%ebp
80105735:	83 ec 08             	sub    $0x8,%esp
80105738:	90                   	nop
80105739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105740:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105747:	b9 08 00 00 00       	mov    $0x8,%ecx
8010574c:	c6 04 c5 a4 4c 11 80 	movb   $0x0,-0x7feeb35c(,%eax,8)
80105753:	00 
80105754:	66 89 0c c5 a2 4c 11 	mov    %cx,-0x7feeb35e(,%eax,8)
8010575b:	80 
8010575c:	c6 04 c5 a5 4c 11 80 	movb   $0x8e,-0x7feeb35b(,%eax,8)
80105763:	8e 
80105764:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
8010576b:	80 
8010576c:	c1 ea 10             	shr    $0x10,%edx
8010576f:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
80105776:	80 
  for(i = 0; i < 256; i++)
80105777:	83 c0 01             	add    $0x1,%eax
8010577a:	3d 00 01 00 00       	cmp    $0x100,%eax
8010577f:	75 bf                	jne    80105740 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105781:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105786:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105789:	ba 08 00 00 00       	mov    $0x8,%edx
  initlock(&tickslock, "time");
8010578e:	68 39 77 10 80       	push   $0x80107739
80105793:	68 60 4c 11 80       	push   $0x80114c60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105798:	66 89 15 a2 4e 11 80 	mov    %dx,0x80114ea2
8010579f:	c6 05 a4 4e 11 80 00 	movb   $0x0,0x80114ea4
801057a6:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
801057ac:	c1 e8 10             	shr    $0x10,%eax
801057af:	c6 05 a5 4e 11 80 ef 	movb   $0xef,0x80114ea5
801057b6:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6
  initlock(&tickslock, "time");
801057bc:	e8 0f eb ff ff       	call   801042d0 <initlock>
}
801057c1:	83 c4 10             	add    $0x10,%esp
801057c4:	c9                   	leave  
801057c5:	c3                   	ret    
801057c6:	8d 76 00             	lea    0x0(%esi),%esi
801057c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057d0 <idtinit>:

void
idtinit(void)
{
801057d0:	55                   	push   %ebp
  pd[0] = size-1;
801057d1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801057d6:	89 e5                	mov    %esp,%ebp
801057d8:	83 ec 10             	sub    $0x10,%esp
801057db:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801057df:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
801057e4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801057e8:	c1 e8 10             	shr    $0x10,%eax
801057eb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801057ef:	8d 45 fa             	lea    -0x6(%ebp),%eax
801057f2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801057f5:	c9                   	leave  
801057f6:	c3                   	ret    
801057f7:	89 f6                	mov    %esi,%esi
801057f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105800 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	57                   	push   %edi
80105804:	56                   	push   %esi
80105805:	53                   	push   %ebx
80105806:	83 ec 1c             	sub    $0x1c,%esp
80105809:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010580c:	8b 47 30             	mov    0x30(%edi),%eax
8010580f:	83 f8 40             	cmp    $0x40,%eax
80105812:	0f 84 88 01 00 00    	je     801059a0 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105818:	83 e8 20             	sub    $0x20,%eax
8010581b:	83 f8 1f             	cmp    $0x1f,%eax
8010581e:	77 10                	ja     80105830 <trap+0x30>
80105820:	ff 24 85 e0 77 10 80 	jmp    *-0x7fef8820(,%eax,4)
80105827:	89 f6                	mov    %esi,%esi
80105829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105830:	e8 4b e0 ff ff       	call   80103880 <myproc>
80105835:	85 c0                	test   %eax,%eax
80105837:	0f 84 d7 01 00 00    	je     80105a14 <trap+0x214>
8010583d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105841:	0f 84 cd 01 00 00    	je     80105a14 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105847:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010584a:	8b 57 38             	mov    0x38(%edi),%edx
8010584d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105850:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105853:	e8 08 e0 ff ff       	call   80103860 <cpuid>
80105858:	8b 77 34             	mov    0x34(%edi),%esi
8010585b:	8b 5f 30             	mov    0x30(%edi),%ebx
8010585e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105861:	e8 1a e0 ff ff       	call   80103880 <myproc>
80105866:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105869:	e8 12 e0 ff ff       	call   80103880 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010586e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105871:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105874:	51                   	push   %ecx
80105875:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105876:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105879:	ff 75 e4             	pushl  -0x1c(%ebp)
8010587c:	56                   	push   %esi
8010587d:	53                   	push   %ebx
            myproc()->pid, myproc()->name, tf->trapno,
8010587e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105881:	52                   	push   %edx
80105882:	ff 70 10             	pushl  0x10(%eax)
80105885:	68 9c 77 10 80       	push   $0x8010779c
8010588a:	e8 b1 ae ff ff       	call   80100740 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010588f:	83 c4 20             	add    $0x20,%esp
80105892:	e8 e9 df ff ff       	call   80103880 <myproc>
80105897:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010589e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801058a0:	e8 db df ff ff       	call   80103880 <myproc>
801058a5:	85 c0                	test   %eax,%eax
801058a7:	74 0c                	je     801058b5 <trap+0xb5>
801058a9:	e8 d2 df ff ff       	call   80103880 <myproc>
801058ae:	8b 50 24             	mov    0x24(%eax),%edx
801058b1:	85 d2                	test   %edx,%edx
801058b3:	75 4b                	jne    80105900 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801058b5:	e8 c6 df ff ff       	call   80103880 <myproc>
801058ba:	85 c0                	test   %eax,%eax
801058bc:	74 0b                	je     801058c9 <trap+0xc9>
801058be:	e8 bd df ff ff       	call   80103880 <myproc>
801058c3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801058c7:	74 4f                	je     80105918 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801058c9:	e8 b2 df ff ff       	call   80103880 <myproc>
801058ce:	85 c0                	test   %eax,%eax
801058d0:	74 1d                	je     801058ef <trap+0xef>
801058d2:	e8 a9 df ff ff       	call   80103880 <myproc>
801058d7:	8b 40 24             	mov    0x24(%eax),%eax
801058da:	85 c0                	test   %eax,%eax
801058dc:	74 11                	je     801058ef <trap+0xef>
801058de:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801058e2:	83 e0 03             	and    $0x3,%eax
801058e5:	66 83 f8 03          	cmp    $0x3,%ax
801058e9:	0f 84 da 00 00 00    	je     801059c9 <trap+0x1c9>
    exit();
}
801058ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058f2:	5b                   	pop    %ebx
801058f3:	5e                   	pop    %esi
801058f4:	5f                   	pop    %edi
801058f5:	5d                   	pop    %ebp
801058f6:	c3                   	ret    
801058f7:	89 f6                	mov    %esi,%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105900:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105904:	83 e0 03             	and    $0x3,%eax
80105907:	66 83 f8 03          	cmp    $0x3,%ax
8010590b:	75 a8                	jne    801058b5 <trap+0xb5>
    exit();
8010590d:	e8 9e e3 ff ff       	call   80103cb0 <exit>
80105912:	eb a1                	jmp    801058b5 <trap+0xb5>
80105914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105918:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
8010591c:	75 ab                	jne    801058c9 <trap+0xc9>
    yield();
8010591e:	e8 bd e4 ff ff       	call   80103de0 <yield>
80105923:	eb a4                	jmp    801058c9 <trap+0xc9>
80105925:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105928:	e8 33 df ff ff       	call   80103860 <cpuid>
8010592d:	85 c0                	test   %eax,%eax
8010592f:	0f 84 ab 00 00 00    	je     801059e0 <trap+0x1e0>
    lapiceoi();
80105935:	e8 d6 ce ff ff       	call   80102810 <lapiceoi>
    break;
8010593a:	e9 61 ff ff ff       	jmp    801058a0 <trap+0xa0>
8010593f:	90                   	nop
    kbdintr();
80105940:	e8 8b cd ff ff       	call   801026d0 <kbdintr>
    lapiceoi();
80105945:	e8 c6 ce ff ff       	call   80102810 <lapiceoi>
    break;
8010594a:	e9 51 ff ff ff       	jmp    801058a0 <trap+0xa0>
8010594f:	90                   	nop
    uartintr();
80105950:	e8 5b 02 00 00       	call   80105bb0 <uartintr>
    lapiceoi();
80105955:	e8 b6 ce ff ff       	call   80102810 <lapiceoi>
    break;
8010595a:	e9 41 ff ff ff       	jmp    801058a0 <trap+0xa0>
8010595f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105960:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105964:	8b 77 38             	mov    0x38(%edi),%esi
80105967:	e8 f4 de ff ff       	call   80103860 <cpuid>
8010596c:	56                   	push   %esi
8010596d:	53                   	push   %ebx
8010596e:	50                   	push   %eax
8010596f:	68 44 77 10 80       	push   $0x80107744
80105974:	e8 c7 ad ff ff       	call   80100740 <cprintf>
    lapiceoi();
80105979:	e8 92 ce ff ff       	call   80102810 <lapiceoi>
    break;
8010597e:	83 c4 10             	add    $0x10,%esp
80105981:	e9 1a ff ff ff       	jmp    801058a0 <trap+0xa0>
80105986:	8d 76 00             	lea    0x0(%esi),%esi
80105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80105990:	e8 ab c7 ff ff       	call   80102140 <ideintr>
80105995:	eb 9e                	jmp    80105935 <trap+0x135>
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(myproc()->killed)
801059a0:	e8 db de ff ff       	call   80103880 <myproc>
801059a5:	8b 58 24             	mov    0x24(%eax),%ebx
801059a8:	85 db                	test   %ebx,%ebx
801059aa:	75 2c                	jne    801059d8 <trap+0x1d8>
    myproc()->tf = tf;
801059ac:	e8 cf de ff ff       	call   80103880 <myproc>
801059b1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801059b4:	e8 57 ef ff ff       	call   80104910 <syscall>
    if(myproc()->killed)
801059b9:	e8 c2 de ff ff       	call   80103880 <myproc>
801059be:	8b 48 24             	mov    0x24(%eax),%ecx
801059c1:	85 c9                	test   %ecx,%ecx
801059c3:	0f 84 26 ff ff ff    	je     801058ef <trap+0xef>
}
801059c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059cc:	5b                   	pop    %ebx
801059cd:	5e                   	pop    %esi
801059ce:	5f                   	pop    %edi
801059cf:	5d                   	pop    %ebp
      exit();
801059d0:	e9 db e2 ff ff       	jmp    80103cb0 <exit>
801059d5:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
801059d8:	e8 d3 e2 ff ff       	call   80103cb0 <exit>
801059dd:	eb cd                	jmp    801059ac <trap+0x1ac>
801059df:	90                   	nop
      acquire(&tickslock);
801059e0:	83 ec 0c             	sub    $0xc,%esp
801059e3:	68 60 4c 11 80       	push   $0x80114c60
801059e8:	e8 43 ea ff ff       	call   80104430 <acquire>
      wakeup(&ticks);
801059ed:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
      ticks++;
801059f4:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
801059fb:	e8 f0 e5 ff ff       	call   80103ff0 <wakeup>
      release(&tickslock);
80105a00:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105a07:	e8 d4 ea ff ff       	call   801044e0 <release>
80105a0c:	83 c4 10             	add    $0x10,%esp
80105a0f:	e9 21 ff ff ff       	jmp    80105935 <trap+0x135>
80105a14:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105a17:	8b 5f 38             	mov    0x38(%edi),%ebx
80105a1a:	e8 41 de ff ff       	call   80103860 <cpuid>
80105a1f:	83 ec 0c             	sub    $0xc,%esp
80105a22:	56                   	push   %esi
80105a23:	53                   	push   %ebx
80105a24:	50                   	push   %eax
80105a25:	ff 77 30             	pushl  0x30(%edi)
80105a28:	68 68 77 10 80       	push   $0x80107768
80105a2d:	e8 0e ad ff ff       	call   80100740 <cprintf>
      panic("trap");
80105a32:	83 c4 14             	add    $0x14,%esp
80105a35:	68 3e 77 10 80       	push   $0x8010773e
80105a3a:	e8 31 a9 ff ff       	call   80100370 <panic>
80105a3f:	90                   	nop

80105a40 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105a40:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105a45:	55                   	push   %ebp
80105a46:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105a48:	85 c0                	test   %eax,%eax
80105a4a:	74 1c                	je     80105a68 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105a4c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105a51:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105a52:	a8 01                	test   $0x1,%al
80105a54:	74 12                	je     80105a68 <uartgetc+0x28>
80105a56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a5b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105a5c:	0f b6 c0             	movzbl %al,%eax
}
80105a5f:	5d                   	pop    %ebp
80105a60:	c3                   	ret    
80105a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a6d:	5d                   	pop    %ebp
80105a6e:	c3                   	ret    
80105a6f:	90                   	nop

80105a70 <uartputc.part.0>:
uartputc(int c)
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	57                   	push   %edi
80105a74:	56                   	push   %esi
80105a75:	53                   	push   %ebx
80105a76:	89 c7                	mov    %eax,%edi
80105a78:	bb 80 00 00 00       	mov    $0x80,%ebx
80105a7d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105a82:	83 ec 0c             	sub    $0xc,%esp
80105a85:	eb 1b                	jmp    80105aa2 <uartputc.part.0+0x32>
80105a87:	89 f6                	mov    %esi,%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105a90:	83 ec 0c             	sub    $0xc,%esp
80105a93:	6a 0a                	push   $0xa
80105a95:	e8 96 cd ff ff       	call   80102830 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105a9a:	83 c4 10             	add    $0x10,%esp
80105a9d:	83 eb 01             	sub    $0x1,%ebx
80105aa0:	74 07                	je     80105aa9 <uartputc.part.0+0x39>
80105aa2:	89 f2                	mov    %esi,%edx
80105aa4:	ec                   	in     (%dx),%al
80105aa5:	a8 20                	test   $0x20,%al
80105aa7:	74 e7                	je     80105a90 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105aa9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105aae:	89 f8                	mov    %edi,%eax
80105ab0:	ee                   	out    %al,(%dx)
}
80105ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ab4:	5b                   	pop    %ebx
80105ab5:	5e                   	pop    %esi
80105ab6:	5f                   	pop    %edi
80105ab7:	5d                   	pop    %ebp
80105ab8:	c3                   	ret    
80105ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ac0 <uartinit>:
{
80105ac0:	55                   	push   %ebp
80105ac1:	31 c9                	xor    %ecx,%ecx
80105ac3:	89 c8                	mov    %ecx,%eax
80105ac5:	89 e5                	mov    %esp,%ebp
80105ac7:	57                   	push   %edi
80105ac8:	56                   	push   %esi
80105ac9:	53                   	push   %ebx
80105aca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105acf:	89 da                	mov    %ebx,%edx
80105ad1:	83 ec 0c             	sub    $0xc,%esp
80105ad4:	ee                   	out    %al,(%dx)
80105ad5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105ada:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105adf:	89 fa                	mov    %edi,%edx
80105ae1:	ee                   	out    %al,(%dx)
80105ae2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ae7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105aec:	ee                   	out    %al,(%dx)
80105aed:	be f9 03 00 00       	mov    $0x3f9,%esi
80105af2:	89 c8                	mov    %ecx,%eax
80105af4:	89 f2                	mov    %esi,%edx
80105af6:	ee                   	out    %al,(%dx)
80105af7:	b8 03 00 00 00       	mov    $0x3,%eax
80105afc:	89 fa                	mov    %edi,%edx
80105afe:	ee                   	out    %al,(%dx)
80105aff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105b04:	89 c8                	mov    %ecx,%eax
80105b06:	ee                   	out    %al,(%dx)
80105b07:	b8 01 00 00 00       	mov    $0x1,%eax
80105b0c:	89 f2                	mov    %esi,%edx
80105b0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b14:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105b15:	3c ff                	cmp    $0xff,%al
80105b17:	74 5a                	je     80105b73 <uartinit+0xb3>
  uart = 1;
80105b19:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105b20:	00 00 00 
80105b23:	89 da                	mov    %ebx,%edx
80105b25:	ec                   	in     (%dx),%al
80105b26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b2b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105b2c:	83 ec 08             	sub    $0x8,%esp
80105b2f:	bb 60 78 10 80       	mov    $0x80107860,%ebx
80105b34:	6a 00                	push   $0x0
80105b36:	6a 04                	push   $0x4
80105b38:	e8 53 c8 ff ff       	call   80102390 <ioapicenable>
80105b3d:	83 c4 10             	add    $0x10,%esp
80105b40:	b8 78 00 00 00       	mov    $0x78,%eax
80105b45:	eb 13                	jmp    80105b5a <uartinit+0x9a>
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p="xv6...\n"; *p; p++)
80105b50:	83 c3 01             	add    $0x1,%ebx
80105b53:	0f be 03             	movsbl (%ebx),%eax
80105b56:	84 c0                	test   %al,%al
80105b58:	74 19                	je     80105b73 <uartinit+0xb3>
  if(!uart)
80105b5a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105b60:	85 d2                	test   %edx,%edx
80105b62:	74 ec                	je     80105b50 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105b64:	83 c3 01             	add    $0x1,%ebx
80105b67:	e8 04 ff ff ff       	call   80105a70 <uartputc.part.0>
80105b6c:	0f be 03             	movsbl (%ebx),%eax
80105b6f:	84 c0                	test   %al,%al
80105b71:	75 e7                	jne    80105b5a <uartinit+0x9a>
}
80105b73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b76:	5b                   	pop    %ebx
80105b77:	5e                   	pop    %esi
80105b78:	5f                   	pop    %edi
80105b79:	5d                   	pop    %ebp
80105b7a:	c3                   	ret    
80105b7b:	90                   	nop
80105b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b80 <uartputc>:
  if(!uart)
80105b80:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105b86:	55                   	push   %ebp
80105b87:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b89:	85 d2                	test   %edx,%edx
{
80105b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105b8e:	74 10                	je     80105ba0 <uartputc+0x20>
}
80105b90:	5d                   	pop    %ebp
80105b91:	e9 da fe ff ff       	jmp    80105a70 <uartputc.part.0>
80105b96:	8d 76 00             	lea    0x0(%esi),%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ba0:	5d                   	pop    %ebp
80105ba1:	c3                   	ret    
80105ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bb0 <uartintr>:

void
uartintr(void)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105bb6:	68 40 5a 10 80       	push   $0x80105a40
80105bbb:	e8 00 ad ff ff       	call   801008c0 <consoleintr>
}
80105bc0:	83 c4 10             	add    $0x10,%esp
80105bc3:	c9                   	leave  
80105bc4:	c3                   	ret    

80105bc5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105bc5:	6a 00                	push   $0x0
  pushl $0
80105bc7:	6a 00                	push   $0x0
  jmp alltraps
80105bc9:	e9 3c fb ff ff       	jmp    8010570a <alltraps>

80105bce <vector1>:
.globl vector1
vector1:
  pushl $0
80105bce:	6a 00                	push   $0x0
  pushl $1
80105bd0:	6a 01                	push   $0x1
  jmp alltraps
80105bd2:	e9 33 fb ff ff       	jmp    8010570a <alltraps>

80105bd7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105bd7:	6a 00                	push   $0x0
  pushl $2
80105bd9:	6a 02                	push   $0x2
  jmp alltraps
80105bdb:	e9 2a fb ff ff       	jmp    8010570a <alltraps>

80105be0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105be0:	6a 00                	push   $0x0
  pushl $3
80105be2:	6a 03                	push   $0x3
  jmp alltraps
80105be4:	e9 21 fb ff ff       	jmp    8010570a <alltraps>

80105be9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105be9:	6a 00                	push   $0x0
  pushl $4
80105beb:	6a 04                	push   $0x4
  jmp alltraps
80105bed:	e9 18 fb ff ff       	jmp    8010570a <alltraps>

80105bf2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105bf2:	6a 00                	push   $0x0
  pushl $5
80105bf4:	6a 05                	push   $0x5
  jmp alltraps
80105bf6:	e9 0f fb ff ff       	jmp    8010570a <alltraps>

80105bfb <vector6>:
.globl vector6
vector6:
  pushl $0
80105bfb:	6a 00                	push   $0x0
  pushl $6
80105bfd:	6a 06                	push   $0x6
  jmp alltraps
80105bff:	e9 06 fb ff ff       	jmp    8010570a <alltraps>

80105c04 <vector7>:
.globl vector7
vector7:
  pushl $0
80105c04:	6a 00                	push   $0x0
  pushl $7
80105c06:	6a 07                	push   $0x7
  jmp alltraps
80105c08:	e9 fd fa ff ff       	jmp    8010570a <alltraps>

80105c0d <vector8>:
.globl vector8
vector8:
  pushl $8
80105c0d:	6a 08                	push   $0x8
  jmp alltraps
80105c0f:	e9 f6 fa ff ff       	jmp    8010570a <alltraps>

80105c14 <vector9>:
.globl vector9
vector9:
  pushl $0
80105c14:	6a 00                	push   $0x0
  pushl $9
80105c16:	6a 09                	push   $0x9
  jmp alltraps
80105c18:	e9 ed fa ff ff       	jmp    8010570a <alltraps>

80105c1d <vector10>:
.globl vector10
vector10:
  pushl $10
80105c1d:	6a 0a                	push   $0xa
  jmp alltraps
80105c1f:	e9 e6 fa ff ff       	jmp    8010570a <alltraps>

80105c24 <vector11>:
.globl vector11
vector11:
  pushl $11
80105c24:	6a 0b                	push   $0xb
  jmp alltraps
80105c26:	e9 df fa ff ff       	jmp    8010570a <alltraps>

80105c2b <vector12>:
.globl vector12
vector12:
  pushl $12
80105c2b:	6a 0c                	push   $0xc
  jmp alltraps
80105c2d:	e9 d8 fa ff ff       	jmp    8010570a <alltraps>

80105c32 <vector13>:
.globl vector13
vector13:
  pushl $13
80105c32:	6a 0d                	push   $0xd
  jmp alltraps
80105c34:	e9 d1 fa ff ff       	jmp    8010570a <alltraps>

80105c39 <vector14>:
.globl vector14
vector14:
  pushl $14
80105c39:	6a 0e                	push   $0xe
  jmp alltraps
80105c3b:	e9 ca fa ff ff       	jmp    8010570a <alltraps>

80105c40 <vector15>:
.globl vector15
vector15:
  pushl $0
80105c40:	6a 00                	push   $0x0
  pushl $15
80105c42:	6a 0f                	push   $0xf
  jmp alltraps
80105c44:	e9 c1 fa ff ff       	jmp    8010570a <alltraps>

80105c49 <vector16>:
.globl vector16
vector16:
  pushl $0
80105c49:	6a 00                	push   $0x0
  pushl $16
80105c4b:	6a 10                	push   $0x10
  jmp alltraps
80105c4d:	e9 b8 fa ff ff       	jmp    8010570a <alltraps>

80105c52 <vector17>:
.globl vector17
vector17:
  pushl $17
80105c52:	6a 11                	push   $0x11
  jmp alltraps
80105c54:	e9 b1 fa ff ff       	jmp    8010570a <alltraps>

80105c59 <vector18>:
.globl vector18
vector18:
  pushl $0
80105c59:	6a 00                	push   $0x0
  pushl $18
80105c5b:	6a 12                	push   $0x12
  jmp alltraps
80105c5d:	e9 a8 fa ff ff       	jmp    8010570a <alltraps>

80105c62 <vector19>:
.globl vector19
vector19:
  pushl $0
80105c62:	6a 00                	push   $0x0
  pushl $19
80105c64:	6a 13                	push   $0x13
  jmp alltraps
80105c66:	e9 9f fa ff ff       	jmp    8010570a <alltraps>

80105c6b <vector20>:
.globl vector20
vector20:
  pushl $0
80105c6b:	6a 00                	push   $0x0
  pushl $20
80105c6d:	6a 14                	push   $0x14
  jmp alltraps
80105c6f:	e9 96 fa ff ff       	jmp    8010570a <alltraps>

80105c74 <vector21>:
.globl vector21
vector21:
  pushl $0
80105c74:	6a 00                	push   $0x0
  pushl $21
80105c76:	6a 15                	push   $0x15
  jmp alltraps
80105c78:	e9 8d fa ff ff       	jmp    8010570a <alltraps>

80105c7d <vector22>:
.globl vector22
vector22:
  pushl $0
80105c7d:	6a 00                	push   $0x0
  pushl $22
80105c7f:	6a 16                	push   $0x16
  jmp alltraps
80105c81:	e9 84 fa ff ff       	jmp    8010570a <alltraps>

80105c86 <vector23>:
.globl vector23
vector23:
  pushl $0
80105c86:	6a 00                	push   $0x0
  pushl $23
80105c88:	6a 17                	push   $0x17
  jmp alltraps
80105c8a:	e9 7b fa ff ff       	jmp    8010570a <alltraps>

80105c8f <vector24>:
.globl vector24
vector24:
  pushl $0
80105c8f:	6a 00                	push   $0x0
  pushl $24
80105c91:	6a 18                	push   $0x18
  jmp alltraps
80105c93:	e9 72 fa ff ff       	jmp    8010570a <alltraps>

80105c98 <vector25>:
.globl vector25
vector25:
  pushl $0
80105c98:	6a 00                	push   $0x0
  pushl $25
80105c9a:	6a 19                	push   $0x19
  jmp alltraps
80105c9c:	e9 69 fa ff ff       	jmp    8010570a <alltraps>

80105ca1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ca1:	6a 00                	push   $0x0
  pushl $26
80105ca3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ca5:	e9 60 fa ff ff       	jmp    8010570a <alltraps>

80105caa <vector27>:
.globl vector27
vector27:
  pushl $0
80105caa:	6a 00                	push   $0x0
  pushl $27
80105cac:	6a 1b                	push   $0x1b
  jmp alltraps
80105cae:	e9 57 fa ff ff       	jmp    8010570a <alltraps>

80105cb3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105cb3:	6a 00                	push   $0x0
  pushl $28
80105cb5:	6a 1c                	push   $0x1c
  jmp alltraps
80105cb7:	e9 4e fa ff ff       	jmp    8010570a <alltraps>

80105cbc <vector29>:
.globl vector29
vector29:
  pushl $0
80105cbc:	6a 00                	push   $0x0
  pushl $29
80105cbe:	6a 1d                	push   $0x1d
  jmp alltraps
80105cc0:	e9 45 fa ff ff       	jmp    8010570a <alltraps>

80105cc5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105cc5:	6a 00                	push   $0x0
  pushl $30
80105cc7:	6a 1e                	push   $0x1e
  jmp alltraps
80105cc9:	e9 3c fa ff ff       	jmp    8010570a <alltraps>

80105cce <vector31>:
.globl vector31
vector31:
  pushl $0
80105cce:	6a 00                	push   $0x0
  pushl $31
80105cd0:	6a 1f                	push   $0x1f
  jmp alltraps
80105cd2:	e9 33 fa ff ff       	jmp    8010570a <alltraps>

80105cd7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105cd7:	6a 00                	push   $0x0
  pushl $32
80105cd9:	6a 20                	push   $0x20
  jmp alltraps
80105cdb:	e9 2a fa ff ff       	jmp    8010570a <alltraps>

80105ce0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105ce0:	6a 00                	push   $0x0
  pushl $33
80105ce2:	6a 21                	push   $0x21
  jmp alltraps
80105ce4:	e9 21 fa ff ff       	jmp    8010570a <alltraps>

80105ce9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ce9:	6a 00                	push   $0x0
  pushl $34
80105ceb:	6a 22                	push   $0x22
  jmp alltraps
80105ced:	e9 18 fa ff ff       	jmp    8010570a <alltraps>

80105cf2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105cf2:	6a 00                	push   $0x0
  pushl $35
80105cf4:	6a 23                	push   $0x23
  jmp alltraps
80105cf6:	e9 0f fa ff ff       	jmp    8010570a <alltraps>

80105cfb <vector36>:
.globl vector36
vector36:
  pushl $0
80105cfb:	6a 00                	push   $0x0
  pushl $36
80105cfd:	6a 24                	push   $0x24
  jmp alltraps
80105cff:	e9 06 fa ff ff       	jmp    8010570a <alltraps>

80105d04 <vector37>:
.globl vector37
vector37:
  pushl $0
80105d04:	6a 00                	push   $0x0
  pushl $37
80105d06:	6a 25                	push   $0x25
  jmp alltraps
80105d08:	e9 fd f9 ff ff       	jmp    8010570a <alltraps>

80105d0d <vector38>:
.globl vector38
vector38:
  pushl $0
80105d0d:	6a 00                	push   $0x0
  pushl $38
80105d0f:	6a 26                	push   $0x26
  jmp alltraps
80105d11:	e9 f4 f9 ff ff       	jmp    8010570a <alltraps>

80105d16 <vector39>:
.globl vector39
vector39:
  pushl $0
80105d16:	6a 00                	push   $0x0
  pushl $39
80105d18:	6a 27                	push   $0x27
  jmp alltraps
80105d1a:	e9 eb f9 ff ff       	jmp    8010570a <alltraps>

80105d1f <vector40>:
.globl vector40
vector40:
  pushl $0
80105d1f:	6a 00                	push   $0x0
  pushl $40
80105d21:	6a 28                	push   $0x28
  jmp alltraps
80105d23:	e9 e2 f9 ff ff       	jmp    8010570a <alltraps>

80105d28 <vector41>:
.globl vector41
vector41:
  pushl $0
80105d28:	6a 00                	push   $0x0
  pushl $41
80105d2a:	6a 29                	push   $0x29
  jmp alltraps
80105d2c:	e9 d9 f9 ff ff       	jmp    8010570a <alltraps>

80105d31 <vector42>:
.globl vector42
vector42:
  pushl $0
80105d31:	6a 00                	push   $0x0
  pushl $42
80105d33:	6a 2a                	push   $0x2a
  jmp alltraps
80105d35:	e9 d0 f9 ff ff       	jmp    8010570a <alltraps>

80105d3a <vector43>:
.globl vector43
vector43:
  pushl $0
80105d3a:	6a 00                	push   $0x0
  pushl $43
80105d3c:	6a 2b                	push   $0x2b
  jmp alltraps
80105d3e:	e9 c7 f9 ff ff       	jmp    8010570a <alltraps>

80105d43 <vector44>:
.globl vector44
vector44:
  pushl $0
80105d43:	6a 00                	push   $0x0
  pushl $44
80105d45:	6a 2c                	push   $0x2c
  jmp alltraps
80105d47:	e9 be f9 ff ff       	jmp    8010570a <alltraps>

80105d4c <vector45>:
.globl vector45
vector45:
  pushl $0
80105d4c:	6a 00                	push   $0x0
  pushl $45
80105d4e:	6a 2d                	push   $0x2d
  jmp alltraps
80105d50:	e9 b5 f9 ff ff       	jmp    8010570a <alltraps>

80105d55 <vector46>:
.globl vector46
vector46:
  pushl $0
80105d55:	6a 00                	push   $0x0
  pushl $46
80105d57:	6a 2e                	push   $0x2e
  jmp alltraps
80105d59:	e9 ac f9 ff ff       	jmp    8010570a <alltraps>

80105d5e <vector47>:
.globl vector47
vector47:
  pushl $0
80105d5e:	6a 00                	push   $0x0
  pushl $47
80105d60:	6a 2f                	push   $0x2f
  jmp alltraps
80105d62:	e9 a3 f9 ff ff       	jmp    8010570a <alltraps>

80105d67 <vector48>:
.globl vector48
vector48:
  pushl $0
80105d67:	6a 00                	push   $0x0
  pushl $48
80105d69:	6a 30                	push   $0x30
  jmp alltraps
80105d6b:	e9 9a f9 ff ff       	jmp    8010570a <alltraps>

80105d70 <vector49>:
.globl vector49
vector49:
  pushl $0
80105d70:	6a 00                	push   $0x0
  pushl $49
80105d72:	6a 31                	push   $0x31
  jmp alltraps
80105d74:	e9 91 f9 ff ff       	jmp    8010570a <alltraps>

80105d79 <vector50>:
.globl vector50
vector50:
  pushl $0
80105d79:	6a 00                	push   $0x0
  pushl $50
80105d7b:	6a 32                	push   $0x32
  jmp alltraps
80105d7d:	e9 88 f9 ff ff       	jmp    8010570a <alltraps>

80105d82 <vector51>:
.globl vector51
vector51:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $51
80105d84:	6a 33                	push   $0x33
  jmp alltraps
80105d86:	e9 7f f9 ff ff       	jmp    8010570a <alltraps>

80105d8b <vector52>:
.globl vector52
vector52:
  pushl $0
80105d8b:	6a 00                	push   $0x0
  pushl $52
80105d8d:	6a 34                	push   $0x34
  jmp alltraps
80105d8f:	e9 76 f9 ff ff       	jmp    8010570a <alltraps>

80105d94 <vector53>:
.globl vector53
vector53:
  pushl $0
80105d94:	6a 00                	push   $0x0
  pushl $53
80105d96:	6a 35                	push   $0x35
  jmp alltraps
80105d98:	e9 6d f9 ff ff       	jmp    8010570a <alltraps>

80105d9d <vector54>:
.globl vector54
vector54:
  pushl $0
80105d9d:	6a 00                	push   $0x0
  pushl $54
80105d9f:	6a 36                	push   $0x36
  jmp alltraps
80105da1:	e9 64 f9 ff ff       	jmp    8010570a <alltraps>

80105da6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105da6:	6a 00                	push   $0x0
  pushl $55
80105da8:	6a 37                	push   $0x37
  jmp alltraps
80105daa:	e9 5b f9 ff ff       	jmp    8010570a <alltraps>

80105daf <vector56>:
.globl vector56
vector56:
  pushl $0
80105daf:	6a 00                	push   $0x0
  pushl $56
80105db1:	6a 38                	push   $0x38
  jmp alltraps
80105db3:	e9 52 f9 ff ff       	jmp    8010570a <alltraps>

80105db8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105db8:	6a 00                	push   $0x0
  pushl $57
80105dba:	6a 39                	push   $0x39
  jmp alltraps
80105dbc:	e9 49 f9 ff ff       	jmp    8010570a <alltraps>

80105dc1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105dc1:	6a 00                	push   $0x0
  pushl $58
80105dc3:	6a 3a                	push   $0x3a
  jmp alltraps
80105dc5:	e9 40 f9 ff ff       	jmp    8010570a <alltraps>

80105dca <vector59>:
.globl vector59
vector59:
  pushl $0
80105dca:	6a 00                	push   $0x0
  pushl $59
80105dcc:	6a 3b                	push   $0x3b
  jmp alltraps
80105dce:	e9 37 f9 ff ff       	jmp    8010570a <alltraps>

80105dd3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105dd3:	6a 00                	push   $0x0
  pushl $60
80105dd5:	6a 3c                	push   $0x3c
  jmp alltraps
80105dd7:	e9 2e f9 ff ff       	jmp    8010570a <alltraps>

80105ddc <vector61>:
.globl vector61
vector61:
  pushl $0
80105ddc:	6a 00                	push   $0x0
  pushl $61
80105dde:	6a 3d                	push   $0x3d
  jmp alltraps
80105de0:	e9 25 f9 ff ff       	jmp    8010570a <alltraps>

80105de5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105de5:	6a 00                	push   $0x0
  pushl $62
80105de7:	6a 3e                	push   $0x3e
  jmp alltraps
80105de9:	e9 1c f9 ff ff       	jmp    8010570a <alltraps>

80105dee <vector63>:
.globl vector63
vector63:
  pushl $0
80105dee:	6a 00                	push   $0x0
  pushl $63
80105df0:	6a 3f                	push   $0x3f
  jmp alltraps
80105df2:	e9 13 f9 ff ff       	jmp    8010570a <alltraps>

80105df7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105df7:	6a 00                	push   $0x0
  pushl $64
80105df9:	6a 40                	push   $0x40
  jmp alltraps
80105dfb:	e9 0a f9 ff ff       	jmp    8010570a <alltraps>

80105e00 <vector65>:
.globl vector65
vector65:
  pushl $0
80105e00:	6a 00                	push   $0x0
  pushl $65
80105e02:	6a 41                	push   $0x41
  jmp alltraps
80105e04:	e9 01 f9 ff ff       	jmp    8010570a <alltraps>

80105e09 <vector66>:
.globl vector66
vector66:
  pushl $0
80105e09:	6a 00                	push   $0x0
  pushl $66
80105e0b:	6a 42                	push   $0x42
  jmp alltraps
80105e0d:	e9 f8 f8 ff ff       	jmp    8010570a <alltraps>

80105e12 <vector67>:
.globl vector67
vector67:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $67
80105e14:	6a 43                	push   $0x43
  jmp alltraps
80105e16:	e9 ef f8 ff ff       	jmp    8010570a <alltraps>

80105e1b <vector68>:
.globl vector68
vector68:
  pushl $0
80105e1b:	6a 00                	push   $0x0
  pushl $68
80105e1d:	6a 44                	push   $0x44
  jmp alltraps
80105e1f:	e9 e6 f8 ff ff       	jmp    8010570a <alltraps>

80105e24 <vector69>:
.globl vector69
vector69:
  pushl $0
80105e24:	6a 00                	push   $0x0
  pushl $69
80105e26:	6a 45                	push   $0x45
  jmp alltraps
80105e28:	e9 dd f8 ff ff       	jmp    8010570a <alltraps>

80105e2d <vector70>:
.globl vector70
vector70:
  pushl $0
80105e2d:	6a 00                	push   $0x0
  pushl $70
80105e2f:	6a 46                	push   $0x46
  jmp alltraps
80105e31:	e9 d4 f8 ff ff       	jmp    8010570a <alltraps>

80105e36 <vector71>:
.globl vector71
vector71:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $71
80105e38:	6a 47                	push   $0x47
  jmp alltraps
80105e3a:	e9 cb f8 ff ff       	jmp    8010570a <alltraps>

80105e3f <vector72>:
.globl vector72
vector72:
  pushl $0
80105e3f:	6a 00                	push   $0x0
  pushl $72
80105e41:	6a 48                	push   $0x48
  jmp alltraps
80105e43:	e9 c2 f8 ff ff       	jmp    8010570a <alltraps>

80105e48 <vector73>:
.globl vector73
vector73:
  pushl $0
80105e48:	6a 00                	push   $0x0
  pushl $73
80105e4a:	6a 49                	push   $0x49
  jmp alltraps
80105e4c:	e9 b9 f8 ff ff       	jmp    8010570a <alltraps>

80105e51 <vector74>:
.globl vector74
vector74:
  pushl $0
80105e51:	6a 00                	push   $0x0
  pushl $74
80105e53:	6a 4a                	push   $0x4a
  jmp alltraps
80105e55:	e9 b0 f8 ff ff       	jmp    8010570a <alltraps>

80105e5a <vector75>:
.globl vector75
vector75:
  pushl $0
80105e5a:	6a 00                	push   $0x0
  pushl $75
80105e5c:	6a 4b                	push   $0x4b
  jmp alltraps
80105e5e:	e9 a7 f8 ff ff       	jmp    8010570a <alltraps>

80105e63 <vector76>:
.globl vector76
vector76:
  pushl $0
80105e63:	6a 00                	push   $0x0
  pushl $76
80105e65:	6a 4c                	push   $0x4c
  jmp alltraps
80105e67:	e9 9e f8 ff ff       	jmp    8010570a <alltraps>

80105e6c <vector77>:
.globl vector77
vector77:
  pushl $0
80105e6c:	6a 00                	push   $0x0
  pushl $77
80105e6e:	6a 4d                	push   $0x4d
  jmp alltraps
80105e70:	e9 95 f8 ff ff       	jmp    8010570a <alltraps>

80105e75 <vector78>:
.globl vector78
vector78:
  pushl $0
80105e75:	6a 00                	push   $0x0
  pushl $78
80105e77:	6a 4e                	push   $0x4e
  jmp alltraps
80105e79:	e9 8c f8 ff ff       	jmp    8010570a <alltraps>

80105e7e <vector79>:
.globl vector79
vector79:
  pushl $0
80105e7e:	6a 00                	push   $0x0
  pushl $79
80105e80:	6a 4f                	push   $0x4f
  jmp alltraps
80105e82:	e9 83 f8 ff ff       	jmp    8010570a <alltraps>

80105e87 <vector80>:
.globl vector80
vector80:
  pushl $0
80105e87:	6a 00                	push   $0x0
  pushl $80
80105e89:	6a 50                	push   $0x50
  jmp alltraps
80105e8b:	e9 7a f8 ff ff       	jmp    8010570a <alltraps>

80105e90 <vector81>:
.globl vector81
vector81:
  pushl $0
80105e90:	6a 00                	push   $0x0
  pushl $81
80105e92:	6a 51                	push   $0x51
  jmp alltraps
80105e94:	e9 71 f8 ff ff       	jmp    8010570a <alltraps>

80105e99 <vector82>:
.globl vector82
vector82:
  pushl $0
80105e99:	6a 00                	push   $0x0
  pushl $82
80105e9b:	6a 52                	push   $0x52
  jmp alltraps
80105e9d:	e9 68 f8 ff ff       	jmp    8010570a <alltraps>

80105ea2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $83
80105ea4:	6a 53                	push   $0x53
  jmp alltraps
80105ea6:	e9 5f f8 ff ff       	jmp    8010570a <alltraps>

80105eab <vector84>:
.globl vector84
vector84:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $84
80105ead:	6a 54                	push   $0x54
  jmp alltraps
80105eaf:	e9 56 f8 ff ff       	jmp    8010570a <alltraps>

80105eb4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $85
80105eb6:	6a 55                	push   $0x55
  jmp alltraps
80105eb8:	e9 4d f8 ff ff       	jmp    8010570a <alltraps>

80105ebd <vector86>:
.globl vector86
vector86:
  pushl $0
80105ebd:	6a 00                	push   $0x0
  pushl $86
80105ebf:	6a 56                	push   $0x56
  jmp alltraps
80105ec1:	e9 44 f8 ff ff       	jmp    8010570a <alltraps>

80105ec6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $87
80105ec8:	6a 57                	push   $0x57
  jmp alltraps
80105eca:	e9 3b f8 ff ff       	jmp    8010570a <alltraps>

80105ecf <vector88>:
.globl vector88
vector88:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $88
80105ed1:	6a 58                	push   $0x58
  jmp alltraps
80105ed3:	e9 32 f8 ff ff       	jmp    8010570a <alltraps>

80105ed8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105ed8:	6a 00                	push   $0x0
  pushl $89
80105eda:	6a 59                	push   $0x59
  jmp alltraps
80105edc:	e9 29 f8 ff ff       	jmp    8010570a <alltraps>

80105ee1 <vector90>:
.globl vector90
vector90:
  pushl $0
80105ee1:	6a 00                	push   $0x0
  pushl $90
80105ee3:	6a 5a                	push   $0x5a
  jmp alltraps
80105ee5:	e9 20 f8 ff ff       	jmp    8010570a <alltraps>

80105eea <vector91>:
.globl vector91
vector91:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $91
80105eec:	6a 5b                	push   $0x5b
  jmp alltraps
80105eee:	e9 17 f8 ff ff       	jmp    8010570a <alltraps>

80105ef3 <vector92>:
.globl vector92
vector92:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $92
80105ef5:	6a 5c                	push   $0x5c
  jmp alltraps
80105ef7:	e9 0e f8 ff ff       	jmp    8010570a <alltraps>

80105efc <vector93>:
.globl vector93
vector93:
  pushl $0
80105efc:	6a 00                	push   $0x0
  pushl $93
80105efe:	6a 5d                	push   $0x5d
  jmp alltraps
80105f00:	e9 05 f8 ff ff       	jmp    8010570a <alltraps>

80105f05 <vector94>:
.globl vector94
vector94:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $94
80105f07:	6a 5e                	push   $0x5e
  jmp alltraps
80105f09:	e9 fc f7 ff ff       	jmp    8010570a <alltraps>

80105f0e <vector95>:
.globl vector95
vector95:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $95
80105f10:	6a 5f                	push   $0x5f
  jmp alltraps
80105f12:	e9 f3 f7 ff ff       	jmp    8010570a <alltraps>

80105f17 <vector96>:
.globl vector96
vector96:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $96
80105f19:	6a 60                	push   $0x60
  jmp alltraps
80105f1b:	e9 ea f7 ff ff       	jmp    8010570a <alltraps>

80105f20 <vector97>:
.globl vector97
vector97:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $97
80105f22:	6a 61                	push   $0x61
  jmp alltraps
80105f24:	e9 e1 f7 ff ff       	jmp    8010570a <alltraps>

80105f29 <vector98>:
.globl vector98
vector98:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $98
80105f2b:	6a 62                	push   $0x62
  jmp alltraps
80105f2d:	e9 d8 f7 ff ff       	jmp    8010570a <alltraps>

80105f32 <vector99>:
.globl vector99
vector99:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $99
80105f34:	6a 63                	push   $0x63
  jmp alltraps
80105f36:	e9 cf f7 ff ff       	jmp    8010570a <alltraps>

80105f3b <vector100>:
.globl vector100
vector100:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $100
80105f3d:	6a 64                	push   $0x64
  jmp alltraps
80105f3f:	e9 c6 f7 ff ff       	jmp    8010570a <alltraps>

80105f44 <vector101>:
.globl vector101
vector101:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $101
80105f46:	6a 65                	push   $0x65
  jmp alltraps
80105f48:	e9 bd f7 ff ff       	jmp    8010570a <alltraps>

80105f4d <vector102>:
.globl vector102
vector102:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $102
80105f4f:	6a 66                	push   $0x66
  jmp alltraps
80105f51:	e9 b4 f7 ff ff       	jmp    8010570a <alltraps>

80105f56 <vector103>:
.globl vector103
vector103:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $103
80105f58:	6a 67                	push   $0x67
  jmp alltraps
80105f5a:	e9 ab f7 ff ff       	jmp    8010570a <alltraps>

80105f5f <vector104>:
.globl vector104
vector104:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $104
80105f61:	6a 68                	push   $0x68
  jmp alltraps
80105f63:	e9 a2 f7 ff ff       	jmp    8010570a <alltraps>

80105f68 <vector105>:
.globl vector105
vector105:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $105
80105f6a:	6a 69                	push   $0x69
  jmp alltraps
80105f6c:	e9 99 f7 ff ff       	jmp    8010570a <alltraps>

80105f71 <vector106>:
.globl vector106
vector106:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $106
80105f73:	6a 6a                	push   $0x6a
  jmp alltraps
80105f75:	e9 90 f7 ff ff       	jmp    8010570a <alltraps>

80105f7a <vector107>:
.globl vector107
vector107:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $107
80105f7c:	6a 6b                	push   $0x6b
  jmp alltraps
80105f7e:	e9 87 f7 ff ff       	jmp    8010570a <alltraps>

80105f83 <vector108>:
.globl vector108
vector108:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $108
80105f85:	6a 6c                	push   $0x6c
  jmp alltraps
80105f87:	e9 7e f7 ff ff       	jmp    8010570a <alltraps>

80105f8c <vector109>:
.globl vector109
vector109:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $109
80105f8e:	6a 6d                	push   $0x6d
  jmp alltraps
80105f90:	e9 75 f7 ff ff       	jmp    8010570a <alltraps>

80105f95 <vector110>:
.globl vector110
vector110:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $110
80105f97:	6a 6e                	push   $0x6e
  jmp alltraps
80105f99:	e9 6c f7 ff ff       	jmp    8010570a <alltraps>

80105f9e <vector111>:
.globl vector111
vector111:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $111
80105fa0:	6a 6f                	push   $0x6f
  jmp alltraps
80105fa2:	e9 63 f7 ff ff       	jmp    8010570a <alltraps>

80105fa7 <vector112>:
.globl vector112
vector112:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $112
80105fa9:	6a 70                	push   $0x70
  jmp alltraps
80105fab:	e9 5a f7 ff ff       	jmp    8010570a <alltraps>

80105fb0 <vector113>:
.globl vector113
vector113:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $113
80105fb2:	6a 71                	push   $0x71
  jmp alltraps
80105fb4:	e9 51 f7 ff ff       	jmp    8010570a <alltraps>

80105fb9 <vector114>:
.globl vector114
vector114:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $114
80105fbb:	6a 72                	push   $0x72
  jmp alltraps
80105fbd:	e9 48 f7 ff ff       	jmp    8010570a <alltraps>

80105fc2 <vector115>:
.globl vector115
vector115:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $115
80105fc4:	6a 73                	push   $0x73
  jmp alltraps
80105fc6:	e9 3f f7 ff ff       	jmp    8010570a <alltraps>

80105fcb <vector116>:
.globl vector116
vector116:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $116
80105fcd:	6a 74                	push   $0x74
  jmp alltraps
80105fcf:	e9 36 f7 ff ff       	jmp    8010570a <alltraps>

80105fd4 <vector117>:
.globl vector117
vector117:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $117
80105fd6:	6a 75                	push   $0x75
  jmp alltraps
80105fd8:	e9 2d f7 ff ff       	jmp    8010570a <alltraps>

80105fdd <vector118>:
.globl vector118
vector118:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $118
80105fdf:	6a 76                	push   $0x76
  jmp alltraps
80105fe1:	e9 24 f7 ff ff       	jmp    8010570a <alltraps>

80105fe6 <vector119>:
.globl vector119
vector119:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $119
80105fe8:	6a 77                	push   $0x77
  jmp alltraps
80105fea:	e9 1b f7 ff ff       	jmp    8010570a <alltraps>

80105fef <vector120>:
.globl vector120
vector120:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $120
80105ff1:	6a 78                	push   $0x78
  jmp alltraps
80105ff3:	e9 12 f7 ff ff       	jmp    8010570a <alltraps>

80105ff8 <vector121>:
.globl vector121
vector121:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $121
80105ffa:	6a 79                	push   $0x79
  jmp alltraps
80105ffc:	e9 09 f7 ff ff       	jmp    8010570a <alltraps>

80106001 <vector122>:
.globl vector122
vector122:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $122
80106003:	6a 7a                	push   $0x7a
  jmp alltraps
80106005:	e9 00 f7 ff ff       	jmp    8010570a <alltraps>

8010600a <vector123>:
.globl vector123
vector123:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $123
8010600c:	6a 7b                	push   $0x7b
  jmp alltraps
8010600e:	e9 f7 f6 ff ff       	jmp    8010570a <alltraps>

80106013 <vector124>:
.globl vector124
vector124:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $124
80106015:	6a 7c                	push   $0x7c
  jmp alltraps
80106017:	e9 ee f6 ff ff       	jmp    8010570a <alltraps>

8010601c <vector125>:
.globl vector125
vector125:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $125
8010601e:	6a 7d                	push   $0x7d
  jmp alltraps
80106020:	e9 e5 f6 ff ff       	jmp    8010570a <alltraps>

80106025 <vector126>:
.globl vector126
vector126:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $126
80106027:	6a 7e                	push   $0x7e
  jmp alltraps
80106029:	e9 dc f6 ff ff       	jmp    8010570a <alltraps>

8010602e <vector127>:
.globl vector127
vector127:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $127
80106030:	6a 7f                	push   $0x7f
  jmp alltraps
80106032:	e9 d3 f6 ff ff       	jmp    8010570a <alltraps>

80106037 <vector128>:
.globl vector128
vector128:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $128
80106039:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010603e:	e9 c7 f6 ff ff       	jmp    8010570a <alltraps>

80106043 <vector129>:
.globl vector129
vector129:
  pushl $0
80106043:	6a 00                	push   $0x0
  pushl $129
80106045:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010604a:	e9 bb f6 ff ff       	jmp    8010570a <alltraps>

8010604f <vector130>:
.globl vector130
vector130:
  pushl $0
8010604f:	6a 00                	push   $0x0
  pushl $130
80106051:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106056:	e9 af f6 ff ff       	jmp    8010570a <alltraps>

8010605b <vector131>:
.globl vector131
vector131:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $131
8010605d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106062:	e9 a3 f6 ff ff       	jmp    8010570a <alltraps>

80106067 <vector132>:
.globl vector132
vector132:
  pushl $0
80106067:	6a 00                	push   $0x0
  pushl $132
80106069:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010606e:	e9 97 f6 ff ff       	jmp    8010570a <alltraps>

80106073 <vector133>:
.globl vector133
vector133:
  pushl $0
80106073:	6a 00                	push   $0x0
  pushl $133
80106075:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010607a:	e9 8b f6 ff ff       	jmp    8010570a <alltraps>

8010607f <vector134>:
.globl vector134
vector134:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $134
80106081:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106086:	e9 7f f6 ff ff       	jmp    8010570a <alltraps>

8010608b <vector135>:
.globl vector135
vector135:
  pushl $0
8010608b:	6a 00                	push   $0x0
  pushl $135
8010608d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106092:	e9 73 f6 ff ff       	jmp    8010570a <alltraps>

80106097 <vector136>:
.globl vector136
vector136:
  pushl $0
80106097:	6a 00                	push   $0x0
  pushl $136
80106099:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010609e:	e9 67 f6 ff ff       	jmp    8010570a <alltraps>

801060a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $137
801060a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801060aa:	e9 5b f6 ff ff       	jmp    8010570a <alltraps>

801060af <vector138>:
.globl vector138
vector138:
  pushl $0
801060af:	6a 00                	push   $0x0
  pushl $138
801060b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801060b6:	e9 4f f6 ff ff       	jmp    8010570a <alltraps>

801060bb <vector139>:
.globl vector139
vector139:
  pushl $0
801060bb:	6a 00                	push   $0x0
  pushl $139
801060bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801060c2:	e9 43 f6 ff ff       	jmp    8010570a <alltraps>

801060c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $140
801060c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801060ce:	e9 37 f6 ff ff       	jmp    8010570a <alltraps>

801060d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801060d3:	6a 00                	push   $0x0
  pushl $141
801060d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801060da:	e9 2b f6 ff ff       	jmp    8010570a <alltraps>

801060df <vector142>:
.globl vector142
vector142:
  pushl $0
801060df:	6a 00                	push   $0x0
  pushl $142
801060e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801060e6:	e9 1f f6 ff ff       	jmp    8010570a <alltraps>

801060eb <vector143>:
.globl vector143
vector143:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $143
801060ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801060f2:	e9 13 f6 ff ff       	jmp    8010570a <alltraps>

801060f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801060f7:	6a 00                	push   $0x0
  pushl $144
801060f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801060fe:	e9 07 f6 ff ff       	jmp    8010570a <alltraps>

80106103 <vector145>:
.globl vector145
vector145:
  pushl $0
80106103:	6a 00                	push   $0x0
  pushl $145
80106105:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010610a:	e9 fb f5 ff ff       	jmp    8010570a <alltraps>

8010610f <vector146>:
.globl vector146
vector146:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $146
80106111:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106116:	e9 ef f5 ff ff       	jmp    8010570a <alltraps>

8010611b <vector147>:
.globl vector147
vector147:
  pushl $0
8010611b:	6a 00                	push   $0x0
  pushl $147
8010611d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106122:	e9 e3 f5 ff ff       	jmp    8010570a <alltraps>

80106127 <vector148>:
.globl vector148
vector148:
  pushl $0
80106127:	6a 00                	push   $0x0
  pushl $148
80106129:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010612e:	e9 d7 f5 ff ff       	jmp    8010570a <alltraps>

80106133 <vector149>:
.globl vector149
vector149:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $149
80106135:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010613a:	e9 cb f5 ff ff       	jmp    8010570a <alltraps>

8010613f <vector150>:
.globl vector150
vector150:
  pushl $0
8010613f:	6a 00                	push   $0x0
  pushl $150
80106141:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106146:	e9 bf f5 ff ff       	jmp    8010570a <alltraps>

8010614b <vector151>:
.globl vector151
vector151:
  pushl $0
8010614b:	6a 00                	push   $0x0
  pushl $151
8010614d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106152:	e9 b3 f5 ff ff       	jmp    8010570a <alltraps>

80106157 <vector152>:
.globl vector152
vector152:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $152
80106159:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010615e:	e9 a7 f5 ff ff       	jmp    8010570a <alltraps>

80106163 <vector153>:
.globl vector153
vector153:
  pushl $0
80106163:	6a 00                	push   $0x0
  pushl $153
80106165:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010616a:	e9 9b f5 ff ff       	jmp    8010570a <alltraps>

8010616f <vector154>:
.globl vector154
vector154:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $154
80106171:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106176:	e9 8f f5 ff ff       	jmp    8010570a <alltraps>

8010617b <vector155>:
.globl vector155
vector155:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $155
8010617d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106182:	e9 83 f5 ff ff       	jmp    8010570a <alltraps>

80106187 <vector156>:
.globl vector156
vector156:
  pushl $0
80106187:	6a 00                	push   $0x0
  pushl $156
80106189:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010618e:	e9 77 f5 ff ff       	jmp    8010570a <alltraps>

80106193 <vector157>:
.globl vector157
vector157:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $157
80106195:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010619a:	e9 6b f5 ff ff       	jmp    8010570a <alltraps>

8010619f <vector158>:
.globl vector158
vector158:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $158
801061a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801061a6:	e9 5f f5 ff ff       	jmp    8010570a <alltraps>

801061ab <vector159>:
.globl vector159
vector159:
  pushl $0
801061ab:	6a 00                	push   $0x0
  pushl $159
801061ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801061b2:	e9 53 f5 ff ff       	jmp    8010570a <alltraps>

801061b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $160
801061b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801061be:	e9 47 f5 ff ff       	jmp    8010570a <alltraps>

801061c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $161
801061c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801061ca:	e9 3b f5 ff ff       	jmp    8010570a <alltraps>

801061cf <vector162>:
.globl vector162
vector162:
  pushl $0
801061cf:	6a 00                	push   $0x0
  pushl $162
801061d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801061d6:	e9 2f f5 ff ff       	jmp    8010570a <alltraps>

801061db <vector163>:
.globl vector163
vector163:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $163
801061dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801061e2:	e9 23 f5 ff ff       	jmp    8010570a <alltraps>

801061e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $164
801061e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801061ee:	e9 17 f5 ff ff       	jmp    8010570a <alltraps>

801061f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801061f3:	6a 00                	push   $0x0
  pushl $165
801061f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801061fa:	e9 0b f5 ff ff       	jmp    8010570a <alltraps>

801061ff <vector166>:
.globl vector166
vector166:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $166
80106201:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106206:	e9 ff f4 ff ff       	jmp    8010570a <alltraps>

8010620b <vector167>:
.globl vector167
vector167:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $167
8010620d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106212:	e9 f3 f4 ff ff       	jmp    8010570a <alltraps>

80106217 <vector168>:
.globl vector168
vector168:
  pushl $0
80106217:	6a 00                	push   $0x0
  pushl $168
80106219:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010621e:	e9 e7 f4 ff ff       	jmp    8010570a <alltraps>

80106223 <vector169>:
.globl vector169
vector169:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $169
80106225:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010622a:	e9 db f4 ff ff       	jmp    8010570a <alltraps>

8010622f <vector170>:
.globl vector170
vector170:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $170
80106231:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106236:	e9 cf f4 ff ff       	jmp    8010570a <alltraps>

8010623b <vector171>:
.globl vector171
vector171:
  pushl $0
8010623b:	6a 00                	push   $0x0
  pushl $171
8010623d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106242:	e9 c3 f4 ff ff       	jmp    8010570a <alltraps>

80106247 <vector172>:
.globl vector172
vector172:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $172
80106249:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010624e:	e9 b7 f4 ff ff       	jmp    8010570a <alltraps>

80106253 <vector173>:
.globl vector173
vector173:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $173
80106255:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010625a:	e9 ab f4 ff ff       	jmp    8010570a <alltraps>

8010625f <vector174>:
.globl vector174
vector174:
  pushl $0
8010625f:	6a 00                	push   $0x0
  pushl $174
80106261:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106266:	e9 9f f4 ff ff       	jmp    8010570a <alltraps>

8010626b <vector175>:
.globl vector175
vector175:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $175
8010626d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106272:	e9 93 f4 ff ff       	jmp    8010570a <alltraps>

80106277 <vector176>:
.globl vector176
vector176:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $176
80106279:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010627e:	e9 87 f4 ff ff       	jmp    8010570a <alltraps>

80106283 <vector177>:
.globl vector177
vector177:
  pushl $0
80106283:	6a 00                	push   $0x0
  pushl $177
80106285:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010628a:	e9 7b f4 ff ff       	jmp    8010570a <alltraps>

8010628f <vector178>:
.globl vector178
vector178:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $178
80106291:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106296:	e9 6f f4 ff ff       	jmp    8010570a <alltraps>

8010629b <vector179>:
.globl vector179
vector179:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $179
8010629d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801062a2:	e9 63 f4 ff ff       	jmp    8010570a <alltraps>

801062a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801062a7:	6a 00                	push   $0x0
  pushl $180
801062a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801062ae:	e9 57 f4 ff ff       	jmp    8010570a <alltraps>

801062b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $181
801062b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801062ba:	e9 4b f4 ff ff       	jmp    8010570a <alltraps>

801062bf <vector182>:
.globl vector182
vector182:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $182
801062c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801062c6:	e9 3f f4 ff ff       	jmp    8010570a <alltraps>

801062cb <vector183>:
.globl vector183
vector183:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $183
801062cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801062d2:	e9 33 f4 ff ff       	jmp    8010570a <alltraps>

801062d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $184
801062d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801062de:	e9 27 f4 ff ff       	jmp    8010570a <alltraps>

801062e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $185
801062e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801062ea:	e9 1b f4 ff ff       	jmp    8010570a <alltraps>

801062ef <vector186>:
.globl vector186
vector186:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $186
801062f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801062f6:	e9 0f f4 ff ff       	jmp    8010570a <alltraps>

801062fb <vector187>:
.globl vector187
vector187:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $187
801062fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106302:	e9 03 f4 ff ff       	jmp    8010570a <alltraps>

80106307 <vector188>:
.globl vector188
vector188:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $188
80106309:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010630e:	e9 f7 f3 ff ff       	jmp    8010570a <alltraps>

80106313 <vector189>:
.globl vector189
vector189:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $189
80106315:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010631a:	e9 eb f3 ff ff       	jmp    8010570a <alltraps>

8010631f <vector190>:
.globl vector190
vector190:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $190
80106321:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106326:	e9 df f3 ff ff       	jmp    8010570a <alltraps>

8010632b <vector191>:
.globl vector191
vector191:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $191
8010632d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106332:	e9 d3 f3 ff ff       	jmp    8010570a <alltraps>

80106337 <vector192>:
.globl vector192
vector192:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $192
80106339:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010633e:	e9 c7 f3 ff ff       	jmp    8010570a <alltraps>

80106343 <vector193>:
.globl vector193
vector193:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $193
80106345:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010634a:	e9 bb f3 ff ff       	jmp    8010570a <alltraps>

8010634f <vector194>:
.globl vector194
vector194:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $194
80106351:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106356:	e9 af f3 ff ff       	jmp    8010570a <alltraps>

8010635b <vector195>:
.globl vector195
vector195:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $195
8010635d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106362:	e9 a3 f3 ff ff       	jmp    8010570a <alltraps>

80106367 <vector196>:
.globl vector196
vector196:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $196
80106369:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010636e:	e9 97 f3 ff ff       	jmp    8010570a <alltraps>

80106373 <vector197>:
.globl vector197
vector197:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $197
80106375:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010637a:	e9 8b f3 ff ff       	jmp    8010570a <alltraps>

8010637f <vector198>:
.globl vector198
vector198:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $198
80106381:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106386:	e9 7f f3 ff ff       	jmp    8010570a <alltraps>

8010638b <vector199>:
.globl vector199
vector199:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $199
8010638d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106392:	e9 73 f3 ff ff       	jmp    8010570a <alltraps>

80106397 <vector200>:
.globl vector200
vector200:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $200
80106399:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010639e:	e9 67 f3 ff ff       	jmp    8010570a <alltraps>

801063a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $201
801063a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801063aa:	e9 5b f3 ff ff       	jmp    8010570a <alltraps>

801063af <vector202>:
.globl vector202
vector202:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $202
801063b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801063b6:	e9 4f f3 ff ff       	jmp    8010570a <alltraps>

801063bb <vector203>:
.globl vector203
vector203:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $203
801063bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801063c2:	e9 43 f3 ff ff       	jmp    8010570a <alltraps>

801063c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $204
801063c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801063ce:	e9 37 f3 ff ff       	jmp    8010570a <alltraps>

801063d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $205
801063d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801063da:	e9 2b f3 ff ff       	jmp    8010570a <alltraps>

801063df <vector206>:
.globl vector206
vector206:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $206
801063e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801063e6:	e9 1f f3 ff ff       	jmp    8010570a <alltraps>

801063eb <vector207>:
.globl vector207
vector207:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $207
801063ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801063f2:	e9 13 f3 ff ff       	jmp    8010570a <alltraps>

801063f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $208
801063f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801063fe:	e9 07 f3 ff ff       	jmp    8010570a <alltraps>

80106403 <vector209>:
.globl vector209
vector209:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $209
80106405:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010640a:	e9 fb f2 ff ff       	jmp    8010570a <alltraps>

8010640f <vector210>:
.globl vector210
vector210:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $210
80106411:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106416:	e9 ef f2 ff ff       	jmp    8010570a <alltraps>

8010641b <vector211>:
.globl vector211
vector211:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $211
8010641d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106422:	e9 e3 f2 ff ff       	jmp    8010570a <alltraps>

80106427 <vector212>:
.globl vector212
vector212:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $212
80106429:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010642e:	e9 d7 f2 ff ff       	jmp    8010570a <alltraps>

80106433 <vector213>:
.globl vector213
vector213:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $213
80106435:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010643a:	e9 cb f2 ff ff       	jmp    8010570a <alltraps>

8010643f <vector214>:
.globl vector214
vector214:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $214
80106441:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106446:	e9 bf f2 ff ff       	jmp    8010570a <alltraps>

8010644b <vector215>:
.globl vector215
vector215:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $215
8010644d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106452:	e9 b3 f2 ff ff       	jmp    8010570a <alltraps>

80106457 <vector216>:
.globl vector216
vector216:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $216
80106459:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010645e:	e9 a7 f2 ff ff       	jmp    8010570a <alltraps>

80106463 <vector217>:
.globl vector217
vector217:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $217
80106465:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010646a:	e9 9b f2 ff ff       	jmp    8010570a <alltraps>

8010646f <vector218>:
.globl vector218
vector218:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $218
80106471:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106476:	e9 8f f2 ff ff       	jmp    8010570a <alltraps>

8010647b <vector219>:
.globl vector219
vector219:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $219
8010647d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106482:	e9 83 f2 ff ff       	jmp    8010570a <alltraps>

80106487 <vector220>:
.globl vector220
vector220:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $220
80106489:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010648e:	e9 77 f2 ff ff       	jmp    8010570a <alltraps>

80106493 <vector221>:
.globl vector221
vector221:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $221
80106495:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010649a:	e9 6b f2 ff ff       	jmp    8010570a <alltraps>

8010649f <vector222>:
.globl vector222
vector222:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $222
801064a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801064a6:	e9 5f f2 ff ff       	jmp    8010570a <alltraps>

801064ab <vector223>:
.globl vector223
vector223:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $223
801064ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801064b2:	e9 53 f2 ff ff       	jmp    8010570a <alltraps>

801064b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $224
801064b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801064be:	e9 47 f2 ff ff       	jmp    8010570a <alltraps>

801064c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $225
801064c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801064ca:	e9 3b f2 ff ff       	jmp    8010570a <alltraps>

801064cf <vector226>:
.globl vector226
vector226:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $226
801064d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801064d6:	e9 2f f2 ff ff       	jmp    8010570a <alltraps>

801064db <vector227>:
.globl vector227
vector227:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $227
801064dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801064e2:	e9 23 f2 ff ff       	jmp    8010570a <alltraps>

801064e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $228
801064e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801064ee:	e9 17 f2 ff ff       	jmp    8010570a <alltraps>

801064f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $229
801064f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801064fa:	e9 0b f2 ff ff       	jmp    8010570a <alltraps>

801064ff <vector230>:
.globl vector230
vector230:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $230
80106501:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106506:	e9 ff f1 ff ff       	jmp    8010570a <alltraps>

8010650b <vector231>:
.globl vector231
vector231:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $231
8010650d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106512:	e9 f3 f1 ff ff       	jmp    8010570a <alltraps>

80106517 <vector232>:
.globl vector232
vector232:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $232
80106519:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010651e:	e9 e7 f1 ff ff       	jmp    8010570a <alltraps>

80106523 <vector233>:
.globl vector233
vector233:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $233
80106525:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010652a:	e9 db f1 ff ff       	jmp    8010570a <alltraps>

8010652f <vector234>:
.globl vector234
vector234:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $234
80106531:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106536:	e9 cf f1 ff ff       	jmp    8010570a <alltraps>

8010653b <vector235>:
.globl vector235
vector235:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $235
8010653d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106542:	e9 c3 f1 ff ff       	jmp    8010570a <alltraps>

80106547 <vector236>:
.globl vector236
vector236:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $236
80106549:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010654e:	e9 b7 f1 ff ff       	jmp    8010570a <alltraps>

80106553 <vector237>:
.globl vector237
vector237:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $237
80106555:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010655a:	e9 ab f1 ff ff       	jmp    8010570a <alltraps>

8010655f <vector238>:
.globl vector238
vector238:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $238
80106561:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106566:	e9 9f f1 ff ff       	jmp    8010570a <alltraps>

8010656b <vector239>:
.globl vector239
vector239:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $239
8010656d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106572:	e9 93 f1 ff ff       	jmp    8010570a <alltraps>

80106577 <vector240>:
.globl vector240
vector240:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $240
80106579:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010657e:	e9 87 f1 ff ff       	jmp    8010570a <alltraps>

80106583 <vector241>:
.globl vector241
vector241:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $241
80106585:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010658a:	e9 7b f1 ff ff       	jmp    8010570a <alltraps>

8010658f <vector242>:
.globl vector242
vector242:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $242
80106591:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106596:	e9 6f f1 ff ff       	jmp    8010570a <alltraps>

8010659b <vector243>:
.globl vector243
vector243:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $243
8010659d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801065a2:	e9 63 f1 ff ff       	jmp    8010570a <alltraps>

801065a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $244
801065a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801065ae:	e9 57 f1 ff ff       	jmp    8010570a <alltraps>

801065b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $245
801065b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801065ba:	e9 4b f1 ff ff       	jmp    8010570a <alltraps>

801065bf <vector246>:
.globl vector246
vector246:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $246
801065c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801065c6:	e9 3f f1 ff ff       	jmp    8010570a <alltraps>

801065cb <vector247>:
.globl vector247
vector247:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $247
801065cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801065d2:	e9 33 f1 ff ff       	jmp    8010570a <alltraps>

801065d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $248
801065d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801065de:	e9 27 f1 ff ff       	jmp    8010570a <alltraps>

801065e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $249
801065e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801065ea:	e9 1b f1 ff ff       	jmp    8010570a <alltraps>

801065ef <vector250>:
.globl vector250
vector250:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $250
801065f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801065f6:	e9 0f f1 ff ff       	jmp    8010570a <alltraps>

801065fb <vector251>:
.globl vector251
vector251:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $251
801065fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106602:	e9 03 f1 ff ff       	jmp    8010570a <alltraps>

80106607 <vector252>:
.globl vector252
vector252:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $252
80106609:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010660e:	e9 f7 f0 ff ff       	jmp    8010570a <alltraps>

80106613 <vector253>:
.globl vector253
vector253:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $253
80106615:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010661a:	e9 eb f0 ff ff       	jmp    8010570a <alltraps>

8010661f <vector254>:
.globl vector254
vector254:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $254
80106621:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106626:	e9 df f0 ff ff       	jmp    8010570a <alltraps>

8010662b <vector255>:
.globl vector255
vector255:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $255
8010662d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106632:	e9 d3 f0 ff ff       	jmp    8010570a <alltraps>
80106637:	66 90                	xchg   %ax,%ax
80106639:	66 90                	xchg   %ax,%ax
8010663b:	66 90                	xchg   %ax,%ax
8010663d:	66 90                	xchg   %ax,%ax
8010663f:	90                   	nop

80106640 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	57                   	push   %edi
80106644:	56                   	push   %esi
80106645:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106646:	89 d3                	mov    %edx,%ebx
{
80106648:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010664a:	c1 eb 16             	shr    $0x16,%ebx
8010664d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106650:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106653:	8b 06                	mov    (%esi),%eax
80106655:	a8 01                	test   $0x1,%al
80106657:	74 27                	je     80106680 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106659:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010665e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106664:	c1 ef 0a             	shr    $0xa,%edi
}
80106667:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010666a:	89 fa                	mov    %edi,%edx
8010666c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106672:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106675:	5b                   	pop    %ebx
80106676:	5e                   	pop    %esi
80106677:	5f                   	pop    %edi
80106678:	5d                   	pop    %ebp
80106679:	c3                   	ret    
8010667a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106680:	85 c9                	test   %ecx,%ecx
80106682:	74 2c                	je     801066b0 <walkpgdir+0x70>
80106684:	e8 f7 be ff ff       	call   80102580 <kalloc>
80106689:	85 c0                	test   %eax,%eax
8010668b:	89 c3                	mov    %eax,%ebx
8010668d:	74 21                	je     801066b0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010668f:	83 ec 04             	sub    $0x4,%esp
80106692:	68 00 10 00 00       	push   $0x1000
80106697:	6a 00                	push   $0x0
80106699:	50                   	push   %eax
8010669a:	e8 91 de ff ff       	call   80104530 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010669f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801066a5:	83 c4 10             	add    $0x10,%esp
801066a8:	83 c8 07             	or     $0x7,%eax
801066ab:	89 06                	mov    %eax,(%esi)
801066ad:	eb b5                	jmp    80106664 <walkpgdir+0x24>
801066af:	90                   	nop
}
801066b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801066b3:	31 c0                	xor    %eax,%eax
}
801066b5:	5b                   	pop    %ebx
801066b6:	5e                   	pop    %esi
801066b7:	5f                   	pop    %edi
801066b8:	5d                   	pop    %ebp
801066b9:	c3                   	ret    
801066ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801066c0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801066c0:	55                   	push   %ebp
801066c1:	89 e5                	mov    %esp,%ebp
801066c3:	57                   	push   %edi
801066c4:	56                   	push   %esi
801066c5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801066c6:	89 d3                	mov    %edx,%ebx
801066c8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801066ce:	83 ec 1c             	sub    $0x1c,%esp
801066d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801066d4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801066d8:	8b 7d 08             	mov    0x8(%ebp),%edi
801066db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801066e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801066e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801066e6:	29 df                	sub    %ebx,%edi
801066e8:	83 c8 01             	or     $0x1,%eax
801066eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801066ee:	eb 15                	jmp    80106705 <mappages+0x45>
    if(*pte & PTE_P)
801066f0:	f6 00 01             	testb  $0x1,(%eax)
801066f3:	75 45                	jne    8010673a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801066f5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801066f8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801066fb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801066fd:	74 31                	je     80106730 <mappages+0x70>
      break;
    a += PGSIZE;
801066ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106705:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106708:	b9 01 00 00 00       	mov    $0x1,%ecx
8010670d:	89 da                	mov    %ebx,%edx
8010670f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106712:	e8 29 ff ff ff       	call   80106640 <walkpgdir>
80106717:	85 c0                	test   %eax,%eax
80106719:	75 d5                	jne    801066f0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010671b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010671e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106723:	5b                   	pop    %ebx
80106724:	5e                   	pop    %esi
80106725:	5f                   	pop    %edi
80106726:	5d                   	pop    %ebp
80106727:	c3                   	ret    
80106728:	90                   	nop
80106729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106730:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106733:	31 c0                	xor    %eax,%eax
}
80106735:	5b                   	pop    %ebx
80106736:	5e                   	pop    %esi
80106737:	5f                   	pop    %edi
80106738:	5d                   	pop    %ebp
80106739:	c3                   	ret    
      panic("remap");
8010673a:	83 ec 0c             	sub    $0xc,%esp
8010673d:	68 68 78 10 80       	push   $0x80107868
80106742:	e8 29 9c ff ff       	call   80100370 <panic>
80106747:	89 f6                	mov    %esi,%esi
80106749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106750 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106750:	55                   	push   %ebp
80106751:	89 e5                	mov    %esp,%ebp
80106753:	57                   	push   %edi
80106754:	56                   	push   %esi
80106755:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106756:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010675c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010675e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106764:	83 ec 1c             	sub    $0x1c,%esp
80106767:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010676a:	39 d3                	cmp    %edx,%ebx
8010676c:	73 66                	jae    801067d4 <deallocuvm.part.0+0x84>
8010676e:	89 d6                	mov    %edx,%esi
80106770:	eb 3d                	jmp    801067af <deallocuvm.part.0+0x5f>
80106772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106778:	8b 10                	mov    (%eax),%edx
8010677a:	f6 c2 01             	test   $0x1,%dl
8010677d:	74 26                	je     801067a5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010677f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106785:	74 58                	je     801067df <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106787:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010678a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106790:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106793:	52                   	push   %edx
80106794:	e8 37 bc ff ff       	call   801023d0 <kfree>
      *pte = 0;
80106799:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010679c:	83 c4 10             	add    $0x10,%esp
8010679f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801067a5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067ab:	39 f3                	cmp    %esi,%ebx
801067ad:	73 25                	jae    801067d4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801067af:	31 c9                	xor    %ecx,%ecx
801067b1:	89 da                	mov    %ebx,%edx
801067b3:	89 f8                	mov    %edi,%eax
801067b5:	e8 86 fe ff ff       	call   80106640 <walkpgdir>
    if(!pte)
801067ba:	85 c0                	test   %eax,%eax
801067bc:	75 ba                	jne    80106778 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801067be:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801067c4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801067ca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067d0:	39 f3                	cmp    %esi,%ebx
801067d2:	72 db                	jb     801067af <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801067d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801067d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067da:	5b                   	pop    %ebx
801067db:	5e                   	pop    %esi
801067dc:	5f                   	pop    %edi
801067dd:	5d                   	pop    %ebp
801067de:	c3                   	ret    
        panic("kfree");
801067df:	83 ec 0c             	sub    $0xc,%esp
801067e2:	68 06 72 10 80       	push   $0x80107206
801067e7:	e8 84 9b ff ff       	call   80100370 <panic>
801067ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067f0 <seginit>:
{
801067f0:	55                   	push   %ebp
801067f1:	89 e5                	mov    %esp,%ebp
801067f3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801067f6:	e8 65 d0 ff ff       	call   80103860 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067fb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106801:	31 c9                	xor    %ecx,%ecx
80106803:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106808:	66 89 90 f8 27 11 80 	mov    %dx,-0x7feed808(%eax)
8010680f:	66 89 88 fa 27 11 80 	mov    %cx,-0x7feed806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106816:	ba ff ff ff ff       	mov    $0xffffffff,%edx
8010681b:	31 c9                	xor    %ecx,%ecx
8010681d:	66 89 90 00 28 11 80 	mov    %dx,-0x7feed800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106824:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106829:	66 89 88 02 28 11 80 	mov    %cx,-0x7feed7fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106830:	31 c9                	xor    %ecx,%ecx
80106832:	66 89 90 08 28 11 80 	mov    %dx,-0x7feed7f8(%eax)
80106839:	66 89 88 0a 28 11 80 	mov    %cx,-0x7feed7f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106840:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106845:	31 c9                	xor    %ecx,%ecx
80106847:	66 89 90 10 28 11 80 	mov    %dx,-0x7feed7f0(%eax)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010684e:	c6 80 fc 27 11 80 00 	movb   $0x0,-0x7feed804(%eax)
  pd[0] = size-1;
80106855:	ba 2f 00 00 00       	mov    $0x2f,%edx
8010685a:	c6 80 fd 27 11 80 9a 	movb   $0x9a,-0x7feed803(%eax)
80106861:	c6 80 fe 27 11 80 cf 	movb   $0xcf,-0x7feed802(%eax)
80106868:	c6 80 ff 27 11 80 00 	movb   $0x0,-0x7feed801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010686f:	c6 80 04 28 11 80 00 	movb   $0x0,-0x7feed7fc(%eax)
80106876:	c6 80 05 28 11 80 92 	movb   $0x92,-0x7feed7fb(%eax)
8010687d:	c6 80 06 28 11 80 cf 	movb   $0xcf,-0x7feed7fa(%eax)
80106884:	c6 80 07 28 11 80 00 	movb   $0x0,-0x7feed7f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010688b:	c6 80 0c 28 11 80 00 	movb   $0x0,-0x7feed7f4(%eax)
80106892:	c6 80 0d 28 11 80 fa 	movb   $0xfa,-0x7feed7f3(%eax)
80106899:	c6 80 0e 28 11 80 cf 	movb   $0xcf,-0x7feed7f2(%eax)
801068a0:	c6 80 0f 28 11 80 00 	movb   $0x0,-0x7feed7f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801068a7:	66 89 88 12 28 11 80 	mov    %cx,-0x7feed7ee(%eax)
801068ae:	c6 80 14 28 11 80 00 	movb   $0x0,-0x7feed7ec(%eax)
801068b5:	c6 80 15 28 11 80 f2 	movb   $0xf2,-0x7feed7eb(%eax)
801068bc:	c6 80 16 28 11 80 cf 	movb   $0xcf,-0x7feed7ea(%eax)
801068c3:	c6 80 17 28 11 80 00 	movb   $0x0,-0x7feed7e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
801068ca:	05 f0 27 11 80       	add    $0x801127f0,%eax
801068cf:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801068d3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801068d7:	c1 e8 10             	shr    $0x10,%eax
801068da:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801068de:	8d 45 f2             	lea    -0xe(%ebp),%eax
801068e1:	0f 01 10             	lgdtl  (%eax)
}
801068e4:	c9                   	leave  
801068e5:	c3                   	ret    
801068e6:	8d 76 00             	lea    0x0(%esi),%esi
801068e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068f0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801068f0:	a1 a4 54 11 80       	mov    0x801154a4,%eax
{
801068f5:	55                   	push   %ebp
801068f6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801068f8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801068fd:	0f 22 d8             	mov    %eax,%cr3
}
80106900:	5d                   	pop    %ebp
80106901:	c3                   	ret    
80106902:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106910 <switchuvm>:
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	57                   	push   %edi
80106914:	56                   	push   %esi
80106915:	53                   	push   %ebx
80106916:	83 ec 1c             	sub    $0x1c,%esp
80106919:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010691c:	85 f6                	test   %esi,%esi
8010691e:	0f 84 cd 00 00 00    	je     801069f1 <switchuvm+0xe1>
  if(p->kstack == 0)
80106924:	8b 46 08             	mov    0x8(%esi),%eax
80106927:	85 c0                	test   %eax,%eax
80106929:	0f 84 dc 00 00 00    	je     80106a0b <switchuvm+0xfb>
  if(p->pgdir == 0)
8010692f:	8b 7e 04             	mov    0x4(%esi),%edi
80106932:	85 ff                	test   %edi,%edi
80106934:	0f 84 c4 00 00 00    	je     801069fe <switchuvm+0xee>
  pushcli();
8010693a:	e8 11 da ff ff       	call   80104350 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010693f:	e8 9c ce ff ff       	call   801037e0 <mycpu>
80106944:	89 c3                	mov    %eax,%ebx
80106946:	e8 95 ce ff ff       	call   801037e0 <mycpu>
8010694b:	89 c7                	mov    %eax,%edi
8010694d:	e8 8e ce ff ff       	call   801037e0 <mycpu>
80106952:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106955:	83 c7 08             	add    $0x8,%edi
80106958:	e8 83 ce ff ff       	call   801037e0 <mycpu>
8010695d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106960:	83 c0 08             	add    $0x8,%eax
80106963:	ba 67 00 00 00       	mov    $0x67,%edx
80106968:	c1 e8 18             	shr    $0x18,%eax
8010696b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106972:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106979:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106980:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106987:	83 c1 08             	add    $0x8,%ecx
8010698a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106990:	c1 e9 10             	shr    $0x10,%ecx
80106993:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106999:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
8010699e:	e8 3d ce ff ff       	call   801037e0 <mycpu>
801069a3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801069aa:	e8 31 ce ff ff       	call   801037e0 <mycpu>
801069af:	b9 10 00 00 00       	mov    $0x10,%ecx
801069b4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801069b8:	e8 23 ce ff ff       	call   801037e0 <mycpu>
801069bd:	8b 56 08             	mov    0x8(%esi),%edx
801069c0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801069c6:	89 48 0c             	mov    %ecx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801069c9:	e8 12 ce ff ff       	call   801037e0 <mycpu>
801069ce:	66 89 58 6e          	mov    %bx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801069d2:	b8 28 00 00 00       	mov    $0x28,%eax
801069d7:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801069da:	8b 46 04             	mov    0x4(%esi),%eax
801069dd:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069e2:	0f 22 d8             	mov    %eax,%cr3
}
801069e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069e8:	5b                   	pop    %ebx
801069e9:	5e                   	pop    %esi
801069ea:	5f                   	pop    %edi
801069eb:	5d                   	pop    %ebp
  popcli();
801069ec:	e9 9f d9 ff ff       	jmp    80104390 <popcli>
    panic("switchuvm: no process");
801069f1:	83 ec 0c             	sub    $0xc,%esp
801069f4:	68 6e 78 10 80       	push   $0x8010786e
801069f9:	e8 72 99 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
801069fe:	83 ec 0c             	sub    $0xc,%esp
80106a01:	68 99 78 10 80       	push   $0x80107899
80106a06:	e8 65 99 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80106a0b:	83 ec 0c             	sub    $0xc,%esp
80106a0e:	68 84 78 10 80       	push   $0x80107884
80106a13:	e8 58 99 ff ff       	call   80100370 <panic>
80106a18:	90                   	nop
80106a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a20 <inituvm>:
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	57                   	push   %edi
80106a24:	56                   	push   %esi
80106a25:	53                   	push   %ebx
80106a26:	83 ec 1c             	sub    $0x1c,%esp
80106a29:	8b 75 10             	mov    0x10(%ebp),%esi
80106a2c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a2f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106a32:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106a38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106a3b:	77 49                	ja     80106a86 <inituvm+0x66>
  mem = kalloc();
80106a3d:	e8 3e bb ff ff       	call   80102580 <kalloc>
  memset(mem, 0, PGSIZE);
80106a42:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106a45:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106a47:	68 00 10 00 00       	push   $0x1000
80106a4c:	6a 00                	push   $0x0
80106a4e:	50                   	push   %eax
80106a4f:	e8 dc da ff ff       	call   80104530 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106a54:	58                   	pop    %eax
80106a55:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a5b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106a60:	5a                   	pop    %edx
80106a61:	6a 06                	push   $0x6
80106a63:	50                   	push   %eax
80106a64:	31 d2                	xor    %edx,%edx
80106a66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a69:	e8 52 fc ff ff       	call   801066c0 <mappages>
  memmove(mem, init, sz);
80106a6e:	89 75 10             	mov    %esi,0x10(%ebp)
80106a71:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106a74:	83 c4 10             	add    $0x10,%esp
80106a77:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106a7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a7d:	5b                   	pop    %ebx
80106a7e:	5e                   	pop    %esi
80106a7f:	5f                   	pop    %edi
80106a80:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106a81:	e9 5a db ff ff       	jmp    801045e0 <memmove>
    panic("inituvm: more than a page");
80106a86:	83 ec 0c             	sub    $0xc,%esp
80106a89:	68 ad 78 10 80       	push   $0x801078ad
80106a8e:	e8 dd 98 ff ff       	call   80100370 <panic>
80106a93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106aa0 <loaduvm>:
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	57                   	push   %edi
80106aa4:	56                   	push   %esi
80106aa5:	53                   	push   %ebx
80106aa6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106aa9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106ab0:	0f 85 91 00 00 00    	jne    80106b47 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106ab6:	8b 75 18             	mov    0x18(%ebp),%esi
80106ab9:	31 db                	xor    %ebx,%ebx
80106abb:	85 f6                	test   %esi,%esi
80106abd:	75 1a                	jne    80106ad9 <loaduvm+0x39>
80106abf:	eb 6f                	jmp    80106b30 <loaduvm+0x90>
80106ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ac8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ace:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106ad4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106ad7:	76 57                	jbe    80106b30 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ad9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106adc:	8b 45 08             	mov    0x8(%ebp),%eax
80106adf:	31 c9                	xor    %ecx,%ecx
80106ae1:	01 da                	add    %ebx,%edx
80106ae3:	e8 58 fb ff ff       	call   80106640 <walkpgdir>
80106ae8:	85 c0                	test   %eax,%eax
80106aea:	74 4e                	je     80106b3a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106aec:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106aee:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106af1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106af6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106afb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106b01:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b04:	01 d9                	add    %ebx,%ecx
80106b06:	05 00 00 00 80       	add    $0x80000000,%eax
80106b0b:	57                   	push   %edi
80106b0c:	51                   	push   %ecx
80106b0d:	50                   	push   %eax
80106b0e:	ff 75 10             	pushl  0x10(%ebp)
80106b11:	e8 2a af ff ff       	call   80101a40 <readi>
80106b16:	83 c4 10             	add    $0x10,%esp
80106b19:	39 c7                	cmp    %eax,%edi
80106b1b:	74 ab                	je     80106ac8 <loaduvm+0x28>
}
80106b1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106b20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b25:	5b                   	pop    %ebx
80106b26:	5e                   	pop    %esi
80106b27:	5f                   	pop    %edi
80106b28:	5d                   	pop    %ebp
80106b29:	c3                   	ret    
80106b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106b33:	31 c0                	xor    %eax,%eax
}
80106b35:	5b                   	pop    %ebx
80106b36:	5e                   	pop    %esi
80106b37:	5f                   	pop    %edi
80106b38:	5d                   	pop    %ebp
80106b39:	c3                   	ret    
      panic("loaduvm: address should exist");
80106b3a:	83 ec 0c             	sub    $0xc,%esp
80106b3d:	68 c7 78 10 80       	push   $0x801078c7
80106b42:	e8 29 98 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
80106b47:	83 ec 0c             	sub    $0xc,%esp
80106b4a:	68 68 79 10 80       	push   $0x80107968
80106b4f:	e8 1c 98 ff ff       	call   80100370 <panic>
80106b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106b60 <allocuvm>:
{
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	57                   	push   %edi
80106b64:	56                   	push   %esi
80106b65:	53                   	push   %ebx
80106b66:	83 ec 0c             	sub    $0xc,%esp
80106b69:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
80106b6c:	85 ff                	test   %edi,%edi
80106b6e:	78 7b                	js     80106beb <allocuvm+0x8b>
  if(newsz < oldsz)
80106b70:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106b73:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106b76:	72 75                	jb     80106bed <allocuvm+0x8d>
  a = PGROUNDUP(oldsz);
80106b78:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106b7e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106b84:	39 df                	cmp    %ebx,%edi
80106b86:	77 43                	ja     80106bcb <allocuvm+0x6b>
80106b88:	eb 6e                	jmp    80106bf8 <allocuvm+0x98>
80106b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106b90:	83 ec 04             	sub    $0x4,%esp
80106b93:	68 00 10 00 00       	push   $0x1000
80106b98:	6a 00                	push   $0x0
80106b9a:	50                   	push   %eax
80106b9b:	e8 90 d9 ff ff       	call   80104530 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106ba0:	58                   	pop    %eax
80106ba1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106ba7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106bac:	5a                   	pop    %edx
80106bad:	6a 06                	push   $0x6
80106baf:	50                   	push   %eax
80106bb0:	89 da                	mov    %ebx,%edx
80106bb2:	8b 45 08             	mov    0x8(%ebp),%eax
80106bb5:	e8 06 fb ff ff       	call   801066c0 <mappages>
80106bba:	83 c4 10             	add    $0x10,%esp
80106bbd:	85 c0                	test   %eax,%eax
80106bbf:	78 47                	js     80106c08 <allocuvm+0xa8>
  for(; a < newsz; a += PGSIZE){
80106bc1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bc7:	39 df                	cmp    %ebx,%edi
80106bc9:	76 2d                	jbe    80106bf8 <allocuvm+0x98>
    mem = kalloc();
80106bcb:	e8 b0 b9 ff ff       	call   80102580 <kalloc>
    if(mem == 0){
80106bd0:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106bd2:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106bd4:	75 ba                	jne    80106b90 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106bd6:	83 ec 0c             	sub    $0xc,%esp
80106bd9:	68 e5 78 10 80       	push   $0x801078e5
80106bde:	e8 5d 9b ff ff       	call   80100740 <cprintf>
  if(newsz >= oldsz)
80106be3:	83 c4 10             	add    $0x10,%esp
80106be6:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106be9:	77 4f                	ja     80106c3a <allocuvm+0xda>
      return 0;
80106beb:	31 c0                	xor    %eax,%eax
}
80106bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bf0:	5b                   	pop    %ebx
80106bf1:	5e                   	pop    %esi
80106bf2:	5f                   	pop    %edi
80106bf3:	5d                   	pop    %ebp
80106bf4:	c3                   	ret    
80106bf5:	8d 76 00             	lea    0x0(%esi),%esi
80106bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  for(; a < newsz; a += PGSIZE){
80106bfb:	89 f8                	mov    %edi,%eax
}
80106bfd:	5b                   	pop    %ebx
80106bfe:	5e                   	pop    %esi
80106bff:	5f                   	pop    %edi
80106c00:	5d                   	pop    %ebp
80106c01:	c3                   	ret    
80106c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106c08:	83 ec 0c             	sub    $0xc,%esp
80106c0b:	68 fd 78 10 80       	push   $0x801078fd
80106c10:	e8 2b 9b ff ff       	call   80100740 <cprintf>
  if(newsz >= oldsz)
80106c15:	83 c4 10             	add    $0x10,%esp
80106c18:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c1b:	76 0d                	jbe    80106c2a <allocuvm+0xca>
80106c1d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c20:	8b 45 08             	mov    0x8(%ebp),%eax
80106c23:	89 fa                	mov    %edi,%edx
80106c25:	e8 26 fb ff ff       	call   80106750 <deallocuvm.part.0>
      kfree(mem);
80106c2a:	83 ec 0c             	sub    $0xc,%esp
80106c2d:	56                   	push   %esi
80106c2e:	e8 9d b7 ff ff       	call   801023d0 <kfree>
      return 0;
80106c33:	83 c4 10             	add    $0x10,%esp
80106c36:	31 c0                	xor    %eax,%eax
80106c38:	eb b3                	jmp    80106bed <allocuvm+0x8d>
80106c3a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c3d:	8b 45 08             	mov    0x8(%ebp),%eax
80106c40:	89 fa                	mov    %edi,%edx
80106c42:	e8 09 fb ff ff       	call   80106750 <deallocuvm.part.0>
      return 0;
80106c47:	31 c0                	xor    %eax,%eax
80106c49:	eb a2                	jmp    80106bed <allocuvm+0x8d>
80106c4b:	90                   	nop
80106c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c50 <deallocuvm>:
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c56:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106c59:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106c5c:	39 d1                	cmp    %edx,%ecx
80106c5e:	73 10                	jae    80106c70 <deallocuvm+0x20>
}
80106c60:	5d                   	pop    %ebp
80106c61:	e9 ea fa ff ff       	jmp    80106750 <deallocuvm.part.0>
80106c66:	8d 76 00             	lea    0x0(%esi),%esi
80106c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106c70:	89 d0                	mov    %edx,%eax
80106c72:	5d                   	pop    %ebp
80106c73:	c3                   	ret    
80106c74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	56                   	push   %esi
80106c85:	53                   	push   %ebx
80106c86:	83 ec 0c             	sub    $0xc,%esp
80106c89:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106c8c:	85 f6                	test   %esi,%esi
80106c8e:	74 59                	je     80106ce9 <freevm+0x69>
80106c90:	31 c9                	xor    %ecx,%ecx
80106c92:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106c97:	89 f0                	mov    %esi,%eax
80106c99:	e8 b2 fa ff ff       	call   80106750 <deallocuvm.part.0>
80106c9e:	89 f3                	mov    %esi,%ebx
80106ca0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ca6:	eb 0f                	jmp    80106cb7 <freevm+0x37>
80106ca8:	90                   	nop
80106ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cb0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cb3:	39 fb                	cmp    %edi,%ebx
80106cb5:	74 23                	je     80106cda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106cb7:	8b 03                	mov    (%ebx),%eax
80106cb9:	a8 01                	test   $0x1,%al
80106cbb:	74 f3                	je     80106cb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106cbd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106cc2:	83 ec 0c             	sub    $0xc,%esp
80106cc5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106cc8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ccd:	50                   	push   %eax
80106cce:	e8 fd b6 ff ff       	call   801023d0 <kfree>
80106cd3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106cd6:	39 fb                	cmp    %edi,%ebx
80106cd8:	75 dd                	jne    80106cb7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106cda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106cdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ce0:	5b                   	pop    %ebx
80106ce1:	5e                   	pop    %esi
80106ce2:	5f                   	pop    %edi
80106ce3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106ce4:	e9 e7 b6 ff ff       	jmp    801023d0 <kfree>
    panic("freevm: no pgdir");
80106ce9:	83 ec 0c             	sub    $0xc,%esp
80106cec:	68 19 79 10 80       	push   $0x80107919
80106cf1:	e8 7a 96 ff ff       	call   80100370 <panic>
80106cf6:	8d 76 00             	lea    0x0(%esi),%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <setupkvm>:
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	56                   	push   %esi
80106d04:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106d05:	e8 76 b8 ff ff       	call   80102580 <kalloc>
80106d0a:	85 c0                	test   %eax,%eax
80106d0c:	89 c6                	mov    %eax,%esi
80106d0e:	74 42                	je     80106d52 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106d10:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106d13:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106d18:	68 00 10 00 00       	push   $0x1000
80106d1d:	6a 00                	push   $0x0
80106d1f:	50                   	push   %eax
80106d20:	e8 0b d8 ff ff       	call   80104530 <memset>
80106d25:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106d28:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106d2b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106d2e:	83 ec 08             	sub    $0x8,%esp
80106d31:	8b 13                	mov    (%ebx),%edx
80106d33:	ff 73 0c             	pushl  0xc(%ebx)
80106d36:	50                   	push   %eax
80106d37:	29 c1                	sub    %eax,%ecx
80106d39:	89 f0                	mov    %esi,%eax
80106d3b:	e8 80 f9 ff ff       	call   801066c0 <mappages>
80106d40:	83 c4 10             	add    $0x10,%esp
80106d43:	85 c0                	test   %eax,%eax
80106d45:	78 19                	js     80106d60 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106d47:	83 c3 10             	add    $0x10,%ebx
80106d4a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106d50:	72 d6                	jb     80106d28 <setupkvm+0x28>
}
80106d52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106d55:	89 f0                	mov    %esi,%eax
80106d57:	5b                   	pop    %ebx
80106d58:	5e                   	pop    %esi
80106d59:	5d                   	pop    %ebp
80106d5a:	c3                   	ret    
80106d5b:	90                   	nop
80106d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106d60:	83 ec 0c             	sub    $0xc,%esp
80106d63:	56                   	push   %esi
      return 0;
80106d64:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106d66:	e8 15 ff ff ff       	call   80106c80 <freevm>
      return 0;
80106d6b:	83 c4 10             	add    $0x10,%esp
}
80106d6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106d71:	89 f0                	mov    %esi,%eax
80106d73:	5b                   	pop    %ebx
80106d74:	5e                   	pop    %esi
80106d75:	5d                   	pop    %ebp
80106d76:	c3                   	ret    
80106d77:	89 f6                	mov    %esi,%esi
80106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d80 <kvmalloc>:
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106d86:	e8 75 ff ff ff       	call   80106d00 <setupkvm>
80106d8b:	a3 a4 54 11 80       	mov    %eax,0x801154a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d90:	05 00 00 00 80       	add    $0x80000000,%eax
80106d95:	0f 22 d8             	mov    %eax,%cr3
}
80106d98:	c9                   	leave  
80106d99:	c3                   	ret    
80106d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106da0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106da0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106da1:	31 c9                	xor    %ecx,%ecx
{
80106da3:	89 e5                	mov    %esp,%ebp
80106da5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106da8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106dab:	8b 45 08             	mov    0x8(%ebp),%eax
80106dae:	e8 8d f8 ff ff       	call   80106640 <walkpgdir>
  if(pte == 0)
80106db3:	85 c0                	test   %eax,%eax
80106db5:	74 05                	je     80106dbc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106db7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106dba:	c9                   	leave  
80106dbb:	c3                   	ret    
    panic("clearpteu");
80106dbc:	83 ec 0c             	sub    $0xc,%esp
80106dbf:	68 2a 79 10 80       	push   $0x8010792a
80106dc4:	e8 a7 95 ff ff       	call   80100370 <panic>
80106dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106dd0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	57                   	push   %edi
80106dd4:	56                   	push   %esi
80106dd5:	53                   	push   %ebx
80106dd6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106dd9:	e8 22 ff ff ff       	call   80106d00 <setupkvm>
80106dde:	85 c0                	test   %eax,%eax
80106de0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106de3:	0f 84 9f 00 00 00    	je     80106e88 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106de9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106dec:	85 c9                	test   %ecx,%ecx
80106dee:	0f 84 94 00 00 00    	je     80106e88 <copyuvm+0xb8>
80106df4:	31 ff                	xor    %edi,%edi
80106df6:	eb 4a                	jmp    80106e42 <copyuvm+0x72>
80106df8:	90                   	nop
80106df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106e00:	83 ec 04             	sub    $0x4,%esp
80106e03:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106e09:	68 00 10 00 00       	push   $0x1000
80106e0e:	53                   	push   %ebx
80106e0f:	50                   	push   %eax
80106e10:	e8 cb d7 ff ff       	call   801045e0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106e15:	58                   	pop    %eax
80106e16:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e1c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e21:	5a                   	pop    %edx
80106e22:	ff 75 e4             	pushl  -0x1c(%ebp)
80106e25:	50                   	push   %eax
80106e26:	89 fa                	mov    %edi,%edx
80106e28:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e2b:	e8 90 f8 ff ff       	call   801066c0 <mappages>
80106e30:	83 c4 10             	add    $0x10,%esp
80106e33:	85 c0                	test   %eax,%eax
80106e35:	78 61                	js     80106e98 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106e37:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106e3d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106e40:	76 46                	jbe    80106e88 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106e42:	8b 45 08             	mov    0x8(%ebp),%eax
80106e45:	31 c9                	xor    %ecx,%ecx
80106e47:	89 fa                	mov    %edi,%edx
80106e49:	e8 f2 f7 ff ff       	call   80106640 <walkpgdir>
80106e4e:	85 c0                	test   %eax,%eax
80106e50:	74 61                	je     80106eb3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106e52:	8b 00                	mov    (%eax),%eax
80106e54:	a8 01                	test   $0x1,%al
80106e56:	74 4e                	je     80106ea6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106e58:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106e5a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106e5f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106e65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106e68:	e8 13 b7 ff ff       	call   80102580 <kalloc>
80106e6d:	85 c0                	test   %eax,%eax
80106e6f:	89 c6                	mov    %eax,%esi
80106e71:	75 8d                	jne    80106e00 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106e73:	83 ec 0c             	sub    $0xc,%esp
80106e76:	ff 75 e0             	pushl  -0x20(%ebp)
80106e79:	e8 02 fe ff ff       	call   80106c80 <freevm>
  return 0;
80106e7e:	83 c4 10             	add    $0x10,%esp
80106e81:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106e88:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e8e:	5b                   	pop    %ebx
80106e8f:	5e                   	pop    %esi
80106e90:	5f                   	pop    %edi
80106e91:	5d                   	pop    %ebp
80106e92:	c3                   	ret    
80106e93:	90                   	nop
80106e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106e98:	83 ec 0c             	sub    $0xc,%esp
80106e9b:	56                   	push   %esi
80106e9c:	e8 2f b5 ff ff       	call   801023d0 <kfree>
      goto bad;
80106ea1:	83 c4 10             	add    $0x10,%esp
80106ea4:	eb cd                	jmp    80106e73 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106ea6:	83 ec 0c             	sub    $0xc,%esp
80106ea9:	68 4e 79 10 80       	push   $0x8010794e
80106eae:	e8 bd 94 ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80106eb3:	83 ec 0c             	sub    $0xc,%esp
80106eb6:	68 34 79 10 80       	push   $0x80107934
80106ebb:	e8 b0 94 ff ff       	call   80100370 <panic>

80106ec0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106ec0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106ec1:	31 c9                	xor    %ecx,%ecx
{
80106ec3:	89 e5                	mov    %esp,%ebp
80106ec5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106ec8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ecb:	8b 45 08             	mov    0x8(%ebp),%eax
80106ece:	e8 6d f7 ff ff       	call   80106640 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106ed3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106ed5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106ed6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106ed8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106edd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106ee0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ee5:	83 fa 05             	cmp    $0x5,%edx
80106ee8:	ba 00 00 00 00       	mov    $0x0,%edx
80106eed:	0f 45 c2             	cmovne %edx,%eax
}
80106ef0:	c3                   	ret    
80106ef1:	eb 0d                	jmp    80106f00 <copyout>
80106ef3:	90                   	nop
80106ef4:	90                   	nop
80106ef5:	90                   	nop
80106ef6:	90                   	nop
80106ef7:	90                   	nop
80106ef8:	90                   	nop
80106ef9:	90                   	nop
80106efa:	90                   	nop
80106efb:	90                   	nop
80106efc:	90                   	nop
80106efd:	90                   	nop
80106efe:	90                   	nop
80106eff:	90                   	nop

80106f00 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	57                   	push   %edi
80106f04:	56                   	push   %esi
80106f05:	53                   	push   %ebx
80106f06:	83 ec 1c             	sub    $0x1c,%esp
80106f09:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106f0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106f0f:	8b 7d 10             	mov    0x10(%ebp),%edi
80106f12:	85 db                	test   %ebx,%ebx
80106f14:	75 40                	jne    80106f56 <copyout+0x56>
80106f16:	eb 70                	jmp    80106f88 <copyout+0x88>
80106f18:	90                   	nop
80106f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106f20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106f23:	89 f1                	mov    %esi,%ecx
80106f25:	29 d1                	sub    %edx,%ecx
80106f27:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106f2d:	39 d9                	cmp    %ebx,%ecx
80106f2f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106f32:	29 f2                	sub    %esi,%edx
80106f34:	83 ec 04             	sub    $0x4,%esp
80106f37:	01 d0                	add    %edx,%eax
80106f39:	51                   	push   %ecx
80106f3a:	57                   	push   %edi
80106f3b:	50                   	push   %eax
80106f3c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106f3f:	e8 9c d6 ff ff       	call   801045e0 <memmove>
    len -= n;
    buf += n;
80106f44:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80106f47:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80106f4a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80106f50:	01 cf                	add    %ecx,%edi
  while(len > 0){
80106f52:	29 cb                	sub    %ecx,%ebx
80106f54:	74 32                	je     80106f88 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80106f56:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f58:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80106f5b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106f5e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f64:	56                   	push   %esi
80106f65:	ff 75 08             	pushl  0x8(%ebp)
80106f68:	e8 53 ff ff ff       	call   80106ec0 <uva2ka>
    if(pa0 == 0)
80106f6d:	83 c4 10             	add    $0x10,%esp
80106f70:	85 c0                	test   %eax,%eax
80106f72:	75 ac                	jne    80106f20 <copyout+0x20>
  }
  return 0;
}
80106f74:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f7c:	5b                   	pop    %ebx
80106f7d:	5e                   	pop    %esi
80106f7e:	5f                   	pop    %edi
80106f7f:	5d                   	pop    %ebp
80106f80:	c3                   	ret    
80106f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f8b:	31 c0                	xor    %eax,%eax
}
80106f8d:	5b                   	pop    %ebx
80106f8e:	5e                   	pop    %esi
80106f8f:	5f                   	pop    %edi
80106f90:	5d                   	pop    %ebp
80106f91:	c3                   	ret    
