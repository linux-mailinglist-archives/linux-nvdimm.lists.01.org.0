Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D742E19A010
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 22:47:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1EA110FC3635;
	Tue, 31 Mar 2020 13:48:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com; envelope-from=jbi.octave@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C4BA10FC3607
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 13:48:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u10so27805792wro.7
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvASRPgCaC5pl51Xj9DP4Wxeu7mG/1HPSOpzyUZ53rM=;
        b=nxjeR2sq/OMueEcNnfyf3sqemFIQ9tRGoOtZdGieEPWtcApjY+OYjIb31E2gmLTNM8
         CUgd9dtowCAqqqpgEeXxGXP1D9306b8uQ6lUh9pQXYKRU7WvJU8MQ1nGyJ/bhl6HsE2d
         fO2vXmVQXXxe50iieIYpECUT7t5+Ev5FmIp1Xpfg7vdj1j8J000+k7us0PlYNhwJYXIY
         MzDUSKMifaHmFQ+yDQL4XS3Lwq1sa/8X6GdduXBnXeLrntd/uoK0JQRBpfQWbtWDBTR6
         dfIDTmL6zER//TR+/mZXKqqlQkO2iYsQhmYX591wZ7mZiS7ZSyB+prpkut0lW687tY4z
         MlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvASRPgCaC5pl51Xj9DP4Wxeu7mG/1HPSOpzyUZ53rM=;
        b=V+ky/X9by6N+zswo7lMdL/WAQ8DeeoC8v6ct4fITr9Nak/rl56wk2o3L+lH3g0Mi67
         Ox71n4MO+Nwx4QD3bZ2dOxKcXRZzChdYTQ/icSi5tEHQVI+0QFglL0n/SC/jVryZeafI
         hxlY981Ksmf4Gud5FIJ5I6i9ND0/bcwYUxMwuc4D04quIDmAJ+nnBrdmaZkpPs0sgvb7
         OwfA3uWygLPhs8bYjiKNzCVWRgLggqjhvJlmNhJr2q5DxL70xmy19PGgIoo7W+i0lJGZ
         bgadCfywnZaADKTJ94bFJRYNtiwvVO3lM7Xi1Ki7tRHoLYglIiT8eXpAnh/4hzrGhI1b
         /IRw==
X-Gm-Message-State: ANhLgQ1eZe/Cn3+G656mjHUKhaIk5WQj5pr3h3PmJHzLLD0IAoBB7LqG
	0rJNz0k/yUVFcUHtXIBSsQ==
X-Google-Smtp-Source: ADFU+vteECjsDAZ2xVHVsEm663gf11mvqdgWJ7byHpmU5MP+FnkJj06hcikww+/wXxKq9e7VFm3Sqw==
X-Received: by 2002:a5d:4290:: with SMTP id k16mr21990816wrq.406.1585687633570;
        Tue, 31 Mar 2020 13:47:13 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:13 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dax: Add missing annotation for wait_entry_unlocked()
Date: Tue, 31 Mar 2020 21:46:39 +0100
Message-Id: <20200331204643.11262-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Message-ID-Hash: YF5TCHPF6VR5UBNMIECW6T7ZIWQHNWJG
X-Message-ID-Hash: YF5TCHPF6VR5UBNMIECW6T7ZIWQHNWJG
X-MailFrom: jbi.octave@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, "open list:FILESYSTEMS VFS and infrastructure" <linux-fsdevel@vger.kernel.org>, "open list:FILESYSTEM DIRECT ACCESS DAX" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YF5TCHPF6VR5UBNMIECW6T7ZIWQHNWJG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sparse reports a warning at wait_entry_unlocked()

warning: context imbalance in wait_entry_unlocked()
	- unexpected unlock

The root cause is the missing annotation at wait_entry_unlocked()
Add the missing __releases(xa) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..adcd2a57fbad 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
  */
 static void wait_entry_unlocked(struct xa_state *xas, void *entry)
+	__releases(xa)
 {
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
