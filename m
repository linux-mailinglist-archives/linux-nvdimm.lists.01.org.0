Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF2361926
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 07:18:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1ED8100EAB56;
	Thu, 15 Apr 2021 22:18:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.42; helo=mail-ej1-f42.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 20CD4100EAB54
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 22:18:22 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id r9so40258327ejj.3
        for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a50IcdnhgZEvsPlVOQCYwuiT5Nw59xUv8V7Dt7AB8ec=;
        b=Kx4vU7nL6+WWW9/bFW2xrYUssnTxFwAiQq1M1mij8fBbsBmU1EI/FApEAV0JPYUV3O
         8ScPtb77sQtWZTkMDnjBrSlTgPFL5tvZhO/vutCaZmdB15ZZTxxy+FVzYrwKptWCTWEw
         DcR4nrY76od53LRi4pUFYbgamvg0tLC2ND2gxl7hXBNTiK3nCwe4k4tKwYN0uuVqOhxc
         Gz2fKJF+GZzhbXM1X0dscDh4zzA3tKLtA2gntPcbhgSlw4W+T6JLBTtslniE8tDY15eQ
         HcRZ9wBvhTEstVT3WiEOhzJy2P1WVRu7By1iLebTwM9uwJZwd3i8ou3s/TVs7B0bIFHt
         a0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a50IcdnhgZEvsPlVOQCYwuiT5Nw59xUv8V7Dt7AB8ec=;
        b=qOLdjdI0Ig9tiudOfp/wthFCzwb8DlLrJgAsAUm0B54mFSLfvwVkbOuOod64tnVF9h
         3R1viHfjyYYTQTJbU2kShgvFHRIT5yhr+of9ytuf8ZykimLkdtCs5nCiNBSy8XIti03i
         t7KzOeyUEu8PhOqjAVBU3iNtjdOFC1HmmNw8QLKuEhDzuzlWtUuqlGieE8xFpH7nlF4u
         e1j0CsMCmQpVld+HhMMDekGNRPli/uZyk94gDKrdPOwZ2lnHVj0TkgLMjcxlEqRTv/46
         4vchFMTeO40afKxAvz8Wef16Ct355Y0qDUyQ/q9C7EgGYywCLxidGUjp0J01PsUTYuLT
         SLrw==
X-Gm-Message-State: AOAM53241FeUUCpQzI3w6HXWUF2u2sH91HNYuu03WJEmPXyO3a5jcFeg
	khLugUZ8EHOaNsnTxS3Y2gH6Rpm5/99MHDPzvhScXQ==
X-Google-Smtp-Source: ABdhPJzON0Yh7zxJFlJUIXPjsFg1VQTGGptwmZ97+vKn5UxbZ+RlSLTFihiznvOGyYOlfFFz+2jk0MoSZoVebbgAbrs=
X-Received: by 2002:a17:906:8407:: with SMTP id n7mr6532409ejx.264.1618550241023;
 Thu, 15 Apr 2021 22:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Apr 2021 22:17:09 -0700
Message-ID: <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID-Hash: NIIIAYY6K3MZSKNFASNTLMFY67PPMTB4
X-Message-ID-Hash: NIIIAYY6K3MZSKNFASNTLMFY67PPMTB4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NIIIAYY6K3MZSKNFASNTLMFY67PPMTB4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Strictly speaking the comparison between guid_t and raw buffer
> is not correct. Import GUID to variable of guid_t type and then
> compare.

Hmm, what about something like the following instead, because it adds
safety. Any concerns about evaluating x twice in a macro should be
alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
not an array.

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 8c5dde628405..bac01eec07a6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -681,7 +681,7 @@ int nfit_spa_type(struct acpi_nfit_system_address *spa)
        int i;

        for (i = 0; i < NFIT_UUID_MAX; i++)
-               if (guid_equal(to_nfit_uuid(i), (guid_t *)&spa->range_guid))
+               if (guid_equal(to_nfit_uuid(i), cast_guid(spa->range_guid)))
                        return i;
        return -1;
 }
diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 8cdc0d3567cd..cec1dc2ab994 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -33,6 +33,9 @@ typedef struct {
 extern const guid_t guid_null;
 extern const uuid_t uuid_null;

+#define cast_guid(x) ({ BUILD_BUG_ON(ARRAY_SIZE(x) != 16); (guid_t *)&(x); })
+#define cast_uuid(x) ({ BUILD_BUG_ON(ARRAY_SIZE(x) != 16); (uuid_t *)&(x); })
+
 static inline bool guid_equal(const guid_t *u1, const guid_t *u2)
 {
        return memcmp(u1, u2, sizeof(guid_t)) == 0;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
