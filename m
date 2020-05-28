Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B411D1E525D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 May 2020 02:55:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF3A51229706A;
	Wed, 27 May 2020 17:51:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D175D12297069
	for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 17:51:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z5so30240000ejb.3
        for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NqIapQj4M62zo7NAMqZ1WXDa5DQy4R8lLb8tN0P9/I=;
        b=jmlC2uEYMJxp3Ndg2n4Jc8tAGoiLXU5guSTAKk2zwKIsGHoWBTL6aNKskDb3TjqNb4
         +X82xsb3nVPpHukjSUnQRVxPc4bHwDWc5FqOXfUjyBegtq1jdKYq+DsuVNwud0Ie408m
         MDddKH0gFgXP7t/lUWAiRVoyJJiknR45tz+zWPeyXekyWyaIrAPXh0TL5Pnn8ad70DxE
         nxV3xcaYSDRVDLPKctzIIvrO2QNG5kupe8ut/s3M8VagYAUMVFTjRh9U1VS1dsKelFqz
         RB8kGAjP5C2Q/zTXFBfqPw4IceNBH3x5KNcFQP9C4iLMtoyhdR2yxA485YXveKDDvp1L
         cOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NqIapQj4M62zo7NAMqZ1WXDa5DQy4R8lLb8tN0P9/I=;
        b=P/VFUbZ+m+w0/8rpJxl1U3iMLcCVqNjesKcpaZ/qOdibfV1F+qacgHP6nUZmpCKZRA
         /J5okiPmY7iqW9eoKGAcz1lf5GdAV6KILtg2rf4Hqh0wYzOXcVKxquyLY5YwxUTBdn3C
         seHsdlSXdWyCXWMk13AsUsisaQBrMREbJFqJLnfawbbVhS/+6CI4lSf/wa19AGD5343/
         BjY6dcNSibRFSBbY0Jn6xLf9MdIzFtU+5bHgj+DzwhfqHkgIQTZduEnvWOYs4MyPQJ2g
         uF6uJbiflnHieDNpgmgx8xcKh+gAWrrAuBiFvYYoog5CO3m/idRxZBmuyu/khjgrowzz
         DSHg==
X-Gm-Message-State: AOAM531j3ZCs+TekPoPPNHTGskKHRh0m89c2JO1bXsmmnfHaXopKbVKR
	0ctQdP6O8EVblBBED647gfcXGXxbHnRei4K2KyXKUQ==
X-Google-Smtp-Source: ABdhPJymJrNgUvg9FdZHtm1DONWdOyiN4v7MOZP9yHB8u9cpmKjtjqCd/4C8UZPeK/1+wkrxfL3N1id+Ip8wc+yn++0=
X-Received: by 2002:a17:906:3597:: with SMTP id o23mr860338ejb.174.1590627325824;
 Wed, 27 May 2020 17:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <87d06swfr4.fsf@linux.ibm.com> <CAPcyv4jQmQceE_eptnfnrORfAUnikHConhchYLEUPARYRFOcbA@mail.gmail.com>
In-Reply-To: <CAPcyv4jQmQceE_eptnfnrORfAUnikHConhchYLEUPARYRFOcbA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 May 2020 17:55:14 -0700
Message-ID: <CAPcyv4iTNK1ixzBRkm=09mHfrWzmd97HE4v-M2K5Uz0cKKT=3Q@mail.gmail.com>
Subject: Re: Feedback requested: Exposing NVDIMM performance statistics in a
 generic way
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: YRL4JJPCMGCENR6A65NRWWQZCWBKY3PI
X-Message-ID-Hash: YRL4JJPCMGCENR6A65NRWWQZCWBKY3PI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@d-silva.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YRL4JJPCMGCENR6A65NRWWQZCWBKY3PI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 27, 2020 at 12:24 PM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > This was done by adding two new dimm-ops callbacks that were
> > implemented by the papr_scm implementation within libndctl. These
> > callbacks are invoked by newly introduce code in 'util/json-smart.c'
> > that format the returned stats from these new dimm-ops and transform
> > them into a json-object to later presentation. I would request you to
> > look at RFC patch-set[2] to understand the implementation details.
>
> I'm ok to add some stats to ndctl, but I want ndctl to be limited to
> general statistics and not performance counters. Performance counters
> and performance events should be abstracted through perf where
> possible.

Another aspect that helps common statistics is to expose them in
sysfs. I'm going to go review your proposed ioctl mechanism, but I
would hope that is reserved for multi-field command payloads that need
to be sent as a unit rather than statistics retrieval that is amenable
to a sysfs interface.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
