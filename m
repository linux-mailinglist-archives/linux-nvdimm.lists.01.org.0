Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D165421C14B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jul 2020 02:53:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07AB811154D1F;
	Fri, 10 Jul 2020 17:53:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 583D8100EB3EE
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 17:53:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a1so494213edt.10
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Rls/U/lDsLfT4D3DE5n9+9Nu0A90fUMZ5H2LpZadpY=;
        b=iPPbSg9QOhO1/J2AGGABUiWYW1G+aZBlYGBwtZRUeuvTEkRismRqyyYYb/b5HtXFzD
         eT6GM4fHT57mSqaeCJSPWS/lhpqKIIW/IEcSX0sOK4gzky06Dhnp/Ip1OIIpfdUL4I9D
         zaf7XYwr0+dyWUSgZz/fIP6VpjQimltNJozru9KMByXvX/GmYaTxeawAnzBI049LwHqK
         QyTtiHGsXlvVd8xwGIQmR9G52VI1TJAAt9K92hcxV/pbQ4SMotmatFqvGtbVlMbDTsbL
         X0IogtzxzfRftbdheB9eRV8vW+J7XAIlFm6MBfLuy3kRg+Ca6FB45eVJjJ060lXd8Yag
         +wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Rls/U/lDsLfT4D3DE5n9+9Nu0A90fUMZ5H2LpZadpY=;
        b=B+wx2TXHfjpiRgbs/HliNmOqR6xNJAeOrIacvNzacSyEWYKMpDS+4FjMBNhPrkh1ye
         F5iWfxQ0bJ3/8ysYrr7SpZWkkr3l9J0+A1VPE0Fq+m/uMjbqqb51p40U7mIw/zEdL90K
         u5xTg5VkGWFMEotR1q9zOn6af0PE1Bp4HEkgd3cmaQIuoHueIzRgCBLvJRMiLTN2/jGU
         2BEJI+fbLEhD6njhtTAqewJZzEHRBsr02V0Bkgg1/SwB9DniDwWAQ/udA3NbyZq7jMpZ
         m2Uhsk1fXf2KVLA4C318mhQXxcp3l+4W5tnjZbv32ajETGVxKSon8/7Pxg204vktLYo4
         k0cw==
X-Gm-Message-State: AOAM533e6UGxsIr94j9joCRIul9F3Pmf2atQW5oN4B4oiMRDYyl/Oeqw
	vKatV/Y0D29QhJQmBms7rqaXrCfYHOtguvRoj7c1aQ==
X-Google-Smtp-Source: ABdhPJzFhcpJg+WtMu5QLudWk0KLldzkSq/YYsINvRouju8S48SBuHcb7Lqaek9OHZZ2kIe4eSSfayb2v5gUYFCpvG0=
X-Received: by 2002:a50:a1e7:: with SMTP id 94mr77926426edk.165.1594428781622;
 Fri, 10 Jul 2020 17:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <d7043cad-076d-d065-f933-b772b4e9c131@oracle.com>
In-Reply-To: <d7043cad-076d-d065-f933-b772b4e9c131@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jul 2020 17:52:50 -0700
Message-ID: <CAPcyv4ie3pavOzPP68jGdeT1UK2eMjiZwiwvw1Jzy6D-d_pxjg@mail.gmail.com>
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: P6YQ353F4C7Z7Z2ZGJ5AQTNMD3ABAUAG
X-Message-ID-Hash: P6YQ353F4C7Z7Z2ZGJ5AQTNMD3ABAUAG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P6YQ353F4C7Z7Z2ZGJ5AQTNMD3ABAUAG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 12, 2020 at 7:37 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
> > @@ -561,13 +580,26 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> >       if (start == U64_MAX)
> >               return -EINVAL;
> >
> > +     ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> > +                     * (dev_dax->nr_range + 1), GFP_KERNEL);
> > +     if (!ranges)
> > +             return -ENOMEM;
> > +
> >       alloc = __request_region(res, start, size, dev_name(dev), 0);
> > -     if (!alloc)
> > +     if (!alloc) {
> > +             kfree(ranges);
> >               return -ENOMEM;
> > +     }
>
> Noticed this yesterday while looking at alloc_dev_dax_range().
>
> Is it correct to free @ranges here on __request_region failure?
>
> IIUC krealloc() would free dev_dax->ranges if it succeeds, leaving us without
> any valid ranges if __request_region failure case indeed frees @ranges. These
> @ranges are being used afterwards when we delete the interface and free the
> assigned regions. Perhaps we should remove the kfree() above and set
> dev_dax->ranges instead before __request_region; or alternatively change the
> call order between krealloc and __request_region? FWIW, krealloc checks if the
> object being reallocated already meets the requested size, so perhaps there's no
> harm with going with the former.

Yeah, the kfree is bogus. It can just wait until the device is
destroyed to be freed, but only if there is an existing allocation. If
this is a new allocation then nothing else will do the kfree.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
