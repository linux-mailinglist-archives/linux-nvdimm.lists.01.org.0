Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCA20FCED
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 21:45:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64038111F92BE;
	Tue, 30 Jun 2020 12:45:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 661B2111E7BFC
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 12:45:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so21786319ejb.11
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgx3IljQ5BIRlO4yBxZfoSES89T9T1+0rBYxa3AAvLM=;
        b=t0+UuWJ3hcB+YWsKOOBhSVmTSNzUldxsOxO8O0AnhZdpKk17xSwTbMukThuqybSmoS
         wPM9nDtRNNdaJZ9seKmg9WnnQIiG7+fm1ayOY/be0nmyli1ZCQpZBccV92DQjl+8S8x2
         CUQr0bxWU2o3O8hdNe/koalYIo4rtFz3bbftAS9vVB01TtpP+/Wmnd7/iTYdy8px6HBx
         GtZkEPaWLfRlFTzTh9gPxl6TdwuhmcukLic6t3NYXM1dX81E7IUk5cHkuExmv+CQjLgV
         ts5n/JMcHe/o+W339xE0TAxWtC/nWceBfqa7uQRoWYD2Vueouei+JJWjRbVCXLC7scDr
         fUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgx3IljQ5BIRlO4yBxZfoSES89T9T1+0rBYxa3AAvLM=;
        b=A5pdHMb77bx/9LPpmQIKK/SMEVXNf4L4JqGp1zglQg/2MlVfx0AGTRh9Pjh9SXP5bB
         3kaoaU6lxEYsQEN6d9iot7cjomd8pb9Gh11DWKlNLZNfNduf6Wv32BshlDuiT94VOmdL
         s+6Un9xxReH4EhNhxSJ1/GdV97H7ikhFGeDGVcqSsUblnoN41XX9dYceQe6rgVifBlFt
         IHp1wF+OcgCsnC2tYnPtNMhMdpX2f1IZA//DhVNmI4IH7Vfk3xRHr+7HHV1wca05AAtC
         lHdHnKRrNknEGoW8JLkQMSbnbeco59J90cJg0BtWK1OMinIlfVd6CIKCs31bNG8uR5c2
         XQEQ==
X-Gm-Message-State: AOAM530eVxHPChJUsChYBwL7iHDqOiLWAmRyaUQms82hoWGF4GxHXcBB
	A2r8UuqbsV1Ekxwc/sbQX/XASepMvbx2uwMvX0pf+A==
X-Google-Smtp-Source: ABdhPJyKl5EaEcTsTZ/D0hFYWRXDjmf8oBZd9cVwaYLp8hZe/lL/LJhRswILklwWIM5NrBKglrfm4H83B027mbEdiDg=
X-Received: by 2002:a17:906:da0f:: with SMTP id fi15mr19190809ejb.237.1593546341192;
 Tue, 30 Jun 2020 12:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com> <20200629160940.GU21462@kitsune.suse.cz>
 <87lfk5hahc.fsf@linux.ibm.com> <CAPcyv4hEV=Ps=t=3qsFq3Ob1jzf=ptoZmYTDkgr8D_G0op8uvQ@mail.gmail.com>
 <20200630085413.GW21462@kitsune.suse.cz> <9204289b-2274-b5c1-2cd5-8ed5ce28efb4@linux.ibm.com>
In-Reply-To: <9204289b-2274-b5c1-2cd5-8ed5ce28efb4@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jun 2020 12:45:30 -0700
Message-ID: <CAPcyv4gHHjifQcLMdVgo9CyixHxe6OkCYdQ7Jfu2YB7tBqpDNg@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: XUBWLRNN4A5ZGMOOLIIW744CSJ4YSWFB
X-Message-ID-Hash: XUBWLRNN4A5ZGMOOLIIW744CSJ4YSWFB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XUBWLRNN4A5ZGMOOLIIW744CSJ4YSWFB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 30, 2020 at 2:21 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
[..]
> >> The bio argument isn't for range based flushing, it is for flush
> >> operations that need to complete asynchronously.
> > How does the block layer determine that the pmem device needs
> > asynchronous fushing?
> >
>
>         set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>
> and dax_synchronous(dev)

Yes, but I think it is overkill to have an indirect function call just
for a single instruction.

How about something like this instead, to share a common pmem_wmb()
across x86 and powerpc.

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 20ff30c2ab93..b14009060c83 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1180,6 +1180,13 @@ int nvdimm_flush(struct nd_region *nd_region,
struct bio *bio)
 {
        int rc = 0;

+       /*
+        * pmem_wmb() is needed to 'sfence' all previous writes such
+        * that they are architecturally visible for the platform buffer
+        * flush.
+        */
+       pmem_wmb();
+
        if (!nd_region->flush)
                rc = generic_nvdimm_flush(nd_region);
        else {
@@ -1206,17 +1213,14 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
        idx = this_cpu_add_return(flush_idx, hash_32(current->pid + idx, 8));

        /*
-        * The first wmb() is needed to 'sfence' all previous writes
-        * such that they are architecturally visible for the platform
-        * buffer flush.  Note that we've already arranged for pmem
-        * writes to avoid the cache via memcpy_flushcache().  The final
-        * wmb() ensures ordering for the NVDIMM flush write.
+        * Note that we've already arranged for pmem writes to avoid the
+        * cache via memcpy_flushcache().  The final wmb() ensures
+        * ordering for the NVDIMM flush write.
         */
-       wmb();
        for (i = 0; i < nd_region->ndr_mappings; i++)
                if (ndrd_get_flush_wpq(ndrd, i, 0))
                        writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
-       wmb();
+       pmem_wmb();

        return 0;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
