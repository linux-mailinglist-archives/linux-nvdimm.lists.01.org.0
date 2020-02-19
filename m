Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94227164D3C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 19:01:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2498410FC319D;
	Wed, 19 Feb 2020 10:02:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4896110FC316E
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 10:02:40 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id z2so24684917oih.6
        for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQWZXbfJ6Cx92rg8W4AXloDsng7FMNKKi5CY+KNrhGw=;
        b=tqMYimAkhK7RVKS8/vwu6UIGvXGJWO1DJAsX/SR+EtI2384Y7mNAJ1aMgXfv71Z3Vy
         9xxS/hQ4NOW2L8bBL3V5VIpNy7ds1JUjLC0GdheDQcYDp+5rntYZLTMk1cqjwhI821h2
         dlmbovN6N+2PE9OoasFuNdWuXuUormRiu+mRoS82RMJnjilYoRCqlIrO2G8eB9kEykgs
         lkKmzLjWKQYUx9rowXQdrXV/PW7Oy6+k5SFWqRK45DDE5MBxxdAdcKA/0sj+11m+eOVK
         rEhEeTw7UEbi0g700N5TuGrpnQtfk9FylOv5exvlQI/yECLrBAmDvOtbdw951HQXH9tj
         rWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQWZXbfJ6Cx92rg8W4AXloDsng7FMNKKi5CY+KNrhGw=;
        b=QMxZLExDr7/xF6QHvUM2V7xARh1PL0KODcGZrbnp9Vc6A1Z+VH5P27Y18OnISurEWH
         xRWQpVC9NJHWaxycfcXQ+lV/HBXq38U2yfysl62orhYo8/zNTno579Obn0jOhhAqbyG9
         CeET5rY4rmDCEzb9i1qUbKenBBrgwC3PxoUAVsSkHo1spxmt7eFxmvqenslT3H1YFLMr
         83c8Kg3rl5xMZyLy7+c8m49Nt3bX14K7X9eveoNpAmFQji3ex3f3sFUJctPDV6qfnuat
         xZczj64NaPiHelmBxnuQyl04rX3y2ojzljHjQqh4ayL4ROVD5J9qpdVI14DI4XoWgFg0
         Oybw==
X-Gm-Message-State: APjAAAVIX8LTnEsfO44uAv2sV+4VJhxKUkNNFha+7/udt83pptxqXNmR
	bMm0yhn+FfUKmWTtgJDS7/EyxXsDkIittA4i7ke3mLJh
X-Google-Smtp-Source: APXvYqwpX9ZiIfJp0CjbmWzTQNZI75LSXlufA+2j9HnZawZxxZhyJ1ichxk2LnBIpYumj0IT29Q/ek/L1AeBa1/OhY4=
X-Received: by 2002:a54:4791:: with SMTP id o17mr5116907oic.70.1582135306238;
 Wed, 19 Feb 2020 10:01:46 -0800 (PST)
MIME-Version: 1.0
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49sgj6law0.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49sgj6law0.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Feb 2020 10:01:35 -0800
Message-ID: <CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose listing
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: JBWGW725NJUCS6GLE57KFHBZQICL22GN
X-Message-ID-Hash: JBWGW725NJUCS6GLE57KFHBZQICL22GN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JBWGW725NJUCS6GLE57KFHBZQICL22GN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 19, 2020 at 9:56 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The only expected difference between "ndctl list -R" and "ndctl list
> > -Rv" is some additional output fields. Instead it currently results in
> > the region array being contained in a named "regions" list object.
> >
> > # ndctl list -R -r 0
> > [
> >   {
> >     "dev":"region0",
> >     "size":4294967296,
> >     "available_size":0,
> >     "max_available_extent":0,
> >     "type":"pmem",
> >     "persistence_domain":"unknown"
> >   }
> > ]
> >
> > # ndctl list -Rv -r 0
> > {
> >   "regions":[
> >     {
> >       "dev":"region0",
> >       "size":4294967296,
> >       "available_size":0,
> >       "max_available_extent":0,
> >       "type":"pmem",
> >       "numa_node":0,
> >       "target_node":2,
> >       "persistence_domain":"unknown",
> >       "namespaces":[
> >         {
> >           "dev":"namespace0.0",
> >           "mode":"fsdax",
> >           "map":"mem",
> >           "size":4294967296,
> >           "sector_size":512,
> >           "blockdev":"pmem0",
> >           "numa_node":0,
> >           "target_node":2
> >         }
> >       ]
> >     }
> >   ]
> > }
> >
> > Drop the named list, by not including namespaces in the listing. Extra
> > objects only appear at the -vv level. "ndctl list -v" and "ndctl list
> > -Nv" are synonyms and behave as expected.
> >
> > # ndctl list -Rv -r 0
> > [
> >   {
> >     "dev":"region0",
> >     "size":4294967296,
> >     "available_size":0,
> >     "max_available_extent":0,
> >     "type":"pmem",
> >     "numa_node":0,
> >     "target_node":2,
> >     "persistence_domain":"unknown"
> >   }
> > ]
> >
>
> Will this break existing code that parses the javascript output?

Always a potential for that. That said, I'd rather attempt to make it
symmetric and replace it if someone screams, rather than let this
quirk persist because it makes it impossible to ingest region data
with the same script across -R and -Rv.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
