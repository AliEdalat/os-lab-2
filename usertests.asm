
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
      11:	68 26 4d 00 00       	push   $0x4d26
      16:	6a 01                	push   $0x1
      18:	e8 a3 39 00 00       	call   39c0 <printf>
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 3a 4d 00 00       	push   $0x4d3a
      26:	e8 87 38 00 00       	call   38b2 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 a4 54 00 00       	push   $0x54a4
      39:	6a 01                	push   $0x1
      3b:	e8 80 39 00 00       	call   39c0 <printf>
      40:	e8 2d 38 00 00       	call   3872 <exit>
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 3a 4d 00 00       	push   $0x4d3a
      51:	e8 5c 38 00 00       	call   38b2 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 3c 38 00 00       	call   389a <close>
      5e:	e8 5d 35 00 00       	call   35c0 <argptest>
      63:	e8 a8 11 00 00       	call   1210 <createdelete>
      68:	e8 63 1a 00 00       	call   1ad0 <linkunlink>
      6d:	e8 5e 17 00 00       	call   17d0 <concreate>
      72:	e8 99 0f 00 00       	call   1010 <fourfiles>
      77:	e8 d4 0d 00 00       	call   e50 <sharedfd>
      7c:	e8 ff 31 00 00       	call   3280 <bigargtest>
      81:	e8 6a 23 00 00       	call   23f0 <bigwrite>
      86:	e8 f5 31 00 00       	call   3280 <bigargtest>
      8b:	e8 70 31 00 00       	call   3200 <bsstest>
      90:	e8 9b 2c 00 00       	call   2d30 <sbrktest>
      95:	e8 b6 30 00 00       	call   3150 <validatetest>
      9a:	e8 51 03 00 00       	call   3f0 <opentest>
      9f:	e8 dc 03 00 00       	call   480 <writetest>
      a4:	e8 b7 05 00 00       	call   660 <writetest1>
      a9:	e8 82 07 00 00       	call   830 <createtest>
      ae:	e8 3d 02 00 00       	call   2f0 <openiputtest>
      b3:	e8 48 01 00 00       	call   200 <exitiputtest>
      b8:	e8 63 00 00 00       	call   120 <iputtest>
      bd:	e8 be 0c 00 00       	call   d80 <mem>
      c2:	e8 49 09 00 00       	call   a10 <pipe1>
      c7:	e8 e4 0a 00 00       	call   bb0 <preempt>
      cc:	e8 1f 0c 00 00       	call   cf0 <exitwait>
      d1:	e8 0a 27 00 00       	call   27e0 <rmdot>
      d6:	e8 c5 25 00 00       	call   26a0 <fourteen>
      db:	e8 f0 23 00 00       	call   24d0 <bigfile>
      e0:	e8 2b 1c 00 00       	call   1d10 <subdir>
      e5:	e8 d6 14 00 00       	call   15c0 <linktest>
      ea:	e8 41 13 00 00       	call   1430 <unlinkread>
      ef:	e8 6c 28 00 00       	call   2960 <dirfile>
      f4:	e8 67 2a 00 00       	call   2b60 <iref>
      f9:	e8 82 2b 00 00       	call   2c80 <forktest>
      fe:	e8 dd 1a 00 00       	call   1be0 <bigdir>
     103:	e8 48 34 00 00       	call   3550 <uio>
     108:	e8 b3 08 00 00       	call   9c0 <exectest>
     10d:	e8 60 37 00 00       	call   3872 <exit>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
     126:	68 cc 3d 00 00       	push   $0x3dcc
     12b:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     131:	e8 8a 38 00 00       	call   39c0 <printf>
     136:	c7 04 24 5f 3d 00 00 	movl   $0x3d5f,(%esp)
     13d:	e8 98 37 00 00       	call   38da <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 5f 3d 00 00       	push   $0x3d5f
     151:	e8 8c 37 00 00       	call   38e2 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 5c 3d 00 00       	push   $0x3d5c
     169:	e8 54 37 00 00       	call   38c2 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 81 3d 00 00       	push   $0x3d81
     17d:	e8 60 37 00 00       	call   38e2 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 04 3e 00 00       	push   $0x3e04
     191:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     197:	e8 24 38 00 00       	call   39c0 <printf>
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 38 3d 00 00       	push   $0x3d38
     1a8:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     1ae:	e8 0d 38 00 00       	call   39c0 <printf>
     1b3:	e8 ba 36 00 00       	call   3872 <exit>
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 83 3d 00 00       	push   $0x3d83
     1bf:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     1c5:	e8 f6 37 00 00       	call   39c0 <printf>
     1ca:	e8 a3 36 00 00       	call   3872 <exit>
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 67 3d 00 00       	push   $0x3d67
     1d6:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     1dc:	e8 df 37 00 00       	call   39c0 <printf>
     1e1:	e8 8c 36 00 00       	call   3872 <exit>
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 46 3d 00 00       	push   $0x3d46
     1ed:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     1f3:	e8 c8 37 00 00       	call   39c0 <printf>
     1f8:	e8 75 36 00 00       	call   3872 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
     206:	68 93 3d 00 00       	push   $0x3d93
     20b:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     211:	e8 aa 37 00 00       	call   39c0 <printf>
     216:	e8 4f 36 00 00       	call   386a <fork>
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 82 00 00 00    	js     2a8 <exitiputtest+0xa8>
     226:	75 48                	jne    270 <exitiputtest+0x70>
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 5f 3d 00 00       	push   $0x3d5f
     230:	e8 a5 36 00 00       	call   38da <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 96 00 00 00    	js     2d6 <exitiputtest+0xd6>
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 5f 3d 00 00       	push   $0x3d5f
     248:	e8 95 36 00 00       	call   38e2 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	78 6b                	js     2bf <exitiputtest+0xbf>
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	68 5c 3d 00 00       	push   $0x3d5c
     25c:	e8 61 36 00 00       	call   38c2 <unlink>
     261:	83 c4 10             	add    $0x10,%esp
     264:	85 c0                	test   %eax,%eax
     266:	78 28                	js     290 <exitiputtest+0x90>
     268:	e8 05 36 00 00       	call   3872 <exit>
     26d:	8d 76 00             	lea    0x0(%esi),%esi
     270:	e8 05 36 00 00       	call   387a <wait>
     275:	83 ec 08             	sub    $0x8,%esp
     278:	68 b6 3d 00 00       	push   $0x3db6
     27d:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     283:	e8 38 37 00 00       	call   39c0 <printf>
     288:	83 c4 10             	add    $0x10,%esp
     28b:	c9                   	leave  
     28c:	c3                   	ret    
     28d:	8d 76 00             	lea    0x0(%esi),%esi
     290:	83 ec 08             	sub    $0x8,%esp
     293:	68 67 3d 00 00       	push   $0x3d67
     298:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     29e:	e8 1d 37 00 00       	call   39c0 <printf>
     2a3:	e8 ca 35 00 00       	call   3872 <exit>
     2a8:	51                   	push   %ecx
     2a9:	51                   	push   %ecx
     2aa:	68 79 4c 00 00       	push   $0x4c79
     2af:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     2b5:	e8 06 37 00 00       	call   39c0 <printf>
     2ba:	e8 b3 35 00 00       	call   3872 <exit>
     2bf:	50                   	push   %eax
     2c0:	50                   	push   %eax
     2c1:	68 a2 3d 00 00       	push   $0x3da2
     2c6:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     2cc:	e8 ef 36 00 00       	call   39c0 <printf>
     2d1:	e8 9c 35 00 00       	call   3872 <exit>
     2d6:	52                   	push   %edx
     2d7:	52                   	push   %edx
     2d8:	68 38 3d 00 00       	push   $0x3d38
     2dd:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     2e3:	e8 d8 36 00 00       	call   39c0 <printf>
     2e8:	e8 85 35 00 00       	call   3872 <exit>
     2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <openiputtest>:
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	83 ec 10             	sub    $0x10,%esp
     2f6:	68 c8 3d 00 00       	push   $0x3dc8
     2fb:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     301:	e8 ba 36 00 00       	call   39c0 <printf>
     306:	c7 04 24 d7 3d 00 00 	movl   $0x3dd7,(%esp)
     30d:	e8 c8 35 00 00       	call   38da <mkdir>
     312:	83 c4 10             	add    $0x10,%esp
     315:	85 c0                	test   %eax,%eax
     317:	0f 88 88 00 00 00    	js     3a5 <openiputtest+0xb5>
     31d:	e8 48 35 00 00       	call   386a <fork>
     322:	85 c0                	test   %eax,%eax
     324:	0f 88 92 00 00 00    	js     3bc <openiputtest+0xcc>
     32a:	75 34                	jne    360 <openiputtest+0x70>
     32c:	83 ec 08             	sub    $0x8,%esp
     32f:	6a 02                	push   $0x2
     331:	68 d7 3d 00 00       	push   $0x3dd7
     336:	e8 77 35 00 00       	call   38b2 <open>
     33b:	83 c4 10             	add    $0x10,%esp
     33e:	85 c0                	test   %eax,%eax
     340:	78 5e                	js     3a0 <openiputtest+0xb0>
     342:	83 ec 08             	sub    $0x8,%esp
     345:	68 5c 4d 00 00       	push   $0x4d5c
     34a:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     350:	e8 6b 36 00 00       	call   39c0 <printf>
     355:	e8 18 35 00 00       	call   3872 <exit>
     35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     360:	83 ec 0c             	sub    $0xc,%esp
     363:	6a 01                	push   $0x1
     365:	e8 98 35 00 00       	call   3902 <sleep>
     36a:	c7 04 24 d7 3d 00 00 	movl   $0x3dd7,(%esp)
     371:	e8 4c 35 00 00       	call   38c2 <unlink>
     376:	83 c4 10             	add    $0x10,%esp
     379:	85 c0                	test   %eax,%eax
     37b:	75 56                	jne    3d3 <openiputtest+0xe3>
     37d:	e8 f8 34 00 00       	call   387a <wait>
     382:	83 ec 08             	sub    $0x8,%esp
     385:	68 00 3e 00 00       	push   $0x3e00
     38a:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     390:	e8 2b 36 00 00       	call   39c0 <printf>
     395:	83 c4 10             	add    $0x10,%esp
     398:	c9                   	leave  
     399:	c3                   	ret    
     39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3a0:	e8 cd 34 00 00       	call   3872 <exit>
     3a5:	51                   	push   %ecx
     3a6:	51                   	push   %ecx
     3a7:	68 dd 3d 00 00       	push   $0x3ddd
     3ac:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     3b2:	e8 09 36 00 00       	call   39c0 <printf>
     3b7:	e8 b6 34 00 00       	call   3872 <exit>
     3bc:	52                   	push   %edx
     3bd:	52                   	push   %edx
     3be:	68 79 4c 00 00       	push   $0x4c79
     3c3:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     3c9:	e8 f2 35 00 00       	call   39c0 <printf>
     3ce:	e8 9f 34 00 00       	call   3872 <exit>
     3d3:	50                   	push   %eax
     3d4:	50                   	push   %eax
     3d5:	68 f1 3d 00 00       	push   $0x3df1
     3da:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     3e0:	e8 db 35 00 00       	call   39c0 <printf>
     3e5:	e8 88 34 00 00       	call   3872 <exit>
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <opentest>:
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	83 ec 10             	sub    $0x10,%esp
     3f6:	68 12 3e 00 00       	push   $0x3e12
     3fb:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     401:	e8 ba 35 00 00       	call   39c0 <printf>
     406:	58                   	pop    %eax
     407:	5a                   	pop    %edx
     408:	6a 00                	push   $0x0
     40a:	68 1d 3e 00 00       	push   $0x3e1d
     40f:	e8 9e 34 00 00       	call   38b2 <open>
     414:	83 c4 10             	add    $0x10,%esp
     417:	85 c0                	test   %eax,%eax
     419:	78 36                	js     451 <opentest+0x61>
     41b:	83 ec 0c             	sub    $0xc,%esp
     41e:	50                   	push   %eax
     41f:	e8 76 34 00 00       	call   389a <close>
     424:	5a                   	pop    %edx
     425:	59                   	pop    %ecx
     426:	6a 00                	push   $0x0
     428:	68 35 3e 00 00       	push   $0x3e35
     42d:	e8 80 34 00 00       	call   38b2 <open>
     432:	83 c4 10             	add    $0x10,%esp
     435:	85 c0                	test   %eax,%eax
     437:	79 2f                	jns    468 <opentest+0x78>
     439:	83 ec 08             	sub    $0x8,%esp
     43c:	68 60 3e 00 00       	push   $0x3e60
     441:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     447:	e8 74 35 00 00       	call   39c0 <printf>
     44c:	83 c4 10             	add    $0x10,%esp
     44f:	c9                   	leave  
     450:	c3                   	ret    
     451:	50                   	push   %eax
     452:	50                   	push   %eax
     453:	68 22 3e 00 00       	push   $0x3e22
     458:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     45e:	e8 5d 35 00 00       	call   39c0 <printf>
     463:	e8 0a 34 00 00       	call   3872 <exit>
     468:	50                   	push   %eax
     469:	50                   	push   %eax
     46a:	68 42 3e 00 00       	push   $0x3e42
     46f:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     475:	e8 46 35 00 00       	call   39c0 <printf>
     47a:	e8 f3 33 00 00       	call   3872 <exit>
     47f:	90                   	nop

00000480 <writetest>:
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	56                   	push   %esi
     484:	53                   	push   %ebx
     485:	83 ec 08             	sub    $0x8,%esp
     488:	68 6e 3e 00 00       	push   $0x3e6e
     48d:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     493:	e8 28 35 00 00       	call   39c0 <printf>
     498:	58                   	pop    %eax
     499:	5a                   	pop    %edx
     49a:	68 02 02 00 00       	push   $0x202
     49f:	68 7f 3e 00 00       	push   $0x3e7f
     4a4:	e8 09 34 00 00       	call   38b2 <open>
     4a9:	83 c4 10             	add    $0x10,%esp
     4ac:	85 c0                	test   %eax,%eax
     4ae:	0f 88 88 01 00 00    	js     63c <writetest+0x1bc>
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	89 c6                	mov    %eax,%esi
     4b9:	31 db                	xor    %ebx,%ebx
     4bb:	68 85 3e 00 00       	push   $0x3e85
     4c0:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     4c6:	e8 f5 34 00 00       	call   39c0 <printf>
     4cb:	83 c4 10             	add    $0x10,%esp
     4ce:	66 90                	xchg   %ax,%ax
     4d0:	83 ec 04             	sub    $0x4,%esp
     4d3:	6a 0a                	push   $0xa
     4d5:	68 bc 3e 00 00       	push   $0x3ebc
     4da:	56                   	push   %esi
     4db:	e8 b2 33 00 00       	call   3892 <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d9 00 00 00    	jne    5c5 <writetest+0x145>
     4ec:	83 ec 04             	sub    $0x4,%esp
     4ef:	6a 0a                	push   $0xa
     4f1:	68 c7 3e 00 00       	push   $0x3ec7
     4f6:	56                   	push   %esi
     4f7:	e8 96 33 00 00       	call   3892 <write>
     4fc:	83 c4 10             	add    $0x10,%esp
     4ff:	83 f8 0a             	cmp    $0xa,%eax
     502:	0f 85 d6 00 00 00    	jne    5de <writetest+0x15e>
     508:	83 c3 01             	add    $0x1,%ebx
     50b:	83 fb 64             	cmp    $0x64,%ebx
     50e:	75 c0                	jne    4d0 <writetest+0x50>
     510:	83 ec 08             	sub    $0x8,%esp
     513:	68 d2 3e 00 00       	push   $0x3ed2
     518:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     51e:	e8 9d 34 00 00       	call   39c0 <printf>
     523:	89 34 24             	mov    %esi,(%esp)
     526:	e8 6f 33 00 00       	call   389a <close>
     52b:	5b                   	pop    %ebx
     52c:	5e                   	pop    %esi
     52d:	6a 00                	push   $0x0
     52f:	68 7f 3e 00 00       	push   $0x3e7f
     534:	e8 79 33 00 00       	call   38b2 <open>
     539:	83 c4 10             	add    $0x10,%esp
     53c:	85 c0                	test   %eax,%eax
     53e:	89 c3                	mov    %eax,%ebx
     540:	0f 88 b1 00 00 00    	js     5f7 <writetest+0x177>
     546:	83 ec 08             	sub    $0x8,%esp
     549:	68 dd 3e 00 00       	push   $0x3edd
     54e:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     554:	e8 67 34 00 00       	call   39c0 <printf>
     559:	83 c4 0c             	add    $0xc,%esp
     55c:	68 d0 07 00 00       	push   $0x7d0
     561:	68 c0 85 00 00       	push   $0x85c0
     566:	53                   	push   %ebx
     567:	e8 1e 33 00 00       	call   388a <read>
     56c:	83 c4 10             	add    $0x10,%esp
     56f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     574:	0f 85 94 00 00 00    	jne    60e <writetest+0x18e>
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	68 11 3f 00 00       	push   $0x3f11
     582:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     588:	e8 33 34 00 00       	call   39c0 <printf>
     58d:	89 1c 24             	mov    %ebx,(%esp)
     590:	e8 05 33 00 00       	call   389a <close>
     595:	c7 04 24 7f 3e 00 00 	movl   $0x3e7f,(%esp)
     59c:	e8 21 33 00 00       	call   38c2 <unlink>
     5a1:	83 c4 10             	add    $0x10,%esp
     5a4:	85 c0                	test   %eax,%eax
     5a6:	78 7d                	js     625 <writetest+0x1a5>
     5a8:	83 ec 08             	sub    $0x8,%esp
     5ab:	68 39 3f 00 00       	push   $0x3f39
     5b0:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     5b6:	e8 05 34 00 00       	call   39c0 <printf>
     5bb:	83 c4 10             	add    $0x10,%esp
     5be:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5c1:	5b                   	pop    %ebx
     5c2:	5e                   	pop    %esi
     5c3:	5d                   	pop    %ebp
     5c4:	c3                   	ret    
     5c5:	83 ec 04             	sub    $0x4,%esp
     5c8:	53                   	push   %ebx
     5c9:	68 80 4d 00 00       	push   $0x4d80
     5ce:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     5d4:	e8 e7 33 00 00       	call   39c0 <printf>
     5d9:	e8 94 32 00 00       	call   3872 <exit>
     5de:	83 ec 04             	sub    $0x4,%esp
     5e1:	53                   	push   %ebx
     5e2:	68 a4 4d 00 00       	push   $0x4da4
     5e7:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     5ed:	e8 ce 33 00 00       	call   39c0 <printf>
     5f2:	e8 7b 32 00 00       	call   3872 <exit>
     5f7:	51                   	push   %ecx
     5f8:	51                   	push   %ecx
     5f9:	68 f6 3e 00 00       	push   $0x3ef6
     5fe:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     604:	e8 b7 33 00 00       	call   39c0 <printf>
     609:	e8 64 32 00 00       	call   3872 <exit>
     60e:	52                   	push   %edx
     60f:	52                   	push   %edx
     610:	68 3d 42 00 00       	push   $0x423d
     615:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     61b:	e8 a0 33 00 00       	call   39c0 <printf>
     620:	e8 4d 32 00 00       	call   3872 <exit>
     625:	50                   	push   %eax
     626:	50                   	push   %eax
     627:	68 24 3f 00 00       	push   $0x3f24
     62c:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     632:	e8 89 33 00 00       	call   39c0 <printf>
     637:	e8 36 32 00 00       	call   3872 <exit>
     63c:	50                   	push   %eax
     63d:	50                   	push   %eax
     63e:	68 a0 3e 00 00       	push   $0x3ea0
     643:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     649:	e8 72 33 00 00       	call   39c0 <printf>
     64e:	e8 1f 32 00 00       	call   3872 <exit>
     653:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <writetest1>:
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	56                   	push   %esi
     664:	53                   	push   %ebx
     665:	83 ec 08             	sub    $0x8,%esp
     668:	68 4d 3f 00 00       	push   $0x3f4d
     66d:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     673:	e8 48 33 00 00       	call   39c0 <printf>
     678:	58                   	pop    %eax
     679:	5a                   	pop    %edx
     67a:	68 02 02 00 00       	push   $0x202
     67f:	68 c7 3f 00 00       	push   $0x3fc7
     684:	e8 29 32 00 00       	call   38b2 <open>
     689:	83 c4 10             	add    $0x10,%esp
     68c:	85 c0                	test   %eax,%eax
     68e:	0f 88 61 01 00 00    	js     7f5 <writetest1+0x195>
     694:	89 c6                	mov    %eax,%esi
     696:	31 db                	xor    %ebx,%ebx
     698:	90                   	nop
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6a0:	83 ec 04             	sub    $0x4,%esp
     6a3:	89 1d c0 85 00 00    	mov    %ebx,0x85c0
     6a9:	68 00 02 00 00       	push   $0x200
     6ae:	68 c0 85 00 00       	push   $0x85c0
     6b3:	56                   	push   %esi
     6b4:	e8 d9 31 00 00       	call   3892 <write>
     6b9:	83 c4 10             	add    $0x10,%esp
     6bc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6c1:	0f 85 b3 00 00 00    	jne    77a <writetest1+0x11a>
     6c7:	83 c3 01             	add    $0x1,%ebx
     6ca:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6d0:	75 ce                	jne    6a0 <writetest1+0x40>
     6d2:	83 ec 0c             	sub    $0xc,%esp
     6d5:	56                   	push   %esi
     6d6:	e8 bf 31 00 00       	call   389a <close>
     6db:	5b                   	pop    %ebx
     6dc:	5e                   	pop    %esi
     6dd:	6a 00                	push   $0x0
     6df:	68 c7 3f 00 00       	push   $0x3fc7
     6e4:	e8 c9 31 00 00       	call   38b2 <open>
     6e9:	83 c4 10             	add    $0x10,%esp
     6ec:	85 c0                	test   %eax,%eax
     6ee:	89 c6                	mov    %eax,%esi
     6f0:	0f 88 e8 00 00 00    	js     7de <writetest1+0x17e>
     6f6:	31 db                	xor    %ebx,%ebx
     6f8:	eb 1d                	jmp    717 <writetest1+0xb7>
     6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     700:	3d 00 02 00 00       	cmp    $0x200,%eax
     705:	0f 85 9f 00 00 00    	jne    7aa <writetest1+0x14a>
     70b:	a1 c0 85 00 00       	mov    0x85c0,%eax
     710:	39 d8                	cmp    %ebx,%eax
     712:	75 7f                	jne    793 <writetest1+0x133>
     714:	83 c3 01             	add    $0x1,%ebx
     717:	83 ec 04             	sub    $0x4,%esp
     71a:	68 00 02 00 00       	push   $0x200
     71f:	68 c0 85 00 00       	push   $0x85c0
     724:	56                   	push   %esi
     725:	e8 60 31 00 00       	call   388a <read>
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	85 c0                	test   %eax,%eax
     72f:	75 cf                	jne    700 <writetest1+0xa0>
     731:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     737:	0f 84 86 00 00 00    	je     7c3 <writetest1+0x163>
     73d:	83 ec 0c             	sub    $0xc,%esp
     740:	56                   	push   %esi
     741:	e8 54 31 00 00       	call   389a <close>
     746:	c7 04 24 c7 3f 00 00 	movl   $0x3fc7,(%esp)
     74d:	e8 70 31 00 00       	call   38c2 <unlink>
     752:	83 c4 10             	add    $0x10,%esp
     755:	85 c0                	test   %eax,%eax
     757:	0f 88 af 00 00 00    	js     80c <writetest1+0x1ac>
     75d:	83 ec 08             	sub    $0x8,%esp
     760:	68 ee 3f 00 00       	push   $0x3fee
     765:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     76b:	e8 50 32 00 00       	call   39c0 <printf>
     770:	83 c4 10             	add    $0x10,%esp
     773:	8d 65 f8             	lea    -0x8(%ebp),%esp
     776:	5b                   	pop    %ebx
     777:	5e                   	pop    %esi
     778:	5d                   	pop    %ebp
     779:	c3                   	ret    
     77a:	83 ec 04             	sub    $0x4,%esp
     77d:	53                   	push   %ebx
     77e:	68 77 3f 00 00       	push   $0x3f77
     783:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     789:	e8 32 32 00 00       	call   39c0 <printf>
     78e:	e8 df 30 00 00       	call   3872 <exit>
     793:	50                   	push   %eax
     794:	53                   	push   %ebx
     795:	68 c8 4d 00 00       	push   $0x4dc8
     79a:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     7a0:	e8 1b 32 00 00       	call   39c0 <printf>
     7a5:	e8 c8 30 00 00       	call   3872 <exit>
     7aa:	83 ec 04             	sub    $0x4,%esp
     7ad:	50                   	push   %eax
     7ae:	68 cb 3f 00 00       	push   $0x3fcb
     7b3:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     7b9:	e8 02 32 00 00       	call   39c0 <printf>
     7be:	e8 af 30 00 00       	call   3872 <exit>
     7c3:	52                   	push   %edx
     7c4:	68 8b 00 00 00       	push   $0x8b
     7c9:	68 ae 3f 00 00       	push   $0x3fae
     7ce:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     7d4:	e8 e7 31 00 00       	call   39c0 <printf>
     7d9:	e8 94 30 00 00       	call   3872 <exit>
     7de:	51                   	push   %ecx
     7df:	51                   	push   %ecx
     7e0:	68 95 3f 00 00       	push   $0x3f95
     7e5:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     7eb:	e8 d0 31 00 00       	call   39c0 <printf>
     7f0:	e8 7d 30 00 00       	call   3872 <exit>
     7f5:	50                   	push   %eax
     7f6:	50                   	push   %eax
     7f7:	68 5d 3f 00 00       	push   $0x3f5d
     7fc:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     802:	e8 b9 31 00 00       	call   39c0 <printf>
     807:	e8 66 30 00 00       	call   3872 <exit>
     80c:	50                   	push   %eax
     80d:	50                   	push   %eax
     80e:	68 db 3f 00 00       	push   $0x3fdb
     813:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     819:	e8 a2 31 00 00       	call   39c0 <printf>
     81e:	e8 4f 30 00 00       	call   3872 <exit>
     823:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000830 <createtest>:
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	53                   	push   %ebx
     834:	bb 30 00 00 00       	mov    $0x30,%ebx
     839:	83 ec 0c             	sub    $0xc,%esp
     83c:	68 e8 4d 00 00       	push   $0x4de8
     841:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     847:	e8 74 31 00 00       	call   39c0 <printf>
     84c:	c6 05 c0 a5 00 00 61 	movb   $0x61,0xa5c0
     853:	c6 05 c2 a5 00 00 00 	movb   $0x0,0xa5c2
     85a:	83 c4 10             	add    $0x10,%esp
     85d:	8d 76 00             	lea    0x0(%esi),%esi
     860:	83 ec 08             	sub    $0x8,%esp
     863:	88 1d c1 a5 00 00    	mov    %bl,0xa5c1
     869:	83 c3 01             	add    $0x1,%ebx
     86c:	68 02 02 00 00       	push   $0x202
     871:	68 c0 a5 00 00       	push   $0xa5c0
     876:	e8 37 30 00 00       	call   38b2 <open>
     87b:	89 04 24             	mov    %eax,(%esp)
     87e:	e8 17 30 00 00       	call   389a <close>
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
     8b1:	e8 0c 30 00 00       	call   38c2 <unlink>
     8b6:	83 c4 10             	add    $0x10,%esp
     8b9:	80 fb 64             	cmp    $0x64,%bl
     8bc:	75 e2                	jne    8a0 <createtest+0x70>
     8be:	83 ec 08             	sub    $0x8,%esp
     8c1:	68 10 4e 00 00       	push   $0x4e10
     8c6:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     8cc:	e8 ef 30 00 00       	call   39c0 <printf>
     8d1:	83 c4 10             	add    $0x10,%esp
     8d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d7:	c9                   	leave  
     8d8:	c3                   	ret    
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <dirtest>:
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 10             	sub    $0x10,%esp
     8e6:	68 fc 3f 00 00       	push   $0x3ffc
     8eb:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     8f1:	e8 ca 30 00 00       	call   39c0 <printf>
     8f6:	c7 04 24 08 40 00 00 	movl   $0x4008,(%esp)
     8fd:	e8 d8 2f 00 00       	call   38da <mkdir>
     902:	83 c4 10             	add    $0x10,%esp
     905:	85 c0                	test   %eax,%eax
     907:	78 58                	js     961 <dirtest+0x81>
     909:	83 ec 0c             	sub    $0xc,%esp
     90c:	68 08 40 00 00       	push   $0x4008
     911:	e8 cc 2f 00 00       	call   38e2 <chdir>
     916:	83 c4 10             	add    $0x10,%esp
     919:	85 c0                	test   %eax,%eax
     91b:	0f 88 85 00 00 00    	js     9a6 <dirtest+0xc6>
     921:	83 ec 0c             	sub    $0xc,%esp
     924:	68 ad 45 00 00       	push   $0x45ad
     929:	e8 b4 2f 00 00       	call   38e2 <chdir>
     92e:	83 c4 10             	add    $0x10,%esp
     931:	85 c0                	test   %eax,%eax
     933:	78 5a                	js     98f <dirtest+0xaf>
     935:	83 ec 0c             	sub    $0xc,%esp
     938:	68 08 40 00 00       	push   $0x4008
     93d:	e8 80 2f 00 00       	call   38c2 <unlink>
     942:	83 c4 10             	add    $0x10,%esp
     945:	85 c0                	test   %eax,%eax
     947:	78 2f                	js     978 <dirtest+0x98>
     949:	83 ec 08             	sub    $0x8,%esp
     94c:	68 45 40 00 00       	push   $0x4045
     951:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     957:	e8 64 30 00 00       	call   39c0 <printf>
     95c:	83 c4 10             	add    $0x10,%esp
     95f:	c9                   	leave  
     960:	c3                   	ret    
     961:	50                   	push   %eax
     962:	50                   	push   %eax
     963:	68 38 3d 00 00       	push   $0x3d38
     968:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     96e:	e8 4d 30 00 00       	call   39c0 <printf>
     973:	e8 fa 2e 00 00       	call   3872 <exit>
     978:	50                   	push   %eax
     979:	50                   	push   %eax
     97a:	68 31 40 00 00       	push   $0x4031
     97f:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     985:	e8 36 30 00 00       	call   39c0 <printf>
     98a:	e8 e3 2e 00 00       	call   3872 <exit>
     98f:	52                   	push   %edx
     990:	52                   	push   %edx
     991:	68 20 40 00 00       	push   $0x4020
     996:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     99c:	e8 1f 30 00 00       	call   39c0 <printf>
     9a1:	e8 cc 2e 00 00       	call   3872 <exit>
     9a6:	51                   	push   %ecx
     9a7:	51                   	push   %ecx
     9a8:	68 0d 40 00 00       	push   $0x400d
     9ad:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     9b3:	e8 08 30 00 00       	call   39c0 <printf>
     9b8:	e8 b5 2e 00 00       	call   3872 <exit>
     9bd:	8d 76 00             	lea    0x0(%esi),%esi

000009c0 <exectest>:
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	83 ec 10             	sub    $0x10,%esp
     9c6:	68 54 40 00 00       	push   $0x4054
     9cb:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     9d1:	e8 ea 2f 00 00       	call   39c0 <printf>
     9d6:	5a                   	pop    %edx
     9d7:	59                   	pop    %ecx
     9d8:	68 d4 5d 00 00       	push   $0x5dd4
     9dd:	68 1d 3e 00 00       	push   $0x3e1d
     9e2:	e8 c3 2e 00 00       	call   38aa <exec>
     9e7:	83 c4 10             	add    $0x10,%esp
     9ea:	85 c0                	test   %eax,%eax
     9ec:	78 02                	js     9f0 <exectest+0x30>
     9ee:	c9                   	leave  
     9ef:	c3                   	ret    
     9f0:	50                   	push   %eax
     9f1:	50                   	push   %eax
     9f2:	68 5f 40 00 00       	push   $0x405f
     9f7:	ff 35 d0 5d 00 00    	pushl  0x5dd0
     9fd:	e8 be 2f 00 00       	call   39c0 <printf>
     a02:	e8 6b 2e 00 00       	call   3872 <exit>
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
     a1d:	e8 60 2e 00 00       	call   3882 <pipe>
     a22:	83 c4 10             	add    $0x10,%esp
     a25:	85 c0                	test   %eax,%eax
     a27:	0f 85 3e 01 00 00    	jne    b6b <pipe1+0x15b>
     a2d:	89 c3                	mov    %eax,%ebx
     a2f:	e8 36 2e 00 00       	call   386a <fork>
     a34:	83 f8 00             	cmp    $0x0,%eax
     a37:	0f 84 84 00 00 00    	je     ac1 <pipe1+0xb1>
     a3d:	0f 8e 3b 01 00 00    	jle    b7e <pipe1+0x16e>
     a43:	83 ec 0c             	sub    $0xc,%esp
     a46:	ff 75 e4             	pushl  -0x1c(%ebp)
     a49:	bf 01 00 00 00       	mov    $0x1,%edi
     a4e:	e8 47 2e 00 00       	call   389a <close>
     a53:	83 c4 10             	add    $0x10,%esp
     a56:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a5d:	83 ec 04             	sub    $0x4,%esp
     a60:	57                   	push   %edi
     a61:	68 c0 85 00 00       	push   $0x85c0
     a66:	ff 75 e0             	pushl  -0x20(%ebp)
     a69:	e8 1c 2e 00 00       	call   388a <read>
     a6e:	83 c4 10             	add    $0x10,%esp
     a71:	85 c0                	test   %eax,%eax
     a73:	0f 8e ab 00 00 00    	jle    b24 <pipe1+0x114>
     a79:	89 d9                	mov    %ebx,%ecx
     a7b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a7e:	f7 d9                	neg    %ecx
     a80:	38 9c 0b c0 85 00 00 	cmp    %bl,0x85c0(%ebx,%ecx,1)
     a87:	8d 53 01             	lea    0x1(%ebx),%edx
     a8a:	75 1b                	jne    aa7 <pipe1+0x97>
     a8c:	39 f2                	cmp    %esi,%edx
     a8e:	89 d3                	mov    %edx,%ebx
     a90:	75 ee                	jne    a80 <pipe1+0x70>
     a92:	01 ff                	add    %edi,%edi
     a94:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a97:	b8 00 20 00 00       	mov    $0x2000,%eax
     a9c:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     aa2:	0f 4f f8             	cmovg  %eax,%edi
     aa5:	eb b6                	jmp    a5d <pipe1+0x4d>
     aa7:	83 ec 08             	sub    $0x8,%esp
     aaa:	68 8e 40 00 00       	push   $0x408e
     aaf:	6a 01                	push   $0x1
     ab1:	e8 0a 2f 00 00       	call   39c0 <printf>
     ab6:	83 c4 10             	add    $0x10,%esp
     ab9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     abc:	5b                   	pop    %ebx
     abd:	5e                   	pop    %esi
     abe:	5f                   	pop    %edi
     abf:	5d                   	pop    %ebp
     ac0:	c3                   	ret    
     ac1:	83 ec 0c             	sub    $0xc,%esp
     ac4:	ff 75 e0             	pushl  -0x20(%ebp)
     ac7:	31 db                	xor    %ebx,%ebx
     ac9:	be 09 04 00 00       	mov    $0x409,%esi
     ace:	e8 c7 2d 00 00       	call   389a <close>
     ad3:	83 c4 10             	add    $0x10,%esp
     ad6:	89 d8                	mov    %ebx,%eax
     ad8:	89 f2                	mov    %esi,%edx
     ada:	f7 d8                	neg    %eax
     adc:	29 da                	sub    %ebx,%edx
     ade:	66 90                	xchg   %ax,%ax
     ae0:	88 84 03 c0 85 00 00 	mov    %al,0x85c0(%ebx,%eax,1)
     ae7:	83 c0 01             	add    $0x1,%eax
     aea:	39 d0                	cmp    %edx,%eax
     aec:	75 f2                	jne    ae0 <pipe1+0xd0>
     aee:	83 ec 04             	sub    $0x4,%esp
     af1:	68 09 04 00 00       	push   $0x409
     af6:	68 c0 85 00 00       	push   $0x85c0
     afb:	ff 75 e4             	pushl  -0x1c(%ebp)
     afe:	e8 8f 2d 00 00       	call   3892 <write>
     b03:	83 c4 10             	add    $0x10,%esp
     b06:	3d 09 04 00 00       	cmp    $0x409,%eax
     b0b:	0f 85 80 00 00 00    	jne    b91 <pipe1+0x181>
     b11:	81 eb 09 04 00 00    	sub    $0x409,%ebx
     b17:	81 fb d3 eb ff ff    	cmp    $0xffffebd3,%ebx
     b1d:	75 b7                	jne    ad6 <pipe1+0xc6>
     b1f:	e8 4e 2d 00 00       	call   3872 <exit>
     b24:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b2b:	75 29                	jne    b56 <pipe1+0x146>
     b2d:	83 ec 0c             	sub    $0xc,%esp
     b30:	ff 75 e0             	pushl  -0x20(%ebp)
     b33:	e8 62 2d 00 00       	call   389a <close>
     b38:	e8 3d 2d 00 00       	call   387a <wait>
     b3d:	5a                   	pop    %edx
     b3e:	59                   	pop    %ecx
     b3f:	68 b3 40 00 00       	push   $0x40b3
     b44:	6a 01                	push   $0x1
     b46:	e8 75 2e 00 00       	call   39c0 <printf>
     b4b:	83 c4 10             	add    $0x10,%esp
     b4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b51:	5b                   	pop    %ebx
     b52:	5e                   	pop    %esi
     b53:	5f                   	pop    %edi
     b54:	5d                   	pop    %ebp
     b55:	c3                   	ret    
     b56:	53                   	push   %ebx
     b57:	ff 75 d4             	pushl  -0x2c(%ebp)
     b5a:	68 9c 40 00 00       	push   $0x409c
     b5f:	6a 01                	push   $0x1
     b61:	e8 5a 2e 00 00       	call   39c0 <printf>
     b66:	e8 07 2d 00 00       	call   3872 <exit>
     b6b:	57                   	push   %edi
     b6c:	57                   	push   %edi
     b6d:	68 71 40 00 00       	push   $0x4071
     b72:	6a 01                	push   $0x1
     b74:	e8 47 2e 00 00       	call   39c0 <printf>
     b79:	e8 f4 2c 00 00       	call   3872 <exit>
     b7e:	50                   	push   %eax
     b7f:	50                   	push   %eax
     b80:	68 bd 40 00 00       	push   $0x40bd
     b85:	6a 01                	push   $0x1
     b87:	e8 34 2e 00 00       	call   39c0 <printf>
     b8c:	e8 e1 2c 00 00       	call   3872 <exit>
     b91:	56                   	push   %esi
     b92:	56                   	push   %esi
     b93:	68 80 40 00 00       	push   $0x4080
     b98:	6a 01                	push   $0x1
     b9a:	e8 21 2e 00 00       	call   39c0 <printf>
     b9f:	e8 ce 2c 00 00       	call   3872 <exit>
     ba4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     baa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000bb0 <preempt>:
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
     bb9:	68 cc 40 00 00       	push   $0x40cc
     bbe:	6a 01                	push   $0x1
     bc0:	e8 fb 2d 00 00       	call   39c0 <printf>
     bc5:	e8 a0 2c 00 00       	call   386a <fork>
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 02                	jne    bd3 <preempt+0x23>
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	89 c7                	mov    %eax,%edi
     bd5:	e8 90 2c 00 00       	call   386a <fork>
     bda:	85 c0                	test   %eax,%eax
     bdc:	89 c6                	mov    %eax,%esi
     bde:	75 02                	jne    be2 <preempt+0x32>
     be0:	eb fe                	jmp    be0 <preempt+0x30>
     be2:	8d 45 e0             	lea    -0x20(%ebp),%eax
     be5:	83 ec 0c             	sub    $0xc,%esp
     be8:	50                   	push   %eax
     be9:	e8 94 2c 00 00       	call   3882 <pipe>
     bee:	e8 77 2c 00 00       	call   386a <fork>
     bf3:	83 c4 10             	add    $0x10,%esp
     bf6:	85 c0                	test   %eax,%eax
     bf8:	89 c3                	mov    %eax,%ebx
     bfa:	75 46                	jne    c42 <preempt+0x92>
     bfc:	83 ec 0c             	sub    $0xc,%esp
     bff:	ff 75 e0             	pushl  -0x20(%ebp)
     c02:	e8 93 2c 00 00       	call   389a <close>
     c07:	83 c4 0c             	add    $0xc,%esp
     c0a:	6a 01                	push   $0x1
     c0c:	68 91 46 00 00       	push   $0x4691
     c11:	ff 75 e4             	pushl  -0x1c(%ebp)
     c14:	e8 79 2c 00 00       	call   3892 <write>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	83 e8 01             	sub    $0x1,%eax
     c1f:	74 11                	je     c32 <preempt+0x82>
     c21:	50                   	push   %eax
     c22:	50                   	push   %eax
     c23:	68 d6 40 00 00       	push   $0x40d6
     c28:	6a 01                	push   $0x1
     c2a:	e8 91 2d 00 00       	call   39c0 <printf>
     c2f:	83 c4 10             	add    $0x10,%esp
     c32:	83 ec 0c             	sub    $0xc,%esp
     c35:	ff 75 e4             	pushl  -0x1c(%ebp)
     c38:	e8 5d 2c 00 00       	call   389a <close>
     c3d:	83 c4 10             	add    $0x10,%esp
     c40:	eb fe                	jmp    c40 <preempt+0x90>
     c42:	83 ec 0c             	sub    $0xc,%esp
     c45:	ff 75 e4             	pushl  -0x1c(%ebp)
     c48:	e8 4d 2c 00 00       	call   389a <close>
     c4d:	83 c4 0c             	add    $0xc,%esp
     c50:	68 00 20 00 00       	push   $0x2000
     c55:	68 c0 85 00 00       	push   $0x85c0
     c5a:	ff 75 e0             	pushl  -0x20(%ebp)
     c5d:	e8 28 2c 00 00       	call   388a <read>
     c62:	83 c4 10             	add    $0x10,%esp
     c65:	83 e8 01             	sub    $0x1,%eax
     c68:	74 19                	je     c83 <preempt+0xd3>
     c6a:	50                   	push   %eax
     c6b:	50                   	push   %eax
     c6c:	68 ea 40 00 00       	push   $0x40ea
     c71:	6a 01                	push   $0x1
     c73:	e8 48 2d 00 00       	call   39c0 <printf>
     c78:	83 c4 10             	add    $0x10,%esp
     c7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c7e:	5b                   	pop    %ebx
     c7f:	5e                   	pop    %esi
     c80:	5f                   	pop    %edi
     c81:	5d                   	pop    %ebp
     c82:	c3                   	ret    
     c83:	83 ec 0c             	sub    $0xc,%esp
     c86:	ff 75 e0             	pushl  -0x20(%ebp)
     c89:	e8 0c 2c 00 00       	call   389a <close>
     c8e:	58                   	pop    %eax
     c8f:	5a                   	pop    %edx
     c90:	68 fd 40 00 00       	push   $0x40fd
     c95:	6a 01                	push   $0x1
     c97:	e8 24 2d 00 00       	call   39c0 <printf>
     c9c:	89 3c 24             	mov    %edi,(%esp)
     c9f:	e8 fe 2b 00 00       	call   38a2 <kill>
     ca4:	89 34 24             	mov    %esi,(%esp)
     ca7:	e8 f6 2b 00 00       	call   38a2 <kill>
     cac:	89 1c 24             	mov    %ebx,(%esp)
     caf:	e8 ee 2b 00 00       	call   38a2 <kill>
     cb4:	59                   	pop    %ecx
     cb5:	5b                   	pop    %ebx
     cb6:	68 06 41 00 00       	push   $0x4106
     cbb:	6a 01                	push   $0x1
     cbd:	e8 fe 2c 00 00       	call   39c0 <printf>
     cc2:	e8 b3 2b 00 00       	call   387a <wait>
     cc7:	e8 ae 2b 00 00       	call   387a <wait>
     ccc:	e8 a9 2b 00 00       	call   387a <wait>
     cd1:	5e                   	pop    %esi
     cd2:	5f                   	pop    %edi
     cd3:	68 0f 41 00 00       	push   $0x410f
     cd8:	6a 01                	push   $0x1
     cda:	e8 e1 2c 00 00       	call   39c0 <printf>
     cdf:	83 c4 10             	add    $0x10,%esp
     ce2:	eb 97                	jmp    c7b <preempt+0xcb>
     ce4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000cf0 <exitwait>:
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	56                   	push   %esi
     cf4:	be 64 00 00 00       	mov    $0x64,%esi
     cf9:	53                   	push   %ebx
     cfa:	eb 14                	jmp    d10 <exitwait+0x20>
     cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d00:	74 6f                	je     d71 <exitwait+0x81>
     d02:	e8 73 2b 00 00       	call   387a <wait>
     d07:	39 d8                	cmp    %ebx,%eax
     d09:	75 2d                	jne    d38 <exitwait+0x48>
     d0b:	83 ee 01             	sub    $0x1,%esi
     d0e:	74 48                	je     d58 <exitwait+0x68>
     d10:	e8 55 2b 00 00       	call   386a <fork>
     d15:	85 c0                	test   %eax,%eax
     d17:	89 c3                	mov    %eax,%ebx
     d19:	79 e5                	jns    d00 <exitwait+0x10>
     d1b:	83 ec 08             	sub    $0x8,%esp
     d1e:	68 79 4c 00 00       	push   $0x4c79
     d23:	6a 01                	push   $0x1
     d25:	e8 96 2c 00 00       	call   39c0 <printf>
     d2a:	83 c4 10             	add    $0x10,%esp
     d2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d30:	5b                   	pop    %ebx
     d31:	5e                   	pop    %esi
     d32:	5d                   	pop    %ebp
     d33:	c3                   	ret    
     d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d38:	83 ec 08             	sub    $0x8,%esp
     d3b:	68 1b 41 00 00       	push   $0x411b
     d40:	6a 01                	push   $0x1
     d42:	e8 79 2c 00 00       	call   39c0 <printf>
     d47:	83 c4 10             	add    $0x10,%esp
     d4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d4d:	5b                   	pop    %ebx
     d4e:	5e                   	pop    %esi
     d4f:	5d                   	pop    %ebp
     d50:	c3                   	ret    
     d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 2b 41 00 00       	push   $0x412b
     d60:	6a 01                	push   $0x1
     d62:	e8 59 2c 00 00       	call   39c0 <printf>
     d67:	83 c4 10             	add    $0x10,%esp
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
     d71:	e8 fc 2a 00 00       	call   3872 <exit>
     d76:	8d 76 00             	lea    0x0(%esi),%esi
     d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d80 <mem>:
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	57                   	push   %edi
     d84:	56                   	push   %esi
     d85:	53                   	push   %ebx
     d86:	31 db                	xor    %ebx,%ebx
     d88:	83 ec 14             	sub    $0x14,%esp
     d8b:	68 38 41 00 00       	push   $0x4138
     d90:	6a 01                	push   $0x1
     d92:	e8 29 2c 00 00       	call   39c0 <printf>
     d97:	e8 56 2b 00 00       	call   38f2 <getpid>
     d9c:	89 c6                	mov    %eax,%esi
     d9e:	e8 c7 2a 00 00       	call   386a <fork>
     da3:	83 c4 10             	add    $0x10,%esp
     da6:	85 c0                	test   %eax,%eax
     da8:	74 0a                	je     db4 <mem+0x34>
     daa:	e9 89 00 00 00       	jmp    e38 <mem+0xb8>
     daf:	90                   	nop
     db0:	89 18                	mov    %ebx,(%eax)
     db2:	89 c3                	mov    %eax,%ebx
     db4:	83 ec 0c             	sub    $0xc,%esp
     db7:	68 11 27 00 00       	push   $0x2711
     dbc:	e8 7f 2e 00 00       	call   3c40 <malloc>
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
     dd8:	e8 d3 2d 00 00       	call   3bb0 <free>
     ddd:	83 c4 10             	add    $0x10,%esp
     de0:	85 db                	test   %ebx,%ebx
     de2:	75 ec                	jne    dd0 <mem+0x50>
     de4:	83 ec 0c             	sub    $0xc,%esp
     de7:	68 00 50 00 00       	push   $0x5000
     dec:	e8 4f 2e 00 00       	call   3c40 <malloc>
     df1:	83 c4 10             	add    $0x10,%esp
     df4:	85 c0                	test   %eax,%eax
     df6:	74 20                	je     e18 <mem+0x98>
     df8:	83 ec 0c             	sub    $0xc,%esp
     dfb:	50                   	push   %eax
     dfc:	e8 af 2d 00 00       	call   3bb0 <free>
     e01:	58                   	pop    %eax
     e02:	5a                   	pop    %edx
     e03:	68 5c 41 00 00       	push   $0x415c
     e08:	6a 01                	push   $0x1
     e0a:	e8 b1 2b 00 00       	call   39c0 <printf>
     e0f:	e8 5e 2a 00 00       	call   3872 <exit>
     e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e18:	83 ec 08             	sub    $0x8,%esp
     e1b:	68 42 41 00 00       	push   $0x4142
     e20:	6a 01                	push   $0x1
     e22:	e8 99 2b 00 00       	call   39c0 <printf>
     e27:	89 34 24             	mov    %esi,(%esp)
     e2a:	e8 73 2a 00 00       	call   38a2 <kill>
     e2f:	e8 3e 2a 00 00       	call   3872 <exit>
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e38:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e3b:	5b                   	pop    %ebx
     e3c:	5e                   	pop    %esi
     e3d:	5f                   	pop    %edi
     e3e:	5d                   	pop    %ebp
     e3f:	e9 36 2a 00 00       	jmp    387a <wait>
     e44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e50 <sharedfd>:
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
     e56:	83 ec 34             	sub    $0x34,%esp
     e59:	68 64 41 00 00       	push   $0x4164
     e5e:	6a 01                	push   $0x1
     e60:	e8 5b 2b 00 00       	call   39c0 <printf>
     e65:	c7 04 24 73 41 00 00 	movl   $0x4173,(%esp)
     e6c:	e8 51 2a 00 00       	call   38c2 <unlink>
     e71:	59                   	pop    %ecx
     e72:	5b                   	pop    %ebx
     e73:	68 02 02 00 00       	push   $0x202
     e78:	68 73 41 00 00       	push   $0x4173
     e7d:	e8 30 2a 00 00       	call   38b2 <open>
     e82:	83 c4 10             	add    $0x10,%esp
     e85:	85 c0                	test   %eax,%eax
     e87:	0f 88 33 01 00 00    	js     fc0 <sharedfd+0x170>
     e8d:	89 c6                	mov    %eax,%esi
     e8f:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     e94:	e8 d1 29 00 00       	call   386a <fork>
     e99:	83 f8 01             	cmp    $0x1,%eax
     e9c:	89 c7                	mov    %eax,%edi
     e9e:	19 c0                	sbb    %eax,%eax
     ea0:	83 ec 04             	sub    $0x4,%esp
     ea3:	83 e0 f3             	and    $0xfffffff3,%eax
     ea6:	6a 0a                	push   $0xa
     ea8:	83 c0 70             	add    $0x70,%eax
     eab:	50                   	push   %eax
     eac:	8d 45 de             	lea    -0x22(%ebp),%eax
     eaf:	50                   	push   %eax
     eb0:	e8 4b 28 00 00       	call   3700 <memset>
     eb5:	83 c4 10             	add    $0x10,%esp
     eb8:	eb 0b                	jmp    ec5 <sharedfd+0x75>
     eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ec0:	83 eb 01             	sub    $0x1,%ebx
     ec3:	74 29                	je     eee <sharedfd+0x9e>
     ec5:	8d 45 de             	lea    -0x22(%ebp),%eax
     ec8:	83 ec 04             	sub    $0x4,%esp
     ecb:	6a 0a                	push   $0xa
     ecd:	50                   	push   %eax
     ece:	56                   	push   %esi
     ecf:	e8 be 29 00 00       	call   3892 <write>
     ed4:	83 c4 10             	add    $0x10,%esp
     ed7:	83 f8 0a             	cmp    $0xa,%eax
     eda:	74 e4                	je     ec0 <sharedfd+0x70>
     edc:	83 ec 08             	sub    $0x8,%esp
     edf:	68 64 4e 00 00       	push   $0x4e64
     ee4:	6a 01                	push   $0x1
     ee6:	e8 d5 2a 00 00       	call   39c0 <printf>
     eeb:	83 c4 10             	add    $0x10,%esp
     eee:	85 ff                	test   %edi,%edi
     ef0:	0f 84 fe 00 00 00    	je     ff4 <sharedfd+0x1a4>
     ef6:	e8 7f 29 00 00       	call   387a <wait>
     efb:	83 ec 0c             	sub    $0xc,%esp
     efe:	31 db                	xor    %ebx,%ebx
     f00:	31 ff                	xor    %edi,%edi
     f02:	56                   	push   %esi
     f03:	8d 75 e8             	lea    -0x18(%ebp),%esi
     f06:	e8 8f 29 00 00       	call   389a <close>
     f0b:	58                   	pop    %eax
     f0c:	5a                   	pop    %edx
     f0d:	6a 00                	push   $0x0
     f0f:	68 73 41 00 00       	push   $0x4173
     f14:	e8 99 29 00 00       	call   38b2 <open>
     f19:	83 c4 10             	add    $0x10,%esp
     f1c:	85 c0                	test   %eax,%eax
     f1e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f21:	0f 88 b3 00 00 00    	js     fda <sharedfd+0x18a>
     f27:	89 f8                	mov    %edi,%eax
     f29:	89 df                	mov    %ebx,%edi
     f2b:	89 c3                	mov    %eax,%ebx
     f2d:	8d 76 00             	lea    0x0(%esi),%esi
     f30:	8d 45 de             	lea    -0x22(%ebp),%eax
     f33:	83 ec 04             	sub    $0x4,%esp
     f36:	6a 0a                	push   $0xa
     f38:	50                   	push   %eax
     f39:	ff 75 d4             	pushl  -0x2c(%ebp)
     f3c:	e8 49 29 00 00       	call   388a <read>
     f41:	83 c4 10             	add    $0x10,%esp
     f44:	85 c0                	test   %eax,%eax
     f46:	7e 28                	jle    f70 <sharedfd+0x120>
     f48:	8d 45 de             	lea    -0x22(%ebp),%eax
     f4b:	eb 15                	jmp    f62 <sharedfd+0x112>
     f4d:	8d 76 00             	lea    0x0(%esi),%esi
     f50:	80 fa 70             	cmp    $0x70,%dl
     f53:	0f 94 c2             	sete   %dl
     f56:	0f b6 d2             	movzbl %dl,%edx
     f59:	01 d7                	add    %edx,%edi
     f5b:	83 c0 01             	add    $0x1,%eax
     f5e:	39 f0                	cmp    %esi,%eax
     f60:	74 ce                	je     f30 <sharedfd+0xe0>
     f62:	0f b6 10             	movzbl (%eax),%edx
     f65:	80 fa 63             	cmp    $0x63,%dl
     f68:	75 e6                	jne    f50 <sharedfd+0x100>
     f6a:	83 c3 01             	add    $0x1,%ebx
     f6d:	eb ec                	jmp    f5b <sharedfd+0x10b>
     f6f:	90                   	nop
     f70:	83 ec 0c             	sub    $0xc,%esp
     f73:	89 d8                	mov    %ebx,%eax
     f75:	ff 75 d4             	pushl  -0x2c(%ebp)
     f78:	89 fb                	mov    %edi,%ebx
     f7a:	89 c7                	mov    %eax,%edi
     f7c:	e8 19 29 00 00       	call   389a <close>
     f81:	c7 04 24 73 41 00 00 	movl   $0x4173,(%esp)
     f88:	e8 35 29 00 00       	call   38c2 <unlink>
     f8d:	83 c4 10             	add    $0x10,%esp
     f90:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     f96:	75 61                	jne    ff9 <sharedfd+0x1a9>
     f98:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f9e:	75 59                	jne    ff9 <sharedfd+0x1a9>
     fa0:	83 ec 08             	sub    $0x8,%esp
     fa3:	68 7c 41 00 00       	push   $0x417c
     fa8:	6a 01                	push   $0x1
     faa:	e8 11 2a 00 00       	call   39c0 <printf>
     faf:	83 c4 10             	add    $0x10,%esp
     fb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fb5:	5b                   	pop    %ebx
     fb6:	5e                   	pop    %esi
     fb7:	5f                   	pop    %edi
     fb8:	5d                   	pop    %ebp
     fb9:	c3                   	ret    
     fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fc0:	83 ec 08             	sub    $0x8,%esp
     fc3:	68 38 4e 00 00       	push   $0x4e38
     fc8:	6a 01                	push   $0x1
     fca:	e8 f1 29 00 00       	call   39c0 <printf>
     fcf:	83 c4 10             	add    $0x10,%esp
     fd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fd5:	5b                   	pop    %ebx
     fd6:	5e                   	pop    %esi
     fd7:	5f                   	pop    %edi
     fd8:	5d                   	pop    %ebp
     fd9:	c3                   	ret    
     fda:	83 ec 08             	sub    $0x8,%esp
     fdd:	68 84 4e 00 00       	push   $0x4e84
     fe2:	6a 01                	push   $0x1
     fe4:	e8 d7 29 00 00       	call   39c0 <printf>
     fe9:	83 c4 10             	add    $0x10,%esp
     fec:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fef:	5b                   	pop    %ebx
     ff0:	5e                   	pop    %esi
     ff1:	5f                   	pop    %edi
     ff2:	5d                   	pop    %ebp
     ff3:	c3                   	ret    
     ff4:	e8 79 28 00 00       	call   3872 <exit>
     ff9:	53                   	push   %ebx
     ffa:	57                   	push   %edi
     ffb:	68 89 41 00 00       	push   $0x4189
    1000:	6a 01                	push   $0x1
    1002:	e8 b9 29 00 00       	call   39c0 <printf>
    1007:	e8 66 28 00 00       	call   3872 <exit>
    100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001010 <fourfiles>:
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	56                   	push   %esi
    1015:	53                   	push   %ebx
    1016:	be 9e 41 00 00       	mov    $0x419e,%esi
    101b:	31 db                	xor    %ebx,%ebx
    101d:	83 ec 34             	sub    $0x34,%esp
    1020:	c7 45 d8 9e 41 00 00 	movl   $0x419e,-0x28(%ebp)
    1027:	c7 45 dc e7 42 00 00 	movl   $0x42e7,-0x24(%ebp)
    102e:	68 a4 41 00 00       	push   $0x41a4
    1033:	6a 01                	push   $0x1
    1035:	c7 45 e0 eb 42 00 00 	movl   $0x42eb,-0x20(%ebp)
    103c:	c7 45 e4 a1 41 00 00 	movl   $0x41a1,-0x1c(%ebp)
    1043:	e8 78 29 00 00       	call   39c0 <printf>
    1048:	83 c4 10             	add    $0x10,%esp
    104b:	83 ec 0c             	sub    $0xc,%esp
    104e:	56                   	push   %esi
    104f:	e8 6e 28 00 00       	call   38c2 <unlink>
    1054:	e8 11 28 00 00       	call   386a <fork>
    1059:	83 c4 10             	add    $0x10,%esp
    105c:	85 c0                	test   %eax,%eax
    105e:	0f 88 68 01 00 00    	js     11cc <fourfiles+0x1bc>
    1064:	0f 84 df 00 00 00    	je     1149 <fourfiles+0x139>
    106a:	83 c3 01             	add    $0x1,%ebx
    106d:	83 fb 04             	cmp    $0x4,%ebx
    1070:	74 06                	je     1078 <fourfiles+0x68>
    1072:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1076:	eb d3                	jmp    104b <fourfiles+0x3b>
    1078:	e8 fd 27 00 00       	call   387a <wait>
    107d:	31 ff                	xor    %edi,%edi
    107f:	e8 f6 27 00 00       	call   387a <wait>
    1084:	e8 f1 27 00 00       	call   387a <wait>
    1089:	e8 ec 27 00 00       	call   387a <wait>
    108e:	c7 45 d0 9e 41 00 00 	movl   $0x419e,-0x30(%ebp)
    1095:	83 ec 08             	sub    $0x8,%esp
    1098:	31 db                	xor    %ebx,%ebx
    109a:	6a 00                	push   $0x0
    109c:	ff 75 d0             	pushl  -0x30(%ebp)
    109f:	e8 0e 28 00 00       	call   38b2 <open>
    10a4:	83 c4 10             	add    $0x10,%esp
    10a7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10b0:	83 ec 04             	sub    $0x4,%esp
    10b3:	68 00 20 00 00       	push   $0x2000
    10b8:	68 c0 85 00 00       	push   $0x85c0
    10bd:	ff 75 d4             	pushl  -0x2c(%ebp)
    10c0:	e8 c5 27 00 00       	call   388a <read>
    10c5:	83 c4 10             	add    $0x10,%esp
    10c8:	85 c0                	test   %eax,%eax
    10ca:	7e 26                	jle    10f2 <fourfiles+0xe2>
    10cc:	31 d2                	xor    %edx,%edx
    10ce:	66 90                	xchg   %ax,%ax
    10d0:	0f be b2 c0 85 00 00 	movsbl 0x85c0(%edx),%esi
    10d7:	83 ff 01             	cmp    $0x1,%edi
    10da:	19 c9                	sbb    %ecx,%ecx
    10dc:	83 c1 31             	add    $0x31,%ecx
    10df:	39 ce                	cmp    %ecx,%esi
    10e1:	0f 85 be 00 00 00    	jne    11a5 <fourfiles+0x195>
    10e7:	83 c2 01             	add    $0x1,%edx
    10ea:	39 d0                	cmp    %edx,%eax
    10ec:	75 e2                	jne    10d0 <fourfiles+0xc0>
    10ee:	01 c3                	add    %eax,%ebx
    10f0:	eb be                	jmp    10b0 <fourfiles+0xa0>
    10f2:	83 ec 0c             	sub    $0xc,%esp
    10f5:	ff 75 d4             	pushl  -0x2c(%ebp)
    10f8:	e8 9d 27 00 00       	call   389a <close>
    10fd:	83 c4 10             	add    $0x10,%esp
    1100:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1106:	0f 85 d3 00 00 00    	jne    11df <fourfiles+0x1cf>
    110c:	83 ec 0c             	sub    $0xc,%esp
    110f:	ff 75 d0             	pushl  -0x30(%ebp)
    1112:	e8 ab 27 00 00       	call   38c2 <unlink>
    1117:	83 c4 10             	add    $0x10,%esp
    111a:	83 ff 01             	cmp    $0x1,%edi
    111d:	75 1a                	jne    1139 <fourfiles+0x129>
    111f:	83 ec 08             	sub    $0x8,%esp
    1122:	68 e2 41 00 00       	push   $0x41e2
    1127:	6a 01                	push   $0x1
    1129:	e8 92 28 00 00       	call   39c0 <printf>
    112e:	83 c4 10             	add    $0x10,%esp
    1131:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1134:	5b                   	pop    %ebx
    1135:	5e                   	pop    %esi
    1136:	5f                   	pop    %edi
    1137:	5d                   	pop    %ebp
    1138:	c3                   	ret    
    1139:	8b 45 dc             	mov    -0x24(%ebp),%eax
    113c:	bf 01 00 00 00       	mov    $0x1,%edi
    1141:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1144:	e9 4c ff ff ff       	jmp    1095 <fourfiles+0x85>
    1149:	83 ec 08             	sub    $0x8,%esp
    114c:	68 02 02 00 00       	push   $0x202
    1151:	56                   	push   %esi
    1152:	e8 5b 27 00 00       	call   38b2 <open>
    1157:	83 c4 10             	add    $0x10,%esp
    115a:	85 c0                	test   %eax,%eax
    115c:	89 c6                	mov    %eax,%esi
    115e:	78 59                	js     11b9 <fourfiles+0x1a9>
    1160:	83 ec 04             	sub    $0x4,%esp
    1163:	83 c3 30             	add    $0x30,%ebx
    1166:	68 00 02 00 00       	push   $0x200
    116b:	53                   	push   %ebx
    116c:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1171:	68 c0 85 00 00       	push   $0x85c0
    1176:	e8 85 25 00 00       	call   3700 <memset>
    117b:	83 c4 10             	add    $0x10,%esp
    117e:	83 ec 04             	sub    $0x4,%esp
    1181:	68 f4 01 00 00       	push   $0x1f4
    1186:	68 c0 85 00 00       	push   $0x85c0
    118b:	56                   	push   %esi
    118c:	e8 01 27 00 00       	call   3892 <write>
    1191:	83 c4 10             	add    $0x10,%esp
    1194:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1199:	75 57                	jne    11f2 <fourfiles+0x1e2>
    119b:	83 eb 01             	sub    $0x1,%ebx
    119e:	75 de                	jne    117e <fourfiles+0x16e>
    11a0:	e8 cd 26 00 00       	call   3872 <exit>
    11a5:	83 ec 08             	sub    $0x8,%esp
    11a8:	68 c5 41 00 00       	push   $0x41c5
    11ad:	6a 01                	push   $0x1
    11af:	e8 0c 28 00 00       	call   39c0 <printf>
    11b4:	e8 b9 26 00 00       	call   3872 <exit>
    11b9:	51                   	push   %ecx
    11ba:	51                   	push   %ecx
    11bb:	68 3f 44 00 00       	push   $0x443f
    11c0:	6a 01                	push   $0x1
    11c2:	e8 f9 27 00 00       	call   39c0 <printf>
    11c7:	e8 a6 26 00 00       	call   3872 <exit>
    11cc:	53                   	push   %ebx
    11cd:	53                   	push   %ebx
    11ce:	68 79 4c 00 00       	push   $0x4c79
    11d3:	6a 01                	push   $0x1
    11d5:	e8 e6 27 00 00       	call   39c0 <printf>
    11da:	e8 93 26 00 00       	call   3872 <exit>
    11df:	50                   	push   %eax
    11e0:	53                   	push   %ebx
    11e1:	68 d1 41 00 00       	push   $0x41d1
    11e6:	6a 01                	push   $0x1
    11e8:	e8 d3 27 00 00       	call   39c0 <printf>
    11ed:	e8 80 26 00 00       	call   3872 <exit>
    11f2:	52                   	push   %edx
    11f3:	50                   	push   %eax
    11f4:	68 b4 41 00 00       	push   $0x41b4
    11f9:	6a 01                	push   $0x1
    11fb:	e8 c0 27 00 00       	call   39c0 <printf>
    1200:	e8 6d 26 00 00       	call   3872 <exit>
    1205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001210 <createdelete>:
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	57                   	push   %edi
    1214:	56                   	push   %esi
    1215:	53                   	push   %ebx
    1216:	31 db                	xor    %ebx,%ebx
    1218:	83 ec 44             	sub    $0x44,%esp
    121b:	68 f0 41 00 00       	push   $0x41f0
    1220:	6a 01                	push   $0x1
    1222:	e8 99 27 00 00       	call   39c0 <printf>
    1227:	83 c4 10             	add    $0x10,%esp
    122a:	e8 3b 26 00 00       	call   386a <fork>
    122f:	85 c0                	test   %eax,%eax
    1231:	0f 88 be 01 00 00    	js     13f5 <createdelete+0x1e5>
    1237:	0f 84 0b 01 00 00    	je     1348 <createdelete+0x138>
    123d:	83 c3 01             	add    $0x1,%ebx
    1240:	83 fb 04             	cmp    $0x4,%ebx
    1243:	75 e5                	jne    122a <createdelete+0x1a>
    1245:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1248:	be ff ff ff ff       	mov    $0xffffffff,%esi
    124d:	e8 28 26 00 00       	call   387a <wait>
    1252:	e8 23 26 00 00       	call   387a <wait>
    1257:	e8 1e 26 00 00       	call   387a <wait>
    125c:	e8 19 26 00 00       	call   387a <wait>
    1261:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1265:	8d 76 00             	lea    0x0(%esi),%esi
    1268:	8d 46 31             	lea    0x31(%esi),%eax
    126b:	88 45 c7             	mov    %al,-0x39(%ebp)
    126e:	8d 46 01             	lea    0x1(%esi),%eax
    1271:	83 f8 09             	cmp    $0x9,%eax
    1274:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1277:	0f 9f c3             	setg   %bl
    127a:	85 c0                	test   %eax,%eax
    127c:	0f 94 c0             	sete   %al
    127f:	09 c3                	or     %eax,%ebx
    1281:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    1284:	bb 70 00 00 00       	mov    $0x70,%ebx
    1289:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    128d:	83 ec 08             	sub    $0x8,%esp
    1290:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1293:	6a 00                	push   $0x0
    1295:	57                   	push   %edi
    1296:	88 45 c9             	mov    %al,-0x37(%ebp)
    1299:	e8 14 26 00 00       	call   38b2 <open>
    129e:	83 c4 10             	add    $0x10,%esp
    12a1:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12a5:	0f 84 85 00 00 00    	je     1330 <createdelete+0x120>
    12ab:	85 c0                	test   %eax,%eax
    12ad:	0f 88 1a 01 00 00    	js     13cd <createdelete+0x1bd>
    12b3:	83 fe 08             	cmp    $0x8,%esi
    12b6:	0f 86 54 01 00 00    	jbe    1410 <createdelete+0x200>
    12bc:	83 ec 0c             	sub    $0xc,%esp
    12bf:	50                   	push   %eax
    12c0:	e8 d5 25 00 00       	call   389a <close>
    12c5:	83 c4 10             	add    $0x10,%esp
    12c8:	83 c3 01             	add    $0x1,%ebx
    12cb:	80 fb 74             	cmp    $0x74,%bl
    12ce:	75 b9                	jne    1289 <createdelete+0x79>
    12d0:	8b 75 c0             	mov    -0x40(%ebp),%esi
    12d3:	83 fe 13             	cmp    $0x13,%esi
    12d6:	75 90                	jne    1268 <createdelete+0x58>
    12d8:	be 70 00 00 00       	mov    $0x70,%esi
    12dd:	8d 76 00             	lea    0x0(%esi),%esi
    12e0:	8d 46 c0             	lea    -0x40(%esi),%eax
    12e3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12e8:	88 45 c7             	mov    %al,-0x39(%ebp)
    12eb:	89 f0                	mov    %esi,%eax
    12ed:	83 ec 0c             	sub    $0xc,%esp
    12f0:	88 45 c8             	mov    %al,-0x38(%ebp)
    12f3:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    12f7:	57                   	push   %edi
    12f8:	88 45 c9             	mov    %al,-0x37(%ebp)
    12fb:	e8 c2 25 00 00       	call   38c2 <unlink>
    1300:	83 c4 10             	add    $0x10,%esp
    1303:	83 eb 01             	sub    $0x1,%ebx
    1306:	75 e3                	jne    12eb <createdelete+0xdb>
    1308:	83 c6 01             	add    $0x1,%esi
    130b:	89 f0                	mov    %esi,%eax
    130d:	3c 84                	cmp    $0x84,%al
    130f:	75 cf                	jne    12e0 <createdelete+0xd0>
    1311:	83 ec 08             	sub    $0x8,%esp
    1314:	68 03 42 00 00       	push   $0x4203
    1319:	6a 01                	push   $0x1
    131b:	e8 a0 26 00 00       	call   39c0 <printf>
    1320:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1323:	5b                   	pop    %ebx
    1324:	5e                   	pop    %esi
    1325:	5f                   	pop    %edi
    1326:	5d                   	pop    %ebp
    1327:	c3                   	ret    
    1328:	90                   	nop
    1329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1330:	83 fe 08             	cmp    $0x8,%esi
    1333:	0f 86 cf 00 00 00    	jbe    1408 <createdelete+0x1f8>
    1339:	85 c0                	test   %eax,%eax
    133b:	78 8b                	js     12c8 <createdelete+0xb8>
    133d:	e9 7a ff ff ff       	jmp    12bc <createdelete+0xac>
    1342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1348:	83 c3 70             	add    $0x70,%ebx
    134b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    134f:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1352:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1355:	31 db                	xor    %ebx,%ebx
    1357:	eb 0f                	jmp    1368 <createdelete+0x158>
    1359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1360:	83 fb 13             	cmp    $0x13,%ebx
    1363:	74 63                	je     13c8 <createdelete+0x1b8>
    1365:	83 c3 01             	add    $0x1,%ebx
    1368:	83 ec 08             	sub    $0x8,%esp
    136b:	8d 43 30             	lea    0x30(%ebx),%eax
    136e:	68 02 02 00 00       	push   $0x202
    1373:	57                   	push   %edi
    1374:	88 45 c9             	mov    %al,-0x37(%ebp)
    1377:	e8 36 25 00 00       	call   38b2 <open>
    137c:	83 c4 10             	add    $0x10,%esp
    137f:	85 c0                	test   %eax,%eax
    1381:	78 5f                	js     13e2 <createdelete+0x1d2>
    1383:	83 ec 0c             	sub    $0xc,%esp
    1386:	50                   	push   %eax
    1387:	e8 0e 25 00 00       	call   389a <close>
    138c:	83 c4 10             	add    $0x10,%esp
    138f:	85 db                	test   %ebx,%ebx
    1391:	74 d2                	je     1365 <createdelete+0x155>
    1393:	f6 c3 01             	test   $0x1,%bl
    1396:	75 c8                	jne    1360 <createdelete+0x150>
    1398:	83 ec 0c             	sub    $0xc,%esp
    139b:	89 d8                	mov    %ebx,%eax
    139d:	d1 f8                	sar    %eax
    139f:	57                   	push   %edi
    13a0:	83 c0 30             	add    $0x30,%eax
    13a3:	88 45 c9             	mov    %al,-0x37(%ebp)
    13a6:	e8 17 25 00 00       	call   38c2 <unlink>
    13ab:	83 c4 10             	add    $0x10,%esp
    13ae:	85 c0                	test   %eax,%eax
    13b0:	79 ae                	jns    1360 <createdelete+0x150>
    13b2:	52                   	push   %edx
    13b3:	52                   	push   %edx
    13b4:	68 f1 3d 00 00       	push   $0x3df1
    13b9:	6a 01                	push   $0x1
    13bb:	e8 00 26 00 00       	call   39c0 <printf>
    13c0:	e8 ad 24 00 00       	call   3872 <exit>
    13c5:	8d 76 00             	lea    0x0(%esi),%esi
    13c8:	e8 a5 24 00 00       	call   3872 <exit>
    13cd:	83 ec 04             	sub    $0x4,%esp
    13d0:	57                   	push   %edi
    13d1:	68 b0 4e 00 00       	push   $0x4eb0
    13d6:	6a 01                	push   $0x1
    13d8:	e8 e3 25 00 00       	call   39c0 <printf>
    13dd:	e8 90 24 00 00       	call   3872 <exit>
    13e2:	51                   	push   %ecx
    13e3:	51                   	push   %ecx
    13e4:	68 3f 44 00 00       	push   $0x443f
    13e9:	6a 01                	push   $0x1
    13eb:	e8 d0 25 00 00       	call   39c0 <printf>
    13f0:	e8 7d 24 00 00       	call   3872 <exit>
    13f5:	53                   	push   %ebx
    13f6:	53                   	push   %ebx
    13f7:	68 79 4c 00 00       	push   $0x4c79
    13fc:	6a 01                	push   $0x1
    13fe:	e8 bd 25 00 00       	call   39c0 <printf>
    1403:	e8 6a 24 00 00       	call   3872 <exit>
    1408:	85 c0                	test   %eax,%eax
    140a:	0f 88 b8 fe ff ff    	js     12c8 <createdelete+0xb8>
    1410:	50                   	push   %eax
    1411:	57                   	push   %edi
    1412:	68 d4 4e 00 00       	push   $0x4ed4
    1417:	6a 01                	push   $0x1
    1419:	e8 a2 25 00 00       	call   39c0 <printf>
    141e:	e8 4f 24 00 00       	call   3872 <exit>
    1423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001430 <unlinkread>:
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	56                   	push   %esi
    1434:	53                   	push   %ebx
    1435:	83 ec 08             	sub    $0x8,%esp
    1438:	68 14 42 00 00       	push   $0x4214
    143d:	6a 01                	push   $0x1
    143f:	e8 7c 25 00 00       	call   39c0 <printf>
    1444:	5b                   	pop    %ebx
    1445:	5e                   	pop    %esi
    1446:	68 02 02 00 00       	push   $0x202
    144b:	68 25 42 00 00       	push   $0x4225
    1450:	e8 5d 24 00 00       	call   38b2 <open>
    1455:	83 c4 10             	add    $0x10,%esp
    1458:	85 c0                	test   %eax,%eax
    145a:	0f 88 e6 00 00 00    	js     1546 <unlinkread+0x116>
    1460:	83 ec 04             	sub    $0x4,%esp
    1463:	89 c3                	mov    %eax,%ebx
    1465:	6a 05                	push   $0x5
    1467:	68 4a 42 00 00       	push   $0x424a
    146c:	50                   	push   %eax
    146d:	e8 20 24 00 00       	call   3892 <write>
    1472:	89 1c 24             	mov    %ebx,(%esp)
    1475:	e8 20 24 00 00       	call   389a <close>
    147a:	58                   	pop    %eax
    147b:	5a                   	pop    %edx
    147c:	6a 02                	push   $0x2
    147e:	68 25 42 00 00       	push   $0x4225
    1483:	e8 2a 24 00 00       	call   38b2 <open>
    1488:	83 c4 10             	add    $0x10,%esp
    148b:	85 c0                	test   %eax,%eax
    148d:	89 c3                	mov    %eax,%ebx
    148f:	0f 88 10 01 00 00    	js     15a5 <unlinkread+0x175>
    1495:	83 ec 0c             	sub    $0xc,%esp
    1498:	68 25 42 00 00       	push   $0x4225
    149d:	e8 20 24 00 00       	call   38c2 <unlink>
    14a2:	83 c4 10             	add    $0x10,%esp
    14a5:	85 c0                	test   %eax,%eax
    14a7:	0f 85 e5 00 00 00    	jne    1592 <unlinkread+0x162>
    14ad:	83 ec 08             	sub    $0x8,%esp
    14b0:	68 02 02 00 00       	push   $0x202
    14b5:	68 25 42 00 00       	push   $0x4225
    14ba:	e8 f3 23 00 00       	call   38b2 <open>
    14bf:	83 c4 0c             	add    $0xc,%esp
    14c2:	89 c6                	mov    %eax,%esi
    14c4:	6a 03                	push   $0x3
    14c6:	68 82 42 00 00       	push   $0x4282
    14cb:	50                   	push   %eax
    14cc:	e8 c1 23 00 00       	call   3892 <write>
    14d1:	89 34 24             	mov    %esi,(%esp)
    14d4:	e8 c1 23 00 00       	call   389a <close>
    14d9:	83 c4 0c             	add    $0xc,%esp
    14dc:	68 00 20 00 00       	push   $0x2000
    14e1:	68 c0 85 00 00       	push   $0x85c0
    14e6:	53                   	push   %ebx
    14e7:	e8 9e 23 00 00       	call   388a <read>
    14ec:	83 c4 10             	add    $0x10,%esp
    14ef:	83 f8 05             	cmp    $0x5,%eax
    14f2:	0f 85 87 00 00 00    	jne    157f <unlinkread+0x14f>
    14f8:	80 3d c0 85 00 00 68 	cmpb   $0x68,0x85c0
    14ff:	75 6b                	jne    156c <unlinkread+0x13c>
    1501:	83 ec 04             	sub    $0x4,%esp
    1504:	6a 0a                	push   $0xa
    1506:	68 c0 85 00 00       	push   $0x85c0
    150b:	53                   	push   %ebx
    150c:	e8 81 23 00 00       	call   3892 <write>
    1511:	83 c4 10             	add    $0x10,%esp
    1514:	83 f8 0a             	cmp    $0xa,%eax
    1517:	75 40                	jne    1559 <unlinkread+0x129>
    1519:	83 ec 0c             	sub    $0xc,%esp
    151c:	53                   	push   %ebx
    151d:	e8 78 23 00 00       	call   389a <close>
    1522:	c7 04 24 25 42 00 00 	movl   $0x4225,(%esp)
    1529:	e8 94 23 00 00       	call   38c2 <unlink>
    152e:	58                   	pop    %eax
    152f:	5a                   	pop    %edx
    1530:	68 cd 42 00 00       	push   $0x42cd
    1535:	6a 01                	push   $0x1
    1537:	e8 84 24 00 00       	call   39c0 <printf>
    153c:	83 c4 10             	add    $0x10,%esp
    153f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1542:	5b                   	pop    %ebx
    1543:	5e                   	pop    %esi
    1544:	5d                   	pop    %ebp
    1545:	c3                   	ret    
    1546:	51                   	push   %ecx
    1547:	51                   	push   %ecx
    1548:	68 30 42 00 00       	push   $0x4230
    154d:	6a 01                	push   $0x1
    154f:	e8 6c 24 00 00       	call   39c0 <printf>
    1554:	e8 19 23 00 00       	call   3872 <exit>
    1559:	51                   	push   %ecx
    155a:	51                   	push   %ecx
    155b:	68 b4 42 00 00       	push   $0x42b4
    1560:	6a 01                	push   $0x1
    1562:	e8 59 24 00 00       	call   39c0 <printf>
    1567:	e8 06 23 00 00       	call   3872 <exit>
    156c:	53                   	push   %ebx
    156d:	53                   	push   %ebx
    156e:	68 9d 42 00 00       	push   $0x429d
    1573:	6a 01                	push   $0x1
    1575:	e8 46 24 00 00       	call   39c0 <printf>
    157a:	e8 f3 22 00 00       	call   3872 <exit>
    157f:	56                   	push   %esi
    1580:	56                   	push   %esi
    1581:	68 86 42 00 00       	push   $0x4286
    1586:	6a 01                	push   $0x1
    1588:	e8 33 24 00 00       	call   39c0 <printf>
    158d:	e8 e0 22 00 00       	call   3872 <exit>
    1592:	50                   	push   %eax
    1593:	50                   	push   %eax
    1594:	68 68 42 00 00       	push   $0x4268
    1599:	6a 01                	push   $0x1
    159b:	e8 20 24 00 00       	call   39c0 <printf>
    15a0:	e8 cd 22 00 00       	call   3872 <exit>
    15a5:	50                   	push   %eax
    15a6:	50                   	push   %eax
    15a7:	68 50 42 00 00       	push   $0x4250
    15ac:	6a 01                	push   $0x1
    15ae:	e8 0d 24 00 00       	call   39c0 <printf>
    15b3:	e8 ba 22 00 00       	call   3872 <exit>
    15b8:	90                   	nop
    15b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015c0 <linktest>:
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	53                   	push   %ebx
    15c4:	83 ec 0c             	sub    $0xc,%esp
    15c7:	68 dc 42 00 00       	push   $0x42dc
    15cc:	6a 01                	push   $0x1
    15ce:	e8 ed 23 00 00       	call   39c0 <printf>
    15d3:	c7 04 24 e6 42 00 00 	movl   $0x42e6,(%esp)
    15da:	e8 e3 22 00 00       	call   38c2 <unlink>
    15df:	c7 04 24 ea 42 00 00 	movl   $0x42ea,(%esp)
    15e6:	e8 d7 22 00 00       	call   38c2 <unlink>
    15eb:	58                   	pop    %eax
    15ec:	5a                   	pop    %edx
    15ed:	68 02 02 00 00       	push   $0x202
    15f2:	68 e6 42 00 00       	push   $0x42e6
    15f7:	e8 b6 22 00 00       	call   38b2 <open>
    15fc:	83 c4 10             	add    $0x10,%esp
    15ff:	85 c0                	test   %eax,%eax
    1601:	0f 88 1e 01 00 00    	js     1725 <linktest+0x165>
    1607:	83 ec 04             	sub    $0x4,%esp
    160a:	89 c3                	mov    %eax,%ebx
    160c:	6a 05                	push   $0x5
    160e:	68 4a 42 00 00       	push   $0x424a
    1613:	50                   	push   %eax
    1614:	e8 79 22 00 00       	call   3892 <write>
    1619:	83 c4 10             	add    $0x10,%esp
    161c:	83 f8 05             	cmp    $0x5,%eax
    161f:	0f 85 98 01 00 00    	jne    17bd <linktest+0x1fd>
    1625:	83 ec 0c             	sub    $0xc,%esp
    1628:	53                   	push   %ebx
    1629:	e8 6c 22 00 00       	call   389a <close>
    162e:	5b                   	pop    %ebx
    162f:	58                   	pop    %eax
    1630:	68 ea 42 00 00       	push   $0x42ea
    1635:	68 e6 42 00 00       	push   $0x42e6
    163a:	e8 93 22 00 00       	call   38d2 <link>
    163f:	83 c4 10             	add    $0x10,%esp
    1642:	85 c0                	test   %eax,%eax
    1644:	0f 88 60 01 00 00    	js     17aa <linktest+0x1ea>
    164a:	83 ec 0c             	sub    $0xc,%esp
    164d:	68 e6 42 00 00       	push   $0x42e6
    1652:	e8 6b 22 00 00       	call   38c2 <unlink>
    1657:	58                   	pop    %eax
    1658:	5a                   	pop    %edx
    1659:	6a 00                	push   $0x0
    165b:	68 e6 42 00 00       	push   $0x42e6
    1660:	e8 4d 22 00 00       	call   38b2 <open>
    1665:	83 c4 10             	add    $0x10,%esp
    1668:	85 c0                	test   %eax,%eax
    166a:	0f 89 27 01 00 00    	jns    1797 <linktest+0x1d7>
    1670:	83 ec 08             	sub    $0x8,%esp
    1673:	6a 00                	push   $0x0
    1675:	68 ea 42 00 00       	push   $0x42ea
    167a:	e8 33 22 00 00       	call   38b2 <open>
    167f:	83 c4 10             	add    $0x10,%esp
    1682:	85 c0                	test   %eax,%eax
    1684:	89 c3                	mov    %eax,%ebx
    1686:	0f 88 f8 00 00 00    	js     1784 <linktest+0x1c4>
    168c:	83 ec 04             	sub    $0x4,%esp
    168f:	68 00 20 00 00       	push   $0x2000
    1694:	68 c0 85 00 00       	push   $0x85c0
    1699:	50                   	push   %eax
    169a:	e8 eb 21 00 00       	call   388a <read>
    169f:	83 c4 10             	add    $0x10,%esp
    16a2:	83 f8 05             	cmp    $0x5,%eax
    16a5:	0f 85 c6 00 00 00    	jne    1771 <linktest+0x1b1>
    16ab:	83 ec 0c             	sub    $0xc,%esp
    16ae:	53                   	push   %ebx
    16af:	e8 e6 21 00 00       	call   389a <close>
    16b4:	58                   	pop    %eax
    16b5:	5a                   	pop    %edx
    16b6:	68 ea 42 00 00       	push   $0x42ea
    16bb:	68 ea 42 00 00       	push   $0x42ea
    16c0:	e8 0d 22 00 00       	call   38d2 <link>
    16c5:	83 c4 10             	add    $0x10,%esp
    16c8:	85 c0                	test   %eax,%eax
    16ca:	0f 89 8e 00 00 00    	jns    175e <linktest+0x19e>
    16d0:	83 ec 0c             	sub    $0xc,%esp
    16d3:	68 ea 42 00 00       	push   $0x42ea
    16d8:	e8 e5 21 00 00       	call   38c2 <unlink>
    16dd:	59                   	pop    %ecx
    16de:	5b                   	pop    %ebx
    16df:	68 e6 42 00 00       	push   $0x42e6
    16e4:	68 ea 42 00 00       	push   $0x42ea
    16e9:	e8 e4 21 00 00       	call   38d2 <link>
    16ee:	83 c4 10             	add    $0x10,%esp
    16f1:	85 c0                	test   %eax,%eax
    16f3:	79 56                	jns    174b <linktest+0x18b>
    16f5:	83 ec 08             	sub    $0x8,%esp
    16f8:	68 e6 42 00 00       	push   $0x42e6
    16fd:	68 ae 45 00 00       	push   $0x45ae
    1702:	e8 cb 21 00 00       	call   38d2 <link>
    1707:	83 c4 10             	add    $0x10,%esp
    170a:	85 c0                	test   %eax,%eax
    170c:	79 2a                	jns    1738 <linktest+0x178>
    170e:	83 ec 08             	sub    $0x8,%esp
    1711:	68 84 43 00 00       	push   $0x4384
    1716:	6a 01                	push   $0x1
    1718:	e8 a3 22 00 00       	call   39c0 <printf>
    171d:	83 c4 10             	add    $0x10,%esp
    1720:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1723:	c9                   	leave  
    1724:	c3                   	ret    
    1725:	50                   	push   %eax
    1726:	50                   	push   %eax
    1727:	68 ee 42 00 00       	push   $0x42ee
    172c:	6a 01                	push   $0x1
    172e:	e8 8d 22 00 00       	call   39c0 <printf>
    1733:	e8 3a 21 00 00       	call   3872 <exit>
    1738:	50                   	push   %eax
    1739:	50                   	push   %eax
    173a:	68 68 43 00 00       	push   $0x4368
    173f:	6a 01                	push   $0x1
    1741:	e8 7a 22 00 00       	call   39c0 <printf>
    1746:	e8 27 21 00 00       	call   3872 <exit>
    174b:	52                   	push   %edx
    174c:	52                   	push   %edx
    174d:	68 1c 4f 00 00       	push   $0x4f1c
    1752:	6a 01                	push   $0x1
    1754:	e8 67 22 00 00       	call   39c0 <printf>
    1759:	e8 14 21 00 00       	call   3872 <exit>
    175e:	50                   	push   %eax
    175f:	50                   	push   %eax
    1760:	68 4a 43 00 00       	push   $0x434a
    1765:	6a 01                	push   $0x1
    1767:	e8 54 22 00 00       	call   39c0 <printf>
    176c:	e8 01 21 00 00       	call   3872 <exit>
    1771:	51                   	push   %ecx
    1772:	51                   	push   %ecx
    1773:	68 39 43 00 00       	push   $0x4339
    1778:	6a 01                	push   $0x1
    177a:	e8 41 22 00 00       	call   39c0 <printf>
    177f:	e8 ee 20 00 00       	call   3872 <exit>
    1784:	53                   	push   %ebx
    1785:	53                   	push   %ebx
    1786:	68 28 43 00 00       	push   $0x4328
    178b:	6a 01                	push   $0x1
    178d:	e8 2e 22 00 00       	call   39c0 <printf>
    1792:	e8 db 20 00 00       	call   3872 <exit>
    1797:	50                   	push   %eax
    1798:	50                   	push   %eax
    1799:	68 f4 4e 00 00       	push   $0x4ef4
    179e:	6a 01                	push   $0x1
    17a0:	e8 1b 22 00 00       	call   39c0 <printf>
    17a5:	e8 c8 20 00 00       	call   3872 <exit>
    17aa:	51                   	push   %ecx
    17ab:	51                   	push   %ecx
    17ac:	68 13 43 00 00       	push   $0x4313
    17b1:	6a 01                	push   $0x1
    17b3:	e8 08 22 00 00       	call   39c0 <printf>
    17b8:	e8 b5 20 00 00       	call   3872 <exit>
    17bd:	50                   	push   %eax
    17be:	50                   	push   %eax
    17bf:	68 01 43 00 00       	push   $0x4301
    17c4:	6a 01                	push   $0x1
    17c6:	e8 f5 21 00 00       	call   39c0 <printf>
    17cb:	e8 a2 20 00 00       	call   3872 <exit>

000017d0 <concreate>:
    17d0:	55                   	push   %ebp
    17d1:	89 e5                	mov    %esp,%ebp
    17d3:	57                   	push   %edi
    17d4:	56                   	push   %esi
    17d5:	53                   	push   %ebx
    17d6:	31 f6                	xor    %esi,%esi
    17d8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17db:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
    17e0:	83 ec 64             	sub    $0x64,%esp
    17e3:	68 91 43 00 00       	push   $0x4391
    17e8:	6a 01                	push   $0x1
    17ea:	e8 d1 21 00 00       	call   39c0 <printf>
    17ef:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
    17f3:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    17f7:	83 c4 10             	add    $0x10,%esp
    17fa:	eb 4c                	jmp    1848 <concreate+0x78>
    17fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1800:	89 f0                	mov    %esi,%eax
    1802:	89 f1                	mov    %esi,%ecx
    1804:	f7 e7                	mul    %edi
    1806:	d1 ea                	shr    %edx
    1808:	8d 04 52             	lea    (%edx,%edx,2),%eax
    180b:	29 c1                	sub    %eax,%ecx
    180d:	83 f9 01             	cmp    $0x1,%ecx
    1810:	0f 84 ba 00 00 00    	je     18d0 <concreate+0x100>
    1816:	83 ec 08             	sub    $0x8,%esp
    1819:	68 02 02 00 00       	push   $0x202
    181e:	53                   	push   %ebx
    181f:	e8 8e 20 00 00       	call   38b2 <open>
    1824:	83 c4 10             	add    $0x10,%esp
    1827:	85 c0                	test   %eax,%eax
    1829:	78 67                	js     1892 <concreate+0xc2>
    182b:	83 ec 0c             	sub    $0xc,%esp
    182e:	83 c6 01             	add    $0x1,%esi
    1831:	50                   	push   %eax
    1832:	e8 63 20 00 00       	call   389a <close>
    1837:	83 c4 10             	add    $0x10,%esp
    183a:	e8 3b 20 00 00       	call   387a <wait>
    183f:	83 fe 28             	cmp    $0x28,%esi
    1842:	0f 84 aa 00 00 00    	je     18f2 <concreate+0x122>
    1848:	83 ec 0c             	sub    $0xc,%esp
    184b:	8d 46 30             	lea    0x30(%esi),%eax
    184e:	53                   	push   %ebx
    184f:	88 45 ae             	mov    %al,-0x52(%ebp)
    1852:	e8 6b 20 00 00       	call   38c2 <unlink>
    1857:	e8 0e 20 00 00       	call   386a <fork>
    185c:	83 c4 10             	add    $0x10,%esp
    185f:	85 c0                	test   %eax,%eax
    1861:	75 9d                	jne    1800 <concreate+0x30>
    1863:	89 f0                	mov    %esi,%eax
    1865:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    186a:	f7 e2                	mul    %edx
    186c:	c1 ea 02             	shr    $0x2,%edx
    186f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1872:	29 c6                	sub    %eax,%esi
    1874:	83 fe 01             	cmp    $0x1,%esi
    1877:	74 37                	je     18b0 <concreate+0xe0>
    1879:	83 ec 08             	sub    $0x8,%esp
    187c:	68 02 02 00 00       	push   $0x202
    1881:	53                   	push   %ebx
    1882:	e8 2b 20 00 00       	call   38b2 <open>
    1887:	83 c4 10             	add    $0x10,%esp
    188a:	85 c0                	test   %eax,%eax
    188c:	0f 89 28 02 00 00    	jns    1aba <concreate+0x2ea>
    1892:	83 ec 04             	sub    $0x4,%esp
    1895:	53                   	push   %ebx
    1896:	68 a4 43 00 00       	push   $0x43a4
    189b:	6a 01                	push   $0x1
    189d:	e8 1e 21 00 00       	call   39c0 <printf>
    18a2:	e8 cb 1f 00 00       	call   3872 <exit>
    18a7:	89 f6                	mov    %esi,%esi
    18a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    18b0:	83 ec 08             	sub    $0x8,%esp
    18b3:	53                   	push   %ebx
    18b4:	68 a1 43 00 00       	push   $0x43a1
    18b9:	e8 14 20 00 00       	call   38d2 <link>
    18be:	83 c4 10             	add    $0x10,%esp
    18c1:	e8 ac 1f 00 00       	call   3872 <exit>
    18c6:	8d 76 00             	lea    0x0(%esi),%esi
    18c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    18d0:	83 ec 08             	sub    $0x8,%esp
    18d3:	83 c6 01             	add    $0x1,%esi
    18d6:	53                   	push   %ebx
    18d7:	68 a1 43 00 00       	push   $0x43a1
    18dc:	e8 f1 1f 00 00       	call   38d2 <link>
    18e1:	83 c4 10             	add    $0x10,%esp
    18e4:	e8 91 1f 00 00       	call   387a <wait>
    18e9:	83 fe 28             	cmp    $0x28,%esi
    18ec:	0f 85 56 ff ff ff    	jne    1848 <concreate+0x78>
    18f2:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18f5:	83 ec 04             	sub    $0x4,%esp
    18f8:	6a 28                	push   $0x28
    18fa:	6a 00                	push   $0x0
    18fc:	50                   	push   %eax
    18fd:	e8 fe 1d 00 00       	call   3700 <memset>
    1902:	5f                   	pop    %edi
    1903:	58                   	pop    %eax
    1904:	6a 00                	push   $0x0
    1906:	68 ae 45 00 00       	push   $0x45ae
    190b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    190e:	e8 9f 1f 00 00       	call   38b2 <open>
    1913:	83 c4 10             	add    $0x10,%esp
    1916:	89 c6                	mov    %eax,%esi
    1918:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    191f:	90                   	nop
    1920:	83 ec 04             	sub    $0x4,%esp
    1923:	6a 10                	push   $0x10
    1925:	57                   	push   %edi
    1926:	56                   	push   %esi
    1927:	e8 5e 1f 00 00       	call   388a <read>
    192c:	83 c4 10             	add    $0x10,%esp
    192f:	85 c0                	test   %eax,%eax
    1931:	7e 3d                	jle    1970 <concreate+0x1a0>
    1933:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1938:	74 e6                	je     1920 <concreate+0x150>
    193a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    193e:	75 e0                	jne    1920 <concreate+0x150>
    1940:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1944:	75 da                	jne    1920 <concreate+0x150>
    1946:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    194a:	83 e8 30             	sub    $0x30,%eax
    194d:	83 f8 27             	cmp    $0x27,%eax
    1950:	0f 87 4e 01 00 00    	ja     1aa4 <concreate+0x2d4>
    1956:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    195b:	0f 85 2d 01 00 00    	jne    1a8e <concreate+0x2be>
    1961:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
    1966:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    196a:	eb b4                	jmp    1920 <concreate+0x150>
    196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1970:	83 ec 0c             	sub    $0xc,%esp
    1973:	56                   	push   %esi
    1974:	e8 21 1f 00 00       	call   389a <close>
    1979:	83 c4 10             	add    $0x10,%esp
    197c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1980:	0f 85 f5 00 00 00    	jne    1a7b <concreate+0x2ab>
    1986:	31 f6                	xor    %esi,%esi
    1988:	eb 48                	jmp    19d2 <concreate+0x202>
    198a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1990:	85 ff                	test   %edi,%edi
    1992:	74 05                	je     1999 <concreate+0x1c9>
    1994:	83 fa 01             	cmp    $0x1,%edx
    1997:	74 64                	je     19fd <concreate+0x22d>
    1999:	83 ec 0c             	sub    $0xc,%esp
    199c:	53                   	push   %ebx
    199d:	e8 20 1f 00 00       	call   38c2 <unlink>
    19a2:	89 1c 24             	mov    %ebx,(%esp)
    19a5:	e8 18 1f 00 00       	call   38c2 <unlink>
    19aa:	89 1c 24             	mov    %ebx,(%esp)
    19ad:	e8 10 1f 00 00       	call   38c2 <unlink>
    19b2:	89 1c 24             	mov    %ebx,(%esp)
    19b5:	e8 08 1f 00 00       	call   38c2 <unlink>
    19ba:	83 c4 10             	add    $0x10,%esp
    19bd:	85 ff                	test   %edi,%edi
    19bf:	0f 84 fc fe ff ff    	je     18c1 <concreate+0xf1>
    19c5:	83 c6 01             	add    $0x1,%esi
    19c8:	e8 ad 1e 00 00       	call   387a <wait>
    19cd:	83 fe 28             	cmp    $0x28,%esi
    19d0:	74 7e                	je     1a50 <concreate+0x280>
    19d2:	8d 46 30             	lea    0x30(%esi),%eax
    19d5:	88 45 ae             	mov    %al,-0x52(%ebp)
    19d8:	e8 8d 1e 00 00       	call   386a <fork>
    19dd:	85 c0                	test   %eax,%eax
    19df:	89 c7                	mov    %eax,%edi
    19e1:	0f 88 80 00 00 00    	js     1a67 <concreate+0x297>
    19e7:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19ec:	f7 e6                	mul    %esi
    19ee:	d1 ea                	shr    %edx
    19f0:	8d 04 52             	lea    (%edx,%edx,2),%eax
    19f3:	89 f2                	mov    %esi,%edx
    19f5:	29 c2                	sub    %eax,%edx
    19f7:	89 d0                	mov    %edx,%eax
    19f9:	09 f8                	or     %edi,%eax
    19fb:	75 93                	jne    1990 <concreate+0x1c0>
    19fd:	83 ec 08             	sub    $0x8,%esp
    1a00:	6a 00                	push   $0x0
    1a02:	53                   	push   %ebx
    1a03:	e8 aa 1e 00 00       	call   38b2 <open>
    1a08:	89 04 24             	mov    %eax,(%esp)
    1a0b:	e8 8a 1e 00 00       	call   389a <close>
    1a10:	58                   	pop    %eax
    1a11:	5a                   	pop    %edx
    1a12:	6a 00                	push   $0x0
    1a14:	53                   	push   %ebx
    1a15:	e8 98 1e 00 00       	call   38b2 <open>
    1a1a:	89 04 24             	mov    %eax,(%esp)
    1a1d:	e8 78 1e 00 00       	call   389a <close>
    1a22:	59                   	pop    %ecx
    1a23:	58                   	pop    %eax
    1a24:	6a 00                	push   $0x0
    1a26:	53                   	push   %ebx
    1a27:	e8 86 1e 00 00       	call   38b2 <open>
    1a2c:	89 04 24             	mov    %eax,(%esp)
    1a2f:	e8 66 1e 00 00       	call   389a <close>
    1a34:	58                   	pop    %eax
    1a35:	5a                   	pop    %edx
    1a36:	6a 00                	push   $0x0
    1a38:	53                   	push   %ebx
    1a39:	e8 74 1e 00 00       	call   38b2 <open>
    1a3e:	89 04 24             	mov    %eax,(%esp)
    1a41:	e8 54 1e 00 00       	call   389a <close>
    1a46:	83 c4 10             	add    $0x10,%esp
    1a49:	e9 6f ff ff ff       	jmp    19bd <concreate+0x1ed>
    1a4e:	66 90                	xchg   %ax,%ax
    1a50:	83 ec 08             	sub    $0x8,%esp
    1a53:	68 f6 43 00 00       	push   $0x43f6
    1a58:	6a 01                	push   $0x1
    1a5a:	e8 61 1f 00 00       	call   39c0 <printf>
    1a5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a62:	5b                   	pop    %ebx
    1a63:	5e                   	pop    %esi
    1a64:	5f                   	pop    %edi
    1a65:	5d                   	pop    %ebp
    1a66:	c3                   	ret    
    1a67:	83 ec 08             	sub    $0x8,%esp
    1a6a:	68 79 4c 00 00       	push   $0x4c79
    1a6f:	6a 01                	push   $0x1
    1a71:	e8 4a 1f 00 00       	call   39c0 <printf>
    1a76:	e8 f7 1d 00 00       	call   3872 <exit>
    1a7b:	51                   	push   %ecx
    1a7c:	51                   	push   %ecx
    1a7d:	68 40 4f 00 00       	push   $0x4f40
    1a82:	6a 01                	push   $0x1
    1a84:	e8 37 1f 00 00       	call   39c0 <printf>
    1a89:	e8 e4 1d 00 00       	call   3872 <exit>
    1a8e:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a91:	53                   	push   %ebx
    1a92:	50                   	push   %eax
    1a93:	68 d9 43 00 00       	push   $0x43d9
    1a98:	6a 01                	push   $0x1
    1a9a:	e8 21 1f 00 00       	call   39c0 <printf>
    1a9f:	e8 ce 1d 00 00       	call   3872 <exit>
    1aa4:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1aa7:	56                   	push   %esi
    1aa8:	50                   	push   %eax
    1aa9:	68 c0 43 00 00       	push   $0x43c0
    1aae:	6a 01                	push   $0x1
    1ab0:	e8 0b 1f 00 00       	call   39c0 <printf>
    1ab5:	e8 b8 1d 00 00       	call   3872 <exit>
    1aba:	83 ec 0c             	sub    $0xc,%esp
    1abd:	50                   	push   %eax
    1abe:	e8 d7 1d 00 00       	call   389a <close>
    1ac3:	83 c4 10             	add    $0x10,%esp
    1ac6:	e9 f6 fd ff ff       	jmp    18c1 <concreate+0xf1>
    1acb:	90                   	nop
    1acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001ad0 <linkunlink>:
    1ad0:	55                   	push   %ebp
    1ad1:	89 e5                	mov    %esp,%ebp
    1ad3:	57                   	push   %edi
    1ad4:	56                   	push   %esi
    1ad5:	53                   	push   %ebx
    1ad6:	83 ec 24             	sub    $0x24,%esp
    1ad9:	68 04 44 00 00       	push   $0x4404
    1ade:	6a 01                	push   $0x1
    1ae0:	e8 db 1e 00 00       	call   39c0 <printf>
    1ae5:	c7 04 24 91 46 00 00 	movl   $0x4691,(%esp)
    1aec:	e8 d1 1d 00 00       	call   38c2 <unlink>
    1af1:	e8 74 1d 00 00       	call   386a <fork>
    1af6:	83 c4 10             	add    $0x10,%esp
    1af9:	85 c0                	test   %eax,%eax
    1afb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1afe:	0f 88 b6 00 00 00    	js     1bba <linkunlink+0xea>
    1b04:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b08:	bb 64 00 00 00       	mov    $0x64,%ebx
    1b0d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    1b12:	19 ff                	sbb    %edi,%edi
    1b14:	83 e7 60             	and    $0x60,%edi
    1b17:	83 c7 01             	add    $0x1,%edi
    1b1a:	eb 1e                	jmp    1b3a <linkunlink+0x6a>
    1b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1b20:	83 fa 01             	cmp    $0x1,%edx
    1b23:	74 7b                	je     1ba0 <linkunlink+0xd0>
    1b25:	83 ec 0c             	sub    $0xc,%esp
    1b28:	68 91 46 00 00       	push   $0x4691
    1b2d:	e8 90 1d 00 00       	call   38c2 <unlink>
    1b32:	83 c4 10             	add    $0x10,%esp
    1b35:	83 eb 01             	sub    $0x1,%ebx
    1b38:	74 3d                	je     1b77 <linkunlink+0xa7>
    1b3a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b40:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    1b46:	89 f8                	mov    %edi,%eax
    1b48:	f7 e6                	mul    %esi
    1b4a:	d1 ea                	shr    %edx
    1b4c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b4f:	89 fa                	mov    %edi,%edx
    1b51:	29 c2                	sub    %eax,%edx
    1b53:	75 cb                	jne    1b20 <linkunlink+0x50>
    1b55:	83 ec 08             	sub    $0x8,%esp
    1b58:	68 02 02 00 00       	push   $0x202
    1b5d:	68 91 46 00 00       	push   $0x4691
    1b62:	e8 4b 1d 00 00       	call   38b2 <open>
    1b67:	89 04 24             	mov    %eax,(%esp)
    1b6a:	e8 2b 1d 00 00       	call   389a <close>
    1b6f:	83 c4 10             	add    $0x10,%esp
    1b72:	83 eb 01             	sub    $0x1,%ebx
    1b75:	75 c3                	jne    1b3a <linkunlink+0x6a>
    1b77:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b7a:	85 c0                	test   %eax,%eax
    1b7c:	74 4f                	je     1bcd <linkunlink+0xfd>
    1b7e:	e8 f7 1c 00 00       	call   387a <wait>
    1b83:	83 ec 08             	sub    $0x8,%esp
    1b86:	68 19 44 00 00       	push   $0x4419
    1b8b:	6a 01                	push   $0x1
    1b8d:	e8 2e 1e 00 00       	call   39c0 <printf>
    1b92:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b95:	5b                   	pop    %ebx
    1b96:	5e                   	pop    %esi
    1b97:	5f                   	pop    %edi
    1b98:	5d                   	pop    %ebp
    1b99:	c3                   	ret    
    1b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1ba0:	83 ec 08             	sub    $0x8,%esp
    1ba3:	68 91 46 00 00       	push   $0x4691
    1ba8:	68 15 44 00 00       	push   $0x4415
    1bad:	e8 20 1d 00 00       	call   38d2 <link>
    1bb2:	83 c4 10             	add    $0x10,%esp
    1bb5:	e9 7b ff ff ff       	jmp    1b35 <linkunlink+0x65>
    1bba:	52                   	push   %edx
    1bbb:	52                   	push   %edx
    1bbc:	68 79 4c 00 00       	push   $0x4c79
    1bc1:	6a 01                	push   $0x1
    1bc3:	e8 f8 1d 00 00       	call   39c0 <printf>
    1bc8:	e8 a5 1c 00 00       	call   3872 <exit>
    1bcd:	e8 a0 1c 00 00       	call   3872 <exit>
    1bd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001be0 <bigdir>:
    1be0:	55                   	push   %ebp
    1be1:	89 e5                	mov    %esp,%ebp
    1be3:	57                   	push   %edi
    1be4:	56                   	push   %esi
    1be5:	53                   	push   %ebx
    1be6:	83 ec 24             	sub    $0x24,%esp
    1be9:	68 28 44 00 00       	push   $0x4428
    1bee:	6a 01                	push   $0x1
    1bf0:	e8 cb 1d 00 00       	call   39c0 <printf>
    1bf5:	c7 04 24 35 44 00 00 	movl   $0x4435,(%esp)
    1bfc:	e8 c1 1c 00 00       	call   38c2 <unlink>
    1c01:	5a                   	pop    %edx
    1c02:	59                   	pop    %ecx
    1c03:	68 00 02 00 00       	push   $0x200
    1c08:	68 35 44 00 00       	push   $0x4435
    1c0d:	e8 a0 1c 00 00       	call   38b2 <open>
    1c12:	83 c4 10             	add    $0x10,%esp
    1c15:	85 c0                	test   %eax,%eax
    1c17:	0f 88 de 00 00 00    	js     1cfb <bigdir+0x11b>
    1c1d:	83 ec 0c             	sub    $0xc,%esp
    1c20:	8d 7d de             	lea    -0x22(%ebp),%edi
    1c23:	31 f6                	xor    %esi,%esi
    1c25:	50                   	push   %eax
    1c26:	e8 6f 1c 00 00       	call   389a <close>
    1c2b:	83 c4 10             	add    $0x10,%esp
    1c2e:	66 90                	xchg   %ax,%ax
    1c30:	89 f0                	mov    %esi,%eax
    1c32:	83 ec 08             	sub    $0x8,%esp
    1c35:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c39:	c1 f8 06             	sar    $0x6,%eax
    1c3c:	57                   	push   %edi
    1c3d:	68 35 44 00 00       	push   $0x4435
    1c42:	83 c0 30             	add    $0x30,%eax
    1c45:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c49:	88 45 df             	mov    %al,-0x21(%ebp)
    1c4c:	89 f0                	mov    %esi,%eax
    1c4e:	83 e0 3f             	and    $0x3f,%eax
    1c51:	83 c0 30             	add    $0x30,%eax
    1c54:	88 45 e0             	mov    %al,-0x20(%ebp)
    1c57:	e8 76 1c 00 00       	call   38d2 <link>
    1c5c:	83 c4 10             	add    $0x10,%esp
    1c5f:	85 c0                	test   %eax,%eax
    1c61:	89 c3                	mov    %eax,%ebx
    1c63:	75 6e                	jne    1cd3 <bigdir+0xf3>
    1c65:	83 c6 01             	add    $0x1,%esi
    1c68:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c6e:	75 c0                	jne    1c30 <bigdir+0x50>
    1c70:	83 ec 0c             	sub    $0xc,%esp
    1c73:	68 35 44 00 00       	push   $0x4435
    1c78:	e8 45 1c 00 00       	call   38c2 <unlink>
    1c7d:	83 c4 10             	add    $0x10,%esp
    1c80:	89 d8                	mov    %ebx,%eax
    1c82:	83 ec 0c             	sub    $0xc,%esp
    1c85:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c89:	c1 f8 06             	sar    $0x6,%eax
    1c8c:	57                   	push   %edi
    1c8d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c91:	83 c0 30             	add    $0x30,%eax
    1c94:	88 45 df             	mov    %al,-0x21(%ebp)
    1c97:	89 d8                	mov    %ebx,%eax
    1c99:	83 e0 3f             	and    $0x3f,%eax
    1c9c:	83 c0 30             	add    $0x30,%eax
    1c9f:	88 45 e0             	mov    %al,-0x20(%ebp)
    1ca2:	e8 1b 1c 00 00       	call   38c2 <unlink>
    1ca7:	83 c4 10             	add    $0x10,%esp
    1caa:	85 c0                	test   %eax,%eax
    1cac:	75 39                	jne    1ce7 <bigdir+0x107>
    1cae:	83 c3 01             	add    $0x1,%ebx
    1cb1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cb7:	75 c7                	jne    1c80 <bigdir+0xa0>
    1cb9:	83 ec 08             	sub    $0x8,%esp
    1cbc:	68 77 44 00 00       	push   $0x4477
    1cc1:	6a 01                	push   $0x1
    1cc3:	e8 f8 1c 00 00       	call   39c0 <printf>
    1cc8:	83 c4 10             	add    $0x10,%esp
    1ccb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cce:	5b                   	pop    %ebx
    1ccf:	5e                   	pop    %esi
    1cd0:	5f                   	pop    %edi
    1cd1:	5d                   	pop    %ebp
    1cd2:	c3                   	ret    
    1cd3:	83 ec 08             	sub    $0x8,%esp
    1cd6:	68 4e 44 00 00       	push   $0x444e
    1cdb:	6a 01                	push   $0x1
    1cdd:	e8 de 1c 00 00       	call   39c0 <printf>
    1ce2:	e8 8b 1b 00 00       	call   3872 <exit>
    1ce7:	83 ec 08             	sub    $0x8,%esp
    1cea:	68 62 44 00 00       	push   $0x4462
    1cef:	6a 01                	push   $0x1
    1cf1:	e8 ca 1c 00 00       	call   39c0 <printf>
    1cf6:	e8 77 1b 00 00       	call   3872 <exit>
    1cfb:	50                   	push   %eax
    1cfc:	50                   	push   %eax
    1cfd:	68 38 44 00 00       	push   $0x4438
    1d02:	6a 01                	push   $0x1
    1d04:	e8 b7 1c 00 00       	call   39c0 <printf>
    1d09:	e8 64 1b 00 00       	call   3872 <exit>
    1d0e:	66 90                	xchg   %ax,%ax

00001d10 <subdir>:
    1d10:	55                   	push   %ebp
    1d11:	89 e5                	mov    %esp,%ebp
    1d13:	53                   	push   %ebx
    1d14:	83 ec 0c             	sub    $0xc,%esp
    1d17:	68 82 44 00 00       	push   $0x4482
    1d1c:	6a 01                	push   $0x1
    1d1e:	e8 9d 1c 00 00       	call   39c0 <printf>
    1d23:	c7 04 24 0b 45 00 00 	movl   $0x450b,(%esp)
    1d2a:	e8 93 1b 00 00       	call   38c2 <unlink>
    1d2f:	c7 04 24 a8 45 00 00 	movl   $0x45a8,(%esp)
    1d36:	e8 9f 1b 00 00       	call   38da <mkdir>
    1d3b:	83 c4 10             	add    $0x10,%esp
    1d3e:	85 c0                	test   %eax,%eax
    1d40:	0f 85 b3 05 00 00    	jne    22f9 <subdir+0x5e9>
    1d46:	83 ec 08             	sub    $0x8,%esp
    1d49:	68 02 02 00 00       	push   $0x202
    1d4e:	68 e1 44 00 00       	push   $0x44e1
    1d53:	e8 5a 1b 00 00       	call   38b2 <open>
    1d58:	83 c4 10             	add    $0x10,%esp
    1d5b:	85 c0                	test   %eax,%eax
    1d5d:	89 c3                	mov    %eax,%ebx
    1d5f:	0f 88 81 05 00 00    	js     22e6 <subdir+0x5d6>
    1d65:	83 ec 04             	sub    $0x4,%esp
    1d68:	6a 02                	push   $0x2
    1d6a:	68 0b 45 00 00       	push   $0x450b
    1d6f:	50                   	push   %eax
    1d70:	e8 1d 1b 00 00       	call   3892 <write>
    1d75:	89 1c 24             	mov    %ebx,(%esp)
    1d78:	e8 1d 1b 00 00       	call   389a <close>
    1d7d:	c7 04 24 a8 45 00 00 	movl   $0x45a8,(%esp)
    1d84:	e8 39 1b 00 00       	call   38c2 <unlink>
    1d89:	83 c4 10             	add    $0x10,%esp
    1d8c:	85 c0                	test   %eax,%eax
    1d8e:	0f 89 3f 05 00 00    	jns    22d3 <subdir+0x5c3>
    1d94:	83 ec 0c             	sub    $0xc,%esp
    1d97:	68 bc 44 00 00       	push   $0x44bc
    1d9c:	e8 39 1b 00 00       	call   38da <mkdir>
    1da1:	83 c4 10             	add    $0x10,%esp
    1da4:	85 c0                	test   %eax,%eax
    1da6:	0f 85 14 05 00 00    	jne    22c0 <subdir+0x5b0>
    1dac:	83 ec 08             	sub    $0x8,%esp
    1daf:	68 02 02 00 00       	push   $0x202
    1db4:	68 de 44 00 00       	push   $0x44de
    1db9:	e8 f4 1a 00 00       	call   38b2 <open>
    1dbe:	83 c4 10             	add    $0x10,%esp
    1dc1:	85 c0                	test   %eax,%eax
    1dc3:	89 c3                	mov    %eax,%ebx
    1dc5:	0f 88 24 04 00 00    	js     21ef <subdir+0x4df>
    1dcb:	83 ec 04             	sub    $0x4,%esp
    1dce:	6a 02                	push   $0x2
    1dd0:	68 ff 44 00 00       	push   $0x44ff
    1dd5:	50                   	push   %eax
    1dd6:	e8 b7 1a 00 00       	call   3892 <write>
    1ddb:	89 1c 24             	mov    %ebx,(%esp)
    1dde:	e8 b7 1a 00 00       	call   389a <close>
    1de3:	58                   	pop    %eax
    1de4:	5a                   	pop    %edx
    1de5:	6a 00                	push   $0x0
    1de7:	68 02 45 00 00       	push   $0x4502
    1dec:	e8 c1 1a 00 00       	call   38b2 <open>
    1df1:	83 c4 10             	add    $0x10,%esp
    1df4:	85 c0                	test   %eax,%eax
    1df6:	89 c3                	mov    %eax,%ebx
    1df8:	0f 88 de 03 00 00    	js     21dc <subdir+0x4cc>
    1dfe:	83 ec 04             	sub    $0x4,%esp
    1e01:	68 00 20 00 00       	push   $0x2000
    1e06:	68 c0 85 00 00       	push   $0x85c0
    1e0b:	50                   	push   %eax
    1e0c:	e8 79 1a 00 00       	call   388a <read>
    1e11:	83 c4 10             	add    $0x10,%esp
    1e14:	83 f8 02             	cmp    $0x2,%eax
    1e17:	0f 85 3a 03 00 00    	jne    2157 <subdir+0x447>
    1e1d:	80 3d c0 85 00 00 66 	cmpb   $0x66,0x85c0
    1e24:	0f 85 2d 03 00 00    	jne    2157 <subdir+0x447>
    1e2a:	83 ec 0c             	sub    $0xc,%esp
    1e2d:	53                   	push   %ebx
    1e2e:	e8 67 1a 00 00       	call   389a <close>
    1e33:	5b                   	pop    %ebx
    1e34:	58                   	pop    %eax
    1e35:	68 42 45 00 00       	push   $0x4542
    1e3a:	68 de 44 00 00       	push   $0x44de
    1e3f:	e8 8e 1a 00 00       	call   38d2 <link>
    1e44:	83 c4 10             	add    $0x10,%esp
    1e47:	85 c0                	test   %eax,%eax
    1e49:	0f 85 c6 03 00 00    	jne    2215 <subdir+0x505>
    1e4f:	83 ec 0c             	sub    $0xc,%esp
    1e52:	68 de 44 00 00       	push   $0x44de
    1e57:	e8 66 1a 00 00       	call   38c2 <unlink>
    1e5c:	83 c4 10             	add    $0x10,%esp
    1e5f:	85 c0                	test   %eax,%eax
    1e61:	0f 85 16 03 00 00    	jne    217d <subdir+0x46d>
    1e67:	83 ec 08             	sub    $0x8,%esp
    1e6a:	6a 00                	push   $0x0
    1e6c:	68 de 44 00 00       	push   $0x44de
    1e71:	e8 3c 1a 00 00       	call   38b2 <open>
    1e76:	83 c4 10             	add    $0x10,%esp
    1e79:	85 c0                	test   %eax,%eax
    1e7b:	0f 89 2c 04 00 00    	jns    22ad <subdir+0x59d>
    1e81:	83 ec 0c             	sub    $0xc,%esp
    1e84:	68 a8 45 00 00       	push   $0x45a8
    1e89:	e8 54 1a 00 00       	call   38e2 <chdir>
    1e8e:	83 c4 10             	add    $0x10,%esp
    1e91:	85 c0                	test   %eax,%eax
    1e93:	0f 85 01 04 00 00    	jne    229a <subdir+0x58a>
    1e99:	83 ec 0c             	sub    $0xc,%esp
    1e9c:	68 76 45 00 00       	push   $0x4576
    1ea1:	e8 3c 1a 00 00       	call   38e2 <chdir>
    1ea6:	83 c4 10             	add    $0x10,%esp
    1ea9:	85 c0                	test   %eax,%eax
    1eab:	0f 85 b9 02 00 00    	jne    216a <subdir+0x45a>
    1eb1:	83 ec 0c             	sub    $0xc,%esp
    1eb4:	68 9c 45 00 00       	push   $0x459c
    1eb9:	e8 24 1a 00 00       	call   38e2 <chdir>
    1ebe:	83 c4 10             	add    $0x10,%esp
    1ec1:	85 c0                	test   %eax,%eax
    1ec3:	0f 85 a1 02 00 00    	jne    216a <subdir+0x45a>
    1ec9:	83 ec 0c             	sub    $0xc,%esp
    1ecc:	68 ab 45 00 00       	push   $0x45ab
    1ed1:	e8 0c 1a 00 00       	call   38e2 <chdir>
    1ed6:	83 c4 10             	add    $0x10,%esp
    1ed9:	85 c0                	test   %eax,%eax
    1edb:	0f 85 21 03 00 00    	jne    2202 <subdir+0x4f2>
    1ee1:	83 ec 08             	sub    $0x8,%esp
    1ee4:	6a 00                	push   $0x0
    1ee6:	68 42 45 00 00       	push   $0x4542
    1eeb:	e8 c2 19 00 00       	call   38b2 <open>
    1ef0:	83 c4 10             	add    $0x10,%esp
    1ef3:	85 c0                	test   %eax,%eax
    1ef5:	89 c3                	mov    %eax,%ebx
    1ef7:	0f 88 e0 04 00 00    	js     23dd <subdir+0x6cd>
    1efd:	83 ec 04             	sub    $0x4,%esp
    1f00:	68 00 20 00 00       	push   $0x2000
    1f05:	68 c0 85 00 00       	push   $0x85c0
    1f0a:	50                   	push   %eax
    1f0b:	e8 7a 19 00 00       	call   388a <read>
    1f10:	83 c4 10             	add    $0x10,%esp
    1f13:	83 f8 02             	cmp    $0x2,%eax
    1f16:	0f 85 ae 04 00 00    	jne    23ca <subdir+0x6ba>
    1f1c:	83 ec 0c             	sub    $0xc,%esp
    1f1f:	53                   	push   %ebx
    1f20:	e8 75 19 00 00       	call   389a <close>
    1f25:	59                   	pop    %ecx
    1f26:	5b                   	pop    %ebx
    1f27:	6a 00                	push   $0x0
    1f29:	68 de 44 00 00       	push   $0x44de
    1f2e:	e8 7f 19 00 00       	call   38b2 <open>
    1f33:	83 c4 10             	add    $0x10,%esp
    1f36:	85 c0                	test   %eax,%eax
    1f38:	0f 89 65 02 00 00    	jns    21a3 <subdir+0x493>
    1f3e:	83 ec 08             	sub    $0x8,%esp
    1f41:	68 02 02 00 00       	push   $0x202
    1f46:	68 f6 45 00 00       	push   $0x45f6
    1f4b:	e8 62 19 00 00       	call   38b2 <open>
    1f50:	83 c4 10             	add    $0x10,%esp
    1f53:	85 c0                	test   %eax,%eax
    1f55:	0f 89 35 02 00 00    	jns    2190 <subdir+0x480>
    1f5b:	83 ec 08             	sub    $0x8,%esp
    1f5e:	68 02 02 00 00       	push   $0x202
    1f63:	68 1b 46 00 00       	push   $0x461b
    1f68:	e8 45 19 00 00       	call   38b2 <open>
    1f6d:	83 c4 10             	add    $0x10,%esp
    1f70:	85 c0                	test   %eax,%eax
    1f72:	0f 89 0f 03 00 00    	jns    2287 <subdir+0x577>
    1f78:	83 ec 08             	sub    $0x8,%esp
    1f7b:	68 00 02 00 00       	push   $0x200
    1f80:	68 a8 45 00 00       	push   $0x45a8
    1f85:	e8 28 19 00 00       	call   38b2 <open>
    1f8a:	83 c4 10             	add    $0x10,%esp
    1f8d:	85 c0                	test   %eax,%eax
    1f8f:	0f 89 df 02 00 00    	jns    2274 <subdir+0x564>
    1f95:	83 ec 08             	sub    $0x8,%esp
    1f98:	6a 02                	push   $0x2
    1f9a:	68 a8 45 00 00       	push   $0x45a8
    1f9f:	e8 0e 19 00 00       	call   38b2 <open>
    1fa4:	83 c4 10             	add    $0x10,%esp
    1fa7:	85 c0                	test   %eax,%eax
    1fa9:	0f 89 b2 02 00 00    	jns    2261 <subdir+0x551>
    1faf:	83 ec 08             	sub    $0x8,%esp
    1fb2:	6a 01                	push   $0x1
    1fb4:	68 a8 45 00 00       	push   $0x45a8
    1fb9:	e8 f4 18 00 00       	call   38b2 <open>
    1fbe:	83 c4 10             	add    $0x10,%esp
    1fc1:	85 c0                	test   %eax,%eax
    1fc3:	0f 89 85 02 00 00    	jns    224e <subdir+0x53e>
    1fc9:	83 ec 08             	sub    $0x8,%esp
    1fcc:	68 8a 46 00 00       	push   $0x468a
    1fd1:	68 f6 45 00 00       	push   $0x45f6
    1fd6:	e8 f7 18 00 00       	call   38d2 <link>
    1fdb:	83 c4 10             	add    $0x10,%esp
    1fde:	85 c0                	test   %eax,%eax
    1fe0:	0f 84 55 02 00 00    	je     223b <subdir+0x52b>
    1fe6:	83 ec 08             	sub    $0x8,%esp
    1fe9:	68 8a 46 00 00       	push   $0x468a
    1fee:	68 1b 46 00 00       	push   $0x461b
    1ff3:	e8 da 18 00 00       	call   38d2 <link>
    1ff8:	83 c4 10             	add    $0x10,%esp
    1ffb:	85 c0                	test   %eax,%eax
    1ffd:	0f 84 25 02 00 00    	je     2228 <subdir+0x518>
    2003:	83 ec 08             	sub    $0x8,%esp
    2006:	68 42 45 00 00       	push   $0x4542
    200b:	68 e1 44 00 00       	push   $0x44e1
    2010:	e8 bd 18 00 00       	call   38d2 <link>
    2015:	83 c4 10             	add    $0x10,%esp
    2018:	85 c0                	test   %eax,%eax
    201a:	0f 84 a9 01 00 00    	je     21c9 <subdir+0x4b9>
    2020:	83 ec 0c             	sub    $0xc,%esp
    2023:	68 f6 45 00 00       	push   $0x45f6
    2028:	e8 ad 18 00 00       	call   38da <mkdir>
    202d:	83 c4 10             	add    $0x10,%esp
    2030:	85 c0                	test   %eax,%eax
    2032:	0f 84 7e 01 00 00    	je     21b6 <subdir+0x4a6>
    2038:	83 ec 0c             	sub    $0xc,%esp
    203b:	68 1b 46 00 00       	push   $0x461b
    2040:	e8 95 18 00 00       	call   38da <mkdir>
    2045:	83 c4 10             	add    $0x10,%esp
    2048:	85 c0                	test   %eax,%eax
    204a:	0f 84 67 03 00 00    	je     23b7 <subdir+0x6a7>
    2050:	83 ec 0c             	sub    $0xc,%esp
    2053:	68 42 45 00 00       	push   $0x4542
    2058:	e8 7d 18 00 00       	call   38da <mkdir>
    205d:	83 c4 10             	add    $0x10,%esp
    2060:	85 c0                	test   %eax,%eax
    2062:	0f 84 3c 03 00 00    	je     23a4 <subdir+0x694>
    2068:	83 ec 0c             	sub    $0xc,%esp
    206b:	68 1b 46 00 00       	push   $0x461b
    2070:	e8 4d 18 00 00       	call   38c2 <unlink>
    2075:	83 c4 10             	add    $0x10,%esp
    2078:	85 c0                	test   %eax,%eax
    207a:	0f 84 11 03 00 00    	je     2391 <subdir+0x681>
    2080:	83 ec 0c             	sub    $0xc,%esp
    2083:	68 f6 45 00 00       	push   $0x45f6
    2088:	e8 35 18 00 00       	call   38c2 <unlink>
    208d:	83 c4 10             	add    $0x10,%esp
    2090:	85 c0                	test   %eax,%eax
    2092:	0f 84 e6 02 00 00    	je     237e <subdir+0x66e>
    2098:	83 ec 0c             	sub    $0xc,%esp
    209b:	68 e1 44 00 00       	push   $0x44e1
    20a0:	e8 3d 18 00 00       	call   38e2 <chdir>
    20a5:	83 c4 10             	add    $0x10,%esp
    20a8:	85 c0                	test   %eax,%eax
    20aa:	0f 84 bb 02 00 00    	je     236b <subdir+0x65b>
    20b0:	83 ec 0c             	sub    $0xc,%esp
    20b3:	68 8d 46 00 00       	push   $0x468d
    20b8:	e8 25 18 00 00       	call   38e2 <chdir>
    20bd:	83 c4 10             	add    $0x10,%esp
    20c0:	85 c0                	test   %eax,%eax
    20c2:	0f 84 90 02 00 00    	je     2358 <subdir+0x648>
    20c8:	83 ec 0c             	sub    $0xc,%esp
    20cb:	68 42 45 00 00       	push   $0x4542
    20d0:	e8 ed 17 00 00       	call   38c2 <unlink>
    20d5:	83 c4 10             	add    $0x10,%esp
    20d8:	85 c0                	test   %eax,%eax
    20da:	0f 85 9d 00 00 00    	jne    217d <subdir+0x46d>
    20e0:	83 ec 0c             	sub    $0xc,%esp
    20e3:	68 e1 44 00 00       	push   $0x44e1
    20e8:	e8 d5 17 00 00       	call   38c2 <unlink>
    20ed:	83 c4 10             	add    $0x10,%esp
    20f0:	85 c0                	test   %eax,%eax
    20f2:	0f 85 4d 02 00 00    	jne    2345 <subdir+0x635>
    20f8:	83 ec 0c             	sub    $0xc,%esp
    20fb:	68 a8 45 00 00       	push   $0x45a8
    2100:	e8 bd 17 00 00       	call   38c2 <unlink>
    2105:	83 c4 10             	add    $0x10,%esp
    2108:	85 c0                	test   %eax,%eax
    210a:	0f 84 22 02 00 00    	je     2332 <subdir+0x622>
    2110:	83 ec 0c             	sub    $0xc,%esp
    2113:	68 bd 44 00 00       	push   $0x44bd
    2118:	e8 a5 17 00 00       	call   38c2 <unlink>
    211d:	83 c4 10             	add    $0x10,%esp
    2120:	85 c0                	test   %eax,%eax
    2122:	0f 88 f7 01 00 00    	js     231f <subdir+0x60f>
    2128:	83 ec 0c             	sub    $0xc,%esp
    212b:	68 a8 45 00 00       	push   $0x45a8
    2130:	e8 8d 17 00 00       	call   38c2 <unlink>
    2135:	83 c4 10             	add    $0x10,%esp
    2138:	85 c0                	test   %eax,%eax
    213a:	0f 88 cc 01 00 00    	js     230c <subdir+0x5fc>
    2140:	83 ec 08             	sub    $0x8,%esp
    2143:	68 8a 47 00 00       	push   $0x478a
    2148:	6a 01                	push   $0x1
    214a:	e8 71 18 00 00       	call   39c0 <printf>
    214f:	83 c4 10             	add    $0x10,%esp
    2152:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2155:	c9                   	leave  
    2156:	c3                   	ret    
    2157:	50                   	push   %eax
    2158:	50                   	push   %eax
    2159:	68 27 45 00 00       	push   $0x4527
    215e:	6a 01                	push   $0x1
    2160:	e8 5b 18 00 00       	call   39c0 <printf>
    2165:	e8 08 17 00 00       	call   3872 <exit>
    216a:	50                   	push   %eax
    216b:	50                   	push   %eax
    216c:	68 82 45 00 00       	push   $0x4582
    2171:	6a 01                	push   $0x1
    2173:	e8 48 18 00 00       	call   39c0 <printf>
    2178:	e8 f5 16 00 00       	call   3872 <exit>
    217d:	52                   	push   %edx
    217e:	52                   	push   %edx
    217f:	68 4d 45 00 00       	push   $0x454d
    2184:	6a 01                	push   $0x1
    2186:	e8 35 18 00 00       	call   39c0 <printf>
    218b:	e8 e2 16 00 00       	call   3872 <exit>
    2190:	50                   	push   %eax
    2191:	50                   	push   %eax
    2192:	68 ff 45 00 00       	push   $0x45ff
    2197:	6a 01                	push   $0x1
    2199:	e8 22 18 00 00       	call   39c0 <printf>
    219e:	e8 cf 16 00 00       	call   3872 <exit>
    21a3:	52                   	push   %edx
    21a4:	52                   	push   %edx
    21a5:	68 e4 4f 00 00       	push   $0x4fe4
    21aa:	6a 01                	push   $0x1
    21ac:	e8 0f 18 00 00       	call   39c0 <printf>
    21b1:	e8 bc 16 00 00       	call   3872 <exit>
    21b6:	52                   	push   %edx
    21b7:	52                   	push   %edx
    21b8:	68 93 46 00 00       	push   $0x4693
    21bd:	6a 01                	push   $0x1
    21bf:	e8 fc 17 00 00       	call   39c0 <printf>
    21c4:	e8 a9 16 00 00       	call   3872 <exit>
    21c9:	51                   	push   %ecx
    21ca:	51                   	push   %ecx
    21cb:	68 54 50 00 00       	push   $0x5054
    21d0:	6a 01                	push   $0x1
    21d2:	e8 e9 17 00 00       	call   39c0 <printf>
    21d7:	e8 96 16 00 00       	call   3872 <exit>
    21dc:	50                   	push   %eax
    21dd:	50                   	push   %eax
    21de:	68 0e 45 00 00       	push   $0x450e
    21e3:	6a 01                	push   $0x1
    21e5:	e8 d6 17 00 00       	call   39c0 <printf>
    21ea:	e8 83 16 00 00       	call   3872 <exit>
    21ef:	51                   	push   %ecx
    21f0:	51                   	push   %ecx
    21f1:	68 e7 44 00 00       	push   $0x44e7
    21f6:	6a 01                	push   $0x1
    21f8:	e8 c3 17 00 00       	call   39c0 <printf>
    21fd:	e8 70 16 00 00       	call   3872 <exit>
    2202:	50                   	push   %eax
    2203:	50                   	push   %eax
    2204:	68 b0 45 00 00       	push   $0x45b0
    2209:	6a 01                	push   $0x1
    220b:	e8 b0 17 00 00       	call   39c0 <printf>
    2210:	e8 5d 16 00 00       	call   3872 <exit>
    2215:	51                   	push   %ecx
    2216:	51                   	push   %ecx
    2217:	68 9c 4f 00 00       	push   $0x4f9c
    221c:	6a 01                	push   $0x1
    221e:	e8 9d 17 00 00       	call   39c0 <printf>
    2223:	e8 4a 16 00 00       	call   3872 <exit>
    2228:	53                   	push   %ebx
    2229:	53                   	push   %ebx
    222a:	68 30 50 00 00       	push   $0x5030
    222f:	6a 01                	push   $0x1
    2231:	e8 8a 17 00 00       	call   39c0 <printf>
    2236:	e8 37 16 00 00       	call   3872 <exit>
    223b:	50                   	push   %eax
    223c:	50                   	push   %eax
    223d:	68 0c 50 00 00       	push   $0x500c
    2242:	6a 01                	push   $0x1
    2244:	e8 77 17 00 00       	call   39c0 <printf>
    2249:	e8 24 16 00 00       	call   3872 <exit>
    224e:	50                   	push   %eax
    224f:	50                   	push   %eax
    2250:	68 6f 46 00 00       	push   $0x466f
    2255:	6a 01                	push   $0x1
    2257:	e8 64 17 00 00       	call   39c0 <printf>
    225c:	e8 11 16 00 00       	call   3872 <exit>
    2261:	50                   	push   %eax
    2262:	50                   	push   %eax
    2263:	68 56 46 00 00       	push   $0x4656
    2268:	6a 01                	push   $0x1
    226a:	e8 51 17 00 00       	call   39c0 <printf>
    226f:	e8 fe 15 00 00       	call   3872 <exit>
    2274:	50                   	push   %eax
    2275:	50                   	push   %eax
    2276:	68 40 46 00 00       	push   $0x4640
    227b:	6a 01                	push   $0x1
    227d:	e8 3e 17 00 00       	call   39c0 <printf>
    2282:	e8 eb 15 00 00       	call   3872 <exit>
    2287:	50                   	push   %eax
    2288:	50                   	push   %eax
    2289:	68 24 46 00 00       	push   $0x4624
    228e:	6a 01                	push   $0x1
    2290:	e8 2b 17 00 00       	call   39c0 <printf>
    2295:	e8 d8 15 00 00       	call   3872 <exit>
    229a:	50                   	push   %eax
    229b:	50                   	push   %eax
    229c:	68 65 45 00 00       	push   $0x4565
    22a1:	6a 01                	push   $0x1
    22a3:	e8 18 17 00 00       	call   39c0 <printf>
    22a8:	e8 c5 15 00 00       	call   3872 <exit>
    22ad:	50                   	push   %eax
    22ae:	50                   	push   %eax
    22af:	68 c0 4f 00 00       	push   $0x4fc0
    22b4:	6a 01                	push   $0x1
    22b6:	e8 05 17 00 00       	call   39c0 <printf>
    22bb:	e8 b2 15 00 00       	call   3872 <exit>
    22c0:	53                   	push   %ebx
    22c1:	53                   	push   %ebx
    22c2:	68 c3 44 00 00       	push   $0x44c3
    22c7:	6a 01                	push   $0x1
    22c9:	e8 f2 16 00 00       	call   39c0 <printf>
    22ce:	e8 9f 15 00 00       	call   3872 <exit>
    22d3:	50                   	push   %eax
    22d4:	50                   	push   %eax
    22d5:	68 74 4f 00 00       	push   $0x4f74
    22da:	6a 01                	push   $0x1
    22dc:	e8 df 16 00 00       	call   39c0 <printf>
    22e1:	e8 8c 15 00 00       	call   3872 <exit>
    22e6:	50                   	push   %eax
    22e7:	50                   	push   %eax
    22e8:	68 a7 44 00 00       	push   $0x44a7
    22ed:	6a 01                	push   $0x1
    22ef:	e8 cc 16 00 00       	call   39c0 <printf>
    22f4:	e8 79 15 00 00       	call   3872 <exit>
    22f9:	50                   	push   %eax
    22fa:	50                   	push   %eax
    22fb:	68 8f 44 00 00       	push   $0x448f
    2300:	6a 01                	push   $0x1
    2302:	e8 b9 16 00 00       	call   39c0 <printf>
    2307:	e8 66 15 00 00       	call   3872 <exit>
    230c:	50                   	push   %eax
    230d:	50                   	push   %eax
    230e:	68 78 47 00 00       	push   $0x4778
    2313:	6a 01                	push   $0x1
    2315:	e8 a6 16 00 00       	call   39c0 <printf>
    231a:	e8 53 15 00 00       	call   3872 <exit>
    231f:	52                   	push   %edx
    2320:	52                   	push   %edx
    2321:	68 63 47 00 00       	push   $0x4763
    2326:	6a 01                	push   $0x1
    2328:	e8 93 16 00 00       	call   39c0 <printf>
    232d:	e8 40 15 00 00       	call   3872 <exit>
    2332:	51                   	push   %ecx
    2333:	51                   	push   %ecx
    2334:	68 78 50 00 00       	push   $0x5078
    2339:	6a 01                	push   $0x1
    233b:	e8 80 16 00 00       	call   39c0 <printf>
    2340:	e8 2d 15 00 00       	call   3872 <exit>
    2345:	53                   	push   %ebx
    2346:	53                   	push   %ebx
    2347:	68 4e 47 00 00       	push   $0x474e
    234c:	6a 01                	push   $0x1
    234e:	e8 6d 16 00 00       	call   39c0 <printf>
    2353:	e8 1a 15 00 00       	call   3872 <exit>
    2358:	50                   	push   %eax
    2359:	50                   	push   %eax
    235a:	68 36 47 00 00       	push   $0x4736
    235f:	6a 01                	push   $0x1
    2361:	e8 5a 16 00 00       	call   39c0 <printf>
    2366:	e8 07 15 00 00       	call   3872 <exit>
    236b:	50                   	push   %eax
    236c:	50                   	push   %eax
    236d:	68 1e 47 00 00       	push   $0x471e
    2372:	6a 01                	push   $0x1
    2374:	e8 47 16 00 00       	call   39c0 <printf>
    2379:	e8 f4 14 00 00       	call   3872 <exit>
    237e:	50                   	push   %eax
    237f:	50                   	push   %eax
    2380:	68 02 47 00 00       	push   $0x4702
    2385:	6a 01                	push   $0x1
    2387:	e8 34 16 00 00       	call   39c0 <printf>
    238c:	e8 e1 14 00 00       	call   3872 <exit>
    2391:	50                   	push   %eax
    2392:	50                   	push   %eax
    2393:	68 e6 46 00 00       	push   $0x46e6
    2398:	6a 01                	push   $0x1
    239a:	e8 21 16 00 00       	call   39c0 <printf>
    239f:	e8 ce 14 00 00       	call   3872 <exit>
    23a4:	50                   	push   %eax
    23a5:	50                   	push   %eax
    23a6:	68 c9 46 00 00       	push   $0x46c9
    23ab:	6a 01                	push   $0x1
    23ad:	e8 0e 16 00 00       	call   39c0 <printf>
    23b2:	e8 bb 14 00 00       	call   3872 <exit>
    23b7:	50                   	push   %eax
    23b8:	50                   	push   %eax
    23b9:	68 ae 46 00 00       	push   $0x46ae
    23be:	6a 01                	push   $0x1
    23c0:	e8 fb 15 00 00       	call   39c0 <printf>
    23c5:	e8 a8 14 00 00       	call   3872 <exit>
    23ca:	50                   	push   %eax
    23cb:	50                   	push   %eax
    23cc:	68 db 45 00 00       	push   $0x45db
    23d1:	6a 01                	push   $0x1
    23d3:	e8 e8 15 00 00       	call   39c0 <printf>
    23d8:	e8 95 14 00 00       	call   3872 <exit>
    23dd:	50                   	push   %eax
    23de:	50                   	push   %eax
    23df:	68 c3 45 00 00       	push   $0x45c3
    23e4:	6a 01                	push   $0x1
    23e6:	e8 d5 15 00 00       	call   39c0 <printf>
    23eb:	e8 82 14 00 00       	call   3872 <exit>

000023f0 <bigwrite>:
    23f0:	55                   	push   %ebp
    23f1:	89 e5                	mov    %esp,%ebp
    23f3:	56                   	push   %esi
    23f4:	53                   	push   %ebx
    23f5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    23fa:	83 ec 08             	sub    $0x8,%esp
    23fd:	68 95 47 00 00       	push   $0x4795
    2402:	6a 01                	push   $0x1
    2404:	e8 b7 15 00 00       	call   39c0 <printf>
    2409:	c7 04 24 a4 47 00 00 	movl   $0x47a4,(%esp)
    2410:	e8 ad 14 00 00       	call   38c2 <unlink>
    2415:	83 c4 10             	add    $0x10,%esp
    2418:	90                   	nop
    2419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2420:	83 ec 08             	sub    $0x8,%esp
    2423:	68 02 02 00 00       	push   $0x202
    2428:	68 a4 47 00 00       	push   $0x47a4
    242d:	e8 80 14 00 00       	call   38b2 <open>
    2432:	83 c4 10             	add    $0x10,%esp
    2435:	85 c0                	test   %eax,%eax
    2437:	89 c6                	mov    %eax,%esi
    2439:	78 7e                	js     24b9 <bigwrite+0xc9>
    243b:	83 ec 04             	sub    $0x4,%esp
    243e:	53                   	push   %ebx
    243f:	68 c0 85 00 00       	push   $0x85c0
    2444:	50                   	push   %eax
    2445:	e8 48 14 00 00       	call   3892 <write>
    244a:	83 c4 10             	add    $0x10,%esp
    244d:	39 d8                	cmp    %ebx,%eax
    244f:	75 55                	jne    24a6 <bigwrite+0xb6>
    2451:	83 ec 04             	sub    $0x4,%esp
    2454:	53                   	push   %ebx
    2455:	68 c0 85 00 00       	push   $0x85c0
    245a:	56                   	push   %esi
    245b:	e8 32 14 00 00       	call   3892 <write>
    2460:	83 c4 10             	add    $0x10,%esp
    2463:	39 d8                	cmp    %ebx,%eax
    2465:	75 3f                	jne    24a6 <bigwrite+0xb6>
    2467:	83 ec 0c             	sub    $0xc,%esp
    246a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    2470:	56                   	push   %esi
    2471:	e8 24 14 00 00       	call   389a <close>
    2476:	c7 04 24 a4 47 00 00 	movl   $0x47a4,(%esp)
    247d:	e8 40 14 00 00       	call   38c2 <unlink>
    2482:	83 c4 10             	add    $0x10,%esp
    2485:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    248b:	75 93                	jne    2420 <bigwrite+0x30>
    248d:	83 ec 08             	sub    $0x8,%esp
    2490:	68 d7 47 00 00       	push   $0x47d7
    2495:	6a 01                	push   $0x1
    2497:	e8 24 15 00 00       	call   39c0 <printf>
    249c:	83 c4 10             	add    $0x10,%esp
    249f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24a2:	5b                   	pop    %ebx
    24a3:	5e                   	pop    %esi
    24a4:	5d                   	pop    %ebp
    24a5:	c3                   	ret    
    24a6:	50                   	push   %eax
    24a7:	53                   	push   %ebx
    24a8:	68 c5 47 00 00       	push   $0x47c5
    24ad:	6a 01                	push   $0x1
    24af:	e8 0c 15 00 00       	call   39c0 <printf>
    24b4:	e8 b9 13 00 00       	call   3872 <exit>
    24b9:	83 ec 08             	sub    $0x8,%esp
    24bc:	68 ad 47 00 00       	push   $0x47ad
    24c1:	6a 01                	push   $0x1
    24c3:	e8 f8 14 00 00       	call   39c0 <printf>
    24c8:	e8 a5 13 00 00       	call   3872 <exit>
    24cd:	8d 76 00             	lea    0x0(%esi),%esi

000024d0 <bigfile>:
    24d0:	55                   	push   %ebp
    24d1:	89 e5                	mov    %esp,%ebp
    24d3:	57                   	push   %edi
    24d4:	56                   	push   %esi
    24d5:	53                   	push   %ebx
    24d6:	83 ec 14             	sub    $0x14,%esp
    24d9:	68 e4 47 00 00       	push   $0x47e4
    24de:	6a 01                	push   $0x1
    24e0:	e8 db 14 00 00       	call   39c0 <printf>
    24e5:	c7 04 24 00 48 00 00 	movl   $0x4800,(%esp)
    24ec:	e8 d1 13 00 00       	call   38c2 <unlink>
    24f1:	58                   	pop    %eax
    24f2:	5a                   	pop    %edx
    24f3:	68 02 02 00 00       	push   $0x202
    24f8:	68 00 48 00 00       	push   $0x4800
    24fd:	e8 b0 13 00 00       	call   38b2 <open>
    2502:	83 c4 10             	add    $0x10,%esp
    2505:	85 c0                	test   %eax,%eax
    2507:	0f 88 5e 01 00 00    	js     266b <bigfile+0x19b>
    250d:	89 c6                	mov    %eax,%esi
    250f:	31 db                	xor    %ebx,%ebx
    2511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2518:	83 ec 04             	sub    $0x4,%esp
    251b:	68 58 02 00 00       	push   $0x258
    2520:	53                   	push   %ebx
    2521:	68 c0 85 00 00       	push   $0x85c0
    2526:	e8 d5 11 00 00       	call   3700 <memset>
    252b:	83 c4 0c             	add    $0xc,%esp
    252e:	68 58 02 00 00       	push   $0x258
    2533:	68 c0 85 00 00       	push   $0x85c0
    2538:	56                   	push   %esi
    2539:	e8 54 13 00 00       	call   3892 <write>
    253e:	83 c4 10             	add    $0x10,%esp
    2541:	3d 58 02 00 00       	cmp    $0x258,%eax
    2546:	0f 85 f8 00 00 00    	jne    2644 <bigfile+0x174>
    254c:	83 c3 01             	add    $0x1,%ebx
    254f:	83 fb 14             	cmp    $0x14,%ebx
    2552:	75 c4                	jne    2518 <bigfile+0x48>
    2554:	83 ec 0c             	sub    $0xc,%esp
    2557:	56                   	push   %esi
    2558:	e8 3d 13 00 00       	call   389a <close>
    255d:	5e                   	pop    %esi
    255e:	5f                   	pop    %edi
    255f:	6a 00                	push   $0x0
    2561:	68 00 48 00 00       	push   $0x4800
    2566:	e8 47 13 00 00       	call   38b2 <open>
    256b:	83 c4 10             	add    $0x10,%esp
    256e:	85 c0                	test   %eax,%eax
    2570:	89 c6                	mov    %eax,%esi
    2572:	0f 88 e0 00 00 00    	js     2658 <bigfile+0x188>
    2578:	31 db                	xor    %ebx,%ebx
    257a:	31 ff                	xor    %edi,%edi
    257c:	eb 30                	jmp    25ae <bigfile+0xde>
    257e:	66 90                	xchg   %ax,%ax
    2580:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2585:	0f 85 91 00 00 00    	jne    261c <bigfile+0x14c>
    258b:	0f be 05 c0 85 00 00 	movsbl 0x85c0,%eax
    2592:	89 fa                	mov    %edi,%edx
    2594:	d1 fa                	sar    %edx
    2596:	39 d0                	cmp    %edx,%eax
    2598:	75 6e                	jne    2608 <bigfile+0x138>
    259a:	0f be 15 eb 86 00 00 	movsbl 0x86eb,%edx
    25a1:	39 d0                	cmp    %edx,%eax
    25a3:	75 63                	jne    2608 <bigfile+0x138>
    25a5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
    25ab:	83 c7 01             	add    $0x1,%edi
    25ae:	83 ec 04             	sub    $0x4,%esp
    25b1:	68 2c 01 00 00       	push   $0x12c
    25b6:	68 c0 85 00 00       	push   $0x85c0
    25bb:	56                   	push   %esi
    25bc:	e8 c9 12 00 00       	call   388a <read>
    25c1:	83 c4 10             	add    $0x10,%esp
    25c4:	85 c0                	test   %eax,%eax
    25c6:	78 68                	js     2630 <bigfile+0x160>
    25c8:	75 b6                	jne    2580 <bigfile+0xb0>
    25ca:	83 ec 0c             	sub    $0xc,%esp
    25cd:	56                   	push   %esi
    25ce:	e8 c7 12 00 00       	call   389a <close>
    25d3:	83 c4 10             	add    $0x10,%esp
    25d6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25dc:	0f 85 9c 00 00 00    	jne    267e <bigfile+0x1ae>
    25e2:	83 ec 0c             	sub    $0xc,%esp
    25e5:	68 00 48 00 00       	push   $0x4800
    25ea:	e8 d3 12 00 00       	call   38c2 <unlink>
    25ef:	58                   	pop    %eax
    25f0:	5a                   	pop    %edx
    25f1:	68 8f 48 00 00       	push   $0x488f
    25f6:	6a 01                	push   $0x1
    25f8:	e8 c3 13 00 00       	call   39c0 <printf>
    25fd:	83 c4 10             	add    $0x10,%esp
    2600:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2603:	5b                   	pop    %ebx
    2604:	5e                   	pop    %esi
    2605:	5f                   	pop    %edi
    2606:	5d                   	pop    %ebp
    2607:	c3                   	ret    
    2608:	83 ec 08             	sub    $0x8,%esp
    260b:	68 5c 48 00 00       	push   $0x485c
    2610:	6a 01                	push   $0x1
    2612:	e8 a9 13 00 00       	call   39c0 <printf>
    2617:	e8 56 12 00 00       	call   3872 <exit>
    261c:	83 ec 08             	sub    $0x8,%esp
    261f:	68 48 48 00 00       	push   $0x4848
    2624:	6a 01                	push   $0x1
    2626:	e8 95 13 00 00       	call   39c0 <printf>
    262b:	e8 42 12 00 00       	call   3872 <exit>
    2630:	83 ec 08             	sub    $0x8,%esp
    2633:	68 33 48 00 00       	push   $0x4833
    2638:	6a 01                	push   $0x1
    263a:	e8 81 13 00 00       	call   39c0 <printf>
    263f:	e8 2e 12 00 00       	call   3872 <exit>
    2644:	83 ec 08             	sub    $0x8,%esp
    2647:	68 08 48 00 00       	push   $0x4808
    264c:	6a 01                	push   $0x1
    264e:	e8 6d 13 00 00       	call   39c0 <printf>
    2653:	e8 1a 12 00 00       	call   3872 <exit>
    2658:	53                   	push   %ebx
    2659:	53                   	push   %ebx
    265a:	68 1e 48 00 00       	push   $0x481e
    265f:	6a 01                	push   $0x1
    2661:	e8 5a 13 00 00       	call   39c0 <printf>
    2666:	e8 07 12 00 00       	call   3872 <exit>
    266b:	50                   	push   %eax
    266c:	50                   	push   %eax
    266d:	68 f2 47 00 00       	push   $0x47f2
    2672:	6a 01                	push   $0x1
    2674:	e8 47 13 00 00       	call   39c0 <printf>
    2679:	e8 f4 11 00 00       	call   3872 <exit>
    267e:	51                   	push   %ecx
    267f:	51                   	push   %ecx
    2680:	68 75 48 00 00       	push   $0x4875
    2685:	6a 01                	push   $0x1
    2687:	e8 34 13 00 00       	call   39c0 <printf>
    268c:	e8 e1 11 00 00       	call   3872 <exit>
    2691:	eb 0d                	jmp    26a0 <fourteen>
    2693:	90                   	nop
    2694:	90                   	nop
    2695:	90                   	nop
    2696:	90                   	nop
    2697:	90                   	nop
    2698:	90                   	nop
    2699:	90                   	nop
    269a:	90                   	nop
    269b:	90                   	nop
    269c:	90                   	nop
    269d:	90                   	nop
    269e:	90                   	nop
    269f:	90                   	nop

000026a0 <fourteen>:
    26a0:	55                   	push   %ebp
    26a1:	89 e5                	mov    %esp,%ebp
    26a3:	83 ec 10             	sub    $0x10,%esp
    26a6:	68 a0 48 00 00       	push   $0x48a0
    26ab:	6a 01                	push   $0x1
    26ad:	e8 0e 13 00 00       	call   39c0 <printf>
    26b2:	c7 04 24 db 48 00 00 	movl   $0x48db,(%esp)
    26b9:	e8 1c 12 00 00       	call   38da <mkdir>
    26be:	83 c4 10             	add    $0x10,%esp
    26c1:	85 c0                	test   %eax,%eax
    26c3:	0f 85 97 00 00 00    	jne    2760 <fourteen+0xc0>
    26c9:	83 ec 0c             	sub    $0xc,%esp
    26cc:	68 98 50 00 00       	push   $0x5098
    26d1:	e8 04 12 00 00       	call   38da <mkdir>
    26d6:	83 c4 10             	add    $0x10,%esp
    26d9:	85 c0                	test   %eax,%eax
    26db:	0f 85 de 00 00 00    	jne    27bf <fourteen+0x11f>
    26e1:	83 ec 08             	sub    $0x8,%esp
    26e4:	68 00 02 00 00       	push   $0x200
    26e9:	68 e8 50 00 00       	push   $0x50e8
    26ee:	e8 bf 11 00 00       	call   38b2 <open>
    26f3:	83 c4 10             	add    $0x10,%esp
    26f6:	85 c0                	test   %eax,%eax
    26f8:	0f 88 ae 00 00 00    	js     27ac <fourteen+0x10c>
    26fe:	83 ec 0c             	sub    $0xc,%esp
    2701:	50                   	push   %eax
    2702:	e8 93 11 00 00       	call   389a <close>
    2707:	58                   	pop    %eax
    2708:	5a                   	pop    %edx
    2709:	6a 00                	push   $0x0
    270b:	68 58 51 00 00       	push   $0x5158
    2710:	e8 9d 11 00 00       	call   38b2 <open>
    2715:	83 c4 10             	add    $0x10,%esp
    2718:	85 c0                	test   %eax,%eax
    271a:	78 7d                	js     2799 <fourteen+0xf9>
    271c:	83 ec 0c             	sub    $0xc,%esp
    271f:	50                   	push   %eax
    2720:	e8 75 11 00 00       	call   389a <close>
    2725:	c7 04 24 cc 48 00 00 	movl   $0x48cc,(%esp)
    272c:	e8 a9 11 00 00       	call   38da <mkdir>
    2731:	83 c4 10             	add    $0x10,%esp
    2734:	85 c0                	test   %eax,%eax
    2736:	74 4e                	je     2786 <fourteen+0xe6>
    2738:	83 ec 0c             	sub    $0xc,%esp
    273b:	68 f4 51 00 00       	push   $0x51f4
    2740:	e8 95 11 00 00       	call   38da <mkdir>
    2745:	83 c4 10             	add    $0x10,%esp
    2748:	85 c0                	test   %eax,%eax
    274a:	74 27                	je     2773 <fourteen+0xd3>
    274c:	83 ec 08             	sub    $0x8,%esp
    274f:	68 ea 48 00 00       	push   $0x48ea
    2754:	6a 01                	push   $0x1
    2756:	e8 65 12 00 00       	call   39c0 <printf>
    275b:	83 c4 10             	add    $0x10,%esp
    275e:	c9                   	leave  
    275f:	c3                   	ret    
    2760:	50                   	push   %eax
    2761:	50                   	push   %eax
    2762:	68 af 48 00 00       	push   $0x48af
    2767:	6a 01                	push   $0x1
    2769:	e8 52 12 00 00       	call   39c0 <printf>
    276e:	e8 ff 10 00 00       	call   3872 <exit>
    2773:	50                   	push   %eax
    2774:	50                   	push   %eax
    2775:	68 14 52 00 00       	push   $0x5214
    277a:	6a 01                	push   $0x1
    277c:	e8 3f 12 00 00       	call   39c0 <printf>
    2781:	e8 ec 10 00 00       	call   3872 <exit>
    2786:	52                   	push   %edx
    2787:	52                   	push   %edx
    2788:	68 c4 51 00 00       	push   $0x51c4
    278d:	6a 01                	push   $0x1
    278f:	e8 2c 12 00 00       	call   39c0 <printf>
    2794:	e8 d9 10 00 00       	call   3872 <exit>
    2799:	51                   	push   %ecx
    279a:	51                   	push   %ecx
    279b:	68 88 51 00 00       	push   $0x5188
    27a0:	6a 01                	push   $0x1
    27a2:	e8 19 12 00 00       	call   39c0 <printf>
    27a7:	e8 c6 10 00 00       	call   3872 <exit>
    27ac:	51                   	push   %ecx
    27ad:	51                   	push   %ecx
    27ae:	68 18 51 00 00       	push   $0x5118
    27b3:	6a 01                	push   $0x1
    27b5:	e8 06 12 00 00       	call   39c0 <printf>
    27ba:	e8 b3 10 00 00       	call   3872 <exit>
    27bf:	50                   	push   %eax
    27c0:	50                   	push   %eax
    27c1:	68 b8 50 00 00       	push   $0x50b8
    27c6:	6a 01                	push   $0x1
    27c8:	e8 f3 11 00 00       	call   39c0 <printf>
    27cd:	e8 a0 10 00 00       	call   3872 <exit>
    27d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027e0 <rmdot>:
    27e0:	55                   	push   %ebp
    27e1:	89 e5                	mov    %esp,%ebp
    27e3:	83 ec 10             	sub    $0x10,%esp
    27e6:	68 f7 48 00 00       	push   $0x48f7
    27eb:	6a 01                	push   $0x1
    27ed:	e8 ce 11 00 00       	call   39c0 <printf>
    27f2:	c7 04 24 03 49 00 00 	movl   $0x4903,(%esp)
    27f9:	e8 dc 10 00 00       	call   38da <mkdir>
    27fe:	83 c4 10             	add    $0x10,%esp
    2801:	85 c0                	test   %eax,%eax
    2803:	0f 85 b0 00 00 00    	jne    28b9 <rmdot+0xd9>
    2809:	83 ec 0c             	sub    $0xc,%esp
    280c:	68 03 49 00 00       	push   $0x4903
    2811:	e8 cc 10 00 00       	call   38e2 <chdir>
    2816:	83 c4 10             	add    $0x10,%esp
    2819:	85 c0                	test   %eax,%eax
    281b:	0f 85 1d 01 00 00    	jne    293e <rmdot+0x15e>
    2821:	83 ec 0c             	sub    $0xc,%esp
    2824:	68 ae 45 00 00       	push   $0x45ae
    2829:	e8 94 10 00 00       	call   38c2 <unlink>
    282e:	83 c4 10             	add    $0x10,%esp
    2831:	85 c0                	test   %eax,%eax
    2833:	0f 84 f2 00 00 00    	je     292b <rmdot+0x14b>
    2839:	83 ec 0c             	sub    $0xc,%esp
    283c:	68 ad 45 00 00       	push   $0x45ad
    2841:	e8 7c 10 00 00       	call   38c2 <unlink>
    2846:	83 c4 10             	add    $0x10,%esp
    2849:	85 c0                	test   %eax,%eax
    284b:	0f 84 c7 00 00 00    	je     2918 <rmdot+0x138>
    2851:	83 ec 0c             	sub    $0xc,%esp
    2854:	68 81 3d 00 00       	push   $0x3d81
    2859:	e8 84 10 00 00       	call   38e2 <chdir>
    285e:	83 c4 10             	add    $0x10,%esp
    2861:	85 c0                	test   %eax,%eax
    2863:	0f 85 9c 00 00 00    	jne    2905 <rmdot+0x125>
    2869:	83 ec 0c             	sub    $0xc,%esp
    286c:	68 4b 49 00 00       	push   $0x494b
    2871:	e8 4c 10 00 00       	call   38c2 <unlink>
    2876:	83 c4 10             	add    $0x10,%esp
    2879:	85 c0                	test   %eax,%eax
    287b:	74 75                	je     28f2 <rmdot+0x112>
    287d:	83 ec 0c             	sub    $0xc,%esp
    2880:	68 69 49 00 00       	push   $0x4969
    2885:	e8 38 10 00 00       	call   38c2 <unlink>
    288a:	83 c4 10             	add    $0x10,%esp
    288d:	85 c0                	test   %eax,%eax
    288f:	74 4e                	je     28df <rmdot+0xff>
    2891:	83 ec 0c             	sub    $0xc,%esp
    2894:	68 03 49 00 00       	push   $0x4903
    2899:	e8 24 10 00 00       	call   38c2 <unlink>
    289e:	83 c4 10             	add    $0x10,%esp
    28a1:	85 c0                	test   %eax,%eax
    28a3:	75 27                	jne    28cc <rmdot+0xec>
    28a5:	83 ec 08             	sub    $0x8,%esp
    28a8:	68 9e 49 00 00       	push   $0x499e
    28ad:	6a 01                	push   $0x1
    28af:	e8 0c 11 00 00       	call   39c0 <printf>
    28b4:	83 c4 10             	add    $0x10,%esp
    28b7:	c9                   	leave  
    28b8:	c3                   	ret    
    28b9:	50                   	push   %eax
    28ba:	50                   	push   %eax
    28bb:	68 08 49 00 00       	push   $0x4908
    28c0:	6a 01                	push   $0x1
    28c2:	e8 f9 10 00 00       	call   39c0 <printf>
    28c7:	e8 a6 0f 00 00       	call   3872 <exit>
    28cc:	50                   	push   %eax
    28cd:	50                   	push   %eax
    28ce:	68 89 49 00 00       	push   $0x4989
    28d3:	6a 01                	push   $0x1
    28d5:	e8 e6 10 00 00       	call   39c0 <printf>
    28da:	e8 93 0f 00 00       	call   3872 <exit>
    28df:	52                   	push   %edx
    28e0:	52                   	push   %edx
    28e1:	68 71 49 00 00       	push   $0x4971
    28e6:	6a 01                	push   $0x1
    28e8:	e8 d3 10 00 00       	call   39c0 <printf>
    28ed:	e8 80 0f 00 00       	call   3872 <exit>
    28f2:	51                   	push   %ecx
    28f3:	51                   	push   %ecx
    28f4:	68 52 49 00 00       	push   $0x4952
    28f9:	6a 01                	push   $0x1
    28fb:	e8 c0 10 00 00       	call   39c0 <printf>
    2900:	e8 6d 0f 00 00       	call   3872 <exit>
    2905:	50                   	push   %eax
    2906:	50                   	push   %eax
    2907:	68 83 3d 00 00       	push   $0x3d83
    290c:	6a 01                	push   $0x1
    290e:	e8 ad 10 00 00       	call   39c0 <printf>
    2913:	e8 5a 0f 00 00       	call   3872 <exit>
    2918:	50                   	push   %eax
    2919:	50                   	push   %eax
    291a:	68 3c 49 00 00       	push   $0x493c
    291f:	6a 01                	push   $0x1
    2921:	e8 9a 10 00 00       	call   39c0 <printf>
    2926:	e8 47 0f 00 00       	call   3872 <exit>
    292b:	50                   	push   %eax
    292c:	50                   	push   %eax
    292d:	68 2e 49 00 00       	push   $0x492e
    2932:	6a 01                	push   $0x1
    2934:	e8 87 10 00 00       	call   39c0 <printf>
    2939:	e8 34 0f 00 00       	call   3872 <exit>
    293e:	50                   	push   %eax
    293f:	50                   	push   %eax
    2940:	68 1b 49 00 00       	push   $0x491b
    2945:	6a 01                	push   $0x1
    2947:	e8 74 10 00 00       	call   39c0 <printf>
    294c:	e8 21 0f 00 00       	call   3872 <exit>
    2951:	eb 0d                	jmp    2960 <dirfile>
    2953:	90                   	nop
    2954:	90                   	nop
    2955:	90                   	nop
    2956:	90                   	nop
    2957:	90                   	nop
    2958:	90                   	nop
    2959:	90                   	nop
    295a:	90                   	nop
    295b:	90                   	nop
    295c:	90                   	nop
    295d:	90                   	nop
    295e:	90                   	nop
    295f:	90                   	nop

00002960 <dirfile>:
    2960:	55                   	push   %ebp
    2961:	89 e5                	mov    %esp,%ebp
    2963:	53                   	push   %ebx
    2964:	83 ec 0c             	sub    $0xc,%esp
    2967:	68 a8 49 00 00       	push   $0x49a8
    296c:	6a 01                	push   $0x1
    296e:	e8 4d 10 00 00       	call   39c0 <printf>
    2973:	59                   	pop    %ecx
    2974:	5b                   	pop    %ebx
    2975:	68 00 02 00 00       	push   $0x200
    297a:	68 b5 49 00 00       	push   $0x49b5
    297f:	e8 2e 0f 00 00       	call   38b2 <open>
    2984:	83 c4 10             	add    $0x10,%esp
    2987:	85 c0                	test   %eax,%eax
    2989:	0f 88 43 01 00 00    	js     2ad2 <dirfile+0x172>
    298f:	83 ec 0c             	sub    $0xc,%esp
    2992:	50                   	push   %eax
    2993:	e8 02 0f 00 00       	call   389a <close>
    2998:	c7 04 24 b5 49 00 00 	movl   $0x49b5,(%esp)
    299f:	e8 3e 0f 00 00       	call   38e2 <chdir>
    29a4:	83 c4 10             	add    $0x10,%esp
    29a7:	85 c0                	test   %eax,%eax
    29a9:	0f 84 10 01 00 00    	je     2abf <dirfile+0x15f>
    29af:	83 ec 08             	sub    $0x8,%esp
    29b2:	6a 00                	push   $0x0
    29b4:	68 ee 49 00 00       	push   $0x49ee
    29b9:	e8 f4 0e 00 00       	call   38b2 <open>
    29be:	83 c4 10             	add    $0x10,%esp
    29c1:	85 c0                	test   %eax,%eax
    29c3:	0f 89 e3 00 00 00    	jns    2aac <dirfile+0x14c>
    29c9:	83 ec 08             	sub    $0x8,%esp
    29cc:	68 00 02 00 00       	push   $0x200
    29d1:	68 ee 49 00 00       	push   $0x49ee
    29d6:	e8 d7 0e 00 00       	call   38b2 <open>
    29db:	83 c4 10             	add    $0x10,%esp
    29de:	85 c0                	test   %eax,%eax
    29e0:	0f 89 c6 00 00 00    	jns    2aac <dirfile+0x14c>
    29e6:	83 ec 0c             	sub    $0xc,%esp
    29e9:	68 ee 49 00 00       	push   $0x49ee
    29ee:	e8 e7 0e 00 00       	call   38da <mkdir>
    29f3:	83 c4 10             	add    $0x10,%esp
    29f6:	85 c0                	test   %eax,%eax
    29f8:	0f 84 46 01 00 00    	je     2b44 <dirfile+0x1e4>
    29fe:	83 ec 0c             	sub    $0xc,%esp
    2a01:	68 ee 49 00 00       	push   $0x49ee
    2a06:	e8 b7 0e 00 00       	call   38c2 <unlink>
    2a0b:	83 c4 10             	add    $0x10,%esp
    2a0e:	85 c0                	test   %eax,%eax
    2a10:	0f 84 1b 01 00 00    	je     2b31 <dirfile+0x1d1>
    2a16:	83 ec 08             	sub    $0x8,%esp
    2a19:	68 ee 49 00 00       	push   $0x49ee
    2a1e:	68 52 4a 00 00       	push   $0x4a52
    2a23:	e8 aa 0e 00 00       	call   38d2 <link>
    2a28:	83 c4 10             	add    $0x10,%esp
    2a2b:	85 c0                	test   %eax,%eax
    2a2d:	0f 84 eb 00 00 00    	je     2b1e <dirfile+0x1be>
    2a33:	83 ec 0c             	sub    $0xc,%esp
    2a36:	68 b5 49 00 00       	push   $0x49b5
    2a3b:	e8 82 0e 00 00       	call   38c2 <unlink>
    2a40:	83 c4 10             	add    $0x10,%esp
    2a43:	85 c0                	test   %eax,%eax
    2a45:	0f 85 c0 00 00 00    	jne    2b0b <dirfile+0x1ab>
    2a4b:	83 ec 08             	sub    $0x8,%esp
    2a4e:	6a 02                	push   $0x2
    2a50:	68 ae 45 00 00       	push   $0x45ae
    2a55:	e8 58 0e 00 00       	call   38b2 <open>
    2a5a:	83 c4 10             	add    $0x10,%esp
    2a5d:	85 c0                	test   %eax,%eax
    2a5f:	0f 89 93 00 00 00    	jns    2af8 <dirfile+0x198>
    2a65:	83 ec 08             	sub    $0x8,%esp
    2a68:	6a 00                	push   $0x0
    2a6a:	68 ae 45 00 00       	push   $0x45ae
    2a6f:	e8 3e 0e 00 00       	call   38b2 <open>
    2a74:	83 c4 0c             	add    $0xc,%esp
    2a77:	89 c3                	mov    %eax,%ebx
    2a79:	6a 01                	push   $0x1
    2a7b:	68 91 46 00 00       	push   $0x4691
    2a80:	50                   	push   %eax
    2a81:	e8 0c 0e 00 00       	call   3892 <write>
    2a86:	83 c4 10             	add    $0x10,%esp
    2a89:	85 c0                	test   %eax,%eax
    2a8b:	7f 58                	jg     2ae5 <dirfile+0x185>
    2a8d:	83 ec 0c             	sub    $0xc,%esp
    2a90:	53                   	push   %ebx
    2a91:	e8 04 0e 00 00       	call   389a <close>
    2a96:	58                   	pop    %eax
    2a97:	5a                   	pop    %edx
    2a98:	68 85 4a 00 00       	push   $0x4a85
    2a9d:	6a 01                	push   $0x1
    2a9f:	e8 1c 0f 00 00       	call   39c0 <printf>
    2aa4:	83 c4 10             	add    $0x10,%esp
    2aa7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2aaa:	c9                   	leave  
    2aab:	c3                   	ret    
    2aac:	50                   	push   %eax
    2aad:	50                   	push   %eax
    2aae:	68 f9 49 00 00       	push   $0x49f9
    2ab3:	6a 01                	push   $0x1
    2ab5:	e8 06 0f 00 00       	call   39c0 <printf>
    2aba:	e8 b3 0d 00 00       	call   3872 <exit>
    2abf:	50                   	push   %eax
    2ac0:	50                   	push   %eax
    2ac1:	68 d4 49 00 00       	push   $0x49d4
    2ac6:	6a 01                	push   $0x1
    2ac8:	e8 f3 0e 00 00       	call   39c0 <printf>
    2acd:	e8 a0 0d 00 00       	call   3872 <exit>
    2ad2:	52                   	push   %edx
    2ad3:	52                   	push   %edx
    2ad4:	68 bd 49 00 00       	push   $0x49bd
    2ad9:	6a 01                	push   $0x1
    2adb:	e8 e0 0e 00 00       	call   39c0 <printf>
    2ae0:	e8 8d 0d 00 00       	call   3872 <exit>
    2ae5:	51                   	push   %ecx
    2ae6:	51                   	push   %ecx
    2ae7:	68 71 4a 00 00       	push   $0x4a71
    2aec:	6a 01                	push   $0x1
    2aee:	e8 cd 0e 00 00       	call   39c0 <printf>
    2af3:	e8 7a 0d 00 00       	call   3872 <exit>
    2af8:	53                   	push   %ebx
    2af9:	53                   	push   %ebx
    2afa:	68 68 52 00 00       	push   $0x5268
    2aff:	6a 01                	push   $0x1
    2b01:	e8 ba 0e 00 00       	call   39c0 <printf>
    2b06:	e8 67 0d 00 00       	call   3872 <exit>
    2b0b:	50                   	push   %eax
    2b0c:	50                   	push   %eax
    2b0d:	68 59 4a 00 00       	push   $0x4a59
    2b12:	6a 01                	push   $0x1
    2b14:	e8 a7 0e 00 00       	call   39c0 <printf>
    2b19:	e8 54 0d 00 00       	call   3872 <exit>
    2b1e:	50                   	push   %eax
    2b1f:	50                   	push   %eax
    2b20:	68 48 52 00 00       	push   $0x5248
    2b25:	6a 01                	push   $0x1
    2b27:	e8 94 0e 00 00       	call   39c0 <printf>
    2b2c:	e8 41 0d 00 00       	call   3872 <exit>
    2b31:	50                   	push   %eax
    2b32:	50                   	push   %eax
    2b33:	68 34 4a 00 00       	push   $0x4a34
    2b38:	6a 01                	push   $0x1
    2b3a:	e8 81 0e 00 00       	call   39c0 <printf>
    2b3f:	e8 2e 0d 00 00       	call   3872 <exit>
    2b44:	50                   	push   %eax
    2b45:	50                   	push   %eax
    2b46:	68 17 4a 00 00       	push   $0x4a17
    2b4b:	6a 01                	push   $0x1
    2b4d:	e8 6e 0e 00 00       	call   39c0 <printf>
    2b52:	e8 1b 0d 00 00       	call   3872 <exit>
    2b57:	89 f6                	mov    %esi,%esi
    2b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b60 <iref>:
    2b60:	55                   	push   %ebp
    2b61:	89 e5                	mov    %esp,%ebp
    2b63:	53                   	push   %ebx
    2b64:	bb 33 00 00 00       	mov    $0x33,%ebx
    2b69:	83 ec 0c             	sub    $0xc,%esp
    2b6c:	68 95 4a 00 00       	push   $0x4a95
    2b71:	6a 01                	push   $0x1
    2b73:	e8 48 0e 00 00       	call   39c0 <printf>
    2b78:	83 c4 10             	add    $0x10,%esp
    2b7b:	90                   	nop
    2b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b80:	83 ec 0c             	sub    $0xc,%esp
    2b83:	68 a6 4a 00 00       	push   $0x4aa6
    2b88:	e8 4d 0d 00 00       	call   38da <mkdir>
    2b8d:	83 c4 10             	add    $0x10,%esp
    2b90:	85 c0                	test   %eax,%eax
    2b92:	0f 85 bb 00 00 00    	jne    2c53 <iref+0xf3>
    2b98:	83 ec 0c             	sub    $0xc,%esp
    2b9b:	68 a6 4a 00 00       	push   $0x4aa6
    2ba0:	e8 3d 0d 00 00       	call   38e2 <chdir>
    2ba5:	83 c4 10             	add    $0x10,%esp
    2ba8:	85 c0                	test   %eax,%eax
    2baa:	0f 85 b7 00 00 00    	jne    2c67 <iref+0x107>
    2bb0:	83 ec 0c             	sub    $0xc,%esp
    2bb3:	68 5b 41 00 00       	push   $0x415b
    2bb8:	e8 1d 0d 00 00       	call   38da <mkdir>
    2bbd:	59                   	pop    %ecx
    2bbe:	58                   	pop    %eax
    2bbf:	68 5b 41 00 00       	push   $0x415b
    2bc4:	68 52 4a 00 00       	push   $0x4a52
    2bc9:	e8 04 0d 00 00       	call   38d2 <link>
    2bce:	58                   	pop    %eax
    2bcf:	5a                   	pop    %edx
    2bd0:	68 00 02 00 00       	push   $0x200
    2bd5:	68 5b 41 00 00       	push   $0x415b
    2bda:	e8 d3 0c 00 00       	call   38b2 <open>
    2bdf:	83 c4 10             	add    $0x10,%esp
    2be2:	85 c0                	test   %eax,%eax
    2be4:	78 0c                	js     2bf2 <iref+0x92>
    2be6:	83 ec 0c             	sub    $0xc,%esp
    2be9:	50                   	push   %eax
    2bea:	e8 ab 0c 00 00       	call   389a <close>
    2bef:	83 c4 10             	add    $0x10,%esp
    2bf2:	83 ec 08             	sub    $0x8,%esp
    2bf5:	68 00 02 00 00       	push   $0x200
    2bfa:	68 90 46 00 00       	push   $0x4690
    2bff:	e8 ae 0c 00 00       	call   38b2 <open>
    2c04:	83 c4 10             	add    $0x10,%esp
    2c07:	85 c0                	test   %eax,%eax
    2c09:	78 0c                	js     2c17 <iref+0xb7>
    2c0b:	83 ec 0c             	sub    $0xc,%esp
    2c0e:	50                   	push   %eax
    2c0f:	e8 86 0c 00 00       	call   389a <close>
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	83 ec 0c             	sub    $0xc,%esp
    2c1a:	68 90 46 00 00       	push   $0x4690
    2c1f:	e8 9e 0c 00 00       	call   38c2 <unlink>
    2c24:	83 c4 10             	add    $0x10,%esp
    2c27:	83 eb 01             	sub    $0x1,%ebx
    2c2a:	0f 85 50 ff ff ff    	jne    2b80 <iref+0x20>
    2c30:	83 ec 0c             	sub    $0xc,%esp
    2c33:	68 81 3d 00 00       	push   $0x3d81
    2c38:	e8 a5 0c 00 00       	call   38e2 <chdir>
    2c3d:	58                   	pop    %eax
    2c3e:	5a                   	pop    %edx
    2c3f:	68 d4 4a 00 00       	push   $0x4ad4
    2c44:	6a 01                	push   $0x1
    2c46:	e8 75 0d 00 00       	call   39c0 <printf>
    2c4b:	83 c4 10             	add    $0x10,%esp
    2c4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c51:	c9                   	leave  
    2c52:	c3                   	ret    
    2c53:	83 ec 08             	sub    $0x8,%esp
    2c56:	68 ac 4a 00 00       	push   $0x4aac
    2c5b:	6a 01                	push   $0x1
    2c5d:	e8 5e 0d 00 00       	call   39c0 <printf>
    2c62:	e8 0b 0c 00 00       	call   3872 <exit>
    2c67:	83 ec 08             	sub    $0x8,%esp
    2c6a:	68 c0 4a 00 00       	push   $0x4ac0
    2c6f:	6a 01                	push   $0x1
    2c71:	e8 4a 0d 00 00       	call   39c0 <printf>
    2c76:	e8 f7 0b 00 00       	call   3872 <exit>
    2c7b:	90                   	nop
    2c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002c80 <forktest>:
    2c80:	55                   	push   %ebp
    2c81:	89 e5                	mov    %esp,%ebp
    2c83:	53                   	push   %ebx
    2c84:	31 db                	xor    %ebx,%ebx
    2c86:	83 ec 0c             	sub    $0xc,%esp
    2c89:	68 e8 4a 00 00       	push   $0x4ae8
    2c8e:	6a 01                	push   $0x1
    2c90:	e8 2b 0d 00 00       	call   39c0 <printf>
    2c95:	83 c4 10             	add    $0x10,%esp
    2c98:	eb 13                	jmp    2cad <forktest+0x2d>
    2c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2ca0:	74 62                	je     2d04 <forktest+0x84>
    2ca2:	83 c3 01             	add    $0x1,%ebx
    2ca5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2cab:	74 43                	je     2cf0 <forktest+0x70>
    2cad:	e8 b8 0b 00 00       	call   386a <fork>
    2cb2:	85 c0                	test   %eax,%eax
    2cb4:	79 ea                	jns    2ca0 <forktest+0x20>
    2cb6:	85 db                	test   %ebx,%ebx
    2cb8:	74 14                	je     2cce <forktest+0x4e>
    2cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2cc0:	e8 b5 0b 00 00       	call   387a <wait>
    2cc5:	85 c0                	test   %eax,%eax
    2cc7:	78 40                	js     2d09 <forktest+0x89>
    2cc9:	83 eb 01             	sub    $0x1,%ebx
    2ccc:	75 f2                	jne    2cc0 <forktest+0x40>
    2cce:	e8 a7 0b 00 00       	call   387a <wait>
    2cd3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cd6:	75 45                	jne    2d1d <forktest+0x9d>
    2cd8:	83 ec 08             	sub    $0x8,%esp
    2cdb:	68 1a 4b 00 00       	push   $0x4b1a
    2ce0:	6a 01                	push   $0x1
    2ce2:	e8 d9 0c 00 00       	call   39c0 <printf>
    2ce7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cea:	c9                   	leave  
    2ceb:	c3                   	ret    
    2cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2cf0:	83 ec 08             	sub    $0x8,%esp
    2cf3:	68 88 52 00 00       	push   $0x5288
    2cf8:	6a 01                	push   $0x1
    2cfa:	e8 c1 0c 00 00       	call   39c0 <printf>
    2cff:	e8 6e 0b 00 00       	call   3872 <exit>
    2d04:	e8 69 0b 00 00       	call   3872 <exit>
    2d09:	83 ec 08             	sub    $0x8,%esp
    2d0c:	68 f3 4a 00 00       	push   $0x4af3
    2d11:	6a 01                	push   $0x1
    2d13:	e8 a8 0c 00 00       	call   39c0 <printf>
    2d18:	e8 55 0b 00 00       	call   3872 <exit>
    2d1d:	50                   	push   %eax
    2d1e:	50                   	push   %eax
    2d1f:	68 07 4b 00 00       	push   $0x4b07
    2d24:	6a 01                	push   $0x1
    2d26:	e8 95 0c 00 00       	call   39c0 <printf>
    2d2b:	e8 42 0b 00 00       	call   3872 <exit>

00002d30 <sbrktest>:
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
    2d35:	53                   	push   %ebx
    2d36:	31 ff                	xor    %edi,%edi
    2d38:	83 ec 64             	sub    $0x64,%esp
    2d3b:	68 28 4b 00 00       	push   $0x4b28
    2d40:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    2d46:	e8 75 0c 00 00       	call   39c0 <printf>
    2d4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d52:	e8 a3 0b 00 00       	call   38fa <sbrk>
    2d57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d5e:	89 c3                	mov    %eax,%ebx
    2d60:	e8 95 0b 00 00       	call   38fa <sbrk>
    2d65:	83 c4 10             	add    $0x10,%esp
    2d68:	89 c6                	mov    %eax,%esi
    2d6a:	eb 06                	jmp    2d72 <sbrktest+0x42>
    2d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d70:	89 c6                	mov    %eax,%esi
    2d72:	83 ec 0c             	sub    $0xc,%esp
    2d75:	6a 01                	push   $0x1
    2d77:	e8 7e 0b 00 00       	call   38fa <sbrk>
    2d7c:	83 c4 10             	add    $0x10,%esp
    2d7f:	39 f0                	cmp    %esi,%eax
    2d81:	0f 85 62 02 00 00    	jne    2fe9 <sbrktest+0x2b9>
    2d87:	83 c7 01             	add    $0x1,%edi
    2d8a:	c6 06 01             	movb   $0x1,(%esi)
    2d8d:	8d 46 01             	lea    0x1(%esi),%eax
    2d90:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2d96:	75 d8                	jne    2d70 <sbrktest+0x40>
    2d98:	e8 cd 0a 00 00       	call   386a <fork>
    2d9d:	85 c0                	test   %eax,%eax
    2d9f:	89 c7                	mov    %eax,%edi
    2da1:	0f 88 82 03 00 00    	js     3129 <sbrktest+0x3f9>
    2da7:	83 ec 0c             	sub    $0xc,%esp
    2daa:	83 c6 02             	add    $0x2,%esi
    2dad:	6a 01                	push   $0x1
    2daf:	e8 46 0b 00 00       	call   38fa <sbrk>
    2db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dbb:	e8 3a 0b 00 00       	call   38fa <sbrk>
    2dc0:	83 c4 10             	add    $0x10,%esp
    2dc3:	39 f0                	cmp    %esi,%eax
    2dc5:	0f 85 47 03 00 00    	jne    3112 <sbrktest+0x3e2>
    2dcb:	85 ff                	test   %edi,%edi
    2dcd:	0f 84 3a 03 00 00    	je     310d <sbrktest+0x3dd>
    2dd3:	e8 a2 0a 00 00       	call   387a <wait>
    2dd8:	83 ec 0c             	sub    $0xc,%esp
    2ddb:	6a 00                	push   $0x0
    2ddd:	e8 18 0b 00 00       	call   38fa <sbrk>
    2de2:	89 c6                	mov    %eax,%esi
    2de4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2de9:	29 f0                	sub    %esi,%eax
    2deb:	89 04 24             	mov    %eax,(%esp)
    2dee:	e8 07 0b 00 00       	call   38fa <sbrk>
    2df3:	83 c4 10             	add    $0x10,%esp
    2df6:	39 c6                	cmp    %eax,%esi
    2df8:	0f 85 f8 02 00 00    	jne    30f6 <sbrktest+0x3c6>
    2dfe:	83 ec 0c             	sub    $0xc,%esp
    2e01:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
    2e08:	6a 00                	push   $0x0
    2e0a:	e8 eb 0a 00 00       	call   38fa <sbrk>
    2e0f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2e16:	89 c6                	mov    %eax,%esi
    2e18:	e8 dd 0a 00 00       	call   38fa <sbrk>
    2e1d:	83 c4 10             	add    $0x10,%esp
    2e20:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e23:	0f 84 b6 02 00 00    	je     30df <sbrktest+0x3af>
    2e29:	83 ec 0c             	sub    $0xc,%esp
    2e2c:	6a 00                	push   $0x0
    2e2e:	e8 c7 0a 00 00       	call   38fa <sbrk>
    2e33:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2e39:	83 c4 10             	add    $0x10,%esp
    2e3c:	39 d0                	cmp    %edx,%eax
    2e3e:	0f 85 84 02 00 00    	jne    30c8 <sbrktest+0x398>
    2e44:	83 ec 0c             	sub    $0xc,%esp
    2e47:	6a 00                	push   $0x0
    2e49:	e8 ac 0a 00 00       	call   38fa <sbrk>
    2e4e:	89 c6                	mov    %eax,%esi
    2e50:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e57:	e8 9e 0a 00 00       	call   38fa <sbrk>
    2e5c:	83 c4 10             	add    $0x10,%esp
    2e5f:	39 c6                	cmp    %eax,%esi
    2e61:	89 c7                	mov    %eax,%edi
    2e63:	0f 85 48 02 00 00    	jne    30b1 <sbrktest+0x381>
    2e69:	83 ec 0c             	sub    $0xc,%esp
    2e6c:	6a 00                	push   $0x0
    2e6e:	e8 87 0a 00 00       	call   38fa <sbrk>
    2e73:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2e79:	83 c4 10             	add    $0x10,%esp
    2e7c:	39 d0                	cmp    %edx,%eax
    2e7e:	0f 85 2d 02 00 00    	jne    30b1 <sbrktest+0x381>
    2e84:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e8b:	0f 84 09 02 00 00    	je     309a <sbrktest+0x36a>
    2e91:	83 ec 0c             	sub    $0xc,%esp
    2e94:	6a 00                	push   $0x0
    2e96:	e8 5f 0a 00 00       	call   38fa <sbrk>
    2e9b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ea2:	89 c6                	mov    %eax,%esi
    2ea4:	e8 51 0a 00 00       	call   38fa <sbrk>
    2ea9:	89 d9                	mov    %ebx,%ecx
    2eab:	29 c1                	sub    %eax,%ecx
    2ead:	89 0c 24             	mov    %ecx,(%esp)
    2eb0:	e8 45 0a 00 00       	call   38fa <sbrk>
    2eb5:	83 c4 10             	add    $0x10,%esp
    2eb8:	39 c6                	cmp    %eax,%esi
    2eba:	0f 85 c3 01 00 00    	jne    3083 <sbrktest+0x353>
    2ec0:	be 00 00 00 80       	mov    $0x80000000,%esi
    2ec5:	e8 28 0a 00 00       	call   38f2 <getpid>
    2eca:	89 c7                	mov    %eax,%edi
    2ecc:	e8 99 09 00 00       	call   386a <fork>
    2ed1:	85 c0                	test   %eax,%eax
    2ed3:	0f 88 93 01 00 00    	js     306c <sbrktest+0x33c>
    2ed9:	0f 84 6b 01 00 00    	je     304a <sbrktest+0x31a>
    2edf:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    2ee5:	e8 90 09 00 00       	call   387a <wait>
    2eea:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2ef0:	75 d3                	jne    2ec5 <sbrktest+0x195>
    2ef2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ef5:	83 ec 0c             	sub    $0xc,%esp
    2ef8:	50                   	push   %eax
    2ef9:	e8 84 09 00 00       	call   3882 <pipe>
    2efe:	83 c4 10             	add    $0x10,%esp
    2f01:	85 c0                	test   %eax,%eax
    2f03:	0f 85 2e 01 00 00    	jne    3037 <sbrktest+0x307>
    2f09:	8d 7d c0             	lea    -0x40(%ebp),%edi
    2f0c:	89 fe                	mov    %edi,%esi
    2f0e:	eb 23                	jmp    2f33 <sbrktest+0x203>
    2f10:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f13:	74 14                	je     2f29 <sbrktest+0x1f9>
    2f15:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f18:	83 ec 04             	sub    $0x4,%esp
    2f1b:	6a 01                	push   $0x1
    2f1d:	50                   	push   %eax
    2f1e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f21:	e8 64 09 00 00       	call   388a <read>
    2f26:	83 c4 10             	add    $0x10,%esp
    2f29:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f2c:	83 c6 04             	add    $0x4,%esi
    2f2f:	39 c6                	cmp    %eax,%esi
    2f31:	74 4f                	je     2f82 <sbrktest+0x252>
    2f33:	e8 32 09 00 00       	call   386a <fork>
    2f38:	85 c0                	test   %eax,%eax
    2f3a:	89 06                	mov    %eax,(%esi)
    2f3c:	75 d2                	jne    2f10 <sbrktest+0x1e0>
    2f3e:	83 ec 0c             	sub    $0xc,%esp
    2f41:	6a 00                	push   $0x0
    2f43:	e8 b2 09 00 00       	call   38fa <sbrk>
    2f48:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f4d:	29 c2                	sub    %eax,%edx
    2f4f:	89 14 24             	mov    %edx,(%esp)
    2f52:	e8 a3 09 00 00       	call   38fa <sbrk>
    2f57:	83 c4 0c             	add    $0xc,%esp
    2f5a:	6a 01                	push   $0x1
    2f5c:	68 91 46 00 00       	push   $0x4691
    2f61:	ff 75 bc             	pushl  -0x44(%ebp)
    2f64:	e8 29 09 00 00       	call   3892 <write>
    2f69:	83 c4 10             	add    $0x10,%esp
    2f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2f70:	83 ec 0c             	sub    $0xc,%esp
    2f73:	68 e8 03 00 00       	push   $0x3e8
    2f78:	e8 85 09 00 00       	call   3902 <sleep>
    2f7d:	83 c4 10             	add    $0x10,%esp
    2f80:	eb ee                	jmp    2f70 <sbrktest+0x240>
    2f82:	83 ec 0c             	sub    $0xc,%esp
    2f85:	68 00 10 00 00       	push   $0x1000
    2f8a:	e8 6b 09 00 00       	call   38fa <sbrk>
    2f8f:	83 c4 10             	add    $0x10,%esp
    2f92:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    2f95:	8b 07                	mov    (%edi),%eax
    2f97:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f9a:	74 11                	je     2fad <sbrktest+0x27d>
    2f9c:	83 ec 0c             	sub    $0xc,%esp
    2f9f:	50                   	push   %eax
    2fa0:	e8 fd 08 00 00       	call   38a2 <kill>
    2fa5:	e8 d0 08 00 00       	call   387a <wait>
    2faa:	83 c4 10             	add    $0x10,%esp
    2fad:	83 c7 04             	add    $0x4,%edi
    2fb0:	39 fe                	cmp    %edi,%esi
    2fb2:	75 e1                	jne    2f95 <sbrktest+0x265>
    2fb4:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2fb8:	74 66                	je     3020 <sbrktest+0x2f0>
    2fba:	83 ec 0c             	sub    $0xc,%esp
    2fbd:	6a 00                	push   $0x0
    2fbf:	e8 36 09 00 00       	call   38fa <sbrk>
    2fc4:	83 c4 10             	add    $0x10,%esp
    2fc7:	39 d8                	cmp    %ebx,%eax
    2fc9:	77 3c                	ja     3007 <sbrktest+0x2d7>
    2fcb:	83 ec 08             	sub    $0x8,%esp
    2fce:	68 d0 4b 00 00       	push   $0x4bd0
    2fd3:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    2fd9:	e8 e2 09 00 00       	call   39c0 <printf>
    2fde:	83 c4 10             	add    $0x10,%esp
    2fe1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fe4:	5b                   	pop    %ebx
    2fe5:	5e                   	pop    %esi
    2fe6:	5f                   	pop    %edi
    2fe7:	5d                   	pop    %ebp
    2fe8:	c3                   	ret    
    2fe9:	83 ec 0c             	sub    $0xc,%esp
    2fec:	50                   	push   %eax
    2fed:	56                   	push   %esi
    2fee:	57                   	push   %edi
    2fef:	68 33 4b 00 00       	push   $0x4b33
    2ff4:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    2ffa:	e8 c1 09 00 00       	call   39c0 <printf>
    2fff:	83 c4 20             	add    $0x20,%esp
    3002:	e8 6b 08 00 00       	call   3872 <exit>
    3007:	83 ec 0c             	sub    $0xc,%esp
    300a:	6a 00                	push   $0x0
    300c:	e8 e9 08 00 00       	call   38fa <sbrk>
    3011:	29 c3                	sub    %eax,%ebx
    3013:	89 1c 24             	mov    %ebx,(%esp)
    3016:	e8 df 08 00 00       	call   38fa <sbrk>
    301b:	83 c4 10             	add    $0x10,%esp
    301e:	eb ab                	jmp    2fcb <sbrktest+0x29b>
    3020:	50                   	push   %eax
    3021:	50                   	push   %eax
    3022:	68 b5 4b 00 00       	push   $0x4bb5
    3027:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    302d:	e8 8e 09 00 00       	call   39c0 <printf>
    3032:	e8 3b 08 00 00       	call   3872 <exit>
    3037:	52                   	push   %edx
    3038:	52                   	push   %edx
    3039:	68 71 40 00 00       	push   $0x4071
    303e:	6a 01                	push   $0x1
    3040:	e8 7b 09 00 00       	call   39c0 <printf>
    3045:	e8 28 08 00 00       	call   3872 <exit>
    304a:	0f be 06             	movsbl (%esi),%eax
    304d:	50                   	push   %eax
    304e:	56                   	push   %esi
    304f:	68 9c 4b 00 00       	push   $0x4b9c
    3054:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    305a:	e8 61 09 00 00       	call   39c0 <printf>
    305f:	89 3c 24             	mov    %edi,(%esp)
    3062:	e8 3b 08 00 00       	call   38a2 <kill>
    3067:	e8 06 08 00 00       	call   3872 <exit>
    306c:	51                   	push   %ecx
    306d:	51                   	push   %ecx
    306e:	68 79 4c 00 00       	push   $0x4c79
    3073:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3079:	e8 42 09 00 00       	call   39c0 <printf>
    307e:	e8 ef 07 00 00       	call   3872 <exit>
    3083:	50                   	push   %eax
    3084:	56                   	push   %esi
    3085:	68 7c 53 00 00       	push   $0x537c
    308a:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3090:	e8 2b 09 00 00       	call   39c0 <printf>
    3095:	e8 d8 07 00 00       	call   3872 <exit>
    309a:	53                   	push   %ebx
    309b:	53                   	push   %ebx
    309c:	68 4c 53 00 00       	push   $0x534c
    30a1:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    30a7:	e8 14 09 00 00       	call   39c0 <printf>
    30ac:	e8 c1 07 00 00       	call   3872 <exit>
    30b1:	57                   	push   %edi
    30b2:	56                   	push   %esi
    30b3:	68 24 53 00 00       	push   $0x5324
    30b8:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    30be:	e8 fd 08 00 00       	call   39c0 <printf>
    30c3:	e8 aa 07 00 00       	call   3872 <exit>
    30c8:	50                   	push   %eax
    30c9:	56                   	push   %esi
    30ca:	68 ec 52 00 00       	push   $0x52ec
    30cf:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    30d5:	e8 e6 08 00 00       	call   39c0 <printf>
    30da:	e8 93 07 00 00       	call   3872 <exit>
    30df:	56                   	push   %esi
    30e0:	56                   	push   %esi
    30e1:	68 81 4b 00 00       	push   $0x4b81
    30e6:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    30ec:	e8 cf 08 00 00       	call   39c0 <printf>
    30f1:	e8 7c 07 00 00       	call   3872 <exit>
    30f6:	57                   	push   %edi
    30f7:	57                   	push   %edi
    30f8:	68 ac 52 00 00       	push   $0x52ac
    30fd:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3103:	e8 b8 08 00 00       	call   39c0 <printf>
    3108:	e8 65 07 00 00       	call   3872 <exit>
    310d:	e8 60 07 00 00       	call   3872 <exit>
    3112:	50                   	push   %eax
    3113:	50                   	push   %eax
    3114:	68 65 4b 00 00       	push   $0x4b65
    3119:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    311f:	e8 9c 08 00 00       	call   39c0 <printf>
    3124:	e8 49 07 00 00       	call   3872 <exit>
    3129:	50                   	push   %eax
    312a:	50                   	push   %eax
    312b:	68 4e 4b 00 00       	push   $0x4b4e
    3130:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3136:	e8 85 08 00 00       	call   39c0 <printf>
    313b:	e8 32 07 00 00       	call   3872 <exit>

00003140 <validateint>:
    3140:	55                   	push   %ebp
    3141:	89 e5                	mov    %esp,%ebp
    3143:	5d                   	pop    %ebp
    3144:	c3                   	ret    
    3145:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003150 <validatetest>:
    3150:	55                   	push   %ebp
    3151:	89 e5                	mov    %esp,%ebp
    3153:	56                   	push   %esi
    3154:	53                   	push   %ebx
    3155:	31 db                	xor    %ebx,%ebx
    3157:	83 ec 08             	sub    $0x8,%esp
    315a:	68 de 4b 00 00       	push   $0x4bde
    315f:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3165:	e8 56 08 00 00       	call   39c0 <printf>
    316a:	83 c4 10             	add    $0x10,%esp
    316d:	8d 76 00             	lea    0x0(%esi),%esi
    3170:	e8 f5 06 00 00       	call   386a <fork>
    3175:	85 c0                	test   %eax,%eax
    3177:	89 c6                	mov    %eax,%esi
    3179:	74 63                	je     31de <validatetest+0x8e>
    317b:	83 ec 0c             	sub    $0xc,%esp
    317e:	6a 00                	push   $0x0
    3180:	e8 7d 07 00 00       	call   3902 <sleep>
    3185:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    318c:	e8 71 07 00 00       	call   3902 <sleep>
    3191:	89 34 24             	mov    %esi,(%esp)
    3194:	e8 09 07 00 00       	call   38a2 <kill>
    3199:	e8 dc 06 00 00       	call   387a <wait>
    319e:	58                   	pop    %eax
    319f:	5a                   	pop    %edx
    31a0:	53                   	push   %ebx
    31a1:	68 ed 4b 00 00       	push   $0x4bed
    31a6:	e8 27 07 00 00       	call   38d2 <link>
    31ab:	83 c4 10             	add    $0x10,%esp
    31ae:	83 f8 ff             	cmp    $0xffffffff,%eax
    31b1:	75 30                	jne    31e3 <validatetest+0x93>
    31b3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    31b9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    31bf:	75 af                	jne    3170 <validatetest+0x20>
    31c1:	83 ec 08             	sub    $0x8,%esp
    31c4:	68 11 4c 00 00       	push   $0x4c11
    31c9:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    31cf:	e8 ec 07 00 00       	call   39c0 <printf>
    31d4:	83 c4 10             	add    $0x10,%esp
    31d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31da:	5b                   	pop    %ebx
    31db:	5e                   	pop    %esi
    31dc:	5d                   	pop    %ebp
    31dd:	c3                   	ret    
    31de:	e8 8f 06 00 00       	call   3872 <exit>
    31e3:	83 ec 08             	sub    $0x8,%esp
    31e6:	68 f8 4b 00 00       	push   $0x4bf8
    31eb:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    31f1:	e8 ca 07 00 00       	call   39c0 <printf>
    31f6:	e8 77 06 00 00       	call   3872 <exit>
    31fb:	90                   	nop
    31fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003200 <bsstest>:
    3200:	55                   	push   %ebp
    3201:	89 e5                	mov    %esp,%ebp
    3203:	83 ec 10             	sub    $0x10,%esp
    3206:	68 1e 4c 00 00       	push   $0x4c1e
    320b:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3211:	e8 aa 07 00 00       	call   39c0 <printf>
    3216:	83 c4 10             	add    $0x10,%esp
    3219:	80 3d a0 5e 00 00 00 	cmpb   $0x0,0x5ea0
    3220:	75 39                	jne    325b <bsstest+0x5b>
    3222:	b8 01 00 00 00       	mov    $0x1,%eax
    3227:	89 f6                	mov    %esi,%esi
    3229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3230:	80 b8 a0 5e 00 00 00 	cmpb   $0x0,0x5ea0(%eax)
    3237:	75 22                	jne    325b <bsstest+0x5b>
    3239:	83 c0 01             	add    $0x1,%eax
    323c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3241:	75 ed                	jne    3230 <bsstest+0x30>
    3243:	83 ec 08             	sub    $0x8,%esp
    3246:	68 39 4c 00 00       	push   $0x4c39
    324b:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3251:	e8 6a 07 00 00       	call   39c0 <printf>
    3256:	83 c4 10             	add    $0x10,%esp
    3259:	c9                   	leave  
    325a:	c3                   	ret    
    325b:	83 ec 08             	sub    $0x8,%esp
    325e:	68 28 4c 00 00       	push   $0x4c28
    3263:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3269:	e8 52 07 00 00       	call   39c0 <printf>
    326e:	e8 ff 05 00 00       	call   3872 <exit>
    3273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003280 <bigargtest>:
    3280:	55                   	push   %ebp
    3281:	89 e5                	mov    %esp,%ebp
    3283:	83 ec 14             	sub    $0x14,%esp
    3286:	68 46 4c 00 00       	push   $0x4c46
    328b:	e8 32 06 00 00       	call   38c2 <unlink>
    3290:	e8 d5 05 00 00       	call   386a <fork>
    3295:	83 c4 10             	add    $0x10,%esp
    3298:	85 c0                	test   %eax,%eax
    329a:	74 3f                	je     32db <bigargtest+0x5b>
    329c:	0f 88 c2 00 00 00    	js     3364 <bigargtest+0xe4>
    32a2:	e8 d3 05 00 00       	call   387a <wait>
    32a7:	83 ec 08             	sub    $0x8,%esp
    32aa:	6a 00                	push   $0x0
    32ac:	68 46 4c 00 00       	push   $0x4c46
    32b1:	e8 fc 05 00 00       	call   38b2 <open>
    32b6:	83 c4 10             	add    $0x10,%esp
    32b9:	85 c0                	test   %eax,%eax
    32bb:	0f 88 8c 00 00 00    	js     334d <bigargtest+0xcd>
    32c1:	83 ec 0c             	sub    $0xc,%esp
    32c4:	50                   	push   %eax
    32c5:	e8 d0 05 00 00       	call   389a <close>
    32ca:	c7 04 24 46 4c 00 00 	movl   $0x4c46,(%esp)
    32d1:	e8 ec 05 00 00       	call   38c2 <unlink>
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	c9                   	leave  
    32da:	c3                   	ret    
    32db:	b8 00 5e 00 00       	mov    $0x5e00,%eax
    32e0:	c7 00 a0 53 00 00    	movl   $0x53a0,(%eax)
    32e6:	83 c0 04             	add    $0x4,%eax
    32e9:	3d 7c 5e 00 00       	cmp    $0x5e7c,%eax
    32ee:	75 f0                	jne    32e0 <bigargtest+0x60>
    32f0:	51                   	push   %ecx
    32f1:	51                   	push   %ecx
    32f2:	68 50 4c 00 00       	push   $0x4c50
    32f7:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    32fd:	c7 05 7c 5e 00 00 00 	movl   $0x0,0x5e7c
    3304:	00 00 00 
    3307:	e8 b4 06 00 00       	call   39c0 <printf>
    330c:	58                   	pop    %eax
    330d:	5a                   	pop    %edx
    330e:	68 00 5e 00 00       	push   $0x5e00
    3313:	68 1d 3e 00 00       	push   $0x3e1d
    3318:	e8 8d 05 00 00       	call   38aa <exec>
    331d:	59                   	pop    %ecx
    331e:	58                   	pop    %eax
    331f:	68 5d 4c 00 00       	push   $0x4c5d
    3324:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    332a:	e8 91 06 00 00       	call   39c0 <printf>
    332f:	58                   	pop    %eax
    3330:	5a                   	pop    %edx
    3331:	68 00 02 00 00       	push   $0x200
    3336:	68 46 4c 00 00       	push   $0x4c46
    333b:	e8 72 05 00 00       	call   38b2 <open>
    3340:	89 04 24             	mov    %eax,(%esp)
    3343:	e8 52 05 00 00       	call   389a <close>
    3348:	e8 25 05 00 00       	call   3872 <exit>
    334d:	50                   	push   %eax
    334e:	50                   	push   %eax
    334f:	68 86 4c 00 00       	push   $0x4c86
    3354:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    335a:	e8 61 06 00 00       	call   39c0 <printf>
    335f:	e8 0e 05 00 00       	call   3872 <exit>
    3364:	52                   	push   %edx
    3365:	52                   	push   %edx
    3366:	68 6d 4c 00 00       	push   $0x4c6d
    336b:	ff 35 d0 5d 00 00    	pushl  0x5dd0
    3371:	e8 4a 06 00 00       	call   39c0 <printf>
    3376:	e8 f7 04 00 00       	call   3872 <exit>
    337b:	90                   	nop
    337c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003380 <fsfull>:
    3380:	55                   	push   %ebp
    3381:	89 e5                	mov    %esp,%ebp
    3383:	57                   	push   %edi
    3384:	56                   	push   %esi
    3385:	53                   	push   %ebx
    3386:	31 db                	xor    %ebx,%ebx
    3388:	83 ec 54             	sub    $0x54,%esp
    338b:	68 9b 4c 00 00       	push   $0x4c9b
    3390:	6a 01                	push   $0x1
    3392:	e8 29 06 00 00       	call   39c0 <printf>
    3397:	83 c4 10             	add    $0x10,%esp
    339a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    33a0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    33a5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    33aa:	83 ec 04             	sub    $0x4,%esp
    33ad:	f7 e3                	mul    %ebx
    33af:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    33b3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    33b7:	c1 ea 06             	shr    $0x6,%edx
    33ba:	8d 42 30             	lea    0x30(%edx),%eax
    33bd:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    33c3:	88 45 a9             	mov    %al,-0x57(%ebp)
    33c6:	89 d8                	mov    %ebx,%eax
    33c8:	29 d0                	sub    %edx,%eax
    33ca:	89 c2                	mov    %eax,%edx
    33cc:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33d1:	f7 e2                	mul    %edx
    33d3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33d8:	c1 ea 05             	shr    $0x5,%edx
    33db:	83 c2 30             	add    $0x30,%edx
    33de:	88 55 aa             	mov    %dl,-0x56(%ebp)
    33e1:	f7 e3                	mul    %ebx
    33e3:	89 d8                	mov    %ebx,%eax
    33e5:	c1 ea 05             	shr    $0x5,%edx
    33e8:	6b d2 64             	imul   $0x64,%edx,%edx
    33eb:	29 d0                	sub    %edx,%eax
    33ed:	f7 e1                	mul    %ecx
    33ef:	89 d8                	mov    %ebx,%eax
    33f1:	c1 ea 03             	shr    $0x3,%edx
    33f4:	83 c2 30             	add    $0x30,%edx
    33f7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    33fa:	f7 e1                	mul    %ecx
    33fc:	89 d9                	mov    %ebx,%ecx
    33fe:	c1 ea 03             	shr    $0x3,%edx
    3401:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3404:	01 c0                	add    %eax,%eax
    3406:	29 c1                	sub    %eax,%ecx
    3408:	89 c8                	mov    %ecx,%eax
    340a:	83 c0 30             	add    $0x30,%eax
    340d:	88 45 ac             	mov    %al,-0x54(%ebp)
    3410:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3413:	50                   	push   %eax
    3414:	68 a8 4c 00 00       	push   $0x4ca8
    3419:	6a 01                	push   $0x1
    341b:	e8 a0 05 00 00       	call   39c0 <printf>
    3420:	58                   	pop    %eax
    3421:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3424:	5a                   	pop    %edx
    3425:	68 02 02 00 00       	push   $0x202
    342a:	50                   	push   %eax
    342b:	e8 82 04 00 00       	call   38b2 <open>
    3430:	83 c4 10             	add    $0x10,%esp
    3433:	85 c0                	test   %eax,%eax
    3435:	89 c7                	mov    %eax,%edi
    3437:	78 57                	js     3490 <fsfull+0x110>
    3439:	31 f6                	xor    %esi,%esi
    343b:	eb 05                	jmp    3442 <fsfull+0xc2>
    343d:	8d 76 00             	lea    0x0(%esi),%esi
    3440:	01 c6                	add    %eax,%esi
    3442:	83 ec 04             	sub    $0x4,%esp
    3445:	68 00 02 00 00       	push   $0x200
    344a:	68 c0 85 00 00       	push   $0x85c0
    344f:	57                   	push   %edi
    3450:	e8 3d 04 00 00       	call   3892 <write>
    3455:	83 c4 10             	add    $0x10,%esp
    3458:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    345d:	7f e1                	jg     3440 <fsfull+0xc0>
    345f:	83 ec 04             	sub    $0x4,%esp
    3462:	56                   	push   %esi
    3463:	68 c4 4c 00 00       	push   $0x4cc4
    3468:	6a 01                	push   $0x1
    346a:	e8 51 05 00 00       	call   39c0 <printf>
    346f:	89 3c 24             	mov    %edi,(%esp)
    3472:	e8 23 04 00 00       	call   389a <close>
    3477:	83 c4 10             	add    $0x10,%esp
    347a:	85 f6                	test   %esi,%esi
    347c:	74 28                	je     34a6 <fsfull+0x126>
    347e:	83 c3 01             	add    $0x1,%ebx
    3481:	e9 1a ff ff ff       	jmp    33a0 <fsfull+0x20>
    3486:	8d 76 00             	lea    0x0(%esi),%esi
    3489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3490:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3493:	83 ec 04             	sub    $0x4,%esp
    3496:	50                   	push   %eax
    3497:	68 b4 4c 00 00       	push   $0x4cb4
    349c:	6a 01                	push   $0x1
    349e:	e8 1d 05 00 00       	call   39c0 <printf>
    34a3:	83 c4 10             	add    $0x10,%esp
    34a6:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    34ab:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    34b0:	89 d8                	mov    %ebx,%eax
    34b2:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    34b7:	83 ec 0c             	sub    $0xc,%esp
    34ba:	f7 e7                	mul    %edi
    34bc:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    34c0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    34c4:	c1 ea 06             	shr    $0x6,%edx
    34c7:	8d 42 30             	lea    0x30(%edx),%eax
    34ca:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    34d0:	88 45 a9             	mov    %al,-0x57(%ebp)
    34d3:	89 d8                	mov    %ebx,%eax
    34d5:	29 d0                	sub    %edx,%eax
    34d7:	f7 e6                	mul    %esi
    34d9:	89 d8                	mov    %ebx,%eax
    34db:	c1 ea 05             	shr    $0x5,%edx
    34de:	83 c2 30             	add    $0x30,%edx
    34e1:	88 55 aa             	mov    %dl,-0x56(%ebp)
    34e4:	f7 e6                	mul    %esi
    34e6:	89 d8                	mov    %ebx,%eax
    34e8:	c1 ea 05             	shr    $0x5,%edx
    34eb:	6b d2 64             	imul   $0x64,%edx,%edx
    34ee:	29 d0                	sub    %edx,%eax
    34f0:	f7 e1                	mul    %ecx
    34f2:	89 d8                	mov    %ebx,%eax
    34f4:	c1 ea 03             	shr    $0x3,%edx
    34f7:	83 c2 30             	add    $0x30,%edx
    34fa:	88 55 ab             	mov    %dl,-0x55(%ebp)
    34fd:	f7 e1                	mul    %ecx
    34ff:	89 d9                	mov    %ebx,%ecx
    3501:	83 eb 01             	sub    $0x1,%ebx
    3504:	c1 ea 03             	shr    $0x3,%edx
    3507:	8d 04 92             	lea    (%edx,%edx,4),%eax
    350a:	01 c0                	add    %eax,%eax
    350c:	29 c1                	sub    %eax,%ecx
    350e:	89 c8                	mov    %ecx,%eax
    3510:	83 c0 30             	add    $0x30,%eax
    3513:	88 45 ac             	mov    %al,-0x54(%ebp)
    3516:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3519:	50                   	push   %eax
    351a:	e8 a3 03 00 00       	call   38c2 <unlink>
    351f:	83 c4 10             	add    $0x10,%esp
    3522:	83 fb ff             	cmp    $0xffffffff,%ebx
    3525:	75 89                	jne    34b0 <fsfull+0x130>
    3527:	83 ec 08             	sub    $0x8,%esp
    352a:	68 d4 4c 00 00       	push   $0x4cd4
    352f:	6a 01                	push   $0x1
    3531:	e8 8a 04 00 00       	call   39c0 <printf>
    3536:	83 c4 10             	add    $0x10,%esp
    3539:	8d 65 f4             	lea    -0xc(%ebp),%esp
    353c:	5b                   	pop    %ebx
    353d:	5e                   	pop    %esi
    353e:	5f                   	pop    %edi
    353f:	5d                   	pop    %ebp
    3540:	c3                   	ret    
    3541:	eb 0d                	jmp    3550 <uio>
    3543:	90                   	nop
    3544:	90                   	nop
    3545:	90                   	nop
    3546:	90                   	nop
    3547:	90                   	nop
    3548:	90                   	nop
    3549:	90                   	nop
    354a:	90                   	nop
    354b:	90                   	nop
    354c:	90                   	nop
    354d:	90                   	nop
    354e:	90                   	nop
    354f:	90                   	nop

00003550 <uio>:
    3550:	55                   	push   %ebp
    3551:	89 e5                	mov    %esp,%ebp
    3553:	83 ec 10             	sub    $0x10,%esp
    3556:	68 ea 4c 00 00       	push   $0x4cea
    355b:	6a 01                	push   $0x1
    355d:	e8 5e 04 00 00       	call   39c0 <printf>
    3562:	e8 03 03 00 00       	call   386a <fork>
    3567:	83 c4 10             	add    $0x10,%esp
    356a:	85 c0                	test   %eax,%eax
    356c:	74 1b                	je     3589 <uio+0x39>
    356e:	78 3d                	js     35ad <uio+0x5d>
    3570:	e8 05 03 00 00       	call   387a <wait>
    3575:	83 ec 08             	sub    $0x8,%esp
    3578:	68 f4 4c 00 00       	push   $0x4cf4
    357d:	6a 01                	push   $0x1
    357f:	e8 3c 04 00 00       	call   39c0 <printf>
    3584:	83 c4 10             	add    $0x10,%esp
    3587:	c9                   	leave  
    3588:	c3                   	ret    
    3589:	b8 09 00 00 00       	mov    $0x9,%eax
    358e:	ba 70 00 00 00       	mov    $0x70,%edx
    3593:	ee                   	out    %al,(%dx)
    3594:	ba 71 00 00 00       	mov    $0x71,%edx
    3599:	ec                   	in     (%dx),%al
    359a:	52                   	push   %edx
    359b:	52                   	push   %edx
    359c:	68 80 54 00 00       	push   $0x5480
    35a1:	6a 01                	push   $0x1
    35a3:	e8 18 04 00 00       	call   39c0 <printf>
    35a8:	e8 c5 02 00 00       	call   3872 <exit>
    35ad:	50                   	push   %eax
    35ae:	50                   	push   %eax
    35af:	68 79 4c 00 00       	push   $0x4c79
    35b4:	6a 01                	push   $0x1
    35b6:	e8 05 04 00 00       	call   39c0 <printf>
    35bb:	e8 b2 02 00 00       	call   3872 <exit>

000035c0 <argptest>:
    35c0:	55                   	push   %ebp
    35c1:	89 e5                	mov    %esp,%ebp
    35c3:	53                   	push   %ebx
    35c4:	83 ec 0c             	sub    $0xc,%esp
    35c7:	6a 00                	push   $0x0
    35c9:	68 03 4d 00 00       	push   $0x4d03
    35ce:	e8 df 02 00 00       	call   38b2 <open>
    35d3:	83 c4 10             	add    $0x10,%esp
    35d6:	85 c0                	test   %eax,%eax
    35d8:	78 39                	js     3613 <argptest+0x53>
    35da:	83 ec 0c             	sub    $0xc,%esp
    35dd:	89 c3                	mov    %eax,%ebx
    35df:	6a 00                	push   $0x0
    35e1:	e8 14 03 00 00       	call   38fa <sbrk>
    35e6:	83 c4 0c             	add    $0xc,%esp
    35e9:	83 e8 01             	sub    $0x1,%eax
    35ec:	6a ff                	push   $0xffffffff
    35ee:	50                   	push   %eax
    35ef:	53                   	push   %ebx
    35f0:	e8 95 02 00 00       	call   388a <read>
    35f5:	89 1c 24             	mov    %ebx,(%esp)
    35f8:	e8 9d 02 00 00       	call   389a <close>
    35fd:	58                   	pop    %eax
    35fe:	5a                   	pop    %edx
    35ff:	68 15 4d 00 00       	push   $0x4d15
    3604:	6a 01                	push   $0x1
    3606:	e8 b5 03 00 00       	call   39c0 <printf>
    360b:	83 c4 10             	add    $0x10,%esp
    360e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3611:	c9                   	leave  
    3612:	c3                   	ret    
    3613:	51                   	push   %ecx
    3614:	51                   	push   %ecx
    3615:	68 08 4d 00 00       	push   $0x4d08
    361a:	6a 02                	push   $0x2
    361c:	e8 9f 03 00 00       	call   39c0 <printf>
    3621:	e8 4c 02 00 00       	call   3872 <exit>
    3626:	8d 76 00             	lea    0x0(%esi),%esi
    3629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003630 <rand>:
    3630:	69 05 cc 5d 00 00 0d 	imul   $0x19660d,0x5dcc,%eax
    3637:	66 19 00 
    363a:	55                   	push   %ebp
    363b:	89 e5                	mov    %esp,%ebp
    363d:	5d                   	pop    %ebp
    363e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3643:	a3 cc 5d 00 00       	mov    %eax,0x5dcc
    3648:	c3                   	ret    
    3649:	66 90                	xchg   %ax,%ax
    364b:	66 90                	xchg   %ax,%ax
    364d:	66 90                	xchg   %ax,%ax
    364f:	90                   	nop

00003650 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3650:	55                   	push   %ebp
    3651:	89 e5                	mov    %esp,%ebp
    3653:	8b 45 08             	mov    0x8(%ebp),%eax
    3656:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    3659:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    365a:	89 c2                	mov    %eax,%edx
    365c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3660:	83 c1 01             	add    $0x1,%ecx
    3663:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3667:	83 c2 01             	add    $0x1,%edx
    366a:	84 db                	test   %bl,%bl
    366c:	88 5a ff             	mov    %bl,-0x1(%edx)
    366f:	75 ef                	jne    3660 <strcpy+0x10>
    ;
  return os;
}
    3671:	5b                   	pop    %ebx
    3672:	5d                   	pop    %ebp
    3673:	c3                   	ret    
    3674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    367a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003680 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	8b 55 08             	mov    0x8(%ebp),%edx
    3686:	53                   	push   %ebx
    3687:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    368a:	0f b6 02             	movzbl (%edx),%eax
    368d:	84 c0                	test   %al,%al
    368f:	74 2d                	je     36be <strcmp+0x3e>
    3691:	0f b6 19             	movzbl (%ecx),%ebx
    3694:	38 d8                	cmp    %bl,%al
    3696:	74 0e                	je     36a6 <strcmp+0x26>
    3698:	eb 2b                	jmp    36c5 <strcmp+0x45>
    369a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36a0:	38 c8                	cmp    %cl,%al
    36a2:	75 15                	jne    36b9 <strcmp+0x39>
    p++, q++;
    36a4:	89 d9                	mov    %ebx,%ecx
    36a6:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36a9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    36ac:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36af:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
    36b3:	84 c0                	test   %al,%al
    36b5:	75 e9                	jne    36a0 <strcmp+0x20>
    36b7:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    36b9:	29 c8                	sub    %ecx,%eax
}
    36bb:	5b                   	pop    %ebx
    36bc:	5d                   	pop    %ebp
    36bd:	c3                   	ret    
    36be:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36c1:	31 c0                	xor    %eax,%eax
    36c3:	eb f4                	jmp    36b9 <strcmp+0x39>
    36c5:	0f b6 cb             	movzbl %bl,%ecx
    36c8:	eb ef                	jmp    36b9 <strcmp+0x39>
    36ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000036d0 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
    36d0:	55                   	push   %ebp
    36d1:	89 e5                	mov    %esp,%ebp
    36d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    36d6:	80 39 00             	cmpb   $0x0,(%ecx)
    36d9:	74 12                	je     36ed <strlen+0x1d>
    36db:	31 d2                	xor    %edx,%edx
    36dd:	8d 76 00             	lea    0x0(%esi),%esi
    36e0:	83 c2 01             	add    $0x1,%edx
    36e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    36e7:	89 d0                	mov    %edx,%eax
    36e9:	75 f5                	jne    36e0 <strlen+0x10>
    ;
  return n;
}
    36eb:	5d                   	pop    %ebp
    36ec:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    36ed:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    36ef:	5d                   	pop    %ebp
    36f0:	c3                   	ret    
    36f1:	eb 0d                	jmp    3700 <memset>
    36f3:	90                   	nop
    36f4:	90                   	nop
    36f5:	90                   	nop
    36f6:	90                   	nop
    36f7:	90                   	nop
    36f8:	90                   	nop
    36f9:	90                   	nop
    36fa:	90                   	nop
    36fb:	90                   	nop
    36fc:	90                   	nop
    36fd:	90                   	nop
    36fe:	90                   	nop
    36ff:	90                   	nop

00003700 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3700:	55                   	push   %ebp
    3701:	89 e5                	mov    %esp,%ebp
    3703:	8b 55 08             	mov    0x8(%ebp),%edx
    3706:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3707:	8b 4d 10             	mov    0x10(%ebp),%ecx
    370a:	8b 45 0c             	mov    0xc(%ebp),%eax
    370d:	89 d7                	mov    %edx,%edi
    370f:	fc                   	cld    
    3710:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3712:	89 d0                	mov    %edx,%eax
    3714:	5f                   	pop    %edi
    3715:	5d                   	pop    %ebp
    3716:	c3                   	ret    
    3717:	89 f6                	mov    %esi,%esi
    3719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003720 <strchr>:

char*
strchr(const char *s, char c)
{
    3720:	55                   	push   %ebp
    3721:	89 e5                	mov    %esp,%ebp
    3723:	8b 45 08             	mov    0x8(%ebp),%eax
    3726:	53                   	push   %ebx
    3727:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
    372a:	0f b6 18             	movzbl (%eax),%ebx
    372d:	84 db                	test   %bl,%bl
    372f:	74 1d                	je     374e <strchr+0x2e>
    if(*s == c)
    3731:	38 d3                	cmp    %dl,%bl
    3733:	89 d1                	mov    %edx,%ecx
    3735:	75 0d                	jne    3744 <strchr+0x24>
    3737:	eb 17                	jmp    3750 <strchr+0x30>
    3739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3740:	38 ca                	cmp    %cl,%dl
    3742:	74 0c                	je     3750 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3744:	83 c0 01             	add    $0x1,%eax
    3747:	0f b6 10             	movzbl (%eax),%edx
    374a:	84 d2                	test   %dl,%dl
    374c:	75 f2                	jne    3740 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    374e:	31 c0                	xor    %eax,%eax
}
    3750:	5b                   	pop    %ebx
    3751:	5d                   	pop    %ebp
    3752:	c3                   	ret    
    3753:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003760 <gets>:

char*
gets(char *buf, int max)
{
    3760:	55                   	push   %ebp
    3761:	89 e5                	mov    %esp,%ebp
    3763:	57                   	push   %edi
    3764:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3765:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
    3767:	53                   	push   %ebx
    3768:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    376b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    376e:	eb 31                	jmp    37a1 <gets+0x41>
    cc = read(0, &c, 1);
    3770:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3777:	00 
    3778:	89 7c 24 04          	mov    %edi,0x4(%esp)
    377c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3783:	e8 02 01 00 00       	call   388a <read>
    if(cc < 1)
    3788:	85 c0                	test   %eax,%eax
    378a:	7e 1d                	jle    37a9 <gets+0x49>
      break;
    buf[i++] = c;
    378c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3790:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    3792:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
    3795:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    3797:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    379b:	74 0c                	je     37a9 <gets+0x49>
    379d:	3c 0a                	cmp    $0xa,%al
    379f:	74 08                	je     37a9 <gets+0x49>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    37a1:	8d 5e 01             	lea    0x1(%esi),%ebx
    37a4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37a7:	7c c7                	jl     3770 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    37a9:	8b 45 08             	mov    0x8(%ebp),%eax
    37ac:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    37b0:	83 c4 2c             	add    $0x2c,%esp
    37b3:	5b                   	pop    %ebx
    37b4:	5e                   	pop    %esi
    37b5:	5f                   	pop    %edi
    37b6:	5d                   	pop    %ebp
    37b7:	c3                   	ret    
    37b8:	90                   	nop
    37b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000037c0 <stat>:

int
stat(const char *n, struct stat *st)
{
    37c0:	55                   	push   %ebp
    37c1:	89 e5                	mov    %esp,%ebp
    37c3:	56                   	push   %esi
    37c4:	53                   	push   %ebx
    37c5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    37c8:	8b 45 08             	mov    0x8(%ebp),%eax
    37cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    37d2:	00 
    37d3:	89 04 24             	mov    %eax,(%esp)
    37d6:	e8 d7 00 00 00       	call   38b2 <open>
  if(fd < 0)
    37db:	85 c0                	test   %eax,%eax
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    37dd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    37df:	78 27                	js     3808 <stat+0x48>
    return -1;
  r = fstat(fd, st);
    37e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    37e4:	89 1c 24             	mov    %ebx,(%esp)
    37e7:	89 44 24 04          	mov    %eax,0x4(%esp)
    37eb:	e8 da 00 00 00       	call   38ca <fstat>
  close(fd);
    37f0:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    37f3:	89 c6                	mov    %eax,%esi
  close(fd);
    37f5:	e8 a0 00 00 00       	call   389a <close>
  return r;
    37fa:	89 f0                	mov    %esi,%eax
}
    37fc:	83 c4 10             	add    $0x10,%esp
    37ff:	5b                   	pop    %ebx
    3800:	5e                   	pop    %esi
    3801:	5d                   	pop    %ebp
    3802:	c3                   	ret    
    3803:	90                   	nop
    3804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    3808:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    380d:	eb ed                	jmp    37fc <stat+0x3c>
    380f:	90                   	nop

00003810 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3810:	55                   	push   %ebp
    3811:	89 e5                	mov    %esp,%ebp
    3813:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3816:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3817:	0f be 11             	movsbl (%ecx),%edx
    381a:	8d 42 d0             	lea    -0x30(%edx),%eax
    381d:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
    381f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    3824:	77 17                	ja     383d <atoi+0x2d>
    3826:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3828:	83 c1 01             	add    $0x1,%ecx
    382b:	8d 04 80             	lea    (%eax,%eax,4),%eax
    382e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3832:	0f be 11             	movsbl (%ecx),%edx
    3835:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3838:	80 fb 09             	cmp    $0x9,%bl
    383b:	76 eb                	jbe    3828 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    383d:	5b                   	pop    %ebx
    383e:	5d                   	pop    %ebp
    383f:	c3                   	ret    

00003840 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3840:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3841:	31 d2                	xor    %edx,%edx
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3843:	89 e5                	mov    %esp,%ebp
    3845:	56                   	push   %esi
    3846:	8b 45 08             	mov    0x8(%ebp),%eax
    3849:	53                   	push   %ebx
    384a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    384d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3850:	85 db                	test   %ebx,%ebx
    3852:	7e 12                	jle    3866 <memmove+0x26>
    3854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    3858:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    385c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    385f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3862:	39 da                	cmp    %ebx,%edx
    3864:	75 f2                	jne    3858 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    3866:	5b                   	pop    %ebx
    3867:	5e                   	pop    %esi
    3868:	5d                   	pop    %ebp
    3869:	c3                   	ret    

0000386a <fork>:
    386a:	b8 01 00 00 00       	mov    $0x1,%eax
    386f:	cd 40                	int    $0x40
    3871:	c3                   	ret    

00003872 <exit>:
    3872:	b8 02 00 00 00       	mov    $0x2,%eax
    3877:	cd 40                	int    $0x40
    3879:	c3                   	ret    

0000387a <wait>:
    387a:	b8 03 00 00 00       	mov    $0x3,%eax
    387f:	cd 40                	int    $0x40
    3881:	c3                   	ret    

00003882 <pipe>:
    3882:	b8 04 00 00 00       	mov    $0x4,%eax
    3887:	cd 40                	int    $0x40
    3889:	c3                   	ret    

0000388a <read>:
    388a:	b8 05 00 00 00       	mov    $0x5,%eax
    388f:	cd 40                	int    $0x40
    3891:	c3                   	ret    

00003892 <write>:
    3892:	b8 10 00 00 00       	mov    $0x10,%eax
    3897:	cd 40                	int    $0x40
    3899:	c3                   	ret    

0000389a <close>:
    389a:	b8 15 00 00 00       	mov    $0x15,%eax
    389f:	cd 40                	int    $0x40
    38a1:	c3                   	ret    

000038a2 <kill>:
    38a2:	b8 06 00 00 00       	mov    $0x6,%eax
    38a7:	cd 40                	int    $0x40
    38a9:	c3                   	ret    

000038aa <exec>:
    38aa:	b8 07 00 00 00       	mov    $0x7,%eax
    38af:	cd 40                	int    $0x40
    38b1:	c3                   	ret    

000038b2 <open>:
    38b2:	b8 0f 00 00 00       	mov    $0xf,%eax
    38b7:	cd 40                	int    $0x40
    38b9:	c3                   	ret    

000038ba <mknod>:
    38ba:	b8 11 00 00 00       	mov    $0x11,%eax
    38bf:	cd 40                	int    $0x40
    38c1:	c3                   	ret    

000038c2 <unlink>:
    38c2:	b8 12 00 00 00       	mov    $0x12,%eax
    38c7:	cd 40                	int    $0x40
    38c9:	c3                   	ret    

000038ca <fstat>:
    38ca:	b8 08 00 00 00       	mov    $0x8,%eax
    38cf:	cd 40                	int    $0x40
    38d1:	c3                   	ret    

000038d2 <link>:
    38d2:	b8 13 00 00 00       	mov    $0x13,%eax
    38d7:	cd 40                	int    $0x40
    38d9:	c3                   	ret    

000038da <mkdir>:
    38da:	b8 14 00 00 00       	mov    $0x14,%eax
    38df:	cd 40                	int    $0x40
    38e1:	c3                   	ret    

000038e2 <chdir>:
    38e2:	b8 09 00 00 00       	mov    $0x9,%eax
    38e7:	cd 40                	int    $0x40
    38e9:	c3                   	ret    

000038ea <dup>:
    38ea:	b8 0a 00 00 00       	mov    $0xa,%eax
    38ef:	cd 40                	int    $0x40
    38f1:	c3                   	ret    

000038f2 <getpid>:
    38f2:	b8 0b 00 00 00       	mov    $0xb,%eax
    38f7:	cd 40                	int    $0x40
    38f9:	c3                   	ret    

000038fa <sbrk>:
    38fa:	b8 0c 00 00 00       	mov    $0xc,%eax
    38ff:	cd 40                	int    $0x40
    3901:	c3                   	ret    

00003902 <sleep>:
    3902:	b8 0d 00 00 00       	mov    $0xd,%eax
    3907:	cd 40                	int    $0x40
    3909:	c3                   	ret    

0000390a <uptime>:
    390a:	b8 0e 00 00 00       	mov    $0xe,%eax
    390f:	cd 40                	int    $0x40
    3911:	c3                   	ret    
    3912:	66 90                	xchg   %ax,%ax
    3914:	66 90                	xchg   %ax,%ax
    3916:	66 90                	xchg   %ax,%ax
    3918:	66 90                	xchg   %ax,%ax
    391a:	66 90                	xchg   %ax,%ax
    391c:	66 90                	xchg   %ax,%ax
    391e:	66 90                	xchg   %ax,%ax

00003920 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3920:	55                   	push   %ebp
    3921:	89 e5                	mov    %esp,%ebp
    3923:	57                   	push   %edi
    3924:	56                   	push   %esi
    3925:	89 c6                	mov    %eax,%esi
    3927:	53                   	push   %ebx
    3928:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    392b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    392e:	85 db                	test   %ebx,%ebx
    3930:	74 09                	je     393b <printint+0x1b>
    3932:	89 d0                	mov    %edx,%eax
    3934:	c1 e8 1f             	shr    $0x1f,%eax
    3937:	84 c0                	test   %al,%al
    3939:	75 75                	jne    39b0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    393b:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    393d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3944:	89 75 c0             	mov    %esi,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    3947:	31 ff                	xor    %edi,%edi
    3949:	89 ce                	mov    %ecx,%esi
    394b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    394e:	eb 02                	jmp    3952 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
    3950:	89 cf                	mov    %ecx,%edi
    3952:	31 d2                	xor    %edx,%edx
    3954:	f7 f6                	div    %esi
    3956:	8d 4f 01             	lea    0x1(%edi),%ecx
    3959:	0f b6 92 d7 54 00 00 	movzbl 0x54d7(%edx),%edx
  }while((x /= base) != 0);
    3960:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3962:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    3965:	75 e9                	jne    3950 <printint+0x30>
  if(neg)
    3967:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    396a:	89 c8                	mov    %ecx,%eax
    396c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  }while((x /= base) != 0);
  if(neg)
    396f:	85 d2                	test   %edx,%edx
    3971:	74 08                	je     397b <printint+0x5b>
    buf[i++] = '-';
    3973:	8d 4f 02             	lea    0x2(%edi),%ecx
    3976:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
    397b:	8d 79 ff             	lea    -0x1(%ecx),%edi
    397e:	66 90                	xchg   %ax,%ax
    3980:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
    3985:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3988:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    398f:	00 
    3990:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    3994:	89 34 24             	mov    %esi,(%esp)
    3997:	88 45 d7             	mov    %al,-0x29(%ebp)
    399a:	e8 f3 fe ff ff       	call   3892 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    399f:	83 ff ff             	cmp    $0xffffffff,%edi
    39a2:	75 dc                	jne    3980 <printint+0x60>
    putc(fd, buf[i]);
}
    39a4:	83 c4 4c             	add    $0x4c,%esp
    39a7:	5b                   	pop    %ebx
    39a8:	5e                   	pop    %esi
    39a9:	5f                   	pop    %edi
    39aa:	5d                   	pop    %ebp
    39ab:	c3                   	ret    
    39ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    39b0:	89 d0                	mov    %edx,%eax
    39b2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    39b4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    39bb:	eb 87                	jmp    3944 <printint+0x24>
    39bd:	8d 76 00             	lea    0x0(%esi),%esi

000039c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    39c0:	55                   	push   %ebp
    39c1:	89 e5                	mov    %esp,%ebp
    39c3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    39c4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    39c6:	56                   	push   %esi
    39c7:	53                   	push   %ebx
    39c8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    39cb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    39ce:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    39d1:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    39d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    39d7:	0f b6 13             	movzbl (%ebx),%edx
    39da:	83 c3 01             	add    $0x1,%ebx
    39dd:	84 d2                	test   %dl,%dl
    39df:	75 39                	jne    3a1a <printf+0x5a>
    39e1:	e9 c2 00 00 00       	jmp    3aa8 <printf+0xe8>
    39e6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    39e8:	83 fa 25             	cmp    $0x25,%edx
    39eb:	0f 84 bf 00 00 00    	je     3ab0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    39f1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    39f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    39fb:	00 
    39fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a00:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    3a03:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a06:	e8 87 fe ff ff       	call   3892 <write>
    3a0b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a0e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3a12:	84 d2                	test   %dl,%dl
    3a14:	0f 84 8e 00 00 00    	je     3aa8 <printf+0xe8>
    c = fmt[i] & 0xff;
    if(state == 0){
    3a1a:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    3a1c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
    3a1f:	74 c7                	je     39e8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3a21:	83 ff 25             	cmp    $0x25,%edi
    3a24:	75 e5                	jne    3a0b <printf+0x4b>
      if(c == 'd'){
    3a26:	83 fa 64             	cmp    $0x64,%edx
    3a29:	0f 84 31 01 00 00    	je     3b60 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3a2f:	25 f7 00 00 00       	and    $0xf7,%eax
    3a34:	83 f8 70             	cmp    $0x70,%eax
    3a37:	0f 84 83 00 00 00    	je     3ac0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3a3d:	83 fa 73             	cmp    $0x73,%edx
    3a40:	0f 84 a2 00 00 00    	je     3ae8 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3a46:	83 fa 63             	cmp    $0x63,%edx
    3a49:	0f 84 35 01 00 00    	je     3b84 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3a4f:	83 fa 25             	cmp    $0x25,%edx
    3a52:	0f 84 e0 00 00 00    	je     3b38 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a58:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3a5b:	83 c3 01             	add    $0x1,%ebx
    3a5e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3a65:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3a66:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a68:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a6c:	89 34 24             	mov    %esi,(%esp)
    3a6f:	89 55 d0             	mov    %edx,-0x30(%ebp)
    3a72:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
    3a76:	e8 17 fe ff ff       	call   3892 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3a7b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a7e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3a81:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3a88:	00 
    3a89:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a8d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3a90:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a93:	e8 fa fd ff ff       	call   3892 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a98:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3a9c:	84 d2                	test   %dl,%dl
    3a9e:	0f 85 76 ff ff ff    	jne    3a1a <printf+0x5a>
    3aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3aa8:	83 c4 3c             	add    $0x3c,%esp
    3aab:	5b                   	pop    %ebx
    3aac:	5e                   	pop    %esi
    3aad:	5f                   	pop    %edi
    3aae:	5d                   	pop    %ebp
    3aaf:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3ab0:	bf 25 00 00 00       	mov    $0x25,%edi
    3ab5:	e9 51 ff ff ff       	jmp    3a0b <printf+0x4b>
    3aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3ac0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3ac3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3ac8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3aca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3ad1:	8b 10                	mov    (%eax),%edx
    3ad3:	89 f0                	mov    %esi,%eax
    3ad5:	e8 46 fe ff ff       	call   3920 <printint>
        ap++;
    3ada:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3ade:	e9 28 ff ff ff       	jmp    3a0b <printf+0x4b>
    3ae3:	90                   	nop
    3ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    3ae8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
    3aeb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    3aef:	8b 38                	mov    (%eax),%edi
        ap++;
        if(s == 0)
          s = "(null)";
    3af1:	b8 d0 54 00 00       	mov    $0x54d0,%eax
    3af6:	85 ff                	test   %edi,%edi
    3af8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
    3afb:	0f b6 07             	movzbl (%edi),%eax
    3afe:	84 c0                	test   %al,%al
    3b00:	74 2a                	je     3b2c <printf+0x16c>
    3b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3b08:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b0b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3b0e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b11:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3b18:	00 
    3b19:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b1d:	89 34 24             	mov    %esi,(%esp)
    3b20:	e8 6d fd ff ff       	call   3892 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3b25:	0f b6 07             	movzbl (%edi),%eax
    3b28:	84 c0                	test   %al,%al
    3b2a:	75 dc                	jne    3b08 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b2c:	31 ff                	xor    %edi,%edi
    3b2e:	e9 d8 fe ff ff       	jmp    3a0b <printf+0x4b>
    3b33:	90                   	nop
    3b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b38:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b3b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b3d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3b44:	00 
    3b45:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b49:	89 34 24             	mov    %esi,(%esp)
    3b4c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
    3b50:	e8 3d fd ff ff       	call   3892 <write>
    3b55:	e9 b1 fe ff ff       	jmp    3a0b <printf+0x4b>
    3b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3b60:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3b63:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b68:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3b6b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b72:	8b 10                	mov    (%eax),%edx
    3b74:	89 f0                	mov    %esi,%eax
    3b76:	e8 a5 fd ff ff       	call   3920 <printint>
        ap++;
    3b7b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3b7f:	e9 87 fe ff ff       	jmp    3a0b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3b84:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b87:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3b89:	8b 00                	mov    (%eax),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b8b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3b92:	00 
    3b93:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3b96:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b99:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3b9c:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ba0:	e8 ed fc ff ff       	call   3892 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    3ba5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3ba9:	e9 5d fe ff ff       	jmp    3a0b <printf+0x4b>
    3bae:	66 90                	xchg   %ax,%ax

00003bb0 <free>:
    3bb0:	55                   	push   %ebp
    3bb1:	a1 80 5e 00 00       	mov    0x5e80,%eax
    3bb6:	89 e5                	mov    %esp,%ebp
    3bb8:	57                   	push   %edi
    3bb9:	56                   	push   %esi
    3bba:	53                   	push   %ebx
    3bbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3bbe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    3bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bc8:	39 c8                	cmp    %ecx,%eax
    3bca:	8b 10                	mov    (%eax),%edx
    3bcc:	73 32                	jae    3c00 <free+0x50>
    3bce:	39 d1                	cmp    %edx,%ecx
    3bd0:	72 04                	jb     3bd6 <free+0x26>
    3bd2:	39 d0                	cmp    %edx,%eax
    3bd4:	72 32                	jb     3c08 <free+0x58>
    3bd6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3bd9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bdc:	39 fa                	cmp    %edi,%edx
    3bde:	74 30                	je     3c10 <free+0x60>
    3be0:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3be3:	8b 50 04             	mov    0x4(%eax),%edx
    3be6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3be9:	39 f1                	cmp    %esi,%ecx
    3beb:	74 3a                	je     3c27 <free+0x77>
    3bed:	89 08                	mov    %ecx,(%eax)
    3bef:	a3 80 5e 00 00       	mov    %eax,0x5e80
    3bf4:	5b                   	pop    %ebx
    3bf5:	5e                   	pop    %esi
    3bf6:	5f                   	pop    %edi
    3bf7:	5d                   	pop    %ebp
    3bf8:	c3                   	ret    
    3bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c00:	39 d0                	cmp    %edx,%eax
    3c02:	72 04                	jb     3c08 <free+0x58>
    3c04:	39 d1                	cmp    %edx,%ecx
    3c06:	72 ce                	jb     3bd6 <free+0x26>
    3c08:	89 d0                	mov    %edx,%eax
    3c0a:	eb bc                	jmp    3bc8 <free+0x18>
    3c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c10:	03 72 04             	add    0x4(%edx),%esi
    3c13:	89 73 fc             	mov    %esi,-0x4(%ebx)
    3c16:	8b 10                	mov    (%eax),%edx
    3c18:	8b 12                	mov    (%edx),%edx
    3c1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3c1d:	8b 50 04             	mov    0x4(%eax),%edx
    3c20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c23:	39 f1                	cmp    %esi,%ecx
    3c25:	75 c6                	jne    3bed <free+0x3d>
    3c27:	03 53 fc             	add    -0x4(%ebx),%edx
    3c2a:	a3 80 5e 00 00       	mov    %eax,0x5e80
    3c2f:	89 50 04             	mov    %edx,0x4(%eax)
    3c32:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3c35:	89 10                	mov    %edx,(%eax)
    3c37:	5b                   	pop    %ebx
    3c38:	5e                   	pop    %esi
    3c39:	5f                   	pop    %edi
    3c3a:	5d                   	pop    %ebp
    3c3b:	c3                   	ret    
    3c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003c40 <malloc>:
    3c40:	55                   	push   %ebp
    3c41:	89 e5                	mov    %esp,%ebp
    3c43:	57                   	push   %edi
    3c44:	56                   	push   %esi
    3c45:	53                   	push   %ebx
    3c46:	83 ec 0c             	sub    $0xc,%esp
    3c49:	8b 45 08             	mov    0x8(%ebp),%eax
    3c4c:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
    3c52:	8d 78 07             	lea    0x7(%eax),%edi
    3c55:	c1 ef 03             	shr    $0x3,%edi
    3c58:	83 c7 01             	add    $0x1,%edi
    3c5b:	85 d2                	test   %edx,%edx
    3c5d:	0f 84 9d 00 00 00    	je     3d00 <malloc+0xc0>
    3c63:	8b 02                	mov    (%edx),%eax
    3c65:	8b 48 04             	mov    0x4(%eax),%ecx
    3c68:	39 cf                	cmp    %ecx,%edi
    3c6a:	76 6c                	jbe    3cd8 <malloc+0x98>
    3c6c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3c72:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3c77:	0f 43 df             	cmovae %edi,%ebx
    3c7a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3c81:	eb 0e                	jmp    3c91 <malloc+0x51>
    3c83:	90                   	nop
    3c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c88:	8b 02                	mov    (%edx),%eax
    3c8a:	8b 48 04             	mov    0x4(%eax),%ecx
    3c8d:	39 f9                	cmp    %edi,%ecx
    3c8f:	73 47                	jae    3cd8 <malloc+0x98>
    3c91:	39 05 80 5e 00 00    	cmp    %eax,0x5e80
    3c97:	89 c2                	mov    %eax,%edx
    3c99:	75 ed                	jne    3c88 <malloc+0x48>
    3c9b:	83 ec 0c             	sub    $0xc,%esp
    3c9e:	56                   	push   %esi
    3c9f:	e8 56 fc ff ff       	call   38fa <sbrk>
    3ca4:	83 c4 10             	add    $0x10,%esp
    3ca7:	83 f8 ff             	cmp    $0xffffffff,%eax
    3caa:	74 1c                	je     3cc8 <malloc+0x88>
    3cac:	89 58 04             	mov    %ebx,0x4(%eax)
    3caf:	83 ec 0c             	sub    $0xc,%esp
    3cb2:	83 c0 08             	add    $0x8,%eax
    3cb5:	50                   	push   %eax
    3cb6:	e8 f5 fe ff ff       	call   3bb0 <free>
    3cbb:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
    3cc1:	83 c4 10             	add    $0x10,%esp
    3cc4:	85 d2                	test   %edx,%edx
    3cc6:	75 c0                	jne    3c88 <malloc+0x48>
    3cc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3ccb:	31 c0                	xor    %eax,%eax
    3ccd:	5b                   	pop    %ebx
    3cce:	5e                   	pop    %esi
    3ccf:	5f                   	pop    %edi
    3cd0:	5d                   	pop    %ebp
    3cd1:	c3                   	ret    
    3cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3cd8:	39 cf                	cmp    %ecx,%edi
    3cda:	74 54                	je     3d30 <malloc+0xf0>
    3cdc:	29 f9                	sub    %edi,%ecx
    3cde:	89 48 04             	mov    %ecx,0x4(%eax)
    3ce1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    3ce4:	89 78 04             	mov    %edi,0x4(%eax)
    3ce7:	89 15 80 5e 00 00    	mov    %edx,0x5e80
    3ced:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3cf0:	83 c0 08             	add    $0x8,%eax
    3cf3:	5b                   	pop    %ebx
    3cf4:	5e                   	pop    %esi
    3cf5:	5f                   	pop    %edi
    3cf6:	5d                   	pop    %ebp
    3cf7:	c3                   	ret    
    3cf8:	90                   	nop
    3cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d00:	c7 05 80 5e 00 00 84 	movl   $0x5e84,0x5e80
    3d07:	5e 00 00 
    3d0a:	c7 05 84 5e 00 00 84 	movl   $0x5e84,0x5e84
    3d11:	5e 00 00 
    3d14:	b8 84 5e 00 00       	mov    $0x5e84,%eax
    3d19:	c7 05 88 5e 00 00 00 	movl   $0x0,0x5e88
    3d20:	00 00 00 
    3d23:	e9 44 ff ff ff       	jmp    3c6c <malloc+0x2c>
    3d28:	90                   	nop
    3d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d30:	8b 08                	mov    (%eax),%ecx
    3d32:	89 0a                	mov    %ecx,(%edx)
    3d34:	eb b1                	jmp    3ce7 <malloc+0xa7>
