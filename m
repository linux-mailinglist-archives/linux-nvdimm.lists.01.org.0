Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C3B12A929
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Dec 2019 22:18:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0D03A10097F1C;
	Wed, 25 Dec 2019 13:22:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B94C210097F1B
	for <linux-nvdimm@lists.01.org>; Wed, 25 Dec 2019 13:22:00 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id a15so30274287otf.1
        for <linux-nvdimm@lists.01.org>; Wed, 25 Dec 2019 13:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3I4l1wq+GDlyDOQ4w9t5h9FAXnYjZUZQhGALo6lXs8=;
        b=RVjVIiP7m8U3rYXj0igXxL9E6wNRHDbIKQW3LeTHYP/ixju0SxPEF+nBu4hQjvi0tR
         McxTXXpC7Atdkvb47+Gx1kcTTSco7NYF/B/qklJssxfzybw7E2OG3zOqnmqHSyL1VlwH
         QbDrvmLixfcKh/Qd8Ya//fklZMCZAc2fg50dz6tdQAMUfFpkVN6hJ3i43Er+PhDdeMqN
         FjtF2LEz4qWAFCWlyYoE5DdAXOMgqdJ0gPVKgSFNqJgDOxChPoFPDGu9W7W2klm1SyQ3
         c/Apj5IZVZzKCmYdHptCQNtPvxQq4xWBNDcLUuff84kNx9/c9wwwkYxgIac82k0wNtEn
         atGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3I4l1wq+GDlyDOQ4w9t5h9FAXnYjZUZQhGALo6lXs8=;
        b=cKis7/xvekoG3sjXjb+pxqNzPjOCELwwH9riIJ8NcePmIi3iKQ5PvDeJKDGGmVquOP
         zZ06T4/uAL3iYb0dIkkSkvAgHvXjAB1XmdUIOokq/DB6WSinQON2NaU+kJDjV8vJsTZX
         hnQRCaAUqHR3kv3uzEymHrft/6HrsO5GVsEJdTRghViZyMWmouF1+YGUk+l+UVKOcjqN
         lJYh5ShISboqvAdbdH/LuQrSODT8CTjqCuBCiJVDBm1I/nC1lLfTFC+jueB4tYuO3M8i
         6FiCGxEkxVvU07eRw2nBEMcmNjo5ffndsFy9hbpAUW1HrAcSrL/hcy7gX0nwilgvdfWB
         SmeQ==
X-Gm-Message-State: APjAAAWYPpUxzpTQOc4MbXbUmib9DQO3/7maIl4SnLU4eKTkudsTTOk8
	YJNoVwg1BjxK0+J899Ptp6OAwiDJWAMgrhJPC1SASA==
X-Google-Smtp-Source: APXvYqzrVJ7O+kQLwWo/fnYkDOiHzsh9tfp7dfpTqydvqjc9viUIbEds2v6e33QF4HeZAp03nDByukEan8/JHFBmaGk=
X-Received: by 2002:a05:6830:174c:: with SMTP id 12mr26886736otz.71.1577308719527;
 Wed, 25 Dec 2019 13:18:39 -0800 (PST)
MIME-Version: 1.0
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com> <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Dec 2019 13:18:28 -0800
Message-ID: <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: Q75V6KLRSFKAPZTOR3UL6O6PTTEU7EZG
X-Message-ID-Hash: Q75V6KLRSFKAPZTOR3UL6O6PTTEU7EZG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q75V6KLRSFKAPZTOR3UL6O6PTTEU7EZG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 25, 2019 at 2:33 AM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Hi Dan,
>
> I don't see any failure even apply my patch.
> What failure do you observe?

I see the failure in the daxctl-devices.sh unit test. That test and
others are included in the "destructive" set of unit tests. They are
classified "destructive" because they write to platform persistent
memory resources instead of the emulated nfit_test resources. You need
to pass "--enable-destructive" to the configure script at build time
to enable the destructive tests.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
