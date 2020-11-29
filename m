Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A592C7783
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Nov 2020 05:36:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 264E8100EC1F6;
	Sat, 28 Nov 2020 20:36:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1EF2C100EC1E6
	for <linux-nvdimm@lists.01.org>; Sat, 28 Nov 2020 20:36:40 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id n12so8299041otk.0
        for <linux-nvdimm@lists.01.org>; Sat, 28 Nov 2020 20:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q086GncpPt5RZ5GGX1HkBX2M6Dm58Is22dESYRZ6G14=;
        b=GKb6KyglO2akYr94KQz9x9N9j9MmxWh3b3TolI1AKHUlD/+MP2xXoE8cw3rgtvFg+p
         wbhx97+fIC2JSiuKI5IOjMD+I6h1RoaVP2a3fSDGC4rz1UYMIg8TFeWlBH3KelMsrBIj
         C7U5GbKRKKGT452n2aqevAyQrXq9UZ2L9AdujGw+c/bFSYOFwmkaYT2Q3nZIaLzsGPlC
         S4ZvmqlFEYQROEeo/IMhlpdUAITwrGCqhOObYLZZapqjF+cSw6hB5qAMAB4sAEEGPfXF
         vaG7euhsSvAEnvSyYUxDrcmrAJNeb6zT+BBzjmnZCJG4a91nMkoaoFQ0YgFhvFYYZm4P
         bQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q086GncpPt5RZ5GGX1HkBX2M6Dm58Is22dESYRZ6G14=;
        b=Hb7EBMaU8YAgFmzeGPcT35a7VlWMxl9Qhb3gDWXzTUzMO6w08a/0+e6LOslxGnLAMW
         dP02sCYfd7P6BXk6Qy0Fy55Xu8prre6WjKaKJEQZcdbycB1X5WldhKQk0cjC8LxY+qQL
         4+n3Sctte++vEGQcQz/YtuxQ/x3IirsrCrDpRwF2zRyEJLI0Gee8Rza1ivWIyPUoUZUG
         DNtOT8lk/kDzs6T9+rQ0Vbm7er/Q8Sfyqgz5q3Vib656/Y2onjoxAh4ipWT/Fx4DvL/m
         5LOkZJXT9ZcDDkvm6BDCTy8/y7cHMpjnLUWXk0liTmYc8Cf9PRPLcECenGLkquJnGX4U
         ohPw==
X-Gm-Message-State: AOAM533w7yC4s4PfN+diQOsF+Vs1B7zZVVUcyq34oV/wMaqj0rz1/lTR
	aO28bu4NCS9bYEweQHoncxpG2zjWB2h2gOzflds=
X-Google-Smtp-Source: ABdhPJxvcLhJ4FJtXq+ZvQXqChF8Ekt+OsSPE4XGv6LMM0bnoc9AeEaH9ZTveYnFgh6A2fhDN7D0b5KaXE1cBV93ioc=
X-Received: by 2002:a9d:6a81:: with SMTP id l1mr11388742otq.254.1606624599312;
 Sat, 28 Nov 2020 20:36:39 -0800 (PST)
MIME-Version: 1.0
From: Amy Parker <enbyamy@gmail.com>
Date: Sat, 28 Nov 2020 20:36:29 -0800
Message-ID: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
Subject: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from DAX_ZERO_PAGE
 to XA_ZERO_ENTRY
To: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Message-ID-Hash: SHPDEYRYKX76ZFA2EXO2GFCPGBGJLLBJ
X-Message-ID-Hash: SHPDEYRYKX76ZFA2EXO2GFCPGBGJLLBJ
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SHPDEYRYKX76ZFA2EXO2GFCPGBGJLLBJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DAX uses the DAX_ZERO_PAGE bit to represent holes in files. It could also use
a single entry, such as XArray's XA_ZERO_ENTRY. This distinguishes zero pages
and allows us to shift DAX_EMPTY down (see patch 2/3).

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/dax.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..fa8ca1a71bbd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -77,9 +77,14 @@ fs_initcall(init_dax_wait_table);
 #define DAX_SHIFT    (4)
 #define DAX_LOCKED    (1UL << 0)
 #define DAX_PMD        (1UL << 1)
-#define DAX_ZERO_PAGE    (1UL << 2)
 #define DAX_EMPTY    (1UL << 3)

+/*
+ * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
+ * definition helps with checking if an entry is a PMD size.
+ */
+#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
+
 static unsigned long dax_to_pfn(void *entry)
 {
     return xa_to_value(entry) >> DAX_SHIFT;
@@ -114,7 +119,7 @@ static bool dax_is_pte_entry(void *entry)

 static int dax_is_zero_entry(void *entry)
 {
-    return xa_to_value(entry) & DAX_ZERO_PAGE;
+    return xa_to_value(entry) & (unsigned long)XA_ZERO_ENTRY;
 }

 static int dax_is_empty_entry(void *entry)
@@ -738,7 +743,7 @@ static void *dax_insert_entry(struct xa_state *xas,
     if (dirty)
         __mark_inode_dirty(mapping->host, I_DIRTY_PAGES);

-    if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
+    if (dax_is_zero_entry(entry) && !(flags & (unsigned long)XA_ZERO_ENTRY)) {
         unsigned long index = xas->xa_index;
         /* we are replacing a zero page with block mapping */
         if (dax_is_pmd_entry(entry))
@@ -1047,7 +1052,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
     vm_fault_t ret;

     *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-            DAX_ZERO_PAGE, false);
+            XA_ZERO_ENTRY, false);

     ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
     trace_dax_load_hole(inode, vmf, ret);
@@ -1434,7 +1439,7 @@ static vm_fault_t dax_pmd_load_hole(struct
xa_state *xas, struct vm_fault *vmf,

     pfn = page_to_pfn_t(zero_page);
     *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-            DAX_PMD | DAX_ZERO_PAGE, false);
+            XA_ZERO_PMD_ENTRY, false);

     if (arch_needs_pgtable_deposit()) {
         pgtable = pte_alloc_one(vma->vm_mm);
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
