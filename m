Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF516F31F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 00:24:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAD4B10FC36C8;
	Tue, 25 Feb 2020 15:24:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BEC010FC36C2
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 15:24:50 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h9so1173162otj.11
        for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 15:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQJlCFQ0lgHZLa4+7u7RKnEhf4CTE4QT+ia+iBNrQK4=;
        b=bL8p4/kmJJOGCRUjNF+hU2jQRf2f2cYp77zunbqGpQ4B35bbuWCMXZP6g3tVulNiZ9
         dc2ohFuqjkdXhzTQ8eSsXH3ms9uodF4JfVFECGEFuFDWr7BMQa0T7WrJ4R9mE5olSzv5
         BSedLvQflWl5bABbW/hScblLNJVY2AChvVJZWWClAPMIxQjo9fgd4D3FO795nfs1dJ3R
         PkLfog5DRIjzFHCnZYGEM1+fp/3g9wxoWatINmT8lzkWIjbE20ov7bwkufFsI/3sj9ts
         liKp9haZ8DAgp4DkXTM+eaGBmvApQmY7c6cRMnPkQqcjwOwBGp2ilnfuyMh8bR//zL0z
         yhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQJlCFQ0lgHZLa4+7u7RKnEhf4CTE4QT+ia+iBNrQK4=;
        b=oCMrCvYmc1GQ2VprTgAHQJtEKZX1nGlZlXLwNH69bYJCh2+7MJcYniEi5Fk1ZvGZsx
         WtdSWsloZFrlJItkuGi6IoPKw9Cqhnt55V8p9oP6yNPfqnKKN2tmSSftwH+2/Slh8M1I
         uh25JCqC7CGhWG/rz8KMdbq9XZR45d7l/r23ytPBGk3app4AKYBw7nkEPn0WOTSF5FIT
         /U1yjEHYdVFeBgioyiF1jCNOsiNdbIjpYG/OF6xGkJDRxCiGEHdNAGGYm+9k50PU8UcO
         OVqVYbJX/IGB7vI7cncBKSnuYTDzRxiX+10aCEu3Q3nBHAKnUJYf82MPRoxzYmT1RyNz
         3IUA==
X-Gm-Message-State: APjAAAUDVXwcL20UdCL3QdKfvOPzLvcAA/CM6w5re2RL211/fFH3bEG9
	pOw9DrCDijT+Js27g2v7YfaqBoX9Ou0eLgTgGpe/+Kz7
X-Google-Smtp-Source: APXvYqwUzAl4JHSZT9I9vId6f2cp8Mpq8NgJiKgugmbX/dpG17VL/IuNnHbxq2afaMuvybOH/f8OYLRfNPLvlfDwA3o=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr756709oti.207.1582673038112;
 Tue, 25 Feb 2020 15:23:58 -0800 (PST)
MIME-Version: 1.0
References: <158042414995.3946705.2742716492944802875.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158042415512.3946705.18330231517256727320.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49o8tulai8.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49o8tulai8.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Feb 2020 15:23:47 -0800
Message-ID: <CAPcyv4izzfzrb2r7Mc7FfryGnBcn1bOUA8a6_L9t2fKR4caoXw@mail.gmail.com>
Subject: Re: [ndctl PATCH 1/2] ndctl/region: Support ndctl_region_{get, set}_align()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: 2F5LFHESHDXTFAEQV4KBYIXTKIIO3YXL
X-Message-ID-Hash: 2F5LFHESHDXTFAEQV4KBYIXTKIIO3YXL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2F5LFHESHDXTFAEQV4KBYIXTKIIO3YXL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 19, 2020 at 10:04 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> >
> > +NDCTL_EXPORT unsigned long ndctl_region_get_align(struct ndctl_region *region)
> > +{
> > +     return region->align;
> > +}
> > +
> > +NDCTL_EXPORT int ndctl_region_set_align(struct ndctl_region *region,
> > +             unsigned long align)
> > +{
> > +     struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
> > +     char *path = region->region_buf;
> > +     int len = region->buf_len, rc;
> > +     char buf[SYSFS_ATTR_SIZE];
> > +
> > +     if (snprintf(path, len, "%s/align", region->region_path) >= len) {
> > +             err(ctx, "%s: buffer too small!\n",
> > +                             ndctl_region_get_devname(region));
> > +             return -ENXIO;
> > +     }
> > +
> > +     sprintf(buf, "%#lx\n", align);
> > +     rc = sysfs_write_attr(ctx, path, buf);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     region->align = align;
> > +     return 0;
> > +}
> > +
>
> Missing doctext.  Specifically, there should be a big, fat warning
> against changing the region alignment.

I don't mind adding one, but is this the right place to document an
API warning? If the audience is future ndctl developers that should be
warned to keep the status quo of not plumbing this capability into
"create-namespace" that's one message. If it's to stop other libndctl
application developers, they'll likely never see this source file.

As it stands there is
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
