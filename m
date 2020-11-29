Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC192C7784
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Nov 2020 05:36:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FFF0100EBBB4;
	Sat, 28 Nov 2020 20:36:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 899B3100EC1E6
	for <linux-nvdimm@lists.01.org>; Sat, 28 Nov 2020 20:36:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id c80so10588117oib.2
        for <linux-nvdimm@lists.01.org>; Sat, 28 Nov 2020 20:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=soI2FbgRVVf7YiM5QpqBIyP2vOa5RD0uTn26wDJDuAw=;
        b=YAQWSm+qxF11VKwdEUOLxeNDv6v6atlFDk23YKjHQhpWs0949eFjvzU190A0TajDiZ
         svT4m5KElnXDTAgmJVrjbxPaer4OQ9xR9EONeyBezWSMg5beLgHJ/LvsFDHXXaS4BAC2
         OtmW0Ho7RD/QKd58ZyZfmd+78whb3w/K5JhgnPEmf1ih1UB7HzkJGO7nEnKGRE7+2szd
         UIapCGEt2vvqeUGuuQ0RhsVWMiO7laiL7vcyLP+iHqCykgYFwr6YuDCWnn/92yQb8EV9
         YaqW4TZbo5imfUF5GK2QY96Fxiv6debIbvwRz5x7nqLsVNOWj/5xwxP5aBDEf/9Epa5+
         RBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=soI2FbgRVVf7YiM5QpqBIyP2vOa5RD0uTn26wDJDuAw=;
        b=f03RbZju9rZauhxTh+DCNGbEwq8Lc60iqk43tqzQSLUg0YLormAtC5B9Gr9DDzhImG
         EB+aXXO2+Wcneai60CQVhtdzfyE2F+eH5M4u3rtxUq6287XXbv1fIKkyk3pHDcl5BcXx
         bYuHmVR6P1faD3K2iZk+kWhFsJeLvdnxUc8E8SakoO+3VkqMSEiQFP49XlS3F4zJn7Ws
         jxwnzhg+3jlZO4Xzt5cYsCvdKl1SWd9m5dEcR9V659a2hGshorjxEGtuwOdopGI5w4D/
         EAFwNjRk4UZDIXqlJ9fqIleN77Ea7ySoSz7hGtxIEPLtubQKisz3Os/YXprCE9RjkikG
         QLVQ==
X-Gm-Message-State: AOAM533obkm1Tex6duO8wWYUVBFdJ8SuaeeowRMUDBh8N04M5POpIbZt
	vr85HT+ZhYU6lb1uxFSi2+ub515kH5XozDOpKa4=
X-Google-Smtp-Source: ABdhPJw2yKAioiKvOgEBz0/H2meynlNoPvLmKiPbKFeqneELTGWI8hBJojPX9/NNBv7/UhR0rkhroB254agWXvxD1Qo=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr10661269oid.114.1606624600820;
 Sat, 28 Nov 2020 20:36:40 -0800 (PST)
MIME-Version: 1.0
From: Amy Parker <enbyamy@gmail.com>
Date: Sat, 28 Nov 2020 20:36:30 -0800
Message-ID: <CAE1WUT6GfMH9krfXE2oEGuX9KoLe83SUZZbxQYEFvNF8-wFNhg@mail.gmail.com>
Subject: [RFC PATCH 2/3] fs: dax.c: move down bit DAX_EMPTY
To: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Message-ID-Hash: 6IL3GGEVMD2NPHVAKS3CPVYTCGHCBB3D
X-Message-ID-Hash: 6IL3GGEVMD2NPHVAKS3CPVYTCGHCBB3D
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6IL3GGEVMD2NPHVAKS3CPVYTCGHCBB3D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As DAX_ZERO_PAGE has been removed, DAX_EMPTY can be shifted downwards.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index fa8ca1a71bbd..c2bdccef3140 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -77,7 +77,7 @@ fs_initcall(init_dax_wait_table);
 #define DAX_SHIFT    (4)
 #define DAX_LOCKED    (1UL << 0)
 #define DAX_PMD        (1UL << 1)
-#define DAX_EMPTY    (1UL << 3)
+#define DAX_EMPTY    (1UL << 2)

 /*
  * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
