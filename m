Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8211D537
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 19:22:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F2461011366C;
	Thu, 12 Dec 2019 10:26:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com; envelope-from=3fyxyxqqkdegl1ryqyyqvo.mywvsx47-x5nswwvs232.ab.y1q@flex--brho.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 187451011366B
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:26:17 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id j16so1838812qkk.17
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rEnziU9nLlHlYc/tf137lSRc7sdTqh5wg35Mf+C3wB0=;
        b=wOmXzfFazrugxZCYf410kz6njqqI2ZayPQ3Zp1rCCJAl61eXIHZJMLIXKd7ipcL41R
         Sm+Wcca2Q6JqgT++kdbvjzbjYq0FYVW/lmi7QB7yJwkVuo4MV424+x+d7yCwKx0ttep0
         Lptl32SFvhXt0TyRQZlvv9SqXlyRFpCG1TsG3O7/iQ2t4vkLUnHSfRpXrHshDh35/gFo
         c/KEVVI0neOaMUy1YUeklfjbepAMeO7ukOv7HLZ0ISIwDFMKd/GAqrrKh7r8JeBNqa+r
         SbafHPrcaqVH22AN6GG+pQawROsiZA4u3mp/RCCP/9BjFwd9lIMMNNZaOz5x++hHZB3m
         2fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rEnziU9nLlHlYc/tf137lSRc7sdTqh5wg35Mf+C3wB0=;
        b=HwoSJpTIBkGfcytVpXfXCOZiH+65OyMXHYg3Kx3kqY6kZ40MEvWfFfU2jZ1umg8gah
         OI752yLl0cui3pSACKWDtBl2SAz+Y10l4aja8N9FGJ+RpLDCJ95R0aW0sRWStJ2AHMbj
         81QCgMwWtd+3fiy58lXquBlNjjOn6r0+5uxptpEqDMnxtlmrekSuCxNqoAQufrGoKp4y
         M50pTATnyug6kNGZvlKbgpQa41ciaq3MBPKq198nQlkZfma1EFowB6ODLY9MDYR1s/Ve
         BAfzTxxlznY8sx6746cedWVJqGR8IHu9tL24Wc58x8PvQyhY1Df3H8zHa7VQkSPkqZf/
         aFJg==
X-Gm-Message-State: APjAAAUexTwjn11udgJMw0tVRv3jWJyJBmiQKtWW8pq8neLRLeyETqtK
	Xzsa9pfuxHQ81MiJpOP1P3VjtoNh
X-Google-Smtp-Source: APXvYqzcW/ZghkfJqEYc4rFEK2YkEyqYYEYYl+bxHBfcPF4MTg+EIi+2m6XM7rKZ/g0d94tGM2bioMma
X-Received: by 2002:ac8:5308:: with SMTP id t8mr8677688qtn.51.1576174973189;
 Thu, 12 Dec 2019 10:22:53 -0800 (PST)
Date: Thu, 12 Dec 2019 13:22:36 -0500
Message-Id: <20191212182238.46535-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v5 0/2] kvm: Use huge pages for DAX-backed files
From: Barret Rhoden <brho@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID-Hash: 2K7T3DRDFB4TSZDMO7CC5UATA6DWLS7K
X-Message-ID-Hash: 2K7T3DRDFB4TSZDMO7CC5UATA6DWLS7K
X-MailFrom: 3fYXyXQQKDEgl1ryqyyqvo.mywvsx47-x5nswwvs232.AB.y1q@flex--brho.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2K7T3DRDFB4TSZDMO7CC5UATA6DWLS7K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset allows KVM to map huge pages for DAX-backed files.

v4 -> v5:
v4: https://lore.kernel.org/lkml/20191211213207.215936-1-brho@google.com/
- Rebased onto kvm/queue
- Removed the switch statement and fixed PUD_SIZE; just use
  dev_pagemap_mapping_shift() > PAGE_SHIFT
- Added explanation of parameter changes to patch 1's commit message

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

 arch/x86/kvm/mmu/mmu.c | 31 +++++++++++++++++++++++++++----
 include/linux/mm.h     |  3 +++
 mm/memory-failure.c    | 38 +++-----------------------------------
 mm/util.c              | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 39 deletions(-)

-- 
2.24.0.525.g8f36a354ae-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
