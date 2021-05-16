Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B493821FC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 01:14:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D8F28100EC1EB;
	Sun, 16 May 2021 16:14:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=fukuri.sai@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95D2E100EC1DA
	for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 16:14:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 22so3337446pfv.11
        for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1w8PCvrLVyRJVXoW9HTSK4I1VOm9sdjYz1UnXG8iwqs=;
        b=qmZwwUhZPDpUZhwAhYBvcT9MUVlA06LCnX4wtyrBbllTT3PZtJe3ajg1ynohcwmWDK
         EQU0TnOBOu7u+9IJQI4YfPsT6wngCE5eOtqMLcc6Eg2WjYrN3w4SY2m5rW6uW7Qv8Dys
         JxpLP6ZpwkLIgLwFOzH0cAFYqOilHgtrgdcn8flwEN+r0zQnk0CrTL3zGv0KLAr5/JR2
         G6JsOUjh8t5X7m0m2y5aj5i24PWVAGUHoOHco0LjRQZZ0vPO7c4iJkzVMNSQCQklVLS9
         AsMPhwcVs14r6PkDuDdLhk5Es7c7gHzZ1evXteyJuDu9LMqBi1mJTwzgmnvBTUVbeyJ4
         XJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1w8PCvrLVyRJVXoW9HTSK4I1VOm9sdjYz1UnXG8iwqs=;
        b=FMRnLxoMArSAEB+pOTkoWlpBmzeCUIuSee+NxjOJyOqkWPvii/y76yA3i0etJd2Ljr
         +/rtvI7vy1ZT0uJsVFaVQBzze/1BeoxMUB7yi6AbyKRwRO5Hi5Tbw01l6YNuTFYSuxS/
         VlnYrqZR/fLU8UJTObNEEcKZlRqUljnF+ntBLz8C2vGOb/4HZ2YBL0UiXnNS3uuXhHsz
         mG8SEZ+l4Ciy/Vw1gzO/b3vhseInHmj0F70IKYkvUyVRXsXXhrYw8E4v0xOKTw41rsfG
         2EnXv6k22jrJAwmRMxw6JuQWZpD/O4vLBkD4XgvSqM+3VfxHiYjQ23Ugjx2MrtgLXl1O
         dSYw==
X-Gm-Message-State: AOAM530sr326Mt1oDAtirQ8b3R8t8SawKTtenmI3nDelcDD6DdMKiVP0
	lRiyDoWY7BFlH+JNiIDg32+8KEuZXf9k2nlO
X-Google-Smtp-Source: ABdhPJxXCeZLzAuSUbVRtIX6gXPU7DSOL+8zzjmxGO2y8yutQBxr4NffZnDh3IgBPIFZ3IuEQ707yQ==
X-Received: by 2002:a63:4b43:: with SMTP id k3mr57538853pgl.450.1621206882997;
        Sun, 16 May 2021 16:14:42 -0700 (PDT)
Received: from localhost.localdomain (softbank126008227016.bbtec.net. [126.8.227.16])
        by smtp.gmail.com with ESMTPSA id c17sm9097890pgm.3.2021.05.16.16.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 16:14:42 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [RFC ndctl PATCH 0/3] Rename monitor.conf to ndctl.conf as a ndctl global config file
Date: Mon, 17 May 2021 08:14:24 +0900
Message-Id: <20210516231427.64162-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Message-ID-Hash: QLQSSII6YTSLKGDGTLP33SJOC74P6OM5
X-Message-ID-Hash: QLQSSII6YTSLKGDGTLP33SJOC74P6OM5
X-MailFrom: fukuri.sai@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QLQSSII6YTSLKGDGTLP33SJOC74P6OM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: QI Fuli <qi.fuli@fujitsu.com>

This patch set is to rename monitor.conf to ndctl.conf, and make it a
global ndctl configuration file that all ndctl commands can refer to.

As this patch set has been pending until now, I would like to know if
current idea works or not. If yes, I will finish the documents and test.

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>

QI Fuli (3):
  ndctl, ccan: import ciniparser
  ndctl, util: add parse-configs helper
  ndctl, rename monitor.conf to ndctl.conf

 Makefile.am                        |   8 +-
 ccan/ciniparser/ciniparser.c       | 480 +++++++++++++++++++++++++++++
 ccan/ciniparser/ciniparser.h       | 262 ++++++++++++++++
 ccan/ciniparser/dictionary.c       | 266 ++++++++++++++++
 ccan/ciniparser/dictionary.h       | 166 ++++++++++
 configure.ac                       |   8 +-
 ndctl/Makefile.am                  |   9 +-
 ndctl/monitor.c                    | 127 ++------
 ndctl/{monitor.conf => ndctl.conf} |  16 +-
 util/parse-configs.c               |  47 +++
 util/parse-configs.h               |  26 ++
 11 files changed, 1294 insertions(+), 121 deletions(-)
 create mode 100644 ccan/ciniparser/ciniparser.c
 create mode 100644 ccan/ciniparser/ciniparser.h
 create mode 100644 ccan/ciniparser/dictionary.c
 create mode 100644 ccan/ciniparser/dictionary.h
 rename ndctl/{monitor.conf => ndctl.conf} (82%)
 create mode 100644 util/parse-configs.c
 create mode 100644 util/parse-configs.h

-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
