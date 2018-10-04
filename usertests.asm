
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
      11:	68 3e 4d 00 00       	push   $0x4d3e
      16:	6a 01                	push   $0x1
      18:	e8 d3 39 00 00       	call   39f0 <printf>
      1d:	5a                   	pop    %edx
      1e:	59                   	pop    %ecx
      1f:	6a 00                	push   $0x0
      21:	68 52 4d 00 00       	push   $0x4d52
      26:	e8 b7 38 00 00       	call   38e2 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 14                	js     46 <main+0x46>
      32:	83 ec 08             	sub    $0x8,%esp
      35:	68 bc 54 00 00       	push   $0x54bc
      3a:	6a 01                	push   $0x1
      3c:	e8 af 39 00 00       	call   39f0 <printf>
      41:	e8 5c 38 00 00       	call   38a2 <exit>
      46:	50                   	push   %eax
      47:	50                   	push   %eax
      48:	68 00 02 00 00       	push   $0x200
      4d:	68 52 4d 00 00       	push   $0x4d52
      52:	e8 8b 38 00 00       	call   38e2 <open>
      57:	89 04 24             	mov    %eax,(%esp)
      5a:	e8 6b 38 00 00       	call   38ca <close>
      5f:	e8 8c 35 00 00       	call   35f0 <argptest>
      64:	e8 97 11 00 00       	call   1200 <createdelete>
      69:	e8 52 1a 00 00       	call   1ac0 <linkunlink>
      6e:	e8 3d 17 00 00       	call   17b0 <concreate>
      73:	e8 98 0f 00 00       	call   1010 <fourfiles>
      78:	e8 d3 0d 00 00       	call   e50 <sharedfd>
      7d:	e8 0e 32 00 00       	call   3290 <bigargtest>
      82:	e8 59 23 00 00       	call   23e0 <bigwrite>
      87:	e8 04 32 00 00       	call   3290 <bigargtest>
      8c:	e8 7f 31 00 00       	call   3210 <bsstest>
      91:	e8 9a 2c 00 00       	call   2d30 <sbrktest>
      96:	e8 c5 30 00 00       	call   3160 <validatetest>
      9b:	e8 50 03 00 00       	call   3f0 <opentest>
      a0:	e8 db 03 00 00       	call   480 <writetest>
      a5:	e8 b6 05 00 00       	call   660 <writetest1>
      aa:	e8 81 07 00 00       	call   830 <createtest>
      af:	e8 3c 02 00 00       	call   2f0 <openiputtest>
      b4:	e8 47 01 00 00       	call   200 <exitiputtest>
      b9:	e8 62 00 00 00       	call   120 <iputtest>
      be:	e8 bd 0c 00 00       	call   d80 <mem>
      c3:	e8 48 09 00 00       	call   a10 <pipe1>
      c8:	e8 e3 0a 00 00       	call   bb0 <preempt>
      cd:	e8 1e 0c 00 00       	call   cf0 <exitwait>
      d2:	e8 f9 26 00 00       	call   27d0 <rmdot>
      d7:	e8 b4 25 00 00       	call   2690 <fourteen>
      dc:	e8 df 23 00 00       	call   24c0 <bigfile>
      e1:	e8 1a 1c 00 00       	call   1d00 <subdir>
      e6:	e8 b5 14 00 00       	call   15a0 <linktest>
      eb:	e8 20 13 00 00       	call   1410 <unlinkread>
      f0:	e8 5b 28 00 00       	call   2950 <dirfile>
      f5:	e8 56 2a 00 00       	call   2b50 <iref>
      fa:	e8 71 2b 00 00       	call   2c70 <forktest>
      ff:	e8 cc 1a 00 00       	call   1bd0 <bigdir>
     104:	e8 77 34 00 00       	call   3580 <uio>
     109:	e8 b2 08 00 00       	call   9c0 <exectest>
     10e:	e8 8f 37 00 00       	call   38a2 <exit>
     113:	66 90                	xchg   %ax,%ax
     115:	66 90                	xchg   %ax,%ax
     117:	66 90                	xchg   %ax,%ax
     119:	66 90                	xchg   %ax,%ax
     11b:	66 90                	xchg   %ax,%ax
     11d:	66 90                	xchg   %ax,%ax
     11f:	90                   	nop

00000120 <iputtest>:
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
     126:	68 e4 3d 00 00       	push   $0x3de4
     12b:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     131:	e8 ba 38 00 00       	call   39f0 <printf>
     136:	c7 04 24 77 3d 00 00 	movl   $0x3d77,(%esp)
     13d:	e8 c8 37 00 00       	call   390a <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 77 3d 00 00       	push   $0x3d77
     151:	e8 bc 37 00 00       	call   3912 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 74 3d 00 00       	push   $0x3d74
     169:	e8 84 37 00 00       	call   38f2 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 99 3d 00 00       	push   $0x3d99
     17d:	e8 90 37 00 00       	call   3912 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 1c 3e 00 00       	push   $0x3e1c
     191:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     197:	e8 54 38 00 00       	call   39f0 <printf>
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 50 3d 00 00       	push   $0x3d50
     1a8:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     1ae:	e8 3d 38 00 00       	call   39f0 <printf>
     1b3:	e8 ea 36 00 00       	call   38a2 <exit>
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 9b 3d 00 00       	push   $0x3d9b
     1bf:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     1c5:	e8 26 38 00 00       	call   39f0 <printf>
     1ca:	e8 d3 36 00 00       	call   38a2 <exit>
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 7f 3d 00 00       	push   $0x3d7f
     1d6:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     1dc:	e8 0f 38 00 00       	call   39f0 <printf>
     1e1:	e8 bc 36 00 00       	call   38a2 <exit>
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 5e 3d 00 00       	push   $0x3d5e
     1ed:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     1f3:	e8 f8 37 00 00       	call   39f0 <printf>
     1f8:	e8 a5 36 00 00       	call   38a2 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
     206:	68 ab 3d 00 00       	push   $0x3dab
     20b:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     211:	e8 da 37 00 00       	call   39f0 <printf>
     216:	e8 7f 36 00 00       	call   389a <fork>
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 82 00 00 00    	js     2a8 <exitiputtest+0xa8>
     226:	75 48                	jne    270 <exitiputtest+0x70>
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 77 3d 00 00       	push   $0x3d77
     230:	e8 d5 36 00 00       	call   390a <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 96 00 00 00    	js     2d6 <exitiputtest+0xd6>
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 77 3d 00 00       	push   $0x3d77
     248:	e8 c5 36 00 00       	call   3912 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	78 6b                	js     2bf <exitiputtest+0xbf>
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	68 74 3d 00 00       	push   $0x3d74
     25c:	e8 91 36 00 00       	call   38f2 <unlink>
     261:	83 c4 10             	add    $0x10,%esp
     264:	85 c0                	test   %eax,%eax
     266:	78 28                	js     290 <exitiputtest+0x90>
     268:	e8 35 36 00 00       	call   38a2 <exit>
     26d:	8d 76 00             	lea    0x0(%esi),%esi
     270:	e8 35 36 00 00       	call   38aa <wait>
     275:	83 ec 08             	sub    $0x8,%esp
     278:	68 ce 3d 00 00       	push   $0x3dce
     27d:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     283:	e8 68 37 00 00       	call   39f0 <printf>
     288:	83 c4 10             	add    $0x10,%esp
     28b:	c9                   	leave  
     28c:	c3                   	ret    
     28d:	8d 76 00             	lea    0x0(%esi),%esi
     290:	83 ec 08             	sub    $0x8,%esp
     293:	68 7f 3d 00 00       	push   $0x3d7f
     298:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     29e:	e8 4d 37 00 00       	call   39f0 <printf>
     2a3:	e8 fa 35 00 00       	call   38a2 <exit>
     2a8:	51                   	push   %ecx
     2a9:	51                   	push   %ecx
     2aa:	68 91 4c 00 00       	push   $0x4c91
     2af:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     2b5:	e8 36 37 00 00       	call   39f0 <printf>
     2ba:	e8 e3 35 00 00       	call   38a2 <exit>
     2bf:	50                   	push   %eax
     2c0:	50                   	push   %eax
     2c1:	68 ba 3d 00 00       	push   $0x3dba
     2c6:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     2cc:	e8 1f 37 00 00       	call   39f0 <printf>
     2d1:	e8 cc 35 00 00       	call   38a2 <exit>
     2d6:	52                   	push   %edx
     2d7:	52                   	push   %edx
     2d8:	68 50 3d 00 00       	push   $0x3d50
     2dd:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     2e3:	e8 08 37 00 00       	call   39f0 <printf>
     2e8:	e8 b5 35 00 00       	call   38a2 <exit>
     2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <openiputtest>:
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	83 ec 10             	sub    $0x10,%esp
     2f6:	68 e0 3d 00 00       	push   $0x3de0
     2fb:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     301:	e8 ea 36 00 00       	call   39f0 <printf>
     306:	c7 04 24 ef 3d 00 00 	movl   $0x3def,(%esp)
     30d:	e8 f8 35 00 00       	call   390a <mkdir>
     312:	83 c4 10             	add    $0x10,%esp
     315:	85 c0                	test   %eax,%eax
     317:	0f 88 88 00 00 00    	js     3a5 <openiputtest+0xb5>
     31d:	e8 78 35 00 00       	call   389a <fork>
     322:	85 c0                	test   %eax,%eax
     324:	0f 88 92 00 00 00    	js     3bc <openiputtest+0xcc>
     32a:	75 34                	jne    360 <openiputtest+0x70>
     32c:	83 ec 08             	sub    $0x8,%esp
     32f:	6a 02                	push   $0x2
     331:	68 ef 3d 00 00       	push   $0x3def
     336:	e8 a7 35 00 00       	call   38e2 <open>
     33b:	83 c4 10             	add    $0x10,%esp
     33e:	85 c0                	test   %eax,%eax
     340:	78 5e                	js     3a0 <openiputtest+0xb0>
     342:	83 ec 08             	sub    $0x8,%esp
     345:	68 74 4d 00 00       	push   $0x4d74
     34a:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     350:	e8 9b 36 00 00       	call   39f0 <printf>
     355:	e8 48 35 00 00       	call   38a2 <exit>
     35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     360:	83 ec 0c             	sub    $0xc,%esp
     363:	6a 01                	push   $0x1
     365:	e8 c8 35 00 00       	call   3932 <sleep>
     36a:	c7 04 24 ef 3d 00 00 	movl   $0x3def,(%esp)
     371:	e8 7c 35 00 00       	call   38f2 <unlink>
     376:	83 c4 10             	add    $0x10,%esp
     379:	85 c0                	test   %eax,%eax
     37b:	75 56                	jne    3d3 <openiputtest+0xe3>
     37d:	e8 28 35 00 00       	call   38aa <wait>
     382:	83 ec 08             	sub    $0x8,%esp
     385:	68 18 3e 00 00       	push   $0x3e18
     38a:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     390:	e8 5b 36 00 00       	call   39f0 <printf>
     395:	83 c4 10             	add    $0x10,%esp
     398:	c9                   	leave  
     399:	c3                   	ret    
     39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3a0:	e8 fd 34 00 00       	call   38a2 <exit>
     3a5:	51                   	push   %ecx
     3a6:	51                   	push   %ecx
     3a7:	68 f5 3d 00 00       	push   $0x3df5
     3ac:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     3b2:	e8 39 36 00 00       	call   39f0 <printf>
     3b7:	e8 e6 34 00 00       	call   38a2 <exit>
     3bc:	52                   	push   %edx
     3bd:	52                   	push   %edx
     3be:	68 91 4c 00 00       	push   $0x4c91
     3c3:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     3c9:	e8 22 36 00 00       	call   39f0 <printf>
     3ce:	e8 cf 34 00 00       	call   38a2 <exit>
     3d3:	50                   	push   %eax
     3d4:	50                   	push   %eax
     3d5:	68 09 3e 00 00       	push   $0x3e09
     3da:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     3e0:	e8 0b 36 00 00       	call   39f0 <printf>
     3e5:	e8 b8 34 00 00       	call   38a2 <exit>
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <opentest>:
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	83 ec 10             	sub    $0x10,%esp
     3f6:	68 2a 3e 00 00       	push   $0x3e2a
     3fb:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     401:	e8 ea 35 00 00       	call   39f0 <printf>
     406:	58                   	pop    %eax
     407:	5a                   	pop    %edx
     408:	6a 00                	push   $0x0
     40a:	68 35 3e 00 00       	push   $0x3e35
     40f:	e8 ce 34 00 00       	call   38e2 <open>
     414:	83 c4 10             	add    $0x10,%esp
     417:	85 c0                	test   %eax,%eax
     419:	78 36                	js     451 <opentest+0x61>
     41b:	83 ec 0c             	sub    $0xc,%esp
     41e:	50                   	push   %eax
     41f:	e8 a6 34 00 00       	call   38ca <close>
     424:	5a                   	pop    %edx
     425:	59                   	pop    %ecx
     426:	6a 00                	push   $0x0
     428:	68 4d 3e 00 00       	push   $0x3e4d
     42d:	e8 b0 34 00 00       	call   38e2 <open>
     432:	83 c4 10             	add    $0x10,%esp
     435:	85 c0                	test   %eax,%eax
     437:	79 2f                	jns    468 <opentest+0x78>
     439:	83 ec 08             	sub    $0x8,%esp
     43c:	68 78 3e 00 00       	push   $0x3e78
     441:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     447:	e8 a4 35 00 00       	call   39f0 <printf>
     44c:	83 c4 10             	add    $0x10,%esp
     44f:	c9                   	leave  
     450:	c3                   	ret    
     451:	50                   	push   %eax
     452:	50                   	push   %eax
     453:	68 3a 3e 00 00       	push   $0x3e3a
     458:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     45e:	e8 8d 35 00 00       	call   39f0 <printf>
     463:	e8 3a 34 00 00       	call   38a2 <exit>
     468:	50                   	push   %eax
     469:	50                   	push   %eax
     46a:	68 5a 3e 00 00       	push   $0x3e5a
     46f:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     475:	e8 76 35 00 00       	call   39f0 <printf>
     47a:	e8 23 34 00 00       	call   38a2 <exit>
     47f:	90                   	nop

00000480 <writetest>:
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	56                   	push   %esi
     484:	53                   	push   %ebx
     485:	83 ec 08             	sub    $0x8,%esp
     488:	68 86 3e 00 00       	push   $0x3e86
     48d:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     493:	e8 58 35 00 00       	call   39f0 <printf>
     498:	59                   	pop    %ecx
     499:	5b                   	pop    %ebx
     49a:	68 02 02 00 00       	push   $0x202
     49f:	68 97 3e 00 00       	push   $0x3e97
     4a4:	e8 39 34 00 00       	call   38e2 <open>
     4a9:	83 c4 10             	add    $0x10,%esp
     4ac:	85 c0                	test   %eax,%eax
     4ae:	0f 88 8b 01 00 00    	js     63f <writetest+0x1bf>
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	89 c6                	mov    %eax,%esi
     4b9:	31 db                	xor    %ebx,%ebx
     4bb:	68 9d 3e 00 00       	push   $0x3e9d
     4c0:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     4c6:	e8 25 35 00 00       	call   39f0 <printf>
     4cb:	83 c4 10             	add    $0x10,%esp
     4ce:	66 90                	xchg   %ax,%ax
     4d0:	83 ec 04             	sub    $0x4,%esp
     4d3:	6a 0a                	push   $0xa
     4d5:	68 d4 3e 00 00       	push   $0x3ed4
     4da:	56                   	push   %esi
     4db:	e8 e2 33 00 00       	call   38c2 <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d9 00 00 00    	jne    5c5 <writetest+0x145>
     4ec:	83 ec 04             	sub    $0x4,%esp
     4ef:	6a 0a                	push   $0xa
     4f1:	68 df 3e 00 00       	push   $0x3edf
     4f6:	56                   	push   %esi
     4f7:	e8 c6 33 00 00       	call   38c2 <write>
     4fc:	83 c4 10             	add    $0x10,%esp
     4ff:	83 f8 0a             	cmp    $0xa,%eax
     502:	0f 85 d6 00 00 00    	jne    5de <writetest+0x15e>
     508:	83 c3 01             	add    $0x1,%ebx
     50b:	83 fb 64             	cmp    $0x64,%ebx
     50e:	75 c0                	jne    4d0 <writetest+0x50>
     510:	83 ec 08             	sub    $0x8,%esp
     513:	68 ea 3e 00 00       	push   $0x3eea
     518:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     51e:	e8 cd 34 00 00       	call   39f0 <printf>
     523:	89 34 24             	mov    %esi,(%esp)
     526:	e8 9f 33 00 00       	call   38ca <close>
     52b:	58                   	pop    %eax
     52c:	5a                   	pop    %edx
     52d:	6a 00                	push   $0x0
     52f:	68 97 3e 00 00       	push   $0x3e97
     534:	e8 a9 33 00 00       	call   38e2 <open>
     539:	83 c4 10             	add    $0x10,%esp
     53c:	85 c0                	test   %eax,%eax
     53e:	89 c3                	mov    %eax,%ebx
     540:	0f 88 b1 00 00 00    	js     5f7 <writetest+0x177>
     546:	83 ec 08             	sub    $0x8,%esp
     549:	68 f5 3e 00 00       	push   $0x3ef5
     54e:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     554:	e8 97 34 00 00       	call   39f0 <printf>
     559:	83 c4 0c             	add    $0xc,%esp
     55c:	68 d0 07 00 00       	push   $0x7d0
     561:	68 c0 85 00 00       	push   $0x85c0
     566:	53                   	push   %ebx
     567:	e8 4e 33 00 00       	call   38ba <read>
     56c:	83 c4 10             	add    $0x10,%esp
     56f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     574:	0f 85 95 00 00 00    	jne    60f <writetest+0x18f>
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	68 29 3f 00 00       	push   $0x3f29
     582:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     588:	e8 63 34 00 00       	call   39f0 <printf>
     58d:	89 1c 24             	mov    %ebx,(%esp)
     590:	e8 35 33 00 00       	call   38ca <close>
     595:	c7 04 24 97 3e 00 00 	movl   $0x3e97,(%esp)
     59c:	e8 51 33 00 00       	call   38f2 <unlink>
     5a1:	83 c4 10             	add    $0x10,%esp
     5a4:	85 c0                	test   %eax,%eax
     5a6:	78 7f                	js     627 <writetest+0x1a7>
     5a8:	83 ec 08             	sub    $0x8,%esp
     5ab:	68 51 3f 00 00       	push   $0x3f51
     5b0:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     5b6:	e8 35 34 00 00       	call   39f0 <printf>
     5bb:	83 c4 10             	add    $0x10,%esp
     5be:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5c1:	5b                   	pop    %ebx
     5c2:	5e                   	pop    %esi
     5c3:	5d                   	pop    %ebp
     5c4:	c3                   	ret    
     5c5:	83 ec 04             	sub    $0x4,%esp
     5c8:	53                   	push   %ebx
     5c9:	68 98 4d 00 00       	push   $0x4d98
     5ce:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     5d4:	e8 17 34 00 00       	call   39f0 <printf>
     5d9:	e8 c4 32 00 00       	call   38a2 <exit>
     5de:	83 ec 04             	sub    $0x4,%esp
     5e1:	53                   	push   %ebx
     5e2:	68 bc 4d 00 00       	push   $0x4dbc
     5e7:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     5ed:	e8 fe 33 00 00       	call   39f0 <printf>
     5f2:	e8 ab 32 00 00       	call   38a2 <exit>
     5f7:	83 ec 08             	sub    $0x8,%esp
     5fa:	68 0e 3f 00 00       	push   $0x3f0e
     5ff:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     605:	e8 e6 33 00 00       	call   39f0 <printf>
     60a:	e8 93 32 00 00       	call   38a2 <exit>
     60f:	83 ec 08             	sub    $0x8,%esp
     612:	68 55 42 00 00       	push   $0x4255
     617:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     61d:	e8 ce 33 00 00       	call   39f0 <printf>
     622:	e8 7b 32 00 00       	call   38a2 <exit>
     627:	83 ec 08             	sub    $0x8,%esp
     62a:	68 3c 3f 00 00       	push   $0x3f3c
     62f:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     635:	e8 b6 33 00 00       	call   39f0 <printf>
     63a:	e8 63 32 00 00       	call   38a2 <exit>
     63f:	83 ec 08             	sub    $0x8,%esp
     642:	68 b8 3e 00 00       	push   $0x3eb8
     647:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     64d:	e8 9e 33 00 00       	call   39f0 <printf>
     652:	e8 4b 32 00 00       	call   38a2 <exit>
     657:	89 f6                	mov    %esi,%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <writetest1>:
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	56                   	push   %esi
     664:	53                   	push   %ebx
     665:	83 ec 08             	sub    $0x8,%esp
     668:	68 65 3f 00 00       	push   $0x3f65
     66d:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     673:	e8 78 33 00 00       	call   39f0 <printf>
     678:	59                   	pop    %ecx
     679:	5b                   	pop    %ebx
     67a:	68 02 02 00 00       	push   $0x202
     67f:	68 df 3f 00 00       	push   $0x3fdf
     684:	e8 59 32 00 00       	call   38e2 <open>
     689:	83 c4 10             	add    $0x10,%esp
     68c:	85 c0                	test   %eax,%eax
     68e:	0f 88 64 01 00 00    	js     7f8 <writetest1+0x198>
     694:	89 c6                	mov    %eax,%esi
     696:	31 db                	xor    %ebx,%ebx
     698:	90                   	nop
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6a0:	83 ec 04             	sub    $0x4,%esp
     6a3:	89 1d c0 85 00 00    	mov    %ebx,0x85c0
     6a9:	68 00 02 00 00       	push   $0x200
     6ae:	68 c0 85 00 00       	push   $0x85c0
     6b3:	56                   	push   %esi
     6b4:	e8 09 32 00 00       	call   38c2 <write>
     6b9:	83 c4 10             	add    $0x10,%esp
     6bc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6c1:	0f 85 b3 00 00 00    	jne    77a <writetest1+0x11a>
     6c7:	83 c3 01             	add    $0x1,%ebx
     6ca:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6d0:	75 ce                	jne    6a0 <writetest1+0x40>
     6d2:	83 ec 0c             	sub    $0xc,%esp
     6d5:	56                   	push   %esi
     6d6:	e8 ef 31 00 00       	call   38ca <close>
     6db:	58                   	pop    %eax
     6dc:	5a                   	pop    %edx
     6dd:	6a 00                	push   $0x0
     6df:	68 df 3f 00 00       	push   $0x3fdf
     6e4:	e8 f9 31 00 00       	call   38e2 <open>
     6e9:	83 c4 10             	add    $0x10,%esp
     6ec:	85 c0                	test   %eax,%eax
     6ee:	89 c6                	mov    %eax,%esi
     6f0:	0f 88 ea 00 00 00    	js     7e0 <writetest1+0x180>
     6f6:	31 db                	xor    %ebx,%ebx
     6f8:	eb 1d                	jmp    717 <writetest1+0xb7>
     6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     700:	3d 00 02 00 00       	cmp    $0x200,%eax
     705:	0f 85 9f 00 00 00    	jne    7aa <writetest1+0x14a>
     70b:	a1 c0 85 00 00       	mov    0x85c0,%eax
     710:	39 c3                	cmp    %eax,%ebx
     712:	75 7f                	jne    793 <writetest1+0x133>
     714:	83 c3 01             	add    $0x1,%ebx
     717:	83 ec 04             	sub    $0x4,%esp
     71a:	68 00 02 00 00       	push   $0x200
     71f:	68 c0 85 00 00       	push   $0x85c0
     724:	56                   	push   %esi
     725:	e8 90 31 00 00       	call   38ba <read>
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	85 c0                	test   %eax,%eax
     72f:	75 cf                	jne    700 <writetest1+0xa0>
     731:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     737:	0f 84 86 00 00 00    	je     7c3 <writetest1+0x163>
     73d:	83 ec 0c             	sub    $0xc,%esp
     740:	56                   	push   %esi
     741:	e8 84 31 00 00       	call   38ca <close>
     746:	c7 04 24 df 3f 00 00 	movl   $0x3fdf,(%esp)
     74d:	e8 a0 31 00 00       	call   38f2 <unlink>
     752:	83 c4 10             	add    $0x10,%esp
     755:	85 c0                	test   %eax,%eax
     757:	0f 88 b3 00 00 00    	js     810 <writetest1+0x1b0>
     75d:	83 ec 08             	sub    $0x8,%esp
     760:	68 06 40 00 00       	push   $0x4006
     765:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     76b:	e8 80 32 00 00       	call   39f0 <printf>
     770:	83 c4 10             	add    $0x10,%esp
     773:	8d 65 f8             	lea    -0x8(%ebp),%esp
     776:	5b                   	pop    %ebx
     777:	5e                   	pop    %esi
     778:	5d                   	pop    %ebp
     779:	c3                   	ret    
     77a:	83 ec 04             	sub    $0x4,%esp
     77d:	53                   	push   %ebx
     77e:	68 8f 3f 00 00       	push   $0x3f8f
     783:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     789:	e8 62 32 00 00       	call   39f0 <printf>
     78e:	e8 0f 31 00 00       	call   38a2 <exit>
     793:	50                   	push   %eax
     794:	53                   	push   %ebx
     795:	68 e0 4d 00 00       	push   $0x4de0
     79a:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     7a0:	e8 4b 32 00 00       	call   39f0 <printf>
     7a5:	e8 f8 30 00 00       	call   38a2 <exit>
     7aa:	83 ec 04             	sub    $0x4,%esp
     7ad:	50                   	push   %eax
     7ae:	68 e3 3f 00 00       	push   $0x3fe3
     7b3:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     7b9:	e8 32 32 00 00       	call   39f0 <printf>
     7be:	e8 df 30 00 00       	call   38a2 <exit>
     7c3:	83 ec 04             	sub    $0x4,%esp
     7c6:	68 8b 00 00 00       	push   $0x8b
     7cb:	68 c6 3f 00 00       	push   $0x3fc6
     7d0:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     7d6:	e8 15 32 00 00       	call   39f0 <printf>
     7db:	e8 c2 30 00 00       	call   38a2 <exit>
     7e0:	83 ec 08             	sub    $0x8,%esp
     7e3:	68 ad 3f 00 00       	push   $0x3fad
     7e8:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     7ee:	e8 fd 31 00 00       	call   39f0 <printf>
     7f3:	e8 aa 30 00 00       	call   38a2 <exit>
     7f8:	83 ec 08             	sub    $0x8,%esp
     7fb:	68 75 3f 00 00       	push   $0x3f75
     800:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     806:	e8 e5 31 00 00       	call   39f0 <printf>
     80b:	e8 92 30 00 00       	call   38a2 <exit>
     810:	83 ec 08             	sub    $0x8,%esp
     813:	68 f3 3f 00 00       	push   $0x3ff3
     818:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     81e:	e8 cd 31 00 00       	call   39f0 <printf>
     823:	e8 7a 30 00 00       	call   38a2 <exit>
     828:	90                   	nop
     829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000830 <createtest>:
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	53                   	push   %ebx
     834:	bb 30 00 00 00       	mov    $0x30,%ebx
     839:	83 ec 0c             	sub    $0xc,%esp
     83c:	68 00 4e 00 00       	push   $0x4e00
     841:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     847:	e8 a4 31 00 00       	call   39f0 <printf>
     84c:	c6 05 c0 a5 00 00 61 	movb   $0x61,0xa5c0
     853:	c6 05 c2 a5 00 00 00 	movb   $0x0,0xa5c2
     85a:	83 c4 10             	add    $0x10,%esp
     85d:	8d 76 00             	lea    0x0(%esi),%esi
     860:	83 ec 08             	sub    $0x8,%esp
     863:	88 1d c1 a5 00 00    	mov    %bl,0xa5c1
     869:	83 c3 01             	add    $0x1,%ebx
     86c:	68 02 02 00 00       	push   $0x202
     871:	68 c0 a5 00 00       	push   $0xa5c0
     876:	e8 67 30 00 00       	call   38e2 <open>
     87b:	89 04 24             	mov    %eax,(%esp)
     87e:	e8 47 30 00 00       	call   38ca <close>
     883:	83 c4 10             	add    $0x10,%esp
     886:	80 fb 64             	cmp    $0x64,%bl
     889:	75 d5                	jne    860 <createtest+0x30>
     88b:	c6 05 c0 a5 00 00 61 	movb   $0x61,0xa5c0
     892:	c6 05 c2 a5 00 00 00 	movb   $0x0,0xa5c2
     899:	bb 30 00 00 00       	mov    $0x30,%ebx
     89e:	66 90                	xchg   %ax,%ax
     8a0:	83 ec 0c             	sub    $0xc,%esp
     8a3:	88 1d c1 a5 00 00    	mov    %bl,0xa5c1
     8a9:	83 c3 01             	add    $0x1,%ebx
     8ac:	68 c0 a5 00 00       	push   $0xa5c0
     8b1:	e8 3c 30 00 00       	call   38f2 <unlink>
     8b6:	83 c4 10             	add    $0x10,%esp
     8b9:	80 fb 64             	cmp    $0x64,%bl
     8bc:	75 e2                	jne    8a0 <createtest+0x70>
     8be:	83 ec 08             	sub    $0x8,%esp
     8c1:	68 28 4e 00 00       	push   $0x4e28
     8c6:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     8cc:	e8 1f 31 00 00       	call   39f0 <printf>
     8d1:	83 c4 10             	add    $0x10,%esp
     8d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d7:	c9                   	leave  
     8d8:	c3                   	ret    
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <dirtest>:
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 10             	sub    $0x10,%esp
     8e6:	68 14 40 00 00       	push   $0x4014
     8eb:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     8f1:	e8 fa 30 00 00       	call   39f0 <printf>
     8f6:	c7 04 24 20 40 00 00 	movl   $0x4020,(%esp)
     8fd:	e8 08 30 00 00       	call   390a <mkdir>
     902:	83 c4 10             	add    $0x10,%esp
     905:	85 c0                	test   %eax,%eax
     907:	78 58                	js     961 <dirtest+0x81>
     909:	83 ec 0c             	sub    $0xc,%esp
     90c:	68 20 40 00 00       	push   $0x4020
     911:	e8 fc 2f 00 00       	call   3912 <chdir>
     916:	83 c4 10             	add    $0x10,%esp
     919:	85 c0                	test   %eax,%eax
     91b:	0f 88 85 00 00 00    	js     9a6 <dirtest+0xc6>
     921:	83 ec 0c             	sub    $0xc,%esp
     924:	68 c5 45 00 00       	push   $0x45c5
     929:	e8 e4 2f 00 00       	call   3912 <chdir>
     92e:	83 c4 10             	add    $0x10,%esp
     931:	85 c0                	test   %eax,%eax
     933:	78 5a                	js     98f <dirtest+0xaf>
     935:	83 ec 0c             	sub    $0xc,%esp
     938:	68 20 40 00 00       	push   $0x4020
     93d:	e8 b0 2f 00 00       	call   38f2 <unlink>
     942:	83 c4 10             	add    $0x10,%esp
     945:	85 c0                	test   %eax,%eax
     947:	78 2f                	js     978 <dirtest+0x98>
     949:	83 ec 08             	sub    $0x8,%esp
     94c:	68 5d 40 00 00       	push   $0x405d
     951:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     957:	e8 94 30 00 00       	call   39f0 <printf>
     95c:	83 c4 10             	add    $0x10,%esp
     95f:	c9                   	leave  
     960:	c3                   	ret    
     961:	50                   	push   %eax
     962:	50                   	push   %eax
     963:	68 50 3d 00 00       	push   $0x3d50
     968:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     96e:	e8 7d 30 00 00       	call   39f0 <printf>
     973:	e8 2a 2f 00 00       	call   38a2 <exit>
     978:	50                   	push   %eax
     979:	50                   	push   %eax
     97a:	68 49 40 00 00       	push   $0x4049
     97f:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     985:	e8 66 30 00 00       	call   39f0 <printf>
     98a:	e8 13 2f 00 00       	call   38a2 <exit>
     98f:	52                   	push   %edx
     990:	52                   	push   %edx
     991:	68 38 40 00 00       	push   $0x4038
     996:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     99c:	e8 4f 30 00 00       	call   39f0 <printf>
     9a1:	e8 fc 2e 00 00       	call   38a2 <exit>
     9a6:	51                   	push   %ecx
     9a7:	51                   	push   %ecx
     9a8:	68 25 40 00 00       	push   $0x4025
     9ad:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     9b3:	e8 38 30 00 00       	call   39f0 <printf>
     9b8:	e8 e5 2e 00 00       	call   38a2 <exit>
     9bd:	8d 76 00             	lea    0x0(%esi),%esi

000009c0 <exectest>:
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	83 ec 10             	sub    $0x10,%esp
     9c6:	68 6c 40 00 00       	push   $0x406c
     9cb:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     9d1:	e8 1a 30 00 00       	call   39f0 <printf>
     9d6:	5a                   	pop    %edx
     9d7:	59                   	pop    %ecx
     9d8:	68 d0 5d 00 00       	push   $0x5dd0
     9dd:	68 35 3e 00 00       	push   $0x3e35
     9e2:	e8 f3 2e 00 00       	call   38da <exec>
     9e7:	83 c4 10             	add    $0x10,%esp
     9ea:	85 c0                	test   %eax,%eax
     9ec:	78 02                	js     9f0 <exectest+0x30>
     9ee:	c9                   	leave  
     9ef:	c3                   	ret    
     9f0:	50                   	push   %eax
     9f1:	50                   	push   %eax
     9f2:	68 77 40 00 00       	push   $0x4077
     9f7:	ff 35 cc 5d 00 00    	pushl  0x5dcc
     9fd:	e8 ee 2f 00 00       	call   39f0 <printf>
     a02:	e8 9b 2e 00 00       	call   38a2 <exit>
     a07:	89 f6                	mov    %esi,%esi
     a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a10 <pipe1>:
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	57                   	push   %edi
     a14:	56                   	push   %esi
     a15:	53                   	push   %ebx
     a16:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a19:	83 ec 38             	sub    $0x38,%esp
     a1c:	50                   	push   %eax
     a1d:	e8 90 2e 00 00       	call   38b2 <pipe>
     a22:	83 c4 10             	add    $0x10,%esp
     a25:	85 c0                	test   %eax,%eax
     a27:	0f 85 3d 01 00 00    	jne    b6a <pipe1+0x15a>
     a2d:	89 c3                	mov    %eax,%ebx
     a2f:	e8 66 2e 00 00       	call   389a <fork>
     a34:	83 f8 00             	cmp    $0x0,%eax
     a37:	89 c6                	mov    %eax,%esi
     a39:	0f 84 8a 00 00 00    	je     ac9 <pipe1+0xb9>
     a3f:	0f 8e 39 01 00 00    	jle    b7e <pipe1+0x16e>
     a45:	83 ec 0c             	sub    $0xc,%esp
     a48:	ff 75 e4             	pushl  -0x1c(%ebp)
     a4b:	bf 01 00 00 00       	mov    $0x1,%edi
     a50:	e8 75 2e 00 00       	call   38ca <close>
     a55:	83 c4 10             	add    $0x10,%esp
     a58:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a5f:	83 ec 04             	sub    $0x4,%esp
     a62:	57                   	push   %edi
     a63:	68 c0 85 00 00       	push   $0x85c0
     a68:	ff 75 e0             	pushl  -0x20(%ebp)
     a6b:	e8 4a 2e 00 00       	call   38ba <read>
     a70:	83 c4 10             	add    $0x10,%esp
     a73:	85 c0                	test   %eax,%eax
     a75:	0f 8e a9 00 00 00    	jle    b24 <pipe1+0x114>
     a7b:	89 d9                	mov    %ebx,%ecx
     a7d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a80:	f7 d9                	neg    %ecx
     a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a88:	38 9c 0b c0 85 00 00 	cmp    %bl,0x85c0(%ebx,%ecx,1)
     a8f:	8d 53 01             	lea    0x1(%ebx),%edx
     a92:	75 1b                	jne    aaf <pipe1+0x9f>
     a94:	39 f2                	cmp    %esi,%edx
     a96:	89 d3                	mov    %edx,%ebx
     a98:	75 ee                	jne    a88 <pipe1+0x78>
     a9a:	01 ff                	add    %edi,%edi
     a9c:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a9f:	b8 00 20 00 00       	mov    $0x2000,%eax
     aa4:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     aaa:	0f 4f f8             	cmovg  %eax,%edi
     aad:	eb b0                	jmp    a5f <pipe1+0x4f>
     aaf:	83 ec 08             	sub    $0x8,%esp
     ab2:	68 a6 40 00 00       	push   $0x40a6
     ab7:	6a 01                	push   $0x1
     ab9:	e8 32 2f 00 00       	call   39f0 <printf>
     abe:	83 c4 10             	add    $0x10,%esp
     ac1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ac4:	5b                   	pop    %ebx
     ac5:	5e                   	pop    %esi
     ac6:	5f                   	pop    %edi
     ac7:	5d                   	pop    %ebp
     ac8:	c3                   	ret    
     ac9:	83 ec 0c             	sub    $0xc,%esp
     acc:	ff 75 e0             	pushl  -0x20(%ebp)
     acf:	e8 f6 2d 00 00       	call   38ca <close>
     ad4:	83 c4 10             	add    $0x10,%esp
     ad7:	89 f0                	mov    %esi,%eax
     ad9:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx
     adf:	89 f3                	mov    %esi,%ebx
     ae1:	f7 d8                	neg    %eax
     ae3:	90                   	nop
     ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ae8:	88 9c 18 c0 85 00 00 	mov    %bl,0x85c0(%eax,%ebx,1)
     aef:	83 c3 01             	add    $0x1,%ebx
     af2:	39 d3                	cmp    %edx,%ebx
     af4:	75 f2                	jne    ae8 <pipe1+0xd8>
     af6:	83 ec 04             	sub    $0x4,%esp
     af9:	89 de                	mov    %ebx,%esi
     afb:	68 09 04 00 00       	push   $0x409
     b00:	68 c0 85 00 00       	push   $0x85c0
     b05:	ff 75 e4             	pushl  -0x1c(%ebp)
     b08:	e8 b5 2d 00 00       	call   38c2 <write>
     b0d:	83 c4 10             	add    $0x10,%esp
     b10:	3d 09 04 00 00       	cmp    $0x409,%eax
     b15:	75 7b                	jne    b92 <pipe1+0x182>
     b17:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b1d:	75 b8                	jne    ad7 <pipe1+0xc7>
     b1f:	e8 7e 2d 00 00       	call   38a2 <exit>
     b24:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b2b:	75 26                	jne    b53 <pipe1+0x143>
     b2d:	83 ec 0c             	sub    $0xc,%esp
     b30:	ff 75 e0             	pushl  -0x20(%ebp)
     b33:	e8 92 2d 00 00       	call   38ca <close>
     b38:	e8 6d 2d 00 00       	call   38aa <wait>
     b3d:	58                   	pop    %eax
     b3e:	5a                   	pop    %edx
     b3f:	68 cb 40 00 00       	push   $0x40cb
     b44:	6a 01                	push   $0x1
     b46:	e8 a5 2e 00 00       	call   39f0 <printf>
     b4b:	83 c4 10             	add    $0x10,%esp
     b4e:	e9 6e ff ff ff       	jmp    ac1 <pipe1+0xb1>
     b53:	83 ec 04             	sub    $0x4,%esp
     b56:	ff 75 d4             	pushl  -0x2c(%ebp)
     b59:	68 b4 40 00 00       	push   $0x40b4
     b5e:	6a 01                	push   $0x1
     b60:	e8 8b 2e 00 00       	call   39f0 <printf>
     b65:	e8 38 2d 00 00       	call   38a2 <exit>
     b6a:	83 ec 08             	sub    $0x8,%esp
     b6d:	68 89 40 00 00       	push   $0x4089
     b72:	6a 01                	push   $0x1
     b74:	e8 77 2e 00 00       	call   39f0 <printf>
     b79:	e8 24 2d 00 00       	call   38a2 <exit>
     b7e:	83 ec 08             	sub    $0x8,%esp
     b81:	68 d5 40 00 00       	push   $0x40d5
     b86:	6a 01                	push   $0x1
     b88:	e8 63 2e 00 00       	call   39f0 <printf>
     b8d:	e8 10 2d 00 00       	call   38a2 <exit>
     b92:	83 ec 08             	sub    $0x8,%esp
     b95:	68 98 40 00 00       	push   $0x4098
     b9a:	6a 01                	push   $0x1
     b9c:	e8 4f 2e 00 00       	call   39f0 <printf>
     ba1:	e8 fc 2c 00 00       	call   38a2 <exit>
     ba6:	8d 76 00             	lea    0x0(%esi),%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <preempt>:
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
     bb9:	68 e4 40 00 00       	push   $0x40e4
     bbe:	6a 01                	push   $0x1
     bc0:	e8 2b 2e 00 00       	call   39f0 <printf>
     bc5:	e8 d0 2c 00 00       	call   389a <fork>
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 02                	jne    bd3 <preempt+0x23>
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	89 c7                	mov    %eax,%edi
     bd5:	e8 c0 2c 00 00       	call   389a <fork>
     bda:	85 c0                	test   %eax,%eax
     bdc:	89 c6                	mov    %eax,%esi
     bde:	75 02                	jne    be2 <preempt+0x32>
     be0:	eb fe                	jmp    be0 <preempt+0x30>
     be2:	8d 45 e0             	lea    -0x20(%ebp),%eax
     be5:	83 ec 0c             	sub    $0xc,%esp
     be8:	50                   	push   %eax
     be9:	e8 c4 2c 00 00       	call   38b2 <pipe>
     bee:	e8 a7 2c 00 00       	call   389a <fork>
     bf3:	83 c4 10             	add    $0x10,%esp
     bf6:	85 c0                	test   %eax,%eax
     bf8:	89 c3                	mov    %eax,%ebx
     bfa:	75 47                	jne    c43 <preempt+0x93>
     bfc:	83 ec 0c             	sub    $0xc,%esp
     bff:	ff 75 e0             	pushl  -0x20(%ebp)
     c02:	e8 c3 2c 00 00       	call   38ca <close>
     c07:	83 c4 0c             	add    $0xc,%esp
     c0a:	6a 01                	push   $0x1
     c0c:	68 a9 46 00 00       	push   $0x46a9
     c11:	ff 75 e4             	pushl  -0x1c(%ebp)
     c14:	e8 a9 2c 00 00       	call   38c2 <write>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	83 f8 01             	cmp    $0x1,%eax
     c1f:	74 12                	je     c33 <preempt+0x83>
     c21:	83 ec 08             	sub    $0x8,%esp
     c24:	68 ee 40 00 00       	push   $0x40ee
     c29:	6a 01                	push   $0x1
     c2b:	e8 c0 2d 00 00       	call   39f0 <printf>
     c30:	83 c4 10             	add    $0x10,%esp
     c33:	83 ec 0c             	sub    $0xc,%esp
     c36:	ff 75 e4             	pushl  -0x1c(%ebp)
     c39:	e8 8c 2c 00 00       	call   38ca <close>
     c3e:	83 c4 10             	add    $0x10,%esp
     c41:	eb fe                	jmp    c41 <preempt+0x91>
     c43:	83 ec 0c             	sub    $0xc,%esp
     c46:	ff 75 e4             	pushl  -0x1c(%ebp)
     c49:	e8 7c 2c 00 00       	call   38ca <close>
     c4e:	83 c4 0c             	add    $0xc,%esp
     c51:	68 00 20 00 00       	push   $0x2000
     c56:	68 c0 85 00 00       	push   $0x85c0
     c5b:	ff 75 e0             	pushl  -0x20(%ebp)
     c5e:	e8 57 2c 00 00       	call   38ba <read>
     c63:	83 c4 10             	add    $0x10,%esp
     c66:	83 f8 01             	cmp    $0x1,%eax
     c69:	74 1a                	je     c85 <preempt+0xd5>
     c6b:	83 ec 08             	sub    $0x8,%esp
     c6e:	68 02 41 00 00       	push   $0x4102
     c73:	6a 01                	push   $0x1
     c75:	e8 76 2d 00 00       	call   39f0 <printf>
     c7a:	83 c4 10             	add    $0x10,%esp
     c7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c80:	5b                   	pop    %ebx
     c81:	5e                   	pop    %esi
     c82:	5f                   	pop    %edi
     c83:	5d                   	pop    %ebp
     c84:	c3                   	ret    
     c85:	83 ec 0c             	sub    $0xc,%esp
     c88:	ff 75 e0             	pushl  -0x20(%ebp)
     c8b:	e8 3a 2c 00 00       	call   38ca <close>
     c90:	58                   	pop    %eax
     c91:	5a                   	pop    %edx
     c92:	68 15 41 00 00       	push   $0x4115
     c97:	6a 01                	push   $0x1
     c99:	e8 52 2d 00 00       	call   39f0 <printf>
     c9e:	89 3c 24             	mov    %edi,(%esp)
     ca1:	e8 2c 2c 00 00       	call   38d2 <kill>
     ca6:	89 34 24             	mov    %esi,(%esp)
     ca9:	e8 24 2c 00 00       	call   38d2 <kill>
     cae:	89 1c 24             	mov    %ebx,(%esp)
     cb1:	e8 1c 2c 00 00       	call   38d2 <kill>
     cb6:	59                   	pop    %ecx
     cb7:	5b                   	pop    %ebx
     cb8:	68 1e 41 00 00       	push   $0x411e
     cbd:	6a 01                	push   $0x1
     cbf:	e8 2c 2d 00 00       	call   39f0 <printf>
     cc4:	e8 e1 2b 00 00       	call   38aa <wait>
     cc9:	e8 dc 2b 00 00       	call   38aa <wait>
     cce:	e8 d7 2b 00 00       	call   38aa <wait>
     cd3:	5e                   	pop    %esi
     cd4:	5f                   	pop    %edi
     cd5:	68 27 41 00 00       	push   $0x4127
     cda:	6a 01                	push   $0x1
     cdc:	e8 0f 2d 00 00       	call   39f0 <printf>
     ce1:	83 c4 10             	add    $0x10,%esp
     ce4:	eb 97                	jmp    c7d <preempt+0xcd>
     ce6:	8d 76 00             	lea    0x0(%esi),%esi
     ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cf0 <exitwait>:
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	56                   	push   %esi
     cf4:	be 64 00 00 00       	mov    $0x64,%esi
     cf9:	53                   	push   %ebx
     cfa:	eb 14                	jmp    d10 <exitwait+0x20>
     cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d00:	74 6f                	je     d71 <exitwait+0x81>
     d02:	e8 a3 2b 00 00       	call   38aa <wait>
     d07:	39 c3                	cmp    %eax,%ebx
     d09:	75 2d                	jne    d38 <exitwait+0x48>
     d0b:	83 ee 01             	sub    $0x1,%esi
     d0e:	74 48                	je     d58 <exitwait+0x68>
     d10:	e8 85 2b 00 00       	call   389a <fork>
     d15:	85 c0                	test   %eax,%eax
     d17:	89 c3                	mov    %eax,%ebx
     d19:	79 e5                	jns    d00 <exitwait+0x10>
     d1b:	83 ec 08             	sub    $0x8,%esp
     d1e:	68 91 4c 00 00       	push   $0x4c91
     d23:	6a 01                	push   $0x1
     d25:	e8 c6 2c 00 00       	call   39f0 <printf>
     d2a:	83 c4 10             	add    $0x10,%esp
     d2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d30:	5b                   	pop    %ebx
     d31:	5e                   	pop    %esi
     d32:	5d                   	pop    %ebp
     d33:	c3                   	ret    
     d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d38:	83 ec 08             	sub    $0x8,%esp
     d3b:	68 33 41 00 00       	push   $0x4133
     d40:	6a 01                	push   $0x1
     d42:	e8 a9 2c 00 00       	call   39f0 <printf>
     d47:	83 c4 10             	add    $0x10,%esp
     d4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d4d:	5b                   	pop    %ebx
     d4e:	5e                   	pop    %esi
     d4f:	5d                   	pop    %ebp
     d50:	c3                   	ret    
     d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 43 41 00 00       	push   $0x4143
     d60:	6a 01                	push   $0x1
     d62:	e8 89 2c 00 00       	call   39f0 <printf>
     d67:	83 c4 10             	add    $0x10,%esp
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
     d71:	e8 2c 2b 00 00       	call   38a2 <exit>
     d76:	8d 76 00             	lea    0x0(%esi),%esi
     d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d80 <mem>:
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	57                   	push   %edi
     d84:	56                   	push   %esi
     d85:	53                   	push   %ebx
     d86:	83 ec 14             	sub    $0x14,%esp
     d89:	68 50 41 00 00       	push   $0x4150
     d8e:	6a 01                	push   $0x1
     d90:	e8 5b 2c 00 00       	call   39f0 <printf>
     d95:	e8 88 2b 00 00       	call   3922 <getpid>
     d9a:	89 c6                	mov    %eax,%esi
     d9c:	e8 f9 2a 00 00       	call   389a <fork>
     da1:	83 c4 10             	add    $0x10,%esp
     da4:	85 c0                	test   %eax,%eax
     da6:	75 70                	jne    e18 <mem+0x98>
     da8:	31 db                	xor    %ebx,%ebx
     daa:	eb 08                	jmp    db4 <mem+0x34>
     dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     db0:	89 18                	mov    %ebx,(%eax)
     db2:	89 c3                	mov    %eax,%ebx
     db4:	83 ec 0c             	sub    $0xc,%esp
     db7:	68 11 27 00 00       	push   $0x2711
     dbc:	e8 af 2e 00 00       	call   3c70 <malloc>
     dc1:	83 c4 10             	add    $0x10,%esp
     dc4:	85 c0                	test   %eax,%eax
     dc6:	75 e8                	jne    db0 <mem+0x30>
     dc8:	85 db                	test   %ebx,%ebx
     dca:	74 18                	je     de4 <mem+0x64>
     dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dd0:	8b 3b                	mov    (%ebx),%edi
     dd2:	83 ec 0c             	sub    $0xc,%esp
     dd5:	53                   	push   %ebx
     dd6:	89 fb                	mov    %edi,%ebx
     dd8:	e8 03 2e 00 00       	call   3be0 <free>
     ddd:	83 c4 10             	add    $0x10,%esp
     de0:	85 db                	test   %ebx,%ebx
     de2:	75 ec                	jne    dd0 <mem+0x50>
     de4:	83 ec 0c             	sub    $0xc,%esp
     de7:	68 00 50 00 00       	push   $0x5000
     dec:	e8 7f 2e 00 00       	call   3c70 <malloc>
     df1:	83 c4 10             	add    $0x10,%esp
     df4:	85 c0                	test   %eax,%eax
     df6:	74 30                	je     e28 <mem+0xa8>
     df8:	83 ec 0c             	sub    $0xc,%esp
     dfb:	50                   	push   %eax
     dfc:	e8 df 2d 00 00       	call   3be0 <free>
     e01:	58                   	pop    %eax
     e02:	5a                   	pop    %edx
     e03:	68 74 41 00 00       	push   $0x4174
     e08:	6a 01                	push   $0x1
     e0a:	e8 e1 2b 00 00       	call   39f0 <printf>
     e0f:	e8 8e 2a 00 00       	call   38a2 <exit>
     e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e1b:	5b                   	pop    %ebx
     e1c:	5e                   	pop    %esi
     e1d:	5f                   	pop    %edi
     e1e:	5d                   	pop    %ebp
     e1f:	e9 86 2a 00 00       	jmp    38aa <wait>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 5a 41 00 00       	push   $0x415a
     e30:	6a 01                	push   $0x1
     e32:	e8 b9 2b 00 00       	call   39f0 <printf>
     e37:	89 34 24             	mov    %esi,(%esp)
     e3a:	e8 93 2a 00 00       	call   38d2 <kill>
     e3f:	e8 5e 2a 00 00       	call   38a2 <exit>
     e44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e50 <sharedfd>:
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
     e56:	83 ec 34             	sub    $0x34,%esp
     e59:	68 7c 41 00 00       	push   $0x417c
     e5e:	6a 01                	push   $0x1
     e60:	e8 8b 2b 00 00       	call   39f0 <printf>
     e65:	c7 04 24 8b 41 00 00 	movl   $0x418b,(%esp)
     e6c:	e8 81 2a 00 00       	call   38f2 <unlink>
     e71:	5b                   	pop    %ebx
     e72:	5e                   	pop    %esi
     e73:	68 02 02 00 00       	push   $0x202
     e78:	68 8b 41 00 00       	push   $0x418b
     e7d:	e8 60 2a 00 00       	call   38e2 <open>
     e82:	83 c4 10             	add    $0x10,%esp
     e85:	85 c0                	test   %eax,%eax
     e87:	0f 88 29 01 00 00    	js     fb6 <sharedfd+0x166>
     e8d:	89 c7                	mov    %eax,%edi
     e8f:	8d 75 de             	lea    -0x22(%ebp),%esi
     e92:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     e97:	e8 fe 29 00 00       	call   389a <fork>
     e9c:	83 f8 01             	cmp    $0x1,%eax
     e9f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ea2:	19 c0                	sbb    %eax,%eax
     ea4:	83 ec 04             	sub    $0x4,%esp
     ea7:	83 e0 f3             	and    $0xfffffff3,%eax
     eaa:	6a 0a                	push   $0xa
     eac:	83 c0 70             	add    $0x70,%eax
     eaf:	50                   	push   %eax
     eb0:	56                   	push   %esi
     eb1:	e8 7a 28 00 00       	call   3730 <memset>
     eb6:	83 c4 10             	add    $0x10,%esp
     eb9:	eb 0a                	jmp    ec5 <sharedfd+0x75>
     ebb:	90                   	nop
     ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ec0:	83 eb 01             	sub    $0x1,%ebx
     ec3:	74 26                	je     eeb <sharedfd+0x9b>
     ec5:	83 ec 04             	sub    $0x4,%esp
     ec8:	6a 0a                	push   $0xa
     eca:	56                   	push   %esi
     ecb:	57                   	push   %edi
     ecc:	e8 f1 29 00 00       	call   38c2 <write>
     ed1:	83 c4 10             	add    $0x10,%esp
     ed4:	83 f8 0a             	cmp    $0xa,%eax
     ed7:	74 e7                	je     ec0 <sharedfd+0x70>
     ed9:	83 ec 08             	sub    $0x8,%esp
     edc:	68 7c 4e 00 00       	push   $0x4e7c
     ee1:	6a 01                	push   $0x1
     ee3:	e8 08 2b 00 00       	call   39f0 <printf>
     ee8:	83 c4 10             	add    $0x10,%esp
     eeb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     eee:	85 c9                	test   %ecx,%ecx
     ef0:	0f 84 f4 00 00 00    	je     fea <sharedfd+0x19a>
     ef6:	e8 af 29 00 00       	call   38aa <wait>
     efb:	83 ec 0c             	sub    $0xc,%esp
     efe:	31 db                	xor    %ebx,%ebx
     f00:	57                   	push   %edi
     f01:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f04:	e8 c1 29 00 00       	call   38ca <close>
     f09:	58                   	pop    %eax
     f0a:	5a                   	pop    %edx
     f0b:	6a 00                	push   $0x0
     f0d:	68 8b 41 00 00       	push   $0x418b
     f12:	e8 cb 29 00 00       	call   38e2 <open>
     f17:	83 c4 10             	add    $0x10,%esp
     f1a:	31 d2                	xor    %edx,%edx
     f1c:	85 c0                	test   %eax,%eax
     f1e:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f21:	0f 88 a9 00 00 00    	js     fd0 <sharedfd+0x180>
     f27:	89 f6                	mov    %esi,%esi
     f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f30:	83 ec 04             	sub    $0x4,%esp
     f33:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f36:	6a 0a                	push   $0xa
     f38:	56                   	push   %esi
     f39:	ff 75 d0             	pushl  -0x30(%ebp)
     f3c:	e8 79 29 00 00       	call   38ba <read>
     f41:	83 c4 10             	add    $0x10,%esp
     f44:	85 c0                	test   %eax,%eax
     f46:	7e 27                	jle    f6f <sharedfd+0x11f>
     f48:	89 f0                	mov    %esi,%eax
     f4a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f4d:	eb 13                	jmp    f62 <sharedfd+0x112>
     f4f:	90                   	nop
     f50:	80 f9 70             	cmp    $0x70,%cl
     f53:	0f 94 c1             	sete   %cl
     f56:	0f b6 c9             	movzbl %cl,%ecx
     f59:	01 cb                	add    %ecx,%ebx
     f5b:	83 c0 01             	add    $0x1,%eax
     f5e:	39 c7                	cmp    %eax,%edi
     f60:	74 ce                	je     f30 <sharedfd+0xe0>
     f62:	0f b6 08             	movzbl (%eax),%ecx
     f65:	80 f9 63             	cmp    $0x63,%cl
     f68:	75 e6                	jne    f50 <sharedfd+0x100>
     f6a:	83 c2 01             	add    $0x1,%edx
     f6d:	eb ec                	jmp    f5b <sharedfd+0x10b>
     f6f:	83 ec 0c             	sub    $0xc,%esp
     f72:	ff 75 d0             	pushl  -0x30(%ebp)
     f75:	e8 50 29 00 00       	call   38ca <close>
     f7a:	c7 04 24 8b 41 00 00 	movl   $0x418b,(%esp)
     f81:	e8 6c 29 00 00       	call   38f2 <unlink>
     f86:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f89:	83 c4 10             	add    $0x10,%esp
     f8c:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     f92:	75 5b                	jne    fef <sharedfd+0x19f>
     f94:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f9a:	75 53                	jne    fef <sharedfd+0x19f>
     f9c:	83 ec 08             	sub    $0x8,%esp
     f9f:	68 94 41 00 00       	push   $0x4194
     fa4:	6a 01                	push   $0x1
     fa6:	e8 45 2a 00 00       	call   39f0 <printf>
     fab:	83 c4 10             	add    $0x10,%esp
     fae:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fb1:	5b                   	pop    %ebx
     fb2:	5e                   	pop    %esi
     fb3:	5f                   	pop    %edi
     fb4:	5d                   	pop    %ebp
     fb5:	c3                   	ret    
     fb6:	83 ec 08             	sub    $0x8,%esp
     fb9:	68 50 4e 00 00       	push   $0x4e50
     fbe:	6a 01                	push   $0x1
     fc0:	e8 2b 2a 00 00       	call   39f0 <printf>
     fc5:	83 c4 10             	add    $0x10,%esp
     fc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fcb:	5b                   	pop    %ebx
     fcc:	5e                   	pop    %esi
     fcd:	5f                   	pop    %edi
     fce:	5d                   	pop    %ebp
     fcf:	c3                   	ret    
     fd0:	83 ec 08             	sub    $0x8,%esp
     fd3:	68 9c 4e 00 00       	push   $0x4e9c
     fd8:	6a 01                	push   $0x1
     fda:	e8 11 2a 00 00       	call   39f0 <printf>
     fdf:	83 c4 10             	add    $0x10,%esp
     fe2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fe5:	5b                   	pop    %ebx
     fe6:	5e                   	pop    %esi
     fe7:	5f                   	pop    %edi
     fe8:	5d                   	pop    %ebp
     fe9:	c3                   	ret    
     fea:	e8 b3 28 00 00       	call   38a2 <exit>
     fef:	53                   	push   %ebx
     ff0:	52                   	push   %edx
     ff1:	68 a1 41 00 00       	push   $0x41a1
     ff6:	6a 01                	push   $0x1
     ff8:	e8 f3 29 00 00       	call   39f0 <printf>
     ffd:	e8 a0 28 00 00       	call   38a2 <exit>
    1002:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001010 <fourfiles>:
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	56                   	push   %esi
    1015:	53                   	push   %ebx
    1016:	be b6 41 00 00       	mov    $0x41b6,%esi
    101b:	31 db                	xor    %ebx,%ebx
    101d:	83 ec 34             	sub    $0x34,%esp
    1020:	c7 45 d8 b6 41 00 00 	movl   $0x41b6,-0x28(%ebp)
    1027:	c7 45 dc ff 42 00 00 	movl   $0x42ff,-0x24(%ebp)
    102e:	68 bc 41 00 00       	push   $0x41bc
    1033:	6a 01                	push   $0x1
    1035:	c7 45 e0 03 43 00 00 	movl   $0x4303,-0x20(%ebp)
    103c:	c7 45 e4 b9 41 00 00 	movl   $0x41b9,-0x1c(%ebp)
    1043:	e8 a8 29 00 00       	call   39f0 <printf>
    1048:	83 c4 10             	add    $0x10,%esp
    104b:	83 ec 0c             	sub    $0xc,%esp
    104e:	56                   	push   %esi
    104f:	e8 9e 28 00 00       	call   38f2 <unlink>
    1054:	e8 41 28 00 00       	call   389a <fork>
    1059:	83 c4 10             	add    $0x10,%esp
    105c:	85 c0                	test   %eax,%eax
    105e:	0f 88 83 01 00 00    	js     11e7 <fourfiles+0x1d7>
    1064:	0f 84 e3 00 00 00    	je     114d <fourfiles+0x13d>
    106a:	83 c3 01             	add    $0x1,%ebx
    106d:	83 fb 04             	cmp    $0x4,%ebx
    1070:	74 06                	je     1078 <fourfiles+0x68>
    1072:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1076:	eb d3                	jmp    104b <fourfiles+0x3b>
    1078:	e8 2d 28 00 00       	call   38aa <wait>
    107d:	bf 30 00 00 00       	mov    $0x30,%edi
    1082:	e8 23 28 00 00       	call   38aa <wait>
    1087:	e8 1e 28 00 00       	call   38aa <wait>
    108c:	e8 19 28 00 00       	call   38aa <wait>
    1091:	c7 45 d4 b6 41 00 00 	movl   $0x41b6,-0x2c(%ebp)
    1098:	83 ec 08             	sub    $0x8,%esp
    109b:	31 db                	xor    %ebx,%ebx
    109d:	6a 00                	push   $0x0
    109f:	ff 75 d4             	pushl  -0x2c(%ebp)
    10a2:	e8 3b 28 00 00       	call   38e2 <open>
    10a7:	83 c4 10             	add    $0x10,%esp
    10aa:	89 c6                	mov    %eax,%esi
    10ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10b0:	83 ec 04             	sub    $0x4,%esp
    10b3:	68 00 20 00 00       	push   $0x2000
    10b8:	68 c0 85 00 00       	push   $0x85c0
    10bd:	56                   	push   %esi
    10be:	e8 f7 27 00 00       	call   38ba <read>
    10c3:	83 c4 10             	add    $0x10,%esp
    10c6:	85 c0                	test   %eax,%eax
    10c8:	7e 1c                	jle    10e6 <fourfiles+0xd6>
    10ca:	31 d2                	xor    %edx,%edx
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10d0:	0f be 8a c0 85 00 00 	movsbl 0x85c0(%edx),%ecx
    10d7:	39 cf                	cmp    %ecx,%edi
    10d9:	75 5e                	jne    1139 <fourfiles+0x129>
    10db:	83 c2 01             	add    $0x1,%edx
    10de:	39 d0                	cmp    %edx,%eax
    10e0:	75 ee                	jne    10d0 <fourfiles+0xc0>
    10e2:	01 c3                	add    %eax,%ebx
    10e4:	eb ca                	jmp    10b0 <fourfiles+0xa0>
    10e6:	83 ec 0c             	sub    $0xc,%esp
    10e9:	56                   	push   %esi
    10ea:	e8 db 27 00 00       	call   38ca <close>
    10ef:	83 c4 10             	add    $0x10,%esp
    10f2:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    10f8:	0f 85 d4 00 00 00    	jne    11d2 <fourfiles+0x1c2>
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	pushl  -0x2c(%ebp)
    1104:	83 c7 01             	add    $0x1,%edi
    1107:	e8 e6 27 00 00       	call   38f2 <unlink>
    110c:	83 c4 10             	add    $0x10,%esp
    110f:	83 ff 32             	cmp    $0x32,%edi
    1112:	75 1a                	jne    112e <fourfiles+0x11e>
    1114:	83 ec 08             	sub    $0x8,%esp
    1117:	68 fa 41 00 00       	push   $0x41fa
    111c:	6a 01                	push   $0x1
    111e:	e8 cd 28 00 00       	call   39f0 <printf>
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1129:	5b                   	pop    %ebx
    112a:	5e                   	pop    %esi
    112b:	5f                   	pop    %edi
    112c:	5d                   	pop    %ebp
    112d:	c3                   	ret    
    112e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1131:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1134:	e9 5f ff ff ff       	jmp    1098 <fourfiles+0x88>
    1139:	83 ec 08             	sub    $0x8,%esp
    113c:	68 dd 41 00 00       	push   $0x41dd
    1141:	6a 01                	push   $0x1
    1143:	e8 a8 28 00 00       	call   39f0 <printf>
    1148:	e8 55 27 00 00       	call   38a2 <exit>
    114d:	83 ec 08             	sub    $0x8,%esp
    1150:	68 02 02 00 00       	push   $0x202
    1155:	56                   	push   %esi
    1156:	e8 87 27 00 00       	call   38e2 <open>
    115b:	83 c4 10             	add    $0x10,%esp
    115e:	85 c0                	test   %eax,%eax
    1160:	89 c6                	mov    %eax,%esi
    1162:	78 5a                	js     11be <fourfiles+0x1ae>
    1164:	83 ec 04             	sub    $0x4,%esp
    1167:	83 c3 30             	add    $0x30,%ebx
    116a:	68 00 02 00 00       	push   $0x200
    116f:	53                   	push   %ebx
    1170:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1175:	68 c0 85 00 00       	push   $0x85c0
    117a:	e8 b1 25 00 00       	call   3730 <memset>
    117f:	83 c4 10             	add    $0x10,%esp
    1182:	83 ec 04             	sub    $0x4,%esp
    1185:	68 f4 01 00 00       	push   $0x1f4
    118a:	68 c0 85 00 00       	push   $0x85c0
    118f:	56                   	push   %esi
    1190:	e8 2d 27 00 00       	call   38c2 <write>
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    119d:	75 0a                	jne    11a9 <fourfiles+0x199>
    119f:	83 eb 01             	sub    $0x1,%ebx
    11a2:	75 de                	jne    1182 <fourfiles+0x172>
    11a4:	e8 f9 26 00 00       	call   38a2 <exit>
    11a9:	83 ec 04             	sub    $0x4,%esp
    11ac:	50                   	push   %eax
    11ad:	68 cc 41 00 00       	push   $0x41cc
    11b2:	6a 01                	push   $0x1
    11b4:	e8 37 28 00 00       	call   39f0 <printf>
    11b9:	e8 e4 26 00 00       	call   38a2 <exit>
    11be:	83 ec 08             	sub    $0x8,%esp
    11c1:	68 57 44 00 00       	push   $0x4457
    11c6:	6a 01                	push   $0x1
    11c8:	e8 23 28 00 00       	call   39f0 <printf>
    11cd:	e8 d0 26 00 00       	call   38a2 <exit>
    11d2:	83 ec 04             	sub    $0x4,%esp
    11d5:	53                   	push   %ebx
    11d6:	68 e9 41 00 00       	push   $0x41e9
    11db:	6a 01                	push   $0x1
    11dd:	e8 0e 28 00 00       	call   39f0 <printf>
    11e2:	e8 bb 26 00 00       	call   38a2 <exit>
    11e7:	83 ec 08             	sub    $0x8,%esp
    11ea:	68 91 4c 00 00       	push   $0x4c91
    11ef:	6a 01                	push   $0x1
    11f1:	e8 fa 27 00 00       	call   39f0 <printf>
    11f6:	e8 a7 26 00 00       	call   38a2 <exit>
    11fb:	90                   	nop
    11fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001200 <createdelete>:
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
    1205:	53                   	push   %ebx
    1206:	31 db                	xor    %ebx,%ebx
    1208:	83 ec 44             	sub    $0x44,%esp
    120b:	68 08 42 00 00       	push   $0x4208
    1210:	6a 01                	push   $0x1
    1212:	e8 d9 27 00 00       	call   39f0 <printf>
    1217:	83 c4 10             	add    $0x10,%esp
    121a:	e8 7b 26 00 00       	call   389a <fork>
    121f:	85 c0                	test   %eax,%eax
    1221:	0f 88 b7 01 00 00    	js     13de <createdelete+0x1de>
    1227:	0f 84 f6 00 00 00    	je     1323 <createdelete+0x123>
    122d:	83 c3 01             	add    $0x1,%ebx
    1230:	83 fb 04             	cmp    $0x4,%ebx
    1233:	75 e5                	jne    121a <createdelete+0x1a>
    1235:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1238:	31 f6                	xor    %esi,%esi
    123a:	e8 6b 26 00 00       	call   38aa <wait>
    123f:	e8 66 26 00 00       	call   38aa <wait>
    1244:	e8 61 26 00 00       	call   38aa <wait>
    1249:	e8 5c 26 00 00       	call   38aa <wait>
    124e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1258:	8d 46 30             	lea    0x30(%esi),%eax
    125b:	83 fe 09             	cmp    $0x9,%esi
    125e:	bb 70 00 00 00       	mov    $0x70,%ebx
    1263:	0f 9f c2             	setg   %dl
    1266:	85 f6                	test   %esi,%esi
    1268:	88 45 c7             	mov    %al,-0x39(%ebp)
    126b:	0f 94 c0             	sete   %al
    126e:	09 c2                	or     %eax,%edx
    1270:	8d 46 ff             	lea    -0x1(%esi),%eax
    1273:	88 55 c6             	mov    %dl,-0x3a(%ebp)
    1276:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1279:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    127d:	83 ec 08             	sub    $0x8,%esp
    1280:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1283:	6a 00                	push   $0x0
    1285:	57                   	push   %edi
    1286:	88 45 c9             	mov    %al,-0x37(%ebp)
    1289:	e8 54 26 00 00       	call   38e2 <open>
    128e:	89 c1                	mov    %eax,%ecx
    1290:	83 c4 10             	add    $0x10,%esp
    1293:	c1 e9 1f             	shr    $0x1f,%ecx
    1296:	84 c9                	test   %cl,%cl
    1298:	74 0a                	je     12a4 <createdelete+0xa4>
    129a:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    129e:	0f 85 11 01 00 00    	jne    13b5 <createdelete+0x1b5>
    12a4:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    12a8:	0f 86 44 01 00 00    	jbe    13f2 <createdelete+0x1f2>
    12ae:	85 c0                	test   %eax,%eax
    12b0:	78 0c                	js     12be <createdelete+0xbe>
    12b2:	83 ec 0c             	sub    $0xc,%esp
    12b5:	50                   	push   %eax
    12b6:	e8 0f 26 00 00       	call   38ca <close>
    12bb:	83 c4 10             	add    $0x10,%esp
    12be:	83 c3 01             	add    $0x1,%ebx
    12c1:	80 fb 74             	cmp    $0x74,%bl
    12c4:	75 b3                	jne    1279 <createdelete+0x79>
    12c6:	83 c6 01             	add    $0x1,%esi
    12c9:	83 fe 14             	cmp    $0x14,%esi
    12cc:	75 8a                	jne    1258 <createdelete+0x58>
    12ce:	be 70 00 00 00       	mov    $0x70,%esi
    12d3:	90                   	nop
    12d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12d8:	8d 46 c0             	lea    -0x40(%esi),%eax
    12db:	bb 04 00 00 00       	mov    $0x4,%ebx
    12e0:	88 45 c7             	mov    %al,-0x39(%ebp)
    12e3:	89 f0                	mov    %esi,%eax
    12e5:	83 ec 0c             	sub    $0xc,%esp
    12e8:	88 45 c8             	mov    %al,-0x38(%ebp)
    12eb:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    12ef:	57                   	push   %edi
    12f0:	88 45 c9             	mov    %al,-0x37(%ebp)
    12f3:	e8 fa 25 00 00       	call   38f2 <unlink>
    12f8:	83 c4 10             	add    $0x10,%esp
    12fb:	83 eb 01             	sub    $0x1,%ebx
    12fe:	75 e3                	jne    12e3 <createdelete+0xe3>
    1300:	83 c6 01             	add    $0x1,%esi
    1303:	89 f0                	mov    %esi,%eax
    1305:	3c 84                	cmp    $0x84,%al
    1307:	75 cf                	jne    12d8 <createdelete+0xd8>
    1309:	83 ec 08             	sub    $0x8,%esp
    130c:	68 1b 42 00 00       	push   $0x421b
    1311:	6a 01                	push   $0x1
    1313:	e8 d8 26 00 00       	call   39f0 <printf>
    1318:	83 c4 10             	add    $0x10,%esp
    131b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    131e:	5b                   	pop    %ebx
    131f:	5e                   	pop    %esi
    1320:	5f                   	pop    %edi
    1321:	5d                   	pop    %ebp
    1322:	c3                   	ret    
    1323:	83 c3 70             	add    $0x70,%ebx
    1326:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    132a:	be 01 00 00 00       	mov    $0x1,%esi
    132f:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1332:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1335:	31 db                	xor    %ebx,%ebx
    1337:	eb 12                	jmp    134b <createdelete+0x14b>
    1339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1340:	83 fe 14             	cmp    $0x14,%esi
    1343:	74 6b                	je     13b0 <createdelete+0x1b0>
    1345:	83 c3 01             	add    $0x1,%ebx
    1348:	83 c6 01             	add    $0x1,%esi
    134b:	83 ec 08             	sub    $0x8,%esp
    134e:	8d 43 30             	lea    0x30(%ebx),%eax
    1351:	68 02 02 00 00       	push   $0x202
    1356:	57                   	push   %edi
    1357:	88 45 c9             	mov    %al,-0x37(%ebp)
    135a:	e8 83 25 00 00       	call   38e2 <open>
    135f:	83 c4 10             	add    $0x10,%esp
    1362:	85 c0                	test   %eax,%eax
    1364:	78 64                	js     13ca <createdelete+0x1ca>
    1366:	83 ec 0c             	sub    $0xc,%esp
    1369:	50                   	push   %eax
    136a:	e8 5b 25 00 00       	call   38ca <close>
    136f:	83 c4 10             	add    $0x10,%esp
    1372:	85 db                	test   %ebx,%ebx
    1374:	74 cf                	je     1345 <createdelete+0x145>
    1376:	f6 c3 01             	test   $0x1,%bl
    1379:	75 c5                	jne    1340 <createdelete+0x140>
    137b:	83 ec 0c             	sub    $0xc,%esp
    137e:	89 d8                	mov    %ebx,%eax
    1380:	d1 f8                	sar    %eax
    1382:	57                   	push   %edi
    1383:	83 c0 30             	add    $0x30,%eax
    1386:	88 45 c9             	mov    %al,-0x37(%ebp)
    1389:	e8 64 25 00 00       	call   38f2 <unlink>
    138e:	83 c4 10             	add    $0x10,%esp
    1391:	85 c0                	test   %eax,%eax
    1393:	79 ab                	jns    1340 <createdelete+0x140>
    1395:	83 ec 08             	sub    $0x8,%esp
    1398:	68 09 3e 00 00       	push   $0x3e09
    139d:	6a 01                	push   $0x1
    139f:	e8 4c 26 00 00       	call   39f0 <printf>
    13a4:	e8 f9 24 00 00       	call   38a2 <exit>
    13a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13b0:	e8 ed 24 00 00       	call   38a2 <exit>
    13b5:	83 ec 04             	sub    $0x4,%esp
    13b8:	57                   	push   %edi
    13b9:	68 c8 4e 00 00       	push   $0x4ec8
    13be:	6a 01                	push   $0x1
    13c0:	e8 2b 26 00 00       	call   39f0 <printf>
    13c5:	e8 d8 24 00 00       	call   38a2 <exit>
    13ca:	83 ec 08             	sub    $0x8,%esp
    13cd:	68 57 44 00 00       	push   $0x4457
    13d2:	6a 01                	push   $0x1
    13d4:	e8 17 26 00 00       	call   39f0 <printf>
    13d9:	e8 c4 24 00 00       	call   38a2 <exit>
    13de:	83 ec 08             	sub    $0x8,%esp
    13e1:	68 91 4c 00 00       	push   $0x4c91
    13e6:	6a 01                	push   $0x1
    13e8:	e8 03 26 00 00       	call   39f0 <printf>
    13ed:	e8 b0 24 00 00       	call   38a2 <exit>
    13f2:	85 c0                	test   %eax,%eax
    13f4:	0f 88 c4 fe ff ff    	js     12be <createdelete+0xbe>
    13fa:	83 ec 04             	sub    $0x4,%esp
    13fd:	57                   	push   %edi
    13fe:	68 ec 4e 00 00       	push   $0x4eec
    1403:	6a 01                	push   $0x1
    1405:	e8 e6 25 00 00       	call   39f0 <printf>
    140a:	e8 93 24 00 00       	call   38a2 <exit>
    140f:	90                   	nop

00001410 <unlinkread>:
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	56                   	push   %esi
    1414:	53                   	push   %ebx
    1415:	83 ec 08             	sub    $0x8,%esp
    1418:	68 2c 42 00 00       	push   $0x422c
    141d:	6a 01                	push   $0x1
    141f:	e8 cc 25 00 00       	call   39f0 <printf>
    1424:	5b                   	pop    %ebx
    1425:	5e                   	pop    %esi
    1426:	68 02 02 00 00       	push   $0x202
    142b:	68 3d 42 00 00       	push   $0x423d
    1430:	e8 ad 24 00 00       	call   38e2 <open>
    1435:	83 c4 10             	add    $0x10,%esp
    1438:	85 c0                	test   %eax,%eax
    143a:	0f 88 e6 00 00 00    	js     1526 <unlinkread+0x116>
    1440:	83 ec 04             	sub    $0x4,%esp
    1443:	89 c3                	mov    %eax,%ebx
    1445:	6a 05                	push   $0x5
    1447:	68 62 42 00 00       	push   $0x4262
    144c:	50                   	push   %eax
    144d:	e8 70 24 00 00       	call   38c2 <write>
    1452:	89 1c 24             	mov    %ebx,(%esp)
    1455:	e8 70 24 00 00       	call   38ca <close>
    145a:	58                   	pop    %eax
    145b:	5a                   	pop    %edx
    145c:	6a 02                	push   $0x2
    145e:	68 3d 42 00 00       	push   $0x423d
    1463:	e8 7a 24 00 00       	call   38e2 <open>
    1468:	83 c4 10             	add    $0x10,%esp
    146b:	85 c0                	test   %eax,%eax
    146d:	89 c3                	mov    %eax,%ebx
    146f:	0f 88 10 01 00 00    	js     1585 <unlinkread+0x175>
    1475:	83 ec 0c             	sub    $0xc,%esp
    1478:	68 3d 42 00 00       	push   $0x423d
    147d:	e8 70 24 00 00       	call   38f2 <unlink>
    1482:	83 c4 10             	add    $0x10,%esp
    1485:	85 c0                	test   %eax,%eax
    1487:	0f 85 e5 00 00 00    	jne    1572 <unlinkread+0x162>
    148d:	83 ec 08             	sub    $0x8,%esp
    1490:	68 02 02 00 00       	push   $0x202
    1495:	68 3d 42 00 00       	push   $0x423d
    149a:	e8 43 24 00 00       	call   38e2 <open>
    149f:	83 c4 0c             	add    $0xc,%esp
    14a2:	89 c6                	mov    %eax,%esi
    14a4:	6a 03                	push   $0x3
    14a6:	68 9a 42 00 00       	push   $0x429a
    14ab:	50                   	push   %eax
    14ac:	e8 11 24 00 00       	call   38c2 <write>
    14b1:	89 34 24             	mov    %esi,(%esp)
    14b4:	e8 11 24 00 00       	call   38ca <close>
    14b9:	83 c4 0c             	add    $0xc,%esp
    14bc:	68 00 20 00 00       	push   $0x2000
    14c1:	68 c0 85 00 00       	push   $0x85c0
    14c6:	53                   	push   %ebx
    14c7:	e8 ee 23 00 00       	call   38ba <read>
    14cc:	83 c4 10             	add    $0x10,%esp
    14cf:	83 f8 05             	cmp    $0x5,%eax
    14d2:	0f 85 87 00 00 00    	jne    155f <unlinkread+0x14f>
    14d8:	80 3d c0 85 00 00 68 	cmpb   $0x68,0x85c0
    14df:	75 6b                	jne    154c <unlinkread+0x13c>
    14e1:	83 ec 04             	sub    $0x4,%esp
    14e4:	6a 0a                	push   $0xa
    14e6:	68 c0 85 00 00       	push   $0x85c0
    14eb:	53                   	push   %ebx
    14ec:	e8 d1 23 00 00       	call   38c2 <write>
    14f1:	83 c4 10             	add    $0x10,%esp
    14f4:	83 f8 0a             	cmp    $0xa,%eax
    14f7:	75 40                	jne    1539 <unlinkread+0x129>
    14f9:	83 ec 0c             	sub    $0xc,%esp
    14fc:	53                   	push   %ebx
    14fd:	e8 c8 23 00 00       	call   38ca <close>
    1502:	c7 04 24 3d 42 00 00 	movl   $0x423d,(%esp)
    1509:	e8 e4 23 00 00       	call   38f2 <unlink>
    150e:	58                   	pop    %eax
    150f:	5a                   	pop    %edx
    1510:	68 e5 42 00 00       	push   $0x42e5
    1515:	6a 01                	push   $0x1
    1517:	e8 d4 24 00 00       	call   39f0 <printf>
    151c:	83 c4 10             	add    $0x10,%esp
    151f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1522:	5b                   	pop    %ebx
    1523:	5e                   	pop    %esi
    1524:	5d                   	pop    %ebp
    1525:	c3                   	ret    
    1526:	51                   	push   %ecx
    1527:	51                   	push   %ecx
    1528:	68 48 42 00 00       	push   $0x4248
    152d:	6a 01                	push   $0x1
    152f:	e8 bc 24 00 00       	call   39f0 <printf>
    1534:	e8 69 23 00 00       	call   38a2 <exit>
    1539:	51                   	push   %ecx
    153a:	51                   	push   %ecx
    153b:	68 cc 42 00 00       	push   $0x42cc
    1540:	6a 01                	push   $0x1
    1542:	e8 a9 24 00 00       	call   39f0 <printf>
    1547:	e8 56 23 00 00       	call   38a2 <exit>
    154c:	53                   	push   %ebx
    154d:	53                   	push   %ebx
    154e:	68 b5 42 00 00       	push   $0x42b5
    1553:	6a 01                	push   $0x1
    1555:	e8 96 24 00 00       	call   39f0 <printf>
    155a:	e8 43 23 00 00       	call   38a2 <exit>
    155f:	56                   	push   %esi
    1560:	56                   	push   %esi
    1561:	68 9e 42 00 00       	push   $0x429e
    1566:	6a 01                	push   $0x1
    1568:	e8 83 24 00 00       	call   39f0 <printf>
    156d:	e8 30 23 00 00       	call   38a2 <exit>
    1572:	50                   	push   %eax
    1573:	50                   	push   %eax
    1574:	68 80 42 00 00       	push   $0x4280
    1579:	6a 01                	push   $0x1
    157b:	e8 70 24 00 00       	call   39f0 <printf>
    1580:	e8 1d 23 00 00       	call   38a2 <exit>
    1585:	50                   	push   %eax
    1586:	50                   	push   %eax
    1587:	68 68 42 00 00       	push   $0x4268
    158c:	6a 01                	push   $0x1
    158e:	e8 5d 24 00 00       	call   39f0 <printf>
    1593:	e8 0a 23 00 00       	call   38a2 <exit>
    1598:	90                   	nop
    1599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015a0 <linktest>:
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	53                   	push   %ebx
    15a4:	83 ec 0c             	sub    $0xc,%esp
    15a7:	68 f4 42 00 00       	push   $0x42f4
    15ac:	6a 01                	push   $0x1
    15ae:	e8 3d 24 00 00       	call   39f0 <printf>
    15b3:	c7 04 24 fe 42 00 00 	movl   $0x42fe,(%esp)
    15ba:	e8 33 23 00 00       	call   38f2 <unlink>
    15bf:	c7 04 24 02 43 00 00 	movl   $0x4302,(%esp)
    15c6:	e8 27 23 00 00       	call   38f2 <unlink>
    15cb:	58                   	pop    %eax
    15cc:	5a                   	pop    %edx
    15cd:	68 02 02 00 00       	push   $0x202
    15d2:	68 fe 42 00 00       	push   $0x42fe
    15d7:	e8 06 23 00 00       	call   38e2 <open>
    15dc:	83 c4 10             	add    $0x10,%esp
    15df:	85 c0                	test   %eax,%eax
    15e1:	0f 88 1e 01 00 00    	js     1705 <linktest+0x165>
    15e7:	83 ec 04             	sub    $0x4,%esp
    15ea:	89 c3                	mov    %eax,%ebx
    15ec:	6a 05                	push   $0x5
    15ee:	68 62 42 00 00       	push   $0x4262
    15f3:	50                   	push   %eax
    15f4:	e8 c9 22 00 00       	call   38c2 <write>
    15f9:	83 c4 10             	add    $0x10,%esp
    15fc:	83 f8 05             	cmp    $0x5,%eax
    15ff:	0f 85 98 01 00 00    	jne    179d <linktest+0x1fd>
    1605:	83 ec 0c             	sub    $0xc,%esp
    1608:	53                   	push   %ebx
    1609:	e8 bc 22 00 00       	call   38ca <close>
    160e:	5b                   	pop    %ebx
    160f:	58                   	pop    %eax
    1610:	68 02 43 00 00       	push   $0x4302
    1615:	68 fe 42 00 00       	push   $0x42fe
    161a:	e8 e3 22 00 00       	call   3902 <link>
    161f:	83 c4 10             	add    $0x10,%esp
    1622:	85 c0                	test   %eax,%eax
    1624:	0f 88 60 01 00 00    	js     178a <linktest+0x1ea>
    162a:	83 ec 0c             	sub    $0xc,%esp
    162d:	68 fe 42 00 00       	push   $0x42fe
    1632:	e8 bb 22 00 00       	call   38f2 <unlink>
    1637:	58                   	pop    %eax
    1638:	5a                   	pop    %edx
    1639:	6a 00                	push   $0x0
    163b:	68 fe 42 00 00       	push   $0x42fe
    1640:	e8 9d 22 00 00       	call   38e2 <open>
    1645:	83 c4 10             	add    $0x10,%esp
    1648:	85 c0                	test   %eax,%eax
    164a:	0f 89 27 01 00 00    	jns    1777 <linktest+0x1d7>
    1650:	83 ec 08             	sub    $0x8,%esp
    1653:	6a 00                	push   $0x0
    1655:	68 02 43 00 00       	push   $0x4302
    165a:	e8 83 22 00 00       	call   38e2 <open>
    165f:	83 c4 10             	add    $0x10,%esp
    1662:	85 c0                	test   %eax,%eax
    1664:	89 c3                	mov    %eax,%ebx
    1666:	0f 88 f8 00 00 00    	js     1764 <linktest+0x1c4>
    166c:	83 ec 04             	sub    $0x4,%esp
    166f:	68 00 20 00 00       	push   $0x2000
    1674:	68 c0 85 00 00       	push   $0x85c0
    1679:	50                   	push   %eax
    167a:	e8 3b 22 00 00       	call   38ba <read>
    167f:	83 c4 10             	add    $0x10,%esp
    1682:	83 f8 05             	cmp    $0x5,%eax
    1685:	0f 85 c6 00 00 00    	jne    1751 <linktest+0x1b1>
    168b:	83 ec 0c             	sub    $0xc,%esp
    168e:	53                   	push   %ebx
    168f:	e8 36 22 00 00       	call   38ca <close>
    1694:	58                   	pop    %eax
    1695:	5a                   	pop    %edx
    1696:	68 02 43 00 00       	push   $0x4302
    169b:	68 02 43 00 00       	push   $0x4302
    16a0:	e8 5d 22 00 00       	call   3902 <link>
    16a5:	83 c4 10             	add    $0x10,%esp
    16a8:	85 c0                	test   %eax,%eax
    16aa:	0f 89 8e 00 00 00    	jns    173e <linktest+0x19e>
    16b0:	83 ec 0c             	sub    $0xc,%esp
    16b3:	68 02 43 00 00       	push   $0x4302
    16b8:	e8 35 22 00 00       	call   38f2 <unlink>
    16bd:	59                   	pop    %ecx
    16be:	5b                   	pop    %ebx
    16bf:	68 fe 42 00 00       	push   $0x42fe
    16c4:	68 02 43 00 00       	push   $0x4302
    16c9:	e8 34 22 00 00       	call   3902 <link>
    16ce:	83 c4 10             	add    $0x10,%esp
    16d1:	85 c0                	test   %eax,%eax
    16d3:	79 56                	jns    172b <linktest+0x18b>
    16d5:	83 ec 08             	sub    $0x8,%esp
    16d8:	68 fe 42 00 00       	push   $0x42fe
    16dd:	68 c6 45 00 00       	push   $0x45c6
    16e2:	e8 1b 22 00 00       	call   3902 <link>
    16e7:	83 c4 10             	add    $0x10,%esp
    16ea:	85 c0                	test   %eax,%eax
    16ec:	79 2a                	jns    1718 <linktest+0x178>
    16ee:	83 ec 08             	sub    $0x8,%esp
    16f1:	68 9c 43 00 00       	push   $0x439c
    16f6:	6a 01                	push   $0x1
    16f8:	e8 f3 22 00 00       	call   39f0 <printf>
    16fd:	83 c4 10             	add    $0x10,%esp
    1700:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1703:	c9                   	leave  
    1704:	c3                   	ret    
    1705:	50                   	push   %eax
    1706:	50                   	push   %eax
    1707:	68 06 43 00 00       	push   $0x4306
    170c:	6a 01                	push   $0x1
    170e:	e8 dd 22 00 00       	call   39f0 <printf>
    1713:	e8 8a 21 00 00       	call   38a2 <exit>
    1718:	50                   	push   %eax
    1719:	50                   	push   %eax
    171a:	68 80 43 00 00       	push   $0x4380
    171f:	6a 01                	push   $0x1
    1721:	e8 ca 22 00 00       	call   39f0 <printf>
    1726:	e8 77 21 00 00       	call   38a2 <exit>
    172b:	52                   	push   %edx
    172c:	52                   	push   %edx
    172d:	68 34 4f 00 00       	push   $0x4f34
    1732:	6a 01                	push   $0x1
    1734:	e8 b7 22 00 00       	call   39f0 <printf>
    1739:	e8 64 21 00 00       	call   38a2 <exit>
    173e:	50                   	push   %eax
    173f:	50                   	push   %eax
    1740:	68 62 43 00 00       	push   $0x4362
    1745:	6a 01                	push   $0x1
    1747:	e8 a4 22 00 00       	call   39f0 <printf>
    174c:	e8 51 21 00 00       	call   38a2 <exit>
    1751:	51                   	push   %ecx
    1752:	51                   	push   %ecx
    1753:	68 51 43 00 00       	push   $0x4351
    1758:	6a 01                	push   $0x1
    175a:	e8 91 22 00 00       	call   39f0 <printf>
    175f:	e8 3e 21 00 00       	call   38a2 <exit>
    1764:	53                   	push   %ebx
    1765:	53                   	push   %ebx
    1766:	68 40 43 00 00       	push   $0x4340
    176b:	6a 01                	push   $0x1
    176d:	e8 7e 22 00 00       	call   39f0 <printf>
    1772:	e8 2b 21 00 00       	call   38a2 <exit>
    1777:	50                   	push   %eax
    1778:	50                   	push   %eax
    1779:	68 0c 4f 00 00       	push   $0x4f0c
    177e:	6a 01                	push   $0x1
    1780:	e8 6b 22 00 00       	call   39f0 <printf>
    1785:	e8 18 21 00 00       	call   38a2 <exit>
    178a:	51                   	push   %ecx
    178b:	51                   	push   %ecx
    178c:	68 2b 43 00 00       	push   $0x432b
    1791:	6a 01                	push   $0x1
    1793:	e8 58 22 00 00       	call   39f0 <printf>
    1798:	e8 05 21 00 00       	call   38a2 <exit>
    179d:	50                   	push   %eax
    179e:	50                   	push   %eax
    179f:	68 19 43 00 00       	push   $0x4319
    17a4:	6a 01                	push   $0x1
    17a6:	e8 45 22 00 00       	call   39f0 <printf>
    17ab:	e8 f2 20 00 00       	call   38a2 <exit>

000017b0 <concreate>:
    17b0:	55                   	push   %ebp
    17b1:	89 e5                	mov    %esp,%ebp
    17b3:	57                   	push   %edi
    17b4:	56                   	push   %esi
    17b5:	53                   	push   %ebx
    17b6:	31 f6                	xor    %esi,%esi
    17b8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17bb:	bf 56 55 55 55       	mov    $0x55555556,%edi
    17c0:	83 ec 64             	sub    $0x64,%esp
    17c3:	68 a9 43 00 00       	push   $0x43a9
    17c8:	6a 01                	push   $0x1
    17ca:	e8 21 22 00 00       	call   39f0 <printf>
    17cf:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
    17d3:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    17d7:	83 c4 10             	add    $0x10,%esp
    17da:	eb 51                	jmp    182d <concreate+0x7d>
    17dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    17e0:	89 f0                	mov    %esi,%eax
    17e2:	89 f1                	mov    %esi,%ecx
    17e4:	f7 ef                	imul   %edi
    17e6:	89 f0                	mov    %esi,%eax
    17e8:	c1 f8 1f             	sar    $0x1f,%eax
    17eb:	29 c2                	sub    %eax,%edx
    17ed:	8d 04 52             	lea    (%edx,%edx,2),%eax
    17f0:	29 c1                	sub    %eax,%ecx
    17f2:	83 f9 01             	cmp    $0x1,%ecx
    17f5:	0f 84 b5 00 00 00    	je     18b0 <concreate+0x100>
    17fb:	83 ec 08             	sub    $0x8,%esp
    17fe:	68 02 02 00 00       	push   $0x202
    1803:	53                   	push   %ebx
    1804:	e8 d9 20 00 00       	call   38e2 <open>
    1809:	83 c4 10             	add    $0x10,%esp
    180c:	85 c0                	test   %eax,%eax
    180e:	78 6d                	js     187d <concreate+0xcd>
    1810:	83 ec 0c             	sub    $0xc,%esp
    1813:	83 c6 01             	add    $0x1,%esi
    1816:	50                   	push   %eax
    1817:	e8 ae 20 00 00       	call   38ca <close>
    181c:	83 c4 10             	add    $0x10,%esp
    181f:	e8 86 20 00 00       	call   38aa <wait>
    1824:	83 fe 28             	cmp    $0x28,%esi
    1827:	0f 84 ab 00 00 00    	je     18d8 <concreate+0x128>
    182d:	83 ec 0c             	sub    $0xc,%esp
    1830:	8d 46 30             	lea    0x30(%esi),%eax
    1833:	53                   	push   %ebx
    1834:	88 45 ae             	mov    %al,-0x52(%ebp)
    1837:	e8 b6 20 00 00       	call   38f2 <unlink>
    183c:	e8 59 20 00 00       	call   389a <fork>
    1841:	83 c4 10             	add    $0x10,%esp
    1844:	85 c0                	test   %eax,%eax
    1846:	75 98                	jne    17e0 <concreate+0x30>
    1848:	89 f0                	mov    %esi,%eax
    184a:	ba 67 66 66 66       	mov    $0x66666667,%edx
    184f:	f7 ea                	imul   %edx
    1851:	89 f0                	mov    %esi,%eax
    1853:	c1 f8 1f             	sar    $0x1f,%eax
    1856:	d1 fa                	sar    %edx
    1858:	29 c2                	sub    %eax,%edx
    185a:	8d 04 92             	lea    (%edx,%edx,4),%eax
    185d:	29 c6                	sub    %eax,%esi
    185f:	83 fe 01             	cmp    $0x1,%esi
    1862:	74 34                	je     1898 <concreate+0xe8>
    1864:	83 ec 08             	sub    $0x8,%esp
    1867:	68 02 02 00 00       	push   $0x202
    186c:	53                   	push   %ebx
    186d:	e8 70 20 00 00       	call   38e2 <open>
    1872:	83 c4 10             	add    $0x10,%esp
    1875:	85 c0                	test   %eax,%eax
    1877:	0f 89 32 02 00 00    	jns    1aaf <concreate+0x2ff>
    187d:	83 ec 04             	sub    $0x4,%esp
    1880:	53                   	push   %ebx
    1881:	68 bc 43 00 00       	push   $0x43bc
    1886:	6a 01                	push   $0x1
    1888:	e8 63 21 00 00       	call   39f0 <printf>
    188d:	e8 10 20 00 00       	call   38a2 <exit>
    1892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1898:	83 ec 08             	sub    $0x8,%esp
    189b:	53                   	push   %ebx
    189c:	68 b9 43 00 00       	push   $0x43b9
    18a1:	e8 5c 20 00 00       	call   3902 <link>
    18a6:	83 c4 10             	add    $0x10,%esp
    18a9:	e8 f4 1f 00 00       	call   38a2 <exit>
    18ae:	66 90                	xchg   %ax,%ax
    18b0:	83 ec 08             	sub    $0x8,%esp
    18b3:	83 c6 01             	add    $0x1,%esi
    18b6:	53                   	push   %ebx
    18b7:	68 b9 43 00 00       	push   $0x43b9
    18bc:	e8 41 20 00 00       	call   3902 <link>
    18c1:	83 c4 10             	add    $0x10,%esp
    18c4:	e8 e1 1f 00 00       	call   38aa <wait>
    18c9:	83 fe 28             	cmp    $0x28,%esi
    18cc:	0f 85 5b ff ff ff    	jne    182d <concreate+0x7d>
    18d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    18d8:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18db:	83 ec 04             	sub    $0x4,%esp
    18de:	8d 7d b0             	lea    -0x50(%ebp),%edi
    18e1:	6a 28                	push   $0x28
    18e3:	6a 00                	push   $0x0
    18e5:	50                   	push   %eax
    18e6:	e8 45 1e 00 00       	call   3730 <memset>
    18eb:	59                   	pop    %ecx
    18ec:	5e                   	pop    %esi
    18ed:	6a 00                	push   $0x0
    18ef:	68 c6 45 00 00       	push   $0x45c6
    18f4:	e8 e9 1f 00 00       	call   38e2 <open>
    18f9:	83 c4 10             	add    $0x10,%esp
    18fc:	89 c6                	mov    %eax,%esi
    18fe:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1905:	8d 76 00             	lea    0x0(%esi),%esi
    1908:	83 ec 04             	sub    $0x4,%esp
    190b:	6a 10                	push   $0x10
    190d:	57                   	push   %edi
    190e:	56                   	push   %esi
    190f:	e8 a6 1f 00 00       	call   38ba <read>
    1914:	83 c4 10             	add    $0x10,%esp
    1917:	85 c0                	test   %eax,%eax
    1919:	7e 3d                	jle    1958 <concreate+0x1a8>
    191b:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1920:	74 e6                	je     1908 <concreate+0x158>
    1922:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1926:	75 e0                	jne    1908 <concreate+0x158>
    1928:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    192c:	75 da                	jne    1908 <concreate+0x158>
    192e:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1932:	83 e8 30             	sub    $0x30,%eax
    1935:	83 f8 27             	cmp    $0x27,%eax
    1938:	0f 87 59 01 00 00    	ja     1a97 <concreate+0x2e7>
    193e:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1943:	0f 85 36 01 00 00    	jne    1a7f <concreate+0x2cf>
    1949:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
    194e:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    1952:	eb b4                	jmp    1908 <concreate+0x158>
    1954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1958:	83 ec 0c             	sub    $0xc,%esp
    195b:	56                   	push   %esi
    195c:	e8 69 1f 00 00       	call   38ca <close>
    1961:	83 c4 10             	add    $0x10,%esp
    1964:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1968:	0f 85 fd 00 00 00    	jne    1a6b <concreate+0x2bb>
    196e:	31 f6                	xor    %esi,%esi
    1970:	eb 70                	jmp    19e2 <concreate+0x232>
    1972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1978:	83 fa 01             	cmp    $0x1,%edx
    197b:	0f 85 99 00 00 00    	jne    1a1a <concreate+0x26a>
    1981:	83 ec 08             	sub    $0x8,%esp
    1984:	6a 00                	push   $0x0
    1986:	53                   	push   %ebx
    1987:	e8 56 1f 00 00       	call   38e2 <open>
    198c:	89 04 24             	mov    %eax,(%esp)
    198f:	e8 36 1f 00 00       	call   38ca <close>
    1994:	58                   	pop    %eax
    1995:	5a                   	pop    %edx
    1996:	6a 00                	push   $0x0
    1998:	53                   	push   %ebx
    1999:	e8 44 1f 00 00       	call   38e2 <open>
    199e:	89 04 24             	mov    %eax,(%esp)
    19a1:	e8 24 1f 00 00       	call   38ca <close>
    19a6:	59                   	pop    %ecx
    19a7:	58                   	pop    %eax
    19a8:	6a 00                	push   $0x0
    19aa:	53                   	push   %ebx
    19ab:	e8 32 1f 00 00       	call   38e2 <open>
    19b0:	89 04 24             	mov    %eax,(%esp)
    19b3:	e8 12 1f 00 00       	call   38ca <close>
    19b8:	58                   	pop    %eax
    19b9:	5a                   	pop    %edx
    19ba:	6a 00                	push   $0x0
    19bc:	53                   	push   %ebx
    19bd:	e8 20 1f 00 00       	call   38e2 <open>
    19c2:	89 04 24             	mov    %eax,(%esp)
    19c5:	e8 00 1f 00 00       	call   38ca <close>
    19ca:	83 c4 10             	add    $0x10,%esp
    19cd:	85 ff                	test   %edi,%edi
    19cf:	0f 84 d4 fe ff ff    	je     18a9 <concreate+0xf9>
    19d5:	83 c6 01             	add    $0x1,%esi
    19d8:	e8 cd 1e 00 00       	call   38aa <wait>
    19dd:	83 fe 28             	cmp    $0x28,%esi
    19e0:	74 5e                	je     1a40 <concreate+0x290>
    19e2:	8d 46 30             	lea    0x30(%esi),%eax
    19e5:	88 45 ae             	mov    %al,-0x52(%ebp)
    19e8:	e8 ad 1e 00 00       	call   389a <fork>
    19ed:	85 c0                	test   %eax,%eax
    19ef:	89 c7                	mov    %eax,%edi
    19f1:	78 64                	js     1a57 <concreate+0x2a7>
    19f3:	b8 56 55 55 55       	mov    $0x55555556,%eax
    19f8:	f7 ee                	imul   %esi
    19fa:	89 f0                	mov    %esi,%eax
    19fc:	c1 f8 1f             	sar    $0x1f,%eax
    19ff:	29 c2                	sub    %eax,%edx
    1a01:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1a04:	89 f2                	mov    %esi,%edx
    1a06:	29 c2                	sub    %eax,%edx
    1a08:	89 f8                	mov    %edi,%eax
    1a0a:	09 d0                	or     %edx,%eax
    1a0c:	0f 84 6f ff ff ff    	je     1981 <concreate+0x1d1>
    1a12:	85 ff                	test   %edi,%edi
    1a14:	0f 85 5e ff ff ff    	jne    1978 <concreate+0x1c8>
    1a1a:	83 ec 0c             	sub    $0xc,%esp
    1a1d:	53                   	push   %ebx
    1a1e:	e8 cf 1e 00 00       	call   38f2 <unlink>
    1a23:	89 1c 24             	mov    %ebx,(%esp)
    1a26:	e8 c7 1e 00 00       	call   38f2 <unlink>
    1a2b:	89 1c 24             	mov    %ebx,(%esp)
    1a2e:	e8 bf 1e 00 00       	call   38f2 <unlink>
    1a33:	89 1c 24             	mov    %ebx,(%esp)
    1a36:	e8 b7 1e 00 00       	call   38f2 <unlink>
    1a3b:	83 c4 10             	add    $0x10,%esp
    1a3e:	eb 8d                	jmp    19cd <concreate+0x21d>
    1a40:	83 ec 08             	sub    $0x8,%esp
    1a43:	68 0e 44 00 00       	push   $0x440e
    1a48:	6a 01                	push   $0x1
    1a4a:	e8 a1 1f 00 00       	call   39f0 <printf>
    1a4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a52:	5b                   	pop    %ebx
    1a53:	5e                   	pop    %esi
    1a54:	5f                   	pop    %edi
    1a55:	5d                   	pop    %ebp
    1a56:	c3                   	ret    
    1a57:	83 ec 08             	sub    $0x8,%esp
    1a5a:	68 91 4c 00 00       	push   $0x4c91
    1a5f:	6a 01                	push   $0x1
    1a61:	e8 8a 1f 00 00       	call   39f0 <printf>
    1a66:	e8 37 1e 00 00       	call   38a2 <exit>
    1a6b:	83 ec 08             	sub    $0x8,%esp
    1a6e:	68 58 4f 00 00       	push   $0x4f58
    1a73:	6a 01                	push   $0x1
    1a75:	e8 76 1f 00 00       	call   39f0 <printf>
    1a7a:	e8 23 1e 00 00       	call   38a2 <exit>
    1a7f:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a82:	83 ec 04             	sub    $0x4,%esp
    1a85:	50                   	push   %eax
    1a86:	68 f1 43 00 00       	push   $0x43f1
    1a8b:	6a 01                	push   $0x1
    1a8d:	e8 5e 1f 00 00       	call   39f0 <printf>
    1a92:	e8 0b 1e 00 00       	call   38a2 <exit>
    1a97:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a9a:	83 ec 04             	sub    $0x4,%esp
    1a9d:	50                   	push   %eax
    1a9e:	68 d8 43 00 00       	push   $0x43d8
    1aa3:	6a 01                	push   $0x1
    1aa5:	e8 46 1f 00 00       	call   39f0 <printf>
    1aaa:	e8 f3 1d 00 00       	call   38a2 <exit>
    1aaf:	83 ec 0c             	sub    $0xc,%esp
    1ab2:	50                   	push   %eax
    1ab3:	e8 12 1e 00 00       	call   38ca <close>
    1ab8:	83 c4 10             	add    $0x10,%esp
    1abb:	e9 e9 fd ff ff       	jmp    18a9 <concreate+0xf9>

00001ac0 <linkunlink>:
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	57                   	push   %edi
    1ac4:	56                   	push   %esi
    1ac5:	53                   	push   %ebx
    1ac6:	83 ec 24             	sub    $0x24,%esp
    1ac9:	68 1c 44 00 00       	push   $0x441c
    1ace:	6a 01                	push   $0x1
    1ad0:	e8 1b 1f 00 00       	call   39f0 <printf>
    1ad5:	c7 04 24 a9 46 00 00 	movl   $0x46a9,(%esp)
    1adc:	e8 11 1e 00 00       	call   38f2 <unlink>
    1ae1:	e8 b4 1d 00 00       	call   389a <fork>
    1ae6:	83 c4 10             	add    $0x10,%esp
    1ae9:	85 c0                	test   %eax,%eax
    1aeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1aee:	0f 88 b6 00 00 00    	js     1baa <linkunlink+0xea>
    1af4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1af8:	bb 64 00 00 00       	mov    $0x64,%ebx
    1afd:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    1b02:	19 ff                	sbb    %edi,%edi
    1b04:	83 e7 60             	and    $0x60,%edi
    1b07:	83 c7 01             	add    $0x1,%edi
    1b0a:	eb 1e                	jmp    1b2a <linkunlink+0x6a>
    1b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1b10:	83 fa 01             	cmp    $0x1,%edx
    1b13:	74 7b                	je     1b90 <linkunlink+0xd0>
    1b15:	83 ec 0c             	sub    $0xc,%esp
    1b18:	68 a9 46 00 00       	push   $0x46a9
    1b1d:	e8 d0 1d 00 00       	call   38f2 <unlink>
    1b22:	83 c4 10             	add    $0x10,%esp
    1b25:	83 eb 01             	sub    $0x1,%ebx
    1b28:	74 3d                	je     1b67 <linkunlink+0xa7>
    1b2a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b30:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    1b36:	89 f8                	mov    %edi,%eax
    1b38:	f7 e6                	mul    %esi
    1b3a:	d1 ea                	shr    %edx
    1b3c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b3f:	89 fa                	mov    %edi,%edx
    1b41:	29 c2                	sub    %eax,%edx
    1b43:	75 cb                	jne    1b10 <linkunlink+0x50>
    1b45:	83 ec 08             	sub    $0x8,%esp
    1b48:	68 02 02 00 00       	push   $0x202
    1b4d:	68 a9 46 00 00       	push   $0x46a9
    1b52:	e8 8b 1d 00 00       	call   38e2 <open>
    1b57:	89 04 24             	mov    %eax,(%esp)
    1b5a:	e8 6b 1d 00 00       	call   38ca <close>
    1b5f:	83 c4 10             	add    $0x10,%esp
    1b62:	83 eb 01             	sub    $0x1,%ebx
    1b65:	75 c3                	jne    1b2a <linkunlink+0x6a>
    1b67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b6a:	85 c0                	test   %eax,%eax
    1b6c:	74 50                	je     1bbe <linkunlink+0xfe>
    1b6e:	e8 37 1d 00 00       	call   38aa <wait>
    1b73:	83 ec 08             	sub    $0x8,%esp
    1b76:	68 31 44 00 00       	push   $0x4431
    1b7b:	6a 01                	push   $0x1
    1b7d:	e8 6e 1e 00 00       	call   39f0 <printf>
    1b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b85:	5b                   	pop    %ebx
    1b86:	5e                   	pop    %esi
    1b87:	5f                   	pop    %edi
    1b88:	5d                   	pop    %ebp
    1b89:	c3                   	ret    
    1b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1b90:	83 ec 08             	sub    $0x8,%esp
    1b93:	68 a9 46 00 00       	push   $0x46a9
    1b98:	68 2d 44 00 00       	push   $0x442d
    1b9d:	e8 60 1d 00 00       	call   3902 <link>
    1ba2:	83 c4 10             	add    $0x10,%esp
    1ba5:	e9 7b ff ff ff       	jmp    1b25 <linkunlink+0x65>
    1baa:	83 ec 08             	sub    $0x8,%esp
    1bad:	68 91 4c 00 00       	push   $0x4c91
    1bb2:	6a 01                	push   $0x1
    1bb4:	e8 37 1e 00 00       	call   39f0 <printf>
    1bb9:	e8 e4 1c 00 00       	call   38a2 <exit>
    1bbe:	e8 df 1c 00 00       	call   38a2 <exit>
    1bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001bd0 <bigdir>:
    1bd0:	55                   	push   %ebp
    1bd1:	89 e5                	mov    %esp,%ebp
    1bd3:	57                   	push   %edi
    1bd4:	56                   	push   %esi
    1bd5:	53                   	push   %ebx
    1bd6:	83 ec 24             	sub    $0x24,%esp
    1bd9:	68 40 44 00 00       	push   $0x4440
    1bde:	6a 01                	push   $0x1
    1be0:	e8 0b 1e 00 00       	call   39f0 <printf>
    1be5:	c7 04 24 4d 44 00 00 	movl   $0x444d,(%esp)
    1bec:	e8 01 1d 00 00       	call   38f2 <unlink>
    1bf1:	58                   	pop    %eax
    1bf2:	5a                   	pop    %edx
    1bf3:	68 00 02 00 00       	push   $0x200
    1bf8:	68 4d 44 00 00       	push   $0x444d
    1bfd:	e8 e0 1c 00 00       	call   38e2 <open>
    1c02:	83 c4 10             	add    $0x10,%esp
    1c05:	85 c0                	test   %eax,%eax
    1c07:	0f 88 de 00 00 00    	js     1ceb <bigdir+0x11b>
    1c0d:	83 ec 0c             	sub    $0xc,%esp
    1c10:	8d 7d de             	lea    -0x22(%ebp),%edi
    1c13:	31 f6                	xor    %esi,%esi
    1c15:	50                   	push   %eax
    1c16:	e8 af 1c 00 00       	call   38ca <close>
    1c1b:	83 c4 10             	add    $0x10,%esp
    1c1e:	66 90                	xchg   %ax,%ax
    1c20:	89 f0                	mov    %esi,%eax
    1c22:	83 ec 08             	sub    $0x8,%esp
    1c25:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c29:	c1 f8 06             	sar    $0x6,%eax
    1c2c:	57                   	push   %edi
    1c2d:	68 4d 44 00 00       	push   $0x444d
    1c32:	83 c0 30             	add    $0x30,%eax
    1c35:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c39:	88 45 df             	mov    %al,-0x21(%ebp)
    1c3c:	89 f0                	mov    %esi,%eax
    1c3e:	83 e0 3f             	and    $0x3f,%eax
    1c41:	83 c0 30             	add    $0x30,%eax
    1c44:	88 45 e0             	mov    %al,-0x20(%ebp)
    1c47:	e8 b6 1c 00 00       	call   3902 <link>
    1c4c:	83 c4 10             	add    $0x10,%esp
    1c4f:	85 c0                	test   %eax,%eax
    1c51:	89 c3                	mov    %eax,%ebx
    1c53:	75 6e                	jne    1cc3 <bigdir+0xf3>
    1c55:	83 c6 01             	add    $0x1,%esi
    1c58:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c5e:	75 c0                	jne    1c20 <bigdir+0x50>
    1c60:	83 ec 0c             	sub    $0xc,%esp
    1c63:	68 4d 44 00 00       	push   $0x444d
    1c68:	e8 85 1c 00 00       	call   38f2 <unlink>
    1c6d:	83 c4 10             	add    $0x10,%esp
    1c70:	89 d8                	mov    %ebx,%eax
    1c72:	83 ec 0c             	sub    $0xc,%esp
    1c75:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c79:	c1 f8 06             	sar    $0x6,%eax
    1c7c:	57                   	push   %edi
    1c7d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c81:	83 c0 30             	add    $0x30,%eax
    1c84:	88 45 df             	mov    %al,-0x21(%ebp)
    1c87:	89 d8                	mov    %ebx,%eax
    1c89:	83 e0 3f             	and    $0x3f,%eax
    1c8c:	83 c0 30             	add    $0x30,%eax
    1c8f:	88 45 e0             	mov    %al,-0x20(%ebp)
    1c92:	e8 5b 1c 00 00       	call   38f2 <unlink>
    1c97:	83 c4 10             	add    $0x10,%esp
    1c9a:	85 c0                	test   %eax,%eax
    1c9c:	75 39                	jne    1cd7 <bigdir+0x107>
    1c9e:	83 c3 01             	add    $0x1,%ebx
    1ca1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1ca7:	75 c7                	jne    1c70 <bigdir+0xa0>
    1ca9:	83 ec 08             	sub    $0x8,%esp
    1cac:	68 8f 44 00 00       	push   $0x448f
    1cb1:	6a 01                	push   $0x1
    1cb3:	e8 38 1d 00 00       	call   39f0 <printf>
    1cb8:	83 c4 10             	add    $0x10,%esp
    1cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cbe:	5b                   	pop    %ebx
    1cbf:	5e                   	pop    %esi
    1cc0:	5f                   	pop    %edi
    1cc1:	5d                   	pop    %ebp
    1cc2:	c3                   	ret    
    1cc3:	83 ec 08             	sub    $0x8,%esp
    1cc6:	68 66 44 00 00       	push   $0x4466
    1ccb:	6a 01                	push   $0x1
    1ccd:	e8 1e 1d 00 00       	call   39f0 <printf>
    1cd2:	e8 cb 1b 00 00       	call   38a2 <exit>
    1cd7:	83 ec 08             	sub    $0x8,%esp
    1cda:	68 7a 44 00 00       	push   $0x447a
    1cdf:	6a 01                	push   $0x1
    1ce1:	e8 0a 1d 00 00       	call   39f0 <printf>
    1ce6:	e8 b7 1b 00 00       	call   38a2 <exit>
    1ceb:	83 ec 08             	sub    $0x8,%esp
    1cee:	68 50 44 00 00       	push   $0x4450
    1cf3:	6a 01                	push   $0x1
    1cf5:	e8 f6 1c 00 00       	call   39f0 <printf>
    1cfa:	e8 a3 1b 00 00       	call   38a2 <exit>
    1cff:	90                   	nop

00001d00 <subdir>:
    1d00:	55                   	push   %ebp
    1d01:	89 e5                	mov    %esp,%ebp
    1d03:	53                   	push   %ebx
    1d04:	83 ec 0c             	sub    $0xc,%esp
    1d07:	68 9a 44 00 00       	push   $0x449a
    1d0c:	6a 01                	push   $0x1
    1d0e:	e8 dd 1c 00 00       	call   39f0 <printf>
    1d13:	c7 04 24 23 45 00 00 	movl   $0x4523,(%esp)
    1d1a:	e8 d3 1b 00 00       	call   38f2 <unlink>
    1d1f:	c7 04 24 c0 45 00 00 	movl   $0x45c0,(%esp)
    1d26:	e8 df 1b 00 00       	call   390a <mkdir>
    1d2b:	83 c4 10             	add    $0x10,%esp
    1d2e:	85 c0                	test   %eax,%eax
    1d30:	0f 85 b3 05 00 00    	jne    22e9 <subdir+0x5e9>
    1d36:	83 ec 08             	sub    $0x8,%esp
    1d39:	68 02 02 00 00       	push   $0x202
    1d3e:	68 f9 44 00 00       	push   $0x44f9
    1d43:	e8 9a 1b 00 00       	call   38e2 <open>
    1d48:	83 c4 10             	add    $0x10,%esp
    1d4b:	85 c0                	test   %eax,%eax
    1d4d:	89 c3                	mov    %eax,%ebx
    1d4f:	0f 88 81 05 00 00    	js     22d6 <subdir+0x5d6>
    1d55:	83 ec 04             	sub    $0x4,%esp
    1d58:	6a 02                	push   $0x2
    1d5a:	68 23 45 00 00       	push   $0x4523
    1d5f:	50                   	push   %eax
    1d60:	e8 5d 1b 00 00       	call   38c2 <write>
    1d65:	89 1c 24             	mov    %ebx,(%esp)
    1d68:	e8 5d 1b 00 00       	call   38ca <close>
    1d6d:	c7 04 24 c0 45 00 00 	movl   $0x45c0,(%esp)
    1d74:	e8 79 1b 00 00       	call   38f2 <unlink>
    1d79:	83 c4 10             	add    $0x10,%esp
    1d7c:	85 c0                	test   %eax,%eax
    1d7e:	0f 89 3f 05 00 00    	jns    22c3 <subdir+0x5c3>
    1d84:	83 ec 0c             	sub    $0xc,%esp
    1d87:	68 d4 44 00 00       	push   $0x44d4
    1d8c:	e8 79 1b 00 00       	call   390a <mkdir>
    1d91:	83 c4 10             	add    $0x10,%esp
    1d94:	85 c0                	test   %eax,%eax
    1d96:	0f 85 14 05 00 00    	jne    22b0 <subdir+0x5b0>
    1d9c:	83 ec 08             	sub    $0x8,%esp
    1d9f:	68 02 02 00 00       	push   $0x202
    1da4:	68 f6 44 00 00       	push   $0x44f6
    1da9:	e8 34 1b 00 00       	call   38e2 <open>
    1dae:	83 c4 10             	add    $0x10,%esp
    1db1:	85 c0                	test   %eax,%eax
    1db3:	89 c3                	mov    %eax,%ebx
    1db5:	0f 88 24 04 00 00    	js     21df <subdir+0x4df>
    1dbb:	83 ec 04             	sub    $0x4,%esp
    1dbe:	6a 02                	push   $0x2
    1dc0:	68 17 45 00 00       	push   $0x4517
    1dc5:	50                   	push   %eax
    1dc6:	e8 f7 1a 00 00       	call   38c2 <write>
    1dcb:	89 1c 24             	mov    %ebx,(%esp)
    1dce:	e8 f7 1a 00 00       	call   38ca <close>
    1dd3:	58                   	pop    %eax
    1dd4:	5a                   	pop    %edx
    1dd5:	6a 00                	push   $0x0
    1dd7:	68 1a 45 00 00       	push   $0x451a
    1ddc:	e8 01 1b 00 00       	call   38e2 <open>
    1de1:	83 c4 10             	add    $0x10,%esp
    1de4:	85 c0                	test   %eax,%eax
    1de6:	89 c3                	mov    %eax,%ebx
    1de8:	0f 88 de 03 00 00    	js     21cc <subdir+0x4cc>
    1dee:	83 ec 04             	sub    $0x4,%esp
    1df1:	68 00 20 00 00       	push   $0x2000
    1df6:	68 c0 85 00 00       	push   $0x85c0
    1dfb:	50                   	push   %eax
    1dfc:	e8 b9 1a 00 00       	call   38ba <read>
    1e01:	83 c4 10             	add    $0x10,%esp
    1e04:	83 f8 02             	cmp    $0x2,%eax
    1e07:	0f 85 3a 03 00 00    	jne    2147 <subdir+0x447>
    1e0d:	80 3d c0 85 00 00 66 	cmpb   $0x66,0x85c0
    1e14:	0f 85 2d 03 00 00    	jne    2147 <subdir+0x447>
    1e1a:	83 ec 0c             	sub    $0xc,%esp
    1e1d:	53                   	push   %ebx
    1e1e:	e8 a7 1a 00 00       	call   38ca <close>
    1e23:	5b                   	pop    %ebx
    1e24:	58                   	pop    %eax
    1e25:	68 5a 45 00 00       	push   $0x455a
    1e2a:	68 f6 44 00 00       	push   $0x44f6
    1e2f:	e8 ce 1a 00 00       	call   3902 <link>
    1e34:	83 c4 10             	add    $0x10,%esp
    1e37:	85 c0                	test   %eax,%eax
    1e39:	0f 85 c6 03 00 00    	jne    2205 <subdir+0x505>
    1e3f:	83 ec 0c             	sub    $0xc,%esp
    1e42:	68 f6 44 00 00       	push   $0x44f6
    1e47:	e8 a6 1a 00 00       	call   38f2 <unlink>
    1e4c:	83 c4 10             	add    $0x10,%esp
    1e4f:	85 c0                	test   %eax,%eax
    1e51:	0f 85 16 03 00 00    	jne    216d <subdir+0x46d>
    1e57:	83 ec 08             	sub    $0x8,%esp
    1e5a:	6a 00                	push   $0x0
    1e5c:	68 f6 44 00 00       	push   $0x44f6
    1e61:	e8 7c 1a 00 00       	call   38e2 <open>
    1e66:	83 c4 10             	add    $0x10,%esp
    1e69:	85 c0                	test   %eax,%eax
    1e6b:	0f 89 2c 04 00 00    	jns    229d <subdir+0x59d>
    1e71:	83 ec 0c             	sub    $0xc,%esp
    1e74:	68 c0 45 00 00       	push   $0x45c0
    1e79:	e8 94 1a 00 00       	call   3912 <chdir>
    1e7e:	83 c4 10             	add    $0x10,%esp
    1e81:	85 c0                	test   %eax,%eax
    1e83:	0f 85 01 04 00 00    	jne    228a <subdir+0x58a>
    1e89:	83 ec 0c             	sub    $0xc,%esp
    1e8c:	68 8e 45 00 00       	push   $0x458e
    1e91:	e8 7c 1a 00 00       	call   3912 <chdir>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	0f 85 b9 02 00 00    	jne    215a <subdir+0x45a>
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	68 b4 45 00 00       	push   $0x45b4
    1ea9:	e8 64 1a 00 00       	call   3912 <chdir>
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	0f 85 a1 02 00 00    	jne    215a <subdir+0x45a>
    1eb9:	83 ec 0c             	sub    $0xc,%esp
    1ebc:	68 c3 45 00 00       	push   $0x45c3
    1ec1:	e8 4c 1a 00 00       	call   3912 <chdir>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 85 21 03 00 00    	jne    21f2 <subdir+0x4f2>
    1ed1:	83 ec 08             	sub    $0x8,%esp
    1ed4:	6a 00                	push   $0x0
    1ed6:	68 5a 45 00 00       	push   $0x455a
    1edb:	e8 02 1a 00 00       	call   38e2 <open>
    1ee0:	83 c4 10             	add    $0x10,%esp
    1ee3:	85 c0                	test   %eax,%eax
    1ee5:	89 c3                	mov    %eax,%ebx
    1ee7:	0f 88 e0 04 00 00    	js     23cd <subdir+0x6cd>
    1eed:	83 ec 04             	sub    $0x4,%esp
    1ef0:	68 00 20 00 00       	push   $0x2000
    1ef5:	68 c0 85 00 00       	push   $0x85c0
    1efa:	50                   	push   %eax
    1efb:	e8 ba 19 00 00       	call   38ba <read>
    1f00:	83 c4 10             	add    $0x10,%esp
    1f03:	83 f8 02             	cmp    $0x2,%eax
    1f06:	0f 85 ae 04 00 00    	jne    23ba <subdir+0x6ba>
    1f0c:	83 ec 0c             	sub    $0xc,%esp
    1f0f:	53                   	push   %ebx
    1f10:	e8 b5 19 00 00       	call   38ca <close>
    1f15:	59                   	pop    %ecx
    1f16:	5b                   	pop    %ebx
    1f17:	6a 00                	push   $0x0
    1f19:	68 f6 44 00 00       	push   $0x44f6
    1f1e:	e8 bf 19 00 00       	call   38e2 <open>
    1f23:	83 c4 10             	add    $0x10,%esp
    1f26:	85 c0                	test   %eax,%eax
    1f28:	0f 89 65 02 00 00    	jns    2193 <subdir+0x493>
    1f2e:	83 ec 08             	sub    $0x8,%esp
    1f31:	68 02 02 00 00       	push   $0x202
    1f36:	68 0e 46 00 00       	push   $0x460e
    1f3b:	e8 a2 19 00 00       	call   38e2 <open>
    1f40:	83 c4 10             	add    $0x10,%esp
    1f43:	85 c0                	test   %eax,%eax
    1f45:	0f 89 35 02 00 00    	jns    2180 <subdir+0x480>
    1f4b:	83 ec 08             	sub    $0x8,%esp
    1f4e:	68 02 02 00 00       	push   $0x202
    1f53:	68 33 46 00 00       	push   $0x4633
    1f58:	e8 85 19 00 00       	call   38e2 <open>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	0f 89 0f 03 00 00    	jns    2277 <subdir+0x577>
    1f68:	83 ec 08             	sub    $0x8,%esp
    1f6b:	68 00 02 00 00       	push   $0x200
    1f70:	68 c0 45 00 00       	push   $0x45c0
    1f75:	e8 68 19 00 00       	call   38e2 <open>
    1f7a:	83 c4 10             	add    $0x10,%esp
    1f7d:	85 c0                	test   %eax,%eax
    1f7f:	0f 89 df 02 00 00    	jns    2264 <subdir+0x564>
    1f85:	83 ec 08             	sub    $0x8,%esp
    1f88:	6a 02                	push   $0x2
    1f8a:	68 c0 45 00 00       	push   $0x45c0
    1f8f:	e8 4e 19 00 00       	call   38e2 <open>
    1f94:	83 c4 10             	add    $0x10,%esp
    1f97:	85 c0                	test   %eax,%eax
    1f99:	0f 89 b2 02 00 00    	jns    2251 <subdir+0x551>
    1f9f:	83 ec 08             	sub    $0x8,%esp
    1fa2:	6a 01                	push   $0x1
    1fa4:	68 c0 45 00 00       	push   $0x45c0
    1fa9:	e8 34 19 00 00       	call   38e2 <open>
    1fae:	83 c4 10             	add    $0x10,%esp
    1fb1:	85 c0                	test   %eax,%eax
    1fb3:	0f 89 85 02 00 00    	jns    223e <subdir+0x53e>
    1fb9:	83 ec 08             	sub    $0x8,%esp
    1fbc:	68 a2 46 00 00       	push   $0x46a2
    1fc1:	68 0e 46 00 00       	push   $0x460e
    1fc6:	e8 37 19 00 00       	call   3902 <link>
    1fcb:	83 c4 10             	add    $0x10,%esp
    1fce:	85 c0                	test   %eax,%eax
    1fd0:	0f 84 55 02 00 00    	je     222b <subdir+0x52b>
    1fd6:	83 ec 08             	sub    $0x8,%esp
    1fd9:	68 a2 46 00 00       	push   $0x46a2
    1fde:	68 33 46 00 00       	push   $0x4633
    1fe3:	e8 1a 19 00 00       	call   3902 <link>
    1fe8:	83 c4 10             	add    $0x10,%esp
    1feb:	85 c0                	test   %eax,%eax
    1fed:	0f 84 25 02 00 00    	je     2218 <subdir+0x518>
    1ff3:	83 ec 08             	sub    $0x8,%esp
    1ff6:	68 5a 45 00 00       	push   $0x455a
    1ffb:	68 f9 44 00 00       	push   $0x44f9
    2000:	e8 fd 18 00 00       	call   3902 <link>
    2005:	83 c4 10             	add    $0x10,%esp
    2008:	85 c0                	test   %eax,%eax
    200a:	0f 84 a9 01 00 00    	je     21b9 <subdir+0x4b9>
    2010:	83 ec 0c             	sub    $0xc,%esp
    2013:	68 0e 46 00 00       	push   $0x460e
    2018:	e8 ed 18 00 00       	call   390a <mkdir>
    201d:	83 c4 10             	add    $0x10,%esp
    2020:	85 c0                	test   %eax,%eax
    2022:	0f 84 7e 01 00 00    	je     21a6 <subdir+0x4a6>
    2028:	83 ec 0c             	sub    $0xc,%esp
    202b:	68 33 46 00 00       	push   $0x4633
    2030:	e8 d5 18 00 00       	call   390a <mkdir>
    2035:	83 c4 10             	add    $0x10,%esp
    2038:	85 c0                	test   %eax,%eax
    203a:	0f 84 67 03 00 00    	je     23a7 <subdir+0x6a7>
    2040:	83 ec 0c             	sub    $0xc,%esp
    2043:	68 5a 45 00 00       	push   $0x455a
    2048:	e8 bd 18 00 00       	call   390a <mkdir>
    204d:	83 c4 10             	add    $0x10,%esp
    2050:	85 c0                	test   %eax,%eax
    2052:	0f 84 3c 03 00 00    	je     2394 <subdir+0x694>
    2058:	83 ec 0c             	sub    $0xc,%esp
    205b:	68 33 46 00 00       	push   $0x4633
    2060:	e8 8d 18 00 00       	call   38f2 <unlink>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 11 03 00 00    	je     2381 <subdir+0x681>
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 0e 46 00 00       	push   $0x460e
    2078:	e8 75 18 00 00       	call   38f2 <unlink>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 e6 02 00 00    	je     236e <subdir+0x66e>
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 f9 44 00 00       	push   $0x44f9
    2090:	e8 7d 18 00 00       	call   3912 <chdir>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 bb 02 00 00    	je     235b <subdir+0x65b>
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 a5 46 00 00       	push   $0x46a5
    20a8:	e8 65 18 00 00       	call   3912 <chdir>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 90 02 00 00    	je     2348 <subdir+0x648>
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 5a 45 00 00       	push   $0x455a
    20c0:	e8 2d 18 00 00       	call   38f2 <unlink>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 85 9d 00 00 00    	jne    216d <subdir+0x46d>
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 f9 44 00 00       	push   $0x44f9
    20d8:	e8 15 18 00 00       	call   38f2 <unlink>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 85 4d 02 00 00    	jne    2335 <subdir+0x635>
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 c0 45 00 00       	push   $0x45c0
    20f0:	e8 fd 17 00 00       	call   38f2 <unlink>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 84 22 02 00 00    	je     2322 <subdir+0x622>
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 d5 44 00 00       	push   $0x44d5
    2108:	e8 e5 17 00 00       	call   38f2 <unlink>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 88 f7 01 00 00    	js     230f <subdir+0x60f>
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 c0 45 00 00       	push   $0x45c0
    2120:	e8 cd 17 00 00       	call   38f2 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 88 cc 01 00 00    	js     22fc <subdir+0x5fc>
    2130:	83 ec 08             	sub    $0x8,%esp
    2133:	68 a2 47 00 00       	push   $0x47a2
    2138:	6a 01                	push   $0x1
    213a:	e8 b1 18 00 00       	call   39f0 <printf>
    213f:	83 c4 10             	add    $0x10,%esp
    2142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2145:	c9                   	leave  
    2146:	c3                   	ret    
    2147:	50                   	push   %eax
    2148:	50                   	push   %eax
    2149:	68 3f 45 00 00       	push   $0x453f
    214e:	6a 01                	push   $0x1
    2150:	e8 9b 18 00 00       	call   39f0 <printf>
    2155:	e8 48 17 00 00       	call   38a2 <exit>
    215a:	50                   	push   %eax
    215b:	50                   	push   %eax
    215c:	68 9a 45 00 00       	push   $0x459a
    2161:	6a 01                	push   $0x1
    2163:	e8 88 18 00 00       	call   39f0 <printf>
    2168:	e8 35 17 00 00       	call   38a2 <exit>
    216d:	52                   	push   %edx
    216e:	52                   	push   %edx
    216f:	68 65 45 00 00       	push   $0x4565
    2174:	6a 01                	push   $0x1
    2176:	e8 75 18 00 00       	call   39f0 <printf>
    217b:	e8 22 17 00 00       	call   38a2 <exit>
    2180:	50                   	push   %eax
    2181:	50                   	push   %eax
    2182:	68 17 46 00 00       	push   $0x4617
    2187:	6a 01                	push   $0x1
    2189:	e8 62 18 00 00       	call   39f0 <printf>
    218e:	e8 0f 17 00 00       	call   38a2 <exit>
    2193:	52                   	push   %edx
    2194:	52                   	push   %edx
    2195:	68 fc 4f 00 00       	push   $0x4ffc
    219a:	6a 01                	push   $0x1
    219c:	e8 4f 18 00 00       	call   39f0 <printf>
    21a1:	e8 fc 16 00 00       	call   38a2 <exit>
    21a6:	52                   	push   %edx
    21a7:	52                   	push   %edx
    21a8:	68 ab 46 00 00       	push   $0x46ab
    21ad:	6a 01                	push   $0x1
    21af:	e8 3c 18 00 00       	call   39f0 <printf>
    21b4:	e8 e9 16 00 00       	call   38a2 <exit>
    21b9:	51                   	push   %ecx
    21ba:	51                   	push   %ecx
    21bb:	68 6c 50 00 00       	push   $0x506c
    21c0:	6a 01                	push   $0x1
    21c2:	e8 29 18 00 00       	call   39f0 <printf>
    21c7:	e8 d6 16 00 00       	call   38a2 <exit>
    21cc:	50                   	push   %eax
    21cd:	50                   	push   %eax
    21ce:	68 26 45 00 00       	push   $0x4526
    21d3:	6a 01                	push   $0x1
    21d5:	e8 16 18 00 00       	call   39f0 <printf>
    21da:	e8 c3 16 00 00       	call   38a2 <exit>
    21df:	51                   	push   %ecx
    21e0:	51                   	push   %ecx
    21e1:	68 ff 44 00 00       	push   $0x44ff
    21e6:	6a 01                	push   $0x1
    21e8:	e8 03 18 00 00       	call   39f0 <printf>
    21ed:	e8 b0 16 00 00       	call   38a2 <exit>
    21f2:	50                   	push   %eax
    21f3:	50                   	push   %eax
    21f4:	68 c8 45 00 00       	push   $0x45c8
    21f9:	6a 01                	push   $0x1
    21fb:	e8 f0 17 00 00       	call   39f0 <printf>
    2200:	e8 9d 16 00 00       	call   38a2 <exit>
    2205:	51                   	push   %ecx
    2206:	51                   	push   %ecx
    2207:	68 b4 4f 00 00       	push   $0x4fb4
    220c:	6a 01                	push   $0x1
    220e:	e8 dd 17 00 00       	call   39f0 <printf>
    2213:	e8 8a 16 00 00       	call   38a2 <exit>
    2218:	53                   	push   %ebx
    2219:	53                   	push   %ebx
    221a:	68 48 50 00 00       	push   $0x5048
    221f:	6a 01                	push   $0x1
    2221:	e8 ca 17 00 00       	call   39f0 <printf>
    2226:	e8 77 16 00 00       	call   38a2 <exit>
    222b:	50                   	push   %eax
    222c:	50                   	push   %eax
    222d:	68 24 50 00 00       	push   $0x5024
    2232:	6a 01                	push   $0x1
    2234:	e8 b7 17 00 00       	call   39f0 <printf>
    2239:	e8 64 16 00 00       	call   38a2 <exit>
    223e:	50                   	push   %eax
    223f:	50                   	push   %eax
    2240:	68 87 46 00 00       	push   $0x4687
    2245:	6a 01                	push   $0x1
    2247:	e8 a4 17 00 00       	call   39f0 <printf>
    224c:	e8 51 16 00 00       	call   38a2 <exit>
    2251:	50                   	push   %eax
    2252:	50                   	push   %eax
    2253:	68 6e 46 00 00       	push   $0x466e
    2258:	6a 01                	push   $0x1
    225a:	e8 91 17 00 00       	call   39f0 <printf>
    225f:	e8 3e 16 00 00       	call   38a2 <exit>
    2264:	50                   	push   %eax
    2265:	50                   	push   %eax
    2266:	68 58 46 00 00       	push   $0x4658
    226b:	6a 01                	push   $0x1
    226d:	e8 7e 17 00 00       	call   39f0 <printf>
    2272:	e8 2b 16 00 00       	call   38a2 <exit>
    2277:	50                   	push   %eax
    2278:	50                   	push   %eax
    2279:	68 3c 46 00 00       	push   $0x463c
    227e:	6a 01                	push   $0x1
    2280:	e8 6b 17 00 00       	call   39f0 <printf>
    2285:	e8 18 16 00 00       	call   38a2 <exit>
    228a:	50                   	push   %eax
    228b:	50                   	push   %eax
    228c:	68 7d 45 00 00       	push   $0x457d
    2291:	6a 01                	push   $0x1
    2293:	e8 58 17 00 00       	call   39f0 <printf>
    2298:	e8 05 16 00 00       	call   38a2 <exit>
    229d:	50                   	push   %eax
    229e:	50                   	push   %eax
    229f:	68 d8 4f 00 00       	push   $0x4fd8
    22a4:	6a 01                	push   $0x1
    22a6:	e8 45 17 00 00       	call   39f0 <printf>
    22ab:	e8 f2 15 00 00       	call   38a2 <exit>
    22b0:	53                   	push   %ebx
    22b1:	53                   	push   %ebx
    22b2:	68 db 44 00 00       	push   $0x44db
    22b7:	6a 01                	push   $0x1
    22b9:	e8 32 17 00 00       	call   39f0 <printf>
    22be:	e8 df 15 00 00       	call   38a2 <exit>
    22c3:	50                   	push   %eax
    22c4:	50                   	push   %eax
    22c5:	68 8c 4f 00 00       	push   $0x4f8c
    22ca:	6a 01                	push   $0x1
    22cc:	e8 1f 17 00 00       	call   39f0 <printf>
    22d1:	e8 cc 15 00 00       	call   38a2 <exit>
    22d6:	50                   	push   %eax
    22d7:	50                   	push   %eax
    22d8:	68 bf 44 00 00       	push   $0x44bf
    22dd:	6a 01                	push   $0x1
    22df:	e8 0c 17 00 00       	call   39f0 <printf>
    22e4:	e8 b9 15 00 00       	call   38a2 <exit>
    22e9:	50                   	push   %eax
    22ea:	50                   	push   %eax
    22eb:	68 a7 44 00 00       	push   $0x44a7
    22f0:	6a 01                	push   $0x1
    22f2:	e8 f9 16 00 00       	call   39f0 <printf>
    22f7:	e8 a6 15 00 00       	call   38a2 <exit>
    22fc:	50                   	push   %eax
    22fd:	50                   	push   %eax
    22fe:	68 90 47 00 00       	push   $0x4790
    2303:	6a 01                	push   $0x1
    2305:	e8 e6 16 00 00       	call   39f0 <printf>
    230a:	e8 93 15 00 00       	call   38a2 <exit>
    230f:	52                   	push   %edx
    2310:	52                   	push   %edx
    2311:	68 7b 47 00 00       	push   $0x477b
    2316:	6a 01                	push   $0x1
    2318:	e8 d3 16 00 00       	call   39f0 <printf>
    231d:	e8 80 15 00 00       	call   38a2 <exit>
    2322:	51                   	push   %ecx
    2323:	51                   	push   %ecx
    2324:	68 90 50 00 00       	push   $0x5090
    2329:	6a 01                	push   $0x1
    232b:	e8 c0 16 00 00       	call   39f0 <printf>
    2330:	e8 6d 15 00 00       	call   38a2 <exit>
    2335:	53                   	push   %ebx
    2336:	53                   	push   %ebx
    2337:	68 66 47 00 00       	push   $0x4766
    233c:	6a 01                	push   $0x1
    233e:	e8 ad 16 00 00       	call   39f0 <printf>
    2343:	e8 5a 15 00 00       	call   38a2 <exit>
    2348:	50                   	push   %eax
    2349:	50                   	push   %eax
    234a:	68 4e 47 00 00       	push   $0x474e
    234f:	6a 01                	push   $0x1
    2351:	e8 9a 16 00 00       	call   39f0 <printf>
    2356:	e8 47 15 00 00       	call   38a2 <exit>
    235b:	50                   	push   %eax
    235c:	50                   	push   %eax
    235d:	68 36 47 00 00       	push   $0x4736
    2362:	6a 01                	push   $0x1
    2364:	e8 87 16 00 00       	call   39f0 <printf>
    2369:	e8 34 15 00 00       	call   38a2 <exit>
    236e:	50                   	push   %eax
    236f:	50                   	push   %eax
    2370:	68 1a 47 00 00       	push   $0x471a
    2375:	6a 01                	push   $0x1
    2377:	e8 74 16 00 00       	call   39f0 <printf>
    237c:	e8 21 15 00 00       	call   38a2 <exit>
    2381:	50                   	push   %eax
    2382:	50                   	push   %eax
    2383:	68 fe 46 00 00       	push   $0x46fe
    2388:	6a 01                	push   $0x1
    238a:	e8 61 16 00 00       	call   39f0 <printf>
    238f:	e8 0e 15 00 00       	call   38a2 <exit>
    2394:	50                   	push   %eax
    2395:	50                   	push   %eax
    2396:	68 e1 46 00 00       	push   $0x46e1
    239b:	6a 01                	push   $0x1
    239d:	e8 4e 16 00 00       	call   39f0 <printf>
    23a2:	e8 fb 14 00 00       	call   38a2 <exit>
    23a7:	50                   	push   %eax
    23a8:	50                   	push   %eax
    23a9:	68 c6 46 00 00       	push   $0x46c6
    23ae:	6a 01                	push   $0x1
    23b0:	e8 3b 16 00 00       	call   39f0 <printf>
    23b5:	e8 e8 14 00 00       	call   38a2 <exit>
    23ba:	50                   	push   %eax
    23bb:	50                   	push   %eax
    23bc:	68 f3 45 00 00       	push   $0x45f3
    23c1:	6a 01                	push   $0x1
    23c3:	e8 28 16 00 00       	call   39f0 <printf>
    23c8:	e8 d5 14 00 00       	call   38a2 <exit>
    23cd:	50                   	push   %eax
    23ce:	50                   	push   %eax
    23cf:	68 db 45 00 00       	push   $0x45db
    23d4:	6a 01                	push   $0x1
    23d6:	e8 15 16 00 00       	call   39f0 <printf>
    23db:	e8 c2 14 00 00       	call   38a2 <exit>

000023e0 <bigwrite>:
    23e0:	55                   	push   %ebp
    23e1:	89 e5                	mov    %esp,%ebp
    23e3:	56                   	push   %esi
    23e4:	53                   	push   %ebx
    23e5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    23ea:	83 ec 08             	sub    $0x8,%esp
    23ed:	68 ad 47 00 00       	push   $0x47ad
    23f2:	6a 01                	push   $0x1
    23f4:	e8 f7 15 00 00       	call   39f0 <printf>
    23f9:	c7 04 24 bc 47 00 00 	movl   $0x47bc,(%esp)
    2400:	e8 ed 14 00 00       	call   38f2 <unlink>
    2405:	83 c4 10             	add    $0x10,%esp
    2408:	90                   	nop
    2409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2410:	83 ec 08             	sub    $0x8,%esp
    2413:	68 02 02 00 00       	push   $0x202
    2418:	68 bc 47 00 00       	push   $0x47bc
    241d:	e8 c0 14 00 00       	call   38e2 <open>
    2422:	83 c4 10             	add    $0x10,%esp
    2425:	85 c0                	test   %eax,%eax
    2427:	89 c6                	mov    %eax,%esi
    2429:	78 7e                	js     24a9 <bigwrite+0xc9>
    242b:	83 ec 04             	sub    $0x4,%esp
    242e:	53                   	push   %ebx
    242f:	68 c0 85 00 00       	push   $0x85c0
    2434:	50                   	push   %eax
    2435:	e8 88 14 00 00       	call   38c2 <write>
    243a:	83 c4 10             	add    $0x10,%esp
    243d:	39 d8                	cmp    %ebx,%eax
    243f:	75 55                	jne    2496 <bigwrite+0xb6>
    2441:	83 ec 04             	sub    $0x4,%esp
    2444:	53                   	push   %ebx
    2445:	68 c0 85 00 00       	push   $0x85c0
    244a:	56                   	push   %esi
    244b:	e8 72 14 00 00       	call   38c2 <write>
    2450:	83 c4 10             	add    $0x10,%esp
    2453:	39 d8                	cmp    %ebx,%eax
    2455:	75 3f                	jne    2496 <bigwrite+0xb6>
    2457:	83 ec 0c             	sub    $0xc,%esp
    245a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    2460:	56                   	push   %esi
    2461:	e8 64 14 00 00       	call   38ca <close>
    2466:	c7 04 24 bc 47 00 00 	movl   $0x47bc,(%esp)
    246d:	e8 80 14 00 00       	call   38f2 <unlink>
    2472:	83 c4 10             	add    $0x10,%esp
    2475:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    247b:	75 93                	jne    2410 <bigwrite+0x30>
    247d:	83 ec 08             	sub    $0x8,%esp
    2480:	68 ef 47 00 00       	push   $0x47ef
    2485:	6a 01                	push   $0x1
    2487:	e8 64 15 00 00       	call   39f0 <printf>
    248c:	83 c4 10             	add    $0x10,%esp
    248f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2492:	5b                   	pop    %ebx
    2493:	5e                   	pop    %esi
    2494:	5d                   	pop    %ebp
    2495:	c3                   	ret    
    2496:	50                   	push   %eax
    2497:	53                   	push   %ebx
    2498:	68 dd 47 00 00       	push   $0x47dd
    249d:	6a 01                	push   $0x1
    249f:	e8 4c 15 00 00       	call   39f0 <printf>
    24a4:	e8 f9 13 00 00       	call   38a2 <exit>
    24a9:	83 ec 08             	sub    $0x8,%esp
    24ac:	68 c5 47 00 00       	push   $0x47c5
    24b1:	6a 01                	push   $0x1
    24b3:	e8 38 15 00 00       	call   39f0 <printf>
    24b8:	e8 e5 13 00 00       	call   38a2 <exit>
    24bd:	8d 76 00             	lea    0x0(%esi),%esi

000024c0 <bigfile>:
    24c0:	55                   	push   %ebp
    24c1:	89 e5                	mov    %esp,%ebp
    24c3:	57                   	push   %edi
    24c4:	56                   	push   %esi
    24c5:	53                   	push   %ebx
    24c6:	83 ec 14             	sub    $0x14,%esp
    24c9:	68 fc 47 00 00       	push   $0x47fc
    24ce:	6a 01                	push   $0x1
    24d0:	e8 1b 15 00 00       	call   39f0 <printf>
    24d5:	c7 04 24 18 48 00 00 	movl   $0x4818,(%esp)
    24dc:	e8 11 14 00 00       	call   38f2 <unlink>
    24e1:	5e                   	pop    %esi
    24e2:	5f                   	pop    %edi
    24e3:	68 02 02 00 00       	push   $0x202
    24e8:	68 18 48 00 00       	push   $0x4818
    24ed:	e8 f0 13 00 00       	call   38e2 <open>
    24f2:	83 c4 10             	add    $0x10,%esp
    24f5:	85 c0                	test   %eax,%eax
    24f7:	0f 88 5f 01 00 00    	js     265c <bigfile+0x19c>
    24fd:	89 c6                	mov    %eax,%esi
    24ff:	31 db                	xor    %ebx,%ebx
    2501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2508:	83 ec 04             	sub    $0x4,%esp
    250b:	68 58 02 00 00       	push   $0x258
    2510:	53                   	push   %ebx
    2511:	68 c0 85 00 00       	push   $0x85c0
    2516:	e8 15 12 00 00       	call   3730 <memset>
    251b:	83 c4 0c             	add    $0xc,%esp
    251e:	68 58 02 00 00       	push   $0x258
    2523:	68 c0 85 00 00       	push   $0x85c0
    2528:	56                   	push   %esi
    2529:	e8 94 13 00 00       	call   38c2 <write>
    252e:	83 c4 10             	add    $0x10,%esp
    2531:	3d 58 02 00 00       	cmp    $0x258,%eax
    2536:	0f 85 f8 00 00 00    	jne    2634 <bigfile+0x174>
    253c:	83 c3 01             	add    $0x1,%ebx
    253f:	83 fb 14             	cmp    $0x14,%ebx
    2542:	75 c4                	jne    2508 <bigfile+0x48>
    2544:	83 ec 0c             	sub    $0xc,%esp
    2547:	56                   	push   %esi
    2548:	e8 7d 13 00 00       	call   38ca <close>
    254d:	59                   	pop    %ecx
    254e:	5b                   	pop    %ebx
    254f:	6a 00                	push   $0x0
    2551:	68 18 48 00 00       	push   $0x4818
    2556:	e8 87 13 00 00       	call   38e2 <open>
    255b:	83 c4 10             	add    $0x10,%esp
    255e:	85 c0                	test   %eax,%eax
    2560:	89 c6                	mov    %eax,%esi
    2562:	0f 88 e0 00 00 00    	js     2648 <bigfile+0x188>
    2568:	31 db                	xor    %ebx,%ebx
    256a:	31 ff                	xor    %edi,%edi
    256c:	eb 30                	jmp    259e <bigfile+0xde>
    256e:	66 90                	xchg   %ax,%ax
    2570:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2575:	0f 85 91 00 00 00    	jne    260c <bigfile+0x14c>
    257b:	0f be 05 c0 85 00 00 	movsbl 0x85c0,%eax
    2582:	89 fa                	mov    %edi,%edx
    2584:	d1 fa                	sar    %edx
    2586:	39 d0                	cmp    %edx,%eax
    2588:	75 6e                	jne    25f8 <bigfile+0x138>
    258a:	0f be 15 eb 86 00 00 	movsbl 0x86eb,%edx
    2591:	39 d0                	cmp    %edx,%eax
    2593:	75 63                	jne    25f8 <bigfile+0x138>
    2595:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
    259b:	83 c7 01             	add    $0x1,%edi
    259e:	83 ec 04             	sub    $0x4,%esp
    25a1:	68 2c 01 00 00       	push   $0x12c
    25a6:	68 c0 85 00 00       	push   $0x85c0
    25ab:	56                   	push   %esi
    25ac:	e8 09 13 00 00       	call   38ba <read>
    25b1:	83 c4 10             	add    $0x10,%esp
    25b4:	85 c0                	test   %eax,%eax
    25b6:	78 68                	js     2620 <bigfile+0x160>
    25b8:	75 b6                	jne    2570 <bigfile+0xb0>
    25ba:	83 ec 0c             	sub    $0xc,%esp
    25bd:	56                   	push   %esi
    25be:	e8 07 13 00 00       	call   38ca <close>
    25c3:	83 c4 10             	add    $0x10,%esp
    25c6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25cc:	0f 85 9e 00 00 00    	jne    2670 <bigfile+0x1b0>
    25d2:	83 ec 0c             	sub    $0xc,%esp
    25d5:	68 18 48 00 00       	push   $0x4818
    25da:	e8 13 13 00 00       	call   38f2 <unlink>
    25df:	58                   	pop    %eax
    25e0:	5a                   	pop    %edx
    25e1:	68 a7 48 00 00       	push   $0x48a7
    25e6:	6a 01                	push   $0x1
    25e8:	e8 03 14 00 00       	call   39f0 <printf>
    25ed:	83 c4 10             	add    $0x10,%esp
    25f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    25f3:	5b                   	pop    %ebx
    25f4:	5e                   	pop    %esi
    25f5:	5f                   	pop    %edi
    25f6:	5d                   	pop    %ebp
    25f7:	c3                   	ret    
    25f8:	83 ec 08             	sub    $0x8,%esp
    25fb:	68 74 48 00 00       	push   $0x4874
    2600:	6a 01                	push   $0x1
    2602:	e8 e9 13 00 00       	call   39f0 <printf>
    2607:	e8 96 12 00 00       	call   38a2 <exit>
    260c:	83 ec 08             	sub    $0x8,%esp
    260f:	68 60 48 00 00       	push   $0x4860
    2614:	6a 01                	push   $0x1
    2616:	e8 d5 13 00 00       	call   39f0 <printf>
    261b:	e8 82 12 00 00       	call   38a2 <exit>
    2620:	83 ec 08             	sub    $0x8,%esp
    2623:	68 4b 48 00 00       	push   $0x484b
    2628:	6a 01                	push   $0x1
    262a:	e8 c1 13 00 00       	call   39f0 <printf>
    262f:	e8 6e 12 00 00       	call   38a2 <exit>
    2634:	83 ec 08             	sub    $0x8,%esp
    2637:	68 20 48 00 00       	push   $0x4820
    263c:	6a 01                	push   $0x1
    263e:	e8 ad 13 00 00       	call   39f0 <printf>
    2643:	e8 5a 12 00 00       	call   38a2 <exit>
    2648:	83 ec 08             	sub    $0x8,%esp
    264b:	68 36 48 00 00       	push   $0x4836
    2650:	6a 01                	push   $0x1
    2652:	e8 99 13 00 00       	call   39f0 <printf>
    2657:	e8 46 12 00 00       	call   38a2 <exit>
    265c:	83 ec 08             	sub    $0x8,%esp
    265f:	68 0a 48 00 00       	push   $0x480a
    2664:	6a 01                	push   $0x1
    2666:	e8 85 13 00 00       	call   39f0 <printf>
    266b:	e8 32 12 00 00       	call   38a2 <exit>
    2670:	83 ec 08             	sub    $0x8,%esp
    2673:	68 8d 48 00 00       	push   $0x488d
    2678:	6a 01                	push   $0x1
    267a:	e8 71 13 00 00       	call   39f0 <printf>
    267f:	e8 1e 12 00 00       	call   38a2 <exit>
    2684:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    268a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00002690 <fourteen>:
    2690:	55                   	push   %ebp
    2691:	89 e5                	mov    %esp,%ebp
    2693:	83 ec 10             	sub    $0x10,%esp
    2696:	68 b8 48 00 00       	push   $0x48b8
    269b:	6a 01                	push   $0x1
    269d:	e8 4e 13 00 00       	call   39f0 <printf>
    26a2:	c7 04 24 f3 48 00 00 	movl   $0x48f3,(%esp)
    26a9:	e8 5c 12 00 00       	call   390a <mkdir>
    26ae:	83 c4 10             	add    $0x10,%esp
    26b1:	85 c0                	test   %eax,%eax
    26b3:	0f 85 97 00 00 00    	jne    2750 <fourteen+0xc0>
    26b9:	83 ec 0c             	sub    $0xc,%esp
    26bc:	68 b0 50 00 00       	push   $0x50b0
    26c1:	e8 44 12 00 00       	call   390a <mkdir>
    26c6:	83 c4 10             	add    $0x10,%esp
    26c9:	85 c0                	test   %eax,%eax
    26cb:	0f 85 de 00 00 00    	jne    27af <fourteen+0x11f>
    26d1:	83 ec 08             	sub    $0x8,%esp
    26d4:	68 00 02 00 00       	push   $0x200
    26d9:	68 00 51 00 00       	push   $0x5100
    26de:	e8 ff 11 00 00       	call   38e2 <open>
    26e3:	83 c4 10             	add    $0x10,%esp
    26e6:	85 c0                	test   %eax,%eax
    26e8:	0f 88 ae 00 00 00    	js     279c <fourteen+0x10c>
    26ee:	83 ec 0c             	sub    $0xc,%esp
    26f1:	50                   	push   %eax
    26f2:	e8 d3 11 00 00       	call   38ca <close>
    26f7:	58                   	pop    %eax
    26f8:	5a                   	pop    %edx
    26f9:	6a 00                	push   $0x0
    26fb:	68 70 51 00 00       	push   $0x5170
    2700:	e8 dd 11 00 00       	call   38e2 <open>
    2705:	83 c4 10             	add    $0x10,%esp
    2708:	85 c0                	test   %eax,%eax
    270a:	78 7d                	js     2789 <fourteen+0xf9>
    270c:	83 ec 0c             	sub    $0xc,%esp
    270f:	50                   	push   %eax
    2710:	e8 b5 11 00 00       	call   38ca <close>
    2715:	c7 04 24 e4 48 00 00 	movl   $0x48e4,(%esp)
    271c:	e8 e9 11 00 00       	call   390a <mkdir>
    2721:	83 c4 10             	add    $0x10,%esp
    2724:	85 c0                	test   %eax,%eax
    2726:	74 4e                	je     2776 <fourteen+0xe6>
    2728:	83 ec 0c             	sub    $0xc,%esp
    272b:	68 0c 52 00 00       	push   $0x520c
    2730:	e8 d5 11 00 00       	call   390a <mkdir>
    2735:	83 c4 10             	add    $0x10,%esp
    2738:	85 c0                	test   %eax,%eax
    273a:	74 27                	je     2763 <fourteen+0xd3>
    273c:	83 ec 08             	sub    $0x8,%esp
    273f:	68 02 49 00 00       	push   $0x4902
    2744:	6a 01                	push   $0x1
    2746:	e8 a5 12 00 00       	call   39f0 <printf>
    274b:	83 c4 10             	add    $0x10,%esp
    274e:	c9                   	leave  
    274f:	c3                   	ret    
    2750:	50                   	push   %eax
    2751:	50                   	push   %eax
    2752:	68 c7 48 00 00       	push   $0x48c7
    2757:	6a 01                	push   $0x1
    2759:	e8 92 12 00 00       	call   39f0 <printf>
    275e:	e8 3f 11 00 00       	call   38a2 <exit>
    2763:	50                   	push   %eax
    2764:	50                   	push   %eax
    2765:	68 2c 52 00 00       	push   $0x522c
    276a:	6a 01                	push   $0x1
    276c:	e8 7f 12 00 00       	call   39f0 <printf>
    2771:	e8 2c 11 00 00       	call   38a2 <exit>
    2776:	52                   	push   %edx
    2777:	52                   	push   %edx
    2778:	68 dc 51 00 00       	push   $0x51dc
    277d:	6a 01                	push   $0x1
    277f:	e8 6c 12 00 00       	call   39f0 <printf>
    2784:	e8 19 11 00 00       	call   38a2 <exit>
    2789:	51                   	push   %ecx
    278a:	51                   	push   %ecx
    278b:	68 a0 51 00 00       	push   $0x51a0
    2790:	6a 01                	push   $0x1
    2792:	e8 59 12 00 00       	call   39f0 <printf>
    2797:	e8 06 11 00 00       	call   38a2 <exit>
    279c:	51                   	push   %ecx
    279d:	51                   	push   %ecx
    279e:	68 30 51 00 00       	push   $0x5130
    27a3:	6a 01                	push   $0x1
    27a5:	e8 46 12 00 00       	call   39f0 <printf>
    27aa:	e8 f3 10 00 00       	call   38a2 <exit>
    27af:	50                   	push   %eax
    27b0:	50                   	push   %eax
    27b1:	68 d0 50 00 00       	push   $0x50d0
    27b6:	6a 01                	push   $0x1
    27b8:	e8 33 12 00 00       	call   39f0 <printf>
    27bd:	e8 e0 10 00 00       	call   38a2 <exit>
    27c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027d0 <rmdot>:
    27d0:	55                   	push   %ebp
    27d1:	89 e5                	mov    %esp,%ebp
    27d3:	83 ec 10             	sub    $0x10,%esp
    27d6:	68 0f 49 00 00       	push   $0x490f
    27db:	6a 01                	push   $0x1
    27dd:	e8 0e 12 00 00       	call   39f0 <printf>
    27e2:	c7 04 24 1b 49 00 00 	movl   $0x491b,(%esp)
    27e9:	e8 1c 11 00 00       	call   390a <mkdir>
    27ee:	83 c4 10             	add    $0x10,%esp
    27f1:	85 c0                	test   %eax,%eax
    27f3:	0f 85 b0 00 00 00    	jne    28a9 <rmdot+0xd9>
    27f9:	83 ec 0c             	sub    $0xc,%esp
    27fc:	68 1b 49 00 00       	push   $0x491b
    2801:	e8 0c 11 00 00       	call   3912 <chdir>
    2806:	83 c4 10             	add    $0x10,%esp
    2809:	85 c0                	test   %eax,%eax
    280b:	0f 85 1d 01 00 00    	jne    292e <rmdot+0x15e>
    2811:	83 ec 0c             	sub    $0xc,%esp
    2814:	68 c6 45 00 00       	push   $0x45c6
    2819:	e8 d4 10 00 00       	call   38f2 <unlink>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 84 f2 00 00 00    	je     291b <rmdot+0x14b>
    2829:	83 ec 0c             	sub    $0xc,%esp
    282c:	68 c5 45 00 00       	push   $0x45c5
    2831:	e8 bc 10 00 00       	call   38f2 <unlink>
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 84 c7 00 00 00    	je     2908 <rmdot+0x138>
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	68 99 3d 00 00       	push   $0x3d99
    2849:	e8 c4 10 00 00       	call   3912 <chdir>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 85 9c 00 00 00    	jne    28f5 <rmdot+0x125>
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 63 49 00 00       	push   $0x4963
    2861:	e8 8c 10 00 00       	call   38f2 <unlink>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	74 75                	je     28e2 <rmdot+0x112>
    286d:	83 ec 0c             	sub    $0xc,%esp
    2870:	68 81 49 00 00       	push   $0x4981
    2875:	e8 78 10 00 00       	call   38f2 <unlink>
    287a:	83 c4 10             	add    $0x10,%esp
    287d:	85 c0                	test   %eax,%eax
    287f:	74 4e                	je     28cf <rmdot+0xff>
    2881:	83 ec 0c             	sub    $0xc,%esp
    2884:	68 1b 49 00 00       	push   $0x491b
    2889:	e8 64 10 00 00       	call   38f2 <unlink>
    288e:	83 c4 10             	add    $0x10,%esp
    2891:	85 c0                	test   %eax,%eax
    2893:	75 27                	jne    28bc <rmdot+0xec>
    2895:	83 ec 08             	sub    $0x8,%esp
    2898:	68 b6 49 00 00       	push   $0x49b6
    289d:	6a 01                	push   $0x1
    289f:	e8 4c 11 00 00       	call   39f0 <printf>
    28a4:	83 c4 10             	add    $0x10,%esp
    28a7:	c9                   	leave  
    28a8:	c3                   	ret    
    28a9:	50                   	push   %eax
    28aa:	50                   	push   %eax
    28ab:	68 20 49 00 00       	push   $0x4920
    28b0:	6a 01                	push   $0x1
    28b2:	e8 39 11 00 00       	call   39f0 <printf>
    28b7:	e8 e6 0f 00 00       	call   38a2 <exit>
    28bc:	50                   	push   %eax
    28bd:	50                   	push   %eax
    28be:	68 a1 49 00 00       	push   $0x49a1
    28c3:	6a 01                	push   $0x1
    28c5:	e8 26 11 00 00       	call   39f0 <printf>
    28ca:	e8 d3 0f 00 00       	call   38a2 <exit>
    28cf:	52                   	push   %edx
    28d0:	52                   	push   %edx
    28d1:	68 89 49 00 00       	push   $0x4989
    28d6:	6a 01                	push   $0x1
    28d8:	e8 13 11 00 00       	call   39f0 <printf>
    28dd:	e8 c0 0f 00 00       	call   38a2 <exit>
    28e2:	51                   	push   %ecx
    28e3:	51                   	push   %ecx
    28e4:	68 6a 49 00 00       	push   $0x496a
    28e9:	6a 01                	push   $0x1
    28eb:	e8 00 11 00 00       	call   39f0 <printf>
    28f0:	e8 ad 0f 00 00       	call   38a2 <exit>
    28f5:	50                   	push   %eax
    28f6:	50                   	push   %eax
    28f7:	68 9b 3d 00 00       	push   $0x3d9b
    28fc:	6a 01                	push   $0x1
    28fe:	e8 ed 10 00 00       	call   39f0 <printf>
    2903:	e8 9a 0f 00 00       	call   38a2 <exit>
    2908:	50                   	push   %eax
    2909:	50                   	push   %eax
    290a:	68 54 49 00 00       	push   $0x4954
    290f:	6a 01                	push   $0x1
    2911:	e8 da 10 00 00       	call   39f0 <printf>
    2916:	e8 87 0f 00 00       	call   38a2 <exit>
    291b:	50                   	push   %eax
    291c:	50                   	push   %eax
    291d:	68 46 49 00 00       	push   $0x4946
    2922:	6a 01                	push   $0x1
    2924:	e8 c7 10 00 00       	call   39f0 <printf>
    2929:	e8 74 0f 00 00       	call   38a2 <exit>
    292e:	50                   	push   %eax
    292f:	50                   	push   %eax
    2930:	68 33 49 00 00       	push   $0x4933
    2935:	6a 01                	push   $0x1
    2937:	e8 b4 10 00 00       	call   39f0 <printf>
    293c:	e8 61 0f 00 00       	call   38a2 <exit>
    2941:	eb 0d                	jmp    2950 <dirfile>
    2943:	90                   	nop
    2944:	90                   	nop
    2945:	90                   	nop
    2946:	90                   	nop
    2947:	90                   	nop
    2948:	90                   	nop
    2949:	90                   	nop
    294a:	90                   	nop
    294b:	90                   	nop
    294c:	90                   	nop
    294d:	90                   	nop
    294e:	90                   	nop
    294f:	90                   	nop

00002950 <dirfile>:
    2950:	55                   	push   %ebp
    2951:	89 e5                	mov    %esp,%ebp
    2953:	53                   	push   %ebx
    2954:	83 ec 0c             	sub    $0xc,%esp
    2957:	68 c0 49 00 00       	push   $0x49c0
    295c:	6a 01                	push   $0x1
    295e:	e8 8d 10 00 00       	call   39f0 <printf>
    2963:	59                   	pop    %ecx
    2964:	5b                   	pop    %ebx
    2965:	68 00 02 00 00       	push   $0x200
    296a:	68 cd 49 00 00       	push   $0x49cd
    296f:	e8 6e 0f 00 00       	call   38e2 <open>
    2974:	83 c4 10             	add    $0x10,%esp
    2977:	85 c0                	test   %eax,%eax
    2979:	0f 88 43 01 00 00    	js     2ac2 <dirfile+0x172>
    297f:	83 ec 0c             	sub    $0xc,%esp
    2982:	50                   	push   %eax
    2983:	e8 42 0f 00 00       	call   38ca <close>
    2988:	c7 04 24 cd 49 00 00 	movl   $0x49cd,(%esp)
    298f:	e8 7e 0f 00 00       	call   3912 <chdir>
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	0f 84 10 01 00 00    	je     2aaf <dirfile+0x15f>
    299f:	83 ec 08             	sub    $0x8,%esp
    29a2:	6a 00                	push   $0x0
    29a4:	68 06 4a 00 00       	push   $0x4a06
    29a9:	e8 34 0f 00 00       	call   38e2 <open>
    29ae:	83 c4 10             	add    $0x10,%esp
    29b1:	85 c0                	test   %eax,%eax
    29b3:	0f 89 e3 00 00 00    	jns    2a9c <dirfile+0x14c>
    29b9:	83 ec 08             	sub    $0x8,%esp
    29bc:	68 00 02 00 00       	push   $0x200
    29c1:	68 06 4a 00 00       	push   $0x4a06
    29c6:	e8 17 0f 00 00       	call   38e2 <open>
    29cb:	83 c4 10             	add    $0x10,%esp
    29ce:	85 c0                	test   %eax,%eax
    29d0:	0f 89 c6 00 00 00    	jns    2a9c <dirfile+0x14c>
    29d6:	83 ec 0c             	sub    $0xc,%esp
    29d9:	68 06 4a 00 00       	push   $0x4a06
    29de:	e8 27 0f 00 00       	call   390a <mkdir>
    29e3:	83 c4 10             	add    $0x10,%esp
    29e6:	85 c0                	test   %eax,%eax
    29e8:	0f 84 46 01 00 00    	je     2b34 <dirfile+0x1e4>
    29ee:	83 ec 0c             	sub    $0xc,%esp
    29f1:	68 06 4a 00 00       	push   $0x4a06
    29f6:	e8 f7 0e 00 00       	call   38f2 <unlink>
    29fb:	83 c4 10             	add    $0x10,%esp
    29fe:	85 c0                	test   %eax,%eax
    2a00:	0f 84 1b 01 00 00    	je     2b21 <dirfile+0x1d1>
    2a06:	83 ec 08             	sub    $0x8,%esp
    2a09:	68 06 4a 00 00       	push   $0x4a06
    2a0e:	68 6a 4a 00 00       	push   $0x4a6a
    2a13:	e8 ea 0e 00 00       	call   3902 <link>
    2a18:	83 c4 10             	add    $0x10,%esp
    2a1b:	85 c0                	test   %eax,%eax
    2a1d:	0f 84 eb 00 00 00    	je     2b0e <dirfile+0x1be>
    2a23:	83 ec 0c             	sub    $0xc,%esp
    2a26:	68 cd 49 00 00       	push   $0x49cd
    2a2b:	e8 c2 0e 00 00       	call   38f2 <unlink>
    2a30:	83 c4 10             	add    $0x10,%esp
    2a33:	85 c0                	test   %eax,%eax
    2a35:	0f 85 c0 00 00 00    	jne    2afb <dirfile+0x1ab>
    2a3b:	83 ec 08             	sub    $0x8,%esp
    2a3e:	6a 02                	push   $0x2
    2a40:	68 c6 45 00 00       	push   $0x45c6
    2a45:	e8 98 0e 00 00       	call   38e2 <open>
    2a4a:	83 c4 10             	add    $0x10,%esp
    2a4d:	85 c0                	test   %eax,%eax
    2a4f:	0f 89 93 00 00 00    	jns    2ae8 <dirfile+0x198>
    2a55:	83 ec 08             	sub    $0x8,%esp
    2a58:	6a 00                	push   $0x0
    2a5a:	68 c6 45 00 00       	push   $0x45c6
    2a5f:	e8 7e 0e 00 00       	call   38e2 <open>
    2a64:	83 c4 0c             	add    $0xc,%esp
    2a67:	89 c3                	mov    %eax,%ebx
    2a69:	6a 01                	push   $0x1
    2a6b:	68 a9 46 00 00       	push   $0x46a9
    2a70:	50                   	push   %eax
    2a71:	e8 4c 0e 00 00       	call   38c2 <write>
    2a76:	83 c4 10             	add    $0x10,%esp
    2a79:	85 c0                	test   %eax,%eax
    2a7b:	7f 58                	jg     2ad5 <dirfile+0x185>
    2a7d:	83 ec 0c             	sub    $0xc,%esp
    2a80:	53                   	push   %ebx
    2a81:	e8 44 0e 00 00       	call   38ca <close>
    2a86:	58                   	pop    %eax
    2a87:	5a                   	pop    %edx
    2a88:	68 9d 4a 00 00       	push   $0x4a9d
    2a8d:	6a 01                	push   $0x1
    2a8f:	e8 5c 0f 00 00       	call   39f0 <printf>
    2a94:	83 c4 10             	add    $0x10,%esp
    2a97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a9a:	c9                   	leave  
    2a9b:	c3                   	ret    
    2a9c:	50                   	push   %eax
    2a9d:	50                   	push   %eax
    2a9e:	68 11 4a 00 00       	push   $0x4a11
    2aa3:	6a 01                	push   $0x1
    2aa5:	e8 46 0f 00 00       	call   39f0 <printf>
    2aaa:	e8 f3 0d 00 00       	call   38a2 <exit>
    2aaf:	50                   	push   %eax
    2ab0:	50                   	push   %eax
    2ab1:	68 ec 49 00 00       	push   $0x49ec
    2ab6:	6a 01                	push   $0x1
    2ab8:	e8 33 0f 00 00       	call   39f0 <printf>
    2abd:	e8 e0 0d 00 00       	call   38a2 <exit>
    2ac2:	52                   	push   %edx
    2ac3:	52                   	push   %edx
    2ac4:	68 d5 49 00 00       	push   $0x49d5
    2ac9:	6a 01                	push   $0x1
    2acb:	e8 20 0f 00 00       	call   39f0 <printf>
    2ad0:	e8 cd 0d 00 00       	call   38a2 <exit>
    2ad5:	51                   	push   %ecx
    2ad6:	51                   	push   %ecx
    2ad7:	68 89 4a 00 00       	push   $0x4a89
    2adc:	6a 01                	push   $0x1
    2ade:	e8 0d 0f 00 00       	call   39f0 <printf>
    2ae3:	e8 ba 0d 00 00       	call   38a2 <exit>
    2ae8:	53                   	push   %ebx
    2ae9:	53                   	push   %ebx
    2aea:	68 80 52 00 00       	push   $0x5280
    2aef:	6a 01                	push   $0x1
    2af1:	e8 fa 0e 00 00       	call   39f0 <printf>
    2af6:	e8 a7 0d 00 00       	call   38a2 <exit>
    2afb:	50                   	push   %eax
    2afc:	50                   	push   %eax
    2afd:	68 71 4a 00 00       	push   $0x4a71
    2b02:	6a 01                	push   $0x1
    2b04:	e8 e7 0e 00 00       	call   39f0 <printf>
    2b09:	e8 94 0d 00 00       	call   38a2 <exit>
    2b0e:	50                   	push   %eax
    2b0f:	50                   	push   %eax
    2b10:	68 60 52 00 00       	push   $0x5260
    2b15:	6a 01                	push   $0x1
    2b17:	e8 d4 0e 00 00       	call   39f0 <printf>
    2b1c:	e8 81 0d 00 00       	call   38a2 <exit>
    2b21:	50                   	push   %eax
    2b22:	50                   	push   %eax
    2b23:	68 4c 4a 00 00       	push   $0x4a4c
    2b28:	6a 01                	push   $0x1
    2b2a:	e8 c1 0e 00 00       	call   39f0 <printf>
    2b2f:	e8 6e 0d 00 00       	call   38a2 <exit>
    2b34:	50                   	push   %eax
    2b35:	50                   	push   %eax
    2b36:	68 2f 4a 00 00       	push   $0x4a2f
    2b3b:	6a 01                	push   $0x1
    2b3d:	e8 ae 0e 00 00       	call   39f0 <printf>
    2b42:	e8 5b 0d 00 00       	call   38a2 <exit>
    2b47:	89 f6                	mov    %esi,%esi
    2b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b50 <iref>:
    2b50:	55                   	push   %ebp
    2b51:	89 e5                	mov    %esp,%ebp
    2b53:	53                   	push   %ebx
    2b54:	bb 33 00 00 00       	mov    $0x33,%ebx
    2b59:	83 ec 0c             	sub    $0xc,%esp
    2b5c:	68 ad 4a 00 00       	push   $0x4aad
    2b61:	6a 01                	push   $0x1
    2b63:	e8 88 0e 00 00       	call   39f0 <printf>
    2b68:	83 c4 10             	add    $0x10,%esp
    2b6b:	90                   	nop
    2b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b70:	83 ec 0c             	sub    $0xc,%esp
    2b73:	68 be 4a 00 00       	push   $0x4abe
    2b78:	e8 8d 0d 00 00       	call   390a <mkdir>
    2b7d:	83 c4 10             	add    $0x10,%esp
    2b80:	85 c0                	test   %eax,%eax
    2b82:	0f 85 bb 00 00 00    	jne    2c43 <iref+0xf3>
    2b88:	83 ec 0c             	sub    $0xc,%esp
    2b8b:	68 be 4a 00 00       	push   $0x4abe
    2b90:	e8 7d 0d 00 00       	call   3912 <chdir>
    2b95:	83 c4 10             	add    $0x10,%esp
    2b98:	85 c0                	test   %eax,%eax
    2b9a:	0f 85 b7 00 00 00    	jne    2c57 <iref+0x107>
    2ba0:	83 ec 0c             	sub    $0xc,%esp
    2ba3:	68 73 41 00 00       	push   $0x4173
    2ba8:	e8 5d 0d 00 00       	call   390a <mkdir>
    2bad:	59                   	pop    %ecx
    2bae:	58                   	pop    %eax
    2baf:	68 73 41 00 00       	push   $0x4173
    2bb4:	68 6a 4a 00 00       	push   $0x4a6a
    2bb9:	e8 44 0d 00 00       	call   3902 <link>
    2bbe:	58                   	pop    %eax
    2bbf:	5a                   	pop    %edx
    2bc0:	68 00 02 00 00       	push   $0x200
    2bc5:	68 73 41 00 00       	push   $0x4173
    2bca:	e8 13 0d 00 00       	call   38e2 <open>
    2bcf:	83 c4 10             	add    $0x10,%esp
    2bd2:	85 c0                	test   %eax,%eax
    2bd4:	78 0c                	js     2be2 <iref+0x92>
    2bd6:	83 ec 0c             	sub    $0xc,%esp
    2bd9:	50                   	push   %eax
    2bda:	e8 eb 0c 00 00       	call   38ca <close>
    2bdf:	83 c4 10             	add    $0x10,%esp
    2be2:	83 ec 08             	sub    $0x8,%esp
    2be5:	68 00 02 00 00       	push   $0x200
    2bea:	68 a8 46 00 00       	push   $0x46a8
    2bef:	e8 ee 0c 00 00       	call   38e2 <open>
    2bf4:	83 c4 10             	add    $0x10,%esp
    2bf7:	85 c0                	test   %eax,%eax
    2bf9:	78 0c                	js     2c07 <iref+0xb7>
    2bfb:	83 ec 0c             	sub    $0xc,%esp
    2bfe:	50                   	push   %eax
    2bff:	e8 c6 0c 00 00       	call   38ca <close>
    2c04:	83 c4 10             	add    $0x10,%esp
    2c07:	83 ec 0c             	sub    $0xc,%esp
    2c0a:	68 a8 46 00 00       	push   $0x46a8
    2c0f:	e8 de 0c 00 00       	call   38f2 <unlink>
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	83 eb 01             	sub    $0x1,%ebx
    2c1a:	0f 85 50 ff ff ff    	jne    2b70 <iref+0x20>
    2c20:	83 ec 0c             	sub    $0xc,%esp
    2c23:	68 99 3d 00 00       	push   $0x3d99
    2c28:	e8 e5 0c 00 00       	call   3912 <chdir>
    2c2d:	58                   	pop    %eax
    2c2e:	5a                   	pop    %edx
    2c2f:	68 ec 4a 00 00       	push   $0x4aec
    2c34:	6a 01                	push   $0x1
    2c36:	e8 b5 0d 00 00       	call   39f0 <printf>
    2c3b:	83 c4 10             	add    $0x10,%esp
    2c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c41:	c9                   	leave  
    2c42:	c3                   	ret    
    2c43:	83 ec 08             	sub    $0x8,%esp
    2c46:	68 c4 4a 00 00       	push   $0x4ac4
    2c4b:	6a 01                	push   $0x1
    2c4d:	e8 9e 0d 00 00       	call   39f0 <printf>
    2c52:	e8 4b 0c 00 00       	call   38a2 <exit>
    2c57:	83 ec 08             	sub    $0x8,%esp
    2c5a:	68 d8 4a 00 00       	push   $0x4ad8
    2c5f:	6a 01                	push   $0x1
    2c61:	e8 8a 0d 00 00       	call   39f0 <printf>
    2c66:	e8 37 0c 00 00       	call   38a2 <exit>
    2c6b:	90                   	nop
    2c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002c70 <forktest>:
    2c70:	55                   	push   %ebp
    2c71:	89 e5                	mov    %esp,%ebp
    2c73:	53                   	push   %ebx
    2c74:	31 db                	xor    %ebx,%ebx
    2c76:	83 ec 0c             	sub    $0xc,%esp
    2c79:	68 00 4b 00 00       	push   $0x4b00
    2c7e:	6a 01                	push   $0x1
    2c80:	e8 6b 0d 00 00       	call   39f0 <printf>
    2c85:	83 c4 10             	add    $0x10,%esp
    2c88:	eb 13                	jmp    2c9d <forktest+0x2d>
    2c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2c90:	74 62                	je     2cf4 <forktest+0x84>
    2c92:	83 c3 01             	add    $0x1,%ebx
    2c95:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2c9b:	74 43                	je     2ce0 <forktest+0x70>
    2c9d:	e8 f8 0b 00 00       	call   389a <fork>
    2ca2:	85 c0                	test   %eax,%eax
    2ca4:	79 ea                	jns    2c90 <forktest+0x20>
    2ca6:	85 db                	test   %ebx,%ebx
    2ca8:	74 14                	je     2cbe <forktest+0x4e>
    2caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2cb0:	e8 f5 0b 00 00       	call   38aa <wait>
    2cb5:	85 c0                	test   %eax,%eax
    2cb7:	78 40                	js     2cf9 <forktest+0x89>
    2cb9:	83 eb 01             	sub    $0x1,%ebx
    2cbc:	75 f2                	jne    2cb0 <forktest+0x40>
    2cbe:	e8 e7 0b 00 00       	call   38aa <wait>
    2cc3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cc6:	75 45                	jne    2d0d <forktest+0x9d>
    2cc8:	83 ec 08             	sub    $0x8,%esp
    2ccb:	68 32 4b 00 00       	push   $0x4b32
    2cd0:	6a 01                	push   $0x1
    2cd2:	e8 19 0d 00 00       	call   39f0 <printf>
    2cd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cda:	c9                   	leave  
    2cdb:	c3                   	ret    
    2cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2ce0:	83 ec 08             	sub    $0x8,%esp
    2ce3:	68 a0 52 00 00       	push   $0x52a0
    2ce8:	6a 01                	push   $0x1
    2cea:	e8 01 0d 00 00       	call   39f0 <printf>
    2cef:	e8 ae 0b 00 00       	call   38a2 <exit>
    2cf4:	e8 a9 0b 00 00       	call   38a2 <exit>
    2cf9:	83 ec 08             	sub    $0x8,%esp
    2cfc:	68 0b 4b 00 00       	push   $0x4b0b
    2d01:	6a 01                	push   $0x1
    2d03:	e8 e8 0c 00 00       	call   39f0 <printf>
    2d08:	e8 95 0b 00 00       	call   38a2 <exit>
    2d0d:	83 ec 08             	sub    $0x8,%esp
    2d10:	68 1f 4b 00 00       	push   $0x4b1f
    2d15:	6a 01                	push   $0x1
    2d17:	e8 d4 0c 00 00       	call   39f0 <printf>
    2d1c:	e8 81 0b 00 00       	call   38a2 <exit>
    2d21:	eb 0d                	jmp    2d30 <sbrktest>
    2d23:	90                   	nop
    2d24:	90                   	nop
    2d25:	90                   	nop
    2d26:	90                   	nop
    2d27:	90                   	nop
    2d28:	90                   	nop
    2d29:	90                   	nop
    2d2a:	90                   	nop
    2d2b:	90                   	nop
    2d2c:	90                   	nop
    2d2d:	90                   	nop
    2d2e:	90                   	nop
    2d2f:	90                   	nop

00002d30 <sbrktest>:
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
    2d35:	53                   	push   %ebx
    2d36:	31 f6                	xor    %esi,%esi
    2d38:	83 ec 64             	sub    $0x64,%esp
    2d3b:	68 40 4b 00 00       	push   $0x4b40
    2d40:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    2d46:	e8 a5 0c 00 00       	call   39f0 <printf>
    2d4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d52:	e8 d3 0b 00 00       	call   392a <sbrk>
    2d57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d5e:	89 c7                	mov    %eax,%edi
    2d60:	e8 c5 0b 00 00       	call   392a <sbrk>
    2d65:	83 c4 10             	add    $0x10,%esp
    2d68:	89 c3                	mov    %eax,%ebx
    2d6a:	eb 06                	jmp    2d72 <sbrktest+0x42>
    2d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d70:	89 c3                	mov    %eax,%ebx
    2d72:	83 ec 0c             	sub    $0xc,%esp
    2d75:	6a 01                	push   $0x1
    2d77:	e8 ae 0b 00 00       	call   392a <sbrk>
    2d7c:	83 c4 10             	add    $0x10,%esp
    2d7f:	39 d8                	cmp    %ebx,%eax
    2d81:	0f 85 83 02 00 00    	jne    300a <sbrktest+0x2da>
    2d87:	83 c6 01             	add    $0x1,%esi
    2d8a:	c6 03 01             	movb   $0x1,(%ebx)
    2d8d:	8d 43 01             	lea    0x1(%ebx),%eax
    2d90:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2d96:	75 d8                	jne    2d70 <sbrktest+0x40>
    2d98:	e8 fd 0a 00 00       	call   389a <fork>
    2d9d:	85 c0                	test   %eax,%eax
    2d9f:	89 c6                	mov    %eax,%esi
    2da1:	0f 88 91 03 00 00    	js     3138 <sbrktest+0x408>
    2da7:	83 ec 0c             	sub    $0xc,%esp
    2daa:	83 c3 02             	add    $0x2,%ebx
    2dad:	6a 01                	push   $0x1
    2daf:	e8 76 0b 00 00       	call   392a <sbrk>
    2db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dbb:	e8 6a 0b 00 00       	call   392a <sbrk>
    2dc0:	83 c4 10             	add    $0x10,%esp
    2dc3:	39 d8                	cmp    %ebx,%eax
    2dc5:	0f 85 55 03 00 00    	jne    3120 <sbrktest+0x3f0>
    2dcb:	85 f6                	test   %esi,%esi
    2dcd:	0f 84 48 03 00 00    	je     311b <sbrktest+0x3eb>
    2dd3:	e8 d2 0a 00 00       	call   38aa <wait>
    2dd8:	83 ec 0c             	sub    $0xc,%esp
    2ddb:	6a 00                	push   $0x0
    2ddd:	e8 48 0b 00 00       	call   392a <sbrk>
    2de2:	89 c3                	mov    %eax,%ebx
    2de4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2de9:	29 d8                	sub    %ebx,%eax
    2deb:	89 04 24             	mov    %eax,(%esp)
    2dee:	e8 37 0b 00 00       	call   392a <sbrk>
    2df3:	83 c4 10             	add    $0x10,%esp
    2df6:	39 c3                	cmp    %eax,%ebx
    2df8:	0f 85 05 03 00 00    	jne    3103 <sbrktest+0x3d3>
    2dfe:	83 ec 0c             	sub    $0xc,%esp
    2e01:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
    2e08:	6a 00                	push   $0x0
    2e0a:	e8 1b 0b 00 00       	call   392a <sbrk>
    2e0f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2e16:	89 c3                	mov    %eax,%ebx
    2e18:	e8 0d 0b 00 00       	call   392a <sbrk>
    2e1d:	83 c4 10             	add    $0x10,%esp
    2e20:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e23:	0f 84 c2 02 00 00    	je     30eb <sbrktest+0x3bb>
    2e29:	83 ec 0c             	sub    $0xc,%esp
    2e2c:	6a 00                	push   $0x0
    2e2e:	e8 f7 0a 00 00       	call   392a <sbrk>
    2e33:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2e39:	83 c4 10             	add    $0x10,%esp
    2e3c:	39 d0                	cmp    %edx,%eax
    2e3e:	0f 85 90 02 00 00    	jne    30d4 <sbrktest+0x3a4>
    2e44:	83 ec 0c             	sub    $0xc,%esp
    2e47:	6a 00                	push   $0x0
    2e49:	e8 dc 0a 00 00       	call   392a <sbrk>
    2e4e:	89 c3                	mov    %eax,%ebx
    2e50:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e57:	e8 ce 0a 00 00       	call   392a <sbrk>
    2e5c:	83 c4 10             	add    $0x10,%esp
    2e5f:	39 c3                	cmp    %eax,%ebx
    2e61:	89 c6                	mov    %eax,%esi
    2e63:	0f 85 54 02 00 00    	jne    30bd <sbrktest+0x38d>
    2e69:	83 ec 0c             	sub    $0xc,%esp
    2e6c:	6a 00                	push   $0x0
    2e6e:	e8 b7 0a 00 00       	call   392a <sbrk>
    2e73:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2e79:	83 c4 10             	add    $0x10,%esp
    2e7c:	39 d0                	cmp    %edx,%eax
    2e7e:	0f 85 39 02 00 00    	jne    30bd <sbrktest+0x38d>
    2e84:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e8b:	0f 84 14 02 00 00    	je     30a5 <sbrktest+0x375>
    2e91:	83 ec 0c             	sub    $0xc,%esp
    2e94:	6a 00                	push   $0x0
    2e96:	e8 8f 0a 00 00       	call   392a <sbrk>
    2e9b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ea2:	89 c3                	mov    %eax,%ebx
    2ea4:	e8 81 0a 00 00       	call   392a <sbrk>
    2ea9:	89 f9                	mov    %edi,%ecx
    2eab:	29 c1                	sub    %eax,%ecx
    2ead:	89 0c 24             	mov    %ecx,(%esp)
    2eb0:	e8 75 0a 00 00       	call   392a <sbrk>
    2eb5:	83 c4 10             	add    $0x10,%esp
    2eb8:	39 c3                	cmp    %eax,%ebx
    2eba:	0f 85 ce 01 00 00    	jne    308e <sbrktest+0x35e>
    2ec0:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2ec5:	8d 76 00             	lea    0x0(%esi),%esi
    2ec8:	e8 55 0a 00 00       	call   3922 <getpid>
    2ecd:	89 c6                	mov    %eax,%esi
    2ecf:	e8 c6 09 00 00       	call   389a <fork>
    2ed4:	85 c0                	test   %eax,%eax
    2ed6:	0f 88 9a 01 00 00    	js     3076 <sbrktest+0x346>
    2edc:	0f 84 72 01 00 00    	je     3054 <sbrktest+0x324>
    2ee2:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2ee8:	e8 bd 09 00 00       	call   38aa <wait>
    2eed:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2ef3:	75 d3                	jne    2ec8 <sbrktest+0x198>
    2ef5:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ef8:	83 ec 0c             	sub    $0xc,%esp
    2efb:	50                   	push   %eax
    2efc:	e8 b1 09 00 00       	call   38b2 <pipe>
    2f01:	83 c4 10             	add    $0x10,%esp
    2f04:	85 c0                	test   %eax,%eax
    2f06:	0f 85 34 01 00 00    	jne    3040 <sbrktest+0x310>
    2f0c:	8d 75 c0             	lea    -0x40(%ebp),%esi
    2f0f:	89 f3                	mov    %esi,%ebx
    2f11:	e8 84 09 00 00       	call   389a <fork>
    2f16:	85 c0                	test   %eax,%eax
    2f18:	89 03                	mov    %eax,(%ebx)
    2f1a:	0f 84 a5 00 00 00    	je     2fc5 <sbrktest+0x295>
    2f20:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f23:	74 14                	je     2f39 <sbrktest+0x209>
    2f25:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f28:	83 ec 04             	sub    $0x4,%esp
    2f2b:	6a 01                	push   $0x1
    2f2d:	50                   	push   %eax
    2f2e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f31:	e8 84 09 00 00       	call   38ba <read>
    2f36:	83 c4 10             	add    $0x10,%esp
    2f39:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f3c:	83 c3 04             	add    $0x4,%ebx
    2f3f:	39 c3                	cmp    %eax,%ebx
    2f41:	75 ce                	jne    2f11 <sbrktest+0x1e1>
    2f43:	83 ec 0c             	sub    $0xc,%esp
    2f46:	68 00 10 00 00       	push   $0x1000
    2f4b:	e8 da 09 00 00       	call   392a <sbrk>
    2f50:	83 c4 10             	add    $0x10,%esp
    2f53:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    2f56:	8b 06                	mov    (%esi),%eax
    2f58:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f5b:	74 11                	je     2f6e <sbrktest+0x23e>
    2f5d:	83 ec 0c             	sub    $0xc,%esp
    2f60:	50                   	push   %eax
    2f61:	e8 6c 09 00 00       	call   38d2 <kill>
    2f66:	e8 3f 09 00 00       	call   38aa <wait>
    2f6b:	83 c4 10             	add    $0x10,%esp
    2f6e:	83 c6 04             	add    $0x4,%esi
    2f71:	39 f3                	cmp    %esi,%ebx
    2f73:	75 e1                	jne    2f56 <sbrktest+0x226>
    2f75:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2f79:	0f 84 a9 00 00 00    	je     3028 <sbrktest+0x2f8>
    2f7f:	83 ec 0c             	sub    $0xc,%esp
    2f82:	6a 00                	push   $0x0
    2f84:	e8 a1 09 00 00       	call   392a <sbrk>
    2f89:	83 c4 10             	add    $0x10,%esp
    2f8c:	39 c7                	cmp    %eax,%edi
    2f8e:	73 17                	jae    2fa7 <sbrktest+0x277>
    2f90:	83 ec 0c             	sub    $0xc,%esp
    2f93:	6a 00                	push   $0x0
    2f95:	e8 90 09 00 00       	call   392a <sbrk>
    2f9a:	29 c7                	sub    %eax,%edi
    2f9c:	89 3c 24             	mov    %edi,(%esp)
    2f9f:	e8 86 09 00 00       	call   392a <sbrk>
    2fa4:	83 c4 10             	add    $0x10,%esp
    2fa7:	83 ec 08             	sub    $0x8,%esp
    2faa:	68 e8 4b 00 00       	push   $0x4be8
    2faf:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    2fb5:	e8 36 0a 00 00       	call   39f0 <printf>
    2fba:	83 c4 10             	add    $0x10,%esp
    2fbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fc0:	5b                   	pop    %ebx
    2fc1:	5e                   	pop    %esi
    2fc2:	5f                   	pop    %edi
    2fc3:	5d                   	pop    %ebp
    2fc4:	c3                   	ret    
    2fc5:	83 ec 0c             	sub    $0xc,%esp
    2fc8:	6a 00                	push   $0x0
    2fca:	e8 5b 09 00 00       	call   392a <sbrk>
    2fcf:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2fd4:	29 c2                	sub    %eax,%edx
    2fd6:	89 14 24             	mov    %edx,(%esp)
    2fd9:	e8 4c 09 00 00       	call   392a <sbrk>
    2fde:	83 c4 0c             	add    $0xc,%esp
    2fe1:	6a 01                	push   $0x1
    2fe3:	68 a9 46 00 00       	push   $0x46a9
    2fe8:	ff 75 bc             	pushl  -0x44(%ebp)
    2feb:	e8 d2 08 00 00       	call   38c2 <write>
    2ff0:	83 c4 10             	add    $0x10,%esp
    2ff3:	90                   	nop
    2ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2ff8:	83 ec 0c             	sub    $0xc,%esp
    2ffb:	68 e8 03 00 00       	push   $0x3e8
    3000:	e8 2d 09 00 00       	call   3932 <sleep>
    3005:	83 c4 10             	add    $0x10,%esp
    3008:	eb ee                	jmp    2ff8 <sbrktest+0x2c8>
    300a:	83 ec 0c             	sub    $0xc,%esp
    300d:	50                   	push   %eax
    300e:	53                   	push   %ebx
    300f:	56                   	push   %esi
    3010:	68 4b 4b 00 00       	push   $0x4b4b
    3015:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    301b:	e8 d0 09 00 00       	call   39f0 <printf>
    3020:	83 c4 20             	add    $0x20,%esp
    3023:	e8 7a 08 00 00       	call   38a2 <exit>
    3028:	83 ec 08             	sub    $0x8,%esp
    302b:	68 cd 4b 00 00       	push   $0x4bcd
    3030:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3036:	e8 b5 09 00 00       	call   39f0 <printf>
    303b:	e8 62 08 00 00       	call   38a2 <exit>
    3040:	83 ec 08             	sub    $0x8,%esp
    3043:	68 89 40 00 00       	push   $0x4089
    3048:	6a 01                	push   $0x1
    304a:	e8 a1 09 00 00       	call   39f0 <printf>
    304f:	e8 4e 08 00 00       	call   38a2 <exit>
    3054:	0f be 03             	movsbl (%ebx),%eax
    3057:	50                   	push   %eax
    3058:	53                   	push   %ebx
    3059:	68 b4 4b 00 00       	push   $0x4bb4
    305e:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3064:	e8 87 09 00 00       	call   39f0 <printf>
    3069:	89 34 24             	mov    %esi,(%esp)
    306c:	e8 61 08 00 00       	call   38d2 <kill>
    3071:	e8 2c 08 00 00       	call   38a2 <exit>
    3076:	83 ec 08             	sub    $0x8,%esp
    3079:	68 91 4c 00 00       	push   $0x4c91
    307e:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3084:	e8 67 09 00 00       	call   39f0 <printf>
    3089:	e8 14 08 00 00       	call   38a2 <exit>
    308e:	50                   	push   %eax
    308f:	53                   	push   %ebx
    3090:	68 94 53 00 00       	push   $0x5394
    3095:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    309b:	e8 50 09 00 00       	call   39f0 <printf>
    30a0:	e8 fd 07 00 00       	call   38a2 <exit>
    30a5:	83 ec 08             	sub    $0x8,%esp
    30a8:	68 64 53 00 00       	push   $0x5364
    30ad:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    30b3:	e8 38 09 00 00       	call   39f0 <printf>
    30b8:	e8 e5 07 00 00       	call   38a2 <exit>
    30bd:	56                   	push   %esi
    30be:	53                   	push   %ebx
    30bf:	68 3c 53 00 00       	push   $0x533c
    30c4:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    30ca:	e8 21 09 00 00       	call   39f0 <printf>
    30cf:	e8 ce 07 00 00       	call   38a2 <exit>
    30d4:	50                   	push   %eax
    30d5:	53                   	push   %ebx
    30d6:	68 04 53 00 00       	push   $0x5304
    30db:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    30e1:	e8 0a 09 00 00       	call   39f0 <printf>
    30e6:	e8 b7 07 00 00       	call   38a2 <exit>
    30eb:	83 ec 08             	sub    $0x8,%esp
    30ee:	68 99 4b 00 00       	push   $0x4b99
    30f3:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    30f9:	e8 f2 08 00 00       	call   39f0 <printf>
    30fe:	e8 9f 07 00 00       	call   38a2 <exit>
    3103:	83 ec 08             	sub    $0x8,%esp
    3106:	68 c4 52 00 00       	push   $0x52c4
    310b:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3111:	e8 da 08 00 00       	call   39f0 <printf>
    3116:	e8 87 07 00 00       	call   38a2 <exit>
    311b:	e8 82 07 00 00       	call   38a2 <exit>
    3120:	83 ec 08             	sub    $0x8,%esp
    3123:	68 7d 4b 00 00       	push   $0x4b7d
    3128:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    312e:	e8 bd 08 00 00       	call   39f0 <printf>
    3133:	e8 6a 07 00 00       	call   38a2 <exit>
    3138:	83 ec 08             	sub    $0x8,%esp
    313b:	68 66 4b 00 00       	push   $0x4b66
    3140:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3146:	e8 a5 08 00 00       	call   39f0 <printf>
    314b:	e8 52 07 00 00       	call   38a2 <exit>

00003150 <validateint>:
    3150:	55                   	push   %ebp
    3151:	89 e5                	mov    %esp,%ebp
    3153:	5d                   	pop    %ebp
    3154:	c3                   	ret    
    3155:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003160 <validatetest>:
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
    3163:	56                   	push   %esi
    3164:	53                   	push   %ebx
    3165:	31 db                	xor    %ebx,%ebx
    3167:	83 ec 08             	sub    $0x8,%esp
    316a:	68 f6 4b 00 00       	push   $0x4bf6
    316f:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3175:	e8 76 08 00 00       	call   39f0 <printf>
    317a:	83 c4 10             	add    $0x10,%esp
    317d:	8d 76 00             	lea    0x0(%esi),%esi
    3180:	e8 15 07 00 00       	call   389a <fork>
    3185:	85 c0                	test   %eax,%eax
    3187:	89 c6                	mov    %eax,%esi
    3189:	74 63                	je     31ee <validatetest+0x8e>
    318b:	83 ec 0c             	sub    $0xc,%esp
    318e:	6a 00                	push   $0x0
    3190:	e8 9d 07 00 00       	call   3932 <sleep>
    3195:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    319c:	e8 91 07 00 00       	call   3932 <sleep>
    31a1:	89 34 24             	mov    %esi,(%esp)
    31a4:	e8 29 07 00 00       	call   38d2 <kill>
    31a9:	e8 fc 06 00 00       	call   38aa <wait>
    31ae:	58                   	pop    %eax
    31af:	5a                   	pop    %edx
    31b0:	53                   	push   %ebx
    31b1:	68 05 4c 00 00       	push   $0x4c05
    31b6:	e8 47 07 00 00       	call   3902 <link>
    31bb:	83 c4 10             	add    $0x10,%esp
    31be:	83 f8 ff             	cmp    $0xffffffff,%eax
    31c1:	75 30                	jne    31f3 <validatetest+0x93>
    31c3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    31c9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    31cf:	75 af                	jne    3180 <validatetest+0x20>
    31d1:	83 ec 08             	sub    $0x8,%esp
    31d4:	68 29 4c 00 00       	push   $0x4c29
    31d9:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    31df:	e8 0c 08 00 00       	call   39f0 <printf>
    31e4:	83 c4 10             	add    $0x10,%esp
    31e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31ea:	5b                   	pop    %ebx
    31eb:	5e                   	pop    %esi
    31ec:	5d                   	pop    %ebp
    31ed:	c3                   	ret    
    31ee:	e8 af 06 00 00       	call   38a2 <exit>
    31f3:	83 ec 08             	sub    $0x8,%esp
    31f6:	68 10 4c 00 00       	push   $0x4c10
    31fb:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3201:	e8 ea 07 00 00       	call   39f0 <printf>
    3206:	e8 97 06 00 00       	call   38a2 <exit>
    320b:	90                   	nop
    320c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003210 <bsstest>:
    3210:	55                   	push   %ebp
    3211:	89 e5                	mov    %esp,%ebp
    3213:	83 ec 10             	sub    $0x10,%esp
    3216:	68 36 4c 00 00       	push   $0x4c36
    321b:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3221:	e8 ca 07 00 00       	call   39f0 <printf>
    3226:	83 c4 10             	add    $0x10,%esp
    3229:	80 3d a0 5e 00 00 00 	cmpb   $0x0,0x5ea0
    3230:	75 39                	jne    326b <bsstest+0x5b>
    3232:	b8 01 00 00 00       	mov    $0x1,%eax
    3237:	89 f6                	mov    %esi,%esi
    3239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3240:	80 b8 a0 5e 00 00 00 	cmpb   $0x0,0x5ea0(%eax)
    3247:	75 22                	jne    326b <bsstest+0x5b>
    3249:	83 c0 01             	add    $0x1,%eax
    324c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3251:	75 ed                	jne    3240 <bsstest+0x30>
    3253:	83 ec 08             	sub    $0x8,%esp
    3256:	68 51 4c 00 00       	push   $0x4c51
    325b:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3261:	e8 8a 07 00 00       	call   39f0 <printf>
    3266:	83 c4 10             	add    $0x10,%esp
    3269:	c9                   	leave  
    326a:	c3                   	ret    
    326b:	83 ec 08             	sub    $0x8,%esp
    326e:	68 40 4c 00 00       	push   $0x4c40
    3273:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3279:	e8 72 07 00 00       	call   39f0 <printf>
    327e:	e8 1f 06 00 00       	call   38a2 <exit>
    3283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003290 <bigargtest>:
    3290:	55                   	push   %ebp
    3291:	89 e5                	mov    %esp,%ebp
    3293:	83 ec 14             	sub    $0x14,%esp
    3296:	68 5e 4c 00 00       	push   $0x4c5e
    329b:	e8 52 06 00 00       	call   38f2 <unlink>
    32a0:	e8 f5 05 00 00       	call   389a <fork>
    32a5:	83 c4 10             	add    $0x10,%esp
    32a8:	85 c0                	test   %eax,%eax
    32aa:	74 3f                	je     32eb <bigargtest+0x5b>
    32ac:	0f 88 c2 00 00 00    	js     3374 <bigargtest+0xe4>
    32b2:	e8 f3 05 00 00       	call   38aa <wait>
    32b7:	83 ec 08             	sub    $0x8,%esp
    32ba:	6a 00                	push   $0x0
    32bc:	68 5e 4c 00 00       	push   $0x4c5e
    32c1:	e8 1c 06 00 00       	call   38e2 <open>
    32c6:	83 c4 10             	add    $0x10,%esp
    32c9:	85 c0                	test   %eax,%eax
    32cb:	0f 88 8c 00 00 00    	js     335d <bigargtest+0xcd>
    32d1:	83 ec 0c             	sub    $0xc,%esp
    32d4:	50                   	push   %eax
    32d5:	e8 f0 05 00 00       	call   38ca <close>
    32da:	c7 04 24 5e 4c 00 00 	movl   $0x4c5e,(%esp)
    32e1:	e8 0c 06 00 00       	call   38f2 <unlink>
    32e6:	83 c4 10             	add    $0x10,%esp
    32e9:	c9                   	leave  
    32ea:	c3                   	ret    
    32eb:	b8 00 5e 00 00       	mov    $0x5e00,%eax
    32f0:	c7 00 b8 53 00 00    	movl   $0x53b8,(%eax)
    32f6:	83 c0 04             	add    $0x4,%eax
    32f9:	3d 7c 5e 00 00       	cmp    $0x5e7c,%eax
    32fe:	75 f0                	jne    32f0 <bigargtest+0x60>
    3300:	51                   	push   %ecx
    3301:	51                   	push   %ecx
    3302:	68 68 4c 00 00       	push   $0x4c68
    3307:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    330d:	c7 05 7c 5e 00 00 00 	movl   $0x0,0x5e7c
    3314:	00 00 00 
    3317:	e8 d4 06 00 00       	call   39f0 <printf>
    331c:	58                   	pop    %eax
    331d:	5a                   	pop    %edx
    331e:	68 00 5e 00 00       	push   $0x5e00
    3323:	68 35 3e 00 00       	push   $0x3e35
    3328:	e8 ad 05 00 00       	call   38da <exec>
    332d:	59                   	pop    %ecx
    332e:	58                   	pop    %eax
    332f:	68 75 4c 00 00       	push   $0x4c75
    3334:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    333a:	e8 b1 06 00 00       	call   39f0 <printf>
    333f:	58                   	pop    %eax
    3340:	5a                   	pop    %edx
    3341:	68 00 02 00 00       	push   $0x200
    3346:	68 5e 4c 00 00       	push   $0x4c5e
    334b:	e8 92 05 00 00       	call   38e2 <open>
    3350:	89 04 24             	mov    %eax,(%esp)
    3353:	e8 72 05 00 00       	call   38ca <close>
    3358:	e8 45 05 00 00       	call   38a2 <exit>
    335d:	50                   	push   %eax
    335e:	50                   	push   %eax
    335f:	68 9e 4c 00 00       	push   $0x4c9e
    3364:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    336a:	e8 81 06 00 00       	call   39f0 <printf>
    336f:	e8 2e 05 00 00       	call   38a2 <exit>
    3374:	52                   	push   %edx
    3375:	52                   	push   %edx
    3376:	68 85 4c 00 00       	push   $0x4c85
    337b:	ff 35 cc 5d 00 00    	pushl  0x5dcc
    3381:	e8 6a 06 00 00       	call   39f0 <printf>
    3386:	e8 17 05 00 00       	call   38a2 <exit>
    338b:	90                   	nop
    338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003390 <fsfull>:
    3390:	55                   	push   %ebp
    3391:	89 e5                	mov    %esp,%ebp
    3393:	57                   	push   %edi
    3394:	56                   	push   %esi
    3395:	53                   	push   %ebx
    3396:	31 db                	xor    %ebx,%ebx
    3398:	83 ec 54             	sub    $0x54,%esp
    339b:	68 b3 4c 00 00       	push   $0x4cb3
    33a0:	6a 01                	push   $0x1
    33a2:	e8 49 06 00 00       	call   39f0 <printf>
    33a7:	83 c4 10             	add    $0x10,%esp
    33aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    33b0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    33b5:	89 de                	mov    %ebx,%esi
    33b7:	89 d9                	mov    %ebx,%ecx
    33b9:	f7 eb                	imul   %ebx
    33bb:	c1 fe 1f             	sar    $0x1f,%esi
    33be:	89 df                	mov    %ebx,%edi
    33c0:	83 ec 04             	sub    $0x4,%esp
    33c3:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    33c7:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    33cb:	c1 fa 06             	sar    $0x6,%edx
    33ce:	29 f2                	sub    %esi,%edx
    33d0:	8d 42 30             	lea    0x30(%edx),%eax
    33d3:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    33d9:	88 45 a9             	mov    %al,-0x57(%ebp)
    33dc:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33e1:	29 d1                	sub    %edx,%ecx
    33e3:	f7 e9                	imul   %ecx
    33e5:	c1 f9 1f             	sar    $0x1f,%ecx
    33e8:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33ed:	c1 fa 05             	sar    $0x5,%edx
    33f0:	29 ca                	sub    %ecx,%edx
    33f2:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    33f7:	83 c2 30             	add    $0x30,%edx
    33fa:	88 55 aa             	mov    %dl,-0x56(%ebp)
    33fd:	f7 eb                	imul   %ebx
    33ff:	c1 fa 05             	sar    $0x5,%edx
    3402:	29 f2                	sub    %esi,%edx
    3404:	6b d2 64             	imul   $0x64,%edx,%edx
    3407:	29 d7                	sub    %edx,%edi
    3409:	89 f8                	mov    %edi,%eax
    340b:	c1 ff 1f             	sar    $0x1f,%edi
    340e:	f7 e9                	imul   %ecx
    3410:	89 d8                	mov    %ebx,%eax
    3412:	c1 fa 02             	sar    $0x2,%edx
    3415:	29 fa                	sub    %edi,%edx
    3417:	83 c2 30             	add    $0x30,%edx
    341a:	88 55 ab             	mov    %dl,-0x55(%ebp)
    341d:	f7 e9                	imul   %ecx
    341f:	89 d9                	mov    %ebx,%ecx
    3421:	c1 fa 02             	sar    $0x2,%edx
    3424:	29 f2                	sub    %esi,%edx
    3426:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3429:	01 c0                	add    %eax,%eax
    342b:	29 c1                	sub    %eax,%ecx
    342d:	89 c8                	mov    %ecx,%eax
    342f:	83 c0 30             	add    $0x30,%eax
    3432:	88 45 ac             	mov    %al,-0x54(%ebp)
    3435:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3438:	50                   	push   %eax
    3439:	68 c0 4c 00 00       	push   $0x4cc0
    343e:	6a 01                	push   $0x1
    3440:	e8 ab 05 00 00       	call   39f0 <printf>
    3445:	58                   	pop    %eax
    3446:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3449:	5a                   	pop    %edx
    344a:	68 02 02 00 00       	push   $0x202
    344f:	50                   	push   %eax
    3450:	e8 8d 04 00 00       	call   38e2 <open>
    3455:	83 c4 10             	add    $0x10,%esp
    3458:	85 c0                	test   %eax,%eax
    345a:	89 c7                	mov    %eax,%edi
    345c:	78 50                	js     34ae <fsfull+0x11e>
    345e:	31 f6                	xor    %esi,%esi
    3460:	eb 08                	jmp    346a <fsfull+0xda>
    3462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3468:	01 c6                	add    %eax,%esi
    346a:	83 ec 04             	sub    $0x4,%esp
    346d:	68 00 02 00 00       	push   $0x200
    3472:	68 c0 85 00 00       	push   $0x85c0
    3477:	57                   	push   %edi
    3478:	e8 45 04 00 00       	call   38c2 <write>
    347d:	83 c4 10             	add    $0x10,%esp
    3480:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3485:	7f e1                	jg     3468 <fsfull+0xd8>
    3487:	83 ec 04             	sub    $0x4,%esp
    348a:	56                   	push   %esi
    348b:	68 dc 4c 00 00       	push   $0x4cdc
    3490:	6a 01                	push   $0x1
    3492:	e8 59 05 00 00       	call   39f0 <printf>
    3497:	89 3c 24             	mov    %edi,(%esp)
    349a:	e8 2b 04 00 00       	call   38ca <close>
    349f:	83 c4 10             	add    $0x10,%esp
    34a2:	85 f6                	test   %esi,%esi
    34a4:	74 22                	je     34c8 <fsfull+0x138>
    34a6:	83 c3 01             	add    $0x1,%ebx
    34a9:	e9 02 ff ff ff       	jmp    33b0 <fsfull+0x20>
    34ae:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34b1:	83 ec 04             	sub    $0x4,%esp
    34b4:	50                   	push   %eax
    34b5:	68 cc 4c 00 00       	push   $0x4ccc
    34ba:	6a 01                	push   $0x1
    34bc:	e8 2f 05 00 00       	call   39f0 <printf>
    34c1:	83 c4 10             	add    $0x10,%esp
    34c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    34c8:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    34cd:	89 de                	mov    %ebx,%esi
    34cf:	89 d9                	mov    %ebx,%ecx
    34d1:	f7 eb                	imul   %ebx
    34d3:	c1 fe 1f             	sar    $0x1f,%esi
    34d6:	89 df                	mov    %ebx,%edi
    34d8:	83 ec 0c             	sub    $0xc,%esp
    34db:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    34df:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    34e3:	c1 fa 06             	sar    $0x6,%edx
    34e6:	29 f2                	sub    %esi,%edx
    34e8:	8d 42 30             	lea    0x30(%edx),%eax
    34eb:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    34f1:	88 45 a9             	mov    %al,-0x57(%ebp)
    34f4:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    34f9:	29 d1                	sub    %edx,%ecx
    34fb:	f7 e9                	imul   %ecx
    34fd:	c1 f9 1f             	sar    $0x1f,%ecx
    3500:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3505:	c1 fa 05             	sar    $0x5,%edx
    3508:	29 ca                	sub    %ecx,%edx
    350a:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    350f:	83 c2 30             	add    $0x30,%edx
    3512:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3515:	f7 eb                	imul   %ebx
    3517:	c1 fa 05             	sar    $0x5,%edx
    351a:	29 f2                	sub    %esi,%edx
    351c:	6b d2 64             	imul   $0x64,%edx,%edx
    351f:	29 d7                	sub    %edx,%edi
    3521:	89 f8                	mov    %edi,%eax
    3523:	c1 ff 1f             	sar    $0x1f,%edi
    3526:	f7 e9                	imul   %ecx
    3528:	89 d8                	mov    %ebx,%eax
    352a:	c1 fa 02             	sar    $0x2,%edx
    352d:	29 fa                	sub    %edi,%edx
    352f:	83 c2 30             	add    $0x30,%edx
    3532:	88 55 ab             	mov    %dl,-0x55(%ebp)
    3535:	f7 e9                	imul   %ecx
    3537:	89 d9                	mov    %ebx,%ecx
    3539:	83 eb 01             	sub    $0x1,%ebx
    353c:	c1 fa 02             	sar    $0x2,%edx
    353f:	29 f2                	sub    %esi,%edx
    3541:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3544:	01 c0                	add    %eax,%eax
    3546:	29 c1                	sub    %eax,%ecx
    3548:	89 c8                	mov    %ecx,%eax
    354a:	83 c0 30             	add    $0x30,%eax
    354d:	88 45 ac             	mov    %al,-0x54(%ebp)
    3550:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3553:	50                   	push   %eax
    3554:	e8 99 03 00 00       	call   38f2 <unlink>
    3559:	83 c4 10             	add    $0x10,%esp
    355c:	83 fb ff             	cmp    $0xffffffff,%ebx
    355f:	0f 85 63 ff ff ff    	jne    34c8 <fsfull+0x138>
    3565:	83 ec 08             	sub    $0x8,%esp
    3568:	68 ec 4c 00 00       	push   $0x4cec
    356d:	6a 01                	push   $0x1
    356f:	e8 7c 04 00 00       	call   39f0 <printf>
    3574:	83 c4 10             	add    $0x10,%esp
    3577:	8d 65 f4             	lea    -0xc(%ebp),%esp
    357a:	5b                   	pop    %ebx
    357b:	5e                   	pop    %esi
    357c:	5f                   	pop    %edi
    357d:	5d                   	pop    %ebp
    357e:	c3                   	ret    
    357f:	90                   	nop

00003580 <uio>:
    3580:	55                   	push   %ebp
    3581:	89 e5                	mov    %esp,%ebp
    3583:	83 ec 10             	sub    $0x10,%esp
    3586:	68 02 4d 00 00       	push   $0x4d02
    358b:	6a 01                	push   $0x1
    358d:	e8 5e 04 00 00       	call   39f0 <printf>
    3592:	e8 03 03 00 00       	call   389a <fork>
    3597:	83 c4 10             	add    $0x10,%esp
    359a:	85 c0                	test   %eax,%eax
    359c:	74 1b                	je     35b9 <uio+0x39>
    359e:	78 3d                	js     35dd <uio+0x5d>
    35a0:	e8 05 03 00 00       	call   38aa <wait>
    35a5:	83 ec 08             	sub    $0x8,%esp
    35a8:	68 0c 4d 00 00       	push   $0x4d0c
    35ad:	6a 01                	push   $0x1
    35af:	e8 3c 04 00 00       	call   39f0 <printf>
    35b4:	83 c4 10             	add    $0x10,%esp
    35b7:	c9                   	leave  
    35b8:	c3                   	ret    
    35b9:	ba 70 00 00 00       	mov    $0x70,%edx
    35be:	b8 09 00 00 00       	mov    $0x9,%eax
    35c3:	ee                   	out    %al,(%dx)
    35c4:	ba 71 00 00 00       	mov    $0x71,%edx
    35c9:	ec                   	in     (%dx),%al
    35ca:	52                   	push   %edx
    35cb:	52                   	push   %edx
    35cc:	68 98 54 00 00       	push   $0x5498
    35d1:	6a 01                	push   $0x1
    35d3:	e8 18 04 00 00       	call   39f0 <printf>
    35d8:	e8 c5 02 00 00       	call   38a2 <exit>
    35dd:	50                   	push   %eax
    35de:	50                   	push   %eax
    35df:	68 91 4c 00 00       	push   $0x4c91
    35e4:	6a 01                	push   $0x1
    35e6:	e8 05 04 00 00       	call   39f0 <printf>
    35eb:	e8 b2 02 00 00       	call   38a2 <exit>

000035f0 <argptest>:
    35f0:	55                   	push   %ebp
    35f1:	89 e5                	mov    %esp,%ebp
    35f3:	53                   	push   %ebx
    35f4:	83 ec 0c             	sub    $0xc,%esp
    35f7:	6a 00                	push   $0x0
    35f9:	68 1b 4d 00 00       	push   $0x4d1b
    35fe:	e8 df 02 00 00       	call   38e2 <open>
    3603:	83 c4 10             	add    $0x10,%esp
    3606:	85 c0                	test   %eax,%eax
    3608:	78 39                	js     3643 <argptest+0x53>
    360a:	83 ec 0c             	sub    $0xc,%esp
    360d:	89 c3                	mov    %eax,%ebx
    360f:	6a 00                	push   $0x0
    3611:	e8 14 03 00 00       	call   392a <sbrk>
    3616:	83 c4 0c             	add    $0xc,%esp
    3619:	83 e8 01             	sub    $0x1,%eax
    361c:	6a ff                	push   $0xffffffff
    361e:	50                   	push   %eax
    361f:	53                   	push   %ebx
    3620:	e8 95 02 00 00       	call   38ba <read>
    3625:	89 1c 24             	mov    %ebx,(%esp)
    3628:	e8 9d 02 00 00       	call   38ca <close>
    362d:	58                   	pop    %eax
    362e:	5a                   	pop    %edx
    362f:	68 2d 4d 00 00       	push   $0x4d2d
    3634:	6a 01                	push   $0x1
    3636:	e8 b5 03 00 00       	call   39f0 <printf>
    363b:	83 c4 10             	add    $0x10,%esp
    363e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3641:	c9                   	leave  
    3642:	c3                   	ret    
    3643:	51                   	push   %ecx
    3644:	51                   	push   %ecx
    3645:	68 20 4d 00 00       	push   $0x4d20
    364a:	6a 02                	push   $0x2
    364c:	e8 9f 03 00 00       	call   39f0 <printf>
    3651:	e8 4c 02 00 00       	call   38a2 <exit>
    3656:	8d 76 00             	lea    0x0(%esi),%esi
    3659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003660 <rand>:
    3660:	69 05 c8 5d 00 00 0d 	imul   $0x19660d,0x5dc8,%eax
    3667:	66 19 00 
    366a:	55                   	push   %ebp
    366b:	89 e5                	mov    %esp,%ebp
    366d:	5d                   	pop    %ebp
    366e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3673:	a3 c8 5d 00 00       	mov    %eax,0x5dc8
    3678:	c3                   	ret    
    3679:	66 90                	xchg   %ax,%ax
    367b:	66 90                	xchg   %ax,%ax
    367d:	66 90                	xchg   %ax,%ax
    367f:	90                   	nop

00003680 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	8b 45 08             	mov    0x8(%ebp),%eax
    3686:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    3689:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    368a:	89 c2                	mov    %eax,%edx
    368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3690:	83 c1 01             	add    $0x1,%ecx
    3693:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3697:	83 c2 01             	add    $0x1,%edx
    369a:	84 db                	test   %bl,%bl
    369c:	88 5a ff             	mov    %bl,-0x1(%edx)
    369f:	75 ef                	jne    3690 <strcpy+0x10>
    ;
  return os;
}
    36a1:	5b                   	pop    %ebx
    36a2:	5d                   	pop    %ebp
    36a3:	c3                   	ret    
    36a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000036b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	8b 55 08             	mov    0x8(%ebp),%edx
    36b6:	53                   	push   %ebx
    36b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    36ba:	0f b6 02             	movzbl (%edx),%eax
    36bd:	84 c0                	test   %al,%al
    36bf:	74 2d                	je     36ee <strcmp+0x3e>
    36c1:	0f b6 19             	movzbl (%ecx),%ebx
    36c4:	38 d8                	cmp    %bl,%al
    36c6:	74 0e                	je     36d6 <strcmp+0x26>
    36c8:	eb 2b                	jmp    36f5 <strcmp+0x45>
    36ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36d0:	38 c8                	cmp    %cl,%al
    36d2:	75 15                	jne    36e9 <strcmp+0x39>
    p++, q++;
    36d4:	89 d9                	mov    %ebx,%ecx
    36d6:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36d9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    36dc:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36df:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
    36e3:	84 c0                	test   %al,%al
    36e5:	75 e9                	jne    36d0 <strcmp+0x20>
    36e7:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    36e9:	29 c8                	sub    %ecx,%eax
}
    36eb:	5b                   	pop    %ebx
    36ec:	5d                   	pop    %ebp
    36ed:	c3                   	ret    
    36ee:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36f1:	31 c0                	xor    %eax,%eax
    36f3:	eb f4                	jmp    36e9 <strcmp+0x39>
    36f5:	0f b6 cb             	movzbl %bl,%ecx
    36f8:	eb ef                	jmp    36e9 <strcmp+0x39>
    36fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003700 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
    3700:	55                   	push   %ebp
    3701:	89 e5                	mov    %esp,%ebp
    3703:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3706:	80 39 00             	cmpb   $0x0,(%ecx)
    3709:	74 12                	je     371d <strlen+0x1d>
    370b:	31 d2                	xor    %edx,%edx
    370d:	8d 76 00             	lea    0x0(%esi),%esi
    3710:	83 c2 01             	add    $0x1,%edx
    3713:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3717:	89 d0                	mov    %edx,%eax
    3719:	75 f5                	jne    3710 <strlen+0x10>
    ;
  return n;
}
    371b:	5d                   	pop    %ebp
    371c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    371d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    371f:	5d                   	pop    %ebp
    3720:	c3                   	ret    
    3721:	eb 0d                	jmp    3730 <memset>
    3723:	90                   	nop
    3724:	90                   	nop
    3725:	90                   	nop
    3726:	90                   	nop
    3727:	90                   	nop
    3728:	90                   	nop
    3729:	90                   	nop
    372a:	90                   	nop
    372b:	90                   	nop
    372c:	90                   	nop
    372d:	90                   	nop
    372e:	90                   	nop
    372f:	90                   	nop

00003730 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3730:	55                   	push   %ebp
    3731:	89 e5                	mov    %esp,%ebp
    3733:	8b 55 08             	mov    0x8(%ebp),%edx
    3736:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3737:	8b 4d 10             	mov    0x10(%ebp),%ecx
    373a:	8b 45 0c             	mov    0xc(%ebp),%eax
    373d:	89 d7                	mov    %edx,%edi
    373f:	fc                   	cld    
    3740:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3742:	89 d0                	mov    %edx,%eax
    3744:	5f                   	pop    %edi
    3745:	5d                   	pop    %ebp
    3746:	c3                   	ret    
    3747:	89 f6                	mov    %esi,%esi
    3749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003750 <strchr>:

char*
strchr(const char *s, char c)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	8b 45 08             	mov    0x8(%ebp),%eax
    3756:	53                   	push   %ebx
    3757:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
    375a:	0f b6 18             	movzbl (%eax),%ebx
    375d:	84 db                	test   %bl,%bl
    375f:	74 1d                	je     377e <strchr+0x2e>
    if(*s == c)
    3761:	38 d3                	cmp    %dl,%bl
    3763:	89 d1                	mov    %edx,%ecx
    3765:	75 0d                	jne    3774 <strchr+0x24>
    3767:	eb 17                	jmp    3780 <strchr+0x30>
    3769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3770:	38 ca                	cmp    %cl,%dl
    3772:	74 0c                	je     3780 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3774:	83 c0 01             	add    $0x1,%eax
    3777:	0f b6 10             	movzbl (%eax),%edx
    377a:	84 d2                	test   %dl,%dl
    377c:	75 f2                	jne    3770 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    377e:	31 c0                	xor    %eax,%eax
}
    3780:	5b                   	pop    %ebx
    3781:	5d                   	pop    %ebp
    3782:	c3                   	ret    
    3783:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003790 <gets>:

char*
gets(char *buf, int max)
{
    3790:	55                   	push   %ebp
    3791:	89 e5                	mov    %esp,%ebp
    3793:	57                   	push   %edi
    3794:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3795:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
    3797:	53                   	push   %ebx
    3798:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    379b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    379e:	eb 31                	jmp    37d1 <gets+0x41>
    cc = read(0, &c, 1);
    37a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    37a7:	00 
    37a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
    37ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37b3:	e8 02 01 00 00       	call   38ba <read>
    if(cc < 1)
    37b8:	85 c0                	test   %eax,%eax
    37ba:	7e 1d                	jle    37d9 <gets+0x49>
      break;
    buf[i++] = c;
    37bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    37c0:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    37c2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
    37c5:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    37c7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    37cb:	74 0c                	je     37d9 <gets+0x49>
    37cd:	3c 0a                	cmp    $0xa,%al
    37cf:	74 08                	je     37d9 <gets+0x49>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    37d1:	8d 5e 01             	lea    0x1(%esi),%ebx
    37d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37d7:	7c c7                	jl     37a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    37d9:	8b 45 08             	mov    0x8(%ebp),%eax
    37dc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    37e0:	83 c4 2c             	add    $0x2c,%esp
    37e3:	5b                   	pop    %ebx
    37e4:	5e                   	pop    %esi
    37e5:	5f                   	pop    %edi
    37e6:	5d                   	pop    %ebp
    37e7:	c3                   	ret    
    37e8:	90                   	nop
    37e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000037f0 <stat>:

int
stat(const char *n, struct stat *st)
{
    37f0:	55                   	push   %ebp
    37f1:	89 e5                	mov    %esp,%ebp
    37f3:	56                   	push   %esi
    37f4:	53                   	push   %ebx
    37f5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    37f8:	8b 45 08             	mov    0x8(%ebp),%eax
    37fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3802:	00 
    3803:	89 04 24             	mov    %eax,(%esp)
    3806:	e8 d7 00 00 00       	call   38e2 <open>
  if(fd < 0)
    380b:	85 c0                	test   %eax,%eax
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    380d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    380f:	78 27                	js     3838 <stat+0x48>
    return -1;
  r = fstat(fd, st);
    3811:	8b 45 0c             	mov    0xc(%ebp),%eax
    3814:	89 1c 24             	mov    %ebx,(%esp)
    3817:	89 44 24 04          	mov    %eax,0x4(%esp)
    381b:	e8 da 00 00 00       	call   38fa <fstat>
  close(fd);
    3820:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    3823:	89 c6                	mov    %eax,%esi
  close(fd);
    3825:	e8 a0 00 00 00       	call   38ca <close>
  return r;
    382a:	89 f0                	mov    %esi,%eax
}
    382c:	83 c4 10             	add    $0x10,%esp
    382f:	5b                   	pop    %ebx
    3830:	5e                   	pop    %esi
    3831:	5d                   	pop    %ebp
    3832:	c3                   	ret    
    3833:	90                   	nop
    3834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    3838:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    383d:	eb ed                	jmp    382c <stat+0x3c>
    383f:	90                   	nop

00003840 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3840:	55                   	push   %ebp
    3841:	89 e5                	mov    %esp,%ebp
    3843:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3846:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3847:	0f be 11             	movsbl (%ecx),%edx
    384a:	8d 42 d0             	lea    -0x30(%edx),%eax
    384d:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
    384f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    3854:	77 17                	ja     386d <atoi+0x2d>
    3856:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3858:	83 c1 01             	add    $0x1,%ecx
    385b:	8d 04 80             	lea    (%eax,%eax,4),%eax
    385e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3862:	0f be 11             	movsbl (%ecx),%edx
    3865:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3868:	80 fb 09             	cmp    $0x9,%bl
    386b:	76 eb                	jbe    3858 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    386d:	5b                   	pop    %ebx
    386e:	5d                   	pop    %ebp
    386f:	c3                   	ret    

00003870 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3870:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3871:	31 d2                	xor    %edx,%edx
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3873:	89 e5                	mov    %esp,%ebp
    3875:	56                   	push   %esi
    3876:	8b 45 08             	mov    0x8(%ebp),%eax
    3879:	53                   	push   %ebx
    387a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    387d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3880:	85 db                	test   %ebx,%ebx
    3882:	7e 12                	jle    3896 <memmove+0x26>
    3884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    3888:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    388c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    388f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3892:	39 da                	cmp    %ebx,%edx
    3894:	75 f2                	jne    3888 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    3896:	5b                   	pop    %ebx
    3897:	5e                   	pop    %esi
    3898:	5d                   	pop    %ebp
    3899:	c3                   	ret    

0000389a <fork>:
    389a:	b8 01 00 00 00       	mov    $0x1,%eax
    389f:	cd 40                	int    $0x40
    38a1:	c3                   	ret    

000038a2 <exit>:
    38a2:	b8 02 00 00 00       	mov    $0x2,%eax
    38a7:	cd 40                	int    $0x40
    38a9:	c3                   	ret    

000038aa <wait>:
    38aa:	b8 03 00 00 00       	mov    $0x3,%eax
    38af:	cd 40                	int    $0x40
    38b1:	c3                   	ret    

000038b2 <pipe>:
    38b2:	b8 04 00 00 00       	mov    $0x4,%eax
    38b7:	cd 40                	int    $0x40
    38b9:	c3                   	ret    

000038ba <read>:
    38ba:	b8 05 00 00 00       	mov    $0x5,%eax
    38bf:	cd 40                	int    $0x40
    38c1:	c3                   	ret    

000038c2 <write>:
    38c2:	b8 10 00 00 00       	mov    $0x10,%eax
    38c7:	cd 40                	int    $0x40
    38c9:	c3                   	ret    

000038ca <close>:
    38ca:	b8 15 00 00 00       	mov    $0x15,%eax
    38cf:	cd 40                	int    $0x40
    38d1:	c3                   	ret    

000038d2 <kill>:
    38d2:	b8 06 00 00 00       	mov    $0x6,%eax
    38d7:	cd 40                	int    $0x40
    38d9:	c3                   	ret    

000038da <exec>:
    38da:	b8 07 00 00 00       	mov    $0x7,%eax
    38df:	cd 40                	int    $0x40
    38e1:	c3                   	ret    

000038e2 <open>:
    38e2:	b8 0f 00 00 00       	mov    $0xf,%eax
    38e7:	cd 40                	int    $0x40
    38e9:	c3                   	ret    

000038ea <mknod>:
    38ea:	b8 11 00 00 00       	mov    $0x11,%eax
    38ef:	cd 40                	int    $0x40
    38f1:	c3                   	ret    

000038f2 <unlink>:
    38f2:	b8 12 00 00 00       	mov    $0x12,%eax
    38f7:	cd 40                	int    $0x40
    38f9:	c3                   	ret    

000038fa <fstat>:
    38fa:	b8 08 00 00 00       	mov    $0x8,%eax
    38ff:	cd 40                	int    $0x40
    3901:	c3                   	ret    

00003902 <link>:
    3902:	b8 13 00 00 00       	mov    $0x13,%eax
    3907:	cd 40                	int    $0x40
    3909:	c3                   	ret    

0000390a <mkdir>:
    390a:	b8 14 00 00 00       	mov    $0x14,%eax
    390f:	cd 40                	int    $0x40
    3911:	c3                   	ret    

00003912 <chdir>:
    3912:	b8 09 00 00 00       	mov    $0x9,%eax
    3917:	cd 40                	int    $0x40
    3919:	c3                   	ret    

0000391a <dup>:
    391a:	b8 0a 00 00 00       	mov    $0xa,%eax
    391f:	cd 40                	int    $0x40
    3921:	c3                   	ret    

00003922 <getpid>:
    3922:	b8 0b 00 00 00       	mov    $0xb,%eax
    3927:	cd 40                	int    $0x40
    3929:	c3                   	ret    

0000392a <sbrk>:
    392a:	b8 0c 00 00 00       	mov    $0xc,%eax
    392f:	cd 40                	int    $0x40
    3931:	c3                   	ret    

00003932 <sleep>:
    3932:	b8 0d 00 00 00       	mov    $0xd,%eax
    3937:	cd 40                	int    $0x40
    3939:	c3                   	ret    

0000393a <uptime>:
    393a:	b8 0e 00 00 00       	mov    $0xe,%eax
    393f:	cd 40                	int    $0x40
    3941:	c3                   	ret    
    3942:	66 90                	xchg   %ax,%ax
    3944:	66 90                	xchg   %ax,%ax
    3946:	66 90                	xchg   %ax,%ax
    3948:	66 90                	xchg   %ax,%ax
    394a:	66 90                	xchg   %ax,%ax
    394c:	66 90                	xchg   %ax,%ax
    394e:	66 90                	xchg   %ax,%ax

00003950 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3950:	55                   	push   %ebp
    3951:	89 e5                	mov    %esp,%ebp
    3953:	57                   	push   %edi
    3954:	56                   	push   %esi
    3955:	89 c6                	mov    %eax,%esi
    3957:	53                   	push   %ebx
    3958:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    395b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    395e:	85 db                	test   %ebx,%ebx
    3960:	74 09                	je     396b <printint+0x1b>
    3962:	89 d0                	mov    %edx,%eax
    3964:	c1 e8 1f             	shr    $0x1f,%eax
    3967:	84 c0                	test   %al,%al
    3969:	75 75                	jne    39e0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    396b:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    396d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3974:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    3977:	31 ff                	xor    %edi,%edi
    3979:	89 ce                	mov    %ecx,%esi
    397b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    397e:	eb 02                	jmp    3982 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
    3980:	89 cf                	mov    %ecx,%edi
    3982:	31 d2                	xor    %edx,%edx
    3984:	f7 f6                	div    %esi
    3986:	8d 4f 01             	lea    0x1(%edi),%ecx
    3989:	0f b6 92 ef 54 00 00 	movzbl 0x54ef(%edx),%edx
  }while((x /= base) != 0);
    3990:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3992:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    3995:	75 e9                	jne    3980 <printint+0x30>
  if(neg)
    3997:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    399a:	89 c8                	mov    %ecx,%eax
    399c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  }while((x /= base) != 0);
  if(neg)
    399f:	85 d2                	test   %edx,%edx
    39a1:	74 08                	je     39ab <printint+0x5b>
    buf[i++] = '-';
    39a3:	8d 4f 02             	lea    0x2(%edi),%ecx
    39a6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
    39ab:	8d 79 ff             	lea    -0x1(%ecx),%edi
    39ae:	66 90                	xchg   %ax,%ax
    39b0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
    39b5:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    39b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    39bf:	00 
    39c0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    39c4:	89 34 24             	mov    %esi,(%esp)
    39c7:	88 45 d7             	mov    %al,-0x29(%ebp)
    39ca:	e8 f3 fe ff ff       	call   38c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    39cf:	83 ff ff             	cmp    $0xffffffff,%edi
    39d2:	75 dc                	jne    39b0 <printint+0x60>
    putc(fd, buf[i]);
}
    39d4:	83 c4 4c             	add    $0x4c,%esp
    39d7:	5b                   	pop    %ebx
    39d8:	5e                   	pop    %esi
    39d9:	5f                   	pop    %edi
    39da:	5d                   	pop    %ebp
    39db:	c3                   	ret    
    39dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    39e0:	89 d0                	mov    %edx,%eax
    39e2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    39e4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    39eb:	eb 87                	jmp    3974 <printint+0x24>
    39ed:	8d 76 00             	lea    0x0(%esi),%esi

000039f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    39f0:	55                   	push   %ebp
    39f1:	89 e5                	mov    %esp,%ebp
    39f3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    39f4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    39f6:	56                   	push   %esi
    39f7:	53                   	push   %ebx
    39f8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    39fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    39fe:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3a01:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    3a04:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    3a07:	0f b6 13             	movzbl (%ebx),%edx
    3a0a:	83 c3 01             	add    $0x1,%ebx
    3a0d:	84 d2                	test   %dl,%dl
    3a0f:	75 39                	jne    3a4a <printf+0x5a>
    3a11:	e9 c2 00 00 00       	jmp    3ad8 <printf+0xe8>
    3a16:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3a18:	83 fa 25             	cmp    $0x25,%edx
    3a1b:	0f 84 bf 00 00 00    	je     3ae0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a21:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3a24:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3a2b:	00 
    3a2c:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a30:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    3a33:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a36:	e8 87 fe ff ff       	call   38c2 <write>
    3a3b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a3e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3a42:	84 d2                	test   %dl,%dl
    3a44:	0f 84 8e 00 00 00    	je     3ad8 <printf+0xe8>
    c = fmt[i] & 0xff;
    if(state == 0){
    3a4a:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    3a4c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
    3a4f:	74 c7                	je     3a18 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3a51:	83 ff 25             	cmp    $0x25,%edi
    3a54:	75 e5                	jne    3a3b <printf+0x4b>
      if(c == 'd'){
    3a56:	83 fa 64             	cmp    $0x64,%edx
    3a59:	0f 84 31 01 00 00    	je     3b90 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3a5f:	25 f7 00 00 00       	and    $0xf7,%eax
    3a64:	83 f8 70             	cmp    $0x70,%eax
    3a67:	0f 84 83 00 00 00    	je     3af0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3a6d:	83 fa 73             	cmp    $0x73,%edx
    3a70:	0f 84 a2 00 00 00    	je     3b18 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3a76:	83 fa 63             	cmp    $0x63,%edx
    3a79:	0f 84 35 01 00 00    	je     3bb4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3a7f:	83 fa 25             	cmp    $0x25,%edx
    3a82:	0f 84 e0 00 00 00    	je     3b68 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a88:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3a8b:	83 c3 01             	add    $0x1,%ebx
    3a8e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3a95:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3a96:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a98:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a9c:	89 34 24             	mov    %esi,(%esp)
    3a9f:	89 55 d0             	mov    %edx,-0x30(%ebp)
    3aa2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
    3aa6:	e8 17 fe ff ff       	call   38c2 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3aab:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3aae:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3ab1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3ab8:	00 
    3ab9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3abd:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3ac0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3ac3:	e8 fa fd ff ff       	call   38c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3ac8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3acc:	84 d2                	test   %dl,%dl
    3ace:	0f 85 76 ff ff ff    	jne    3a4a <printf+0x5a>
    3ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3ad8:	83 c4 3c             	add    $0x3c,%esp
    3adb:	5b                   	pop    %ebx
    3adc:	5e                   	pop    %esi
    3add:	5f                   	pop    %edi
    3ade:	5d                   	pop    %ebp
    3adf:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3ae0:	bf 25 00 00 00       	mov    $0x25,%edi
    3ae5:	e9 51 ff ff ff       	jmp    3a3b <printf+0x4b>
    3aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3af0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3af3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3af8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3afa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b01:	8b 10                	mov    (%eax),%edx
    3b03:	89 f0                	mov    %esi,%eax
    3b05:	e8 46 fe ff ff       	call   3950 <printint>
        ap++;
    3b0a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3b0e:	e9 28 ff ff ff       	jmp    3a3b <printf+0x4b>
    3b13:	90                   	nop
    3b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    3b18:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
    3b1b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    3b1f:	8b 38                	mov    (%eax),%edi
        ap++;
        if(s == 0)
          s = "(null)";
    3b21:	b8 e8 54 00 00       	mov    $0x54e8,%eax
    3b26:	85 ff                	test   %edi,%edi
    3b28:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
    3b2b:	0f b6 07             	movzbl (%edi),%eax
    3b2e:	84 c0                	test   %al,%al
    3b30:	74 2a                	je     3b5c <printf+0x16c>
    3b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3b38:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b3b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3b3e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b41:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3b48:	00 
    3b49:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b4d:	89 34 24             	mov    %esi,(%esp)
    3b50:	e8 6d fd ff ff       	call   38c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3b55:	0f b6 07             	movzbl (%edi),%eax
    3b58:	84 c0                	test   %al,%al
    3b5a:	75 dc                	jne    3b38 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b5c:	31 ff                	xor    %edi,%edi
    3b5e:	e9 d8 fe ff ff       	jmp    3a3b <printf+0x4b>
    3b63:	90                   	nop
    3b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b68:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b6b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b6d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3b74:	00 
    3b75:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b79:	89 34 24             	mov    %esi,(%esp)
    3b7c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
    3b80:	e8 3d fd ff ff       	call   38c2 <write>
    3b85:	e9 b1 fe ff ff       	jmp    3a3b <printf+0x4b>
    3b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3b90:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3b93:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b98:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3b9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3ba2:	8b 10                	mov    (%eax),%edx
    3ba4:	89 f0                	mov    %esi,%eax
    3ba6:	e8 a5 fd ff ff       	call   3950 <printint>
        ap++;
    3bab:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3baf:	e9 87 fe ff ff       	jmp    3a3b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3bb4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3bb7:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3bb9:	8b 00                	mov    (%eax),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3bbb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3bc2:	00 
    3bc3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3bc6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3bc9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
    3bd0:	e8 ed fc ff ff       	call   38c2 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    3bd5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3bd9:	e9 5d fe ff ff       	jmp    3a3b <printf+0x4b>
    3bde:	66 90                	xchg   %ax,%ax

00003be0 <free>:
    3be0:	55                   	push   %ebp
    3be1:	a1 80 5e 00 00       	mov    0x5e80,%eax
    3be6:	89 e5                	mov    %esp,%ebp
    3be8:	57                   	push   %edi
    3be9:	56                   	push   %esi
    3bea:	53                   	push   %ebx
    3beb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3bee:	8b 10                	mov    (%eax),%edx
    3bf0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    3bf3:	39 c8                	cmp    %ecx,%eax
    3bf5:	73 19                	jae    3c10 <free+0x30>
    3bf7:	89 f6                	mov    %esi,%esi
    3bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3c00:	39 d1                	cmp    %edx,%ecx
    3c02:	72 1c                	jb     3c20 <free+0x40>
    3c04:	39 d0                	cmp    %edx,%eax
    3c06:	73 18                	jae    3c20 <free+0x40>
    3c08:	89 d0                	mov    %edx,%eax
    3c0a:	39 c8                	cmp    %ecx,%eax
    3c0c:	8b 10                	mov    (%eax),%edx
    3c0e:	72 f0                	jb     3c00 <free+0x20>
    3c10:	39 d0                	cmp    %edx,%eax
    3c12:	72 f4                	jb     3c08 <free+0x28>
    3c14:	39 d1                	cmp    %edx,%ecx
    3c16:	73 f0                	jae    3c08 <free+0x28>
    3c18:	90                   	nop
    3c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c20:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c23:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c26:	39 fa                	cmp    %edi,%edx
    3c28:	74 19                	je     3c43 <free+0x63>
    3c2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3c2d:	8b 50 04             	mov    0x4(%eax),%edx
    3c30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c33:	39 f1                	cmp    %esi,%ecx
    3c35:	74 23                	je     3c5a <free+0x7a>
    3c37:	89 08                	mov    %ecx,(%eax)
    3c39:	a3 80 5e 00 00       	mov    %eax,0x5e80
    3c3e:	5b                   	pop    %ebx
    3c3f:	5e                   	pop    %esi
    3c40:	5f                   	pop    %edi
    3c41:	5d                   	pop    %ebp
    3c42:	c3                   	ret    
    3c43:	03 72 04             	add    0x4(%edx),%esi
    3c46:	89 73 fc             	mov    %esi,-0x4(%ebx)
    3c49:	8b 10                	mov    (%eax),%edx
    3c4b:	8b 12                	mov    (%edx),%edx
    3c4d:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3c50:	8b 50 04             	mov    0x4(%eax),%edx
    3c53:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c56:	39 f1                	cmp    %esi,%ecx
    3c58:	75 dd                	jne    3c37 <free+0x57>
    3c5a:	03 53 fc             	add    -0x4(%ebx),%edx
    3c5d:	a3 80 5e 00 00       	mov    %eax,0x5e80
    3c62:	89 50 04             	mov    %edx,0x4(%eax)
    3c65:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3c68:	89 10                	mov    %edx,(%eax)
    3c6a:	5b                   	pop    %ebx
    3c6b:	5e                   	pop    %esi
    3c6c:	5f                   	pop    %edi
    3c6d:	5d                   	pop    %ebp
    3c6e:	c3                   	ret    
    3c6f:	90                   	nop

00003c70 <malloc>:
    3c70:	55                   	push   %ebp
    3c71:	89 e5                	mov    %esp,%ebp
    3c73:	57                   	push   %edi
    3c74:	56                   	push   %esi
    3c75:	53                   	push   %ebx
    3c76:	83 ec 0c             	sub    $0xc,%esp
    3c79:	8b 45 08             	mov    0x8(%ebp),%eax
    3c7c:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
    3c82:	8d 78 07             	lea    0x7(%eax),%edi
    3c85:	c1 ef 03             	shr    $0x3,%edi
    3c88:	83 c7 01             	add    $0x1,%edi
    3c8b:	85 d2                	test   %edx,%edx
    3c8d:	0f 84 93 00 00 00    	je     3d26 <malloc+0xb6>
    3c93:	8b 02                	mov    (%edx),%eax
    3c95:	8b 48 04             	mov    0x4(%eax),%ecx
    3c98:	39 cf                	cmp    %ecx,%edi
    3c9a:	76 64                	jbe    3d00 <malloc+0x90>
    3c9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3ca2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3ca7:	0f 43 df             	cmovae %edi,%ebx
    3caa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3cb1:	eb 0e                	jmp    3cc1 <malloc+0x51>
    3cb3:	90                   	nop
    3cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3cb8:	8b 02                	mov    (%edx),%eax
    3cba:	8b 48 04             	mov    0x4(%eax),%ecx
    3cbd:	39 cf                	cmp    %ecx,%edi
    3cbf:	76 3f                	jbe    3d00 <malloc+0x90>
    3cc1:	39 05 80 5e 00 00    	cmp    %eax,0x5e80
    3cc7:	89 c2                	mov    %eax,%edx
    3cc9:	75 ed                	jne    3cb8 <malloc+0x48>
    3ccb:	83 ec 0c             	sub    $0xc,%esp
    3cce:	56                   	push   %esi
    3ccf:	e8 56 fc ff ff       	call   392a <sbrk>
    3cd4:	83 c4 10             	add    $0x10,%esp
    3cd7:	83 f8 ff             	cmp    $0xffffffff,%eax
    3cda:	74 1c                	je     3cf8 <malloc+0x88>
    3cdc:	89 58 04             	mov    %ebx,0x4(%eax)
    3cdf:	83 ec 0c             	sub    $0xc,%esp
    3ce2:	83 c0 08             	add    $0x8,%eax
    3ce5:	50                   	push   %eax
    3ce6:	e8 f5 fe ff ff       	call   3be0 <free>
    3ceb:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
    3cf1:	83 c4 10             	add    $0x10,%esp
    3cf4:	85 d2                	test   %edx,%edx
    3cf6:	75 c0                	jne    3cb8 <malloc+0x48>
    3cf8:	31 c0                	xor    %eax,%eax
    3cfa:	eb 1c                	jmp    3d18 <malloc+0xa8>
    3cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3d00:	39 cf                	cmp    %ecx,%edi
    3d02:	74 1c                	je     3d20 <malloc+0xb0>
    3d04:	29 f9                	sub    %edi,%ecx
    3d06:	89 48 04             	mov    %ecx,0x4(%eax)
    3d09:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    3d0c:	89 78 04             	mov    %edi,0x4(%eax)
    3d0f:	89 15 80 5e 00 00    	mov    %edx,0x5e80
    3d15:	83 c0 08             	add    $0x8,%eax
    3d18:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d1b:	5b                   	pop    %ebx
    3d1c:	5e                   	pop    %esi
    3d1d:	5f                   	pop    %edi
    3d1e:	5d                   	pop    %ebp
    3d1f:	c3                   	ret    
    3d20:	8b 08                	mov    (%eax),%ecx
    3d22:	89 0a                	mov    %ecx,(%edx)
    3d24:	eb e9                	jmp    3d0f <malloc+0x9f>
    3d26:	c7 05 80 5e 00 00 84 	movl   $0x5e84,0x5e80
    3d2d:	5e 00 00 
    3d30:	c7 05 84 5e 00 00 84 	movl   $0x5e84,0x5e84
    3d37:	5e 00 00 
    3d3a:	b8 84 5e 00 00       	mov    $0x5e84,%eax
    3d3f:	c7 05 88 5e 00 00 00 	movl   $0x0,0x5e88
    3d46:	00 00 00 
    3d49:	e9 4e ff ff ff       	jmp    3c9c <malloc+0x2c>
