Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2511CCF4A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 May 2020 03:54:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8DB0511A6E152;
	Sun, 10 May 2020 18:51:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=<UNKNOWN> 
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E72ED11A6E150
	for <linux-nvdimm@lists.01.org>; Sun, 10 May 2020 18:51:45 -0700 (PDT)
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04B1s4SB001071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2020 21:54:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
	id 315364202E4; Sun, 10 May 2020 21:54:04 -0400 (EDT)
Date: Sun, 10 May 2020 21:54:04 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: linux-nvdimm@lists.01.org
Subject: How to fake a dax device for debugging purposes?
Message-ID: <20200511015404.GA1490816@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
Message-ID-Hash: LRPMR4S6IOQJNUEZISWYTOBAPLUQ33MH
X-Message-ID-Hash: LRPMR4S6IOQJNUEZISWYTOBAPLUQ33MH
X-MailFrom: tytso@mit.edu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LRPMR4S6IOQJNUEZISWYTOBAPLUQ33MH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

(Please keep me on the cc line since I'm not okn the linux-nvdimm list.)

Hi,

I used to fake up a dax-capable device for debugging ext4 by using
instructions similar to the ones that can be found here:

https://docs.pmem.io/persistent-memory/getting-started-guide/creating-development-environments/linux-environments/linux-memmap

The problem is that with more recent kernels, this is no longer
working for me.

Here are the relevant dmesg lines (from running "gce-xfstests -c dax
launch"):

[    0.000000] Linux version 5.7.0-rc4-xfstests-00002-g8867a85a3164-dirty (tytso@lambda) (gcc version 9.3.0 (Debian 9.3.0-11), GNU ld (GNU Binutils for Debian) 2.34) #1692 SMP Sun May 10 21:21:14 EDT 2020
[    0.000000] Command line: root=/dev/sda1 ro console=ttyS0,38400n8 elevator=noop net.ifnames=0 biosdevname=0 console=ttyS0 memmap=4G!9G memmap=9G!14G cmd=maint mem=26624M fstestcfg= fstestset= fstestexc= fstestopt= fstesttyp=ext4 fstestapi=1.5 fsteststr= nfssrv=
       ...
[    0.000000] user: [mem 0x0000000240000000-0x000000033fffffff] persistent (type 12)
[    0.000000] user: [mem 0x0000000340000000-0x000000037fffffff] usable
[    0.000000] user: [mem 0x0000000380000000-0x00000005bfffffff] persistent (type 12)
[    0.000000] user: [mem 0x00000005c0000000-0x000000067fffffff] usable
    ....
[    3.180904] nd_pmem namespace0.0: unable to guarantee persistence of writes
[    3.181750] nd_pmem namespace1.0: unable to guarantee persistence of writes
[    3.188025] pmem0: detected capacity change from 0 to 4294967296
[    3.189896] pmem1: detected capacity change from 0 to 9663676416

But when I try to mount a file system with: "mount -o dax -t ext4 /dev/pmem0 /mnt" I get:

[  168.136331] EXT4-fs (pmem0): DAX unsupported by block device.

Looking at drivers/dax/super.c, and changing a bunch of pr_debug to
pr_err, I found the following had triggered.

[  168.130603] pmem0: error: request queue doesn't support dax

So looks like drivers/nvdimm/pmem.c is failing to set QUEUE_FLAG_DAX
flag on its queue, and so in turn that's because pmem->pfn_flags
doesn't have PFN_MAP set.   And.... at that point, I'm lost.

How do I make a /dev/pmem0 via the memmap= boot command line options
be mountable as a dax mount file system?

							- Ted
							
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
