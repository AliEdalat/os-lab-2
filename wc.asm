
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	83 f8 01             	cmp    $0x1,%eax
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 a6 03 00 00       	call   3e2 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  4a:	83 c6 01             	add    $0x1,%esi
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 6c 03 00 00       	call   3ca <close>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  66:	e8 37 03 00 00       	call   3a2 <exit>
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 89 08 00 00       	push   $0x889
  73:	6a 01                	push   $0x1
  75:	e8 76 04 00 00       	call   4f0 <printf>
  7a:	e8 23 03 00 00       	call   3a2 <exit>
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 7b 08 00 00       	push   $0x87b
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
  8d:	e8 10 03 00 00       	call   3a2 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	31 db                	xor    %ebx,%ebx
  a8:	83 ec 1c             	sub    $0x1c,%esp
  ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 a0 0b 00 00       	push   $0xba0
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 e5 02 00 00       	call   3ba <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 f8 00             	cmp    $0x0,%eax
  db:	89 c6                	mov    %eax,%esi
  dd:	7e 61                	jle    140 <wc+0xa0>
  df:	31 ff                	xor    %edi,%edi
  e1:	eb 13                	jmp    f6 <wc+0x56>
  e3:	90                   	nop
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  ef:	83 c7 01             	add    $0x1,%edi
  f2:	39 fe                	cmp    %edi,%esi
  f4:	74 42                	je     138 <wc+0x98>
  f6:	0f be 87 a0 0b 00 00 	movsbl 0xba0(%edi),%eax
  fd:	31 c9                	xor    %ecx,%ecx
  ff:	3c 0a                	cmp    $0xa,%al
 101:	0f 94 c1             	sete   %cl
 104:	83 ec 08             	sub    $0x8,%esp
 107:	50                   	push   %eax
 108:	68 66 08 00 00       	push   $0x866
 10d:	01 cb                	add    %ecx,%ebx
 10f:	e8 3c 01 00 00       	call   250 <strchr>
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	75 cd                	jne    e8 <wc+0x48>
 11b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 11e:	85 d2                	test   %edx,%edx
 120:	75 cd                	jne    ef <wc+0x4f>
 122:	83 c7 01             	add    $0x1,%edi
 125:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
 129:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
 130:	39 fe                	cmp    %edi,%esi
 132:	75 c2                	jne    f6 <wc+0x56>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	01 75 e0             	add    %esi,-0x20(%ebp)
 13b:	eb 83                	jmp    c0 <wc+0x20>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	75 24                	jne    166 <wc+0xc6>
 142:	83 ec 08             	sub    $0x8,%esp
 145:	ff 75 0c             	pushl  0xc(%ebp)
 148:	ff 75 e0             	pushl  -0x20(%ebp)
 14b:	ff 75 dc             	pushl  -0x24(%ebp)
 14e:	53                   	push   %ebx
 14f:	68 7c 08 00 00       	push   $0x87c
 154:	6a 01                	push   $0x1
 156:	e8 95 03 00 00       	call   4f0 <printf>
 15b:	83 c4 20             	add    $0x20,%esp
 15e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 161:	5b                   	pop    %ebx
 162:	5e                   	pop    %esi
 163:	5f                   	pop    %edi
 164:	5d                   	pop    %ebp
 165:	c3                   	ret    
 166:	50                   	push   %eax
 167:	50                   	push   %eax
 168:	68 6c 08 00 00       	push   $0x86c
 16d:	6a 01                	push   $0x1
 16f:	e8 7c 03 00 00       	call   4f0 <printf>
 174:	e8 29 02 00 00       	call   3a2 <exit>
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 189:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	53                   	push   %ebx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	74 2d                	je     1ee <strcmp+0x3e>
 1c1:	0f b6 19             	movzbl (%ecx),%ebx
 1c4:	38 d8                	cmp    %bl,%al
 1c6:	74 0e                	je     1d6 <strcmp+0x26>
 1c8:	eb 2b                	jmp    1f5 <strcmp+0x45>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	38 c8                	cmp    %cl,%al
 1d2:	75 15                	jne    1e9 <strcmp+0x39>
    p++, q++;
 1d4:	89 d9                	mov    %ebx,%ecx
 1d6:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1dc:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1df:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1e3:	84 c0                	test   %al,%al
 1e5:	75 e9                	jne    1d0 <strcmp+0x20>
 1e7:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1e9:	29 c8                	sub    %ecx,%eax
}
 1eb:	5b                   	pop    %ebx
 1ec:	5d                   	pop    %ebp
 1ed:	c3                   	ret    
 1ee:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f1:	31 c0                	xor    %eax,%eax
 1f3:	eb f4                	jmp    1e9 <strcmp+0x39>
 1f5:	0f b6 cb             	movzbl %bl,%ecx
 1f8:	eb ef                	jmp    1e9 <strcmp+0x39>
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 12                	je     21d <strlen+0x1d>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 21d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <memset>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 55 08             	mov    0x8(%ebp),%edx
 236:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	53                   	push   %ebx
 257:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 25a:	0f b6 18             	movzbl (%eax),%ebx
 25d:	84 db                	test   %bl,%bl
 25f:	74 1d                	je     27e <strchr+0x2e>
    if(*s == c)
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d1                	mov    %edx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 295:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 297:	53                   	push   %ebx
 298:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 29b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 29e:	eb 31                	jmp    2d1 <gets+0x41>
    cc = read(0, &c, 1);
 2a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2a7:	00 
 2a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2b3:	e8 02 01 00 00       	call   3ba <read>
    if(cc < 1)
 2b8:	85 c0                	test   %eax,%eax
 2ba:	7e 1d                	jle    2d9 <gets+0x49>
      break;
    buf[i++] = c;
 2bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c0:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2c2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2c5:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2c7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2cb:	74 0c                	je     2d9 <gets+0x49>
 2cd:	3c 0a                	cmp    $0xa,%al
 2cf:	74 08                	je     2d9 <gets+0x49>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d7:	7c c7                	jl     2a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2d9:	8b 45 08             	mov    0x8(%ebp),%eax
 2dc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2e0:	83 c4 2c             	add    $0x2c,%esp
 2e3:	5b                   	pop    %ebx
 2e4:	5e                   	pop    %esi
 2e5:	5f                   	pop    %edi
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	90                   	nop
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
 2f5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f8:	8b 45 08             	mov    0x8(%ebp),%eax
 2fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 302:	00 
 303:	89 04 24             	mov    %eax,(%esp)
 306:	e8 d7 00 00 00       	call   3e2 <open>
  if(fd < 0)
 30b:	85 c0                	test   %eax,%eax
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 30d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 30f:	78 27                	js     338 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 311:	8b 45 0c             	mov    0xc(%ebp),%eax
 314:	89 1c 24             	mov    %ebx,(%esp)
 317:	89 44 24 04          	mov    %eax,0x4(%esp)
 31b:	e8 da 00 00 00       	call   3fa <fstat>
  close(fd);
 320:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 323:	89 c6                	mov    %eax,%esi
  close(fd);
 325:	e8 a0 00 00 00       	call   3ca <close>
  return r;
 32a:	89 f0                	mov    %esi,%eax
}
 32c:	83 c4 10             	add    $0x10,%esp
 32f:	5b                   	pop    %ebx
 330:	5e                   	pop    %esi
 331:	5d                   	pop    %ebp
 332:	c3                   	ret    
 333:	90                   	nop
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 338:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 33d:	eb ed                	jmp    32c <stat+0x3c>
 33f:	90                   	nop

00000340 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 4d 08             	mov    0x8(%ebp),%ecx
 346:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 11             	movsbl (%ecx),%edx
 34a:	8d 42 d0             	lea    -0x30(%edx),%eax
 34d:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 34f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 354:	77 17                	ja     36d <atoi+0x2d>
 356:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 358:	83 c1 01             	add    $0x1,%ecx
 35b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 35e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 362:	0f be 11             	movsbl (%ecx),%edx
 365:	8d 5a d0             	lea    -0x30(%edx),%ebx
 368:	80 fb 09             	cmp    $0x9,%bl
 36b:	76 eb                	jbe    358 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 36d:	5b                   	pop    %ebx
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    

00000370 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 370:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 371:	31 d2                	xor    %edx,%edx
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
{
 373:	89 e5                	mov    %esp,%ebp
 375:	56                   	push   %esi
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	53                   	push   %ebx
 37a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 37d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 380:	85 db                	test   %ebx,%ebx
 382:	7e 12                	jle    396 <memmove+0x26>
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 388:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 38c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 38f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 392:	39 da                	cmp    %ebx,%edx
 394:	75 f2                	jne    388 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 396:	5b                   	pop    %ebx
 397:	5e                   	pop    %esi
 398:	5d                   	pop    %ebp
 399:	c3                   	ret    

0000039a <fork>:
 39a:	b8 01 00 00 00       	mov    $0x1,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <exit>:
 3a2:	b8 02 00 00 00       	mov    $0x2,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <wait>:
 3aa:	b8 03 00 00 00       	mov    $0x3,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <pipe>:
 3b2:	b8 04 00 00 00       	mov    $0x4,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <read>:
 3ba:	b8 05 00 00 00       	mov    $0x5,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <write>:
 3c2:	b8 10 00 00 00       	mov    $0x10,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <close>:
 3ca:	b8 15 00 00 00       	mov    $0x15,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <kill>:
 3d2:	b8 06 00 00 00       	mov    $0x6,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <exec>:
 3da:	b8 07 00 00 00       	mov    $0x7,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <open>:
 3e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <mknod>:
 3ea:	b8 11 00 00 00       	mov    $0x11,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <unlink>:
 3f2:	b8 12 00 00 00       	mov    $0x12,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <fstat>:
 3fa:	b8 08 00 00 00       	mov    $0x8,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <link>:
 402:	b8 13 00 00 00       	mov    $0x13,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <mkdir>:
 40a:	b8 14 00 00 00       	mov    $0x14,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <chdir>:
 412:	b8 09 00 00 00       	mov    $0x9,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <dup>:
 41a:	b8 0a 00 00 00       	mov    $0xa,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <getpid>:
 422:	b8 0b 00 00 00       	mov    $0xb,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <sbrk>:
 42a:	b8 0c 00 00 00       	mov    $0xc,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <sleep>:
 432:	b8 0d 00 00 00       	mov    $0xd,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <uptime>:
 43a:	b8 0e 00 00 00       	mov    $0xe,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    
 442:	66 90                	xchg   %ax,%ax
 444:	66 90                	xchg   %ax,%ax
 446:	66 90                	xchg   %ax,%ax
 448:	66 90                	xchg   %ax,%ax
 44a:	66 90                	xchg   %ax,%ax
 44c:	66 90                	xchg   %ax,%ax
 44e:	66 90                	xchg   %ax,%ax

00000450 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	89 c6                	mov    %eax,%esi
 457:	53                   	push   %ebx
 458:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 45b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 45e:	85 db                	test   %ebx,%ebx
 460:	74 09                	je     46b <printint+0x1b>
 462:	89 d0                	mov    %edx,%eax
 464:	c1 e8 1f             	shr    $0x1f,%eax
 467:	84 c0                	test   %al,%al
 469:	75 75                	jne    4e0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 46b:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 46d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 474:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 477:	31 ff                	xor    %edi,%edi
 479:	89 ce                	mov    %ecx,%esi
 47b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 47e:	eb 02                	jmp    482 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 480:	89 cf                	mov    %ecx,%edi
 482:	31 d2                	xor    %edx,%edx
 484:	f7 f6                	div    %esi
 486:	8d 4f 01             	lea    0x1(%edi),%ecx
 489:	0f b6 92 a4 08 00 00 	movzbl 0x8a4(%edx),%edx
  }while((x /= base) != 0);
 490:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 492:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 495:	75 e9                	jne    480 <printint+0x30>
  if(neg)
 497:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 49a:	89 c8                	mov    %ecx,%eax
 49c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  }while((x /= base) != 0);
  if(neg)
 49f:	85 d2                	test   %edx,%edx
 4a1:	74 08                	je     4ab <printint+0x5b>
    buf[i++] = '-';
 4a3:	8d 4f 02             	lea    0x2(%edi),%ecx
 4a6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 4ab:	8d 79 ff             	lea    -0x1(%ecx),%edi
 4ae:	66 90                	xchg   %ax,%ax
 4b0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 4b5:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4bf:	00 
 4c0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4c4:	89 34 24             	mov    %esi,(%esp)
 4c7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ca:	e8 f3 fe ff ff       	call   3c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4cf:	83 ff ff             	cmp    $0xffffffff,%edi
 4d2:	75 dc                	jne    4b0 <printint+0x60>
    putc(fd, buf[i]);
}
 4d4:	83 c4 4c             	add    $0x4c,%esp
 4d7:	5b                   	pop    %ebx
 4d8:	5e                   	pop    %esi
 4d9:	5f                   	pop    %edi
 4da:	5d                   	pop    %ebp
 4db:	c3                   	ret    
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4e0:	89 d0                	mov    %edx,%eax
 4e2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4e4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4eb:	eb 87                	jmp    474 <printint+0x24>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi

000004f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4f4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f6:	56                   	push   %esi
 4f7:	53                   	push   %ebx
 4f8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4fe:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 501:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 504:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 507:	0f b6 13             	movzbl (%ebx),%edx
 50a:	83 c3 01             	add    $0x1,%ebx
 50d:	84 d2                	test   %dl,%dl
 50f:	75 39                	jne    54a <printf+0x5a>
 511:	e9 c2 00 00 00       	jmp    5d8 <printf+0xe8>
 516:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 518:	83 fa 25             	cmp    $0x25,%edx
 51b:	0f 84 bf 00 00 00    	je     5e0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 521:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 524:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 52b:	00 
 52c:	89 44 24 04          	mov    %eax,0x4(%esp)
 530:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 533:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 536:	e8 87 fe ff ff       	call   3c2 <write>
 53b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 53e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 542:	84 d2                	test   %dl,%dl
 544:	0f 84 8e 00 00 00    	je     5d8 <printf+0xe8>
    c = fmt[i] & 0xff;
    if(state == 0){
 54a:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 54c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 54f:	74 c7                	je     518 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 551:	83 ff 25             	cmp    $0x25,%edi
 554:	75 e5                	jne    53b <printf+0x4b>
      if(c == 'd'){
 556:	83 fa 64             	cmp    $0x64,%edx
 559:	0f 84 31 01 00 00    	je     690 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 55f:	25 f7 00 00 00       	and    $0xf7,%eax
 564:	83 f8 70             	cmp    $0x70,%eax
 567:	0f 84 83 00 00 00    	je     5f0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 56d:	83 fa 73             	cmp    $0x73,%edx
 570:	0f 84 a2 00 00 00    	je     618 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 576:	83 fa 63             	cmp    $0x63,%edx
 579:	0f 84 35 01 00 00    	je     6b4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 57f:	83 fa 25             	cmp    $0x25,%edx
 582:	0f 84 e0 00 00 00    	je     668 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 588:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 58b:	83 c3 01             	add    $0x1,%ebx
 58e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 595:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 596:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 598:	89 44 24 04          	mov    %eax,0x4(%esp)
 59c:	89 34 24             	mov    %esi,(%esp)
 59f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5a2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 5a6:	e8 17 fe ff ff       	call   3c2 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5ab:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b8:	00 
 5b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bd:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5c0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c3:	e8 fa fd ff ff       	call   3c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5cc:	84 d2                	test   %dl,%dl
 5ce:	0f 85 76 ff ff ff    	jne    54a <printf+0x5a>
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d8:	83 c4 3c             	add    $0x3c,%esp
 5db:	5b                   	pop    %ebx
 5dc:	5e                   	pop    %esi
 5dd:	5f                   	pop    %edi
 5de:	5d                   	pop    %ebp
 5df:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5e0:	bf 25 00 00 00       	mov    $0x25,%edi
 5e5:	e9 51 ff ff ff       	jmp    53b <printf+0x4b>
 5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5f3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5f8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 601:	8b 10                	mov    (%eax),%edx
 603:	89 f0                	mov    %esi,%eax
 605:	e8 46 fe ff ff       	call   450 <printint>
        ap++;
 60a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 60e:	e9 28 ff ff ff       	jmp    53b <printf+0x4b>
 613:	90                   	nop
 614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 618:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 61b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 61f:	8b 38                	mov    (%eax),%edi
        ap++;
        if(s == 0)
          s = "(null)";
 621:	b8 9d 08 00 00       	mov    $0x89d,%eax
 626:	85 ff                	test   %edi,%edi
 628:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 62b:	0f b6 07             	movzbl (%edi),%eax
 62e:	84 c0                	test   %al,%al
 630:	74 2a                	je     65c <printf+0x16c>
 632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 638:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 63e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 641:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 648:	00 
 649:	89 44 24 04          	mov    %eax,0x4(%esp)
 64d:	89 34 24             	mov    %esi,(%esp)
 650:	e8 6d fd ff ff       	call   3c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 655:	0f b6 07             	movzbl (%edi),%eax
 658:	84 c0                	test   %al,%al
 65a:	75 dc                	jne    638 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 65c:	31 ff                	xor    %edi,%edi
 65e:	e9 d8 fe ff ff       	jmp    53b <printf+0x4b>
 663:	90                   	nop
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 668:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 66d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 674:	00 
 675:	89 44 24 04          	mov    %eax,0x4(%esp)
 679:	89 34 24             	mov    %esi,(%esp)
 67c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 680:	e8 3d fd ff ff       	call   3c2 <write>
 685:	e9 b1 fe ff ff       	jmp    53b <printf+0x4b>
 68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 690:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 693:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 698:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 69b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6a2:	8b 10                	mov    (%eax),%edx
 6a4:	89 f0                	mov    %esi,%eax
 6a6:	e8 a5 fd ff ff       	call   450 <printint>
        ap++;
 6ab:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6af:	e9 87 fe ff ff       	jmp    53b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6b4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6b7:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6b9:	8b 00                	mov    (%eax),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6bb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6c2:	00 
 6c3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6c6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d0:	e8 ed fc ff ff       	call   3c2 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6d5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6d9:	e9 5d fe ff ff       	jmp    53b <printf+0x4b>
 6de:	66 90                	xchg   %ax,%ax

000006e0 <free>:
 6e0:	55                   	push   %ebp
 6e1:	a1 80 0b 00 00       	mov    0xb80,%eax
 6e6:	89 e5                	mov    %esp,%ebp
 6e8:	57                   	push   %edi
 6e9:	56                   	push   %esi
 6ea:	53                   	push   %ebx
 6eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f8:	39 c8                	cmp    %ecx,%eax
 6fa:	8b 10                	mov    (%eax),%edx
 6fc:	73 32                	jae    730 <free+0x50>
 6fe:	39 d1                	cmp    %edx,%ecx
 700:	72 04                	jb     706 <free+0x26>
 702:	39 d0                	cmp    %edx,%eax
 704:	72 32                	jb     738 <free+0x58>
 706:	8b 73 fc             	mov    -0x4(%ebx),%esi
 709:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 70c:	39 fa                	cmp    %edi,%edx
 70e:	74 30                	je     740 <free+0x60>
 710:	89 53 f8             	mov    %edx,-0x8(%ebx)
 713:	8b 50 04             	mov    0x4(%eax),%edx
 716:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 719:	39 f1                	cmp    %esi,%ecx
 71b:	74 3a                	je     757 <free+0x77>
 71d:	89 08                	mov    %ecx,(%eax)
 71f:	a3 80 0b 00 00       	mov    %eax,0xb80
 724:	5b                   	pop    %ebx
 725:	5e                   	pop    %esi
 726:	5f                   	pop    %edi
 727:	5d                   	pop    %ebp
 728:	c3                   	ret    
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 730:	39 d0                	cmp    %edx,%eax
 732:	72 04                	jb     738 <free+0x58>
 734:	39 d1                	cmp    %edx,%ecx
 736:	72 ce                	jb     706 <free+0x26>
 738:	89 d0                	mov    %edx,%eax
 73a:	eb bc                	jmp    6f8 <free+0x18>
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 740:	03 72 04             	add    0x4(%edx),%esi
 743:	89 73 fc             	mov    %esi,-0x4(%ebx)
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 12                	mov    (%edx),%edx
 74a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 74d:	8b 50 04             	mov    0x4(%eax),%edx
 750:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 753:	39 f1                	cmp    %esi,%ecx
 755:	75 c6                	jne    71d <free+0x3d>
 757:	03 53 fc             	add    -0x4(%ebx),%edx
 75a:	a3 80 0b 00 00       	mov    %eax,0xb80
 75f:	89 50 04             	mov    %edx,0x4(%eax)
 762:	8b 53 f8             	mov    -0x8(%ebx),%edx
 765:	89 10                	mov    %edx,(%eax)
 767:	5b                   	pop    %ebx
 768:	5e                   	pop    %esi
 769:	5f                   	pop    %edi
 76a:	5d                   	pop    %ebp
 76b:	c3                   	ret    
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000770 <malloc>:
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 0c             	sub    $0xc,%esp
 779:	8b 45 08             	mov    0x8(%ebp),%eax
 77c:	8b 15 80 0b 00 00    	mov    0xb80,%edx
 782:	8d 78 07             	lea    0x7(%eax),%edi
 785:	c1 ef 03             	shr    $0x3,%edi
 788:	83 c7 01             	add    $0x1,%edi
 78b:	85 d2                	test   %edx,%edx
 78d:	0f 84 9d 00 00 00    	je     830 <malloc+0xc0>
 793:	8b 02                	mov    (%edx),%eax
 795:	8b 48 04             	mov    0x4(%eax),%ecx
 798:	39 cf                	cmp    %ecx,%edi
 79a:	76 6c                	jbe    808 <malloc+0x98>
 79c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7a2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7a7:	0f 43 df             	cmovae %edi,%ebx
 7aa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7b1:	eb 0e                	jmp    7c1 <malloc+0x51>
 7b3:	90                   	nop
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7b8:	8b 02                	mov    (%edx),%eax
 7ba:	8b 48 04             	mov    0x4(%eax),%ecx
 7bd:	39 f9                	cmp    %edi,%ecx
 7bf:	73 47                	jae    808 <malloc+0x98>
 7c1:	39 05 80 0b 00 00    	cmp    %eax,0xb80
 7c7:	89 c2                	mov    %eax,%edx
 7c9:	75 ed                	jne    7b8 <malloc+0x48>
 7cb:	83 ec 0c             	sub    $0xc,%esp
 7ce:	56                   	push   %esi
 7cf:	e8 56 fc ff ff       	call   42a <sbrk>
 7d4:	83 c4 10             	add    $0x10,%esp
 7d7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7da:	74 1c                	je     7f8 <malloc+0x88>
 7dc:	89 58 04             	mov    %ebx,0x4(%eax)
 7df:	83 ec 0c             	sub    $0xc,%esp
 7e2:	83 c0 08             	add    $0x8,%eax
 7e5:	50                   	push   %eax
 7e6:	e8 f5 fe ff ff       	call   6e0 <free>
 7eb:	8b 15 80 0b 00 00    	mov    0xb80,%edx
 7f1:	83 c4 10             	add    $0x10,%esp
 7f4:	85 d2                	test   %edx,%edx
 7f6:	75 c0                	jne    7b8 <malloc+0x48>
 7f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7fb:	31 c0                	xor    %eax,%eax
 7fd:	5b                   	pop    %ebx
 7fe:	5e                   	pop    %esi
 7ff:	5f                   	pop    %edi
 800:	5d                   	pop    %ebp
 801:	c3                   	ret    
 802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 808:	39 cf                	cmp    %ecx,%edi
 80a:	74 54                	je     860 <malloc+0xf0>
 80c:	29 f9                	sub    %edi,%ecx
 80e:	89 48 04             	mov    %ecx,0x4(%eax)
 811:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 814:	89 78 04             	mov    %edi,0x4(%eax)
 817:	89 15 80 0b 00 00    	mov    %edx,0xb80
 81d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 820:	83 c0 08             	add    $0x8,%eax
 823:	5b                   	pop    %ebx
 824:	5e                   	pop    %esi
 825:	5f                   	pop    %edi
 826:	5d                   	pop    %ebp
 827:	c3                   	ret    
 828:	90                   	nop
 829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 830:	c7 05 80 0b 00 00 84 	movl   $0xb84,0xb80
 837:	0b 00 00 
 83a:	c7 05 84 0b 00 00 84 	movl   $0xb84,0xb84
 841:	0b 00 00 
 844:	b8 84 0b 00 00       	mov    $0xb84,%eax
 849:	c7 05 88 0b 00 00 00 	movl   $0x0,0xb88
 850:	00 00 00 
 853:	e9 44 ff ff ff       	jmp    79c <malloc+0x2c>
 858:	90                   	nop
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 860:	8b 08                	mov    (%eax),%ecx
 862:	89 0a                	mov    %ecx,(%edx)
 864:	eb b1                	jmp    817 <malloc+0xa7>
