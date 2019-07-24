Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D316D72BA0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jul 2019 11:43:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC129212DA5E0;
	Wed, 24 Jul 2019 02:45:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=jencce.kernel@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7435D212DA5D2
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 02:45:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i2so21814739plt.1
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=w4BqOW5YG+Bx/+VkSCqIJQs8GHz1Um7+vVf8YuzOemQ=;
 b=A1S6Uh99xohjYjut+5YhRX9lQcLWnQHQCTLPHEuXUGukqIA8oYIFTXkppohvjxHYQz
 x3ocsLiwN+bvSPLElRBCr7/7mZ3LouQK68A3Bh8kbSFSTXrY8U+7Ffp5Kr/Aq/Adnr5+
 2JYvMw5xkYsReTQ914aceJAVrhnRtJnuGTePe3saJLQ7iV10DhjEwIFikVOOGVBlnBpJ
 +pGBkT9pglQWeCVy6HR5gMBOBhYbIRqCGdGYHrrAkQwb9fGW+57IlXg/MPF3SiCFEeHG
 QlEcb6L6jM5qP/8iAgZbwFc/i8G29qjnlA8CVVBJZZqpm3CZBedGEFwfWQY+9D2JWn6S
 q0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=w4BqOW5YG+Bx/+VkSCqIJQs8GHz1Um7+vVf8YuzOemQ=;
 b=L4CFUlsMclJbXYczBT58MLVWhTVndtolJNUj+pOlHV9xE5ZYSWdfCrHd+gI9ulHkvR
 0eJJxmtV4v1/EDzMYXopJmc/nSZIiQMeDQs7qjKYUY+jCC45DPqsWMuTfBpVXqcIIMkV
 qAsvBCXeCGPuuIgW2cJps24HrT9CtsoPart238qioYesnmcHhJFee2l624a0Fgio85VO
 aGay9LI0eYlYOk1goUuK8aK8nbTfU00FQpmEirWRFWXsDjs7Zj+7s7HqZU0eHdeAWhNG
 eXnBH1RlvVlhahcrfPvc8XOukEHnAUKMTwiMqdi+sJ89NPEczGXFXSXAeXr9lQOVjfls
 96SQ==
X-Gm-Message-State: APjAAAW0N/3uIg7IWUNCKKXrUDxPya3gekyGmyWDQUuxyAXCU2pPz/g+
 iQ3oDUV1JTfJffFhPOr4HN8=
X-Google-Smtp-Source: APXvYqymvcFLwvWfaFG/ZfibSN2sD1Eyvved7KeFgVjkzhTn9AjffyocKJKyhkqYbLwNoqc3sEVTVg==
X-Received: by 2002:a17:902:e30d:: with SMTP id
 cg13mr84550323plb.173.1563961405821; 
 Wed, 24 Jul 2019 02:43:25 -0700 (PDT)
Received: from localhost ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m4sm56460629pgs.71.2019.07.24.02.43.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 02:43:25 -0700 (PDT)
Date: Wed, 24 Jul 2019 17:43:17 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: xfs quota test xfs/050 fails with dax mount option and "-d
 su=2m,sw=1" mkfs option
Message-ID: <20190724094317.4yjm4smk2z47cwmv@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi,

As subject.

-d su=2m,sw=1     && -o dax  fail
-d su=2m,sw=1     && NO dax  pass
no su mkfs option && -o dax  pass
no su mkfs option && NO dax  pass

On latest Linus tree. Reproduce every time.

Testing on older kernels are going on to see if it's a regression.

Is this failure expected ?

Thanks,
M

# fail with 2m su mkfs option and dax mount option:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 7u 5.3.0-rc1-master-ad5e427+ #126 SMP Wed Jul 24 14:46:09 CST 2019
MKFS_OPTIONS  -- -f -f -b size=4096 -d su=2m,sw=1 /dev/pmem1
MOUNT_OPTIONS -- -o dax -o context=system_u:object_r:root_t:s0 /dev/pmem1 /test1

xfs/050 4s ...  [05:30:52] [05:30:56]- output mismatch (see /root/xfstests-dev/results//xfs/050.out.bad)
    --- tests/xfs/050.out       2019-05-07 02:34:03.391107482 -0400
    +++ /root/xfstests-dev/results//xfs/050.out.bad     2019-07-24 05:30:56.483044548 -0400
    @@ -29,6 +29,7 @@
     *** push past the hard block limit (expect EDQUOT)
     [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
     [NAME] =OK= 200 1000 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
    + URK 99: 2097152 is out of range! [3481600,4096000]

     *** unmount
     *** group
    ...
    (Run 'diff -u /root/xfstests-dev/tests/xfs/050.out /root/xfstests-dev/results//xfs/050.out.bad'  to see the entire diff)
Ran: xfs/050
Failures: xfs/050
Failed 1 of 1 tests

~
[root@7u ~]# diff -u /root/xfstests-dev/tests/xfs/050.out /root/xfstests-dev/results//xfs/050.out.bad
--- /root/xfstests-dev/tests/xfs/050.out        2019-05-07 02:34:03.391107482 -0400
+++ /root/xfstests-dev/results//xfs/050.out.bad 2019-07-24 05:30:56.483044548 -0400
@@ -29,6 +29,7 @@
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
 [NAME] =OK= 200 1000 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+ URK 99: 2097152 is out of range! [3481600,4096000]

 *** unmount
 *** group
@@ -61,6 +62,7 @@
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
 [NAME] =OK= 200 1000 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+ URK 99: 2097152 is out of range! [3481600,4096000]

 *** unmount
 *** uqnoenforce
@@ -157,6 +159,7 @@
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
 [NAME] =OK= 200 1000 0 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
+ URK 1: 2097152 is out of range! [3481600,4096000]

 *** unmount
 *** pqnoenforce


#Pass without dax:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 7u 5.3.0-rc1-master-ad5e427+ #126 SMP Wed Jul 24 14:46:09 CST 2019
MKFS_OPTIONS  -- -f -f -b size=4096 /dev/pmem1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/pmem1 /test1

xfs/050         [05:30:35] [05:30:39] 4s
Ran: xfs/050
Passed all 1 tests

#Pass without 2m su mkfs option and with dax option:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 7u 5.3.0-rc1-master-ad5e427+ #126 SMP Wed Jul 24 14:46:09 CST 2019
MKFS_OPTIONS  -- -f -f -b size=4096 /dev/pmem1
MOUNT_OPTIONS -- -o dax -o context=system_u:object_r:root_t:s0 /dev/pmem1 /test1

xfs/050 4s ...  [05:34:13] [05:34:17] 4s
Ran: xfs/050
Passed all 1 tests

# Pass with 2m su mkfs option and without dax mount option:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 7u 5.3.0-rc1-master-ad5e427+ #126 SMP Wed Jul 24 14:46:09 CST 2019
MKFS_OPTIONS  -- -f -f -b size=4096 -d su=2m,sw=1 /dev/pmem1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/pmem1 /test1

xfs/050 4s ...  [05:36:08] [05:36:12] 4s
Ran: xfs/050
Passed all 1 tests

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
