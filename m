Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12E2885EC
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 11:24:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A27F21596DBD0;
	Fri,  9 Oct 2020 02:24:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=47.88.44.36; helo=out4436.biz.mail.alibaba.com; envelope-from=richard.weiyang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com [47.88.44.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B51B8157590BA
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 02:24:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0UBQ5Qni_1602235473;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UBQ5Qni_1602235473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Oct 2020 17:24:34 +0800
Date: Fri, 9 Oct 2020 17:24:33 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] kernel/resource: Fix use of ternary condition in
 release_mem_region_adjustable
Message-ID: <20201009092433.GA56924@L-31X9LVDL-1304.local>
References: <20200911103459.10306-2-david@redhat.com>
 <20200922060748.2452056-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922060748.2452056-1-natechancellor@gmail.com>
Message-ID-Hash: 7ZMSWKU65CJSALSMBPJTB57QHCWMLU5G
X-Message-ID-Hash: 7ZMSWKU65CJSALSMBPJTB57QHCWMLU5G
X-MailFrom: richard.weiyang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: david@redhat.com, akpm@linux-foundation.org, ardb@kernel.org, bhe@redhat.com, jgg@ziepe.ca, keescook@chromium.org, linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, mhocko@suse.com, pankaj.gupta.linux@gmail.com, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, clang-built-linux@googlegroups.com
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7ZMSWKU65CJSALSMBPJTB57QHCWMLU5G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 21, 2020 at 11:07:48PM -0700, Nathan Chancellor wrote:
>Clang warns:
>
>kernel/resource.c:1281:53: warning: operator '?:' has lower precedence
>than '|'; '|' will be evaluated first
>[-Wbitwise-conditional-parentheses]
>        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>kernel/resource.c:1281:53: note: place parentheses around the '|'
>expression to silence this warning
>        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>kernel/resource.c:1281:53: note: place parentheses around the '?:'
>expression to evaluate it first
>        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                                           ^
>                                              (                              )
>1 warning generated.
>
>Add the parentheses as it was clearly intended for the ternary condition
>to be evaluated first.
>
>Fixes: 5fd23bd0d739 ("kernel/resource: make release_mem_region_adjustable() never fail")
>Link: https://github.com/ClangBuiltLinux/linux/issues/1159
>Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
>
>Presumably, this will be squashed but I included a fixes tag
>nonetheless. Apologies if this has already been noticed and fixed
>already, I did not find anything on LKML.
>
> kernel/resource.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/resource.c b/kernel/resource.c
>index ca2a666e4317..3ae2f56cc79d 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -1278,7 +1278,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
> 	 * similarly).
> 	 */
> retry:
>-	new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>+	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? __GFP_NOFAIL : 0));
> 
> 	p = &parent->child;
> 	write_lock(&resource_lock);
>
>base-commit: 40ee82f47bf297e31d0c47547cd8f24ede52415a
>-- 
>2.28.0

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
