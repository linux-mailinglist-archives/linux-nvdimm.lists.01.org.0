Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACDB11BF3A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Dec 2019 22:32:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B7801011361D;
	Wed, 11 Dec 2019 13:35:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3zgdxxqqkdn8csiphpphmf.dpnmjovy-owejnnmjtut.bc.psh@flex--brho.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49C1910113518
	for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 13:35:43 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w127so2910821pfb.13
        for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yOD0iLUDW76bcZvomrsQRH0nGqn37n8IrqSYFpzYwxo=;
        b=SkYtkuEt3uhSk0GqlAk4oucYFWLKir9gozR06v9/suCWs/JVSDqytCQWQ9LgaAQ2na
         PmOF+bMFyZX6yDg3n+Y3lq9ka6vzus1Yx1drthis6lI3K3+dNDjwq8TzRTCIy1BhVIIE
         8YyFCJU6quwTTAiMFY22MftPutzvhLyK65b5i18KFpIC0t8RK3OHJqcX/1Q1U0dLdMk+
         b/qD97l+2JOZReqFN252Il/j1KHxrLlQRWYJ7YefFfcWqCeAnQlW2oxdi/bAsI+HS93n
         o7eHSkSdR5VZMpEmI6I80LN1+CMxsTLZDVS0IUoIUejO9uJ/AKOE54dkjVuXyEUIAhas
         tn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yOD0iLUDW76bcZvomrsQRH0nGqn37n8IrqSYFpzYwxo=;
        b=dEDPzw6QM+j2UNT9aLoS0Im6Y/qtr3grQaogpMymRn7AXHTZUa7Uoy9jgrIzf4QYdd
         TGERZFHsgXa6aelgOdzNeAUxU+n6iABgl7YPH8E5O1OOSHg9pwasbgDZqzYyiAmcIXyR
         Li11YMdvYtEu0cGBO8q58UBthgnnPZNcHBNnmF0szb2SrVeF4FjczBKqd3eD8S8bj5Ha
         Wa+WyEH+MKGK3pal+kMGYWb0VIgcDaOIWInoW8VHL1KskPxY08RO6AWeOZkvcHii6g1B
         MxfCOnhpyCuflb7yLM/N/8aHwQ7jmiYx0Fi4heBA1SPnGr0/q2EOCoNQqySmjjtDCLtC
         T1vA==
X-Gm-Message-State: APjAAAWFDN4jBYj2Kdb35h1KWzqfVg0cAgTVnB4fPd3OAABQaXLM2Dw0
	QXhugOd50HNBHbD4WD/nzWr+TZAR
X-Google-Smtp-Source: APXvYqwxN+9vk9zS22b7QST6+pxb5MgdnMTh4p7n/rktgqkeQdSuCaW1zb//I1NE9J50Us45XT1y4SFl
X-Received: by 2002:a63:ec0a:: with SMTP id j10mr6589163pgh.178.1576099940106;
 Wed, 11 Dec 2019 13:32:20 -0800 (PST)
Date: Wed, 11 Dec 2019 16:32:05 -0500
Message-Id: <20191211213207.215936-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v4 0/2] kvm: Use huge pages for DAX-backed files
From: Barret Rhoden <brho@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID-Hash: PPJFCK3MNTIZ2YJHKRBL6OTEQMBSSGH2
X-Message-ID-Hash: PPJFCK3MNTIZ2YJHKRBL6OTEQMBSSGH2
X-MailFrom: 3ZGDxXQQKDN8CSIPHPPHMF.DPNMJOVY-OWEJNNMJTUT.bc.PSH@flex--brho.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PPJFCK3MNTIZ2YJHKRBL6OTEQMBSSGH2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset allows KVM to map huge pages for DAX-backed files.

I held previous versions in limbo while people were sorting out whether
or not DAX pages were going to remain PageReserved and how that relates
to KVM.

Now that that is sorted out (DAX pages are PageReserved, but they are
not kvm_is_reserved_pfn(), and DAX pages are considered on a
case-by-case basis for KVM), I can repost this.

v3 -> v4:
v3: https://lore.kernel.org/lkml/20190404202345.133553-1-brho@google.com/
- Rebased onto linus/master

v2 -> v3:
v2: https://lore.kernel.org/lkml/20181114215155.259978-1-brho@google.com/
- Updated Acks/Reviewed-by
- Rebased onto linux-next

v1 -> v2:
https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
- Updated Acks/Reviewed-by
- Minor touchups
- Added patch to remove redundant PageReserved() check
- Rebased onto linux-next

RFC/discussion thread:
https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/

Barret Rhoden (2):
  mm: make dev_pagemap_mapping_shift() externally visible
  kvm: Use huge pages for DAX-backed files

 arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
 include/linux/mm.h     |  3 +++
 mm/memory-failure.c    | 38 +++-----------------------------------
 mm/util.c              | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 39 deletions(-)

-- 
2.24.0.525.g8f36a354ae-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
