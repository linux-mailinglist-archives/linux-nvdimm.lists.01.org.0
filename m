Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC8173CDC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 17:27:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7002C10FC3370;
	Fri, 28 Feb 2020 08:28:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CBF1D10078091
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 08:27:58 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j16so3142422otl.1
        for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akPX/Le0d2EiQmbAvQA94ZihJyml6bsfezTs1xR+aWI=;
        b=bukCJoLWpFuG4kP9cdoMOAtCcw6mtymH0738+Cr/dDuwu2ERG+5ejt9RigalXEkE32
         ogfqK+z82ZNA/pFMw3Cu3QBXiOahIJfVWFrSmMRHS/dIAbAT8wPAeq/8mbKwzGbs87el
         vvNtku4b4DFwyy2BaTPexmQz08UfnrFhesbV0UQsYbBzUnOuocPHTK+SKO6ylLGpWw9h
         Q59r+4Gy7GuB89UgLq2iltRlyb851aKavJ+mzpWZYrohrqmC2lFhYZEOIfwymFvKJz7g
         fsLSmh+43Inz1Qqeyiq/bD/wEsiC3YMv33ThnmFvBY8AOX+YrlWks1wsVEeDIpKM5wou
         FpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akPX/Le0d2EiQmbAvQA94ZihJyml6bsfezTs1xR+aWI=;
        b=Ek3/SnSa/CBuKDdpiu5OHpxVAqYizski9TCDeBzuXAXfzNSyYVRBa2zCrKP91PMjfx
         sOMo351qw1L3CqRYRUK1hNHLlWiLOI0GO8Fs5Mu+k433jz7547CDYY5h/880C/xGKzDM
         4LkrzkNzVKZWKKyenlPBBBzAWfe0C4w1XGflZ5WQHh3W2PvzPxfXvqNVFGdY/TtR/4ly
         VgpUYcsLY+AyNLudSryI4ErD/ENz0ux3KZIzHegEX9icGwzxQ+3uHVkPw5ZiptF3f7Sk
         24c0T+1fBncnC7JxipeLHZFpiO0z3wGaG5L2lNbSFg9cS1Ffl6rtv+EJbnl0XUOuMppb
         FUAA==
X-Gm-Message-State: APjAAAU5z54qNNtAWRuLmL4GvOqTWEDwJJ77SjE67s5CIgYWRnwUo7fx
	SuMJ28fEP/apnGirOV+jYeVBF5m9AF8u0YhlCUI8Dw==
X-Google-Smtp-Source: APXvYqxPIfQgCnD3v9HTx5cFPLUInp7b+fRgEsmGH/hBamVfDcdplRO8p87KJZr4ZSNSQycJp3mYOu5p6SffilbLu3s=
X-Received: by 2002:a9d:6c9:: with SMTP id 67mr4103721otx.363.1582907225590;
 Fri, 28 Feb 2020 08:27:05 -0800 (PST)
MIME-Version: 1.0
References: <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com> <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com> <20200223230330.GE10737@dread.disaster.area>
 <20200224153844.GB14651@redhat.com> <20200227030248.GG10737@dread.disaster.area>
 <CAPcyv4gTSb-xZ2k938HxQeAXATvGg1aSkEGPfrzeQAz9idkgzQ@mail.gmail.com>
 <20200228013054.GO10737@dread.disaster.area> <CAPcyv4i2vjUGrwaRsjp1-L0wFf0a00e46F-SUbocQBkiQ3M1kg@mail.gmail.com>
 <20200228140508.GA2987@infradead.org>
In-Reply-To: <20200228140508.GA2987@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Feb 2020 08:26:54 -0800
Message-ID: <CAPcyv4ivX2cah1YLBZzWPdULOFX7Ds4nuboPh4mf94uN1YeMVg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: GAD7S7WJHZMTVOIQL6GGRKU5KSLJACT4
X-Message-ID-Hash: GAD7S7WJHZMTVOIQL6GGRKU5KSLJACT4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GAD7S7WJHZMTVOIQL6GGRKU5KSLJACT4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 28, 2020 at 6:05 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Feb 27, 2020 at 07:28:41PM -0800, Dan Williams wrote:
> > "don't perform generic memory-error-handling, there's an fs that owns
> > this daxdev and wants to disposition errors". The fs/dax.c
> > infrastructure that sets up ->index and ->mapping would still need to
> > be there for ext4 until its ready to take on the same responsibility.
> > Last I checked the ext4 reverse mapping implementation was not as
> > capable as XFS. This goes back to why the initial design avoided
> > relying on not universally available / stable reverse-mapping
> > facilities and opted for extending the generic mm/memory-failure.c
> > implementation.
>
> The important but is that we stop using ->index and ->mapping when XFS
> is used as that enables using DAX+reflinks, which actually is the most
> requested DAX feature on XFS (way more than silly runtime flag switches
> for example).

Understood. To be clear the plan we are marching to is knock down all
the known objections to the removal of the "experimental" designation.
reflink is on that list and so is per-file dax. The thought was that
pef-file dax was a nearer term goal than reflink.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
