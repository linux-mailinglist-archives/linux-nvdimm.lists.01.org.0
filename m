Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14FE8DF9D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 23:06:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8FBDD202B75E0;
	Wed, 14 Aug 2019 14:08:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6075D202B75DB
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 14:08:40 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t24so35750oij.13
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5zDBwvpLyFVSkpJn8WQbGXXGIeiLWE8u296DugBnVIM=;
 b=qx+Jm3ca+9U4p9pb39tK1gJ0waXX8b+VFuCeaflTZELVIi06SA4fEE8Q8c8cDSM3/K
 lU0ElyrjHGF1vXrGFMp1kBfJ9SFlzmZxFldO2OmoUeU6t3NYYeSSDb1SmUw9nOKfoGTO
 8IHIboBhdEPAo9QKP+HdD+gDuLvCLXUDOAqSednRksqyzZb5+BH+Keuy4z8zEw9Jdu5F
 tkct6AZ5mKheTo+kCLkgx+8FSy/USdS1seX9NeADhP12yTqK6mY7aReOJSb8N1vO/IuF
 0X7ortNtNF2sgb6oTMuN94oUiSsrWqMx0igWRxtET58OAvd+L/A7vLwebyd1w4eDMJOb
 G+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5zDBwvpLyFVSkpJn8WQbGXXGIeiLWE8u296DugBnVIM=;
 b=iPi4NIOkwFfmeoGefBpn6cesL2f8sIbVKS3o9v4AaZF+keSX5uOKIY6eiu3lUJxmky
 ru5BuyGL/7MLzBnAmOtZU8YmjJZY6qF0DIx8WkPl8WfvAqdC6qtnJPq4T+D1Fr4f3qxs
 2bnFbdW2C8pbIWcRWS8bw8AV/+J8Jgjmr25qLRHCtr5yn/br70C/bF2RsnrCMjZsHBUF
 1RSgmo06eqt0AtnybEmXvgBHjpoq2nN4pQ/oHMLFZzIkehvKhi0ZoG1YVz91NQdUsMNS
 U/qSpQKkI/hxPvLmN7rLUYN/gOc6uuCLQl+uy0HohEn7dkSQZpx/kofqv0YgZZ0xt6NR
 Is3Q==
X-Gm-Message-State: APjAAAXYETye2LA6y5fF52P2juZQQT7ZRR6xbJR7BVLWDwLMrO71Rfna
 sTCLUfSSUQp7hN6QnmOSFZscL7R+GVyW7DhmK/pSdQ==
X-Google-Smtp-Source: APXvYqyRjddj0M4/z6rqv1Q6XdbswhzEEmpUUUwmnRazEyo7/hX6/nr7dXCmtJrH+7ZuwIRE5B7wvUUvm+H+WvGFpL0=
X-Received: by 2002:a05:6808:914:: with SMTP id
 w20mr1224601oih.73.1565816795758; 
 Wed, 14 Aug 2019 14:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190809074520.27115-1-aneesh.kumar@linux.ibm.com>
 <20190809074520.27115-3-aneesh.kumar@linux.ibm.com>
 <8736i9r6po.fsf@linux.ibm.com>
In-Reply-To: <8736i9r6po.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 14 Aug 2019 14:06:24 -0700
Message-ID: <CAPcyv4h+xY9hmb6bznp4ciJdrtDc_p7HLQhOz1JLqzLf+BVUug@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm/nvdimm: Add page size and struct page size to
 pfn superblock
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 9, 2019 at 9:21 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>         case PFN_MODE_PMEM:
> > @@ -475,6 +484,20 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
> >               align = 1UL << ilog2(offset);
> >       mode = le32_to_cpu(pfn_sb->mode);
> >
> > +     if (le32_to_cpu(pfn_sb->page_size) != PAGE_SIZE) {

I think this is too strict. It's only a potential problem in the
"pfn_sb->page_size > PAGE_SIZE" case, because only then might the
existing reservation for the memmap be too small. Otherwise, unless
I'm missing something, there should be no ill effects for
under-utilizing the reservation.

> > +             dev_err(&nd_pfn->dev,
> > +                     "init failed, page size mismatch %d\n",
> > +                     le32_to_cpu(pfn_sb->page_size));
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (le16_to_cpu(pfn_sb->page_struct_size) < sizeof(struct page)) {
> > +             dev_err(&nd_pfn->dev,
> > +                     "init failed, struct page size mismatch %d\n",
> > +                     le16_to_cpu(pfn_sb->page_struct_size));
> > +             return -EOPNOTSUPP;
> > +     }
> > +
>
> We need this here?

Yes, both ->page_struct_size and ->page_size are only relevant in the
PFN_MODE_PMEM case because PFN_MODE_RAM assumes all pages are
allocated dynamically and the size does not matter.


>
> From 9885b2f9ed81a2438fc81507cfcdbdb1aeab756c Mon Sep 17 00:00:00 2001
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Date: Fri, 9 Aug 2019 22:10:08 +0530
> Subject: [PATCH] nvdimm: check struct page size only if pfn node is PMEM
>
> We should do the check only with PFN_MODE_PMEM. If we use
> memory for backing vmemmap, we should be able to enable
> the namespace even if struct page size change.

Same as the other patches please drop the usage of "we" in the changelog.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
