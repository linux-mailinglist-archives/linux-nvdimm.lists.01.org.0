Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB94D2C7785
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Nov 2020 05:36:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57986100EBBCA;
	Sat, 28 Nov 2020 20:36:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c42; helo=mail-oo1-xc42.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2D3E100EBBAC
	for <linux-nvdimm@lists.01.org>; Sat, 28 Nov 2020 20:36:43 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id f8so1969701oou.0
        for <linux-nvdimm@lists.01.org>; Sat, 28 Nov 2020 20:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EAojnF4t5DRg2ANKGYyPD+m7P2SzoKfdrt8RRTLUrjc=;
        b=i937HvJCOE5kRkQVkNmOI1nqD+BtqUVKfm5rxTmdUXbOXHdgZhYMhBw7uxmWPZ6Iah
         wUr3KvvWpfziaVHX3Cj7DE7nTgGKXZlHgEzwnISt8be7m66WNjuePgVx4lJuA+L2/UO+
         yIOAruGI/UnyItFfYzWg14NDeebg3nBmflyZfVE0HV7bi72ocFYiqj8iNydnCS3F5o3g
         BV3OrixKnMla4Wa61fiAcHxrkzCapPFh9DUZhCungqcTuzFPzZYCX/pYAlsyyBjYptk4
         fjzPS+q+1FPlICGC7zuP9HtqPbC4NAXagLovl1McAQ50KC7whmgNstBLNcB05OL59/f9
         oJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EAojnF4t5DRg2ANKGYyPD+m7P2SzoKfdrt8RRTLUrjc=;
        b=kiDLN51qI3y38yi8xcLMwqTqdhcSVHEVZnq/mSsuwwoqfZ+Qash+QejrpSJjWixVYl
         EWDCCPwgq1ZcStNgHq2wwZmNNmHNmRn+xYc+vBXBjdGh39BMng1xWLdCuvfWcCCzdmRs
         XGZBrZuCZUtEiearOg6UcCHnWfQCa4tHj6usOkSgYomNIlRANWHyZlMB2OFhEk4ttkjo
         h5MfEWTNkkIZKIPcdUJdEYVVzksie07F3e+BBxI5zpeSm0NQ+4M3pmcNjgbClv7cCYi1
         L53TqSjZWM1UVcWCk7v/mVIXXuvmD3dNSMRaALoNoFn5r2+RtOdS7BsVJvVL3Ggl+azy
         Y8kQ==
X-Gm-Message-State: AOAM531nxZX+MBInzXoYb2IIylM31+2jfyfMgdmUuhThqtMdsyA6wqkk
	mi5fnhy4erlmyErc4sffN2lsDpjmaDWqQgGX8WM=
X-Google-Smtp-Source: ABdhPJyK3VgPYV3WHp6k8LdcP+3Vb/uyGiAuqsVI5MeqbR5ow0ZRhcZG9DKyGDv0+0/kaFFBTsAUSJgwiysbTBuIK04=
X-Received: by 2002:a4a:4e87:: with SMTP id r129mr11050293ooa.4.1606624602474;
 Sat, 28 Nov 2020 20:36:42 -0800 (PST)
MIME-Version: 1.0
From: Amy Parker <enbyamy@gmail.com>
Date: Sat, 28 Nov 2020 20:36:32 -0800
Message-ID: <CAE1WUT5HT4oZkWw87ADw53AOSygkZKEzF00joe+ZXq=mKH-fiw@mail.gmail.com>
Subject: [RFC PATCH 3/3] fs: dax.c: correct terminology used in DAX bit definitions
To: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Message-ID-Hash: UTXMDNADRKMTWR3AEFNZ6332SADNTRPR
X-Message-ID-Hash: UTXMDNADRKMTWR3AEFNZ6332SADNTRPR
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UTXMDNADRKMTWR3AEFNZ6332SADNTRPR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DAX_ZERO_ENTRY is no longer the bit for zero entries - XA_ZERO_ENTRY is.
The documentation above should be accurate to the definitions used accordingly.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/dax.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c2bdccef3140..ec23a4f9edd5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -66,13 +66,13 @@ fs_initcall(init_dax_wait_table);

 /*
  * DAX pagecache entries use XArray value entries so they can't be mistaken
- * for pages.  We use one bit for locking, one bit for the entry size (PMD)
- * and two more to tell us if the entry is a zero page or an empty entry that
- * is just used for locking.  In total four special bits.
+ * for pages.  We use one bit for locking, one bit for the entry size (PMD),
+ * and one to tell if the entry is an empty entry just for locking. We use
+ * XArray's ZERO_ENTRY to tell us if the entry is a zero page.
  *
- * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
- * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
- * block allocation.
+ * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the EMPTY
+ * and ZERO_ENTRY bits aren't set the entry is a normal DAX entry with a
+ * filesystem block allocation.
  */
 #define DAX_SHIFT    (4)
 #define DAX_LOCKED    (1UL << 0)
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
