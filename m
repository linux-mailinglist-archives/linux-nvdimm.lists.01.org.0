Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF809328781
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Mar 2021 18:26:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60F3A100EF270;
	Mon,  1 Mar 2021 09:25:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=fukuri.sai@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB8FF100EF264
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 09:25:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id r5so11939045pfh.13
        for <linux-nvdimm@lists.01.org>; Mon, 01 Mar 2021 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkqtNyD5YWU7skZBnRCnaqPp65C8sMiYuSFRxiO6ulI=;
        b=e+4QJF3u52p6DmBTElcFIpILACZblfRQvflfl8e3AWDhveUZN/pad0E4bNaYoRMBpM
         gbIzk8Vq/TWm/70qfEr33j3A9EVoDSoEVQLlYeBw7dnw1c/aufPIGwnaJdEj6OQWzI7P
         cGefkc12nj6m8PdAfElfoQ9Muj3+JDbKUKB7/xGr+pli2qGNLcp+ePWlTfc++ceTsHim
         lKhZulwQVahOnQdB4GHuyF04RF731NnZiRBIWHgbr2RNf5ihJaAEcJ7dGmAVwGFbWXl8
         0JlLzAJLB2mv/eAOVho3xS5SVfXhUriNN0HBEJxm5Mr+UXwpSHaN7Ldlhj/kdINDisbL
         L6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkqtNyD5YWU7skZBnRCnaqPp65C8sMiYuSFRxiO6ulI=;
        b=nTX1+1UyeMIcYvMGJFCS0x9tBEUeayEYFNqXk6WXIjQGSRy8rRCxvkpFkTBCOQqzBj
         WG4S7EVmNgi3GF6/g71+KLiH02xXzKrOs+nx4k3U4V15DdbjSJmbllI1hVe4LNHdb2I2
         OhVjacsC7ucgM1nmKrvECo2JYjq76I82SsmYchGOQQQYCWf143dMbS61T1GnYBMSfxsu
         tT9dlhOvoXdjeinaCb+Z07/5XueRmzUHuG0dDGdN8ANLel9XmI8zEWj5LtneoYRylY1E
         pB5eB+kuQhRZsV2gpQdhJazOnljjS4MnuDg1vpsMe1vbq1v9eqQ2Yo7ykwyGDdJLoFYc
         U/dw==
X-Gm-Message-State: AOAM5325QGRaJFLk06xzpM+R7TiprP5/9cXh1c0ICr4H4b7lzQYPjg+x
	bFgzIgYhwa2Fcl6TcAAV2tCNQByyQK9YiBPQ
X-Google-Smtp-Source: ABdhPJxWMg5ubukuDfmrTEwG7YuRmNxnxE6Yg8phiMThQEnLrKYwnUmqWnZKwKdgwC7Qo5FTt+RVEw==
X-Received: by 2002:a65:4088:: with SMTP id t8mr14824429pgp.296.1614619555088;
        Mon, 01 Mar 2021 09:25:55 -0800 (PST)
Received: from localhost.localdomain (softbank126036163236.bbtec.net. [126.36.163.236])
        by smtp.gmail.com with ESMTPSA id r186sm13622079pfr.124.2021.03.01.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:25:54 -0800 (PST)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 1/2] configure: add checking jq command
Date: Tue,  2 Mar 2021 02:25:39 +0900
Message-Id: <20210301172540.1511-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: T7YKWFAZT2BZECKHPHM5PLAKDFAMXFJ6
X-Message-ID-Hash: T7YKWFAZT2BZECKHPHM5PLAKDFAMXFJ6
X-MailFrom: fukuri.sai@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T7YKWFAZT2BZECKHPHM5PLAKDFAMXFJ6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add checking jq command since it is needed to validate tests

Cc: Santosh Sivaraj <santosh@fossix.org>
Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
Link: https://github.com/pmem/ndctl/issues/141
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5ec8d2f..839836b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -65,6 +65,12 @@ fi
 AC_SUBST([XMLTO])
 fi

+AC_CHECK_PROG(JQ, [jq], [$(which jq)], [missing])
+if test "x$JQ" = xmissing; then
+	AC_MSG_ERROR([jq command needed to validate tests])
+fi
+AC_SUBST([JQ])
+
 AC_C_TYPEOF
 AC_DEFINE([HAVE_STATEMENT_EXPR], 1, [Define to 1 if you have statement expressions.])

--
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
