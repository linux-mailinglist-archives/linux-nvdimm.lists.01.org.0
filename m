Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CA36F568
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Apr 2021 07:41:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4AECC100EB859;
	Thu, 29 Apr 2021 22:41:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=hughd@google.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B757F100EB858
	for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 22:41:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id b14so8281633qvf.9
        for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 22:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Zx8pZdhiNX5aPOyXUOIzWq8zYQHmuVtq5hGUZrL+hxk=;
        b=leXLFTKdISvneTcPmvgUXPy0vucswWlGanD1F9s2b2AM5ZlSIVmek08Oc6xCvLso+i
         SdFwKFSs0p3/a0i1XzlDr/VTxcPgVkORFyoRglFCTeGrRFseFEJ+CxlNWsvKUSJXuj29
         e2usBGYSeWD10SugISYejx9upWSBnBuzwpRZSo5jq7Kyif963vjzwqVdy+G2OMJsuAIY
         AMax8Z5vPcJOaLCzLCIgM2y5pYstLLiJMIKgGWoto6LU7i998eaIsejstUfW6WVQ2dsA
         gJyujCd7bfz6Q8RZH3JjXzcVN0TCeMNA46pWSoZitsTFYxkzrDpr00mzSd75n/k3JNmg
         1JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Zx8pZdhiNX5aPOyXUOIzWq8zYQHmuVtq5hGUZrL+hxk=;
        b=I5vebI4HxYWXblIVv8RtEZYzj3mXxhkoHQf5ylYJgEE11w7kiPGxb18yPO9YQC1ZH0
         GN+ASsEOPA6Rick2Qy/BavA0omTDnW5wSo52r+B9ACj1u6wGQmao2F7MRB6uv1eydeTY
         U9ygi9GoV4YHDql8jXSL2Zq+McBbzl/78b4k2xa6Zn3nCyF5axdWoyzjGcU187+sjQ97
         PZMVYOWmCrKopORCH8k6XuG8Xvbs672N7Hna8VJegYFakIIlOWKpwuO9t95GuOpBhWdC
         sE1+vZQT7uwuZtG9eHMJeMJBiTIqs6i92GGzI2Xuqf7RUBOtmlaBmimz/xOvbcX6ZTTz
         zdnw==
X-Gm-Message-State: AOAM533Zr98vyd7F3VzS4kg+e4KyeqS4rkd+NOUCbj7h6SBKzN6GmWMK
	Zo/0HvbtejmRv/7kybgqtwyJ/Q==
X-Google-Smtp-Source: ABdhPJzY13DAJCoJ5dcDvmbdoiHlkA74Mjnt1G1gxrRT/Of1Bop6wAym2XmFy51k0T+0YZ2pDLUGsg==
X-Received: by 2002:a0c:e242:: with SMTP id x2mr3422063qvl.45.1619761281109;
        Thu, 29 Apr 2021 22:41:21 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a24sm672835qkn.104.2021.04.29.22.41.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 29 Apr 2021 22:41:20 -0700 (PDT)
Date: Thu, 29 Apr 2021 22:41:05 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
In-Reply-To: <20210429211634.de4e0fb98d27b3ab9d05757c@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2104292229380.16080@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils> <20210331024913.GS351017@casper.infradead.org> <alpine.LSU.2.11.2103311413560.1201@eggly.anvils> <20210401170615.GH351017@casper.infradead.org> <20210402031305.GK351017@casper.infradead.org>
 <20210402132708.GM351017@casper.infradead.org> <20210402170414.GQ351017@casper.infradead.org> <alpine.LSU.2.11.2104021239060.1092@eggly.anvils> <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
 <20210429211634.de4e0fb98d27b3ab9d05757c@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Message-ID-Hash: 6OVFLY4BFUS2KWAMXWEMOZAA4IGLGNVW
X-Message-ID-Hash: 6OVFLY4BFUS2KWAMXWEMOZAA4IGLGNVW
X-MailFrom: hughd@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6OVFLY4BFUS2KWAMXWEMOZAA4IGLGNVW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 29 Apr 2021, Andrew Morton wrote:
> 
> I'm not sure this ever was resolved?

It was not resolved: Matthew had prospective fixes for one way in which
it could happen, but they did not help the case which still hits my
testing (well, I replace the BUG_ON by a WARN_ON, so not hit badly).

> 
> Is it the case that the series "Remove nrexceptional tracking v2" at
> least exposed this bug?

Yes: makes a BUG out of a long-standing issue not noticed before.

> 
> IOW, what the heck should I do with
> 
> mm-introduce-and-use-mapping_empty.patch
> mm-stop-accounting-shadow-entries.patch
> dax-account-dax-entries-as-nrpages.patch
> mm-remove-nrexceptional-from-inode.patch

If Matthew doesn't have a proper fix yet (and it's a bit late for more
than an obvious fix), I think those should go in, with this addition:

[PATCH] mm: remove nrexceptional from inode: remove BUG_ON

clear_inode()'s BUG_ON(!mapping_empty(&inode->i_data)) is unsafe: we know
of two ways in which nodes can and do (on rare occasions) get left behind.
Until those are fixed, do not BUG_ON() nor even WARN_ON(). Yes, this will
then leak those nodes (or the next user of the struct inode may use them);
but this has been happening for years, and the new BUG_ON(!mapping_empty)
was only guilty of revealing that. A proper fix will follow, but no hurry.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 fs/inode.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- mmotm/fs/inode.c	2021-04-22 18:30:46.285908982 -0700
+++ linux/fs/inode.c	2021-04-29 22:13:54.096530691 -0700
@@ -529,7 +529,14 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_lock_irq(&inode->i_data.i_pages);
 	BUG_ON(inode->i_data.nrpages);
-	BUG_ON(!mapping_empty(&inode->i_data));
+	/*
+	 * Almost always, mapping_empty(&inode->i_data) here; but there are
+	 * two known and long-standing ways in which nodes may get left behind
+	 * (when deep radix-tree node allocation failed partway; or when THP
+	 * collapse_file() failed). Until those two known cases are cleaned up,
+	 * or a cleanup function is called here, do not BUG_ON(!mapping_empty),
+	 * nor even WARN_ON(!mapping_empty).
+	 */
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
