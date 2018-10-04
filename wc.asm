
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
  37:	e8 96 03 00 00       	call   3d2 <open>
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
  59:	e8 5c 03 00 00       	call   3ba <close>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  66:	e8 27 03 00 00       	call   392 <exit>
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 61 08 00 00       	push   $0x861
  73:	6a 01                	push   $0x1
  75:	e8 66 04 00 00       	call   4e0 <printf>
  7a:	e8 13 03 00 00       	call   392 <exit>
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 53 08 00 00       	push   $0x853
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
  8d:	e8 00 03 00 00       	call   392 <exit>
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
  a6:	31 f6                	xor    %esi,%esi
  a8:	31 db                	xor    %ebx,%ebx
  aa:	83 ec 1c             	sub    $0x1c,%esp
  ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 60 0b 00 00       	push   $0xb60
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 d5 02 00 00       	call   3aa <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 f8 00             	cmp    $0x0,%eax
  db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  de:	7e 54                	jle    134 <wc+0x94>
  e0:	31 ff                	xor    %edi,%edi
  e2:	eb 0e                	jmp    f2 <wc+0x52>
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e8:	31 f6                	xor    %esi,%esi
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 3a                	je     12c <wc+0x8c>
  f2:	0f be 87 60 0b 00 00 	movsbl 0xb60(%edi),%eax
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
 104:	68 3e 08 00 00       	push   $0x83e
 109:	01 cb                	add    %ecx,%ebx
 10b:	e8 30 01 00 00       	call   240 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
 117:	85 f6                	test   %esi,%esi
 119:	75 cf                	jne    ea <wc+0x4a>
 11b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
 11f:	83 c7 01             	add    $0x1,%edi
 122:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 125:	be 01 00 00 00       	mov    $0x1,%esi
 12a:	75 c6                	jne    f2 <wc+0x52>
 12c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 12f:	01 55 dc             	add    %edx,-0x24(%ebp)
 132:	eb 8c                	jmp    c0 <wc+0x20>
 134:	75 24                	jne    15a <wc+0xba>
 136:	83 ec 08             	sub    $0x8,%esp
 139:	ff 75 0c             	pushl  0xc(%ebp)
 13c:	ff 75 dc             	pushl  -0x24(%ebp)
 13f:	ff 75 e0             	pushl  -0x20(%ebp)
 142:	53                   	push   %ebx
 143:	68 54 08 00 00       	push   $0x854
 148:	6a 01                	push   $0x1
 14a:	e8 91 03 00 00       	call   4e0 <printf>
 14f:	83 c4 20             	add    $0x20,%esp
 152:	8d 65 f4             	lea    -0xc(%ebp),%esp
 155:	5b                   	pop    %ebx
 156:	5e                   	pop    %esi
 157:	5f                   	pop    %edi
 158:	5d                   	pop    %ebp
 159:	c3                   	ret    
 15a:	83 ec 08             	sub    $0x8,%esp
 15d:	68 44 08 00 00       	push   $0x844
 162:	6a 01                	push   $0x1
 164:	e8 77 03 00 00       	call   4e0 <printf>
 169:	e8 24 02 00 00       	call   392 <exit>
 16e:	66 90                	xchg   %ax,%ax

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 179:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17a:	89 c2                	mov    %eax,%edx
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	83 c1 01             	add    $0x1,%ecx
 183:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 187:	83 c2 01             	add    $0x1,%edx
 18a:	84 db                	test   %bl,%bl
 18c:	88 5a ff             	mov    %bl,-0x1(%edx)
 18f:	75 ef                	jne    180 <strcpy+0x10>
    ;
  return os;
}
 191:	5b                   	pop    %ebx
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 19a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
 1a6:	53                   	push   %ebx
 1a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1aa:	0f b6 02             	movzbl (%edx),%eax
 1ad:	84 c0                	test   %al,%al
 1af:	74 2d                	je     1de <strcmp+0x3e>
 1b1:	0f b6 19             	movzbl (%ecx),%ebx
 1b4:	38 d8                	cmp    %bl,%al
 1b6:	74 0e                	je     1c6 <strcmp+0x26>
 1b8:	eb 2b                	jmp    1e5 <strcmp+0x45>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c0:	38 c8                	cmp    %cl,%al
 1c2:	75 15                	jne    1d9 <strcmp+0x39>
    p++, q++;
 1c4:	89 d9                	mov    %ebx,%ecx
 1c6:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1c9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1cc:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1cf:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1d3:	84 c0                	test   %al,%al
 1d5:	75 e9                	jne    1c0 <strcmp+0x20>
 1d7:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1d9:	29 c8                	sub    %ecx,%eax
}
 1db:	5b                   	pop    %ebx
 1dc:	5d                   	pop    %ebp
 1dd:	c3                   	ret    
 1de:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e1:	31 c0                	xor    %eax,%eax
 1e3:	eb f4                	jmp    1d9 <strcmp+0x39>
 1e5:	0f b6 cb             	movzbl %bl,%ecx
 1e8:	eb ef                	jmp    1d9 <strcmp+0x39>
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1f6:	80 39 00             	cmpb   $0x0,(%ecx)
 1f9:	74 12                	je     20d <strlen+0x1d>
 1fb:	31 d2                	xor    %edx,%edx
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	83 c2 01             	add    $0x1,%edx
 203:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 207:	89 d0                	mov    %edx,%eax
 209:	75 f5                	jne    200 <strlen+0x10>
    ;
  return n;
}
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 20d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret    
 211:	eb 0d                	jmp    220 <memset>
 213:	90                   	nop
 214:	90                   	nop
 215:	90                   	nop
 216:	90                   	nop
 217:	90                   	nop
 218:	90                   	nop
 219:	90                   	nop
 21a:	90                   	nop
 21b:	90                   	nop
 21c:	90                   	nop
 21d:	90                   	nop
 21e:	90                   	nop
 21f:	90                   	nop

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
 226:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 227:	8b 4d 10             	mov    0x10(%ebp),%ecx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 d7                	mov    %edx,%edi
 22f:	fc                   	cld    
 230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 232:	89 d0                	mov    %edx,%eax
 234:	5f                   	pop    %edi
 235:	5d                   	pop    %ebp
 236:	c3                   	ret    
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	53                   	push   %ebx
 247:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 24a:	0f b6 18             	movzbl (%eax),%ebx
 24d:	84 db                	test   %bl,%bl
 24f:	74 1d                	je     26e <strchr+0x2e>
    if(*s == c)
 251:	38 d3                	cmp    %dl,%bl
 253:	89 d1                	mov    %edx,%ecx
 255:	75 0d                	jne    264 <strchr+0x24>
 257:	eb 17                	jmp    270 <strchr+0x30>
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 260:	38 ca                	cmp    %cl,%dl
 262:	74 0c                	je     270 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 264:	83 c0 01             	add    $0x1,%eax
 267:	0f b6 10             	movzbl (%eax),%edx
 26a:	84 d2                	test   %dl,%dl
 26c:	75 f2                	jne    260 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 26e:	31 c0                	xor    %eax,%eax
}
 270:	5b                   	pop    %ebx
 271:	5d                   	pop    %ebp
 272:	c3                   	ret    
 273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 285:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 287:	53                   	push   %ebx
 288:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 28b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28e:	eb 31                	jmp    2c1 <gets+0x41>
    cc = read(0, &c, 1);
 290:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 297:	00 
 298:	89 7c 24 04          	mov    %edi,0x4(%esp)
 29c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2a3:	e8 02 01 00 00       	call   3aa <read>
    if(cc < 1)
 2a8:	85 c0                	test   %eax,%eax
 2aa:	7e 1d                	jle    2c9 <gets+0x49>
      break;
    buf[i++] = c;
 2ac:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b0:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2b2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2b5:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2b7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2bb:	74 0c                	je     2c9 <gets+0x49>
 2bd:	3c 0a                	cmp    $0xa,%al
 2bf:	74 08                	je     2c9 <gets+0x49>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2c7:	7c c7                	jl     290 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2c9:	8b 45 08             	mov    0x8(%ebp),%eax
 2cc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2d0:	83 c4 2c             	add    $0x2c,%esp
 2d3:	5b                   	pop    %ebx
 2d4:	5e                   	pop    %esi
 2d5:	5f                   	pop    %edi
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    
 2d8:	90                   	nop
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	56                   	push   %esi
 2e4:	53                   	push   %ebx
 2e5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e8:	8b 45 08             	mov    0x8(%ebp),%eax
 2eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2f2:	00 
 2f3:	89 04 24             	mov    %eax,(%esp)
 2f6:	e8 d7 00 00 00       	call   3d2 <open>
  if(fd < 0)
 2fb:	85 c0                	test   %eax,%eax
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2fd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2ff:	78 27                	js     328 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 301:	8b 45 0c             	mov    0xc(%ebp),%eax
 304:	89 1c 24             	mov    %ebx,(%esp)
 307:	89 44 24 04          	mov    %eax,0x4(%esp)
 30b:	e8 da 00 00 00       	call   3ea <fstat>
  close(fd);
 310:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 313:	89 c6                	mov    %eax,%esi
  close(fd);
 315:	e8 a0 00 00 00       	call   3ba <close>
  return r;
 31a:	89 f0                	mov    %esi,%eax
}
 31c:	83 c4 10             	add    $0x10,%esp
 31f:	5b                   	pop    %ebx
 320:	5e                   	pop    %esi
 321:	5d                   	pop    %ebp
 322:	c3                   	ret    
 323:	90                   	nop
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 328:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 32d:	eb ed                	jmp    31c <stat+0x3c>
 32f:	90                   	nop

00000330 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 4d 08             	mov    0x8(%ebp),%ecx
 336:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 337:	0f be 11             	movsbl (%ecx),%edx
 33a:	8d 42 d0             	lea    -0x30(%edx),%eax
 33d:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 33f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 344:	77 17                	ja     35d <atoi+0x2d>
 346:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 348:	83 c1 01             	add    $0x1,%ecx
 34b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 34e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 352:	0f be 11             	movsbl (%ecx),%edx
 355:	8d 5a d0             	lea    -0x30(%edx),%ebx
 358:	80 fb 09             	cmp    $0x9,%bl
 35b:	76 eb                	jbe    348 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 35d:	5b                   	pop    %ebx
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 361:	31 d2                	xor    %edx,%edx
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
{
 363:	89 e5                	mov    %esp,%ebp
 365:	56                   	push   %esi
 366:	8b 45 08             	mov    0x8(%ebp),%eax
 369:	53                   	push   %ebx
 36a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 36d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 370:	85 db                	test   %ebx,%ebx
 372:	7e 12                	jle    386 <memmove+0x26>
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 382:	39 da                	cmp    %ebx,%edx
 384:	75 f2                	jne    378 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5d                   	pop    %ebp
 389:	c3                   	ret    

0000038a <fork>:
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    
 432:	66 90                	xchg   %ax,%ax
 434:	66 90                	xchg   %ax,%ax
 436:	66 90                	xchg   %ax,%ax
 438:	66 90                	xchg   %ax,%ax
 43a:	66 90                	xchg   %ax,%ax
 43c:	66 90                	xchg   %ax,%ax
 43e:	66 90                	xchg   %ax,%ax

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	89 c6                	mov    %eax,%esi
 447:	53                   	push   %ebx
 448:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 44b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 44e:	85 db                	test   %ebx,%ebx
 450:	74 09                	je     45b <printint+0x1b>
 452:	89 d0                	mov    %edx,%eax
 454:	c1 e8 1f             	shr    $0x1f,%eax
 457:	84 c0                	test   %al,%al
 459:	75 75                	jne    4d0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 45b:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 45d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 464:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 467:	31 ff                	xor    %edi,%edi
 469:	89 ce                	mov    %ecx,%esi
 46b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 46e:	eb 02                	jmp    472 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 470:	89 cf                	mov    %ecx,%edi
 472:	31 d2                	xor    %edx,%edx
 474:	f7 f6                	div    %esi
 476:	8d 4f 01             	lea    0x1(%edi),%ecx
 479:	0f b6 92 7c 08 00 00 	movzbl 0x87c(%edx),%edx
  }while((x /= base) != 0);
 480:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 482:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 485:	75 e9                	jne    470 <printint+0x30>
  if(neg)
 487:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 48a:	89 c8                	mov    %ecx,%eax
 48c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  }while((x /= base) != 0);
  if(neg)
 48f:	85 d2                	test   %edx,%edx
 491:	74 08                	je     49b <printint+0x5b>
    buf[i++] = '-';
 493:	8d 4f 02             	lea    0x2(%edi),%ecx
 496:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 49b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 49e:	66 90                	xchg   %ax,%ax
 4a0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 4a5:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4af:	00 
 4b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4b4:	89 34 24             	mov    %esi,(%esp)
 4b7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ba:	e8 f3 fe ff ff       	call   3b2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4bf:	83 ff ff             	cmp    $0xffffffff,%edi
 4c2:	75 dc                	jne    4a0 <printint+0x60>
    putc(fd, buf[i]);
}
 4c4:	83 c4 4c             	add    $0x4c,%esp
 4c7:	5b                   	pop    %ebx
 4c8:	5e                   	pop    %esi
 4c9:	5f                   	pop    %edi
 4ca:	5d                   	pop    %ebp
 4cb:	c3                   	ret    
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4d0:	89 d0                	mov    %edx,%eax
 4d2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4d4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4db:	eb 87                	jmp    464 <printint+0x24>
 4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4e4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e6:	56                   	push   %esi
 4e7:	53                   	push   %ebx
 4e8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4ee:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f1:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 4f7:	0f b6 13             	movzbl (%ebx),%edx
 4fa:	83 c3 01             	add    $0x1,%ebx
 4fd:	84 d2                	test   %dl,%dl
 4ff:	75 39                	jne    53a <printf+0x5a>
 501:	e9 c2 00 00 00       	jmp    5c8 <printf+0xe8>
 506:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 508:	83 fa 25             	cmp    $0x25,%edx
 50b:	0f 84 bf 00 00 00    	je     5d0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 511:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 514:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 51b:	00 
 51c:	89 44 24 04          	mov    %eax,0x4(%esp)
 520:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 523:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 526:	e8 87 fe ff ff       	call   3b2 <write>
 52b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 52e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 532:	84 d2                	test   %dl,%dl
 534:	0f 84 8e 00 00 00    	je     5c8 <printf+0xe8>
    c = fmt[i] & 0xff;
    if(state == 0){
 53a:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 53c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 53f:	74 c7                	je     508 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 541:	83 ff 25             	cmp    $0x25,%edi
 544:	75 e5                	jne    52b <printf+0x4b>
      if(c == 'd'){
 546:	83 fa 64             	cmp    $0x64,%edx
 549:	0f 84 31 01 00 00    	je     680 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 54f:	25 f7 00 00 00       	and    $0xf7,%eax
 554:	83 f8 70             	cmp    $0x70,%eax
 557:	0f 84 83 00 00 00    	je     5e0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 55d:	83 fa 73             	cmp    $0x73,%edx
 560:	0f 84 a2 00 00 00    	je     608 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 566:	83 fa 63             	cmp    $0x63,%edx
 569:	0f 84 35 01 00 00    	je     6a4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 56f:	83 fa 25             	cmp    $0x25,%edx
 572:	0f 84 e0 00 00 00    	je     658 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 578:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 57b:	83 c3 01             	add    $0x1,%ebx
 57e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 585:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 586:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 588:	89 44 24 04          	mov    %eax,0x4(%esp)
 58c:	89 34 24             	mov    %esi,(%esp)
 58f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 592:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 596:	e8 17 fe ff ff       	call   3b2 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 59b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a8:	00 
 5a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ad:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5b0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5b3:	e8 fa fd ff ff       	call   3b2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5bc:	84 d2                	test   %dl,%dl
 5be:	0f 85 76 ff ff ff    	jne    53a <printf+0x5a>
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c8:	83 c4 3c             	add    $0x3c,%esp
 5cb:	5b                   	pop    %ebx
 5cc:	5e                   	pop    %esi
 5cd:	5f                   	pop    %edi
 5ce:	5d                   	pop    %ebp
 5cf:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5d0:	bf 25 00 00 00       	mov    $0x25,%edi
 5d5:	e9 51 ff ff ff       	jmp    52b <printf+0x4b>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5e3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5f1:	8b 10                	mov    (%eax),%edx
 5f3:	89 f0                	mov    %esi,%eax
 5f5:	e8 46 fe ff ff       	call   440 <printint>
        ap++;
 5fa:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5fe:	e9 28 ff ff ff       	jmp    52b <printf+0x4b>
 603:	90                   	nop
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 608:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 60b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 60f:	8b 38                	mov    (%eax),%edi
        ap++;
        if(s == 0)
          s = "(null)";
 611:	b8 75 08 00 00       	mov    $0x875,%eax
 616:	85 ff                	test   %edi,%edi
 618:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 61b:	0f b6 07             	movzbl (%edi),%eax
 61e:	84 c0                	test   %al,%al
 620:	74 2a                	je     64c <printf+0x16c>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 628:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 62e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 631:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 638:	00 
 639:	89 44 24 04          	mov    %eax,0x4(%esp)
 63d:	89 34 24             	mov    %esi,(%esp)
 640:	e8 6d fd ff ff       	call   3b2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 645:	0f b6 07             	movzbl (%edi),%eax
 648:	84 c0                	test   %al,%al
 64a:	75 dc                	jne    628 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 64c:	31 ff                	xor    %edi,%edi
 64e:	e9 d8 fe ff ff       	jmp    52b <printf+0x4b>
 653:	90                   	nop
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 658:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 65b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 65d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 664:	00 
 665:	89 44 24 04          	mov    %eax,0x4(%esp)
 669:	89 34 24             	mov    %esi,(%esp)
 66c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 670:	e8 3d fd ff ff       	call   3b2 <write>
 675:	e9 b1 fe ff ff       	jmp    52b <printf+0x4b>
 67a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 680:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 683:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 688:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 68b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 692:	8b 10                	mov    (%eax),%edx
 694:	89 f0                	mov    %esi,%eax
 696:	e8 a5 fd ff ff       	call   440 <printint>
        ap++;
 69b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 69f:	e9 87 fe ff ff       	jmp    52b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6a7:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a9:	8b 00                	mov    (%eax),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ab:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b2:	00 
 6b3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6b6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6b9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c0:	e8 ed fc ff ff       	call   3b2 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6c5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6c9:	e9 5d fe ff ff       	jmp    52b <printf+0x4b>
 6ce:	66 90                	xchg   %ax,%ax

000006d0 <free>:
 6d0:	55                   	push   %ebp
 6d1:	a1 40 0b 00 00       	mov    0xb40,%eax
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6de:	8b 10                	mov    (%eax),%edx
 6e0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6e3:	39 c8                	cmp    %ecx,%eax
 6e5:	73 19                	jae    700 <free+0x30>
 6e7:	89 f6                	mov    %esi,%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6f0:	39 d1                	cmp    %edx,%ecx
 6f2:	72 1c                	jb     710 <free+0x40>
 6f4:	39 d0                	cmp    %edx,%eax
 6f6:	73 18                	jae    710 <free+0x40>
 6f8:	89 d0                	mov    %edx,%eax
 6fa:	39 c8                	cmp    %ecx,%eax
 6fc:	8b 10                	mov    (%eax),%edx
 6fe:	72 f0                	jb     6f0 <free+0x20>
 700:	39 d0                	cmp    %edx,%eax
 702:	72 f4                	jb     6f8 <free+0x28>
 704:	39 d1                	cmp    %edx,%ecx
 706:	73 f0                	jae    6f8 <free+0x28>
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 710:	8b 73 fc             	mov    -0x4(%ebx),%esi
 713:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 716:	39 fa                	cmp    %edi,%edx
 718:	74 19                	je     733 <free+0x63>
 71a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 71d:	8b 50 04             	mov    0x4(%eax),%edx
 720:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 723:	39 f1                	cmp    %esi,%ecx
 725:	74 23                	je     74a <free+0x7a>
 727:	89 08                	mov    %ecx,(%eax)
 729:	a3 40 0b 00 00       	mov    %eax,0xb40
 72e:	5b                   	pop    %ebx
 72f:	5e                   	pop    %esi
 730:	5f                   	pop    %edi
 731:	5d                   	pop    %ebp
 732:	c3                   	ret    
 733:	03 72 04             	add    0x4(%edx),%esi
 736:	89 73 fc             	mov    %esi,-0x4(%ebx)
 739:	8b 10                	mov    (%eax),%edx
 73b:	8b 12                	mov    (%edx),%edx
 73d:	89 53 f8             	mov    %edx,-0x8(%ebx)
 740:	8b 50 04             	mov    0x4(%eax),%edx
 743:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 746:	39 f1                	cmp    %esi,%ecx
 748:	75 dd                	jne    727 <free+0x57>
 74a:	03 53 fc             	add    -0x4(%ebx),%edx
 74d:	a3 40 0b 00 00       	mov    %eax,0xb40
 752:	89 50 04             	mov    %edx,0x4(%eax)
 755:	8b 53 f8             	mov    -0x8(%ebx),%edx
 758:	89 10                	mov    %edx,(%eax)
 75a:	5b                   	pop    %ebx
 75b:	5e                   	pop    %esi
 75c:	5f                   	pop    %edi
 75d:	5d                   	pop    %ebp
 75e:	c3                   	ret    
 75f:	90                   	nop

00000760 <malloc>:
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
 769:	8b 45 08             	mov    0x8(%ebp),%eax
 76c:	8b 15 40 0b 00 00    	mov    0xb40,%edx
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	83 c7 01             	add    $0x1,%edi
 77b:	85 d2                	test   %edx,%edx
 77d:	0f 84 93 00 00 00    	je     816 <malloc+0xb6>
 783:	8b 02                	mov    (%edx),%eax
 785:	8b 48 04             	mov    0x4(%eax),%ecx
 788:	39 cf                	cmp    %ecx,%edi
 78a:	76 64                	jbe    7f0 <malloc+0x90>
 78c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 792:	bb 00 10 00 00       	mov    $0x1000,%ebx
 797:	0f 43 df             	cmovae %edi,%ebx
 79a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7a1:	eb 0e                	jmp    7b1 <malloc+0x51>
 7a3:	90                   	nop
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7a8:	8b 02                	mov    (%edx),%eax
 7aa:	8b 48 04             	mov    0x4(%eax),%ecx
 7ad:	39 cf                	cmp    %ecx,%edi
 7af:	76 3f                	jbe    7f0 <malloc+0x90>
 7b1:	39 05 40 0b 00 00    	cmp    %eax,0xb40
 7b7:	89 c2                	mov    %eax,%edx
 7b9:	75 ed                	jne    7a8 <malloc+0x48>
 7bb:	83 ec 0c             	sub    $0xc,%esp
 7be:	56                   	push   %esi
 7bf:	e8 56 fc ff ff       	call   41a <sbrk>
 7c4:	83 c4 10             	add    $0x10,%esp
 7c7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ca:	74 1c                	je     7e8 <malloc+0x88>
 7cc:	89 58 04             	mov    %ebx,0x4(%eax)
 7cf:	83 ec 0c             	sub    $0xc,%esp
 7d2:	83 c0 08             	add    $0x8,%eax
 7d5:	50                   	push   %eax
 7d6:	e8 f5 fe ff ff       	call   6d0 <free>
 7db:	8b 15 40 0b 00 00    	mov    0xb40,%edx
 7e1:	83 c4 10             	add    $0x10,%esp
 7e4:	85 d2                	test   %edx,%edx
 7e6:	75 c0                	jne    7a8 <malloc+0x48>
 7e8:	31 c0                	xor    %eax,%eax
 7ea:	eb 1c                	jmp    808 <malloc+0xa8>
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 1c                	je     810 <malloc+0xb0>
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
 7ff:	89 15 40 0b 00 00    	mov    %edx,0xb40
 805:	83 c0 08             	add    $0x8,%eax
 808:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret    
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb e9                	jmp    7ff <malloc+0x9f>
 816:	c7 05 40 0b 00 00 44 	movl   $0xb44,0xb40
 81d:	0b 00 00 
 820:	c7 05 44 0b 00 00 44 	movl   $0xb44,0xb44
 827:	0b 00 00 
 82a:	b8 44 0b 00 00       	mov    $0xb44,%eax
 82f:	c7 05 48 0b 00 00 00 	movl   $0x0,0xb48
 836:	00 00 00 
 839:	e9 4e ff ff ff       	jmp    78c <malloc+0x2c>
