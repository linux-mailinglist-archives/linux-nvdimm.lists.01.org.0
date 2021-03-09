Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF10332C3A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 17:37:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C84DF100EB835;
	Tue,  9 Mar 2021 08:37:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2F3C100EBB7E
	for <linux-nvdimm@lists.01.org>; Tue,  9 Mar 2021 08:36:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w9so21435794edc.11
        for <linux-nvdimm@lists.01.org>; Tue, 09 Mar 2021 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/fpSmEn/Omnn9hT4CF3J0SxPNZ3B3Al6CQWKVqNiBQ=;
        b=StNMHMhRfB8T/5YxpdFifEdg64ybP3EsolQTfz9j8mT99xOZm4AP2PLj7Lj9Vz8yxG
         t5u2mGMp0ID0D2xI8sewZ7MWYrJpiZf9DOe+jqwFthRMU64XdYV/mO36V14t786ILnIk
         NTCWj5xpdpoohcsKdU048Qt/svji00BGtnFKLOPAz0HnCpdFfdFOseG6w2cbR0I61l+q
         ylc00Qdh7rjzdHbe91XpFhqJElhF8V1IG2GSkNBs613QrMQKTdnSt3JUBY4C0RzkWEie
         qpFxLVikQOfstznmBtOfKLxIaeAcH7Bsla0eOGj/AxQ+1Kaykq6N9GN770mMWhm9x6Dv
         Pq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/fpSmEn/Omnn9hT4CF3J0SxPNZ3B3Al6CQWKVqNiBQ=;
        b=TjCwt9MmIRWoNBlKV5RtUawo9oTvEHsGP/VP/kTr5uabSNM/KY6Rkx+4xj8Be4aBsQ
         ZBHb7UVxioj21BrDtUBDS2HTkv6zSkSygTBtSL5O4T7P0o+Ge/3hGfltDXaefVWf59Fq
         NbOA1gCieB9WuiR3a9EFmrTfVOHNTDLw3uUY1l4QVcF3HvvUOKe3fxnZEdSb2jE4m3Sb
         239bP+KOvM6wG4mI/co+/T6FCrda6X7/iGGMJxxHfjc3hgM3t6AhkL+h3QG4PXJf74bL
         sfPvUE4ZrqPiE1oVj8vzbSHFRNnQohAzLlp5nNPHCpLf6qpWZS3pjy2FxmQEvEHTQCVN
         JItA==
X-Gm-Message-State: AOAM532CHWIjiYid2Z5JCv5iJsG7b2x3Po0qN+zFIlJ98rBQA8QH9N7Z
	rWSTYFCSHZtlYaLxdJXRMtkvm/w6t8W/a+7BXKJoQg==
X-Google-Smtp-Source: ABdhPJyzPjVHBi3eKHJ3wMsoze0wVkKY9whBDXBrbn5HcD+NO5qt8MclSQ/sO8bdsyXTxsn1FW30Wg1M45vhSD/6jKQ=
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr5285330edv.210.1615307815848;
 Tue, 09 Mar 2021 08:36:55 -0800 (PST)
MIME-Version: 1.0
References: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210309073110.GA3140@lst.de>
In-Reply-To: <20210309073110.GA3140@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 9 Mar 2021 08:36:53 -0800
Message-ID: <CAPcyv4iQShzBxyZcn+H=2DGnnpifaV_e=5yBaGA1sF+ESS0jAQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Let revalidate_disk() revalidate region read-only
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: IFOHQL4WVJFBHAC6O2ZWIEQKE743YU47
X-Message-ID-Hash: IFOHQL4WVJFBHAC6O2ZWIEQKE743YU47
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IFOHQL4WVJFBHAC6O2ZWIEQKE743YU47/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 8, 2021 at 11:31 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Mar 08, 2021 at 10:54:22PM -0800, Dan Williams wrote:
> > Previous kernels allowed the BLKROSET to override the disk's read-only
> > status. With that situation fixed the pmem driver needs to rely on
> > revalidate_disk() to clear the disk read-only status after the host
> > region has been marked read-write.
> >
> > Recall that when libnvdimm determines that the persistent memory has
> > lost persistence (for example lack of energy to flush from DRAM to FLASH
> > on an NVDIMM-N device) it marks the region read-only, but that state can
> > be overridden by the user via:
> >
> >    echo 0 > /sys/bus/nd/devices/regionX/read_only
> >
> > ...to date there is no notification that the region has restored
> > persistence, so the user override is the only recovery.
>
> I've just resent my series to kill of ->revalidate_disk for good, so this
> obvious makes me a little unhappy.  Given that ->revalidate_disk
> only ends up beeing called from the same path that ->open is called,
> why can't you just hook this up from the open method?
>
> Also any reason the sysfs attribute can't just directly propagate the
> information to the disk?

I should have assumed that revalidate_disk() was on the chopping
block. Let me take a look at just propagating from the region update
down to all affected disks. There's already a notification path for
regions to communicate badblocks, should be straightforward to reuse
for read-only updates.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
