Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262B13CD55
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 20:44:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F00CA10097DD3;
	Wed, 15 Jan 2020 11:48:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 871BF100DC3E2
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 11:48:00 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 77so17179291oty.6
        for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9lmkxhOK8RALAleUIVCgSkysugra+Rjv945slR1G1U=;
        b=Ucv4ed8viRSxJFUeGKAGs6Gy+7uWsdMntUwYN7sJ2sa1J08QDHqMY1zCv/skkNS8dM
         uiRUvHw0wAqjojW1g8Um7JvreVpbAVydXUM+xQdMjH7ujsQmrSH02Lw8j7Dy5qou3s96
         LNYt6oEGozB1B+l/1sshCuCH4yuCWPEDoJ4HnQAFTE8GwDslx28fh3q4hvRIbre6pGf0
         9QLa9S0F8JmfRU22TmIjJ8fNL1kzrDCxpU1LRnhp6PmX3h0t+CmAtHPhf7mi+JgQvsEt
         0zqlcgZA7jVtDZ76xX/pIB4kgY7TjUCdufb7Lk4Eq5E3pollnbs1ifvuAFyM2/6cvTIF
         mYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9lmkxhOK8RALAleUIVCgSkysugra+Rjv945slR1G1U=;
        b=S1LYsFk90COe98JIWgMRaN1NLjFCOd6eE4SBSeJgL+DajQi1snyGuZkps64EiS7R1P
         UdhjWH05j0mvfme+sLnpB48IEGUG55FVwzsqnQto+yW29D4YbYMd9pFoyy337Uyzwlc7
         bbzhLpUM8wzSrO6Ama57sAG//aPivNFzZeRSrBkkDnBnabTegeIo5T8Ty++rA4jwn2Gq
         9dCDiU/TuA3AZFkriXs9LyJEXIEX86ZkWnEN1MTmj1rRgu03rFkGFB+R4Dfd+YDAu7mN
         7/7AbKDa0AFgWhAelMGYjsFzdxnr+/w5ei+II3f5ey0POy/EeRe6jMxtUkc/i1tp+oGw
         bGbg==
X-Gm-Message-State: APjAAAVEBEGNvM2HEvklDBI1FiEYDD7neZx1I6lHmYbjeJb0QNfz/d6/
	uuutzAJlYFS8FOuc7Q2tkrRJ2R0Rk5alzTD5YfZG6w==
X-Google-Smtp-Source: APXvYqz3lRM1//AYzlDfYDkE/8e4RSpDQKX/Gk1trrP8yaI6glld87mcClkkO/m6Wl3mUfRp7AewpnBEw6JAytcrkz4=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr3860252oto.207.1579117480890;
 Wed, 15 Jan 2020 11:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
 <x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com> <a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
 <0f44df90-1f75-9d0a-10af-6e7f48158bc7@linux.ibm.com>
In-Reply-To: <0f44df90-1f75-9d0a-10af-6e7f48158bc7@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 Jan 2020 11:44:29 -0800
Message-ID: <CAPcyv4hRhYUcCyCMET1i2bkUEjp_MWVj0hEr3mVBp24Oq4Yauw@mail.gmail.com>
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain values
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: WJUZ6CFXBZM6GBNKZYJRAP6Z42C6F6KP
X-Message-ID-Hash: WJUZ6CFXBZM6GBNKZYJRAP6Z42C6F6KP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WJUZ6CFXBZM6GBNKZYJRAP6Z42C6F6KP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 15, 2020 at 9:31 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 1/15/20 10:57 PM, Aneesh Kumar K.V wrote:
> > On 1/15/20 10:25 PM, Jeff Moyer wrote:
> >> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >>
> >>> Currently, kernel shows the below values
> >>>     "persistence_domain":"cpu_cache"
> >>>     "persistence_domain":"memory_controller"
> >>>     "persistence_domain":"unknown"
> >>>
> >>> This patch updates the meaning of these values such that
> >>>
> >>> "cpu_cache" indicates no extra instructions is needed to ensure the
> >>> persistence
> >>> of data in the pmem media on power failure.
> >>>
> >>> "memory_controller" indicates platform provided instructions need to
> >>> be issued
> >>> as per documented sequence to make sure data flushed is guaranteed to
> >>> be on pmem
> >>> media in case of system power loss.
> >>>
> >>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >>> ---
> >>>   arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
> >>>   include/linux/libnvdimm.h                 | 6 +++---
> >>>   2 files changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c
> >>> b/arch/powerpc/platforms/pseries/papr_scm.c
> >>> index c2ef320ba1bf..26a5ef263758 100644
> >>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> >>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> >>> @@ -360,8 +360,13 @@ static int papr_scm_nvdimm_init(struct
> >>> papr_scm_priv *p)
> >>>       if (p->is_volatile)
> >>>           p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
> >>> -    else
> >>> +    else {
> >>> +        /*
> >>> +         * We need to flush things correctly to guarantee persistance
> >>> +         */
> >>> +        set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
> >>>           p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
> >>> +    }
> >>>       if (!p->region) {
> >>>           dev_err(dev, "Error registering region %pR from %pOF\n",
> >>>                   ndr_desc.res, p->dn);
> >>
> >> Would you also update of_pmem to indicate the persistence domain,
> >> please?
> >>
> >
> > sure.
> >
> >
> >>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> >>> index f2a33f2e3ba8..9126737377e1 100644
> >>> --- a/include/linux/libnvdimm.h
> >>> +++ b/include/linux/libnvdimm.h
> >>> @@ -52,9 +52,9 @@ enum {
> >>>        */
> >>>       ND_REGION_PERSIST_CACHE = 1,
> >>>       /*
> >>> -     * Platform provides mechanisms to automatically flush outstanding
> >>> -     * write data from memory controler to pmem on system power loss.
> >>> -     * (ADR)
> >>> +     * Platform provides instructions to flush data such that on
> >>> completion
> >>> +     * of the instructions, data flushed is guaranteed to be on pmem
> >>> even
> >>> +     * in case of a system power loss.
> >>
> >> I find the prior description easier to understand.
> >
> >
> > I was trying to avoid the term 'automatically, 'memory controler' and
> > ADR. Can I update the above as
> >
> > /*
> >   * Platform provides mechanisms to flush outstanding write data
> >   * to pmem on system power loss.
> >   */
> >
>
> Wanted to add more details. So with the above interpretation, if the
> persistence_domain is found to be 'cpu_cache', application can expect a
> store instruction to guarantee persistence.

The expectation is globally visible stores are persisted

> If it is 'none' there is no
> persistence ( I am not sure how that is the difference from 'volatile'
> pmem region).

"None" means the "platform does not enumerate a persistence domain".
That's not necessarily "volatile" because the user may know that they
have battery backup, or some other private/out-of-band capability not
exported by the platform. In which case they would manually need to
manipulate the pmemX/write_cache property manually.

> If it is  'memory_controller' ( I am not sure whether that
> is the right term), application needs to follow the recommended
> mechanism to flush write data to pmem.

If it is memory_controller the expectation is that flushing data out
of the cpu caches and making those writebacks to memory globally
visible is sufficient for the platform to persist flushed data on a
power loss.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
