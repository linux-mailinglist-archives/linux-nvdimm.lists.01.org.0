Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514762274F
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 May 2019 18:31:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 286882125583F;
	Sun, 19 May 2019 09:31:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B5239212108F7
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 09:30:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v10so8365735oib.1
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3ZWjYi0LKYa7s2y9DAZ3jQd7Kh/YEvIwC4LalouLic8=;
 b=Luuod+ac+cqT9612W1nKRVgtB2LCgQKBs4NJlcDhy7HrGiNNQGf06d5rORVlwN3CGB
 TaIc5OzVLB1sEgK0QSO+hZ+ZbfxQnarzygNSBmOeuvHYKmPQKz55rOkdjeeLhAduS0Cl
 Whv/M5f1dYJdSHAL78VZajSJTtn8JmnyMbIkOBTip/JQMIf7Eo+idAAA0WrwM00f2gAs
 EZC/QNGgD+1dWOdVNkCsvgOrImn7T9hBKRkg6QD+Bg1Mn6a2yRnuwls9seQDdaKtCJwr
 Wyehk1PTvrLaRBvI4oZSU81sqAOHaiA8/Kzt/nRBBJ9hthyaBW7x78DGfxHBlEP0Ddg7
 0eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3ZWjYi0LKYa7s2y9DAZ3jQd7Kh/YEvIwC4LalouLic8=;
 b=qD2r5pWa2yyA3RadzPusejQXjnilE8x3cdxEkXO3qzX7OYkqpKC35ieBBiprfJxbJu
 EkJAAu5O1EqOQxTguRti1L9jW9Tz8C3/obNS++F+WkqNvAV0u0zYoZMidPsit20f65Lc
 11/muNnZx8wjjpDIvDfcCPTwb8cTt1D2BTKWlXa94skUaEM60OzQAzuZmqcpcu5noFy1
 07VlNQfm4OsfoJBacPI8xvibmS32WZkEEaCOAIiYLllLjFlUxn+iuMgryCZuzwG+/UNy
 iwjdrFmvZOPXoiVQXw+3PMZJGu1u1w8nMeXcEHhlseh+wkV4wtWhnEkPzlgBQm7eoGPI
 78Ew==
X-Gm-Message-State: APjAAAVQgdq1ti+fqqHY3zu0MnQpwLV9gAQf7DkrMVc6GilDj1RkvqTu
 PcWTe+I30N4NN3pvDNGiNmqvzLV4xVyDglsWNFQl/g==
X-Google-Smtp-Source: APXvYqze7m+x1bk2ET/L1T1uLmwbLuZSspl+N/0zleTMGx5P4BoJcD1BBPDyS5Y4fzLP6m16+hvJ3Kgei0XNRfLkQjU=
X-Received: by 2002:aca:b641:: with SMTP id g62mr18495979oif.149.1558283457874; 
 Sun, 19 May 2019 09:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190514025449.9416-1-aneesh.kumar@linux.ibm.com>
 <875zq9m8zx.fsf@vajain21.in.ibm.com>
 <de5cbe7d-bd47-6793-1f1a-2274c5c59eb5@linux.ibm.com>
 <87sgtaddru.fsf@linux.ibm.com>
In-Reply-To: <87sgtaddru.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 19 May 2019 09:30:47 -0700
Message-ID: <CAPcyv4gi3NR4NFCQYYg2_Mpb7+qWGMsRodpf8sK1Pnz3+dCe3A@mail.gmail.com>
Subject: Re: [PATCH] mm/nvdimm: Pick the right alignment default when creating
 dax devices
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux MM <linux-mm@kvack.org>, Vaibhav Jain <vaibhav@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, May 19, 2019 at 1:55 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>
> Hi Dan,
>
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
> > On 5/17/19 8:19 PM, Vaibhav Jain wrote:
> >> Hi Aneesh,
> >>
>
> ....
>
> >>
> >>> +   /*
> >>> +    * Check whether the we support the alignment. For Dax if the
> >>> +    * superblock alignment is not matching, we won't initialize
> >>> +    * the device.
> >>> +    */
> >>> +   if (!nd_supported_alignment(align) &&
> >>> +       memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
> >> Suggestion to change this check to:
> >>
> >> if (memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN) &&
> >>     !nd_supported_alignment(align))
> >>
> >> It would look  a bit more natural i.e. "If the device has dax signature and alignment is
> >> not supported".
> >>
> >
> > I guess that should be !memcmp()? . I will send an updated patch with
> > the hash failure details in the commit message.
> >
>
> We need clarification on what the expected failure behaviour should be.
> The nd_pmem_probe doesn't really have a failure behaviour in this
> regard. For example.
>
> I created a dax device with 16M alignment
>
> {
>   "dev":"namespace0.0",
>   "mode":"devdax",
>   "map":"dev",
>   "size":"9.98 GiB (10.72 GB)",
>   "uuid":"ba62ef22-ebdf-4779-96f5-e6135383ed22",
>   "raw_uuid":"7b2492f9-7160-4ee9-9c3d-2f547d9ef3ee",
>   "daxregion":{
>     "id":0,
>     "size":"9.98 GiB (10.72 GB)",
>     "align":16777216,
>     "devices":[
>       {
>         "chardev":"dax0.0",
>         "size":"9.98 GiB (10.72 GB)"
>       }
>     ]
>   },
>   "align":16777216,
>   "numa_node":0,
>   "supported_alignments":[
>     65536,
>     16777216
>   ]
> }
>
> Now what we want is to fail the initialization of the device when we
> boot a kernel that doesn't support 16M page size. But with the
> nd_pmem_probe failure behaviour we now end up with
>
> [
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",
>     "map":"mem",
>     "size":10737418240,
>     "uuid":"7b2492f9-7160-4ee9-9c3d-2f547d9ef3ee",
>     "blockdev":"pmem0"
>   }
> ]
>
> So it did fallthrough the
>
>         /* if we find a valid info-block we'll come back as that personality */
>         if (nd_btt_probe(dev, ndns) == 0 || nd_pfn_probe(dev, ndns) == 0
>                         || nd_dax_probe(dev, ndns) == 0)
>                 return -ENXIO;
>
>         /* ...otherwise we're just a raw pmem device */
>         return pmem_attach_disk(dev, ndns);
>
>
> Is it ok if i update the code such that we don't do that default
> pmem_atach_disk if we have a label area?

Yes. This seems a new case where the driver finds a valid info-block,
but the capability to load that configuration is missing. So perhaps
special case a EOPNOTSUPP return code from those info-block probe
routines as "fail, and don't fallback to a raw device".
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
