Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E888273A85
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Sep 2020 08:08:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E342814E8307B;
	Mon, 21 Sep 2020 23:07:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f43; helo=mail-qv1-xf43.google.com; envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ADDB714E83078
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 23:07:57 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j3so8895288qvi.7
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtWt5LT1rZHUieitxqoZL94pXE9Kni8HrVa9DLq6ra8=;
        b=iuUH7P98MAjsRlYJLK0TJlVvZeCzmYl9RV4YJokXxQqlQv7Wl7kR5ZHCp9MtlOlzKk
         /1RP01X5p+SM3kTFYgEvk62jz44d/piRqzh8EXdfCfQmyBgRRa3jZ0xJgGBfL2TYW6tn
         ede/YsJq2RHhP6OjTLHxVUg/RHQ1nexItE8RxNdloYtrMpaYRUzbXPWF7VnOLjpzZums
         CY/p2InTF6IIF4O6CRVc14nFUBzT4GmCjfKIYzruKsehGb+bT4uXZzhSESh7tX6yA1Cj
         L4hsw6xW7izWpTL7qRTsyjLb9Wnwa1exn47NZ3C9KFSk/ArtkDmN9SScS3ZUa1kEKfmM
         R/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtWt5LT1rZHUieitxqoZL94pXE9Kni8HrVa9DLq6ra8=;
        b=IrArbT1zxi/Kxri+gyHEBDjYuKmh1/tIP4TsmK/3iTIRNaza216NSVr0juLhBllcUy
         y2fGZl/UjpLVTHe7ANg09l1YBq6yUkXoeigvsciYk47Z7HZ9T1s91lhhSAumlcgo6bjf
         up4gs2ajRzOOesSdi5J/UUTGanon5HEOTG1JVDBKB6Q7qjb9Uib1jZvVbZJxUzTtgTWA
         tU7rgIWkPoP44Y3ehmABb9jBb56h8XjB7GyDIsKr4y4c/Wtkl2ObtpmS2NQW2C1zIo5Z
         CCiVzOywY19bIHYSICePiZQEVnbVaa51CuwrQA0NsXopcR1DiZo8EZXSf9kuxLKga+lN
         R8Gw==
X-Gm-Message-State: AOAM532G09ORGcoRc6HcuDZJh9up5ktIR6/ljY9xpmh+QqWFdezlae3w
	yI8vPEbCNIg8tKSxUmdy5ak=
X-Google-Smtp-Source: ABdhPJzYAkkRErXQKS5nPd9e9nFfwFnEtBGJUL1AQh/5PWzM/3iOlyBSVL9xx1MY6K5RCdOgRUtuYQ==
X-Received: by 2002:a0c:8b02:: with SMTP id q2mr4425388qva.48.1600754876169;
        Mon, 21 Sep 2020 23:07:56 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id x3sm12523533qta.53.2020.09.21.23.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 23:07:55 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: david@redhat.com
Subject: [PATCH] kernel/resource: Fix use of ternary condition in release_mem_region_adjustable
Date: Mon, 21 Sep 2020 23:07:48 -0700
Message-Id: <20200922060748.2452056-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911103459.10306-2-david@redhat.com>
References: <20200911103459.10306-2-david@redhat.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Message-ID-Hash: 35ONLSAU6RHZW7PB47HN2RJVPCP6F2JJ
X-Message-ID-Hash: 35ONLSAU6RHZW7PB47HN2RJVPCP6F2JJ
X-MailFrom: natechancellor@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, ardb@kernel.org, bhe@redhat.com, jgg@ziepe.ca, keescook@chromium.org, linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, mhocko@suse.com, pankaj.gupta.linux@gmail.com, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/35ONLSAU6RHZW7PB47HN2RJVPCP6F2JJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Clang warns:

kernel/resource.c:1281:53: warning: operator '?:' has lower precedence
than '|'; '|' will be evaluated first
[-Wbitwise-conditional-parentheses]
        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
kernel/resource.c:1281:53: note: place parentheses around the '|'
expression to silence this warning
        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
kernel/resource.c:1281:53: note: place parentheses around the '?:'
expression to evaluate it first
        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
                                                           ^
                                              (                              )
1 warning generated.

Add the parentheses as it was clearly intended for the ternary condition
to be evaluated first.

Fixes: 5fd23bd0d739 ("kernel/resource: make release_mem_region_adjustable() never fail")
Link: https://github.com/ClangBuiltLinux/linux/issues/1159
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Presumably, this will be squashed but I included a fixes tag
nonetheless. Apologies if this has already been noticed and fixed
already, I did not find anything on LKML.

 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index ca2a666e4317..3ae2f56cc79d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1278,7 +1278,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 	 * similarly).
 	 */
 retry:
-	new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
+	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? __GFP_NOFAIL : 0));
 
 	p = &parent->child;
 	write_lock(&resource_lock);

base-commit: 40ee82f47bf297e31d0c47547cd8f24ede52415a
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
