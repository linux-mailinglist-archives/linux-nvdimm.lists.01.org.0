Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C12887875E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jul 2019 10:28:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B76F1212E25B0;
	Mon, 29 Jul 2019 01:31:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=jencce.kernel@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EE7BD212AD5A0
 for <linux-nvdimm@lists.01.org>; Mon, 29 Jul 2019 01:31:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l21so27861712pgm.3
 for <linux-nvdimm@lists.01.org>; Mon, 29 Jul 2019 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0ExKlA3DZz4+IGDf5b2lRWN5RHKh8PsDvjZM7lEEtec=;
 b=kZcOX0mQOXYBNR505taQSrXmT63KZLkPEuV5WdrlswHv290JZRi+CkI+jzRpxKt5ba
 GxvPEg1CsRAdz1JmXdZ2yRT+rjjdq418uzfmRah/N+OG4mAP0SBsDswP4TpbS3jOX1c6
 kQAP4hrV3KM69zzm8QJQdM2cBz3GtOXYOpytYIB0NM9OqfbQDewytdiwdKZ0jJZiRCIJ
 0IkD2CRXEJqKzkoR7HwccYUwvq34YNlyUWYZtsLM/54AEmSu4jwI0qhgh6jqzMxu4wEV
 sgeuwIoGtiQZyEUOlS5TMVDVRhlKx/iy1uFSIDQcxexq8GCP9rI8DQpE82Eoy5ndoOV9
 j7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0ExKlA3DZz4+IGDf5b2lRWN5RHKh8PsDvjZM7lEEtec=;
 b=qdQzT8Aif/UBqTLvju6Qb73Mx+rtwyFb+7DxkiAN+HaMeqaq1fwGVWUmNxxOlrrGza
 CFnaZOOHEVB30Z3lMdR+8yQX7FRLLmCauXfgleLvzodZMg9kOQ1jG7eVnX6grVrUb3Gn
 O7YbGVDMIy2LjJSQXRPj1acbpgmxMtjr5uMpZTW5gk8lUzapNyt/PSPJ8ujkPgz9s+tv
 Wg+dI1OTf5eklRcY+SWOYKr1vZPwOpYRfNzWvxvNqkujulZ9w4pQhP9muhWxxSPU3EoM
 4Mzs8xM+uteonDQL6efneVeYaWMeX/pv/wCmjm1B1ePlYxc7v+WvZl5BF8mURJcsIpJy
 tseA==
X-Gm-Message-State: APjAAAXM9ANkwnnTR0/x2F9BWX7jAdkG06hP14TXUcNouDDSu8D/5+a5
 LQKzqHrX4Jz2Hg8IgwCwHE8=
X-Google-Smtp-Source: APXvYqzcCQ6uB5LeeFJTbNT6BeUA//64cSoWjGZktP6RSUF1t6Z5h+z+izLggQe1wrwVvbp/Vpftzw==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr35313470pfa.96.1564388929587; 
 Mon, 29 Jul 2019 01:28:49 -0700 (PDT)
Received: from localhost ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w14sm68644212pfn.47.2019.07.29.01.28.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 01:28:49 -0700 (PDT)
Date: Mon, 29 Jul 2019 16:28:41 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: xfs quota test xfs/050 fails with dax mount option and "-d
 su=2m,sw=1" mkfs option
Message-ID: <20190729082841.6uiroqyygnb3ngls@XZHOUW.usersys.redhat.com>
References: <20190724094317.4yjm4smk2z47cwmv@XZHOUW.usersys.redhat.com>
 <20190729001308.GX7689@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190729001308.GX7689@dread.disaster.area>
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
Cc: linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jul 29, 2019 at 10:13:08AM +1000, Dave Chinner wrote:
> On Wed, Jul 24, 2019 at 05:43:17PM +0800, Murphy Zhou wrote:
> > Hi,
> > 
> > As subject.
> > 
> > -d su=2m,sw=1     && -o dax  fail
> > -d su=2m,sw=1     && NO dax  pass
> > no su mkfs option && -o dax  pass
> > no su mkfs option && NO dax  pass
> > 
> > On latest Linus tree. Reproduce every time.
> > 
> > Testing on older kernels are going on to see if it's a regression.
> > 
> > Is this failure expected ?
> 
> I'm not sure it's actually a failure at all. DAX does not do delayed
> allocation, so if the write is aligned to sunit and at EOF it will
> round the allocation up to a full stripe unit. IOWs, for this test
> once the file size gets beyond sunit on DAX, writes will allocate in
> sunit chunks.
> 
> And, well, xfs/050 has checks in it for extent size hints, and
> notruns if:
> 
>         [ $extsize -ge 512000 ] && \
>                 _notrun "Extent size hint is too large ($extsize bytes)"
> 
> Because EDQUOT occurs when:
> 
> >     + URK 99: 2097152 is out of range! [3481600,4096000]
> 
> the file has less than 3.5MB or > 4MB allocated to it, and for a
> stripe unit of > 512k, EDQUOT will occur at  <3.5MB. That's what
> we are seeing here - a 2MB allocation at offset 2MB is > 4096000
> bytes, and so it gets EDQUOT at that point....
> 
> IOWs, this looks like a test problem, not a code failure...

Got it. Thanks Dave!

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
